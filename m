Return-Path: <SRS0=aUVl=TX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8A6C46460
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 07:35:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB0B21873
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 07:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YmSS0LMu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NzFOjevD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB0B21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A2F23CC4;
	Thu, 23 May 2019 07:35:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 07C11CC0
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 07:35:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6B3096C5
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 07:35:19 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2A62660E5D; Thu, 23 May 2019 07:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1558596919;
	bh=vaYCSPJNKOnJfhfTph1DKToRlp8mANwQb3rgvaGrh04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YmSS0LMu9w6hsfu3aVZgHUEaRW8oWTnMJAzblNdOS+NasujHP41YkFXeHcp3W1BNk
	VOF5JIpSsmnteLqtd73ijOAykKpEg1liraJLoWNhpbKKos0+oTsJm8ZO9rbihp0a71
	S06M4y3knEWtLXJbagbIW1cotSYtk/OCA0bvLQrM=
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
	[209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id DC3FB60F3F
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 07:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1558596916;
	bh=vaYCSPJNKOnJfhfTph1DKToRlp8mANwQb3rgvaGrh04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NzFOjevDj2yTKcBgxOOXOebaoVz64Tm7Nu1RhPaSdKqVOxzt09hwwQalYCp1h8KML
	erpHyl0S2pX4h6mtSCkQExeRJuQZjiwZxUks1aj1LlOwE1zNhtRfoMEv8ndiwsWqsW
	Cy+pSUv+wZnxZapyUMsH1O8wIxvZY9vi20Kg1JKY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC3FB60F3F
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f49.google.com with SMTP id m4so7788213edd.8
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 00:35:15 -0700 (PDT)
X-Gm-Message-State: APjAAAWroTOX9QH6LE6HZo70iG7HwwMyRIz50I8qlMNplGDDpSHAQBH8
	9eJx9zKjdXJpE0MSoUvmoeuS8ec1MwOyT7gEW9s=
X-Google-Smtp-Source: APXvYqxwK48xR/Y7oFZmW0R1iQATtHnSPbVuSjvhCBcsA/CK/DWYQxHabWtrJ11BQGSLmPAhAsILj7d0UtX1rXbzkKY=
X-Received: by 2002:a50:9958:: with SMTP id l24mr95862736edb.92.1558596914222; 
	Thu, 23 May 2019 00:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190516093020.18028-1-vivek.gautam@codeaurora.org>
In-Reply-To: <20190516093020.18028-1-vivek.gautam@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Thu, 23 May 2019 13:05:03 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGgXQ4wg7+rnchfd-4vQEiS5FLoRTVELN6qieC6DjE1HA@mail.gmail.com>
Message-ID: <CAFp+6iGgXQ4wg7+rnchfd-4vQEiS5FLoRTVELN6qieC6DjE1HA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] iommu/io-pgtable-arm: Add support to use system
	cache
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <joro@8bytes.org>, 
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, pratikp@codeaurora.org,
	open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, pdaly@codeaurora.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Robin,



On Thu, May 16, 2019 at 3:00 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Few Qualcomm platforms such as, sdm845 have an additional outer
> cache called as System cache, aka. Last level cache (LLC) that
> allows non-coherent devices to upgrade to using caching.
> This cache sits right before the DDR, and is tightly coupled
> with the memory controller. The clients using this cache request
> their slices from this system cache, make it active, and can then
> start using it.
>
> There is a fundamental assumption that non-coherent devices can't
> access caches. This change adds an exception where they *can* use
> some level of cache despite still being non-coherent overall.
> The coherent devices that use cacheable memory, and CPU make use of
> this system cache by default.
>
> Looking at memory types, we have following -
> a) Normal uncached :- MAIR 0x44, inner non-cacheable,
>                       outer non-cacheable;
> b) Normal cached :-   MAIR 0xff, inner read write-back non-transient,
>                       outer read write-back non-transient;
>                       attribute setting for coherenet I/O devices.
> and, for non-coherent i/o devices that can allocate in system cache
> another type gets added -
> c) Normal sys-cached :- MAIR 0xf4, inner non-cacheable,
>                         outer read write-back non-transient
>
> Coherent I/O devices use system cache by marking the memory as
> normal cached.
> Non-coherent I/O devices should mark the memory as normal
> sys-cached in page tables to use system cache.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---

