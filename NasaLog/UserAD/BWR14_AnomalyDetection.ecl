originalCenterPosition := $.Utils.GetOriginalVector($.Files.Centroids.ds);
OUTPUT(originalCenterPosition, NAMED('Final_Centroid_Position'));

abnormalStdVectors := $.Files.labeledVectors.ds(distance >= 1);
abnormalVectIDs := SET(abnormalStdVectors, userID);
abnormalUsers := $.Files.vectors.ds(userID IN abnormalVectIDs);
OUTPUT(COUNT(abnormalUsers), NAMED('Number_of_potential_abnormal_users'));
OUTPUT(abnormalUsers,, '~nasalog::userAD::abnormalUsers', THOR, COMPRESSED, OVERWRITE);