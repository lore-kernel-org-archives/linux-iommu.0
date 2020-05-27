Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B0BC433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 17:30:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420E32075A
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 17:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420E32075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E7F66251E1;
	Wed, 27 May 2020 17:30:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPHBIUtvbMDu; Wed, 27 May 2020 17:30:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D9EC424CEB;
	Wed, 27 May 2020 17:30:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA02AC088D;
	Wed, 27 May 2020 17:30:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71673C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 17:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 58CE524D71
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 17:30:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8-vb1raSYXaG for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 17:30:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id A083B24CEB
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 17:30:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0DCB31B;
 Wed, 27 May 2020 10:30:19 -0700 (PDT)
Received: from [10.57.2.168] (unknown [10.57.2.168])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D2B73F305;
 Wed, 27 May 2020 10:30:17 -0700 (PDT)
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova
 address
To: Srinath Mannam <srinath.mannam@broadcom.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
Date: Wed, 27 May 2020 18:30:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
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

On 2020-05-27 17:03, Srinath Mannam wrote:
> This patch gives the provision to change default value of MSI IOVA base
> to platform's suitable IOVA using module parameter. The present
> hardcoded MSI IOVA base may not be the accessible IOVA ranges of platform.

That in itself doesn't seem entirely unreasonable; IIRC the current 
address is just an arbitrary choice to fit nicely into Qemu's memory 
map, and there was always the possibility that it wouldn't suit everything.

> Since commit aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible
> DMA address"), inaccessible IOVA address ranges parsed from dma-ranges
> property are reserved.

That, however, doesn't seem to fit here; iommu-dma maps MSI doorbells 
dynamically, so they aren't affected by reserved regions any more than 
regular DMA pages are. In fact, it explicitly ignores the software MSI 
region, since as the comment says, it *is* the software that manages those.

The MSI_IOVA_BASE region exists for VFIO, precisely because in that case 
the kernel *doesn't* control the address space, but still needs some way 
to steal a bit of it for MSIs that the guest doesn't necessarily know 
about, and give userspace a fighting chance of knowing what it's taken. 
I think at the time we discussed the idea of adding something to the 
VFIO uapi such that userspace could move this around if it wanted or 
needed to, but decided we could live without that initially. Perhaps now 
the time has come?

Robin.

> If any platform has the limitaion to access default MSI IOVA, then it can
> be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>   drivers/iommu/arm-smmu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 4f1a350..5e59c9d 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -72,6 +72,9 @@ static bool disable_bypass =
>   module_param(disable_bypass, bool, S_IRUGO);
>   MODULE_PARM_DESC(disable_bypass,
>   	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> +static unsigned long msi_iova_base = MSI_IOVA_BASE;
> +module_param(msi_iova_base, ulong, S_IRUGO);
> +MODULE_PARM_DESC(msi_iova_base, "msi iova base address.");
>   
>   struct arm_smmu_s2cr {
>   	struct iommu_group		*group;
> @@ -1566,7 +1569,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>   	struct iommu_resv_region *region;
>   	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>   
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> +	region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH,
>   					 prot, IOMMU_RESV_SW_MSI);
>   	if (!region)
>   		return;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
