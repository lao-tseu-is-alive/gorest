package main

import (
	"github.com/gin-gonic/gin"
	"math/rand"
	"runtime"
	//"database/sql"
	"fmt"
	"log"
	"strconv"
	//"sort"
	"github.com/jackc/pgx"
	"github.com/lao-tseu-is-alive/gorest/fasthttp/common"
)

const (
	adr = "localhost:8080"
)

var (
	// Database
	worldStatement   *pgx.PreparedStatement
	fortuneStatement *pgx.PreparedStatement
	updateStatement  *pgx.PreparedStatement
	db               *pgx.ConnPool
)

const (
	worldSelect        = "SELECT id, randomNumber FROM World WHERE id = ?"
	worldUpdate        = "UPDATE World SET randomNumber = ? WHERE id = ?"
	fortuneSelect      = "SELECT id, message FROM Fortune;"
	worldRowCount      = 10000
	maxConnectionCount = 256
)

type World struct {
	Id           int32 `json:"id"`
	RandomNumber int32 `json:"randomNumber"`
}

type Fortune struct {
	Id      uint16 `json:"id"`
	Message string `json:"message"`
}

type Fortunes []*Fortune

func (s Fortunes) Len() int      { return len(s) }
func (s Fortunes) Swap(i, j int) { s[i], s[j] = s[j], s[i] }

type ByMessage struct{ Fortunes }

func (s ByMessage) Less(i, j int) bool { return s.Fortunes[i].Message < s.Fortunes[j].Message }

func main() {
	gin.SetMode(gin.ReleaseMode)

	var err error
	maxConnectionCount := runtime.NumCPU() * 4
	if db, err = initDatabase("localhost", 5432,
		"benchmarkdbuser",
		"benchmarkdbpass",
		"benchmark", maxConnectionCount); err != nil {
		log.Fatalf("Error opening database: %s", err)
	}

	r := gin.New()
	serverHeader := []string{"Gin"}
	r.Use(func(c *gin.Context) {
		c.Writer.Header()["Server"] = serverHeader
	})
	r.LoadHTMLFiles("fortune.html")
	r.GET("/json", json)
	r.GET("/plaintext", plaintext)
	r.GET("/db", dbHandler)
	r.GET("/dbs", dbs)
	//r.GET("/fortunes", fortunes)
	//r.GET("/update", update)
	r.Run(adr)
}

func parseQueries(c *gin.Context) int {
	n, err := strconv.Atoi(c.Request.URL.Query().Get("queries"))
	if err != nil {
		n = 1
	} else if n < 1 {
		n = 1
	} else if n > 500 {
		n = 500
	}
	return n
}

/// Test 1: JSON serialization
func json(c *gin.Context) {
	c.JSON(200, gin.H{"message": "Hello, World!"})
}

/// Test 2: Single database query

func dbHandler(c *gin.Context) {
	var world World
	n := rand.Intn(worldRowCount) + 1
	err := db.QueryRow("worldSelectStmt", n).Scan(&world.Id, &world.RandomNumber)
	if err != nil {
		log.Fatalf("Error scanning world row: %s", err)
		c.AbortWithError(500, err)
		return
	}

	c.JSON(200, &world)
}

/// Test 3: Multiple database queries
func dbs(c *gin.Context) {
	numQueries := parseQueries(c)

	worlds := make([]World, numQueries)
	for i := 0; i < numQueries; i++ {
		n := rand.Intn(worldRowCount) + 1
		err := db.QueryRow("worldSelectStmt", n).Scan(&worlds[i].Id, &worlds[i].RandomNumber)
		if err != nil {
			log.Fatalf("Error scanning world row: %s", err)
			c.AbortWithError(500, err)
			return
		}
	}
	c.JSON(200, &worlds)
}

