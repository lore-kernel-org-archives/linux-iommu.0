Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D3205AD1
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286870; cv=none; b=Lkim2dyjvLuc83HF5wGl9oz0pVMmdZ7nxsOaj+IVGG/YSsaLox2XVm+13E1bfivNDwjiQ7AUfD5GeyAtp00Kp39zLyxJSBOWgMLA3QQrd9BFcnAYEsMv9VKSiUYTLyQcb0jDLHzX63fVBlJ+pb/exTWUPZzZ2CUa6LLffrGVeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286870; c=relaxed/simple;
	bh=xnNSrhn6YkqFB3VBNpVKRCF4ANJnpGZ756ekAl8TenQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LiY7eTu2wloZDWUJgVpGptsmwKXVZ7sanDSYMiP5p/Wac3qQRdUa21R2pNGBMWOy69q0dmfMfBQJw57L9VJpSpcWGNq6LQ6OH+dersjM+if6lMq56/Rft/9WGMp4M9pA2TFWz1rpl/ZzMArc2mH95YyYDxaxxW8Z2bKB+HbCmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZnkLjrEa; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZnkLjrEa"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBf0d015495;
	Fri, 18 Oct 2024 21:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=tYC+UFll2lh6Kw3ARqMJCOgUvd8oUBtFSxpeDkXv/+g=; b=
	ZnkLjrEa5RjLcHhrZc/i1rh0pZ0k5Vd7xRM2eaiQYzytfvb1N+Qj4JF05ksB3ODO
	/DrGwmgi6+Yh83h0TGhqBuLRhyfV4obhnxqn/3ntM2Upz8GxoChW+6wxDsDGpho1
	5Woi7oewPGOG++sBQExScWq2jBKBh9Fng9Na6w+wB1b2xr7rlTBNlr9rS5wpgIjw
	xK6q+zGwzjmR1LEbFClKJFlQXbh+31W5PGOT8/1D2ff8I7AxIcuFM/WhG7bri83Z
	AL20PAyWQ5HVwvBqfifmA3n4+yZjX6ozJM0xh1lu4nGSzNOtap3fTNBQT3cg+ok9
	bhjAJN/Vhz/NPD/lQ8BopA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7st8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IJ54hP027117;
	Fri, 18 Oct 2024 21:27:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjq9ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ILRcVr023093;
	Fri, 18 Oct 2024 21:27:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjjq9r5-10;
	Fri, 18 Oct 2024 21:27:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 9/9] iommufd: map file selftest
Date: Fri, 18 Oct 2024 14:27:36 -0700
Message-Id: <1729286856-127844-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180137
X-Proofpoint-ORIG-GUID: 1_Aa_47xBaDBGtL2POzqOLp0xmbR_Rrt
X-Proofpoint-GUID: 1_Aa_47xBaDBGtL2POzqOLp0xmbR_Rrt
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add test cases to exercise IOMMU_IOAS_MAP_FILE.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 151 +++++++++++++++++++++++---
 tools/testing/selftests/iommu/iommufd_utils.h |  41 +++++++
 2 files changed, 177 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 4927b9a..3525670 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3,6 +3,8 @@
 #include <stdlib.h>
 #include <sys/mman.h>
 #include <sys/eventfd.h>
+#include <sys/syscall.h>
+#include <asm/unistd.h>
 
 #define __EXPORTED_HEADERS__
 #include <linux/vfio.h>
@@ -10,6 +12,8 @@
 #include "iommufd_utils.h"
 
 static unsigned long HUGEPAGE_SIZE;
+static void *mfd_buffer;
+static int mfd;
 
 #define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
 #define MOCK_HUGE_PAGE_SIZE (512 * MOCK_PAGE_SIZE)
@@ -33,6 +37,19 @@ static unsigned long get_huge_page_size(void)
 	return strtoul(buf, NULL, 10);
 }
 
