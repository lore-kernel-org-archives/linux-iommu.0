Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FE5C433E9
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:33:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E81B64F38
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E81B64F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 386D683E9A;
	Thu, 18 Mar 2021 09:33:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t96y9xRLw4t6; Thu, 18 Mar 2021 09:33:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA70A840CB;
	Thu, 18 Mar 2021 09:33:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5A00C000A;
	Thu, 18 Mar 2021 09:33:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74957C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57022430A2
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:33:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z6w3gFERe6Ul for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 09:33:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F2884309A
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:33:41 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1MH26yRrz19GR8;
 Thu, 18 Mar 2021 17:31:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Mar 2021 17:33:30 +0800
From: chenxiang <chenxiang66@hisilicon.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
 <song.bao.hua@hisilicon.com>
Subject: [PATCH] dma-mapping: benchmark: Add support for multi-pages map/unmap
Date: Thu, 18 Mar 2021 17:29:30 +0800
Message-ID: <1616059770-194515-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Xiang Chen <chenxiang66@hisilicon.com>

Currently it only support one page map/unmap once a time for dma-map
benchmark, but there are some other scenaries which need to support for
multi-page map/unmap: for those multi-pages interfaces such as
dma_alloc_coherent() and dma_map_sg(), the time spent on multi-pages
map/unmap is not the time of a single page * npages (not linear) as it
may use block description instead of page description when it is satified
with the size such as 2M/1G, and also it can send a single TLB invalidation
command to invalidate multi-pages instead of multi-times when RIL is
enabled (which will short the time of unmap). So it is necessary to add
support for multi-pages map/unmap.

Add a parameter "-g" to support multi-pages map/unmap.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 kernel/dma/map_benchmark.c                      | 21 ++++++++++++++-------
 tools/testing/selftests/dma/dma_map_benchmark.c | 20 ++++++++++++++++----
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index e0e64f8..a5c1b01 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -38,7 +38,8 @@ struct map_benchmark {
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
-	__u8 expansion[80];	/* For future use */
+	__u32 granule;	/* how many PAGE_SIZE will do map/unmap once a time */
+	__u8 expansion[76];	/* For future use */
 };
 
 struct map_benchmark_data {
@@ -58,9 +59,11 @@ static int map_benchmark_thread(void *data)
 	void *buf;
 	dma_addr_t dma_addr;
 	struct map_benchmark_data *map = data;
+	int npages = map->bparam.granule;
+	u64 size = npages * PAGE_SIZE;
 	int ret = 0;
 
-	buf = (void *)__get_free_page(GFP_KERNEL);
+	buf = alloc_pages_exact(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -76,10 +79,10 @@ static int map_benchmark_thread(void *data)
 		 * 66 means evertything goes well! 66 is lucky.
 		 */
 		if (map->dir != DMA_FROM_DEVICE)
-			memset(buf, 0x66, PAGE_SIZE);
+			memset(buf, 0x66, size);
 
 		map_stime = ktime_get();
-		dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE, map->dir);
+		dma_addr = dma_map_single(map->dev, buf, size, map->dir);
 		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
 			pr_err("dma_map_single failed on %s\n",
 				dev_name(map->dev));
@@ -93,7 +96,7 @@ static int map_benchmark_thread(void *data)
 		ndelay(map->bparam.dma_trans_ns);
 
 		unmap_stime = ktime_get();
-		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE, map->dir);
+		dma_unmap_single(map->dev, dma_addr, size, map->dir);
 		unmap_etime = ktime_get();
 		unmap_delta = ktime_sub(unmap_etime, unmap_stime);
 
@@ -112,7 +115,7 @@ static int map_benchmark_thread(void *data)
 	}
 
 out:
-	free_page((unsigned long)buf);
+	free_pages_exact(buf, size);
 	return ret;
 }
 
@@ -203,7 +206,6 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 	struct map_benchmark_data *map = file->private_data;
 	void __user *argp = (void __user *)arg;
 	u64 old_dma_mask;
-
 	int ret;
 
 	if (copy_from_user(&map->bparam, argp, sizeof(map->bparam)))
@@ -234,6 +236,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 		}
 
+		if (map->bparam.granule < 1 || map->bparam.granule > 1024) {
+			pr_err("invalid granule size\n");
+			return -EINVAL;
+		}
+
 		switch (map->bparam.dma_dir) {
 		case DMA_MAP_BIDIRECTIONAL:
 			map->dir = DMA_BIDIRECTIONAL;
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index fb23ce9..6f2caa6 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -40,7 +40,8 @@ struct map_benchmark {
 	__u32 dma_bits; /* DMA addressing capability */
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
-	__u8 expansion[80];	/* For future use */
+	__u32 granule; /* how many PAGE_SIZE will do map/unmap once a time */
+	__u8 expansion[76];	/* For future use */
 };
 
 int main(int argc, char **argv)
@@ -51,11 +52,13 @@ int main(int argc, char **argv)
 	int threads = 1, seconds = 20, node = -1;
 	/* default dma mask 32bit, bidirectional DMA */
 	int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
+	/* default granule 1 PAGESIZE */
+	int granule = 1;
 
 	int cmd = DMA_MAP_BENCHMARK;
 	char *p;
 
-	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:")) != -1) {
+	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
 		switch (opt) {
 		case 't':
 			threads = atoi(optarg);
@@ -75,6 +78,9 @@ int main(int argc, char **argv)
 		case 'x':
 			xdelay = atoi(optarg);
 			break;
+		case 'g':
+			granule = atoi(optarg);
+			break;
 		default:
 			return -1;
 		}
@@ -110,6 +116,11 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (granule < 1 || granule > 1024) {
+		fprintf(stderr, "invalid granule size\n");
+		exit(1);
+	}
+
 	fd = open("/sys/kernel/debug/dma_map_benchmark", O_RDWR);
 	if (fd == -1) {
 		perror("open");
@@ -123,14 +134,15 @@ int main(int argc, char **argv)
 	map.dma_bits = bits;
 	map.dma_dir = dir;
 	map.dma_trans_ns = xdelay;
+	map.granule = granule;
 
 	if (ioctl(fd, cmd, &map)) {
 		perror("ioctl");
 		exit(1);
 	}
 
-	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s\n",
-			threads, seconds, node, dir[directions]);
+	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
+			threads, seconds, node, dir[directions], granule);
 	printf("average map latency(us):%.1f standard deviation:%.1f\n",
 			map.avg_map_100ns/10.0, map.map_stddev/10.0);
 	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
-- 
2.8.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
