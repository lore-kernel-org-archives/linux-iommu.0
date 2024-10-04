Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A91EF0B2
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067708; cv=none; b=qHpwrz7pcEjzMcCLY8SxqDGGkjCT2DWK/IV45ZZpPS03JMTQzhY8Kq7LYIE1kOezJKITe4JaekLgwQTdncdrWaBDNi7zgEuaU44ifXGgRp4z0Kl+GBdvu+bThhHhSreU16btDkW+JqEuOPJmte2L5jUL23vewZ/kyfbWEkzgk+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067708; c=relaxed/simple;
	bh=vXTIV8+0PeWPD/fJqa6UOxit3FdUS96qkBzfraIQIso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U8VWxsiQNG3Bwc1v/MY4Gzy6DqfI6MrzVT493TWn9DLE8gWuozmtXQr93oPcSjsTnyZ6eG46WIkYiJRHuRR3nLbpzNOAMdkPk9PJmbXBQh82A2R9Z4FKZveML56UVS3cE9QW/Yo+49qN8XSSc136uxkpji5jGSVdOEFfPqKDgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ao0RGQtX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ao0RGQtX"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Hfep8027831;
	Fri, 4 Oct 2024 18:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=WQNjHBjRIPg/7KGFvnrtvZEbeQz8AVH8CLF5a0SmTG0=; b=
	Ao0RGQtXjA/2znc1OoEkAe2ammmJ92qtybo+j75M1iTTHb0UFaCbdnqvnkhsJZaM
	7DAu3RHrwRz9Qi2MAOHMVscrmo13BcG1gSGVfqHS+e9raBnHK+duKt/QRxkkJWn9
	uMmbhYeUiXLPHA1R43jPGd2Fnz21s7d4+6nQLKP9hE2jk4+Byd96iuxi958tsm4W
	L1GDsG7KJFUQD6xU/yuGnqZDe0d99ntjpYuGcFXjQvzx1TUgeJHv4TMtr+0FFhGU
	lAiSPzmYfeDsyYz+bLvaEiOsE+7l4ywqs9XjlMxJqhQ9z89ADRV3IvOldVVAgdbD
	6tWhr701cW4BiHd044DJeQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422049291a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494H5eaB038083;
	Fri, 4 Oct 2024 18:48:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057p5u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:23 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494ImLa0029789;
	Fri, 4 Oct 2024 18:48:23 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422057p5sn-3;
	Fri, 04 Oct 2024 18:48:23 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 2/9] iommufd: rename uptr in iopt_alloc_iova
Date: Fri,  4 Oct 2024 11:48:13 -0700
Message-Id: <1728067700-32092-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040129
X-Proofpoint-GUID: jmG92bRsr8S1e1GN5voV9k_owmuIID8o
X-Proofpoint-ORIG-GUID: jmG92bRsr8S1e1GN5voV9k_owmuIID8o
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
 drivers/iommu/iommufd/io_pagetable.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 05fd9d3..20e31e1 100644
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
 	unsigned long iova_alignment;
@@ -121,15 +121,15 @@ static int iopt_alloc_iova(struct io_pagetable *iopt, unsigned long *iova,
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
 
 	if (iova_alignment < iopt->iova_alignment)
 		return -EINVAL;
@@ -240,7 +240,7 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 				 int iommu_prot, unsigned int flags)
 {
 	struct iopt_pages_list *elm;
-	unsigned long iova;
+	unsigned long iova, start;
 	int rc = 0;
 
 	list_for_each_entry(elm, pages_list, next) {
@@ -259,9 +259,8 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
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

