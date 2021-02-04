Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC16C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 23:04:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0404364FAC
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 23:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0404364FAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 950682DDC9;
	Thu,  4 Feb 2021 23:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wxw77DeDJ4FI; Thu,  4 Feb 2021 23:04:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 21CC3203FD;
	Thu,  4 Feb 2021 23:04:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 000A4C07FD;
	Thu,  4 Feb 2021 23:04:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F5CBC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 33E332DADE
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JaWQ+O-wD56K for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 23:04:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by silver.osuosl.org (Postfix) with ESMTPS id B1CBB203FD
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:04:40 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DWvH727LBzjGZd;
 Fri,  5 Feb 2021 07:03:31 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.65) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 07:04:29 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <m.szyprowski@samsung.com>, <hch@lst.de>, <robin.murphy@arm.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH] dma-mapping: benchmark: pretend DMA is transmitting
Date: Fri, 5 Feb 2021 11:58:47 +1300
Message-ID: <20210204225847.8884-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.126.201.65]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, linuxarm@openeuler.org
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

In a real dma mapping user case, after dma_map is done, data will be
transmit. Thus, in multi-threaded user scenario, IOMMU contention
should not be that severe. For example, if users enable multiple
threads to send network packets through 1G/10G/100Gbps NIC, usually
the steps will be: map -> transmission -> unmap.  Transmission delay
reduces the contention of IOMMU. Here a delay is added to simulate
the transmission for TX case so that the tested result could be
more accurate.

RX case would be much more tricky. It is not supported yet.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/dma/map_benchmark.c                      | 11 +++++++++++
 tools/testing/selftests/dma/dma_map_benchmark.c | 17 +++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 1b1b8ff875cb..1976db7e34e4 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -21,6 +21,7 @@
 #define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
 #define DMA_MAP_MAX_THREADS	1024
 #define DMA_MAP_MAX_SECONDS	300
+#define DMA_MAP_MAX_TRANS_DELAY	(10 * 1000 * 1000) /* 10ms */
 
 #define DMA_MAP_BIDIRECTIONAL	0
 #define DMA_MAP_TO_DEVICE	1
@@ -36,6 +37,7 @@ struct map_benchmark {
 	__s32 node; /* which numa node this benchmark will run on */
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
+	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u64 expansion[10];	/* For future use */
 };
 
@@ -87,6 +89,10 @@ static int map_benchmark_thread(void *data)
 		map_etime = ktime_get();
 		map_delta = ktime_sub(map_etime, map_stime);
 
+		/* Pretend DMA is transmitting */
+		if (map->dir != DMA_FROM_DEVICE)
+			ndelay(map->bparam.dma_trans_ns);
+
 		unmap_stime = ktime_get();
 		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE, map->dir);
 		unmap_etime = ktime_get();
@@ -218,6 +224,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 		}
 
+		if (map->bparam.dma_trans_ns > DMA_MAP_MAX_TRANS_DELAY) {
+			pr_err("invalid transmission delay\n");
+			return -EINVAL;
+		}
+
 		if (map->bparam.node != NUMA_NO_NODE &&
 		    !node_possible(map->bparam.node)) {
 			pr_err("invalid numa node\n");
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index 7065163a8388..dbf426e2fb7f 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -14,6 +14,7 @@
 #define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
 #define DMA_MAP_MAX_THREADS	1024
 #define DMA_MAP_MAX_SECONDS     300
+#define DMA_MAP_MAX_TRANS_DELAY	(10 * 1000 * 1000) /* 10ms */
 
 #define DMA_MAP_BIDIRECTIONAL	0
 #define DMA_MAP_TO_DEVICE	1
@@ -35,6 +36,7 @@ struct map_benchmark {
 	__s32 node; /* which numa node this benchmark will run on */
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
+	__u32 dma_trans_ns; /* delay for DMA transmission in ns */
 	__u64 expansion[10];	/* For future use */
 };
 
@@ -45,12 +47,12 @@ int main(int argc, char **argv)
 	/* default single thread, run 20 seconds on NUMA_NO_NODE */
 	int threads = 1, seconds = 20, node = -1;
 	/* default dma mask 32bit, bidirectional DMA */
-	int bits = 32, dir = DMA_MAP_BIDIRECTIONAL;
+	int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
 
 	int cmd = DMA_MAP_BENCHMARK;
 	char *p;
 
-	while ((opt = getopt(argc, argv, "t:s:n:b:d:")) != -1) {
+	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:")) != -1) {
 		switch (opt) {
 		case 't':
 			threads = atoi(optarg);
@@ -67,6 +69,9 @@ int main(int argc, char **argv)
 		case 'd':
 			dir = atoi(optarg);
 			break;
+		case 'x':
+			xdelay = atoi(optarg);
+			break;
 		default:
 			return -1;
 		}
@@ -84,6 +89,12 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (xdelay < 0 || xdelay > DMA_MAP_MAX_TRANS_DELAY) {
+		fprintf(stderr, "invalid transmit delay, must be in 0-%d\n",
+			DMA_MAP_MAX_TRANS_DELAY);
+		exit(1);
+	}
+
 	/* suppose the mininum DMA zone is 1MB in the world */
 	if (bits < 20 || bits > 64) {
 		fprintf(stderr, "invalid dma mask bit, must be in 20-64\n");
@@ -107,6 +118,8 @@ int main(int argc, char **argv)
 	map.node = node;
 	map.dma_bits = bits;
 	map.dma_dir = dir;
+	map.dma_trans_ns = xdelay;
+
 	if (ioctl(fd, cmd, &map)) {
 		perror("ioctl");
 		exit(1);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