+static void *memfd_mmap(size_t length, int prot, int flags, int *mfd_p)
+{
+	int mfd_flags = (flags & MAP_HUGETLB) ? MFD_HUGETLB : 0;
+	int mfd = memfd_create("buffer", mfd_flags);
+
+	if (mfd <= 0)
+		return MAP_FAILED;
+	if (ftruncate(mfd, length))
+		return MAP_FAILED;
+	*mfd_p = mfd;
+	return mmap(0, length, prot, flags, mfd, 0);
+}
+
 static __attribute__((constructor)) void setup_sizes(void)
 {
 	void *vrc;
@@ -49,6 +66,9 @@ static __attribute__((constructor)) void setup_sizes(void)
 	vrc = mmap(buffer, BUFFER_SIZE, PROT_READ | PROT_WRITE,
 		   MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
 	assert(vrc == buffer);
+
+	mfd_buffer = memfd_mmap(BUFFER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
+				&mfd);
 }
 
 FIXTURE(iommufd)
@@ -1372,6 +1392,7 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 {
 	unsigned int mock_domains;
 	bool hugepages;
+	bool file;
 };
 
 FIXTURE_SETUP(iommufd_mock_domain)
@@ -1410,26 +1431,45 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 {
 	.mock_domains = 1,
 	.hugepages = false,
+	.file = false,
 };
 
 FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains)
 {
 	.mock_domains = 2,
 	.hugepages = false,
+	.file = false,
 };
 
 FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_hugepage)
 {
 	.mock_domains = 1,
 	.hugepages = true,
+	.file = false,
 };
 
 FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains_hugepage)
 {
 	.mock_domains = 2,
 	.hugepages = true,
+	.file = false,
 };
 
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_file)
+{
+	.mock_domains = 1,
+	.hugepages = false,
+	.file = true,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_file_hugepage)
+{
+	.mock_domains = 1,
+	.hugepages = true,
+	.file = true,
+};
+
+
 /* Have the kernel check that the user pages made it to the iommu_domain */
 #define check_mock_iova(_ptr, _iova, _length)                                \
 	({                                                                   \
@@ -1455,7 +1495,10 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 		}                                                            \
 	})
 
-TEST_F(iommufd_mock_domain, basic)
+static void
+test_basic_mmap(struct __test_metadata *_metadata,
+		struct _test_data_iommufd_mock_domain *self,
+		const struct _fixture_variant_iommufd_mock_domain *variant)
 {
 	size_t buf_size = self->mmap_buf_size;
 	uint8_t *buf;
@@ -1478,12 +1521,52 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 	test_err_ioctl_ioas_map(EFAULT, buf, buf_size, &iova);
 }
 
+static void
+test_basic_file(struct __test_metadata *_metadata,
+		struct _test_data_iommufd_mock_domain *self,
+		const struct _fixture_variant_iommufd_mock_domain *variant)
+{
+	size_t buf_size = self->mmap_buf_size;
+	uint8_t *buf;
+	__u64 iova;
+	int mfd_tmp;
+	int prot = PROT_READ | PROT_WRITE;
+
+	/* Simple one page map */
+	test_ioctl_ioas_map_file(mfd, 0, PAGE_SIZE, &iova);
+	check_mock_iova(mfd_buffer, iova, PAGE_SIZE);
+
+	buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd_tmp);
+	ASSERT_NE(MAP_FAILED, buf);
+
+	/* EFAULT half way through mapping */
+	ASSERT_EQ(0, munmap(buf + buf_size / 2, buf_size / 2));
+	test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
+
+	/* EFAULT on first page */
+	ASSERT_EQ(0, munmap(buf, buf_size / 2));
+	test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
+
+	close(mfd_tmp);
+}
+
+TEST_F(iommufd_mock_domain, basic)
+{
+	if (variant->file)
+		test_basic_file(_metadata, self, variant);
+	else
+		test_basic_mmap(_metadata, self, variant);
+}
+
 TEST_F(iommufd_mock_domain, ro_unshare)
 {
 	uint8_t *buf;
 	__u64 iova;
 	int fd;
 
+	if (variant->file)
+		SKIP(return, "redundant test");
+
 	fd = open("/proc/self/exe", O_RDONLY);
 	ASSERT_NE(-1, fd);
 
@@ -1513,9 +1596,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 	unsigned int start;
 	unsigned int end;
 	uint8_t *buf;
+	int prot = PROT_READ | PROT_WRITE;
+	int mfd;
 
-	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
-		   0);
+	if (variant->file)
+		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
+	else
+		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
 	ASSERT_NE(MAP_FAILED, buf);
 	check_refs(buf, buf_size, 0);
 
