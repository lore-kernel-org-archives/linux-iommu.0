Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05317B41A
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995440; cv=none; b=Z1xH9KpDufcIcCx5krBRk4iEJjk7J7RK1L3b0Rztjngpbpq8MH+VkK/44JyRYSrav8BM1FIY4QL0dO8Ay4V+YPffqdGrfm+0pY8x6yIo/xEVtHr69omTm6HbhT+Xrgy0YZzeBI5gtvt/ztbmB2lGFQSQOOSQE5ee0pqlD0gsNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995440; c=relaxed/simple;
	bh=7OPmWu4rHG0cvQ7aShH6AWbMD1dP9Y2qmn9w3pPGl3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BGQ+uabV+7Kp+CKd8AgHl3u8Z8EveZNpX+zzBY4PqWUnVL/gzTeQG5zuH+tJBgFC9lcKTKnJdpQPt7t6tCaDHfO49DZM93jbk6Eb4/q/lnDn0TU7Q7SO3wkNH+YZGwNtKMYzHM8UaN7Z1C08XWQd7Fv2NdjhR3FKfJW5NesgFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cSJGfh3I; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cSJGfh3I"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXcDV026243;
	Fri, 21 Jun 2024 18:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=P
	U2K+XWVa8NFo2nj5XuG/3XvG8VPopWMaJCFbaC0Zfc=; b=cSJGfh3I/WeoOR9LL
	OFpKZ5RUTpskijR0jdLuY7XuT2lWGMcpiQqwPsp5btSIRgOnFhy5Dzgg37tOqaT4
	txIkNQASukPixFNk/YrFFU2qGVJbUgwgXlLkC70+YNMvJJJX04EHoSaizVx2sBDV
	kV2pc7isNYGarn54K2YAfi+dT9Y35M9EsmRQNnAPKVyApCL2yRbR3BwzNN0J3Nv1
	dtpzGO+o2A37KEfb0KCf3QmD/ZzApOXcmt188nVjNfL+sqrAGTVNzpZ7zFxCDxNW
	hWQz+eXiKE4s9ZSejyegJB/V/jm6fFaEDHed8sn1NeahFVxacfokolvhtHFrwf96
	X42hQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkftc1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LH6owU040028;
	Fri, 21 Jun 2024 18:43:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4ppb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45LIhFXM032040;
	Fri, 21 Jun 2024 18:43:44 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-63-48.vpn.oracle.com [10.175.63.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yvrn4pnuj-11;
	Fri, 21 Jun 2024 18:43:44 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 10/10] iommufd/iova_bitmap: Remove iterator logic
Date: Fri, 21 Jun 2024 19:42:54 +0100
Message-Id: <20240621184254.45477-11-joao.m.martins@oracle.com>
In-Reply-To: <20240621184254.45477-1-joao.m.martins@oracle.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_10,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=945 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210136
X-Proofpoint-GUID: EZlBeDvyHOy_nSbHwSB0AsyxkhdY3Xd2
X-Proofpoint-ORIG-GUID: EZlBeDvyHOy_nSbHwSB0AsyxkhdY3Xd2

The newly introduced dynamic pinning/windowing greatly simplifies the code
and there's no obvious performance advantage that has been identified that
justifies maintinaing both schemes.

