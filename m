Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC01FDF8D
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527508; cv=none; b=BLlW7apNLyhnTi1Eeatmy0571/l0/sUhIAq2zJZfUWv4upTIPOoj48uLwSZgYweT4VNCqXU439A1tZbmmaz4p/vsKsk/CuwcHLYwfMLJO6B/xOuy5IuIaf/1XtVK3FPU39dIA+RDwDrUQ6qTfkiX7s5mu3gKUKYHy0uJyyx+XhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527508; c=relaxed/simple;
	bh=Z+4CBuHmtMIaL7lhEHun/uPsXZRbTbHz3xWwyJ2TMOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aGoCKkPjUH1GfU4iz9xFRyNmLeXmUsQvtFRUho2bXTZuF44ZaiQQH/ljTUbU/v9nzB8b7qDeww42K+vRjxqV7i1bqeijewxKDxwFUYwkJMEgQrezv5pitpqNs4OQ/cttiUhIYzKVA7ylBcCpJkH6FJvaKNZkFbp5J84civQgaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DtNFXeRB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DtNFXeRB"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBW29006362;
	Wed, 13 Nov 2024 19:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=doCJgKgRNlbWRPdmIViCqvq0yv+c6ObW0I912gt/aIA=; b=
	DtNFXeRB0Eh2ap+B0H1FAs+hweISuWJG6zVCuz7V1CqmCUw6f041QT7yAN3xGqnt
	NMfTONKO4bOnvXLay7TcuPdQ6o0P1aWtzSoD0oU3kJlNMu68mzAKE/LC51jVOjLL
	NuAnR8bSUlFilAiKBgo69+Guh7p8TDxBiKIw8v6coR7/H3HGj+bUh1bd4HK9Emit
	9p3gdbhsYu5h8ANvUD2Mi1CTmIl5VEp3EBRyI3XSsOEDd6E3lLFyN8ndvsY1CrrC
	LKwtv4mVU/m7OgJPlhoQvf/PZ0sJmU70C6Q/IFZdb4dx0pT8ip4OcGXvqM5ZX5z6
	HIumPDihNxKJHVEIRySNgQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwqpxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 19:51:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIKcjh001125;
	Wed, 13 Nov 2024 19:51:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6a4b89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 19:51:43 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4ADJpdsp023287;
	Wed, 13 Nov 2024 19:51:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42sx6a4b5c-5;
	Wed, 13 Nov 2024 19:51:42 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 4/4] iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest
Date: Wed, 13 Nov 2024 11:51:37 -0800
Message-Id: <1731527497-16091-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1731527497-16091-1-git-send-email-steven.sistare@oracle.com>
References: <1731527497-16091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_12,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130163
X-Proofpoint-GUID: W-k9XU7mhkKhptvMb3ZRn9Hq2fagMvEu
X-Proofpoint-ORIG-GUID: W-k9XU7mhkKhptvMb3ZRn9Hq2fagMvEu
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

