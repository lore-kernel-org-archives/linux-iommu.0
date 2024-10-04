Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FDC1EF945
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067712; cv=none; b=Rv3O7vxKtOGyaoMSDOE1h4ngLNKciIDqid2YY867DTO6nSfOvI0Po7b+uZNj6aHDo+XaO7kJHNbyB7OY3sTH6hJEIdOLs2nNvZuR7GOE7ChEmK2+MiHL+Q87/P6BUlkSx/0Deqe1vtPUkOAd2DTihanWl7UK1ZLAqwR5ScRFnTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067712; c=relaxed/simple;
	bh=sz/IRM58zNDJJCYBq1ovxtjx04eD8Yd63sSLVOgN6lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gUFAtqonBQqPLSQWQi1wMxgzfLq7MLzTjfilCkn0vcFAb27DMNSwXAn20183asz2AkoCSzlYv0lE4vqB1aqHSJnrq3v2QDBzkT57rQWIGH2oBjmIoqWsKisXufxHUcpWzgs6CuVSyjr0OV3lCOdQQgTAuUxT/HPBv9srL7G+p7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fSVghl1s; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fSVghl1s"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494HffVZ027859;
	Fri, 4 Oct 2024 18:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=ls+Fw6iZoPN3PoOZ0pZ0CkwCQRfVJJGUZLPyy9dJ6vA=; b=
	fSVghl1sfAFEN8wEzAeILuFFbjtT1OTKPQzB/jUsuV6Pf+OwXYzcE4gXY1Tvff80
	bKXv/lQNIfpC1GfJxR4YE4kNVrORh7yEdrZJ9i6xvepHL3+KK2/jADNjcFmr2I99
	usr81hgaMh5Y/djOLpdhywkg4nwx8PPob7Iik0+YtszO5mAyvewJ5zxM6vA2JWEe
	DCcBnKutNu6swhsGIsTSMjS1W9EFPdAqlPQ6WNmfD0KJ4kCS820evBL/okIcZacE
	QDnJ48512z8wXgTuHcpj1nxTM4rsAyWJT+pcrQG30mMehBHKLZvhdqb/fN2bj4CZ
	GGFaVqHeEASp+84KloWeoA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422049291e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494HFEWn038116;
	Fri, 4 Oct 2024 18:48:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057p5vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:27 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494ImLa8029789;
	Fri, 4 Oct 2024 18:48:27 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422057p5sn-7;
	Fri, 04 Oct 2024 18:48:26 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 6/9] iommufd: file mappings for mdev
Date: Fri,  4 Oct 2024 11:48:17 -0700
Message-Id: <1728067700-32092-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: x6OHHqI70G6aCQSBQ9XyRzQvmRaTBrEc
X-Proofpoint-ORIG-GUID: x6OHHqI70G6aCQSBQ9XyRzQvmRaTBrEc
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Support file mappings for mediated devices, aka mdevs.  Access is initiated
by the vfio_pin_pages and vfio_dma_rw kernel interfaces.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index c4c83c4..8030226 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1731,11 +1731,11 @@ static int iopt_pages_fill_from_domain(struct iopt_pages *pages,
 	return 0;
 }
 
-static int iopt_pages_fill_from_mm(struct iopt_pages *pages,
-				   struct pfn_reader_user *user,
-				   unsigned long start_index,
-				   unsigned long last_index,
-				   struct page **out_pages)
+static int iopt_pages_fill(struct iopt_pages *pages,
+			   struct pfn_reader_user *user,
+			   unsigned long start_index,
+			   unsigned long last_index,
+			   struct page **out_pages)
 {
 	unsigned long cur_index = start_index;
 	int rc;
@@ -1809,8 +1809,8 @@ int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start_index,
 
 		/* hole */
 		cur_pages = out_pages + (span.start_hole - start_index);
-		rc = iopt_pages_fill_from_mm(pages, &user, span.start_hole,
-					     span.last_hole, cur_pages);
+		rc = iopt_pages_fill(pages, &user, span.start_hole,
+				     span.last_hole, cur_pages);
 		if (rc)
 			goto out_clean_xa;
 		rc = pages_to_xarray(&pages->pinned_pfns, span.start_hole,
@@ -1890,6 +1890,10 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
 	struct page *page = NULL;
 	int rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(pages->type != IOPT_ADDRESS_USER))
+		return -EINVAL;
+
 	if (!mmget_not_zero(pages->source_mm))
 		return iopt_pages_rw_slow(pages, index, index, offset, data,
 					  length, flags);
@@ -1945,6 +1949,15 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
 		return -EPERM;
 
+	if (pages->type == IOPT_ADDRESS_FILE)
+		return iopt_pages_rw_slow(pages, start_index, last_index,
+					  start_byte % PAGE_SIZE, data, length,
+					  flags);
+
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(pages->type != IOPT_ADDRESS_USER))
+		return -EINVAL;
+
 	if (!(flags & IOMMUFD_ACCESS_RW_KTHREAD) && change_mm) {
 		if (start_index == last_index)
 			return iopt_pages_rw_page(pages, start_index,
-- 
1.8.3.1

