Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EEFC433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 09:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C57B61314;
	Thu, 30 Jun 2022 09:02:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C57B61314
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GyUNzxMQb6jJ; Thu, 30 Jun 2022 09:02:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A7C060B35;
	Thu, 30 Jun 2022 09:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A7C060B35
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A027C0021;
	Thu, 30 Jun 2022 09:02:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87CBAC0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 576E784035
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:02:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 576E784035
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KFv3ugcc32Go for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 09:02:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A1E584012
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A1E584012
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:02:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92B291063;
 Thu, 30 Jun 2022 02:02:07 -0700 (PDT)
Received: from [10.57.85.25] (unknown [10.57.85.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C38B93F5A1;
 Thu, 30 Jun 2022 02:02:05 -0700 (PDT)
Message-ID: <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
Date: Thu, 30 Jun 2022 10:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Content-Language: en-GB
To: Feng Tang <feng.tang@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Vlastimil Babka <vbabka@suse.cz>
References: <20220630073304.26945-1-feng.tang@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220630073304.26945-1-feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Paul Menzel <pmenzel@molgen.mpg.de>
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

On 2022-06-30 08:33, Feng Tang wrote:
> kmalloc will round up the request size to power of 2, and current
> iova_magazine's size is 1032 (1024+8) bytes, so each instance
> allocated will get 2048 bytes from kmalloc, causing around 1KB
> waste.
> 
> And in some exstreme case, the memory wasted can trigger OOM as
> reported in 2019 on a crash kernel with 256 MB memory [1].

I don't think it really needs pointing out that excessive memory 
consumption can cause OOM. Especially not in the particularly silly 
context of a system with only 2MB of RAM per CPU - that's pretty much 
guaranteed to be doomed one way or another.

>    [    4.319253] iommu: Adding device 0000:06:00.2 to group 5
>    [    4.325869] iommu: Adding device 0000:20:01.0 to group 15
>    [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
>    [    4.338946] swapper/0 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
>    [    4.350251] swapper/0 cpuset=/ mems_allowed=0
>    [    4.354618] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.57.mx64.282 #1
>    [    4.355612] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.9.3 06/25/2019
>    [    4.355612] Call Trace:
>    [    4.355612]  dump_stack+0x46/0x5b
>    [    4.355612]  dump_header+0x6b/0x289
>    [    4.355612]  out_of_memory+0x470/0x4c0
>    [    4.355612]  __alloc_pages_nodemask+0x970/0x1030
>    [    4.355612]  cache_grow_begin+0x7d/0x520
>    [    4.355612]  fallback_alloc+0x148/0x200
>    [    4.355612]  kmem_cache_alloc_trace+0xac/0x1f0
>    [    4.355612]  init_iova_domain+0x112/0x170
>    [    4.355612]  amd_iommu_domain_alloc+0x138/0x1a0
>    [    4.355612]  iommu_group_get_for_dev+0xc4/0x1a0
>    [    4.355612]  amd_iommu_add_device+0x13a/0x610
>    [    4.355612]  add_iommu_group+0x20/0x30
>    [    4.355612]  bus_for_each_dev+0x76/0xc0
>    [    4.355612]  bus_set_iommu+0xb6/0xf0
>    [    4.355612]  amd_iommu_init_api+0x112/0x132
>    [    4.355612]  state_next+0xfb1/0x1165
>    [    4.355612]  amd_iommu_init+0x1f/0x67
>    [    4.355612]  pci_iommu_init+0x16/0x3f
>    ...
>    [    4.670295] Unreclaimable slab info:
>    ...
>    [    4.857565] kmalloc-2048           59164KB      59164KB
> 
> Change IOVA_MAG_SIZE from 128 to 127 to make size of 'iova_magazine'
> 1024 bytes so that no memory will be wasted.
> 
> [1]. https://lkml.org/lkml/2019/8/12/266
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>   drivers/iommu/iova.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index db77aa675145b..27634ddd9b904 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -614,7 +614,12 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>    * dynamic size tuning described in the paper.
>    */
>   
> -#define IOVA_MAG_SIZE 128
> +/*
> + * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
> + * assure size of 'iova_magzine' to be 1024 bytes, so that no memory

Typo: iova_magazine

> + * will be wasted.
> + */
> +#define IOVA_MAG_SIZE 127

The change itself seems perfectly reasonable, though.

Acked-by: Robin Murphy <robin.murphy@arm.com>

>   #define MAX_GLOBAL_MAGS 32	/* magazines per bin */
>   
>   struct iova_magazine {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
