#  Notes

### Alternative solutions:
Instead of creating separate views for Headlines / paragraphs, it is possible to create view modifiers for Text


### Things deliberately omitted: 
- logging
- fine-grained error handling from Network Service
- using system font instead of proposed Inter
- localization - majority of texts are coming from the API
- thread-safety for SwiftData (using ModelActor)
- error state in Character details (in general, Figma is missing error, loading and emtpy states)


### Inconsistencies (in Figma)

Card (character row) background color has different values in light / dark mode
Card (character row) title color - same

Character details card background is not consistent

Search bar: search icon has different colors



### Packages used
CachedAsyncImage - better for refreshing view after db change than native AsyncImage
SwiftUI-introspect - to fine-tune appearance of default searchbar (alternatively, it would be possible to implement custom search bar and place it in Section header in the list)


