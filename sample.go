package main

import (
	"fmt"
	"log"
	"math/rand"
	"time"

	"github.com/fatih/color"
)

func main() {
	now := time.Now().UTC()
	colorFormatters := [5]*color.Color{
		color.New(color.FgBlack).Add(color.BgRed),
		color.New(color.FgBlack).Add(color.BgCyan),
		color.New(color.FgBlack).Add(color.BgYellow),
		color.New(color.FgBlack).Add(color.BgHiMagenta),
		color.New(color.FgBlack).Add(color.BgWhite),
	}

	s1 := rand.NewSource(time.Now().UnixNano())
	r1 := rand.New(s1)
	c := colorFormatters[r1.Intn(5)]

	for 1 < 2 {
		c.Printf("\n\n")
		c.Printf("  Hiii from Golang, main was called on: %s  ", now)
		c.Printf("\n")

		fmt.Printf("\n\n")
		time.Sleep(3 * time.Second)

		if r1.Intn(5) > 2 {
			log.Fatal("Woops.")
		}
	}
}
