Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F948C07E95
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 19:17:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B69611AB
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 19:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B69611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82070401B1;
	Tue, 13 Jul 2021 19:17:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kheQHoRgTgb; Tue, 13 Jul 2021 19:17:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F32940003;
	Tue, 13 Jul 2021 19:17:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09915C001A;
	Tue, 13 Jul 2021 19:17:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04483C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 19:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E62A9405F0
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 19:17:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LQIFjnCxRnV1 for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 19:17:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C5EB400A9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 19:17:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5B321FB;
 Tue, 13 Jul 2021 12:17:48 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6656F3F7D8;
 Tue, 13 Jul 2021 12:17:46 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] iommu: io-pgtable: add DART pagetable format
To: Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-2-sven@svenpeter.dev>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e7dd955b-ae6b-bd1f-bf1f-4a1df61f1fc6@arm.com>
Date: Tue, 13 Jul 2021 20:17:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627143405.77298-2-sven@svenpeter.dev>
Content-Language: en-GB
Cc: Arnd Bergmann <arnd@kernel.org>, r.czerwinski@pengutronix.de,
 devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org,
 Stan Skowronek <stan@corellium.com>
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

On 2021-06-27 15:34, Sven Peter wrote:
> Apple's DART iommu uses a pagetable format that shares some
> similarities with the ones already implemented by io-pgtable.c.
> Add a new format variant to support the required differences
> so that we don't have to duplicate the pagetable handling code.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>   drivers/iommu/io-pgtable-arm.c | 62 ++++++++++++++++++++++++++++++++++
>   drivers/iommu/io-pgtable.c     |  1 +
>   include/linux/io-pgtable.h     |  7 ++++
>   3 files changed, 70 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 87def58e79b5..1dd5c45b4b5b 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -127,6 +127,9 @@
>   #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
>   #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
>   
> +#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
> +#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
> +
>   /* IOPTE accessors */
>   #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
>   
> @@ -381,6 +384,15 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>   {
>   	arm_lpae_iopte pte;
>   
> +	if (data->iop.fmt == ARM_APPLE_DART) {
> +		pte = 0;
> +		if (!(prot & IOMMU_WRITE))
> +			pte |= APPLE_DART_PTE_PROT_NO_WRITE;
> +		if (!(prot & IOMMU_READ))
> +			pte |= APPLE_DART_PTE_PROT_NO_READ;
> +		return pte;
> +	}
> +
>   	if (data->iop.fmt == ARM_64_LPAE_S1 ||
>   	    data->iop.fmt == ARM_32_LPAE_S1) {
>   		pte = ARM_LPAE_PTE_nG;
> @@ -1043,6 +1055,51 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>   	return NULL;
>   }
>   
> +static struct io_pgtable *
> +apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> +{
> +	struct arm_lpae_io_pgtable *data;
> +	int i;
> +
> +	if (cfg->oas > 36)
> +		return NULL;
> +
> +	data = arm_lpae_alloc_pgtable(cfg);
> +	if (!data)
> +		return NULL;
> +
> +	/*
> +	 * Apple's DART always requires three levels with the first level being
> +	 * stored in four MMIO registers. We always concatenate the first and
> +	 * second level so that we only have to setup the MMIO registers once.
> +	 * This results in an effective two level pagetable.
> +	 */

Nit: I appreciate the effort to document the weirdness, but this comment 
did rather mislead me initially, and now that I (think I) understand how 
things work it seems a bit backwards. Could we say something like:

   "The table format itself always uses two levels, but the total VA
    space is mapped by four separate tables, making the MMIO registers
    an effective "level 1". For simplicity, though, we treat this
    equivalently to LPAE stage 2 concatenation at level 2, with the
    additional TTBRs each just pointing at consecutive pages."

?

> +	if (data->start_level < 1)
> +		return NULL;
> +	if (data->start_level == 1 && data->pgd_bits > 2)
> +		return NULL;
> +	if (data->start_level > 1)
> +		data->pgd_bits = 0;
> +	data->start_level = 2;
> +	cfg->apple_dart_cfg.n_ttbrs = 1 << data->pgd_bits;
> +	data->pgd_bits += data->bits_per_level;
> +
> +	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
> +					   cfg);
> +	if (!data->pgd)
> +		goto out_free_data;
> +
> +	for (i = 0; i < cfg->apple_dart_cfg.n_ttbrs; ++i)
> +		cfg->apple_dart_cfg.ttbr[i] =
> +			virt_to_phys(data->pgd + i * ARM_LPAE_GRANULE(data));
> +
> +	return &data->iop;
> +
> +out_free_data:
> +	kfree(data);
> +	return NULL;
> +}
> +
>   struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
>   	.alloc	= arm_64_lpae_alloc_pgtable_s1,
>   	.free	= arm_lpae_free_pgtable,
> @@ -1068,6 +1125,11 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
>   	.free	= arm_lpae_free_pgtable,
>   };
>   
> +struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns = {
> +	.alloc	= apple_dart_alloc_pgtable,
> +	.free	= arm_lpae_free_pgtable,
> +};
> +
>   #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
>   
>   static struct io_pgtable_cfg *cfg_cookie __initdata;
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index 6e9917ce980f..fd8e6bd6caf9 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -20,6 +20,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
>   	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
>   	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
>   	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
> +	[ARM_APPLE_DART] = &io_pgtable_apple_dart_init_fns,
>   #endif
>   #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
>   	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 4d40dfa75b55..a4bfac7f85f7 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -16,6 +16,7 @@ enum io_pgtable_fmt {
>   	ARM_V7S,
>   	ARM_MALI_LPAE,
>   	AMD_IOMMU_V1,
> +	ARM_APPLE_DART,

s/ARM_// - this is pure Apple ;)

With that fixed and hopefully a somewhat clarified comment above,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   	IO_PGTABLE_NUM_FMTS,
>   };
>   
> @@ -136,6 +137,11 @@ struct io_pgtable_cfg {
>   			u64	transtab;
>   			u64	memattr;
>   		} arm_mali_lpae_cfg;
> +
> +		struct {
> +			u64 ttbr[4];
> +			u32 n_ttbrs;
> +		} apple_dart_cfg;
>   	};
>   };
>   
> @@ -246,5 +252,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
> +extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
>   
>   #endif /* __IO_PGTABLE_H */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
