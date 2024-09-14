Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA31CEE88
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319170; cv=none; b=qizf+M/mj+Pq8d29Ryu7SEgvHYl6pvrYkAr1nipSj4hJKb+iVn3ihKhZZgolnPWs1rXaj6mu0U6sbFT4b6xFacHeN01CzQ7iYrkfEIizuzTyVklr7bH4DmSK95f4NMwxB5kKsu0n8l6UIQaf6YqHvZTLUVQ2vhebWkPUqqQLups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319170; c=relaxed/simple;
	bh=AsG06d1qqNFI/voAZGsh3r11wgjeZCqr3Mcjk6GZrDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dTKSZHiVLr+xEE/ba5I5EWC8KmjvDQWRXkMRQXG58nUNj4+ind4D2bMrZgFHQHluvZ1lEdYQN8JlPrQ84HbGxpe1xPXwLgKO56/ho612S1JLfVrv9sFCGqlofPa0MDL8iwgNVp/xm63IRfQqxrAGHIL/VWS1BlQVOI2aq0wkCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n1C0L3HA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n1C0L3HA"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EABXfP030789;
	Sat, 14 Sep 2024 13:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=yJCAskVuLO4QfS1drxKTQtRD/gLRI5nyDzCFcr5qCgc=; b=
	n1C0L3HADbsgNbZPQc5Wenfnt3CKeC9xAVSyqym4gHGmVTOTmcjWDtGF8tQoOC8C
	M5NibdF6gh5v9q7AP/fqnsAjvl1c2A0DHAS5OUJK/7z5BpX+fNA7fdfCSYpW0f9v
	jJbR6pZQVkhR1kWkWj61TQQSzape4KOYyKPNGNhMQxuWuuZmxvcfZkwZVsbriGEg
	VQ/6sTgM0cEbgCIgkTR5RZ4zd8UJ9tXtyDEigxp8BxsfiWcTmfnJ9AgcVeLt45ND
	IhkI/KCzWLlOkXr8jGmzsbKYFDUqwPh3MpnB7iYZwbWO1QlJicJPVGTk9+KkCy6n
	Qnu5LuWgNqD8JWNCfIVy1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rjrdpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48E93Rrd019386;
	Sat, 14 Sep 2024 13:06:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6a1v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48ED60jR024307;
	Sat, 14 Sep 2024 13:06:05 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41n0x6a1su-8;
	Sat, 14 Sep 2024 13:06:05 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 7/9] iommufd: file mappings for mdev
Date: Sat, 14 Sep 2024 06:05:56 -0700
Message-Id: <1726319158-283074-8-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: QDBm4GKmkoNFy3pn-MBHtusNqNhS3pOM
X-Proofpoint-GUID: QDBm4GKmkoNFy3pn-MBHtusNqNhS3pOM
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
index 8c8d0ff..4cb532e 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1706,11 +1706,11 @@ static int iopt_pages_fill_from_domain(struct iopt_pages *pages,
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
@@ -1784,8 +1784,8 @@ int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start_index,
 
 		/* hole */
 		cur_pages = out_pages + (span.start_hole - start_index);
-		rc = iopt_pages_fill_from_mm(pages, &user, span.start_hole,
-					     span.last_hole, cur_pages);
+		rc = iopt_pages_fill(pages, &user, span.start_hole,
+				     span.last_hole, cur_pages);
 		if (rc)
 			goto out_clean_xa;
 		rc = pages_to_xarray(&pages->pinned_pfns, span.start_hole,
@@ -1865,6 +1865,9 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
 	struct page *page = NULL;
 	int rc;
 
+	if (WARN_ON(pages->type != IOPT_ADDRESS_USER))
+		return -EINVAL;
+
 	if (!mmget_not_zero(pages->source_mm))
 		return iopt_pages_rw_slow(pages, index, index, offset, data,
 					  length, flags);
@@ -1920,6 +1923,11 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
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

