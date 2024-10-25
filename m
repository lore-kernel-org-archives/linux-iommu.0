Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2E1B81C1
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861935; cv=none; b=jjx1tyhUMCi4JXaoABa7Shih40iMYJyXAQioBWC97JIPN7H65XrHQmeYMHNXQTQujYtLclQJqne9QIVfpoDllX85I46Ejr2qDf3Y+hKX2iZUYuZxxucrk2/RANiI2v443icVNNsp3xUciTrB5Tq7Roo76Sa6AXt1B5+9WXzIVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861935; c=relaxed/simple;
	bh=ZbTLgsTV+18VFpoCcThu4f6OaamswB3JGcbzsd0eD5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e3ybSkVc9B2fFpadYtJRumaOFCBpW4ezugh4TjscIlkeNETAwNweKYBmgieAsy1a6iiPomJI19nnJ2AmIyxzl4lE3iUCNjKD8myMDTNQLw2lOecFmxtuho9qjRXP/3xM0/+WCRZcyTycvR6GgsLYMLPw4SwBKDDmy+etm3f7idg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LxcHlzMl; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LxcHlzMl"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCTsWN029995;
	Fri, 25 Oct 2024 13:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=p/YBxBXk+dybtGoTyFEv3X0XcTLo1ikRyOl2FavZ+uk=; b=
	LxcHlzMlfgCJa2w8P8pIoUpF/DMPVi1Q8BMCteBAWoJNFS1nqBAnDVCIxvI2ex/R
	w2Egh3XBWcP7CNALhoWjRE5QdnnjOVLcZBq2HqaS9Ze09gidk1cucGFn660fygZh
	puC7HjPomXJaiPVWCvP4UtDTtf8x9H9SdpAqKOmJ/Mfvy3trwTDwxtUwETIhbXcb
	2iEVgSnSBpx4wBPqwp/XdnFN2QfSZkaTRWSWvuC/HPSzRp2xp4FrswxgXU7hz3cj
	SxM9p9YX9d0xZHUgDT/IZTJJ34mnluTCgpF5ojC7ceJYMIHulRCMga58760ZGjQw
	7wNeqWm4hujjKQBRtLzeiQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55emt10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxqZj016733;
	Fri, 25 Oct 2024 13:12:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdug0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:03 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49PDC0Rg000657;
	Fri, 25 Oct 2024 13:12:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhdufy3-3;
	Fri, 25 Oct 2024 13:12:02 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 2/9] iommufd: rename uptr in iopt_alloc_iova
Date: Fri, 25 Oct 2024 06:11:52 -0700
Message-Id: <1729861919-234514-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250102
X-Proofpoint-ORIG-GUID: 2cerve-A7_lCYMhnEzceTCtBzl_Nz8f3
X-Proofpoint-GUID: 2cerve-A7_lCYMhnEzceTCtBzl_Nz8f3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

iopt_alloc_iova takes a uptr argument but only checks for its alignment.
Generalize this to an unsigned address, which can be the offset from the
start of a file in a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4bf7ccd..68ad91d 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -107,9 +107,9 @@ static bool __alloc_iova_check_used(struct interval_tree_span_iter *span,
  * Does not return a 0 IOVA even if it is valid.
  */
 static int iopt_alloc_iova(struct io_pagetable *iopt, unsigned long *iova,
-			   unsigned long uptr, unsigned long length)
+			   unsigned long addr, unsigned long length)
 {
-	unsigned long page_offset = uptr % PAGE_SIZE;
+	unsigned long page_offset = addr % PAGE_SIZE;
 	struct interval_tree_double_span_iter used_span;
 	struct interval_tree_span_iter allowed_span;
 	unsigned long max_alignment = PAGE_SIZE;
@@ -122,15 +122,15 @@ static int iopt_alloc_iova(struct io_pagetable *iopt, unsigned long *iova,
 		return -EOVERFLOW;
 
 	/*
-	 * Keep alignment present in the uptr when building the IOVA, this
+	 * Keep alignment present in addr when building the IOVA, which
 	 * increases the chance we can map a THP.
 	 */
-	if (!uptr)
+	if (!addr)
 		iova_alignment = roundup_pow_of_two(length);
 	else
 		iova_alignment = min_t(unsigned long,
 				       roundup_pow_of_two(length),
-				       1UL << __ffs64(uptr));
+				       1UL << __ffs64(addr));
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	max_alignment = HPAGE_SIZE;
@@ -248,6 +248,7 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 				 int iommu_prot, unsigned int flags)
 {
 	struct iopt_pages_list *elm;
+	unsigned long start;
 	unsigned long iova;
 	int rc = 0;
 
@@ -267,9 +268,8 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
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

