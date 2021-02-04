Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078B3C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 23:50:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A16164FA4
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 23:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A16164FA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E4BEB86931;
	Thu,  4 Feb 2021 23:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iYdhrwVr_ogU; Thu,  4 Feb 2021 23:50:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 05306868EF;
	Thu,  4 Feb 2021 23:50:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2ECBC07FD;
	Thu,  4 Feb 2021 23:50:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D38BC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7712986DBB
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MYIJALwszwmc for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 23:50:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 498F486DB5
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:50:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8822FD6E;
 Thu,  4 Feb 2021 15:50:39 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C5C63F719;
 Thu,  4 Feb 2021 15:50:38 -0800 (PST)
Subject: Re: [PATCH] dma-mapping: benchmark: pretend DMA is transmitting
To: Barry Song <song.bao.hua@hisilicon.com>, m.szyprowski@samsung.com,
 hch@lst.de, iommu@lists.linux-foundation.org
References: <20210204225847.8884-1-song.bao.hua@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8d714a55-7bbc-128e-3e39-492ebf204223@arm.com>
Date: Thu, 4 Feb 2021 23:50:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204225847.8884-1-song.bao.hua@hisilicon.com>
Content-Language: en-GB
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-02-04 22:58, Barry Song wrote:
> In a real dma mapping user case, after dma_map is done, data will be
> transmit. Thus, in multi-threaded user scenario, IOMMU contention
> should not be that severe. For example, if users enable multiple
> threads to send network packets through 1G/10G/100Gbps NIC, usually
> the steps will be: map -> transmission -> unmap.  Transmission delay
> reduces the contention of IOMMU. Here a delay is added to simulate
> the transmission for TX case so that the tested result could be
> more accurate.
> 
> RX case would be much more tricky. It is not supported yet.

I guess it might be a reasonable approximation to map several pages, 
then unmap them again after a slightly more random delay. Or maybe 
divide the threads into pairs of mappers and unmappers respectively 
filling up and draining proper little buffer pools.

> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   kernel/dma/map_benchmark.c                      | 11 +++++++++++
>   tools/testing/selftests/dma/dma_map_benchmark.c | 17 +++++++++++++++--
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 1b1b8ff875cb..1976db7e34e4 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -21,6 +21,7 @@
>   #define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
>   #define DMA_MAP_MAX_THREADS	1024
>   #define DMA_MAP_MAX_SECONDS	300
> +#define DMA_MAP_MAX_TRANS_DELAY	(10 * 1000 * 1000) /* 10ms */

Using MSEC_PER_SEC might be sufficiently self-documenting?

>   #define DMA_MAP_BIDIRECTIONAL	0
>   #define DMA_MAP_TO_DEVICE	1
> @@ -36,6 +37,7 @@ struct map_benchmark {
>   	__s32 node; /* which numa node this benchmark will run on */
>   	__u32 dma_bits; /* DMA addressing capability */
>   	__u32 dma_dir; /* DMA data direction */
> +	__u32 dma_trans_ns; /* time for DMA transmission in ns */
>   	__u64 expansion[10];	/* For future use */
>   };
>   
> @@ -87,6 +89,10 @@ static int map_benchmark_thread(void *data)
>   		map_etime = ktime_get();
>   		map_delta = ktime_sub(map_etime, map_stime);
>   
> +		/* Pretend DMA is transmitting */
> +		if (map->dir != DMA_FROM_DEVICE)
> +			ndelay(map->bparam.dma_trans_ns);

TBH I think the option of a fixed delay between map and unmap might be a 
handy thing in general, so having the direction check at all seems 
needlessly restrictive. As long as the driver implements all the basic 
building blocks, combining them to simulate specific traffic patterns 
can be left up to the benchmark tool.

Robin.

> +
>   		unmap_stime = ktime_get();
>   		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE, map->dir);
>   		unmap_etime = ktime_get();
> @@ -218,6 +224,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
>   			return -EINVAL;
>   		}
>   
> +		if (map->bparam.dma_trans_ns > DMA_MAP_MAX_TRANS_DELAY) {
> +			pr_err("invalid transmission delay\n");
> +			return -EINVAL;
> +		}
> +
>   		if (map->bparam.node != NUMA_NO_NODE &&
>   		    !node_possible(map->bparam.node)) {
>   			pr_err("invalid numa node\n");
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 7065163a8388..dbf426e2fb7f 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -14,6 +14,7 @@
>   #define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
>   #define DMA_MAP_MAX_THREADS	1024
>   #define DMA_MAP_MAX_SECONDS     300
> +#define DMA_MAP_MAX_TRANS_DELAY	(10 * 1000 * 1000) /* 10ms */
>   
>   #define DMA_MAP_BIDIRECTIONAL	0
>   #define DMA_MAP_TO_DEVICE	1
> @@ -35,6 +36,7 @@ struct map_benchmark {
>   	__s32 node; /* which numa node this benchmark will run on */
>   	__u32 dma_bits; /* DMA addressing capability */
>   	__u32 dma_dir; /* DMA data direction */
> +	__u32 dma_trans_ns; /* delay for DMA transmission in ns */
>   	__u64 expansion[10];	/* For future use */
>   };
>   
> @@ -45,12 +47,12 @@ int main(int argc, char **argv)
>   	/* default single thread, run 20 seconds on NUMA_NO_NODE */
>   	int threads = 1, seconds = 20, node = -1;
>   	/* default dma mask 32bit, bidirectional DMA */
> -	int bits = 32, dir = DMA_MAP_BIDIRECTIONAL;
> +	int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
>   
>   	int cmd = DMA_MAP_BENCHMARK;
>   	char *p;
>   
> -	while ((opt = getopt(argc, argv, "t:s:n:b:d:")) != -1) {
> +	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:")) != -1) {
>   		switch (opt) {
>   		case 't':
>   			threads = atoi(optarg);
> @@ -67,6 +69,9 @@ int main(int argc, char **argv)
>   		case 'd':
>   			dir = atoi(optarg);
>   			break;
> +		case 'x':
> +			xdelay = atoi(optarg);
> +			break;
>   		default:
>   			return -1;
>   		}
> @@ -84,6 +89,12 @@ int main(int argc, char **argv)
>   		exit(1);
>   	}
>   
> +	if (xdelay < 0 || xdelay > DMA_MAP_MAX_TRANS_DELAY) {
> +		fprintf(stderr, "invalid transmit delay, must be in 0-%d\n",
> +			DMA_MAP_MAX_TRANS_DELAY);
> +		exit(1);
> +	}
> +
>   	/* suppose the mininum DMA zone is 1MB in the world */
>   	if (bits < 20 || bits > 64) {
>   		fprintf(stderr, "invalid dma mask bit, must be in 20-64\n");
> @@ -107,6 +118,8 @@ int main(int argc, char **argv)
>   	map.node = node;
>   	map.dma_bits = bits;
>   	map.dma_dir = dir;
> +	map.dma_trans_ns = xdelay;
> +
>   	if (ioctl(fd, cmd, &map)) {
>   		perror("ioctl");
>   		exit(1);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
