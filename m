Return-Path: <SRS0=dfl9=EW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B59FC63777
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 06:13:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78332222E
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 06:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78332222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3EBEF868B5;
	Mon, 16 Nov 2020 06:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzG5kFX-s0z0; Mon, 16 Nov 2020 06:13:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B25EC868AC;
	Mon, 16 Nov 2020 06:13:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C1CDC0800;
	Mon, 16 Nov 2020 06:13:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EC37C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 06:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6366D87184
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 06:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ytyA5sSWMjS5 for <iommu@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 06:13:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 89EA787182
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 06:13:12 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CZJdz5cXVz15Lp7;
 Mon, 16 Nov 2020 14:12:55 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.147) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 14:12:57 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <iommu@lists.linux-foundation.org>, <hch@lst.de>, <robin.murphy@arm.com>, 
 <m.szyprowski@samsung.com>
Subject: [PATCH v4 2/2] selftests/dma: add test application for
 DMA_MAP_BENCHMARK
Date: Mon, 16 Nov 2020 19:08:48 +1300
Message-ID: <20201116060848.1848-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201116060848.1848-1-song.bao.hua@hisilicon.com>
References: <20201116060848.1848-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.201.147]
X-CFilter-Loop: Reflected
Cc: Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
 linuxarm@huawei.com, linux-kselftest@vger.kernel.org
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

Another example for PCI devices:
echo dma_map_benchmark > /sys/bus/pci/devices/0000:00:01.0/driver_override
echo 0000:00:01.0 > /sys/bus/pci/drivers/xxx/unbind
echo 0000:00:01.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind

The below command will run 16 threads on numa node 0 for 10 seconds on
the device bound to dma_map_benchmark platform_driver or pci_driver:
./dma_map_benchmark -t 16 -s 10 -n 0
dma mapping benchmark: threads:16 seconds:10
average map latency(us):1.1 standard deviation:1.9
average unmap latency(us):0.5 standard deviation:0.8

Cc: Will Deacon <will@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v4:
  * add dma direction and mask_bit parameters

 MAINTAINERS                                   |   6 +
 tools/testing/selftests/dma/Makefile          |   6 +
 tools/testing/selftests/dma/config            |   1 +
 .../testing/selftests/dma/dma_map_benchmark.c | 123 ++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/dma/Makefile
 create mode 100644 tools/testing/selftests/dma/config
 create mode 100644 tools/testing/selftests/dma/dma_map_benchmark.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e451dcce054f..bc851ffd3114 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5247,6 +5247,12 @@ F:	include/linux/dma-mapping.h
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
 R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
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
index 000000000000..7065163a8388
--- /dev/null
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -0,0 +1,123 @@
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
+#define DMA_MAP_MAX_THREADS	1024
+#define DMA_MAP_MAX_SECONDS     300
+
+#define DMA_MAP_BIDIRECTIONAL	0
+#define DMA_MAP_TO_DEVICE	1
+#define DMA_MAP_FROM_DEVICE	2
+
+static char *directions[] = {
+	"BIDIRECTIONAL",
+	"TO_DEVICE",
+	"FROM_DEVICE",
+};
+
+struct map_benchmark {
+	__u64 avg_map_100ns; /* average map latency in 100ns */
+	__u64 map_stddev; /* standard deviation of map latency */
+	__u64 avg_unmap_100ns; /* as above */
+	__u64 unmap_stddev;
+	__u32 threads; /* how many threads will do map/unmap in parallel */
+	__u32 seconds; /* how long the test will last */
+	__s32 node; /* which numa node this benchmark will run on */
+	__u32 dma_bits; /* DMA addressing capability */
+	__u32 dma_dir; /* DMA data direction */
+	__u64 expansion[10];	/* For future use */
+};
+
+int main(int argc, char **argv)
+{
+	struct map_benchmark map;
+	int fd, opt;
+	/* default single thread, run 20 seconds on NUMA_NO_NODE */
+	int threads = 1, seconds = 20, node = -1;
+	/* default dma mask 32bit, bidirectional DMA */
+	int bits = 32, dir = DMA_MAP_BIDIRECTIONAL;
+
+	int cmd = DMA_MAP_BENCHMARK;
+	char *p;
+
+	while ((opt = getopt(argc, argv, "t:s:n:b:d:")) != -1) {
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
+		case 'b':
+			bits = atoi(optarg);
+			break;
+		case 'd':
+			dir = atoi(optarg);
+			break;
+		default:
+			return -1;
+		}
+	}
+
+	if (threads <= 0 || threads > DMA_MAP_MAX_THREADS) {
+		fprintf(stderr, "invalid number of threads, must be in 1-%d\n",
+			DMA_MAP_MAX_THREADS);
+		exit(1);
+	}
+
+	if (seconds <= 0 || seconds > DMA_MAP_MAX_SECONDS) {
+		fprintf(stderr, "invalid number of seconds, must be in 1-%d\n",
+			DMA_MAP_MAX_SECONDS);
+		exit(1);
+	}
+
+	/* suppose the mininum DMA zone is 1MB in the world */
+	if (bits < 20 || bits > 64) {
+		fprintf(stderr, "invalid dma mask bit, must be in 20-64\n");
+		exit(1);
+	}
+
+	if (dir != DMA_MAP_BIDIRECTIONAL && dir != DMA_MAP_TO_DEVICE &&
+			dir != DMA_MAP_FROM_DEVICE) {
+		fprintf(stderr, "invalid dma direction\n");
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
+	map.dma_bits = bits;
+	map.dma_dir = dir;
+	if (ioctl(fd, cmd, &map)) {
+		perror("ioctl");
+		exit(1);
+	}
+
+	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s\n",
+			threads, seconds, node, dir[directions]);
+	printf("average map latency(us):%.1f standard deviation:%.1f\n",
+			map.avg_map_100ns/10.0, map.map_stddev/10.0);
+	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
+			map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
+
+	return 0;
+}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