Let me know if there's more to improve on this patch.

Best regards
Vivek

>
> V3 version of this patch and related series can be found at [1].
> V4 of this patch is available at [2].
>
> The example usage of how a smmu master can make use of this protection
> flag and set the correct memory attributes to start using system cache,
> can be found at [3]; and here at [3] IOMMU_UPSTREAM_HINT is same as
> IOMMU_QCOM_SYS_CACHE.
>
> Changes since v4:
>  - Changed ARM_LPAE_MAIR_ATTR_QCOM_SYS_CACHE to
>    ARM_LPAE_MAIR_ATTR_INC_OWBRWA.
>  - Changed ARM_LPAE_MAIR_ATTR_IDX_QCOM_SYS_CACHE to
>    ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE.
>  - Added comments to iommu protection flag - IOMMU_QCOM_SYS_CACHE.
>
> Changes since v3:
>  - Dropping support to cache i/o page tables to system cache. Getting support
>    for data buffers is the first step.
>    Removed io-pgtable quirk and related change to add domain attribute.
>
> Glmark2 numbers on SDM845 based cheza board:
>
> S.No.|  with LLC support   |    without LLC support
>      |  for data buffers   |
> ---------------------------------------------------
> 1    |  4480; 72.3fps      |    4042; 65.2fps
> 2    |  4500; 72.6fps      |    4039; 65.1fps
> 3    |  4523; 72.9fps      |    4106; 66.2fps
> 4    |  4489; 72.4fps      |    4104; 66.2fps
> 5    |  4518; 72.9fps      |    4072; 65.7fps
>
> [1] https://patchwork.kernel.org/cover/10772629/
> [2] https://lore.kernel.org/patchwork/patch/1072936/
> [3] https://patchwork.kernel.org/patch/10302791/
>
>  drivers/iommu/io-pgtable-arm.c | 9 ++++++++-
>  include/linux/iommu.h          | 6 ++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 4e21efbc4459..2454ac11aa97 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -167,10 +167,12 @@
>  #define ARM_LPAE_MAIR_ATTR_MASK                0xff
>  #define ARM_LPAE_MAIR_ATTR_DEVICE      0x04
>  #define ARM_LPAE_MAIR_ATTR_NC          0x44
> +#define ARM_LPAE_MAIR_ATTR_INC_OWBRWA  0xf4
>  #define ARM_LPAE_MAIR_ATTR_WBRWA       0xff
>  #define ARM_LPAE_MAIR_ATTR_IDX_NC      0
>  #define ARM_LPAE_MAIR_ATTR_IDX_CACHE   1
>  #define ARM_LPAE_MAIR_ATTR_IDX_DEV     2
> +#define ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE      3
>
>  #define ARM_MALI_LPAE_TTBR_ADRMODE_TABLE (3u << 0)
>  #define ARM_MALI_LPAE_TTBR_READ_INNER  BIT(2)
> @@ -470,6 +472,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>                 else if (prot & IOMMU_CACHE)
>                         pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>                                 << ARM_LPAE_PTE_ATTRINDX_SHIFT);
> +               else if (prot & IOMMU_QCOM_SYS_CACHE)
> +                       pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
> +                               << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>         }
>
>         if (prot & IOMMU_NOEXEC)
> @@ -857,7 +862,9 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>               (ARM_LPAE_MAIR_ATTR_WBRWA
>                << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
>               (ARM_LPAE_MAIR_ATTR_DEVICE
> -              << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV));
> +              << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV)) |
> +             (ARM_LPAE_MAIR_ATTR_INC_OWBRWA
> +              << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE));
>
>         cfg->arm_lpae_s1_cfg.mair[0] = reg;
>         cfg->arm_lpae_s1_cfg.mair[1] = 0;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a815cf6f6f47..8ee3fbaf5855 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -41,6 +41,12 @@
>   * if the IOMMU page table format is equivalent.
>   */
>  #define IOMMU_PRIV     (1 << 5)
> +/*
> + * Non-coherent masters on few Qualcomm SoCs can use this page protection flag
> + * to set correct cacheability attributes to use an outer level of cache -
> + * last level cache, aka system cache.
> + */
> +#define IOMMU_QCOM_SYS_CACHE   (1 << 6)
>
>  struct iommu_ops;
>  struct iommu_group;
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
