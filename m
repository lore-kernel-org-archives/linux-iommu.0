Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF652185A6
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016026; cv=none; b=A6+0/3FYrPXN3RXWck/UYsrsuC1+HRXRv3Og/hJC10A4Bsf/xZD+Qi/zlrz5aZWoyFDEbM64ty8DSSCyMINUuRfUmAceAy5UhhRKof9Cj8IW89iQQUfsPI1A32GfMOpYww8AbFX3riOC9LXAd76MHYtimL9nh2BSbWX4berGIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016026; c=relaxed/simple;
	bh=Z+4CBuHmtMIaL7lhEHun/uPsXZRbTbHz3xWwyJ2TMOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tHK8GgnWqR1gK+AONMUol25I6OCLStp2niuRSZXjFYeJ6ePZCrsqjw1ObDt1eP5P80j7zJ1rujLLn6th3wsahnXcQ+RyvIkx2nEE5GtBjSFx43JJI2jw/tEHVmuWG6a/GyHbUG7rqP8QaS0hGd/zhOjLrenkH8+ySdqkf323bi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=beALYd3V; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="beALYd3V"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7LfcWi021771;
	Thu, 7 Nov 2024 21:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=doCJgKgRNlbWRPdmIViCqvq0yv+c6ObW0I912gt/aIA=; b=
	beALYd3VCFS5ySxK0lak37trN42estEIwG9MTl19xaRuAR1PWLxOrKfPceROXmtd
	qS99IDJZrJ+x0zSplFfjTTpvGItbwdwVfpr5N6wF1/XmhvkFcQACWMOGxqiFJQ27
	Q9q//blGooT2rOLyNTA2h/P2w4wYzYvSFZHZxoPihqo9BP+oJ/KxiyMAnUZKp6D+
	uvC1fQbyb2M5t3MWzHH6j7JfYbBxCONwmX1h7Ax4oo79Tn7flmzIAV3+J6g/lomV
	ZL8PKmd+VFr5DWhumSXlvz0dZIPdb0rE/3B5Yn6LFWeFUljdtQA5gK2WO2DByB2+
	5oppIozw1gQt/qqA0BHjmg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagcbp38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 21:47:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7K2sOH031448;
	Thu, 7 Nov 2024 21:47:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahaca6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 21:47:01 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A7Lkwwc034016;
	Thu, 7 Nov 2024 21:47:00 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42nahaca4a-5;
	Thu, 07 Nov 2024 21:47:00 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 4/4] iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest
Date: Thu,  7 Nov 2024 13:46:57 -0800
Message-Id: <1731016017-430373-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1731016017-430373-1-git-send-email-steven.sistare@oracle.com>
References: <1731016017-430373-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_10,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070171
X-Proofpoint-ORIG-GUID: n_M4-TyQGIWg6VYR67xaKHHcXoVCOB_Y
X-Proofpoint-GUID: n_M4-TyQGIWg6VYR67xaKHHcXoVCOB_Y
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add selftest cases for IOMMU_IOAS_CHANGE_PROCESS.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/Makefile        |   1 +
 tools/testing/selftests/iommu/iommufd.c       | 141 ++++++++++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |   6 ++
 3 files changed, 148 insertions(+)

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
index 88b92bb..edc0f6c 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES */
 #include <asm/unistd.h>
 #include <stdlib.h>
+#include <sys/capability.h>
 #include <sys/mman.h>
 #include <sys/eventfd.h>
 
@@ -133,6 +134,8 @@ static __attribute__((constructor)) void setup_sizes(void)
 	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 	TEST_LENGTH(iommu_ioas_map_file, IOMMU_IOAS_MAP_FILE, iova);
+	TEST_LENGTH(iommu_ioas_change_process, IOMMU_IOAS_CHANGE_PROCESS,
+		    __reserved);
 #undef TEST_LENGTH
 }
 
@@ -191,6 +194,144 @@ static __attribute__((constructor)) void setup_sizes(void)
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
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 2506914..cd8dd39 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -23,6 +23,12 @@
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
-- 
1.8.3.1

