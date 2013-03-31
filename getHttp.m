#import <Foundation/Foundation.h>
@interface GetHttp : NSObject{
  NSString*   srcUrl;
}
- (void) write: (NSString* ) toprint;
- (NSString *) getDataFrom;
@end

@implementation GetHttp
- (void) write : (NSString* ) toprint{
    NSLog(toprint);
}

-(id) init {
    if (self = [super init])  {
      srcUrl = @"http://flavorplus.herokuapp.com/xml?query=date";
      //srcUrl = @"http://localhost:5000/xml?query=date"; 
    }
    return self;
}


- (NSString *) getDataFrom{
  // get request requring data from srcUrl
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:srcUrl]];
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;    

    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    if (oResponseData == nil) {
      NSLog(@"fail to connect");
    }

    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", srcUrl, [responseCode statusCode]);
        //return nil;
    }

    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding]; 
}
@end

int main(void) {
   NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
   GetHttp *doer = [[GetHttp alloc] init];
   NSString* result = [doer getDataFrom]
   NSLog(result);

  /******
    Insert some iphone code to show NSString result
    if the result == "oh yes"
    then we could say "oh yes"
  */

   [doer release];
   [pool drain];
   return 0;
}