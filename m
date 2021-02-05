Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0904FC433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 01:48:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F3A64E16
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 01:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F3A64E16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 09E7886992;
	Fri,  5 Feb 2021 01:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U4TaddVZdejO; Fri,  5 Feb 2021 01:48:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 629818697E;
	Fri,  5 Feb 2021 01:48:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41FF1C07FD;
	Fri,  5 Feb 2021 01:48:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38A9FC013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 01:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2BEF386982
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 01:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E_ugb61iEC-a for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 01:48:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8000F8697E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 01:48:03 +0000 (UTC)
IronPort-SDR: +LMMaP4WhuXpusZHsTaaULtGFRfjH2gv0eVyN8hUbIvqXOOgDWzhmWqMyzPImo4QCnAZGfflpg
 lCnHX42kNh+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="177856347"
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; d="scan'208";a="177856347"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 17:48:03 -0800
IronPort-SDR: KVys015NXYzgilTJwGuAvItTw75dVH+9Y0hpsbBJj8s9iO4o00N7Bbr+UzZl9yO192ciDGfaoN
 jKcuOx6WT2zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; d="scan'208";a="407461752"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 04 Feb 2021 17:48:00 -0800
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Use Real PCI DMA device for IRTE
To: Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210204190906.38515-1-jonathan.derrick@intel.com>
 <20210204190906.38515-2-jonathan.derrick@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cc0c35bc-a5f2-ada2-ec00-14a351649d8c@linux.intel.com>
Date: Fri, 5 Feb 2021 09:39:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204190906.38515-2-jonathan.derrick@intel.com>
Content-Language: en-US
Cc: Nirmal Patel <nirmal.patel@intel.com>, Will Deacon <will@kernel.org>,
 Kapil Karkra <kapil.karkra@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2/5/21 3:09 AM, Jon Derrick wrote:
> VMD retransmits child device MSI/X with the VMD endpoint's requester-id.
> In order to support direct interrupt remapping of VMD child devices,
> ensure that the IRTE is programmed with the VMD endpoint's requester-id
> using pci_real_dma_dev().
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>   drivers/iommu/intel/irq_remapping.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index 685200a5cff0..1939e070eec8 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1276,7 +1276,8 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
>   		break;
>   	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
>   	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
> -		set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
> +		set_msi_sid(irte,
> +			    pci_real_dma_dev(msi_desc_to_pci_dev(info->desc)));
>   		break;
>   	default:
>   		BUG_ON(1);
> 

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
