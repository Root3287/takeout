#include "pch.hpp"

#include "CLI/CLI.hpp"
// time parallel --progress ./takeout -w {1} -t {2} -g {3} -c {4} -o {5} --batch ::: $(seq 0 5 60) ::: $(seq 0 5 300) ::: $(seq 0 10 1000) ::: $(seq 0 0.083 4) ::: $(seq 0 1 0.08334) >> ./data/takeout-cpp.csv


struct Options{
	float wage;
	float takeoutPrice;
	float groceryPrice;
	float cookingTime;
	float orderTime;
	bool batch = false;

	void print(){
		std::cout << "{" <<
			"wage: " << this->wage << ", " <<
			"takeoutPrice: " << this->takeoutPrice << ", " <<
			"groceryPrice: " << this->groceryPrice << ", " <<
			"cookingTime: " << this->cookingTime << ", " <<
			"orderTime: " << this->orderTime << ", " <<
			"batch: " << this->batch << "" <<
		"}" << std::endl;
	}

	std::string batchPrint(){
		std::stringstream str;
		str << 
			this->wage << ", " <<
			this->takeoutPrice << ", " <<
			this->groceryPrice << ", " <<
			this->cookingTime << ", " <<
			this->orderTime << ", ";
		return str.str();
	}
};

int main(int argc, char** argv){
	// std::cout <<  "Hello, World!" << std::endl;
	CLI::App app("A simple algorithm to determine if you sould takeout or cook", "takeout");
	argv = app.ensure_utf8(argv);

	Options options;
	app.add_option("-w,--wage", options.wage, "Wage")->required();
	app.add_option("-t,--takeout-price", options.takeoutPrice, "Takeout Price")->required();
	app.add_option("-g,--grocery-price", options.groceryPrice, "Grocery Price")->required();
	app.add_option("-c,--cooking-time", options.cookingTime, "Cooking Time")->required();
	app.add_option("-o,--order-time", options.orderTime, "Order Time")->required();
	app.add_flag("--batch", options.batch, "Use Batch Formatting");

	CLI11_PARSE(app, argc, argv);

	bool working = (options.wage > 0) ? true : false;
	if(
		working && 
		(options.takeoutPrice - options.groceryPrice) < ((options.cookingTime - options.orderTime) * options.wage)
	){
		if(options.batch){
			std::cout << options.batchPrint() << "Takeout" << std::endl;
		}else{
			std::cout << "Takeout" << std::endl;
		}
	}else{
		if(options.batch){
			std::cout << options.batchPrint() << "Cook" << std::endl;
		}else{
			std::cout << "Cook" << std::endl;
		}
	}


	return 0;
}