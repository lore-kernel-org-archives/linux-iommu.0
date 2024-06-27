Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EC3136653
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486094; cv=none; b=pJMIXABTMQeRbQ01AgtbmRhUDKZ7Cw/nm4/E1PJVjFC/NZeb1iqPq00V68oLWEILpJ5y7L7rEO8gbA1MxEbeB6+RcJbmS3Qoaj7WeIvIwKuCpNUcJvfTi5NVjOxxprD3YbvIUBAEXrolu+yxvo5UC6t9ljDboGduIxECVFJMGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486094; c=relaxed/simple;
	bh=VUODP+PLMNLPZfhRHj7bCFMUmhcatYh44idEaD1CCrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJrMZHzaZ/0KXLOI8THxqsJwEIjuSi/u7hVs+uP2vkPIoqpsE0DMa5kIL0oGdUj6fpqmU7dsP4bU4ZgzgjL9kLBhCuuTrYkEbK6/gq7cO55WvN6wG7oNxPokNq8gG8k4ZYXI1Rq+8aoqFJ/0ZHAu2MV824XSJic7Cmv13ij2ogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HS/H8Va2; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HS/H8Va2"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tUAf028885;
	Thu, 27 Jun 2024 11:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=GRDk7eJB4MOvlP
	NSeeWsqVt7dmxuokcpxcIO2dMbcf8=; b=HS/H8Va2XCA5jjqEDSx6P3MaZTvKPx
	lmunkcOtnLAcquKAlH4sfs2j5DxlMyZwxA8s2GGhlglj5dGqE9+GteaQnkJp1xH0
	GePof73QrGbQIH4AeEerBRno1n3Lgla6ZSrOwHu1BwNN69nsIVUW5vLuIMbBWNdT
	31sxbcsjCOZR+LNWyKBZ2fxagJ2K2wQ9DIAykuqsc8m9yOEUhpBkD34An5q/ygv5
	9OqJptj/1gjWJqjq46LjREf0im7t8yjCJodnTyjocC3x/ne00q9u8oY4Tf3442Nj
	vhHoG+gMy2r4tNZbGyao16vJ++hTliiQyTfSwqGBlZQnf8wnuhEBVCZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t5th2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R9guis023390;
	Thu, 27 Jun 2024 11:01:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grv5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:20 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KN1025281;
	Thu, 27 Jun 2024 11:01:20 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-1;
	Thu, 27 Jun 2024 11:01:20 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Matt Ochs <mochs@nvidia.com>
Subject: [PATCH v2 00/11] iommufd/{iova_bitmap,selftest}: Fix dirty hugepages tracking and selftests
Date: Thu, 27 Jun 2024 12:00:54 +0100
Message-Id: <20240627110105.62325-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-27_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-GUID: 9Z72FSFCenbq9MS5W2QQALfVS2xjy7Tk
X-Proofpoint-ORIG-GUID: 9Z72FSFCenbq9MS5W2QQALfVS2xjy7Tk

---
Changes since v1:
* Adjust a sentence to be clearer on patch 5 (Kevin)
* Add Fixes tags to the last two patches.
* Fix current existing tests to use a MOCK_PAGE_SIZE (Kevin, new patch 4)
  Matt provided some testing feedback offlist on this selftest new patch
  with 64k base pages.
* Added review tags by Kevin in all patches except the new one
---
Hey,

This series purpose is to address what I thought was a complete fix[0].  It
also fixes arm64 64k base page cases that are broken right now with tiny
bitmap sizes (<= 128K IOVA ranges). It also makes selftest read_and_clear()
better iommu drivers and cover new bitmap sizes.

I go in details in the patch 9 but essentially over tons of live migrations
I find out two leftover issues that I failed to fix in my previous
series. The dirty case that that crosses iterations was indeed fixed by
[1], but it's the non dirty that was still generating issues:

a) Essentially, lack of alignment in iterations begin/end leads to checking
two times the same IOPTE for dirty bits reintroducing the 'partial
hugepage' check edge case. Though on big bitmaps (for a 1TB case which is
32MB bitmaps) the time taken pinning iterations can lead for the IOPTE
being dirty in the second time it is checked which makes it miss part of
the dirty page to be sent on the migration stream.

b) when we hit this hugepage represented across iterations we start
checking IOVAs being dirty slightly offsetted leading to set the wrong bits
when we find something dirty later on. This is only visible in >64G iova
ranges and PAGE_SIZE unaligned bitmaps.

The series is organized as:

* Patches 1-4: Fixes the 64k arm64 broken selftests and introduces two
more edge cases to cover the equivalent in 4k base pages. Lastly it
fixes buffer sizes to be based on MOCK_PAGE_SIZE for its size rather than
PAGE_SIZE.

* Patch 5: Fix selftest to match better the current iommu dirty
trackers, which was hiding the brokeness of (b) above. I have used the snip
below[*] to make sure all is passed, but I don't add it because testing
 >=64G takes longer than the selftests timeout tolerates. Furthermore this
is only relevant with the fixed window scheme which I remove in this series
and make it dynamic.

