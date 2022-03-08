Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC37C433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Mar 2022 08:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7693540A99;
	Tue,  8 Mar 2022 08:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AZlmTdbaNZR6; Tue,  8 Mar 2022 08:59:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E5ED3400FE;
	Tue,  8 Mar 2022 08:59:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C90CCC001D;
	Tue,  8 Mar 2022 08:59:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65B26C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 08:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55C2A4021E
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 08:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jQc3-HQUE7sP for <iommu@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:59:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27CD6401EB
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 08:59:28 +0000 (UTC)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KCTfQ1Ts6z1GByG;
 Tue,  8 Mar 2022 16:54:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 16:59:25 +0800
To: <hch@lst.de>, <shuah@kernel.org>, <chenxiang66@hisilicon.com>,
 <skhan@linuxfoundation.org>
Subject: [PATCH v2] dma-mapping: benchmark: Extract a common header file for
 map_benchmark definition
Date: Tue, 8 Mar 2022 16:59:10 +0800
Message-ID: <20220308085910.37358-1-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@openeuler.org,
 linux-kselftest@vger.kernel.org
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
From: Tian Tao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

kernel/dma/map_benchmark.c and selftests/dma/dma_map_benchmark.c
have duplicate map_benchmark definitions, which tends to lead to
inconsistent changes to map_benchmark on both sides, extract a
common header file to avoid this problem.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Acked-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
v2:
move map_benchmark.h in a more appropriate directory
---
 include/linux/map_benchmark.h                 | 31 +++++++++++++++++++
 kernel/dma/map_benchmark.c                    | 25 +--------------
 .../testing/selftests/dma/dma_map_benchmark.c | 25 +--------------
 3 files changed, 33 insertions(+), 48 deletions(-)
 create mode 100644 include/linux/map_benchmark.h

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
new file mode 100644
index 000000000000..62674c83bde4
--- /dev/null
+++ b/include/linux/map_benchmark.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 HiSilicon Limited.
+ */
+
+#ifndef _KERNEL_DMA_BENCHMARK_H
+#define _KERNEL_DMA_BENCHMARK_H
+
+#define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
+#define DMA_MAP_MAX_THREADS     1024
+#define DMA_MAP_MAX_SECONDS     300
+#define DMA_MAP_MAX_TRANS_DELAY (10 * NSEC_PER_MSEC)
+
+#define DMA_MAP_BIDIRECTIONAL   0
+#define DMA_MAP_TO_DEVICE       1
+#define DMA_MAP_FROM_DEVICE     2
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
+	__u32 dma_trans_ns; /* time for DMA transmission in ns */
+	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+};
+#endif /* _KERNEL_DMA_BENCHMARK_H */
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 9b9af1bd6be3..0520a8f4fb1d 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -11,6 +11,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
+#include <linux/map_benchmark.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -18,30 +19,6 @@
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 
-#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
-#define DMA_MAP_MAX_THREADS	1024
-#define DMA_MAP_MAX_SECONDS	300
-#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC)
-
-#define DMA_MAP_BIDIRECTIONAL	0
-#define DMA_MAP_TO_DEVICE	1
-#define DMA_MAP_FROM_DEVICE	2
-
-struct map_benchmark {
-	__u64 avg_map_100ns; /* average map latency in 100ns */
-	__u64 map_stddev; /* standard deviation of map latency */
-	__u64 avg_unmap_100ns; /* as above */
-	__u64 unmap_stddev;
-	__u32 threads; /* how many threads will do map/unmap in parallel */
-	__u32 seconds; /* how long the test will last */
-	__s32 node; /* which numa node this benchmark will run on */
-	__u32 dma_bits; /* DMA addressing capability */
-	__u32 dma_dir; /* DMA data direction */
-	__u32 dma_trans_ns; /* time for DMA transmission in ns */
-	__u32 granule;	/* how many PAGE_SIZE will do map/unmap once a time */
-	__u8 expansion[76];	/* For future use */
-};
-
 struct map_benchmark_data {
 	struct map_benchmark bparam;
 	struct device *dev;
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index 485dff51bad2..c3b3c09e995e 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -10,40 +10,17 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <linux/map_benchmark.h>
 #include <linux/types.h>
 
 #define NSEC_PER_MSEC	1000000L
 
-#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
-#define DMA_MAP_MAX_THREADS	1024
-#define DMA_MAP_MAX_SECONDS     300
-#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC)
-
-#define DMA_MAP_BIDIRECTIONAL	0
-#define DMA_MAP_TO_DEVICE	1
-#define DMA_MAP_FROM_DEVICE	2
-
 static char *directions[] = {
 	"BIDIRECTIONAL",
 	"TO_DEVICE",
 	"FROM_DEVICE",
 };
 
-struct map_benchmark {
-	__u64 avg_map_100ns; /* average map latency in 100ns */
-	__u64 map_stddev; /* standard deviation of map latency */
-	__u64 avg_unmap_100ns; /* as above */
-	__u64 unmap_stddev;
-	__u32 threads; /* how many threads will do map/unmap in parallel */
-	__u32 seconds; /* how long the test will last */
-	__s32 node; /* which numa node this benchmark will run on */
-	__u32 dma_bits; /* DMA addressing capability */
-	__u32 dma_dir; /* DMA data direction */
-	__u32 dma_trans_ns; /* time for DMA transmission in ns */
-	__u32 granule; /* how many PAGE_SIZE will do map/unmap once a time */
-	__u8 expansion[76];	/* For future use */
-};
-
 int main(int argc, char **argv)
 {
 	struct map_benchmark map;
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
