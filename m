Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827F1DCB33
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321214; cv=none; b=i1yXoKZJf4uIFL16QFLf/Sui9ocr+QF+uL1ZMlzHO0YL+I5uMBsqd63qw6I8zyJj/ERRhG+SoJAHcol7waxxVS4SVIMP/uYUBqNpuSoGqPq+ai9Xru2zUkhXdfOuPj039qhH9MaBf8lccXhQSeKeudTiW2Nfej2s/dcPhwrYHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321214; c=relaxed/simple;
	bh=3VwA3CTHuxvWdX+HsBnZV0W7CRRACsYyZttiJ3cd+FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=toe0ZDkKrXeWxZDSV8kx0LxCzfIyxlV0umM5qEzmKz+biQY+ldR9lFYTwkzUuEQvHr5DjsBw0d/NcvdE25TuW/lp/gA3X8U0mPh/JHbFfoJEig0O9WgsEcZJwsVDXEARBsPzvXfM+YYY8+aN0aF/wlMbP6F9Dy8XHrKMo3xIhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NmyZC1iY; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NmyZC1iY"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMdKb005106;
	Mon, 7 Oct 2024 17:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=7dhkWynB/04lAJ6ZC2+qr0vhm9QBYXJN/dWDao7obAo=; b=
	NmyZC1iYlF1el2GrNTezCR54l1qLv8gnm4oVeVXeHr3Kcv/FtjO09Otj1+0k7IDX
	WWEBS2l0eW4q+MMkzgCSNAqNeSn6qfS8B080Vo0+CufKQmF7RqFwo5AsAFfYwkTn
	pDaZ8E1tMsBrveYKq4jk+orsbazj/HaIbmOsDPzDYe633SYrLetW4znx1wqnLJGC
	+jbEwzSpIgTR853xiw/ViKByFbNmpJzOUcTGk0kVo1+Rjuq7fLc/v17pJwlwofEi
	Px4BCY0a785J7V+q96WDzEfoLQkBvIy3C66Ebh7H3XELqq9pQPGsURVQ3rOAHGWS
	EIMbQBqiMH5yx8meYKmliA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300duyr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:13:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497H3lib004627;
	Mon, 7 Oct 2024 17:13:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw63f4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:13:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 497HAoJA003812;
	Mon, 7 Oct 2024 17:13:29 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uw63f0s-5;
	Mon, 07 Oct 2024 17:13:29 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 4/4] iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest
Date: Mon,  7 Oct 2024 10:13:23 -0700
Message-Id: <1728321203-189608-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
References: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_10,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070121
X-Proofpoint-GUID: itupMP6exCHrU1Y9x5dokJCpPvMQbDRf
X-Proofpoint-ORIG-GUID: itupMP6exCHrU1Y9x5dokJCpPvMQbDRf
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add selftest cases for IOMMU_IOAS_CHANGE_PROCESS.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tools/testing/selftests/iommu/Makefile        |   1 +
 tools/testing/selftests/iommu/iommufd.c       | 148 ++++++++++++++++++++++++--
 tools/testing/selftests/iommu/iommufd_utils.h |  34 +++---
 3 files changed, 163 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index fd64779..bd23ac9 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
+CFLAGS += -lcap
 
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 98c9f80..648deb9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -5,6 +5,7 @@
 #include <sys/eventfd.h>
 #include <sys/syscall.h>
 #include <asm/unistd.h>
+#include <sys/capability.h>
 
 #define __EXPORTED_HEADERS__
 #include <linux/vfio.h>
@@ -215,6 +216,144 @@ static __attribute__((constructor)) void setup_sizes(void)
 	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
 }
 