@@ -1532,7 +1619,12 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 			size_t length = end - start;
 			__u64 iova;
 
-			test_ioctl_ioas_map(buf + start, length, &iova);
+			if (variant->file) {
+				test_ioctl_ioas_map_file(mfd, start, length,
+							 &iova);
+			} else {
+				test_ioctl_ioas_map(buf + start, length, &iova);
+			}
 			check_mock_iova(buf + start, iova, length);
 			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
 				   end / PAGE_SIZE * PAGE_SIZE -
@@ -1544,6 +1636,8 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 	}
 	check_refs(buf, buf_size, 0);
 	ASSERT_EQ(0, munmap(buf, buf_size));
+	if (variant->file)
+		close(mfd);
 }
 
 TEST_F(iommufd_mock_domain, all_aligns_copy)
@@ -1554,9 +1648,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 	unsigned int start;
 	unsigned int end;
 	uint8_t *buf;
+	int prot = PROT_READ | PROT_WRITE;
+	int mfd;
 
-	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
-		   0);
+	if (variant->file)
+		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
+	else
+		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
 	ASSERT_NE(MAP_FAILED, buf);
 	check_refs(buf, buf_size, 0);
 
@@ -1575,7 +1673,12 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 			uint32_t mock_stdev_id;
 			__u64 iova;
 
-			test_ioctl_ioas_map(buf + start, length, &iova);
+			if (variant->file) {
+				test_ioctl_ioas_map_file(mfd, start, length,
+							 &iova);
+			} else {
+				test_ioctl_ioas_map(buf + start, length, &iova);
+			}
 
 			/* Add and destroy a domain while the area exists */
 			old_id = self->hwpt_ids[1];
@@ -1596,15 +1699,18 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 	}
 	check_refs(buf, buf_size, 0);
 	ASSERT_EQ(0, munmap(buf, buf_size));
+	if (variant->file)
+		close(mfd);
 }
 
 TEST_F(iommufd_mock_domain, user_copy)
 {
+	void *buf = variant->file ? mfd_buffer : buffer;
 	struct iommu_test_cmd access_cmd = {
 		.size = sizeof(access_cmd),
 		.op = IOMMU_TEST_OP_ACCESS_PAGES,
 		.access_pages = { .length = BUFFER_SIZE,
-				  .uptr = (uintptr_t)buffer },
+				  .uptr = (uintptr_t)buf },
 	};
 	struct iommu_ioas_copy copy_cmd = {
 		.size = sizeof(copy_cmd),
@@ -1623,9 +1729,13 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 
 	/* Pin the pages in an IOAS with no domains then copy to an IOAS with domains */
 	test_ioctl_ioas_alloc(&ioas_id);
-	test_ioctl_ioas_map_id(ioas_id, buffer, BUFFER_SIZE,
-			       &copy_cmd.src_iova);
-
+	if (variant->file) {
+		test_ioctl_ioas_map_id_file(ioas_id, mfd, 0, BUFFER_SIZE,
+					    &copy_cmd.src_iova);
+	} else {
+		test_ioctl_ioas_map_id(ioas_id, buf, BUFFER_SIZE,
+				       &copy_cmd.src_iova);
+	}
 	test_cmd_create_access(ioas_id, &access_cmd.id,
 			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
 
@@ -1635,12 +1745,17 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 			&access_cmd));
 	copy_cmd.src_ioas_id = ioas_id;
 	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
-	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
+	check_mock_iova(buf, MOCK_APERTURE_START, BUFFER_SIZE);
 
 	/* Now replace the ioas with a new one */
 	test_ioctl_ioas_alloc(&new_ioas_id);