/*
/// Test 4: Fortunes
func fortunes(c *gin.Context) {
	rows, err := fortuneStatement.Query()
	if err != nil {
		c.AbortWithError(500, err)
		return
	}

	fortunes := make(Fortunes, 0, 16)
	for rows.Next() { //Fetch rows
		fortune := Fortune{}
		if err := rows.Scan(&fortune.Id, &fortune.Message); err != nil {
			c.AbortWithError(500, err)
			return
		}
		fortunes = append(fortunes, &fortune)
	}
	fortunes = append(fortunes, &Fortune{Message: "Additional fortune added at request time."})

	sort.Sort(ByMessage{fortunes})
	c.HTML(200, "fortune.html", fortunes)
}

/// Test 5: Database updates
func update(c *gin.Context) {
	numQueries := parseQueries(c)
	world := make([]World, numQueries)
	for i := 0; i < numQueries; i++ {
		if err := worldStatement.QueryRow(rand.Intn(worldRowCount)+1).Scan(&world[i].Id, &world[i].RandomNumber); err != nil {
			c.AbortWithError(500, err)
			return
		}
		world[i].RandomNumber = int32(rand.Intn(worldRowCount) + 1)
		if _, err := updateStatement.Exec(world[i].RandomNumber, world[i].Id); err != nil {
			c.AbortWithError(500, err)
			return
		}
	}
	c.JSON(200, world)
}
*/

/// Test 6: plaintext
func plaintext(c *gin.Context) {
	c.String(200, "Hello, World!")
}

/*
func init() {
	runtime.GOMAXPROCS(runtime.NumCPU())

	dsn := "benchmarkdbuser:benchmarkdbpass@tcp(%s:3306)/benchmark"
	dbhost := "localhost"

	db, err := sql.Open("mysql", fmt.Sprintf(dsn, dbhost))
	if err != nil {
		log.Fatalf("Error opening database: %v", err)
	}
	db.SetMaxIdleConns(maxConnectionCount)
	worldStatement, err = db.Prepare(worldSelect)
	if err != nil {
		log.Fatal(err)
	}
	fortuneStatement, err = db.Prepare(fortuneSelect)
	if err != nil {
		log.Fatal(err)
	}
	updateStatement, err = db.Prepare(worldUpdate)
	if err != nil {
		log.Fatal(err)
	}
}
*/

func mustPrepare(db *pgx.Conn, name, query string) *pgx.PreparedStatement {
	stmt, err := db.Prepare(name, query)
	if err != nil {
		log.Fatalf("Error when preparing statement %q: %s", query, err)
	}
	return stmt
}

func initDatabase(dbHost string, dbPort uint16,
	dbUser string, dbPass string,
	dbName string, maxConnectionsInPool int) (*pgx.ConnPool, error) {

	var successOrFailure string = "OK"

	var config pgx.ConnPoolConfig

	config.Host = dbHost
	config.User = dbUser
	config.Password = dbPass
	config.Database = dbName
	config.Port = dbPort

	config.MaxConnections = maxConnectionsInPool

	config.AfterConnect = func(conn *pgx.Conn) error {
		worldStatement = mustPrepare(conn, "worldSelectStmt", "SELECT id, randomNumber FROM World WHERE id = $1")
		updateStatement = mustPrepare(conn, "worldUpdateStmt", "UPDATE World SET randomNumber = $1 WHERE id = $2")
		fortuneStatement = mustPrepare(conn, "fortuneSelectStmt", "SELECT id, message FROM Fortune")
		return nil
	}

	fmt.Println("--------------------------------------------------------------------------------------------")

	connPool, err := pgx.NewConnPool(config)
	if err != nil {
		successOrFailure = "FAILED"
		log.Println("Connecting to database ", dbName, " as user ", dbUser, " ", successOrFailure, ": \n ", err)
	} else {
		log.Println("Connecting to database ", dbName, " as user ", dbUser, ": ", successOrFailure)

		log.Println("Fetching one record to test if db connection is valid...")
		var w common.World
		n := common.RandomWorldNum()
		if errPing := connPool.QueryRow("worldSelectStmt", n).Scan(&w.Id, &w.RandomNumber); errPing != nil {
			log.Fatalf("Error scanning world row: %s", errPing)
		}
		log.Println("OK")
	}

	fmt.Println("--------------------------------------------------------------------------------------------")

	return connPool, err
}