+static void drop_cap_ipc_lock(struct __test_metadata *_metadata)
+{
+	cap_t caps;
+	cap_value_t cap_list[1] = { CAP_IPC_LOCK };
+
+	caps = cap_get_proc();
+	ASSERT_NE(caps, NULL);
+	ASSERT_NE(-1,
+		  cap_set_flag(caps, CAP_EFFECTIVE, 1, cap_list, CAP_CLEAR));
+	ASSERT_NE(-1, cap_set_proc(caps));
+	cap_free(caps);
+}
+
+static long get_proc_status_value(pid_t pid, const char *var)
+{
+	FILE *fp;
+	char buf[80], tag[80];
+	long val = -1;
+
+	snprintf(buf, sizeof(buf), "/proc/%d/status", pid);
+	fp = fopen(buf, "r");
+	if (!fp)
+		return val;
+
+	while (fgets(buf, sizeof(buf), fp))
+		if (fscanf(fp, "%s %ld\n", tag, &val) == 2 && !strcmp(tag, var))
+			break;
+
+	fclose(fp);
+	return val;
+}
+
+static long get_vm_pinned(pid_t pid)
+{
+	return get_proc_status_value(pid, "VmPin:");
+}
+
+static long get_vm_locked(pid_t pid)
+{
+	return get_proc_status_value(pid, "VmLck:");
+}
+
+FIXTURE(change_process)
+{
+	int fd;
+	uint32_t ioas_id;
+};
+
+FIXTURE_VARIANT(change_process)
+{
+	int accounting;
+};
+
+FIXTURE_SETUP(change_process)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+
+	drop_cap_ipc_lock(_metadata);
+	if (variant->accounting != IOPT_PAGES_ACCOUNT_NONE) {
+		struct iommu_option set_limit_cmd = {
+			.size = sizeof(set_limit_cmd),
+			.option_id = IOMMU_OPTION_RLIMIT_MODE,
+			.op = IOMMU_OPTION_OP_SET,
+			.val64 = (variant->accounting == IOPT_PAGES_ACCOUNT_MM),
+		};
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &set_limit_cmd));
+	}
+
+	test_ioctl_ioas_alloc(&self->ioas_id);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
+}
+
+FIXTURE_TEARDOWN(change_process)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(change_process, account_none)
+{
+	.accounting = IOPT_PAGES_ACCOUNT_NONE,
+};
+
+FIXTURE_VARIANT_ADD(change_process, account_user)
+{
+	.accounting = IOPT_PAGES_ACCOUNT_USER,
+};
+
+FIXTURE_VARIANT_ADD(change_process, account_mm)
+{
+	.accounting = IOPT_PAGES_ACCOUNT_MM,
+};
+
+TEST_F(change_process, basic)
+{
+	pid_t parent = getpid();
+	pid_t child;
+	__u64 iova;
+	struct iommu_ioas_change_process cmd = {
+		.size = sizeof(cmd),
+	};
+
+	/* Expect failure if non-file maps exist */
+	test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_IOAS_CHANGE_PROCESS, &cmd));
+	test_ioctl_ioas_unmap(iova, PAGE_SIZE);
+
+	/* Change process works in current process. */
+	test_ioctl_ioas_map_file(mfd, 0, PAGE_SIZE, &iova);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_CHANGE_PROCESS, &cmd));
+
+	/* Change process works in another process */
+	child = fork();
+	if (!child) {
+		int nlock = PAGE_SIZE / 1024;
+
+		/* Parent accounts for locked memory before */
+		ASSERT_EQ(nlock, get_vm_pinned(parent));
+		if (variant->accounting == IOPT_PAGES_ACCOUNT_MM)
+			ASSERT_EQ(nlock, get_vm_locked(parent));
+		ASSERT_EQ(0, get_vm_pinned(getpid()));
+		ASSERT_EQ(0, get_vm_locked(getpid()));
+
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_CHANGE_PROCESS, &cmd));
+
+		/* Child accounts for locked memory after */
+		ASSERT_EQ(0, get_vm_pinned(parent));
+		ASSERT_EQ(0, get_vm_locked(parent));
+		ASSERT_EQ(nlock, get_vm_pinned(getpid()));
+		if (variant->accounting == IOPT_PAGES_ACCOUNT_MM)
+			ASSERT_EQ(nlock, get_vm_locked(getpid()));
+
+		exit(0);
+	}
+	ASSERT_NE(-1, child);
+	ASSERT_EQ(child, waitpid(child, NULL, 0));
+}
+
 FIXTURE(iommufd_ioas)
 {
 	int fd;
@@ -1548,13 +1687,10 @@ static void check_access_rw(struct __test_metadata *_metadata, int fd,
 	buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd_tmp);
 	ASSERT_NE(MAP_FAILED, buf);
 
-	/* EFAULT half way through mapping */
-	ASSERT_EQ(0, munmap(buf + buf_size / 2, buf_size / 2));
-	test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
+	test_err_ioctl_ioas_map_file(EINVAL, mfd_tmp, 0, buf_size + 1, &iova);
 
-	/* EFAULT on first page */
-	ASSERT_EQ(0, munmap(buf, buf_size / 2));
-	test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
+	ASSERT_EQ(0, ftruncate(mfd_tmp, 0));
+	test_err_ioctl_ioas_map_file(EINVAL, mfd_tmp, 0, buf_size, &iova);
 
 	close(mfd_tmp);
 }
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 7bc664e..b5bf1c7 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -22,6 +22,12 @@
 #define BIT_MASK(nr) (1UL << ((nr) % __BITS_PER_LONG))
 #define BIT_WORD(nr) ((nr) / __BITS_PER_LONG)
 
