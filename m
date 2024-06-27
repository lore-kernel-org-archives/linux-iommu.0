Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F813E8B9
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486120; cv=none; b=uWgVL68BKYMdOsYSkrHS/lPMNlXsluZuenCQh9igCbi0ABcCGyN4jNebyib0sb0Ov/y8OCbrRwM2dlxbu8GFXET65P6yJxT/irV6stsvd//cnAQZQfgNBWA9PItrY6o9bWTq81hPtZI78K2rNs3DP//PCWNo+lDSV+UMSgQweVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486120; c=relaxed/simple;
	bh=wJh+wusJiT3/ii8SsLWTsfN4rUKNkQ7RosDlnr7fkY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ViPEq8yxSq5kJ0lhCFL/hBAfnjD2Oh5FCgcutBC5P8qXmmkrnpTw4/GzqWH+P+K1ylNvoncOZ+vG/EAZRdWfcztz7l4e8YfzlJDoj2qiQjgGerSfiO78v5jbzG7jycKm5+kVxSMYNkNeV8lqdJoG5JuxDJJJAJRXHLZeP3Lfy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JiH0liM+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JiH0liM+"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tXE0012045;
	Thu, 27 Jun 2024 11:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=/
	5Y0a91Hs94rZZiEZLHWALJMEUmXre2WgYLrdwF90jg=; b=JiH0liM+mnb06ysrw
	hH23HYPF+PthUHIKtANNe9/6q6CqaatDeD/0GlMMFBr8ViwGP4IxVA1/gnEzg6yO
	VJXcg5e/wztGevh35XK/c1VRDAk3hyAjr+jtGvEpi/8yJT5hnP5KJhMNJSAfOhA9
	0kMcDjR3023H/1v/2AaIyNM9fO1RlF4jKRZWyYy+F5M9oiULca8LbFD3a2kWzDAR
	pYYqEpmDbdDNPkVxGy3y+ODM0eusoE8KzXS8sM1EEDrVxhEOKMdoQ42OsmvSiq5I
	Lmr2hWfqRYeXLETfbveW+7xcsKsjG6kK+RcEa8i4V1ABC2qUKLqIr22fcthFyzmY
	dFQJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d5gtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RAK3kl023445;
	Thu, 27 Jun 2024 11:01:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grvq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KNN025281;
	Thu, 27 Jun 2024 11:01:46 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-12;
	Thu, 27 Jun 2024 11:01:46 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Matt Ochs <mochs@nvidia.com>
Subject: [PATCH v2 11/11] iommufd/iova_bitmap: Remove iterator logic
Date: Thu, 27 Jun 2024 12:01:05 +0100
Message-Id: <20240627110105.62325-12-joao.m.martins@oracle.com>
In-Reply-To: <20240627110105.62325-1-joao.m.martins@oracle.com>
References: <20240627110105.62325-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-27_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=959
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-GUID: 5jm4IQqiQSDL3XzT3OtrVusBrJS_z2lW
X-Proofpoint-ORIG-GUID: 5jm4IQqiQSDL3XzT3OtrVusBrJS_z2lW

The newly introduced dynamic pinning/windowing greatly simplifies the code
and there's no obvious performance advantage that has been identified that
justifies maintinaing both schemes.

Remove the iterator logic and have iova_bitmap_for_each() just invoke the
callback with the total iova/length.

Fixes: 2780025e01e2 ("iommufd/iova_bitmap: Handle recording beyond the mapped pages")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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

