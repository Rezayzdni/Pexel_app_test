import 'package:hindi_2/main.dart';
import 'package:hindi_2/ui/counterState.dart';

CounterState reducers(CounterState counterState , action){
  if(action == Action.Inc){
    return CounterState(counterState.counter+1);
  }
  else if(action == Action.Double){
    return CounterState(2*counterState.counter);
  }
  else if(action == Action.Product_5){
    return CounterState(5*counterState.counter);
  }
  else if(action == Action.Dec){
    return CounterState(counterState.counter-1);
  }
  else if (action == Action.Double && action == Action.Dec){
    return CounterState(counterState.counter-19);
  }


  return counterState;
}