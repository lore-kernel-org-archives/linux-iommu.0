Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CF13F44E
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486115; cv=none; b=G3SNdpv3puV1FenT5IjebJsDknxW27uBElwPy3OZyCEPVO5Y0rE4yEsPcHrJufyuUtTsTABdBGMOjFtnEAViexTU2VPa5BOqOJN5nn9kkJp6tJMojsaPj/24Iw6SO4sZVYqeVbaBIwjtIPD+hnpwfQsGCaxNVDz5h5EPnuXAUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486115; c=relaxed/simple;
	bh=JKpYS7bWzvoDqnPjWuBRzK/lOOn8Q5i8dEUQ2Udu0zQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdzG852M6owvrdTGl/Xuq5afRFM+IHq031+KHJQYx9jPf7Hx7vUbIOWtMTUEwXPJlxhQlceDuwp+rBDQhWtlqvnoMguj+GtQUgdO63vG7AKS8IXQBGGOrtbX798D5RtWBcbDwCOKBUELEBJ8UP0t0WcGpjavTQwNOXUAn0Nwz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jkn6etzI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jkn6etzI"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7u6Nt029279;
	Thu, 27 Jun 2024 11:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=n
	G7QYi69wpkU3kCziGJuOaHlXg/hsy/pTMk/7Jvtec8=; b=Jkn6etzIgKAEX+ovZ
	1noa21+Qoed49ea79gorPKQSAenyixHi9W9EhzhGjCXDJgKwhDWbKjtv5iEZVug0
	If9bTFyTmzrIN9ud7+ULigGoq/1TeyXFJV0GLwTJJKGpmx4Jgitd35yL059FDui7
	cDlYsT7B4mr++JZ0gA3H0uFLkqBnwQxbzLJaGNEAsuW+Fz4ZAoKY0mg0HJ4KYFcr
	ShPDQ2tZl/7Zu2tPP/X+WTduag+RHiWqWrIeshv5jMYhPqk+/JzCKYAIdReBsKHA
	znt63DfjGIhOvtpdJcZ5dA/uUOR0c+YzeEVwSt/j6RygpxhJipna/9PSCZoSLrvf
	Bs/Ow==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 400ttn9bn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R9tBkU023394;
	Thu, 27 Jun 2024 11:01:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grvne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:44 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KNL025281;
	Thu, 27 Jun 2024 11:01:44 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-11;
	Thu, 27 Jun 2024 11:01:44 +0000
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
Subject: [PATCH v2 10/11] iommufd/iova_bitmap: Dynamic pinning on iova_bitmap_set()
Date: Thu, 27 Jun 2024 12:01:04 +0100
Message-Id: <20240627110105.62325-11-joao.m.martins@oracle.com>
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
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-GUID: sB_ZKPNFU1X2Q95ltlp-uZ464WA8X6N4
X-Proofpoint-ORIG-GUID: sB_ZKPNFU1X2Q95ltlp-uZ464WA8X6N4

Today zerocopy iova bitmaps use a static iteration scheme where it walks
the bitmap data in a max iteration size of 2M of bitmap of data at a time.
That translates to a fixed window of IOVA space that can span up to 64G
(e.g.  base pages, x86). Here 'window' refers to the IOVA space represented
by the bitmap data it is iterating. This static scheme is the ideal one
where the reported page-size is the same as the one behind the dirty
tracker.

However, problems start to appear when the dirty tracker may
dirty in many PTE sizes beyond or unaligned at the boundaries of the
iteration window. Such is the case for the IOMMU and
commit 2780025e01e2 ("iommufd/iova_bitmap: Handle recording beyond the mapped pages")
tried to fix the problem by handling the PTEs that get dirty which
surprass the end of the iteration. But the fix was incomplete and it
didn't handle all the data structure issues namely:

1) when there's nothing to dirty but the end of the iteration IOVA range is
a IOMMU hugepage PTE that crosses iterations, when it goes to the next
iteration it finds the other end of the said hugepage but don't account that
it had checked for that IOPTE already. iommu driver then walk the IOVA
space as if it is a new page without accounting that it is past the start
of a bigger page which ends up setting (future) dirty bits slightly
offset-ed. Note that the partial ranges here are self induced
due as a result of the fixed 'window' scheme being unaligned to this
hugepage IOPTE.

2) on the same line of thinking between pinning pages of different
iterations it could allow DMA to mark PTEs as dirty on the second part of
this previously mentioned partial hugepage. This leads to marking part of
the hugepage as dirty but still clearing IOPTE leading to missed dirty
data.

So to fix these problems more fundamentally and avoid future ones: instead
of iterating the whole bitmap in fixed chunks, instead only pin the bitmap
pages when it has dirty bits to set. The logic is simple in
iova_bitmap_set(): check where the current iova range to be marked as dirty
is pinned and pin the bitmap pages where to-be-recorded @iova starts if
it's not. If it's partially mapped out of the whole set, continue pinning
it and set bits until the whole dirty-size is covered. The latter is more
relevant with AMD iommu pgtable v1 format where you can have up
64G/128G/256G page sizes and thus you can set 64G at a time. Code also gets
simpler and easier to follow.

Fixing this without changing this iteration scheme means changing iommu
drivers to ignore any partial pages and not clear dirty bits, which is a
bit hacky. Though getting to walk only part of a IOMMU hugepage is a
self-induced due to this iteration scheme as it doesn't (and can't) align the
iteration boundary to the huge IOPTE at the end. Thus it can't know what
the hugepage size the iteration should align to until it walks the begin/end.

