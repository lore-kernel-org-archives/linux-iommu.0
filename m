Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A80205AA9
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286869; cv=none; b=dHWker/6VO3pNJiqUNcCUDzOP+mLrjRVPGzGYHFhhAP3r6nZ0nd32eWk0E0sqnHGG6EzTIwAepxDlrQokgu/kJumLXUONfVQrb8SMgG/w95700KGn8mookP78LdJhaoBpPPJxfmGrEJ+f/pk7NvSNqByoY5QfhB+7xNxRI0vvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286869; c=relaxed/simple;
	bh=HayUrDZe6zs02Vbn39dbLP7ONNqXIQKlOefE4A6Zr8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VtHOQBCXC03MP31lGJbQ0aDSU1DTluACCKW2LVBRYjxNtnc5kQPEoy6MUvIEKImrymNinMyxn+oUfK2zq73IiuLevbW9bwaJNcwj4yN0Ekgx9InSWquGyvHtS3vG2y7NMZHAvMBgsO4jZ3yYwIhYmw5PjTSoHjVZnbsCC/fCoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HVWuO0xe; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HVWuO0xe"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBfuL031108;
	Fri, 18 Oct 2024 21:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=i1lHbHv0AZh0Qr/827mXbupTMkeGQDBUBujU68P8EVQ=; b=
	HVWuO0xeAs+jHH2cBpPgLjQ+nkzu5i56kY0YTM5CwJqjpvYoFyenlA4nVmhWxRQf
	Qc0SwgQN7iHjqfHrro2Zl9yP/zpXMBRFLEJxWsjezl/JoB4dSSZbz2zTxYvXDeye
	X9pquCWmZAwMnSMxvJtQu2abcYQ9AZak8lBupBpjwW1FufuXo/aZQEjq4Vii1Xpr
	QlGEzf8zq5UFh6hu/Id18SdDhQPmsK8RhF8rHIkwdGy9I5fInzEZZXuvC/B7vSeU
	rCXMpzPVTI2g4hom/i18w9LwUL0ZdoaL0ZjBPXmqnVYqjMFTjSF2gxVMISIxWU+4
	2XynJcbk+mEAscuMV/OqUA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09s5y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKm27L027314;
	Fri, 18 Oct 2024 21:27:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjq9u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ILRcVp023093;
	Fri, 18 Oct 2024 21:27:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjjq9r5-9;
	Fri, 18 Oct 2024 21:27:44 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 8/9] iommufd: file mappings for mdev
Date: Fri, 18 Oct 2024 14:27:35 -0700
Message-Id: <1729286856-127844-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: Lhmrci5KDkfpIhwDGz1qAH0X1x3r75dm
X-Proofpoint-ORIG-GUID: Lhmrci5KDkfpIhwDGz1qAH0X1x3r75dm
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
index d369f56..75d0fed 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1819,11 +1819,11 @@ static int iopt_pages_fill_from_domain(struct iopt_pages *pages,
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
@@ -1897,8 +1897,8 @@ int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start_index,
 
 		/* hole */
 		cur_pages = out_pages + (span.start_hole - start_index);
-		rc = iopt_pages_fill_from_mm(pages, &user, span.start_hole,
-					     span.last_hole, cur_pages);
+		rc = iopt_pages_fill(pages, &user, span.start_hole,
+				     span.last_hole, cur_pages);
 		if (rc)
 			goto out_clean_xa;
 		rc = pages_to_xarray(&pages->pinned_pfns, span.start_hole,
@@ -1978,6 +1978,10 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
 	struct page *page = NULL;
 	int rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(pages->type != IOPT_ADDRESS_USER))
+		return -EINVAL;
+
 	if (!mmget_not_zero(pages->source_mm))
 		return iopt_pages_rw_slow(pages, index, index, offset, data,
 					  length, flags);
@@ -2033,6 +2037,15 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
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

