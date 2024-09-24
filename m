Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF831AB50A
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190350; cv=none; b=WOrGayPlZnIYs1dw029L5fJx9RY/Sqz4ftYsaC70j6CKCR61Zhf8BvbjKIUBW+tFlTM8Gmn42WAshleCt3ktInuNXzF8zsLD17Hk0bdxHKnJVjj7jR1FpGFXkKYGpug2gjLr3QN91ZiL7Zc6wV/eGWuzuCzesQw+eAx+PS8tFKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190350; c=relaxed/simple;
	bh=8j51Jby8ftXWY/+Cr5ZmSuaIOruOOddPVc1kvmU1vZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G9D+R37v7RWWDl1o/jS7KZ3kIoI3zhdAsySPauNfhcwbFyhtEbaIqdksdUD7wkDsuyorZqSeL76i4xnvegXrMD5vL/zBH7qnYGLc27Flp80Dk0C2Fkd303zI1fLdHUzrHtEfIEfv7RswJADLT7KKv51NpjzxZeUE5GVuzmzV7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OV6Ts/Ut; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OV6Ts/Ut"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQfnD000593;
	Tue, 24 Sep 2024 15:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=957yONg7eXEDgso2fei1/0az3NIEnq0imMMpeLIPjLE=; b=
	OV6Ts/UtFDGGCCxUrBxp4C/PE2dkvL2QZReXdEIC2iXX8O4hCs7r3BT7I8srHJ/A
	neHR4wpGActbzOkqrwJ0vV9b0qYBdFBqXokpQeY7fEtx9KUDJSRpzNrgmTwYCFJK
	9MOoR01bKm05x0iWrbyG/8gOsp/ZJsarz6JLaQ0DH0iatFn6H6/MtCFHxRuH2i57
	EVdVJuvTx4tHHOr0nKylQX9m7p9f8TBGqJLfQWkmjFAkAt0/DdSkSKLuh0D8h3LZ
	KSvuHT0wMG9wXSbN8g30P+2dhdL0eso9yxj48gbYvY6hBjDuDLt6Ry/Jz4ClIWrI
	O9AZrFaHqwf4WDc94uddSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cqtcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48ODxTW0005570;
	Tue, 24 Sep 2024 15:05:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9cr5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48OF5dLN027122;
	Tue, 24 Sep 2024 15:05:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smk9cqxg-7;
	Tue, 24 Sep 2024 15:05:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 6/9] iommufd: file mappings for mdev
Date: Tue, 24 Sep 2024 08:05:35 -0700
Message-Id: <1727190338-385692-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240108
X-Proofpoint-GUID: 6SulX0G7m5Tdw2R-Bc-4UM0Dv6CYDcsw
X-Proofpoint-ORIG-GUID: 6SulX0G7m5Tdw2R-Bc-4UM0Dv6CYDcsw
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Support file mappings for mediated devices, aka mdevs.  Access is initiated
by the vfio_pin_pages and vfio_dma_rw kernel interfaces.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/pages.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 0a432dc2..9d31df4 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1725,11 +1725,11 @@ static int iopt_pages_fill_from_domain(struct iopt_pages *pages,
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
@@ -1803,8 +1803,8 @@ int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start_index,
 
 		/* hole */
 		cur_pages = out_pages + (span.start_hole - start_index);
-		rc = iopt_pages_fill_from_mm(pages, &user, span.start_hole,
-					     span.last_hole, cur_pages);
+		rc = iopt_pages_fill(pages, &user, span.start_hole,
+				     span.last_hole, cur_pages);
 		if (rc)
 			goto out_clean_xa;
 		rc = pages_to_xarray(&pages->pinned_pfns, span.start_hole,
@@ -1884,6 +1884,9 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
 	struct page *page = NULL;
 	int rc;
 
+	if (WARN_ON(pages->type != IOPT_ADDRESS_USER))
+		return -EINVAL;
+
 	if (!mmget_not_zero(pages->source_mm))
 		return iopt_pages_rw_slow(pages, index, index, offset, data,
 					  length, flags);
@@ -1939,6 +1942,11 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
 		return -EPERM;
 
+	if (pages->type == IOPT_ADDRESS_FILE)
+		return iopt_pages_rw_slow(pages, start_index, last_index,
+					  start_byte % PAGE_SIZE, data, length,
+					  flags);
+
 	if (!(flags & IOMMUFD_ACCESS_RW_KTHREAD) && change_mm) {
 		if (start_index == last_index)
 			return iopt_pages_rw_page(pages, start_index,
-- 
1.8.3.1

