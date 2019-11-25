Return-Path: <SRS0=OkKq=ZR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38D0C432C3
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 16:05:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C132068E
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 16:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C132068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 81CF784F76;
	Mon, 25 Nov 2019 16:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G4MyLWaR5ltl; Mon, 25 Nov 2019 16:05:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B2EED84E5D;
	Mon, 25 Nov 2019 16:05:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 835D7C0881;
	Mon, 25 Nov 2019 16:05:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08762C0878
 for <iommu@lists.linuxfoundation.org>; Mon, 25 Nov 2019 16:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E5F4F86576
 for <iommu@lists.linuxfoundation.org>; Mon, 25 Nov 2019 16:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ce9J4FOCXdns for <iommu@lists.linuxfoundation.org>;
 Mon, 25 Nov 2019 16:05:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0149786689
 for <iommu@lists.linuxfoundation.org>; Mon, 25 Nov 2019 16:05:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4699D31B;
 Mon, 25 Nov 2019 08:05:03 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 889F73F6C4;
 Mon, 25 Nov 2019 08:05:01 -0800 (PST)
Date: Mon, 25 Nov 2019 16:04:52 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu: support SMMU module probing from the IORT
Message-ID: <20191125160445.GA24078@e121166-lin.cambridge.arm.com>
References: <20191121114918.2293-1-will@kernel.org>
 <20191122174125.21030-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191122174125.21030-1-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: iommu@lists.linuxfoundation.org, isaacm@codeaurora.org,
 saravanak@google.com, jean-philippe@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com, will@kernel.org,
 robin.murphy@arm.com
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

On Fri, Nov 22, 2019 at 06:41:25PM +0100, Ard Biesheuvel wrote:
> Add support for SMMU drivers built as modules to the ACPI/IORT device
> probing path, by deferring the probe of the master if the SMMU driver is
> known to exist but has not been loaded yet. Given that the IORT code
> registers a platform device for each SMMU that it discovers, we can
> easily trigger the udev based autoloading of the SMMU drivers by making
> the platform device identifier part of the module alias.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/acpi/arm64/iort.c   | 4 ++--
>  drivers/iommu/arm-smmu-v3.c | 1 +
>  drivers/iommu/arm-smmu.c    | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)

I think it is best if Will picks this up and add it to the
series that modularize the SMMU drivers:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 5a7551d060f2..a696457a9b11 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -850,9 +850,9 @@ static inline bool iort_iommu_driver_enabled(u8 type)
>  {
>  	switch (type) {
>  	case ACPI_IORT_NODE_SMMU_V3:
> -		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
> +		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
>  	case ACPI_IORT_NODE_SMMU:
> -		return IS_BUILTIN(CONFIG_ARM_SMMU);
> +		return IS_ENABLED(CONFIG_ARM_SMMU);
>  	default:
>  		pr_warn("IORT node type %u does not describe an SMMU\n", type);
>  		return false;
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 7669beafc493..bf6a1e8eb9b0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -3733,4 +3733,5 @@ module_platform_driver(arm_smmu_driver);
>  
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>  MODULE_AUTHOR("Will Deacon <will@kernel.org>");
> +MODULE_ALIAS("platform:arm-smmu-v3");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index d55acc48aee3..db5106b0955b 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2292,4 +2292,5 @@ module_platform_driver(arm_smmu_driver);
>  
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>  MODULE_AUTHOR("Will Deacon <will@kernel.org>");
> +MODULE_ALIAS("platform:arm-smmu");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
