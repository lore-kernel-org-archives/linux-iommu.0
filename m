Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8C01EABDF
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783562; cv=none; b=AOBh22dsWNvgV9CAm0D9eA4lJa0O2r4QX9oK7sgqD5onOQ0YmQLNTYJAwEexeGe72ws2IHmhGl3UUeEnw3Sao5sqTyvRXs39w+0+S5bnE/93xsVayFsCNGhnRNYgyX3gVi4ReTPbg4NYAEhDoGbJT/0gS/f0RzEo0OpueyZHuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783562; c=relaxed/simple;
	bh=ZbTLgsTV+18VFpoCcThu4f6OaamswB3JGcbzsd0eD5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VAE343tXHusBfHDPriuXP8/+cO1e++71gmQAB935dYc2lvRj+CGXc7isP2zmtTTRqreantH+N39gcodtUDpI2UQ0fHgE3f6Fe/DKTEDKrlSjvGdXrWY4QJQhTZoxZP1GjDaZgiDxLE2VtsfNZi0cI9+VIkCh2TGFoUKB/oP5Uq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VdRykZGB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VdRykZGB"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC1aF1025361;
	Thu, 24 Oct 2024 15:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=p/YBxBXk+dybtGoTyFEv3X0XcTLo1ikRyOl2FavZ+uk=; b=
	VdRykZGBP2c2t7hLHccE8usEOGNwyo0JliXacZ5WI6iPUcLaiGwZK8JKk/vfkgMt
	PDgJiDmOpT2kDIqDdi3qHnPxEXsPjhJFm3S3jDd+Y/cWnIAICIZg0QfsmWtKo1Di
	C7Eqcle4tkODH1fIqClF2hC41VVbI3FlW++s5g8v2kYPXi9fLZrtUmVVNu09QwGg
	mYtrQHJy/b9l3ys+TI0b5+rB+GzaT9/uf8NojYw8qQfmPptfTSp8B8o1BpioqzzP
	rZraXvBPj14/j5Pct5uU3qF1QGN73Kzuz4/4fvmqFTT/Fh7ovL7hftif7wyqMeFq
	vkRL/ZvKStlaB5oFRF4nFA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55ejt6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:25:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OF1MAE027419;
	Thu, 24 Oct 2024 15:25:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh4g0qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:25:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49OFNFX5038314;
	Thu, 24 Oct 2024 15:25:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emh4g0jc-3;
	Thu, 24 Oct 2024 15:25:56 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 2/9] iommufd: rename uptr in iopt_alloc_iova
Date: Thu, 24 Oct 2024 08:25:47 -0700
Message-Id: <1729783554-56916-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
References: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240126
X-Proofpoint-ORIG-GUID: v1lhaaTc77F2tnLVvP7AErtykWy2u2Sk
X-Proofpoint-GUID: v1lhaaTc77F2tnLVvP7AErtykWy2u2Sk
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

