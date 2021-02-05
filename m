Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E39C433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 11:39:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED6A64E55
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 11:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED6A64E55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 47F1F8720A;
	Fri,  5 Feb 2021 11:39:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1s6u+jt4g9b; Fri,  5 Feb 2021 11:39:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2EA1E871F1;
	Fri,  5 Feb 2021 11:39:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0F04C08A1;
	Fri,  5 Feb 2021 11:39:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C19ECC013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 11:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A2C1A20371
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 11:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O+JVr0Z4qzMM for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 11:39:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by silver.osuosl.org (Postfix) with ESMTPS id EC1D42036E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 11:39:24 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DXD1F3Mr5zlH7W;
 Fri,  5 Feb 2021 19:37:37 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.232) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 19:39:10 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <m.szyprowski@samsung.com>, <hch@lst.de>, <robin.murphy@arm.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 2/2] dma-mapping: benchmark: pretend DMA is transmitting
Date: Sat, 6 Feb 2021 00:33:25 +1300
Message-ID: <20210205113325.19556-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210205113325.19556-1-song.bao.hua@hisilicon.com>
References: <20210205113325.19556-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.202.232]
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
reduces the contention of IOMMU.

Here a delay is added to simulate the transmission between map and unmap
so that the tested result could be more accurate for TX and simple RX.
A typical TX transmission for NIC would be like: map -> TX -> unmap
since the socket buffers come from OS. Simple RX model eg. disk driver,
is also map -> RX -> unmap, but real RX model in a NIC could be more
complicated considering packets can come spontaneously and many drivers
are using pre-mapped buffers pool. This is in the TBD list.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/dma/map_benchmark.c                    | 12 ++++++++++-
 .../testing/selftests/dma/dma_map_benchmark.c | 21 ++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index da95df381483..e0e64f8b0739 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -21,6 +21,7 @@
 #define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
 #define DMA_MAP_MAX_THREADS	1024
 #define DMA_MAP_MAX_SECONDS	300
+#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC)
 
 #define DMA_MAP_BIDIRECTIONAL	0
 #define DMA_MAP_TO_DEVICE	1
@@ -36,7 +37,8 @@ struct map_benchmark {
 	__s32 node; /* which numa node this benchmark will run on */
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
-	__u8 expansion[84];	/* For future use */
+	__u32 dma_trans_ns; /* time for DMA transmission in ns */
+	__u8 expansion[80];	/* For future use */
 };
 
 struct map_benchmark_data {
@@ -87,6 +89,9 @@ static int map_benchmark_thread(void *data)
 		map_etime = ktime_get();
 		map_delta = ktime_sub(map_etime, map_stime);
 
+		/* Pretend DMA is transmitting */
+		ndelay(map->bparam.dma_trans_ns);
+
 		unmap_stime = ktime_get();
 		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE, map->dir);
 		unmap_etime = ktime_get();
@@ -218,6 +223,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
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
index 537d65968c48..fb23ce9617ea 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -12,9 +12,12 @@
 #include <sys/mman.h>
 #include <linux/types.h>
 
+#define NSEC_PER_MSEC	1000000L
+
 #define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
 #define DMA_MAP_MAX_THREADS	1024
 #define DMA_MAP_MAX_SECONDS     300
+#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC)
 
 #define DMA_MAP_BIDIRECTIONAL	0
 #define DMA_MAP_TO_DEVICE	1
@@ -36,7 +39,8 @@ struct map_benchmark {
 	__s32 node; /* which numa node this benchmark will run on */
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
-	__u8 expansion[84];	/* For future use */
+	__u32 dma_trans_ns; /* time for DMA transmission in ns */
+	__u8 expansion[80];	/* For future use */
 };
 
 int main(int argc, char **argv)
@@ -46,12 +50,12 @@ int main(int argc, char **argv)
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
@@ -68,6 +72,9 @@ int main(int argc, char **argv)
 		case 'd':
 			dir = atoi(optarg);
 			break;
+		case 'x':
+			xdelay = atoi(optarg);
+			break;
 		default:
 			return -1;
 		}
@@ -85,6 +92,12 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (xdelay < 0 || xdelay > DMA_MAP_MAX_TRANS_DELAY) {
+		fprintf(stderr, "invalid transmit delay, must be in 0-%ld\n",
+			DMA_MAP_MAX_TRANS_DELAY);
+		exit(1);
+	}
+
 	/* suppose the mininum DMA zone is 1MB in the world */
 	if (bits < 20 || bits > 64) {
 		fprintf(stderr, "invalid dma mask bit, must be in 20-64\n");
@@ -109,6 +122,8 @@ int main(int argc, char **argv)
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
