# Point cloud segmentation - find obstacles

1. Load workspace mesh (stl file)
2. Remove everything outside region of interest
3. Remove table by fitting plane
4. Cluster remaining points based on distance between clusters
5. Fit bounding spheres to clusters