-	test_ioctl_ioas_map_id(new_ioas_id, buffer, BUFFER_SIZE,
-			       &copy_cmd.src_iova);
+	if (variant->file) {
+		test_ioctl_ioas_map_id_file(new_ioas_id, mfd, 0, BUFFER_SIZE,
+					    &copy_cmd.src_iova);
+	} else {
+		test_ioctl_ioas_map_id(new_ioas_id, buf, BUFFER_SIZE,
+				       &copy_cmd.src_iova);
+	}
 	test_cmd_access_replace_ioas(access_cmd.id, new_ioas_id);
 
 	/* Destroy the old ioas and cleanup copied mapping */
@@ -1654,7 +1769,7 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 			&access_cmd));
 	copy_cmd.src_ioas_id = new_ioas_id;
 	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
-	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
+	check_mock_iova(buf, MOCK_APERTURE_START, BUFFER_SIZE);
 
 	test_cmd_destroy_access_pages(
 		access_cmd.id, access_cmd.access_pages.out_access_pages_id);
@@ -1667,6 +1782,9 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 {
 	uint32_t ioas_id;
 
+	if (variant->file)
+		SKIP(return, "redundant test");
+
 	test_ioctl_ioas_alloc(&ioas_id);
 
 	test_cmd_mock_domain_replace(self->stdev_ids[0], ioas_id);
@@ -1697,6 +1815,9 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 {
 	int i;
 
+	if (variant->file)
+		SKIP(return, "redundant test");
+
 	for (i = 0; i != variant->mock_domains; i++) {
 		uint32_t hwpt_id[2];
 		uint32_t stddev_id;
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 40f6f14..7bc664e 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -589,6 +589,47 @@ static int _test_ioctl_ioas_unmap(int fd, unsigned int ioas_id, uint64_t iova,
 	EXPECT_ERRNO(_errno, _test_ioctl_ioas_unmap(self->fd, self->ioas_id, \
 						    iova, length, NULL))
 
+static int _test_ioctl_ioas_map_file(int fd, unsigned int ioas_id, int mfd,
+				     size_t start, size_t length, __u64 *iova,
+				     unsigned int flags)
+{
+	struct iommu_ioas_map_file cmd = {
+		.size = sizeof(cmd),
+		.flags = flags,
+		.ioas_id = ioas_id,
+		.fd = mfd,
+		.start = start,
+		.length = length,
+	};
+	int ret;
+
+	if (flags & IOMMU_IOAS_MAP_FIXED_IOVA)
+		cmd.iova = *iova;
+
+	ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &cmd);
+	*iova = cmd.iova;
+	return ret;
+}
+
+#define test_ioctl_ioas_map_file(mfd, start, length, iova_p)                 \
+	ASSERT_EQ(0, _test_ioctl_ioas_map_file(self->fd, self->ioas_id, mfd, \
+					       start, length, iova_p,        \
+					       IOMMU_IOAS_MAP_WRITEABLE |    \
+						   IOMMU_IOAS_MAP_READABLE))
+
+#define test_err_ioctl_ioas_map_file(_errno, start, length, iova_p)	     \
+	EXPECT_ERRNO(_errno,                                                 \
+		     _test_ioctl_ioas_map_file(self->fd, self->ioas_id, mfd, \
+					       start, length, iova_p,        \
+					       IOMMU_IOAS_MAP_WRITEABLE |    \
+						   IOMMU_IOAS_MAP_READABLE))
+
+#define test_ioctl_ioas_map_id_file(ioas_id, mfd, start, length, iova_p)     \
+	ASSERT_EQ(0, _test_ioctl_ioas_map_file(self->fd, ioas_id, mfd,       \
+					  start, length, iova_p,             \
+					  IOMMU_IOAS_MAP_WRITEABLE |         \
+						  IOMMU_IOAS_MAP_READABLE))
+
 static int _test_ioctl_set_temp_memory_limit(int fd, unsigned int limit)
 {
 	struct iommu_test_cmd memlimit_cmd = {
-- 
1.8.3.1

