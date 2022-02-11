Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9287CC433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 04:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1571A8316F;
	Fri, 11 Feb 2022 04:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJDpAm0CQoSS; Fri, 11 Feb 2022 04:22:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8C31E83122;
	Fri, 11 Feb 2022 04:22:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F133C0011;
	Fri, 11 Feb 2022 04:22:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30340C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 04:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86E5240033
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 04:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W7JIkl0inANm for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 04:22:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1823C41609
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 04:22:51 +0000 (UTC)
Received: from dggeme710-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jw0n52fbkzbjhR;
 Fri, 11 Feb 2022 12:21:45 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggeme710-chm.china.huawei.com (10.1.199.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 11 Feb 2022 12:22:47 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2308.021;
 Fri, 11 Feb 2022 12:22:47 +0800
To: "tiantao (H)" <tiantao6@hisilicon.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "chenxiang (M)" <chenxiang66@hisilicon.com>, "hch@lst.de"
 <hch@lst.de>
Subject: RE: [PATCH] dma-mapping: benchmark: Extract a common header file for
 map_benchmark definition
Thread-Topic: [PATCH] dma-mapping: benchmark: Extract a common header file for
 map_benchmark definition
Thread-Index: AQHYHvWApYD8MtmT3EOTxi6q+ybr5ayNvbrw
Date: Fri, 11 Feb 2022 04:22:47 +0000
Message-ID: <d3dd5f61efcb41c981b0971e128da907@hisilicon.com>
References: <20220211031441.41126-1-tiantao6@hisilicon.com>
In-Reply-To: <20220211031441.41126-1-tiantao6@hisilicon.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.29]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
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
From: "Song Bao Hua \(Barry Song\) via iommu"
 <iommu@lists.linux-foundation.org>
Reply-To: "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: tiantao (H)
> Sent: Friday, February 11, 2022 4:15 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; shuah@kernel.org;
> chenxiang (M) <chenxiang66@hisilicon.com>
> Cc: iommu@lists.linux-foundation.org; linux-kselftest@vger.kernel.org;
> linuxarm@openeuler.org
> Subject: [PATCH] dma-mapping: benchmark: Extract a common header file for
> map_benchmark definition
> 
> kernel/dma/map_benchmark.c and selftests/dma/dma_map_benchmark.c
> have duplicate map_benchmark definitions, which tends to lead to
> inconsistent changes to map_benchmark on both sides, extract a
> common header file to avoid this problem.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

+To: Christoph

Looks like a right cleanup. This will help decrease the maintain
overhead in the future. Other similar selftests tools are also
doing this.

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  kernel/dma/map_benchmark.c                    | 24 +-------------
>  kernel/dma/map_benchmark.h                    | 31 +++++++++++++++++++
>  .../testing/selftests/dma/dma_map_benchmark.c | 25 +--------------
>  3 files changed, 33 insertions(+), 47 deletions(-)
>  create mode 100644 kernel/dma/map_benchmark.h
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 9b9af1bd6be3..c05f4e242991 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -18,29 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/timekeeping.h>
> 
> -#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
> -#define DMA_MAP_MAX_THREADS	1024
> -#define DMA_MAP_MAX_SECONDS	300
> -#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC)
> -
> -#define DMA_MAP_BIDIRECTIONAL	0
> -#define DMA_MAP_TO_DEVICE	1
> -#define DMA_MAP_FROM_DEVICE	2
> -
> -struct map_benchmark {
> -	__u64 avg_map_100ns; /* average map latency in 100ns */
> -	__u64 map_stddev; /* standard deviation of map latency */
> -	__u64 avg_unmap_100ns; /* as above */
> -	__u64 unmap_stddev;
> -	__u32 threads; /* how many threads will do map/unmap in parallel */
> -	__u32 seconds; /* how long the test will last */
> -	__s32 node; /* which numa node this benchmark will run on */
> -	__u32 dma_bits; /* DMA addressing capability */
> -	__u32 dma_dir; /* DMA data direction */
> -	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> -	__u32 granule;	/* how many PAGE_SIZE will do map/unmap once a time */
> -	__u8 expansion[76];	/* For future use */
> -};
> +#include "map_benchmark.h"
> 
>  struct map_benchmark_data {
>  	struct map_benchmark bparam;
> diff --git a/kernel/dma/map_benchmark.h b/kernel/dma/map_benchmark.h
> new file mode 100644
> index 000000000000..62674c83bde4
> --- /dev/null
> +++ b/kernel/dma/map_benchmark.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2022 HiSilicon Limited.
> + */
> +
> +#ifndef _KERNEL_DMA_BENCHMARK_H
> +#define _KERNEL_DMA_BENCHMARK_H
> +
> +#define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
> +#define DMA_MAP_MAX_THREADS     1024
> +#define DMA_MAP_MAX_SECONDS     300
> +#define DMA_MAP_MAX_TRANS_DELAY (10 * NSEC_PER_MSEC)
> +
> +#define DMA_MAP_BIDIRECTIONAL   0
> +#define DMA_MAP_TO_DEVICE       1
> +#define DMA_MAP_FROM_DEVICE     2
> +
> +struct map_benchmark {
> +	__u64 avg_map_100ns; /* average map latency in 100ns */
> +	__u64 map_stddev; /* standard deviation of map latency */
> +	__u64 avg_unmap_100ns; /* as above */
> +	__u64 unmap_stddev;
> +	__u32 threads; /* how many threads will do map/unmap in parallel */
> +	__u32 seconds; /* how long the test will last */
> +	__s32 node; /* which numa node this benchmark will run on */
> +	__u32 dma_bits; /* DMA addressing capability */
> +	__u32 dma_dir; /* DMA data direction */
> +	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> +	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
> +};
> +#endif /* _KERNEL_DMA_BENCHMARK_H */
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c
> b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 485dff51bad2..33bf073071aa 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -11,39 +11,16 @@
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  #include <linux/types.h>
> +#include "../../../../kernel/dma/map_benchmark.h"
> 
>  #define NSEC_PER_MSEC	1000000L
> 
> -#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
> -#define DMA_MAP_MAX_THREADS	1024
> -#define DMA_MAP_MAX_SECONDS     300
> -#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC)
> -
> -#define DMA_MAP_BIDIRECTIONAL	0
> -#define DMA_MAP_TO_DEVICE	1
> -#define DMA_MAP_FROM_DEVICE	2
> -
>  static char *directions[] = {
>  	"BIDIRECTIONAL",
>  	"TO_DEVICE",
>  	"FROM_DEVICE",
>  };
> 
> -struct map_benchmark {
> -	__u64 avg_map_100ns; /* average map latency in 100ns */
> -	__u64 map_stddev; /* standard deviation of map latency */
> -	__u64 avg_unmap_100ns; /* as above */
> -	__u64 unmap_stddev;
> -	__u32 threads; /* how many threads will do map/unmap in parallel */
> -	__u32 seconds; /* how long the test will last */
> -	__s32 node; /* which numa node this benchmark will run on */
> -	__u32 dma_bits; /* DMA addressing capability */
> -	__u32 dma_dir; /* DMA data direction */
> -	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> -	__u32 granule; /* how many PAGE_SIZE will do map/unmap once a time */
> -	__u8 expansion[76];	/* For future use */
> -};
> -
>  int main(int argc, char **argv)
>  {
>  	struct map_benchmark map;
> --
> 2.33.0

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
