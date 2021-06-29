Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B292C11F67
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 17:34:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9931061DC0
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 17:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9931061DC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A593403F6;
	Tue, 29 Jun 2021 17:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FwRzDKJH4LkS; Tue, 29 Jun 2021 17:34:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 63098403F7;
	Tue, 29 Jun 2021 17:34:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E3C3C001A;
	Tue, 29 Jun 2021 17:34:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74A02C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 17:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60790403FB
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 17:34:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t2AY0RFxIyPD for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 17:34:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3767F403F6
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 17:34:46 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 683A061DB4;
 Tue, 29 Jun 2021 17:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624988085;
 bh=jTocjjSkL2RR2s6O105W2co1/fBDdCJKnwcsykkVW8E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mg7wOzszgrGkQ0WHnqAkQnjpKalfvvimkZTQxbmOdmqbUIQegCHIxZqA8VnRKkFCI
 u1Bxs9xitLBpaQmTQgImesu4ihaoxzpPqm1Kp3AbdEVFlwKzyDZhP6TuRLGHQuWBTZ
 75nk+5HqM0jORG7oSd6bu2uc4XzlDEesgHjvY9F5NoJT05xm9o5kpuJSIEzgTcnq07
 Lnr2hEI2BO6nmaT4bLfoKVIOc6kRSXgHDVVPuiroXCn64x3iJ1Xx81MX0quZLG4hlW
 u8+VYIQuVwwqEMU/NIo6t97XZE6VBOXd8/9/4hLW5m8s49LNhCRes8FlwHDkALPWrV
 RBMLLmFM2ZX9A==
Date: Tue, 29 Jun 2021 18:34:40 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add default domain quirk for Arm Fast
 Models
Message-ID: <20210629173440.GA7556@willie-the-truck>
References: <bf7020acf5ca7306a51d1950e3ff2afe2229e037.1624032324.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf7020acf5ca7306a51d1950e3ff2afe2229e037.1624032324.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, andre.przywara@arm.com,
 iommu@lists.linux-foundation.org, maz@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Jun 18, 2021 at 05:24:49PM +0100, Robin Murphy wrote:
> Arm Fast Models are still implementing legacy virtio-pci devices behind
> the SMMU, which continue to be problematic as "real hardware" devices
> (from the point of view of the simulated system) without the mitigating
> VIRTIO_F_ACCESS_PLATFORM feature.
> 
> Since we now have the ability to force passthrough on a device-specific
> basis, let's use it to work around this particular oddity so that people
> who just want to boot Linux on a model don't have to fiddle around with
> things to avoid the SMMU getting in the way by default (and I don't have
> to keep telling them which things...)
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Any chance of getting the fastmodels updated instead? It feels like it
has to happen *eventually*, and then there would be no need for this bodge.

Will

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 54b2f27b81d4..13cf16e8f45b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2649,6 +2649,20 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>  	}
>  }
>  
> +static int arm_smmu_def_domain_type(struct device *dev)
> +{
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		/* Legacy virtio-block devices on Arm Fast Models */
> +		if (pdev->vendor == 0x1af4 && pdev->device == 0x1001 &&
> +		    pdev->subsystem_vendor == 0x00ff && pdev->subsystem_device == 0x0002)
> +			return IOMMU_DOMAIN_IDENTITY;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct iommu_ops arm_smmu_ops = {
>  	.capable		= arm_smmu_capable,
>  	.domain_alloc		= arm_smmu_domain_alloc,
> @@ -2673,6 +2687,7 @@ static struct iommu_ops arm_smmu_ops = {
>  	.sva_bind		= arm_smmu_sva_bind,
>  	.sva_unbind		= arm_smmu_sva_unbind,
>  	.sva_get_pasid		= arm_smmu_sva_get_pasid,
> +	.def_domain_type	= arm_smmu_def_domain_type,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  	.owner			= THIS_MODULE,
>  };
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
