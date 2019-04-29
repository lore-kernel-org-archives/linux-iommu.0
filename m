Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556C9C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 16:12:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C67720673
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 16:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C67720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 018CB22AA;
	Mon, 29 Apr 2019 16:12:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1545622AC
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 16:09:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id AAB3287D
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 16:09:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DC65EBD;
	Mon, 29 Apr 2019 09:09:41 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1EA13F5C1;
	Mon, 29 Apr 2019 09:09:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA
	address
To: Srinath Mannam <srinath.mannam@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org,
	Ray Jui <rjui@broadcom.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
	<1555038815-31916-3-git-send-email-srinath.mannam@broadcom.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e6c812d6-0cad-4cfd-defd-d7ec427a6538@arm.com>
Date: Mon, 29 Apr 2019 17:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555038815-31916-3-git-send-email-srinath.mannam@broadcom.com>
Content-Language: en-GB
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429160938.UjJvNQqkadCaKCaHSQhhbHx8k8bnpAjEPcJJvIHZa30@z>

On 12/04/2019 04:13, Srinath Mannam wrote:
> dma_ranges field of PCI host bridge structure has resource entries in
> sorted order of address range given through dma-ranges DT property. This
> list is the accessible DMA address range. So that this resource list will
> be processed and reserve IOVA address to the inaccessible address holes in
> the list.
> 
> This method is similar to PCI IO resources address ranges reserving in
> IOMMU for each EP connected to host bridge.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> ---
>   drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d19f3d6..fb42d7c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -212,6 +212,7 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>   	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>   	struct resource_entry *window;
>   	unsigned long lo, hi;
> +	phys_addr_t start = 0, end;
>   
>   	resource_list_for_each_entry(window, &bridge->windows) {
>   		if (resource_type(window->res) != IORESOURCE_MEM)
> @@ -221,6 +222,24 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>   		hi = iova_pfn(iovad, window->res->end - window->offset);
>   		reserve_iova(iovad, lo, hi);
>   	}
> +
> +	/* Get reserved DMA windows from host bridge */
> +	resource_list_for_each_entry(window, &bridge->dma_ranges) {
> +		end = window->res->start - window->offset;
> +resv_iova:
> +		if (end - start) {
> +			lo = iova_pfn(iovad, start);
> +			hi = iova_pfn(iovad, end);
> +			reserve_iova(iovad, lo, hi);
> +		}
> +		start = window->res->end - window->offset + 1;
> +		/* If window is last entry */
> +		if (window->node.next == &bridge->dma_ranges &&
> +		    end != DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE)) {

I still think that's a very silly way to write "~(dma_addr_t)0", but 
otherwise,

Acked-by: Robin Murphy <robin.murphy@arm.com>

> +			end = DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE);
> +			goto resv_iova;
> +		}
> +	}
>   }
>   
>   static int iova_reserve_iommu_regions(struct device *dev,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
