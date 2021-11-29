Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D5FC433F5
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 13:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B4E260A6F;
	Mon, 29 Nov 2021 13:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n3U3qBJ2yT8I; Mon, 29 Nov 2021 13:25:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5559A605DD;
	Mon, 29 Nov 2021 13:25:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 355E6C0012;
	Mon, 29 Nov 2021 13:25:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF6FDC000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 13:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B45F40371
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 13:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lDxIsgD-E6aW for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 13:25:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81759401C8
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 13:25:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9BD01042;
 Mon, 29 Nov 2021 05:25:30 -0800 (PST)
Received: from [10.57.34.182] (unknown [10.57.34.182])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C04B3F766;
 Mon, 29 Nov 2021 05:25:27 -0800 (PST)
Message-ID: <98dfa822-218b-6ad9-4fd0-56a8e5d2bd02@arm.com>
Date: Mon, 29 Nov 2021 13:25:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
Content-Language: en-GB
To: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211126230525.885757679@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zygnier <maz@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jason Gunthorpe <jgg@nvidia.com>, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
 Megha Dey <megha.dey@intel.com>
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

On 2021-11-27 01:22, Thomas Gleixner wrote:
> Let the core code fiddle with the MSI descriptor retrieval.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   19 +++----------------
>   1 file changed, 3 insertions(+), 16 deletions(-)
> 
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3154,7 +3154,6 @@ static void arm_smmu_write_msi_msg(struc
>   
>   static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>   {
> -	struct msi_desc *desc;
>   	int ret, nvec = ARM_SMMU_MAX_MSIS;
>   	struct device *dev = smmu->dev;
>   
> @@ -3182,21 +3181,9 @@ static void arm_smmu_setup_msis(struct a
>   		return;
>   	}
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

FWIW I've just quickly booted the msi-v1-part-2 branch on a platform 
with MSIs but no PRI such that this now sets priq.q.irq to an error 
value, and as I predicted it's still happy.

Tested-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

>   	/* Add callback to free MSIs on teardown */
>   	devm_add_action(dev, arm_smmu_free_msis, dev);
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
