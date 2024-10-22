Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467B13AD2A
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630847; cv=none; b=dQ6vZSAfrlv4zUGESrCDciKL7E5gh+1qS14G+pJzxpB8vquc9pSsRuabcd3eT1EzhOIdcohVjm16ORijdPy9Ad5atqH0iuxxf6Ja84QFXEHjXlHZFVXOR84qGpRGOWIZZMcbrBYgILs7it2YKOQuvTPjETD/3JMXDB/ePMqvl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630847; c=relaxed/simple;
	bh=X2+/nXfY32S9FRGxmaAO37EJvTzZ5qMA1YMsvROTdrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q2Y6zQB7z+NOoeX9rz2fGa3YImEoIiwb9w4BoELpD5gPcQJKnUDeaMah2isCpSObspUWOpTKSqvxusyMMjYB6p2l/FCWiNiCUE5/BTV6neKsUMFQHFbOlVulBLnH8anC0m/ddAoW69PoFEDXC10SYKRuHbCfCRT0DPQAmFKW8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q3buACc7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q3buACc7"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKqJsF032195;
	Tue, 22 Oct 2024 21:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=hBpsKB1fFfpL+THd+mF8sUiQdV/jOI2XovfLkicaHL0=; b=
	Q3buACc7tt8h+nsIAOXwc14sSrmgrQ/Wmj/Ad/M9c3ojFMkskS28OmUc5UMhpWgB
	sRiIumNhYBjYe5cPQFN2aXo4w1hmKIyhMaKBou0/wx48Sv9jFNUR8/p6hYIOsK81
	u+QLbdFjeM1ewXm6XFONQ1i6bboRSMJz9qa29u9Sl1nytekt6HkHUan0lyskURpV
	bRvmf42D5GNsLZo8AuHwdvR2+7FIA+sWfL3HQtvJ61wWqcin2aelrbDGuRxalFfm
	ufmhZguy6kZZwW62wIVih67O2n1rX7/uGbrF46Q4JvQgyxTEUaP16qpsuFfHm90j
	IdhGFCSk6ULWeUPBlzfFkQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqx0d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK0eQ5011988;
	Tue, 22 Oct 2024 21:00:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c3781ac3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ML0dEe016716;
	Tue, 22 Oct 2024 21:00:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42c3781a7p-3;
	Tue, 22 Oct 2024 21:00:40 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 2/9] iommufd: rename uptr in iopt_alloc_iova
Date: Tue, 22 Oct 2024 14:00:31 -0700
Message-Id: <1729630838-24586-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_23,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220135
X-Proofpoint-GUID: 7q5A5O05Inq_HGhx1F9Y4Q_A8mSZAVgs
X-Proofpoint-ORIG-GUID: 7q5A5O05Inq_HGhx1F9Y4Q_A8mSZAVgs
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

