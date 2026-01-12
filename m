Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E326F2BE
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210485; cv=none; b=OhPjFgkafmBNCyu4/inFetJn5cOj6VK1CnBsWSCADockzVyH7ukJnFQBH3Z0uEBfthLVRlWZ0mmWRvUOm8MLGPD0Lh1wd88/tBB8N/MrLQ3f97NE++bWZoVTuT5JARPqtHY+7J5wxTqpy2FQ++empFWx2n8EhPr6/uO/n30WmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210485; c=relaxed/simple;
	bh=8sft5Cfo0r/EQQFuug/6sOpg/zghyhwLBpb8GYf+0f4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4smcEWD9pak17YVkAHBu4R7RsRkjgPvqiIeca2QnunDhvXTJjTY29KKSQ4sNZu53g5Gy6QquSVFNXnJZ7dPM4ZH7bjPu56dWa6zwZS94Wv6UmWWlx693joNcH7TDMRT7ejgPh5GAlODqg57AaJdWeXC1rQjpFiumTsWbQ5ZdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CG6chLH8; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CG6chLH8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uO7P1QvCPLUDxnK/XMa556cfvssPiwxe/AQofsK7HVo=;
	b=CG6chLH8U08Fi0pIrGoNIlTVZwCLRR8773YYkGDAJugYvlO0hqcwOAmbpxsmhL6eEqufrXyIV
	opXAZfx0C1EDSoab/uUZZoXVZ1CvjPRm/3XDZ23bR6cK06plhSAyM9c3W81yHZtoQMIclth50ct
	oBCwO2IJxhx7uSxF+le7Gxo=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dqRvd346MzpSv8;
	Mon, 12 Jan 2026 17:31:09 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 714BA2016A;
	Mon, 12 Jan 2026 17:34:39 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 17:34:38 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <xiaqinxin@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>
CC: <iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v6 3/3] tools/dma: Add dma_map_sg support
Date: Mon, 12 Jan 2026 17:34:36 +0800
Message-ID: <20260112093436.3456315-4-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260112093436.3456315-1-xiaqinxin@huawei.com>
References: <20260112093436.3456315-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Support for dma_map_sg, add option '-m' to distinguish mode.

i) Users can set option '-m' to select mode:
   DMA_MAP_BENCH_SINGLE_MODE=0, DMA_MAP_BENCH_SG_MODE:=1
   (The mode is also show in the test result).
ii) Users can set option '-g' to set sg_nents
    (total count of entries in scatterlist)
    the maximum number is 1024. Each of sg buf size is PAGE_SIZE.
    e.g
    [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
    dma mapping mode: DMA_MAP_BENCH_SG_MODE
    dma mapping benchmark: threads:8 seconds:30 node:-1
    dir:FROM_DEVICE granule/sg_nents: 8
    average map latency(us):1.4 standard deviation:0.3
    average unmap latency(us):1.3 standard deviation:0.3
    [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
    dma mapping mode: DMA_MAP_BENCH_SINGLE_MODE
    dma mapping benchmark: threads:8 seconds:30 node:-1
    dir:FROM_DEVICE granule/sg_nents: 8
    average map latency(us):1.0 standard deviation:0.3
    average unmap latency(us):1.3 standard deviation:0.5

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 tools/dma/dma_map_benchmark.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/dma/dma_map_benchmark.c b/tools/dma/dma_map_benchmark.c
index dd0ed528e6df..143ca8dab8af 100644
--- a/tools/dma/dma_map_benchmark.c
+++ b/tools/dma/dma_map_benchmark.c
@@ -20,12 +20,19 @@ static char *directions[] = {
 	"FROM_DEVICE",
 };
 
+static char *mode[] = {
+	"SINGLE_MODE",
+	"SG_MODE",
+};
+
 int main(int argc, char **argv)
 {
 	struct map_benchmark map;
 	int fd, opt;
 	/* default single thread, run 20 seconds on NUMA_NO_NODE */
 	int threads = 1, seconds = 20, node = -1;
+	/* default single map mode */
+	int map_mode = DMA_MAP_BENCH_SINGLE_MODE;
 	/* default dma mask 32bit, bidirectional DMA */
 	int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
 	/* default granule 1 PAGESIZE */
@@ -33,7 +40,7 @@ int main(int argc, char **argv)
 
 	int cmd = DMA_MAP_BENCHMARK;
 
-	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
+	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:m:")) != -1) {
 		switch (opt) {
 		case 't':
 			threads = atoi(optarg);
@@ -56,11 +63,20 @@ int main(int argc, char **argv)
 		case 'g':
 			granule = atoi(optarg);
 			break;
+		case 'm':
+			map_mode = atoi(optarg);
+			break;
 		default:
 			return -1;
 		}
 	}
 
+	if (map_mode < 0 || map_mode >= DMA_MAP_BENCH_MODE_MAX) {
+		fprintf(stderr, "invalid map mode, SINGLE_MODE:%d, SG_MODE: %d\n",
+			DMA_MAP_BENCH_SINGLE_MODE, DMA_MAP_BENCH_SG_MODE);
+		exit(1);
+	}
+
 	if (threads <= 0 || threads > DMA_MAP_MAX_THREADS) {
 		fprintf(stderr, "invalid number of threads, must be in 1-%d\n",
 			DMA_MAP_MAX_THREADS);
@@ -110,14 +126,15 @@ int main(int argc, char **argv)
 	map.dma_dir = dir;
 	map.dma_trans_ns = xdelay;
 	map.granule = granule;
+	map.map_mode = map_mode;
 
 	if (ioctl(fd, cmd, &map)) {
 		perror("ioctl");
 		exit(1);
 	}
 
-	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
-			threads, seconds, node, directions[dir], granule);
+	printf("dma mapping benchmark(%s): threads:%d seconds:%d node:%d dir:%s granule:%d\n",
+			mode[map_mode], threads, seconds, node, directions[dir], granule);
 	printf("average map latency(us):%.1f standard deviation:%.1f\n",
 			map.avg_map_100ns/10.0, map.map_stddev/10.0);
 	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
-- 
2.33.0