+enum {
+	IOPT_PAGES_ACCOUNT_NONE = 0,
+	IOPT_PAGES_ACCOUNT_USER = 1,
+	IOPT_PAGES_ACCOUNT_MM = 2,
+};
+
 #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 
 static inline void set_bit(unsigned int nr, unsigned long *addr)
@@ -612,23 +618,23 @@ static int _test_ioctl_ioas_map_file(int fd, unsigned int ioas_id, int mfd,
 }
 
 #define test_ioctl_ioas_map_file(mfd, start, length, iova_p)                 \
-	ASSERT_EQ(0, _test_ioctl_ioas_map_file(self->fd, self->ioas_id, mfd, \
-					       start, length, iova_p,        \
-					       IOMMU_IOAS_MAP_WRITEABLE |    \
-						   IOMMU_IOAS_MAP_READABLE))
+	ASSERT_EQ(0,							     \
+		  _test_ioctl_ioas_map_file(				     \
+			self->fd, self->ioas_id, mfd, start, length, iova_p, \
+			IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
 
-#define test_err_ioctl_ioas_map_file(_errno, start, length, iova_p)	     \
-	EXPECT_ERRNO(_errno,                                                 \
-		     _test_ioctl_ioas_map_file(self->fd, self->ioas_id, mfd, \
-					       start, length, iova_p,        \
-					       IOMMU_IOAS_MAP_WRITEABLE |    \
-						   IOMMU_IOAS_MAP_READABLE))
+#define test_err_ioctl_ioas_map_file(_errno, mfd, start, length, iova_p)     \
+	EXPECT_ERRNO(							     \
+		_errno,							     \
+		_test_ioctl_ioas_map_file(				     \
+			self->fd, self->ioas_id, mfd, start, length, iova_p, \
+			IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
 
 #define test_ioctl_ioas_map_id_file(ioas_id, mfd, start, length, iova_p)     \
-	ASSERT_EQ(0, _test_ioctl_ioas_map_file(self->fd, ioas_id, mfd,       \
-					  start, length, iova_p,             \
-					  IOMMU_IOAS_MAP_WRITEABLE |         \
-						  IOMMU_IOAS_MAP_READABLE))
+	ASSERT_EQ(0,							     \
+		  _test_ioctl_ioas_map_file(				     \
+			self->fd, ioas_id, mfd, start, length, iova_p,	     \
+			IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
 
 static int _test_ioctl_set_temp_memory_limit(int fd, unsigned int limit)
 {
-- 
1.8.3.1

