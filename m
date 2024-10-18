Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0999D205AA9
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286865; cv=none; b=FCRWPOxQ2a3C9n7S7o4HIObjGEarRoK4xCOZOqKVO8egVrSTRv0SgYC9YR9FwOxWpp8HvCg1arH+8yuWUlVbwXgRdK6r9BvCpXuuy7pxsVGW/cMo/eJcD15lgE28bsG3gAZ45zsfd+WWoaalKi0s+XSoPUVXBzDDuGkXVbTt6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286865; c=relaxed/simple;
	bh=+dg4NmLpjM2Ch4wmUpqnZ/PIjIw3LWboqCIpVSU7kko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kpexhSzue06gyvPVRH/iq58CfCO7t0QUZvQx5uK7rVHb9m1jzjBFtudCWkQAskNJVI3z01JYrurQLVWAaswRO9umh1mLREnR4h8TOzgBUhlRZyjy+1jfcUAqH5gjKx487gyGop8/zrxKABpHjwgYCJ1YK+rnNLB3vUDDmZQEiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EnCwJGIq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EnCwJGIq"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBfjJ031129;
	Fri, 18 Oct 2024 21:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=pOKCCX610IpXVrYwdwmFjejPMmH83Os/r/i1vrhtIuw=; b=
	EnCwJGIq0ikEdf5rSoJT6DALFjGo2lT8WriTEj+AAn9pbRyvFQnkB2ospgSPS5UM
	N7Cqj0hdq4kAcKMdTaesQU9RsEnBfddZNz2dkZpmVRb7DujvSdRjilBDwAFpYiko
	aZXsItuOS0yea1MK1TqIYVjkq+0JQNed761bXQLunGDC7RToJDXZY1JErOi5+A76
	39KvHSJT12mNhx6o7/MddiuoEjUyWtP1J2mgdg2B84KYPjNYhU+5iTmf1+bgMjri
	kA/pQtV/82oBvq38X6B5aVYM6qKzxnr/DbAjT+G3l9XTc1bn4VvaaDg82GaBDZIA
	h6nnQENPY2zauv+xZsOXeQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09s5y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IJmAgB026718;
	Fri, 18 Oct 2024 21:27:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjq9s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ILRcVd023093;
	Fri, 18 Oct 2024 21:27:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjjq9r5-3;
	Fri, 18 Oct 2024 21:27:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 2/9] iommufd: rename uptr in iopt_alloc_iova
Date: Fri, 18 Oct 2024 14:27:29 -0700
Message-Id: <1729286856-127844-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180137
X-Proofpoint-GUID: y0w6wAs0qmClTha4dI8dApNQBeJhypeD
X-Proofpoint-ORIG-GUID: y0w6wAs0qmClTha4dI8dApNQBeJhypeD
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