Dynamically pinning adds some comparisons inside iova_bitmap_set() to check
if something needs to be pinned if the IOVA range is out of range. Though
it has the benefit that non-dirty IOVA ranges only walk page tables without
needing to pin any bitmap pages. This dynamic scheme should be better for IOMMUs
where upper layers don't need or know what PTE sizes IOVAs map into (and there
could be more than one PTE size[*]) until they walk the IOMMU page tables.

A follow-up change will remove the iteration logic.

[*] Specially on AMD v1 iommu pgtable format where most powers of two are
supported as page-size.

Link: https://lore.kernel.org/linux-iommu/6b90f949-48da-4cb3-ad9a-ed54f1351a9a@oracle.com/
Fixes: 2780025e01e2 ("iommufd/iova_bitmap: Handle recording beyond the mapped pages")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 73 ++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index be97bb464f6b..b047e1e180be 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -119,6 +119,9 @@ struct iova_bitmap {
 
 	/* length of the IOVA range set ahead the pinned pages */
 	unsigned long set_ahead_length;
+
+	/* true if it using the iterator otherwise it pins dynamically */
+	bool iterator;
 };
 
 /*
@@ -340,6 +343,17 @@ static unsigned long iova_bitmap_mapped_length(struct iova_bitmap *bitmap)
 	return remaining;
 }
 
+/*
+ * Returns true if [@iova..@iova+@length-1] is part of the mapped IOVA range.
+ */
+static bool iova_bitmap_mapped_range(struct iova_bitmap_map *mapped,
+				     unsigned long iova, size_t length)
+{
+	return mapped->npages &&
+		(iova >= mapped->iova &&
+		 (iova + length - 1) <= (mapped->iova + mapped->length - 1));
+}
+
 /*
  * Returns true if there's not more data to iterate.
  */
@@ -374,6 +388,27 @@ static int iova_bitmap_set_ahead(struct iova_bitmap *bitmap,
 	return ret;
 }
 
+/*
+ * Advances to a selected range, releases the current pinned
+ * pages and pins the next set of bitmap pages.
+ * Returns 0 on success or otherwise errno.
+ */
+static int iova_bitmap_advance_to(struct iova_bitmap *bitmap,
+				  unsigned long iova)
+{
+	unsigned long index;
+
+	index = iova_bitmap_offset_to_index(bitmap, iova - bitmap->iova);
+	if (index >= bitmap->mapped_total_index)
+		return -EINVAL;
+	bitmap->mapped_base_index = index;
+
+	iova_bitmap_put(bitmap);
+
+	/* Pin the next set of bitmap pages */
+	return iova_bitmap_get(bitmap);
+}
+
 /*
  * Advances to the next range, releases the current pinned
  * pages and pins the next set of bitmap pages.
@@ -426,6 +461,7 @@ int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 	if (ret)
 		return ret;
 
+	bitmap->iterator = true;
 	for (; !iova_bitmap_done(bitmap) && !ret;
 	     ret = iova_bitmap_advance(bitmap)) {
 		ret = fn(bitmap, iova_bitmap_mapped_iova(bitmap),
@@ -433,6 +469,7 @@ int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 		if (ret)
 			break;
 	}
+	bitmap->iterator = false;
 
 	return ret;
 }
@@ -452,11 +489,28 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 		     unsigned long iova, size_t length)
 {
 	struct iova_bitmap_map *mapped = &bitmap->mapped;
-	unsigned long cur_bit = ((iova - mapped->iova) >>
-			mapped->pgshift) + mapped->pgoff * BITS_PER_BYTE;
-	unsigned long last_bit = (((iova + length - 1) - mapped->iova) >>
-			mapped->pgshift) + mapped->pgoff * BITS_PER_BYTE;
-	unsigned long last_page_idx = mapped->npages - 1;
+	unsigned long cur_bit, last_bit, last_page_idx;
+
+update_indexes:
+	if (unlikely(!bitmap->iterator &&
+		     !iova_bitmap_mapped_range(mapped, iova, length))) {
+
+		/*
+		 * The attempt to advance the base index to @iova
+		 * may fail if it's out of bounds, or pinning the pages
+		 * returns an error.
+		 *
+		 * It is a no-op if within a iova_bitmap_for_each() closure.
+		 */
+		if (iova_bitmap_advance_to(bitmap, iova))
+			return;
+	}
+
+	last_page_idx = mapped->npages - 1;
+	cur_bit = ((iova - mapped->iova) >>
+		mapped->pgshift) + mapped->pgoff * BITS_PER_BYTE;
+	last_bit = (((iova + length - 1) - mapped->iova) >>
+		mapped->pgshift) + mapped->pgoff * BITS_PER_BYTE;
 
 	do {
 		unsigned int page_idx = cur_bit / BITS_PER_PAGE;
@@ -469,8 +523,13 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 			unsigned long left =
 				((last_bit - cur_bit + 1) << mapped->pgshift);
 
-			bitmap->set_ahead_length = left;
-			break;
+			if (bitmap->iterator) {
+				bitmap->set_ahead_length = left;
+				return;
+			}
+			iova += (length - left);
+			length = left;
+			goto update_indexes;
 		}
 
 		kaddr = kmap_local_page(mapped->pages[page_idx]);
-- 
2.17.2

