Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974BAC433E6
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 08:26:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B019E64E0F
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 08:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B019E64E0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8227385FC6;
	Sun,  7 Feb 2021 08:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JIgb_uoHl67c; Sun,  7 Feb 2021 08:26:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B282985FAE;
	Sun,  7 Feb 2021 08:26:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA0F3C0174;
	Sun,  7 Feb 2021 08:26:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC32EC013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 08:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C387C204B0
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 08:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1o9qAcqWz+Sy for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 08:26:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by silver.osuosl.org (Postfix) with ESMTPS id 5B1AF20499
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 08:26:27 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYMf65ntqzjKdf;
 Sun,  7 Feb 2021 16:25:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 16:26:16 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-api@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH v3 2/2] selftests/vm: add mempinfd test
Date: Sun, 7 Feb 2021 16:18:04 +0800
Message-ID: <1612685884-19514-3-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, jgg@ziepe.ca,
 gregkh@linuxfoundation.org, zhangfei.gao@linaro.org, liguozhu@hisilicon.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This test gets a fd from new mempinfd syscall and creates multiple threads
to do pin/unpin memory.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Suggested-by: Barry Song <song.bao.hua@hisilicon.com>
---
 tools/testing/selftests/vm/Makefile   |   1 +
 tools/testing/selftests/vm/mempinfd.c | 131 ++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mempinfd.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index d42115e..2d5b509 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -42,6 +42,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_FILES += mempinfd
 
 ifeq ($(MACHINE),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
diff --git a/tools/testing/selftests/vm/mempinfd.c b/tools/testing/selftests/vm/mempinfd.c
new file mode 100644
index 0000000..51d5cbf
--- /dev/null
+++ b/tools/testing/selftests/vm/mempinfd.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021 HiSilicon Limited. */
+#define _GNU_SOURCE
+#include <linux/mempinfd.h>
+#include <malloc.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+
+#include "../kselftest.h"
+
+#ifdef __NR_mempinfd
+
+#define DEF_PIN_SIZE		(4096 * 1024)
+#define MAX_THREAD_NUM		20
+#define DEF_THREAD_NUM		1
+#define DEF_TIMES		10000
+
+struct test_data {
+	int fd;
+	unsigned long mem_size;
+	unsigned long times;
+};
+
+static void *do_pin_test(void *data)
+{
+	struct mem_pin_address addr;
+	struct test_data *d = data;
+	unsigned long times;
+	int ret, fd;
+	int i = 0;
+	void *p;
+
+	p = malloc(d->mem_size);
+	if (!p) {
+		fprintf(stderr, "fail to allocate memory\n");
+		return NULL;
+	}
+
+	addr.addr = (__u64)p;
+	addr.size = d->mem_size;
+	times = d->mem_size;
+	fd = d->fd;
+
+	while (i++ < times) {
+		ret = ioctl(fd, MEM_CMD_PIN, &addr);
+		if (ret) {
+			fprintf(stderr, "fail to pin memory\n");
+			return NULL;
+		}
+
+		usleep(1000);
+
+		ret = ioctl(fd, MEM_CMD_UNPIN, &addr);
+		if (ret) {
+			fprintf(stderr, "fail to unpin memory\n");
+			return NULL;
+		}
+	}
+
+	free(p);
+
+	return NULL;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long thread_num = DEF_THREAD_NUM;
+	unsigned long mem_size = DEF_PIN_SIZE;
+	unsigned long times = DEF_TIMES;
+	pthread_t threads[MAX_THREAD_NUM];
+	struct test_data data;
+	int fd, opt, i;
+	int ret = 0;
+
+	while ((opt = getopt(argc, argv, "s:n:t:")) != -1) {
+		switch (opt) {
+		case 's':
+			mem_size = atoi(optarg);
+			break;
+		case 'n':
+			thread_num = atoi(optarg);
+			if (thread_num > MAX_THREAD_NUM)
+				return -1;
+			break;
+		case 't':
+			times = atoi(optarg);
+			break;
+		default:
+			return -1;
+		}
+	}
+
+	fd = syscall(__NR_mempinfd);
+	if (fd < 0) {
+		fprintf(stderr, "mempinfd syscall not available in this kernel\n");
+		return -1;
+	}
+
+	data.fd = fd;
+	data.mem_size = mem_size;
+	data.times = times;
+
+	for (i = 0; i < thread_num; i++) {
+		ret = pthread_create(&threads[i], NULL, do_pin_test, &data);
+		if (ret) {
+			fprintf(stderr, "fail to create thread %d: %d\n",
+				i, -errno);
+			return -1;
+		}
+	}
+
+	for (i = 0; i < thread_num; i++)
+		pthread_join(threads[i], NULL);
+
+	close(fd);
+
+	return 0;
+}
+
+#else /* __NR_mempinfd */
+
+#warning "missing __NR_mempinfd definition"
+int main(void)
+{
+	printf("skip: Skipping mempinfd test (missing __NR_mempinfd)\n");
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_mempinfd */
-- 
2.8.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
