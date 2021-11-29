Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF850C433EF
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 11:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 758D7409DC;
	Mon, 29 Nov 2021 11:01:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DAAn_IDebWJx; Mon, 29 Nov 2021 11:01:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5278D409C4;
	Mon, 29 Nov 2021 11:01:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA90C001C;
	Mon, 29 Nov 2021 11:01:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1F60C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 11:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2EF983126
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 11:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p5H2IScevSZV for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 11:01:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37A2D82C75
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 11:01:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EAAFF612D9;
 Mon, 29 Nov 2021 10:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A396C53FAD;
 Mon, 29 Nov 2021 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638183315;
 bh=QhZNG7zEJdkQvS0LEX52li9AXzufJrQFobG0M6duX3k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=In+AkzkxuwyvtyrVSnDdHfnln0ej7MVCOlSJ0dRt2ZWpilriGh6TuxtTbIvPZpGRc
 3raF7kENSA7Iqg9d3lIFa1Tycva8OdSns9kjZGzFU/i0aJcBpVAWsw03om+s4qnUOM
 fw8I9XrPtQ3Rho8qt5voFvB4S6aarTonmWrXmIFAJNjWosRUJn049/OYsViwr62iQF
 gEyUDXXP/57E3hImuxQespEfMMrhMyK1bU1TI2fcChiOBzoxZ2prSilIA/X8hL/HV2
 gt/PtTjrEAm0TvcLCwOpO2++IoNJLFndUJeT7h1TLYmVmW3HVey3dfUX8+sE/bT/k6
 GGQZi90ZDL7Yg==
Date: Mon, 29 Nov 2021 10:55:07 +0000
From: Will Deacon <will@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
Message-ID: <20211129105506.GA22761@willie-the-truck>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211126230525.885757679@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Ashok Raj <ashok.raj@intel.com>, Marc Zygnier <maz@kernel.org>, x86@kernel.org,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, Megha Dey <megha.dey@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
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

Hi Thomas,

On Sat, Nov 27, 2021 at 02:20:59AM +0100, Thomas Gleixner wrote:
> Let the core code fiddle with the MSI descriptor retrieval.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3154,7 +3154,6 @@ static void arm_smmu_write_msi_msg(struc
>  
>  static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  {
> -	struct msi_desc *desc;
>  	int ret, nvec = ARM_SMMU_MAX_MSIS;
>  	struct device *dev = smmu->dev;
>  
> @@ -3182,21 +3181,9 @@ static void arm_smmu_setup_msis(struct a
>  		return;
>  	}
>  
> -	for_each_msi_entry(desc, dev) {
> -		switch (desc->msi_index) {
> -		case EVTQ_MSI_INDEX:
> -			smmu->evtq.q.irq = desc->irq;
> -			break;
> -		case GERROR_MSI_INDEX:
> -			smmu->gerr_irq = desc->irq;
> -			break;
> -		case PRIQ_MSI_INDEX:
> -			smmu->priq.q.irq = desc->irq;
> -			break;
> -		default:	/* Unknown */
> -			continue;
> -		}
> -	}
> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);

Prviously, if retrieval of the MSI failed then we'd fall back to wired
interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
we make the assignments to smmu->*irq here conditional on the MSI being
valid, please?

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
