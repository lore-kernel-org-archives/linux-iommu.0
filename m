Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D117CA19
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319168; cv=none; b=nlS6C/aTbc1zzlXTvnG2I/T3UeYkiai9i91ObMsjx+vgeU5j3BF5KLQyV7bFywYkpOx1Ai7yqxWaDV2WJMz7TfWy8HsbPS9tTgOGVk8D17ZfjXjsXZes3hAT6Qutaz5wL5HkNqhESi3UYXYjH8kIBjF+79W5BOKKq3WIrNqmTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319168; c=relaxed/simple;
	bh=J3NnKP5hHZzEQvU9/F38RV2nDCNjifu4p4iHXctHj1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FPy8bL+XNoLBpPZSQ5umtquTOOp3MApq1/myHDVNW5u616e09sYG7NAkCZyZWhN/19I6IZ9v5jirGl4ywqckg6sZtT9jpk6daCs2YBvGEvVDUQ3yg+iwqsehThh+RMBN240mDd9s3K7EUbA6jB0DF5PwR03u1c+m5PWK7zOcc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VuF90XrS; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VuF90XrS"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EBcnw7019867;
	Sat, 14 Sep 2024 13:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=a10dlfib2gz+reuvvPpkx9PYJWgfjKfL2cOLrJqNTcc=; b=
	VuF90XrStbqAOlMypxfXZHrBc/gz1gZoX4w7PnhZW8q6Z8lf0ha4f6izU7XEy0YX
	UEE70PEtO6FRzZtplBXmWiR35C5CR9NmzvHzXtjEd0KGCSDRvvjIwv2efjhvhPQL
	oUQuHEZjE9sClMTsGU1mb9aeY3Ku2AtNgOoDv4y8KYdhyo64pqELoMm3JTpennJ2
	8kt4trj0BgIHNquaozOuMgP/5mz6xUE/seMG5zlxDKGu0I4DMKosR2ujD5jU+WQg
	SymJpqUlW8IuAcryiDMDdGx03Kd1NUu5X9ZSeiPJ/LBCZ7JQZktSgWdnNKhrqjnK
	hKW+yUNpMbs0XGnsrRHxkQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfge50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48E9NQNm019195;
	Sat, 14 Sep 2024 13:06:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6a1tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:02 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48ED60jH024307;
	Sat, 14 Sep 2024 13:06:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41n0x6a1su-3;
	Sat, 14 Sep 2024 13:06:01 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 2/9] iommufd: remove uptr from iopt_alloc_iova
Date: Sat, 14 Sep 2024 06:05:51 -0700
Message-Id: <1726319158-283074-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-14_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409140092
X-Proofpoint-GUID: WSeyJY0XzewmdCwfhF1ZEsXJD0g-YlPm
X-Proofpoint-ORIG-GUID: WSeyJY0XzewmdCwfhF1ZEsXJD0g-YlPm
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

iopt_alloc_iova takes a uptr argument but only checks for its alignment.
Pass an offset from start instead to eliminate its dependence on a user
address.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 05fd9d3..1c23a59 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -104,12 +104,13 @@ static bool __alloc_iova_check_used(struct interval_tree_span_iter *span,
 
 /*
  * Automatically find a block of IOVA that is not being used and not reserved.
+ * @start is the byte offset from the start of the address space.
  * Does not return a 0 IOVA even if it is valid.
  */
 static int iopt_alloc_iova(struct io_pagetable *iopt, unsigned long *iova,
-			   unsigned long uptr, unsigned long length)
+			   unsigned long start, unsigned long length)
 {
-	unsigned long page_offset = uptr % PAGE_SIZE;
+	unsigned long page_offset = start % PAGE_SIZE;
 	struct interval_tree_double_span_iter used_span;
 	struct interval_tree_span_iter allowed_span;
 	unsigned long iova_alignment;
@@ -121,15 +122,15 @@ static int iopt_alloc_iova(struct io_pagetable *iopt, unsigned long *iova,
 		return -EOVERFLOW;
 
 	/*
-	 * Keep alignment present in the uptr when building the IOVA, this
+	 * Keep the start alignment when building the IOVA, which
 	 * increases the chance we can map a THP.
 	 */
-	if (!uptr)
+	if (!start)
 		iova_alignment = roundup_pow_of_two(length);
 	else
 		iova_alignment = min_t(unsigned long,
 				       roundup_pow_of_two(length),
-				       1UL << __ffs64(uptr));
+				       1UL << __ffs64(start));
 
 	if (iova_alignment < iopt->iova_alignment)
 		return -EINVAL;
@@ -240,7 +241,7 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 				 int iommu_prot, unsigned int flags)
 {
 	struct iopt_pages_list *elm;
-	unsigned long iova;
+	unsigned long iova, start;
 	int rc = 0;
 
 	list_for_each_entry(elm, pages_list, next) {
@@ -259,9 +260,8 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 		/* Use the first entry to guess the ideal IOVA alignment */
 		elm = list_first_entry(pages_list, struct iopt_pages_list,
 				       next);
-		rc = iopt_alloc_iova(
-			iopt, dst_iova,
-			(uintptr_t)elm->pages->uptr + elm->start_byte, length);
+		start = elm->start_byte + (uintptr_t)elm->pages->uptr;
+		rc = iopt_alloc_iova(iopt, dst_iova, start, length);
 		if (rc)
 			goto out_unlock;
 		if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
-- 
1.8.3.1