* Patches 6-10: Patches to prep for patch 9, that leads into removing
ithe partial hugepage represented across iterations that is self-induced.
upper layers not knowing what page size is for a given IOVA maps, but more
importantly because IOVA bitmaps deal with fixed 64G range passed into
read_and_clear(). To avoid further issues with this fixed scheme I redid
the fix and make it dynamic the iteration scheme i.e. pin the next 64G and
repin it everytime a dirty-size can't fit into the mapped pages without
requiring callers needing to work in a limited IOVA range (aka we can pass
read_and_clear() the whole thing and we pin the needed bitmap pages).
Additionally, because non dirty IOVA ranges don't need to get anything
pinned, it makes non-dirty cases very cheap as a bonus. I couldn't find a
measurable difference between dynamic vs fixed pinning, so I've removed it
in patch 10. It also makes the code simpler to follow & easier to maintain.
If folks agree with the approach I've taken here I can remove the callers
of iova_bitmap_for_each() in a follow-up cleanup series.

This series survives 1700 migrations of guests with applications doing RDMA
(which is roughly 3-days spent migration back and forth between hosts).
Additionally like the series in [1] I used a set of changes/tool to
exercise some dirty tracking tests but with real iommu drivers. Finally
tested >=64G IOMMU page sizes using this tool but with device-dax memory
(to generate >=64G contiguous RAM) to tackle the case of patch 9 when
iova_bitmap_set() gets called with enourmous page sizes that surprasse or
is equal to the maximum pin set of 64G.

Comments, review as usual appreciated.

	Joao

Joao Martins (11):
  iommufd/selftest: Fix dirty bitmap tests with u8 bitmaps
  iommufd/selftest: Fix iommufd_test_dirty() to handle <u8 bitmaps
  iommufd/selftest: Add tests for <= u8 bitmap sizes
  iommufd/selftest: Fix tests to use MOCK_PAGE_SIZE based buffer sizes
  iommufd/selftest: Do not record head iova to better match iommu drivers
  iommufd/iova_bitmap: Check iova_bitmap_done() after set ahead
  iommufd/iova_bitmap: Cache mapped length in iova_bitmap_map struct
  iommufd/iova_bitmap: Move initial pinning to iova_bitmap_for_each()
  iommufd/iova_bitmap: Consolidate iova_bitmap_set exit conditionals
  iommufd/iova_bitmap: Dynamic pinning on iova_bitmap_set()
  iommufd/iova_bitmap: Remove iterator logic

 drivers/iommu/iommufd/iova_bitmap.c           | 124 +++++++-----------
 drivers/iommu/iommufd/selftest.c              |   6 +-
 tools/testing/selftests/iommu/iommufd.c       |  64 +++++----
 tools/testing/selftests/iommu/iommufd_utils.h |   6 +-
 4 files changed, 97 insertions(+), 103 deletions(-)

[0] https://lore.kernel.org/linux-iommu/6b90f949-48da-4cb3-ad9a-ed54f1351a9a@oracle.com/
[1] https://lore.kernel.org/linux-iommu/20240202133415.23819-1-joao.m.martins@oracle.com/

[*] Adds 72G test and adds the offset=0x1 which exercises both (b)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index e854d3f67205..171d3e437356 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -26,7 +26,7 @@ enum {

 enum {
        MOCK_APERTURE_START = 1UL << 24,
-       MOCK_APERTURE_LAST = (1UL << 31) - 1,
+       MOCK_APERTURE_LAST = (1UL << 37) - 1,
 };

 enum {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 61189215e1ab..61770e31e66a 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1841,6 +1841,13 @@ FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty256M_huge)
        .hugepages = true,
 };

+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty72G_huge)
+{
+       /* 2304K bitmap (72G IOVA range) */
+       .buffer_size = 72 * 1024UL * 1024UL * 1024UL,
+       .hugepages = true,
+};
+
 TEST_F(iommufd_dirty_tracking, enforce_dirty)
 {
        uint32_t ioas_id, stddev_id, idev_id;
@@ -1898,7 +1905,7 @@ TEST_F(iommufd_dirty_tracking, device_dirty_capability)
        test_ioctl_destroy(hwpt_id);
 }
-TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
+TEST_F_TIMEOUT(iommufd_dirty_tracking, get_dirty_bitmap, 4095)
 {
        uint32_t page_size = MOCK_PAGE_SIZE;
        uint32_t hwpt_id;
@@ -1932,10 +1939,16 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
                                self->bitmap + 0xff1, self->bitmap_size, 0,
                                _metadata);

+       /* broken non-dirty page cross iterations (>= 64G tests) */
+       test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
+                               MOCK_APERTURE_START, self->page_size, page_size,
+                               self->bitmap + 0x1, self->bitmap_size, 0,
+                               _metadata);
+
        test_ioctl_destroy(hwpt_id);
 }

-TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_no_clear)
+TEST_F_TIMEOUT(iommufd_dirty_tracking, get_dirty_bitmap_no_clear, 4095)
 {
        uint32_t page_size = MOCK_PAGE_SIZE;
        uint32_t hwpt_id;
@@ -1967,13 +1980,20 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_no_clear)
                                IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
                                _metadata);

-       /* u64 unaligned bitmap */
+       /* u8 unaligned bitmap */
        test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
                                MOCK_APERTURE_START, self->page_size, page_size,
                                self->bitmap + 0xff1, self->bitmap_size,
                                IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
                                _metadata);

+       /* broken non-dirty page cross iterations (>= 64G tests) */
+       test_mock_dirty_bitmaps(hwpt_id, variant->buffer_size,
+                               MOCK_APERTURE_START, self->page_size, page_size,
+                               self->bitmap + 0x1, self->bitmap_size,
+                               IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
+                               _metadata);
+
        test_ioctl_destroy(hwpt_id);
 }

-- 
2.17.2


