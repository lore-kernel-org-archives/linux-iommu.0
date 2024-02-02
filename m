Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800894643A
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880928; cv=none; b=NiujBjfYnWgBDdMquWffjOfN0GU7RU0EUPM9sJ+VCSoUoYzOhMteXN/Itv13AEjTPPrSmSiCjx/nT+F4JGDEJJMbKf8stwYpHHg9RtOgbYo/fpExbrKMlddKoR9cfMvGI0l6e92An1V9JAx4SjhyPtXoWyT4trYbibv9dv1JJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880928; c=relaxed/simple;
	bh=YPY1MADO2shveoRz0HmStiBtEOFsyVfryhcH2u6YP3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDV+LvT9r/Na0aQGLVFo7I0RlH6BYK+2zLhz2J2iJvY/B1dmv/SMN5qzMdS84u6d3XXYJw/v2m8IWRmC57SEbcYsbIX7Oa/HEU6kXzg3w2awYyAF3+Z9LY48xjtVgDNJKmzZ4q0FVjGCxA7AATySSO1Zlh65Tj1VeH7G+I6k5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lLOPjvGR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lLOPjvGR"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DQqwV013385;
	Fri, 2 Feb 2024 13:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=a5tv35wfX7cTuPzQvsK4JW1aVqmRu/2Y3yhmAc3d9ZI=;
 b=lLOPjvGRYCyxx3ZsDbHwMIpa4aduAeN5QRu1y7zqLubB0L4V6bWGRiFNyk75Ot80DlEl
 owc2jSfZbTHEks3ZvmHSSl5NWklJeLwM5k/WgkUyBzRwsEkJ/SNC2HnE5CipzG4w9LQh
 FJH70Fy9lEQy34EA5giL9cLOGcdC/rXwxMs/Vp35ELIZpeHJ2r2AFQCg3CGy/bgNR5hf
 eGXTjhLktlzewC5M7x34M5PphdA0w8IKhF4bznchvqr2L79lBz131jFAk1gVLr7Bcujw
 naZbDuFayYyK7BEGJ8NwFNSI05Ax9xk0eyiq6JA5Q08nwgDYkYfgzoWTK2pRr53/YFae 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm47jeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412BT81g024561;
	Fri, 2 Feb 2024 13:35:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9bufbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DWmAt022185;
	Fri, 2 Feb 2024 13:35:11 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-220-219.vpn.oracle.com [10.175.220.219])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9buewt-8;
	Fri, 02 Feb 2024 13:35:11 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 7/9] iommufd/selftest: Hugepage mock domain support
Date: Fri,  2 Feb 2024 13:34:13 +0000
Message-Id: <20240202133415.23819-8-joao.m.martins@oracle.com>
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
X-Proofpoint-GUID: t7IonzoRLYGKzr0wfLyTnGmtHN8gglWz
X-Proofpoint-ORIG-GUID: t7IonzoRLYGKzr0wfLyTnGmtHN8gglWz

Add support to mock iommu hugepages of 1M (for a 2K mock io page size). To
avoid breaking test suite defaults, the way this is done is by explicitly
creating a iommu mock device which has hugepage support (i.e. through
MOCK_FLAGS_DEVICE_HUGE_IOVA).

The same scheme is maintained of mock base page index tracking in the
XArray, except that an extra bit is added to mark it as a hugepage. One
subpage containing the dirty bit, means that the whole hugepage is dirty
(similar to AMD IOMMU non-standard page sizes). For clearing, same thing
applies, and it must clear all dirty subpages.

This is in preparation for dirty tracking to mark mock hugepages as
dirty to exercise all the iova-bitmap fixes.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  1 +
 drivers/iommu/iommufd/selftest.c     | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 482d4059f5db..e854d3f67205 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -45,6 +45,7 @@ enum {
 
 enum {
 	MOCK_FLAGS_DEVICE_NO_DIRTY = 1 << 0,
+	MOCK_FLAGS_DEVICE_HUGE_IOVA = 1 << 1,
 };
 
 enum {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 182495041407..066ba92fc069 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -41,6 +41,7 @@ static atomic_t mock_dev_num;
 enum {
 	MOCK_DIRTY_TRACK = 1,
 	MOCK_IO_PAGE_SIZE = PAGE_SIZE / 2,
+	MOCK_HUGE_PAGE_SIZE = 512 * MOCK_IO_PAGE_SIZE,
 
 	/*
 	 * Like a real page table alignment requires the low bits of the address
@@ -53,6 +54,7 @@ enum {
 	MOCK_PFN_START_IOVA = _MOCK_PFN_START,
 	MOCK_PFN_LAST_IOVA = _MOCK_PFN_START,
 	MOCK_PFN_DIRTY_IOVA = _MOCK_PFN_START << 1,
+	MOCK_PFN_HUGE_IOVA = _MOCK_PFN_START << 2,
 };
 
 /*
@@ -242,6 +244,8 @@ static int mock_domain_read_and_clear_dirty(struct iommu_domain *domain,
 			continue;
 		}
 
+		if (xa_to_value(ent) & MOCK_PFN_HUGE_IOVA)
+			pgsize = MOCK_HUGE_PAGE_SIZE;
 		head = iova & ~(pgsize - 1);
 
 		/* Clear dirty */
@@ -260,6 +264,7 @@ const struct iommu_dirty_ops dirty_ops = {
 
 static struct iommu_domain *mock_domain_alloc_paging(struct device *dev)
 {
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
 	struct mock_iommu_domain *mock;
 
 	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
@@ -268,6 +273,8 @@ static struct iommu_domain *mock_domain_alloc_paging(struct device *dev)
 	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
 	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
+	if (dev && mdev->flags & MOCK_FLAGS_DEVICE_HUGE_IOVA)
+		mock->domain.pgsize_bitmap |= MOCK_HUGE_PAGE_SIZE;
 	mock->domain.ops = mock_ops.default_domain_ops;
 	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
 	xa_init(&mock->pfns);
@@ -313,7 +320,7 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
 			return ERR_PTR(-EOPNOTSUPP);
 		if (user_data || (has_dirty_flag && no_dirty_ops))
 			return ERR_PTR(-EOPNOTSUPP);
-		domain = mock_domain_alloc_paging(NULL);
+		domain = mock_domain_alloc_paging(dev);
 		if (!domain)
 			return ERR_PTR(-ENOMEM);
 		if (has_dirty_flag)
@@ -376,6 +383,9 @@ static int mock_domain_map_pages(struct iommu_domain *domain,
 
 			if (pgcount == 1 && cur + MOCK_IO_PAGE_SIZE == pgsize)
 				flags = MOCK_PFN_LAST_IOVA;
+			if (pgsize != MOCK_IO_PAGE_SIZE) {
+				flags |= MOCK_PFN_HUGE_IOVA;
+			}
 			old = xa_store(&mock->pfns, iova / MOCK_IO_PAGE_SIZE,
 				       xa_mk_value((paddr / MOCK_IO_PAGE_SIZE) |
 						   flags),
@@ -632,7 +642,8 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	struct mock_dev *mdev;
 	int rc;
 
-	if (dev_flags & ~(MOCK_FLAGS_DEVICE_NO_DIRTY))
+	if (dev_flags &
+	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
 		return ERR_PTR(-EINVAL);
 
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
-- 
2.17.2