Remove the iterator logic and have iova_bitmap_for_each() just invoke the
callback with the total iova/length.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 97 +----------------------------
 1 file changed, 2 insertions(+), 95 deletions(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index b047e1e180be..b9e964b1ad5c 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -116,12 +116,6 @@ struct iova_bitmap {
 
 	/* length of the IOVA range for the whole bitmap */
 	size_t length;
-
-	/* length of the IOVA range set ahead the pinned pages */
-	unsigned long set_ahead_length;
-
-	/* true if it using the iterator otherwise it pins dynamically */
-	bool iterator;
 };
 
 /*
@@ -354,40 +348,6 @@ static bool iova_bitmap_mapped_range(struct iova_bitmap_map *mapped,
 		 (iova + length - 1) <= (mapped->iova + mapped->length - 1));
 }
 
-/*
- * Returns true if there's not more data to iterate.
- */
-static bool iova_bitmap_done(struct iova_bitmap *bitmap)
-{
-	return bitmap->mapped_base_index >= bitmap->mapped_total_index;
-}
-
-static int iova_bitmap_set_ahead(struct iova_bitmap *bitmap,
-				 size_t set_ahead_length)
-{
-	int ret = 0;
-
-	while (set_ahead_length > 0 && !iova_bitmap_done(bitmap)) {
-		unsigned long length = iova_bitmap_mapped_length(bitmap);
-		unsigned long iova = iova_bitmap_mapped_iova(bitmap);
-
-		ret = iova_bitmap_get(bitmap);
-		if (ret)
-			break;
-
-		length = min(length, set_ahead_length);
-		iova_bitmap_set(bitmap, iova, length);
-
-		set_ahead_length -= length;
-		bitmap->mapped_base_index +=
-			iova_bitmap_offset_to_index(bitmap, length - 1) + 1;
-		iova_bitmap_put(bitmap);
-	}
-
-	bitmap->set_ahead_length = 0;
-	return ret;
-}
-
 /*
  * Advances to a selected range, releases the current pinned
  * pages and pins the next set of bitmap pages.
@@ -409,36 +369,6 @@ static int iova_bitmap_advance_to(struct iova_bitmap *bitmap,
 	return iova_bitmap_get(bitmap);
 }
 
-/*
- * Advances to the next range, releases the current pinned
- * pages and pins the next set of bitmap pages.
- * Returns 0 on success or otherwise errno.
- */
-static int iova_bitmap_advance(struct iova_bitmap *bitmap)
-{
-	unsigned long iova = iova_bitmap_mapped_length(bitmap) - 1;
-	unsigned long count = iova_bitmap_offset_to_index(bitmap, iova) + 1;
-
-	bitmap->mapped_base_index += count;
-
-	iova_bitmap_put(bitmap);
-
-	/* Iterate, set and skip any bits requested for next iteration */
-	if (bitmap->set_ahead_length) {
-		int ret;
-
-		ret = iova_bitmap_set_ahead(bitmap, bitmap->set_ahead_length);
-		if (ret)
-			return ret;
-	}
-
-	if (iova_bitmap_done(bitmap))
-		return 0;
-
-	/* When advancing the index we pin the next set of bitmap pages */
-	return iova_bitmap_get(bitmap);
-}
-
 /**
  * iova_bitmap_for_each() - Iterates over the bitmap
  * @bitmap: IOVA bitmap to iterate
@@ -455,23 +385,7 @@ static int iova_bitmap_advance(struct iova_bitmap *bitmap)
 int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 			 iova_bitmap_fn_t fn)
 {
-	int ret = 0;
-
-	ret = iova_bitmap_get(bitmap);
-	if (ret)
-		return ret;
-
-	bitmap->iterator = true;
-	for (; !iova_bitmap_done(bitmap) && !ret;
-	     ret = iova_bitmap_advance(bitmap)) {
-		ret = fn(bitmap, iova_bitmap_mapped_iova(bitmap),
-			 iova_bitmap_mapped_length(bitmap), opaque);
-		if (ret)
-			break;
-	}
-	bitmap->iterator = false;
-
-	return ret;
+	return fn(bitmap, bitmap->iova, bitmap->length, opaque);
 }
 EXPORT_SYMBOL_NS_GPL(iova_bitmap_for_each, IOMMUFD);
 
@@ -492,15 +406,12 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 	unsigned long cur_bit, last_bit, last_page_idx;
 
 update_indexes:
-	if (unlikely(!bitmap->iterator &&
-		     !iova_bitmap_mapped_range(mapped, iova, length))) {
+	if (unlikely(!iova_bitmap_mapped_range(mapped, iova, length))) {
 
 		/*
 		 * The attempt to advance the base index to @iova
 		 * may fail if it's out of bounds, or pinning the pages
 		 * returns an error.
-		 *
-		 * It is a no-op if within a iova_bitmap_for_each() closure.
 		 */
 		if (iova_bitmap_advance_to(bitmap, iova))
 			return;
@@ -523,10 +434,6 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 			unsigned long left =
 				((last_bit - cur_bit + 1) << mapped->pgshift);
 
-			if (bitmap->iterator) {
-				bitmap->set_ahead_length = left;
-				return;
-			}
 			iova += (length - left);
 			length = left;
 			goto update_indexes;
-- 
2.17.2

