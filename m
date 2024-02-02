Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FFB46426
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880914; cv=none; b=TJPB3dQocfDlccL/tuqRH+PH33Uz3uR9jcuCnq9fGPozxMkk/Ym8djn/S488pHK+DMo407Fq1SmpIBok4PuugLV0W4HI649xGfEPGy2ZkMnhzib1t4CYsWd1v6t/Dd46JVl6/D8zmSwnepQ/ouvY1Y+ro8uWNdk2IDPe18tJsuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880914; c=relaxed/simple;
	bh=hgc9mUvxnm9tpGSsyxuBEV7NCsCRQp5OCfcsK0J0cM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGlP7q4gQHYKfY0GEc2ntDlTJYqjgFV0o4qqGcx/m57VxTczzVGaUxY0pTbit23E0/1XBlW/y4fcE+kR6s/0B5KQHtdSyfigOtuQUQZ8DEsiz0rPPw0diCoBe3CQ/eAew+bPvJOcZycdWagJ9TxeyQSe/zG1u4W0N46CVc882Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L0vunVby; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L0vunVby"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DQoP3019851;
	Fri, 2 Feb 2024 13:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=AjnW0ua5XAHKx58BnnoT1ylMexYMP3d7EcmcQD77iCo=;
 b=L0vunVby6VM0njx1YlE1+2SeGEcybFY51MGI8SL3Rp0HqabOj8iz+6fKLx8ubk/1Ol3N
 ddBa9gFXAl4ybBWIHwtsdrWLlV3ub2K32rat+Zisfu65C0KxQzA6ctwFi0f6j3cOSLxU
 yzShqgn1te/BLLNNSXe3UVx4DgHdFlTLQ0thMKPHC2gcjufjj/NYqriW5Bmp13pSBrrz
 O5nf8GxH2Y/w5Q5NHTycHayjm1flE1NWKtvlFCcjgPg8DFo7qp2uShjFlJvKtay3UIJW
 1DLs/6xWh/rdOo3aNsHNDMitgPkZC7ZWjCPtWgoprk6t1/+BsbC1DNdok6cFUkOD97Nc dQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2qs35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412BT8GN024527;
	Fri, 2 Feb 2024 13:35:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9buf7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:06 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DWmAp022185;
	Fri, 2 Feb 2024 13:35:06 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-220-219.vpn.oracle.com [10.175.220.219])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9buewt-6;
	Fri, 02 Feb 2024 13:35:06 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 5/9] iommufd/selftest: Refactor dirty bitmap tests
Date: Fri,  2 Feb 2024 13:34:11 +0000
Message-Id: <20240202133415.23819-6-joao.m.martins@oracle.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=776 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020099
X-Proofpoint-GUID: gHB4dYAkql-r415IPLDHYL47XnDWCaXj
X-Proofpoint-ORIG-GUID: gHB4dYAkql-r415IPLDHYL47XnDWCaXj

Rework the functions that test and set the bitmaps to receive a new
parameter (the pte_page_size) that reflects the expected PTE size in the
page tables. The same scheme is still used i.e. even bits are dirty and odd
page indexes aren't dirty. Here it just refactors to consider the size of
the PTE rather than hardcoded to IOMMU mock base page assumptions.

While at it, refactor dirty bitmap tests to use the idev_id created by the
fixture instead of creating a new one.

This is in preparation for doing tests with IOMMU hugepages where multiple
bits set as part of recording a whole hugepage as dirty and thus the
pte_page_size will vary depending on io hugepages or io base pages.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 28 ++++++-------
 tools/testing/selftests/iommu/iommufd_utils.h | 39 ++++++++++++-------
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 49774a720314..56c3e511a0ab 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1849,7 +1849,7 @@ TEST_F(iommufd_dirty_tracking, device_dirty_capability)
 
 TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
 {
-	uint32_t stddev_id;
+	uint32_t page_size = MOCK_PAGE_SIZE;
 	uint32_t hwpt_id;
 	uint32_t ioas_id;
 
@@ -1859,34 +1859,31 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
 
 	test_cmd_hwpt_alloc(self->idev_id, ioas_id,
 			    IOMMU_HWPT_ALLOC_DIRTY_TRACKING, &hwpt_id);
-	test_cmd_mock_domain(hwpt_id, &stddev_id, NULL, NULL);
 
 	test_cmd_set_dirty_tracking(hwpt_id, true);
 
 	test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
-				MOCK_APERTURE_START, self->page_size,
+				MOCK_APERTURE_START, self->page_size, page_size,
 				self->bitmap, self->bitmap_size, 0, _metadata);
 
 	/* PAGE_SIZE unaligned bitmap */
 	test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
-				MOCK_APERTURE_START, self->page_size,
+				MOCK_APERTURE_START, self->page_size, page_size,
 				self->bitmap + MOCK_PAGE_SIZE,
 				self->bitmap_size, 0, _metadata);
 
 	/* u64 unaligned bitmap */
 	test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
-				MOCK_APERTURE_START, self->page_size,
-				self->bitmap + 0xff1,
-				self->bitmap_size, 0, _metadata);
-
+				MOCK_APERTURE_START, self->page_size, page_size,
+				self->bitmap + 0xff1, self->bitmap_size, 0,
+				_metadata);
 
