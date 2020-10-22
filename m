Return-Path: <SRS0=at/m=D5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30C9C4363A
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 18:06:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EB124641
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 18:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EB124641
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C23A869A9;
	Thu, 22 Oct 2020 18:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X9ETZJ5P2A-u; Thu, 22 Oct 2020 18:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D344D86B77;
	Thu, 22 Oct 2020 18:06:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE966C0052;
	Thu, 22 Oct 2020 18:06:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08B8EC0051
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 18:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DC129203C7
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 18:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 42tT6zG-8neA for <iommu@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 18:06:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id C255F203BB
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 18:06:39 +0000 (UTC)
Received: from gaia (unknown [95.145.162.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7BDE32225F;
 Thu, 22 Oct 2020 18:06:36 +0000 (UTC)
Date: Thu, 22 Oct 2020 19:06:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v4 5/7] arm64: mm: Set ZONE_DMA size based on
 devicetree's dma-ranges
Message-ID: <20201022180632.GI1229@gaia>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
 <20201021123437.21538-6-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201021123437.21538-6-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, ardb@kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
 robin.murphy@arm.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
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

On Wed, Oct 21, 2020 at 02:34:35PM +0200, Nicolas Saenz Julienne wrote:
> @@ -188,9 +186,11 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>  static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> +	unsigned int __maybe_unused dt_zone_dma_bits;
>  
>  #ifdef CONFIG_ZONE_DMA
> -	zone_dma_bits = ARM64_ZONE_DMA_BITS;
> +	dt_zone_dma_bits = ilog2(of_dma_get_max_cpu_address(NULL));
> +	zone_dma_bits = min(32U, dt_zone_dma_bits);

A thought: can we remove the min here and expand ZONE_DMA to whatever
dt_zone_dma_bits says? More on this below.

>  	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif

I was talking earlier to Ard and Robin on the ZONE_DMA32 history and the
need for max_zone_phys(). This was rather theoretical, the Seattle
platform has all RAM starting above 4GB and that led to an empty
ZONE_DMA32 originally. The max_zone_phys() hack was meant to lift
ZONE_DMA32 into the bottom of the RAM, on the assumption that such
32-bit devices would have a DMA offset hardwired. We are not aware of
any such case on arm64 systems and even on Seattle, IIUC 32-bit devices
only work if they are behind an SMMU (so no hardwired offset).

In hindsight, it would have made more sense on platforms with RAM above
4GB to expand ZONE_DMA32 to cover the whole memory (so empty
ZONE_NORMAL). Something like:

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a53c1e0fb017..7d5e3dd85617 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -187,8 +187,12 @@ static void __init reserve_elfcorehdr(void)
  */
 static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
 {
-	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, zone_bits);
-	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
+	phys_addr_t zone_mask = 1ULL << zone_bits;
+
+	if (!(memblock_start_of_DRAM() & zone_mask))
+		zone_mask = PHYS_ADDR_MAX;
+
+	return min(zone_mask, memblock_end_of_DRAM());
 }
 
 static void __init zone_sizes_init(unsigned long min, unsigned long max)

I don't think this makes any difference for ZONE_DMA unless a
broken DT or IORT reports the max CPU address below the start of DRAM.

There's a minor issue if of_dma_get_max_cpu_address() matches
memblock_end_of_DRAM() but they are not a power of 2. We'd be left with
a bit of RAM at the end in ZONE_NORMAL due to ilog2 truncation.

-- 
Catalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
