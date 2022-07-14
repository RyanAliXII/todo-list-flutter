

runIfMounted (bool b, Function fn){
    if(!b) return;
    fn();
}
