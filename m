Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8038DD3
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486094; cv=none; b=Svp0FpBx5gpqtX9nbqMYY4F5v/BzEI8mP4KnDE0irAfZlblkoJsiE6oMyR3JX1K6g3sSYazOGZtJyU3ZAYO5McVy7qPJofXj/i0k6y4tti44wru/NXPiPSFutY9s+5Y5vmfs5sWHhEso4BQhGy/DibHkc6ykncVcocyeBGzlyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486094; c=relaxed/simple;
	bh=Wo1GJ3P86cKFcEUQRubKk/B7XzYIiYjl/nvJFokDAso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTKacGz8c+9IZsh52C5dFidcJLI1eX+qO24m/zfHtRcIaCIs6h48/pqce2s/qugYxYrIp4CTdlA3qxrIaVGH0kbHn7OjzN+H4YEUE7pulHkuBfi8hE/Bf8KbXPxt9dC3/RY5cFmp/pyC3U0cVss3pZa8Qnr6XbIWZrhKk8lAmSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ibJKwKpo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ibJKwKpo"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tWlt028927;
	Thu, 27 Jun 2024 11:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=m
	KAunnO2a59ju2UqgERnb5MHQkdtAsgw6Xike4bH6Jw=; b=ibJKwKpoggUEXO/Uv
	5slOsmgxLVHSi/V/BYOD/xfesmKKD0x/OW+JAbsHx7TvGCsYoDGevIAlT1YH/D8G
	cIfZzyvS8aKhuoS1oSKZGD0fhTCmeKTWxyAL/rjqLkImCyqOqBbdwWkG9IgSIuZn
	39i2zMH+2sEZf4ooW5wFIbcjk7e5rRzMHnzQU+qqGeaRfNVYWNEz859fEJLtSaga
	3MwBt1k4qX3i5vCuhimSnywtDXHFtE3kd280VFPItTRQVK6RrmZOYcMBkzuL8dUB
	O5tVtt4SwMIHWdtcI6YQ2ac8A/Bs2G2N72T4VKXsizZkPJ9prImRlQow39kVJhP9
	ns5aQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t5th3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R9ZJ2Y023396;
	Thu, 27 Jun 2024 11:01:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grv7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:23 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KN3025281;
	Thu, 27 Jun 2024 11:01:23 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-2;
	Thu, 27 Jun 2024 11:01:22 +0000
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
Subject: [PATCH v2 01/11] iommufd/selftest: Fix dirty bitmap tests with u8 bitmaps
Date: Thu, 27 Jun 2024 12:00:55 +0100
Message-Id: <20240627110105.62325-2-joao.m.martins@oracle.com>
In-Reply-To: <20240627110105.62325-1-joao.m.martins@oracle.com>
References: <20240627110105.62325-1-joao.m.martins@oracle.com>
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
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=848
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-GUID: MF5nzHDf0vpdzFIhkUKiiO2BavoILib1
X-Proofpoint-ORIG-GUID: MF5nzHDf0vpdzFIhkUKiiO2BavoILib1

With 64k base pages, the first 128k iova length test requires less than a
byte for a bitmap, exposing a bug in the tests that assume that bitmaps are
at least a byte.

Rather than dealing with bytes, have _test_mock_dirty_bitmaps() pass the
number of bits. The caller functions are adjusted to also use bits as well,
and converting to bytes when clearing, allocating and freeing the bitmap.

Reported-by: Matt Ochs <mochs@nvidia.com>
Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 10 +++++-----
 tools/testing/selftests/iommu/iommufd_utils.h |  6 ++++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index edf1c99c9936..0b04d782a19f 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1722,6 +1722,7 @@ FIXTURE_VARIANT(iommufd_dirty_tracking)
 
 FIXTURE_SETUP(iommufd_dirty_tracking)
 {
+	unsigned long size;
 	int mmap_flags;
 	void *vrc;
 	int rc;
@@ -1749,12 +1750,11 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	assert(vrc == self->buffer);
 
 	self->page_size = MOCK_PAGE_SIZE;
-	self->bitmap_size =
-		variant->buffer_size / self->page_size / BITS_PER_BYTE;
+	self->bitmap_size = variant->buffer_size / self->page_size;
 
 	/* Provision with an extra (PAGE_SIZE) for the unaligned case */
-	rc = posix_memalign(&self->bitmap, PAGE_SIZE,
-			    self->bitmap_size + PAGE_SIZE);
+	size = DIV_ROUND_UP(self->bitmap_size, BITS_PER_BYTE);
+	rc = posix_memalign(&self->bitmap, PAGE_SIZE, size + PAGE_SIZE);
 	assert(!rc);
 	assert(self->bitmap);
 	assert((uintptr_t)self->bitmap % PAGE_SIZE == 0);
@@ -1775,7 +1775,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 FIXTURE_TEARDOWN(iommufd_dirty_tracking)
 {
 	munmap(self->buffer, variant->buffer_size);
-	munmap(self->bitmap, self->bitmap_size);
+	munmap(self->bitmap, DIV_ROUND_UP(self->bitmap_size, BITS_PER_BYTE));
 	teardown_iommufd(self->fd, _metadata);
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 8d2b46b2114d..c612fbf0195b 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -22,6 +22,8 @@
 #define BIT_MASK(nr) (1UL << ((nr) % __BITS_PER_LONG))
 #define BIT_WORD(nr) ((nr) / __BITS_PER_LONG)
 
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
 static inline void set_bit(unsigned int nr, unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
@@ -346,12 +348,12 @@ static int _test_cmd_mock_domain_set_dirty(int fd, __u32 hwpt_id, size_t length,
 static int _test_mock_dirty_bitmaps(int fd, __u32 hwpt_id, size_t length,
 				    __u64 iova, size_t page_size,
 				    size_t pte_page_size, __u64 *bitmap,
-				    __u64 bitmap_size, __u32 flags,
+				    __u64 nbits, __u32 flags,
 				    struct __test_metadata *_metadata)
 {
 	unsigned long npte = pte_page_size / page_size, pteset = 2 * npte;
-	unsigned long nbits = bitmap_size * BITS_PER_BYTE;
 	unsigned long j, i, nr = nbits / pteset ?: 1;
+	unsigned long bitmap_size = DIV_ROUND_UP(nbits, BITS_PER_BYTE);
 	__u64 out_dirty = 0;
 
 	/* Mark all even bits as dirty in the mock domain */
-- 
2.17.2

