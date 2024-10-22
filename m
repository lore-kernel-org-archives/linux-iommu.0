Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9EB1CB325
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630853; cv=none; b=Be+K8wJoubNPkN2Qpe8dTp05Wv0nWvaUf0/xe4fH1o7swt6xbnrV2OmYpeIrxSB2BMwjXLxfAvIFC9m5h6VSJNXdu4mo60OMEPcmNZWfIpZnFOsq3pldTY5f6iDQ4Yhk+fFVGuLBlvEBUXG6de04IlRDXLRWQCQ79fIfJGVNl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630853; c=relaxed/simple;
	bh=119oMVl68SMCEFmi6XMHT3/bnq7Jenoh2szL2PRiG6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NFUjyMQvWNFoxpKbJSyAt0/EfZfEWgxXp1Hm6NpQD2Utpq1yOY9P7zMGaBBYle5TlfTYw9pmUygnqT0oNI4C8oBwOXJA2dZcoyxyhIIGWiqLDuy2JGSJDg6/1v+dmcsnUlFGefmiEnijW9LFb+IKDHaNJgPV8/XrloHPjUVHSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LFcRnEaI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LFcRnEaI"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKqNuc027972;
	Tue, 22 Oct 2024 21:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=NHOkXqz77bsyU75FI1uS2UR3tTAV2DjBfCV21otx1qg=; b=
	LFcRnEaIPblemfe9C6gEUFbfJmjhY7ByS7eD8JTtDTkKDHzjEFgGVDJj1bj/SI/u
	uOfj7BuRYWsj74caLc8pIGW/YVJBgy/DN2Ld4ImfB9tfA4N7absbdeRnKVqPw+aE
	gSVeBJwlFEwdma1joRrn1sL3ez/f+0CvftO8ApkbBYY2QWKHAvwsQIGivsn6Tntn
	autKDvEbUQtlAX0zorf/prh7gFTPHT3UNOs62vItMjlgJW0PdLJzMPen3pDlBi+g
	lFr2/jrBJKVPTATHc7QfgoAO3KPetNUWK+vQZeF0m7sGwGhj0Bw0KKZPoblH6I1f
	LvkGUeidkTsjRGdDA46xPA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3du77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKflH6012240;
	Tue, 22 Oct 2024 21:00:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c3781ann-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:47 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ML0dEq016716;
	Tue, 22 Oct 2024 21:00:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42c3781a7p-9;
	Tue, 22 Oct 2024 21:00:46 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 8/9] iommufd: file mappings for mdev
Date: Tue, 22 Oct 2024 14:00:37 -0700
Message-Id: <1729630838-24586-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: -u3rXxCXYKNgSBPv4Uze0KZygdx50wFE
X-Proofpoint-GUID: -u3rXxCXYKNgSBPv4Uze0KZygdx50wFE
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
index 1b8c3bf..daf8fde 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1814,11 +1814,11 @@ static int iopt_pages_fill_from_domain(struct iopt_pages *pages,
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
@@ -1892,8 +1892,8 @@ int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start_index,
 
 		/* hole */
 		cur_pages = out_pages + (span.start_hole - start_index);
-		rc = iopt_pages_fill_from_mm(pages, &user, span.start_hole,
-					     span.last_hole, cur_pages);
+		rc = iopt_pages_fill(pages, &user, span.start_hole,
+				     span.last_hole, cur_pages);
 		if (rc)
 			goto out_clean_xa;
 		rc = pages_to_xarray(&pages->pinned_pfns, span.start_hole,
@@ -1973,6 +1973,10 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
 	struct page *page = NULL;
 	int rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(pages->type != IOPT_ADDRESS_USER))
+		return -EINVAL;
+
 	if (!mmget_not_zero(pages->source_mm))
 		return iopt_pages_rw_slow(pages, index, index, offset, data,
 					  length, flags);
@@ -2028,6 +2032,15 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
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

