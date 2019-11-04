Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A5CA9ED3
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 19:34:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA33C2089C
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 19:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lpaySFHt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Duiop+10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA33C2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 91971D07;
	Mon,  4 Nov 2019 19:34:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5675ACD2
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 19:34:09 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 591E1A9
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 19:34:08 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D0F8560B14; Mon,  4 Nov 2019 19:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572896048;
	bh=vamSyPnFneWtEfh6IHcJYcXOtMnwFfjQxxj+OCkfymU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpaySFHthd6UwHbVLaIMwy1dV9eel4wQEgeR1OUxsXRdaSb3h9L4Q0twYg0Zy8iJZ
	b86hohj2MGpdZYVVm4nGWyZJVGEcqsunWipRByr/QHyt+o0URdu0to04kLwQkSRxYL
	XHDKJd/6oDD1EjMoF9iSa+ZksRw9nXxL6rV8w8TY=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: isaacm@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EBD960DA6;
	Mon,  4 Nov 2019 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572896046;
	bh=vamSyPnFneWtEfh6IHcJYcXOtMnwFfjQxxj+OCkfymU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Duiop+10dl9a7uFzxcbbqLq46Z+rvAq2Hf6vpbbFBRimQkBG8t331QBq5IYZj8RTI
	6hcKhjx+zVGXUAy2DVt0ulZU45h4flw7IH7d1kFS3IeYdoePVyavbVVMMdji7FFdnm
	BXq/n5MLk4MDgQJAmGmGBNK+KrVLY3jaZtgoQfeI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EBD960DA6
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=isaacm@codeaurora.org
Date: Mon, 4 Nov 2019 11:34:00 -0800
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/7] iommu/arm-smmu: Allow building as a module
Message-ID: <20191104193400.GA24983@codeaurora.org>
References: <20191030145112.19738-1-will@kernel.org>
	<20191030145112.19738-8-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030145112.19738-8-will@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
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

On Wed, Oct 30, 2019 at 02:51:12PM +0000, Will Deacon wrote:
> By conditionally dropping support for the legacy binding and exporting
> the newly introduced 'arm_smmu_impl_init()' function we can allow the
> ARM SMMU driver to be built as a module.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/Kconfig         | 14 ++++++++-
>  drivers/iommu/arm-smmu-impl.c |  6 ++++
>  drivers/iommu/arm-smmu.c      | 54 +++++++++++++++++++++--------------
>  3 files changed, 51 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 7583d47fc4d5..02703f51e533 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -350,7 +350,7 @@ config SPAPR_TCE_IOMMU
>  
>  # ARM IOMMU support
>  config ARM_SMMU
> -	bool "ARM Ltd. System MMU (SMMU) Support"
> +	tristate "ARM Ltd. System MMU (SMMU) Support"
>  	depends on (ARM64 || ARM) && MMU
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
> @@ -362,6 +362,18 @@ config ARM_SMMU
>  	  Say Y here if your SoC includes an IOMMU device implementing
>  	  the ARM SMMU architecture.
>  
> +config ARM_SMMU_LEGACY_DT_BINDINGS
> +	bool "Support the legacy \"mmu-masters\" devicetree bindings"
> +	depends on ARM_SMMU=y && OF
> +	help
> +	  Support for the badly designed and deprecated \"mmu-masters\"
> +	  devicetree bindings. This allows some DMA masters to attach
> +	  to the SMMU but does not provide any support via the DMA API.
> +	  If you're lucky, you might be able to get VFIO up and running.
> +
> +	  If you say Y here then you'll make me very sad. Instead, say N
> +	  and move your firmware to the utopian future that was 2016.
> +
>  config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>  	bool "Default to disabling bypass on ARM SMMU v1 and v2"
>  	depends on ARM_SMMU
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index 5c87a38620c4..2f82d40317d6 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -5,6 +5,7 @@
>  #define pr_fmt(fmt) "arm-smmu: " fmt
>  
>  #include <linux/bitfield.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  
>  #include "arm-smmu.h"
> @@ -172,3 +173,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  
>  	return smmu;
>  }
> +EXPORT_SYMBOL_GPL(arm_smmu_impl_init);
> +
> +MODULE_DESCRIPTION("IOMMU quirks for ARM architected SMMU implementations");
> +MODULE_AUTHOR("Robin Murphy <robin.murphy@arm.com>");
> +MODULE_LICENSE("GPL v2");
Hi Will,

A minor comment: I was curious about why arm-smmu.c and arm-smmu-impl.c
were being compiled as two separate modules, as opposed to combining
them into one module? The latter approach seemed more appropriate, given
that arm-smmu-impl doesn't offer much as a module on its own. Thoughts?

--Isaac
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
