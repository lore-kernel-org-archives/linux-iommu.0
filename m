Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3738F236
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012300; cv=none; b=fAGCz1yo356o+hhtl1MKiw/+SnPt6MbnGQEdjMF4oCw1ypXumDT0ygQhpDpF2nXpQ3IdhAR90kczLyyguSw+viz6LcuJJOOfbTK9D5APXdiR/MizT0wc//OLMWmQ3fKZKoEKr0Sdbz9Mc37v4BCB4dJ43pmfFeOdcy3FMXvXf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012300; c=relaxed/simple;
	bh=o5giisC0eR1Etm7ex4LQeambEh6+osWzZOSCCYoil/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVXOzSRHjThvRTLZ4HRkjDvplXPN8SzoTdLMHdudOLVezaiRfBKVasAxEBGCT4RCnQwRteBl9MzxB1OS629vcaktMKirITC/3VJ0t92A0nCJgpr222M9zYORzQBYxOmKpF/WGPDBlEzDZX/IuSRZhcO/I9Lt+iNKavheng1e4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=y6RWnYt7; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="y6RWnYt7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=laKNEJEcYRRFTe5cTeSLN7zYecF5SpG633uce2FkGY8=;
	b=y6RWnYt76qbqb6CnDfQLEbONOdzof6iFi3qoykW9f3DqaLsJQpTV4wtuLwMjLu3Qsl46WSaHf
	4E+m920qdDdn0oPsFjb9LXicHZtwukNOvk+B6QwAKNpFvgFGJlas9RFIFyj1j1pm8xw1caamTQK
	RnaXFQgAwsQxxoUIxVqhTnk=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fLTsz0KfbznTVV;
	Wed, 25 Feb 2026 17:33:27 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id B55DE40363;
	Wed, 25 Feb 2026 17:38:07 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Feb 2026 17:38:07 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <jonathan.cameron@huawei.com>,
	<wangzhou1@hisilicon.com>, <xiaqinxin@huawei.com>
CC: <iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>, Barry Song
	<baohua@kernel.org>
Subject: [PATCH v7 3/3] tools/dma: Add dma_map_sg support
Date: Wed, 25 Feb 2026 17:38:00 +0800
Message-ID: <20260225093800.3625054-4-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260225093800.3625054-1-xiaqinxin@huawei.com>
References: <20260225093800.3625054-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
index dd0ed528e6df..eab0ac611a23 100644
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

