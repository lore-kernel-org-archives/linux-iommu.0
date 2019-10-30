Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0162CCA9EC6
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 15:22:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A6B2087E
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 15:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A6B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BFB5FE7E;
	Wed, 30 Oct 2019 15:22:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 609D7E7C
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 15:22:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
	[209.85.167.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 032FE8A
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 15:22:14 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id j7so2305420oib.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 08:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Ks/aDXETKL7/ewjtlGzGE6lh24DrchMHRBDEy0Btj3E=;
	b=KMiGULMrL2j3/HCrfyg6abp6VQxXZk5TpNY0bMsbKtOeLqYWmz6afuvU3V0OYUUO6b
	BxphiVe6m2gaJeKJCfgX2u9fxk51Vas+7CjieUmEFVYAdishQX6odkBTyNfhyPkBILfs
	fyaEM8fL1AfRPhQrzaXFTvTkQcV8FETSyPOxsNrTljAPWCzkfprPBYp8XH0U/VWoNtwR
	1Rdm0XreYx1yNnj0dIKpbo//byN1KtlZTQi8KlNSbNksdVRyCtZbtY9HC6sHg0DimfYn
	5r5U1tWpx/fGs72CLXreqpOup1WJSs8qcEP4KCXjZ3T2A7XC5zgKIGqZgQ4mtvbpD/Zr
	SCUg==
X-Gm-Message-State: APjAAAUxfoa0fhSn6m0uuOhhPWQCddc6hKZCGeu9BsBbSSB5jiEZJAfY
	bHiod76r7ZuTuoC26aBUpQ==
X-Google-Smtp-Source: APXvYqx6Kj/zkuW+wIRPdRkZqOqV/N47QSWRwvNNo72T68bbg7gUodLDkXU4GW9fmyM9615s+4cAgw==
X-Received: by 2002:aca:904:: with SMTP id 4mr9507441oij.25.1572448933984;
	Wed, 30 Oct 2019 08:22:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
	[24.155.109.49])
	by smtp.gmail.com with ESMTPSA id m50sm115746otc.80.2019.10.30.08.22.12
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 30 Oct 2019 08:22:13 -0700 (PDT)
Date: Wed, 30 Oct 2019 10:22:12 -0500
From: Rob Herring <robh@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/7] iommu/arm-smmu: Allow building as a module
Message-ID: <20191030152212.ifzhl2w3knapc367@bogus>
References: <20191030145112.19738-1-will@kernel.org>
	<20191030145112.19738-8-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030145112.19738-8-will@kernel.org>
User-Agent: NeoMutt/20180716
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
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

Can't we just remove this now? The only user is Seattle. Is anyone still 
using Seattle AND DT? There's been no real dts change since Feb '16.
There's a bit of clean-up needed in the Seattle dts files, so I'd like 
to remove them if there's not users.

If there are users, can't we just make them move to the new binding? 
Yes compatibility, but that really depends on the users caring.

I though Calxeda was using this too, but I guess we didn't get that 
finished. We should probably remove that secure mode flag as well.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
