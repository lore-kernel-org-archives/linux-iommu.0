Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064E1E4A6
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880927; cv=none; b=UpoRggRzgWB/eF1xlXzaC356+/RsmhNDKUWGrdndmq0JAPWuofXmH/B3A5VhmM/KhDwsFSWHHMj4neuKb6GVV0IO+96YYj9k/teaFSHtnrMKP7tSFX/5QgPybvDdh1E1NpAxg3a43pTqAEOE6H8v7zrmjiXxkgDOKRwWNFbXrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880927; c=relaxed/simple;
	bh=SFqIGI/t39PG4lrbx6itZU0WGVy1Z4+FksCip1AAtm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpt8qpeN/XjeB3vNlE6d/RC37Qxviua0AV8Kh7DSZNh5ehhgRVt0v0IzymPGDs6TAqkBppnOlNagdPvkw0I6Jts7Q5jQjt5H5h2dkuOa74EusIwqibOO1YJ3J0gYlRH9oP8u6Ot27JVYBSMAL4TwCrWL8KqTUCu+91ubU67reZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CA4VEjMT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CA4VEjMT"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DQn1l010564;
	Fri, 2 Feb 2024 13:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=Se/X/TGt8QyFNN8/we27cD9zf4Q2OSwzWhF7cVmqnWE=;
 b=CA4VEjMTYy31Jzc6aoT71P//ed+oE6+QNwzNvk/W6QKMEaPR5IyLo9GMHTo8uzd1FHrf
 NIdvLvXQRR4CUqc7vpKp5GQZbmSEpjzzk8uIS3hV5fabmWbCOBV7r5sEjoZgFfWgwzjg
 r2oNKhYz9VIlpywVkkfaPPXg7r/IMZSwKrogZAM5OqUCpwTE/DqCLnYxKJziqq775ie3
 zPKom3fSdeJ1Msay1cpV7Kp4Trts5n5jMTFwVTkbBNBo8dObkM3hJQ+EIK8zkQx9T2W5
 EMsI7aDq6obZu/R1jcke0VvTqJryCKlHvvsQa+FArI+Xcw6SFg3XHzI/InySJ0XCPDtQ jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcqp76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412DUrV5024519;
	Fri, 2 Feb 2024 13:35:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9bufdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:15 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DWmAv022185;
	Fri, 2 Feb 2024 13:35:14 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-220-219.vpn.oracle.com [10.175.220.219])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9buewt-9;
	Fri, 02 Feb 2024 13:35:14 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 8/9] iommufd/selftest: Add mock IO hugepages tests
Date: Fri,  2 Feb 2024 13:34:14 +0000
Message-Id: <20240202133415.23819-9-joao.m.martins@oracle.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=760 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020099
X-Proofpoint-ORIG-GUID: adv6NB44HpBvkrsUdJohyDlTb1dP-eVs
X-Proofpoint-GUID: adv6NB44HpBvkrsUdJohyDlTb1dP-eVs

Leverage previously added MOCK_FLAGS_DEVICE_HUGE_IOVA flag to create an
IOMMU domain with more than MOCK_IO_PAGE_SIZE supported.

Plumb the hugetlb backing memory for buffer allocation and change the
expected page size to MOCK_HUGE_PAGE_SIZE (1M) when hugepage variant test
cases are used. These so far are limited to 128M and 256M IOVA range tests
cases which is when 1M hugepages can be used.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 tools/testing/selftests/iommu/iommufd.c | 45 +++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 56c3e511a0ab..edf1c99c9936 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -12,6 +12,7 @@
 static unsigned long HUGEPAGE_SIZE;
 
 #define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
+#define MOCK_HUGE_PAGE_SIZE (512 * MOCK_PAGE_SIZE)
 
 static unsigned long get_huge_page_size(void)
 {
@@ -1716,10 +1717,12 @@ FIXTURE(iommufd_dirty_tracking)
 FIXTURE_VARIANT(iommufd_dirty_tracking)
 {
 	unsigned long buffer_size;
+	bool hugepages;
 };
 
 FIXTURE_SETUP(iommufd_dirty_tracking)
 {
+	int mmap_flags;
 	void *vrc;
 	int rc;
 
@@ -1732,9 +1735,17 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 			   variant->buffer_size, rc);
 	}
 
+	mmap_flags = MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED;
+	if (variant->hugepages) {
+		/*
+		 * MAP_POPULATE will cause the kernel to fail mmap if THPs are
+		 * not available.
+		 */
+		mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
+	}
 	assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
 	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
-		   MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+		   mmap_flags, -1, 0);
 	assert(vrc == self->buffer);
 
 	self->page_size = MOCK_PAGE_SIZE;
@@ -1749,8 +1760,16 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	assert((uintptr_t)self->bitmap % PAGE_SIZE == 0);
 
 	test_ioctl_ioas_alloc(&self->ioas_id);
-	test_cmd_mock_domain(self->ioas_id, &self->stdev_id, &self->hwpt_id,
-			     &self->idev_id);
+	/* Enable 1M mock IOMMU hugepages */
+	if (variant->hugepages) {
+		test_cmd_mock_domain_flags(self->ioas_id,
+					   MOCK_FLAGS_DEVICE_HUGE_IOVA,
+					   &self->stdev_id, &self->hwpt_id,
+					   &self->idev_id);
+	} else {
+		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
+				     &self->hwpt_id, &self->idev_id);
+	}
 }
 
 FIXTURE_TEARDOWN(iommufd_dirty_tracking)
@@ -1784,12 +1803,26 @@ FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128M)
 	.buffer_size = 128UL * 1024UL * 1024UL,
 };
 
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128M_huge)
+{
+	/* 4K bitmap (128M IOVA range) */
+	.buffer_size = 128UL * 1024UL * 1024UL,
+	.hugepages = true,
+};
+
 FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty256M)
 {
 	/* 8K bitmap (256M IOVA range) */
 	.buffer_size = 256UL * 1024UL * 1024UL,
 };
 
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty256M_huge)
+{
+	/* 8K bitmap (256M IOVA range) */
+	.buffer_size = 256UL * 1024UL * 1024UL,
+	.hugepages = true,
+};
+
 TEST_F(iommufd_dirty_tracking, enforce_dirty)
 {
 	uint32_t ioas_id, stddev_id, idev_id;
@@ -1853,6 +1886,9 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
 	uint32_t hwpt_id;
 	uint32_t ioas_id;
 
+	if (variant->hugepages)
+		page_size = MOCK_HUGE_PAGE_SIZE;
+
 	test_ioctl_ioas_alloc(&ioas_id);
 	test_ioctl_ioas_map_fixed_id(ioas_id, self->buffer,
 				     variant->buffer_size, MOCK_APERTURE_START);
@@ -1887,6 +1923,9 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_no_clear)
 	uint32_t hwpt_id;
 	uint32_t ioas_id;
 
+	if (variant->hugepages)
+		page_size = MOCK_HUGE_PAGE_SIZE;
+
 	test_ioctl_ioas_alloc(&ioas_id);
 	test_ioctl_ioas_map_fixed_id(ioas_id, self->buffer,
 				     variant->buffer_size, MOCK_APERTURE_START);
-- 
2.17.2

