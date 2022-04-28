Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928B7C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 11:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37DE0826B4;
	Thu, 28 Apr 2022 11:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GsX1hcgBsyIw; Thu, 28 Apr 2022 11:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24A6981432;
	Thu, 28 Apr 2022 11:12:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAF7DC0032;
	Thu, 28 Apr 2022 11:12:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B8BEC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 11:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2904E60B09
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 11:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZpUYr-xc4UgW for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FFF0607F9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 11:12:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EB2B1474;
 Thu, 28 Apr 2022 04:12:49 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DF4F3F774;
 Thu, 28 Apr 2022 04:12:45 -0700 (PDT)
Message-ID: <7b09e989-0aa1-a557-485e-572f69caf881@arm.com>
Date: Thu, 28 Apr 2022 12:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/5] iommu/sun50i: Ensure the IOMMU can be used for DMA
Content-Language: en-GB
To: Samuel Holland <samuel@sholland.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
References: <20220428010401.11323-1-samuel@sholland.org>
 <20220428010401.11323-6-samuel@sholland.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220428010401.11323-6-samuel@sholland.org>
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Maxime Ripard <mripard@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

On 2022-04-28 02:04, Samuel Holland wrote:
> So far, the driver has relied on arch/arm64/Kconfig to select IOMMU_DMA.
> Unsurprisingly, this does not work on RISC-V, so the driver must select
> IOMMU_DMA itself.

No, IOMMU_DMA should only be selected by the architecture code that's 
also responsible for calling iommu_setup_dma_ops(). Without that, this 
select will do nothing other than add some unused code to the kernel image.

I appreciate that the current state of the x86 IOMMU drivers being 
tightly-coupled to the x86 arch code might be confusing (which reminds 
me I'd totally forgotten about [1]). I'm about to start reworking the 
whole area anyway, but for now please just follow the existing intent.

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/9ba6f2e8568a3ff6a94fade66668d99705433c44.1631536879.git.robin.murphy@arm.com/

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>   drivers/iommu/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c79a0df090c0..70a0bfa6d907 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -223,6 +223,7 @@ config SUN50I_IOMMU
>   	depends on ARCH_SUNXI || COMPILE_TEST
>   	select ARM_DMA_USE_IOMMU
>   	select IOMMU_API
> +	select IOMMU_DMA
>   	help
>   	  Support for the IOMMU introduced in the Allwinner H6 SoCs.
>   
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