-	test_ioctl_destroy(stddev_id);
 	test_ioctl_destroy(hwpt_id);
 }
 
 TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_no_clear)
 {
-	uint32_t stddev_id;
+	uint32_t page_size = MOCK_PAGE_SIZE;
 	uint32_t hwpt_id;
 	uint32_t ioas_id;
 
@@ -1896,19 +1893,18 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_no_clear)
 
 	test_cmd_hwpt_alloc(self->idev_id, ioas_id,
 			    IOMMU_HWPT_ALLOC_DIRTY_TRACKING, &hwpt_id);
-	test_cmd_mock_domain(hwpt_id, &stddev_id, NULL, NULL);
 
 	test_cmd_set_dirty_tracking(hwpt_id, true);
 
 	test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
-				MOCK_APERTURE_START, self->page_size,
+				MOCK_APERTURE_START, self->page_size, page_size,
 				self->bitmap, self->bitmap_size,
 				IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
 				_metadata);
 
 	/* Unaligned bitmap */
 	test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
-				MOCK_APERTURE_START, self->page_size,
+				MOCK_APERTURE_START, self->page_size, page_size,
 				self->bitmap + MOCK_PAGE_SIZE,
 				self->bitmap_size,
 				IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
@@ -1916,13 +1912,11 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_no_clear)
 
 	/* u64 unaligned bitmap */
 	test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
-				MOCK_APERTURE_START, self->page_size,
-				self->bitmap + 0xff1,
-				self->bitmap_size,
+				MOCK_APERTURE_START, self->page_size, page_size,
+				self->bitmap + 0xff1, self->bitmap_size,
 				IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
 				_metadata);
 
-	test_ioctl_destroy(stddev_id);
 	test_ioctl_destroy(hwpt_id);
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index c646264aa41f..8d2b46b2114d 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -344,16 +344,19 @@ static int _test_cmd_mock_domain_set_dirty(int fd, __u32 hwpt_id, size_t length,
 						  page_size, bitmap, nr))
 
 static int _test_mock_dirty_bitmaps(int fd, __u32 hwpt_id, size_t length,
-				    __u64 iova, size_t page_size, __u64 *bitmap,
+				    __u64 iova, size_t page_size,
+				    size_t pte_page_size, __u64 *bitmap,
 				    __u64 bitmap_size, __u32 flags,
 				    struct __test_metadata *_metadata)
 {
-	unsigned long i, nbits = bitmap_size * BITS_PER_BYTE;
-	unsigned long nr = nbits / 2;
+	unsigned long npte = pte_page_size / page_size, pteset = 2 * npte;
+	unsigned long nbits = bitmap_size * BITS_PER_BYTE;
+	unsigned long j, i, nr = nbits / pteset ?: 1;
 	__u64 out_dirty = 0;
 
 	/* Mark all even bits as dirty in the mock domain */
-	for (i = 0; i < nbits; i += 2)
+	memset(bitmap, 0, bitmap_size);
+	for (i = 0; i < nbits; i += pteset)
 		set_bit(i, (unsigned long *)bitmap);
 
 	test_cmd_mock_domain_set_dirty(fd, hwpt_id, length, iova, page_size,
@@ -365,8 +368,12 @@ static int _test_mock_dirty_bitmaps(int fd, __u32 hwpt_id, size_t length,
 	test_cmd_get_dirty_bitmap(fd, hwpt_id, length, iova, page_size, bitmap,
 				  flags);
 	/* Beware ASSERT_EQ() is two statements -- braces are not redundant! */
-	for (i = 0; i < nbits; i++) {
-		ASSERT_EQ(!(i % 2), test_bit(i, (unsigned long *)bitmap));
+	for (i = 0; i < nbits; i += pteset) {
+		for (j = 0; j < pteset; j++) {
+			ASSERT_EQ(j < npte,
+				  test_bit(i + j, (unsigned long *)bitmap));
+		}
+		ASSERT_EQ(!(i % pteset), test_bit(i, (unsigned long *)bitmap));
 	}
 
 	memset(bitmap, 0, bitmap_size);
@@ -374,19 +381,23 @@ static int _test_mock_dirty_bitmaps(int fd, __u32 hwpt_id, size_t length,
 				  flags);
 
 	/* It as read already -- expect all zeroes */
-	for (i = 0; i < nbits; i++) {
-		ASSERT_EQ(!(i % 2) && (flags &
-				       IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR),
-			  test_bit(i, (unsigned long *)bitmap));
+	for (i = 0; i < nbits; i += pteset) {
+		for (j = 0; j < pteset; j++) {
+			ASSERT_EQ(
+				(j < npte) &&
+					(flags &
+					 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR),
+				test_bit(i + j, (unsigned long *)bitmap));
+		}
 	}
 
 	return 0;
 }
-#define test_mock_dirty_bitmaps(hwpt_id, length, iova, page_size, bitmap,      \
-				bitmap_size, flags, _metadata)                 \
+#define test_mock_dirty_bitmaps(hwpt_id, length, iova, page_size, pte_size,\
+				bitmap, bitmap_size, flags, _metadata)     \
 	ASSERT_EQ(0, _test_mock_dirty_bitmaps(self->fd, hwpt_id, length, iova, \
-					      page_size, bitmap, bitmap_size,  \
-					      flags, _metadata))
+					      page_size, pte_size, bitmap,     \
+					      bitmap_size, flags, _metadata))
 
 static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 				   __u32 *access_id, unsigned int flags)
-- 
2.17.2

