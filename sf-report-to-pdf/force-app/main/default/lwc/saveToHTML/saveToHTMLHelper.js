function retrieveFromURI(baseURI) {
    const address = baseURI.split("/");
    for (let i = 0; i < address.length; i++) {
        if (address[i] === "r" && address[i + 1] === "Report") {
            return address[i + 2];
        } 
    }
    return null;
}

export {retrieveFromURI};
