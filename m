Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24584643A
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880920; cv=none; b=qI3et7x4+2h5Yj8qpmzi8ZT83KB8A6wl+JTszFbQ5VigwfijFoDC5dCrLXT1xcC+xFB4g4jQH13E/bJXyoOwcNDvYIZuEXHUU9d0xCqZ/uL3wpWGbvArEtu51pOxAyVaDjpUAuhBvjS1hFFT0+55JlAkU4Kfmh82ru78JAJI60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880920; c=relaxed/simple;
	bh=mYz8E9WA3ehSMAZ19ekghF/jpKyTHOXvkSotNCczUrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GRkxmPkzQw1+sfwHmowcKLkjbgGaYS/t27B0pEQS1nAVnJySi7IDrqKuBxdJ47qd2CLZ6Joqq4fpKlsU9/Wr6l5Q45xxKMSVdInXRLOqypT7lecOb0yB/npb7XW5GCRLgZhWYq82it3DAO2guIBg1ghrqUXZ8JY24Ar3ZHPrMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d/B78qxN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/B78qxN"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DRD1k014600;
	Fri, 2 Feb 2024 13:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=paKNOA/ZwbfGSg5jBXNeWuYPLym1V6t7ndNdaHI8LVU=;
 b=d/B78qxNbbzZIq8rdYwYHDZXcTf1/W7TT6x0i5l7cCt/4yg2YbU4aiN8sb/YYrzIF9R5
 95PA12qIzJbp/TE82TEc7Kd7vbJyR8vW2DoGe3vJ9mT/NF43nFTpBRBUvXPZ2YJguc5G
 p8WTxXoD4nfVi2ofhLmFgU/yT4Kzf0TnmdjBcVa2mQqHIjhota096jmWrOE54ogL9i2i
 9db8/h+JajNJcP+ne3AKUd/sZ4q2TaWj1zYr5ILMT+Pxa1E56sYy98Q1X2XRD3+rTXfG
 QvNmpRoJ69zPjCBihynlcQWr+uDwGpC/FSIPOa7K7ow6jfythWUwYk25V0TjDiwiiQUi mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8eq7e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412DUlCq024497;
	Fri, 2 Feb 2024 13:35:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9buf9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DWmAr022185;
	Fri, 2 Feb 2024 13:35:09 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-220-219.vpn.oracle.com [10.175.220.219])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9buewt-7;
	Fri, 02 Feb 2024 13:35:08 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 6/9] iommufd/selftest: Refactor mock_domain_read_and_clear_dirty()
Date: Fri,  2 Feb 2024 13:34:12 +0000
Message-Id: <20240202133415.23819-7-joao.m.martins@oracle.com>
In-Reply-To: <20240202133415.23819-1-joao.m.martins@oracle.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_07,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020099
X-Proofpoint-ORIG-GUID: f861vgtoYOV9biwKS0w8cKIYYGS_hoEz
X-Proofpoint-GUID: f861vgtoYOV9biwKS0w8cKIYYGS_hoEz

Move the clearing of the dirty bit of the mock domain into
mock_domain_test_and_clear_dirty() helper, simplifying the caller function.

Additionally, rework the mock_domain_read_and_clear_dirty() loop to iterate
over a potentially variable IO page size. No functional change intended
with the loop refactor.

This is in preparation for dirty tracking support for IOMMU hugepage mock
domains.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/iommufd/selftest.c | 64 ++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 2fb2597e069f..182495041407 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -191,6 +191,34 @@ static int mock_domain_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 }
 
+static bool mock_test_and_clear_dirty(struct mock_iommu_domain *mock,
+				      unsigned long iova, size_t page_size,
+				      unsigned long flags)
+{
+	unsigned long cur, end = iova + page_size - 1;
+	bool dirty = false;
+	void *ent, *old;
+
+	for (cur = iova; cur < end; cur += MOCK_IO_PAGE_SIZE) {
+		ent = xa_load(&mock->pfns, cur / MOCK_IO_PAGE_SIZE);
+		if (!ent || !(xa_to_value(ent) & MOCK_PFN_DIRTY_IOVA))
+			continue;
+
+		dirty = true;
+		/* Clear dirty */
+		if (!(flags & IOMMU_DIRTY_NO_CLEAR)) {
+			unsigned long val;
+
+			val = xa_to_value(ent) & ~MOCK_PFN_DIRTY_IOVA;
+			old = xa_store(&mock->pfns, cur / MOCK_IO_PAGE_SIZE,
+				       xa_mk_value(val), GFP_KERNEL);
+			WARN_ON_ONCE(ent != old);
+		}
+	}
+
+	return dirty;
+}
+
 static int mock_domain_read_and_clear_dirty(struct iommu_domain *domain,
 					    unsigned long iova, size_t size,
 					    unsigned long flags,
@@ -198,31 +226,29 @@ static int mock_domain_read_and_clear_dirty(struct iommu_domain *domain,
 {
 	struct mock_iommu_domain *mock =
 		container_of(domain, struct mock_iommu_domain, domain);
-	unsigned long i, max = size / MOCK_IO_PAGE_SIZE;
-	void *ent, *old;
+	unsigned long end = iova + size;
+	void *ent;
 
 	if (!(mock->flags & MOCK_DIRTY_TRACK) && dirty->bitmap)
 		return -EINVAL;
 
-	for (i = 0; i < max; i++) {
-		unsigned long cur = iova + i * MOCK_IO_PAGE_SIZE;
+	do {
+		unsigned long pgsize = MOCK_IO_PAGE_SIZE;
+		unsigned long head;
 
-		ent = xa_load(&mock->pfns, cur / MOCK_IO_PAGE_SIZE);
-		if (ent && (xa_to_value(ent) & MOCK_PFN_DIRTY_IOVA)) {
-			/* Clear dirty */
-			if (!(flags & IOMMU_DIRTY_NO_CLEAR)) {
-				unsigned long val;
-
-				val = xa_to_value(ent) & ~MOCK_PFN_DIRTY_IOVA;
-				old = xa_store(&mock->pfns,
-					       cur / MOCK_IO_PAGE_SIZE,
-					       xa_mk_value(val), GFP_KERNEL);
-				WARN_ON_ONCE(ent != old);
-			}
-			iommu_dirty_bitmap_record(dirty, cur,
-						  MOCK_IO_PAGE_SIZE);
+		ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
+		if (!ent) {
+			iova += pgsize;
+			continue;
 		}
-	}
+
+		head = iova & ~(pgsize - 1);
+
+		/* Clear dirty */
+		if (mock_test_and_clear_dirty(mock, head, pgsize, flags))
+			iommu_dirty_bitmap_record(dirty, head, pgsize);
+		iova = head + pgsize;
+	} while (iova < end);
 
 	return 0;
 }
-- 
2.17.2

