Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE38C4332F
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 17:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C33A340017;
	Thu, 17 Mar 2022 17:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pLrsU425Axi6; Thu, 17 Mar 2022 17:19:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 76C2F400EF;
	Thu, 17 Mar 2022 17:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25CAAC001A;
	Thu, 17 Mar 2022 17:19:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC11C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 17:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 59B5260A8B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 17:19:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7svKwK2JeKtP for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 17:19:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4BCB60A72
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 17:19:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D273E1682;
 Thu, 17 Mar 2022 10:19:42 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 132683F7B4;
 Thu, 17 Mar 2022 10:19:39 -0700 (PDT)
Message-ID: <d480c8ea-f047-2854-b1cf-041475b451db@arm.com>
Date: Thu, 17 Mar 2022 17:19:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/4 RESEND] dma-mapping: Add wrapper function to set
 dma_coherent
Content-Language: en-GB
To: Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
 lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
 bhelgaas@google.com, hch@lst.de, m.szyprowski@samsung.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-3-git-send-email-mikelley@microsoft.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1647534311-2349-3-git-send-email-mikelley@microsoft.com>
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

On 2022-03-17 16:25, Michael Kelley via iommu wrote:
> Add a wrapper function to set dma_coherent, avoiding the need for
> complex #ifdef's when setting it in architecture independent code.

No. It might happen to work out on the architectures you're looking at, 
but if Hyper-V were ever to support, say, AArch32 VMs you might see the 
problem. arch_setup_dma_ops() is the tool for this job.

Robin.

> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>   include/linux/dma-map-ops.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 0d5b06b..3350e7a 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -254,11 +254,20 @@ static inline bool dev_is_dma_coherent(struct device *dev)
>   {
>   	return dev->dma_coherent;
>   }
> +static inline void dev_set_dma_coherent(struct device *dev,
> +		bool coherent)
> +{
> +	dev->dma_coherent = coherent;
> +}
>   #else
>   static inline bool dev_is_dma_coherent(struct device *dev)
>   {
>   	return true;
>   }
> +static inline void dev_set_dma_coherent(struct device *dev,
> +		bool coherent)
> +{
> +}
>   #endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
>   
>   void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
