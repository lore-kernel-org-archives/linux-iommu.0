Return-Path: <SRS0=PKzM=EC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF137C55178
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 03:57:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FB220759
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 03:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FB220759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1B1D62040E;
	Tue, 27 Oct 2020 03:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a2MhBLqeFqdZ; Tue, 27 Oct 2020 03:57:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1B67220353;
	Tue, 27 Oct 2020 03:57:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 082F6C088B;
	Tue, 27 Oct 2020 03:57:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A930FC088B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 03:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A367E20402
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 03:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AcRCCEH4xshl for <iommu@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 03:57:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by silver.osuosl.org (Postfix) with ESMTPS id 1D1EB20353
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 03:57:30 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CKyZz2bmKzhZsq;
 Tue, 27 Oct 2020 11:57:31 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.177) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 11:57:18 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <iommu@lists.linux-foundation.org>, <hch@lst.de>,
 <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
Subject: [PATCH 2/2] selftests/dma: add test application for DMA_MAP_BENCHMARK
Date: Tue, 27 Oct 2020 16:53:30 +1300
Message-ID: <20201027035330.29612-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201027035330.29612-1-song.bao.hua@hisilicon.com>
References: <20201027035330.29612-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.202.177]
X-CFilter-Loop: Reflected
Cc: will@kernel.org, linuxarm@huawei.com, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
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

This patch provides the test application for DMA_MAP_BENCHMARK.

Before running the test application, we need to bind a device to dma_map_
benchmark driver. For example, unbind "xxx" from its original driver and
bind to dma_map_benchmark:

echo dma_map_benchmark > /sys/bus/platform/devices/xxx/driver_override
echo xxx > /sys/bus/platform/drivers/xxx/unbind
echo xxx > /sys/bus/platform/drivers/dma_map_benchmark/bind

Then, run 10 threads on numa node 1 for 10 seconds on device "xxx":
./dma_map_benchmark -t 10 -s 10 -n 1
dma mapping benchmark: average map_nsec:3619 average unmap_nsec:2423

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 MAINTAINERS                                   |  6 ++
 tools/testing/selftests/dma/Makefile          |  6 ++
 tools/testing/selftests/dma/config            |  1 +
 .../testing/selftests/dma/dma_map_benchmark.c | 72 +++++++++++++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 tools/testing/selftests/dma/Makefile
 create mode 100644 tools/testing/selftests/dma/config
 create mode 100644 tools/testing/selftests/dma/dma_map_benchmark.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f310f0a09904..552389874ca2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5220,6 +5220,12 @@ F:	include/linux/dma-mapping.h
 F:	include/linux/dma-map-ops.h
 F:	kernel/dma/
 
+DMA MAPPING BENCHMARK
+M:	Barry Song <song.bao.hua@hisilicon.com>
+L:	iommu@lists.linux-foundation.org
+F:	kernel/dma/map_benchmark.c
+F:	tools/testing/selftests/dma/
+
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Andrew F. Davis <afd@ti.com>
diff --git a/tools/testing/selftests/dma/Makefile b/tools/testing/selftests/dma/Makefile
new file mode 100644
index 000000000000..aa8e8b5b3864
--- /dev/null
+++ b/tools/testing/selftests/dma/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -I../../../../usr/include/
+
+TEST_GEN_PROGS := dma_map_benchmark
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dma/config b/tools/testing/selftests/dma/config
new file mode 100644
index 000000000000..6102ee3c43cd
--- /dev/null
+++ b/tools/testing/selftests/dma/config
@@ -0,0 +1 @@
+CONFIG_DMA_MAP_BENCHMARK=y
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
new file mode 100644
index 000000000000..e03bd03e101e
--- /dev/null
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Hisilicon Limited.
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <linux/types.h>
+
+#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
+
+struct map_benchmark {
+	__u64 map_nsec;
+	__u64 unmap_nsec;
+	__u32 threads; /* how many threads will do map/unmap in parallel */
+	__u32 seconds; /* how long the test will last */
+	int node; /* which numa node this benchmark will run on */
+	__u64 expansion[10];	/* For future use */
+};
+
+int main(int argc, char **argv)
+{
+	struct map_benchmark map;
+	int fd, opt, threads = 0, seconds = 0, node = -1;
+	int cmd = DMA_MAP_BENCHMARK;
+	char *p;
+
+	while ((opt = getopt(argc, argv, "t:s:n:")) != -1) {
+		switch (opt) {
+		case 't':
+			threads = atoi(optarg);
+			break;
+		case 's':
+			seconds = atoi(optarg);
+			break;
+		case 'n':
+			node = atoi(optarg);
+			break;
+		default:
+			return -1;
+		}
+	}
+
+	if (threads <= 0 || seconds <= 0) {
+		perror("invalid number of threads or seconds");
+		exit(1);
+	}
+
+	fd = open("/sys/kernel/debug/dma_map_benchmark", O_RDWR);
+	if (fd == -1) {
+		perror("open");
+		exit(1);
+	}
+
+	map.seconds = seconds;
+	map.threads = threads;
+	map.node = node;
+	if (ioctl(fd, cmd, &map)) {
+		perror("ioctl");
+		exit(1);
+	}
+
+	printf("dma mapping benchmark: average map_nsec:%lld average unmap_nsec:%lld\n",
+			map.map_nsec,
+			map.unmap_nsec);
+
+	return 0;
+}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
