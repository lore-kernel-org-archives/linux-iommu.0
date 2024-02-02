Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2F46544
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880916; cv=none; b=pxPSWqFQAZXTFRilEttL9Vrr2xECOVf9bgsnYPwvsmap+X/+a/djTJe2ymFJeKFYY81XEKT8THeNYYhELqosbpgcDEyKSSteRK0t/3ZJfZgBX59tN+uFd12Cmqfb0T7NwUXy8gMkKUAjFr41Joo+8wFVNRtTXiu/3/+I+8UXDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880916; c=relaxed/simple;
	bh=dtgcAFpqRTIaS5rlY3LI68hMROjGKmmnjxRRHTKM1Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhJ4ya2WOgPeftXTRvLSl4gzsG8GIZqRRmExgn9PwKRZ5MBwllVyd8QcLDippLbJw1Zemo39K8wC1xIURF/r7S+Ns5/VNbS1CWhZEDm8xcOfy8/AhovmmAY3FHo19+GdGNhlvrrLpoqN6MDiEKEjDdR92tbBdtCgYQLIryEDZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I0qNzvSG; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I0qNzvSG"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DQuAK013434;
	Fri, 2 Feb 2024 13:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=oVtKRvR6gpam24/b/sSEfv0lZ5RyWKDTrS47u5k9XdM=;
 b=I0qNzvSGdIhVIZ/FmrID8+EnpWB4x9jneKIldqB/XfH7qaXbFxvXADstxIvZcgt2DOEJ
 zGGLF+JkMT6auMxc3JhAMlxTZvB1mw3crli0qAX8+M77UWgdpkJRu1i3uekD6d/4hyMV
 AEQa46kwm0soasy5wJnHe5LlltBaW7ZlnUEgsBzXq0lY61+k+QK8bQuO4WWY2KlEBtpu
 DDBiWscAv04ci+goylSyCwwa+I9r1YJ4K3pRhzmA2pR1LO++FJx259bbgcB9onVw80ew
 GRSG8eXst+kzqrSrf7Uy485gFvqXUjxEJp/r4dYWfUmi+a5zkLeGU+p1AVDABNm6FTvp tA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm47jdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412BT8xY024495;
	Fri, 2 Feb 2024 13:35:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9buf3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:01 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DWmAl022185;
	Fri, 2 Feb 2024 13:35:01 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-220-219.vpn.oracle.com [10.175.220.219])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9buewt-4;
	Fri, 02 Feb 2024 13:35:00 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 3/9] iommufd/selftest: Test u64 unaligned bitmaps
Date: Fri,  2 Feb 2024 13:34:09 +0000
Message-Id: <20240202133415.23819-4-joao.m.martins@oracle.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=849 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020099
X-Proofpoint-GUID: _Wd3Td1FfHr5Eo25dx_XPMAYCA1sqSB3
X-Proofpoint-ORIG-GUID: _Wd3Td1FfHr5Eo25dx_XPMAYCA1sqSB3

Exercise the dirty tracking bitmaps with byte unaligned addresses in
addition to the PAGE_SIZE unaligned bitmaps, using a address towards the
end of the page boundary.

In doing so, increase the tailroom we allocate for the bitmap from
MOCK_PAGE_SIZE(2K) into PAGE_SIZE(4K), such that we can test end of bitmap
boundary.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 tools/testing/selftests/iommu/iommufd.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1a881e7a21d1..49774a720314 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1741,9 +1741,9 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	self->bitmap_size =
 		variant->buffer_size / self->page_size / BITS_PER_BYTE;
 
-	/* Provision with an extra (MOCK_PAGE_SIZE) for the unaligned case */
+	/* Provision with an extra (PAGE_SIZE) for the unaligned case */
 	rc = posix_memalign(&self->bitmap, PAGE_SIZE,
-			    self->bitmap_size + MOCK_PAGE_SIZE);
+			    self->bitmap_size + PAGE_SIZE);
 	assert(!rc);
 	assert(self->bitmap);
 	assert((uintptr_t)self->bitmap % PAGE_SIZE == 0);
@@ -1873,6 +1873,13 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
 				self->bitmap + MOCK_PAGE_SIZE,
 				self->bitmap_size, 0, _metadata);
 
+	/* u64 unaligned bitmap */
+	test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
+				MOCK_APERTURE_START, self->page_size,
+				self->bitmap + 0xff1,
+				self->bitmap_size, 0, _metadata);
+
+
 	test_ioctl_destroy(stddev_id);
 	test_ioctl_destroy(hwpt_id);
 }
@@ -1907,6 +1914,14 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_no_clear)
 				IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
 				_metadata);
 
+	/* u64 unaligned bitmap */
+	test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
+				MOCK_APERTURE_START, self->page_size,
+				self->bitmap + 0xff1,
+				self->bitmap_size,
+				IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
+				_metadata);
+
 	test_ioctl_destroy(stddev_id);
 	test_ioctl_destroy(hwpt_id);
 }
-- 
2.17.2

