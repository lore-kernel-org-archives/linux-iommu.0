Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F90CC388F2
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 09:22:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D522121D91
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 09:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D522121D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3F44187351;
	Mon,  2 Nov 2020 09:22:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsmvREZVBoBa; Mon,  2 Nov 2020 09:22:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2901287347;
	Mon,  2 Nov 2020 09:22:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19FB3C088B;
	Mon,  2 Nov 2020 09:22:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C7B8C0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 09:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3E75B204A5
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 09:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kZ9xcyi661A6 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 09:22:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id 8577820496
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 09:22:27 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 514D0E9FB9041C93B2E0;
 Mon,  2 Nov 2020 09:22:24 +0000 (GMT)
Received: from [10.47.5.1] (10.47.5.1) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 2 Nov 2020
 09:22:23 +0000
Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
To: Barry Song <song.bao.hua@hisilicon.com>,
 <iommu@lists.linux-foundation.org>, <hch@lst.de>, <robin.murphy@arm.com>,
 <m.szyprowski@samsung.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <184797b8-512e-e3da-fae7-25c7d662648b@huawei.com>
Date: Mon, 2 Nov 2020 09:18:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201102080646.2180-2-song.bao.hua@hisilicon.com>
Content-Language: en-US
X-Originating-IP: [10.47.5.1]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linuxarm@huawei.com, xuwei5@huawei.com, Will Deacon <will@kernel.org>
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

On 02/11/2020 08:06, Barry Song wrote:
> Nowadays, there are increasing requirements to benchmark the performance
> of dma_map and dma_unmap particually while the device is attached to an
> IOMMU.
> 
> This patch enables the support. Users can run specified number of threads
> to do dma_map_page and dma_unmap_page on a specific NUMA node with the
> specified duration. Then dma_map_benchmark will calculate the average
> latency for map and unmap.
> 
> A difficulity for this benchmark is that dma_map/unmap APIs must run on
> a particular device. Each device might have different backend of IOMMU or
> non-IOMMU.
> 
> So we use the driver_override to bind dma_map_benchmark to a particual
> device by:
> For platform devices:
> echo dma_map_benchmark > /sys/bus/platform/devices/xxx/driver_override
> echo xxx > /sys/bus/platform/drivers/xxx/unbind
> echo xxx > /sys/bus/platform/drivers/dma_map_benchmark/bind
> 
> For PCI devices:
> echo dma_map_benchmark > /sys/bus/pci/devices/0000:00:01.0/driver_override
> echo 0000:00:01.0 > /sys/bus/pci/drivers/xxx/unbind
> echo 0000:00:01.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
> -v3:
>    * fix build issues reported by 0day kernel test robot
> -v2:
>    * add PCI support; v1 supported platform devices only
>    * replace ssleep by msleep_interruptible() to permit users to exit
>      benchmark before it is completed
>    * many changes according to Robin's suggestions, thanks! Robin
>      - add standard deviation output to reflect the worst case
>      - check users' parameters strictly like the number of threads
>      - make cache dirty before dma_map
>      - fix unpaired dma_map_page and dma_unmap_single;
>      - remove redundant "long long" before ktime_to_ns();
>      - use devm_add_action()
> 
>   kernel/dma/Kconfig         |   8 +
>   kernel/dma/Makefile        |   1 +
>   kernel/dma/map_benchmark.c | 296 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 305 insertions(+)
>   create mode 100644 kernel/dma/map_benchmark.c
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index c99de4a21458..949c53da5991 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -225,3 +225,11 @@ config DMA_API_DEBUG_SG
>   	  is technically out-of-spec.
>   
>   	  If unsure, say N.
> +
> +config DMA_MAP_BENCHMARK
> +	bool "Enable benchmarking of streaming DMA mapping"
> +	help
> +	  Provides /sys/kernel/debug/dma_map_benchmark that helps with testing
> +	  performance of dma_(un)map_page.

Since this is a driver, any reason for which it cannot be loadable? If 
so, it seems any functionality would depend on DEBUG FS, I figure that's 
just how we work for debugfs.

Thanks,
John

> +
> +	  See tools/testing/selftests/dma/dma_map_benchmark.c
> diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
> index dc755ab68aab..7aa6b26b1348 100644
> --- a/kernel/dma/Makefile
> +++ b/kernel/dma/Makefile
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
