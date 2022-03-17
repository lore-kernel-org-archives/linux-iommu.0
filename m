Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446A0C4332F
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 16:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D45AD8436D;
	Thu, 17 Mar 2022 16:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e7y9GOHK4mvS; Thu, 17 Mar 2022 16:52:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BBABC84348;
	Thu, 17 Mar 2022 16:52:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D07FC0012;
	Thu, 17 Mar 2022 16:52:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F493C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DC11418BE
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id doO_iZGzRpV1 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 16:52:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC495417AE
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:52:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB4591682;
 Thu, 17 Mar 2022 09:52:47 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23B8C3F7B4;
 Thu, 17 Mar 2022 09:52:44 -0700 (PDT)
Message-ID: <e2ceb902-6fe2-bcb9-259a-f120901672b6@arm.com>
Date: Thu, 17 Mar 2022 16:52:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 3/4 RESEND] Drivers: hv: vmbus: Propagate VMbus coherence
 to each VMbus device
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
 <1647534311-2349-4-git-send-email-mikelley@microsoft.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1647534311-2349-4-git-send-email-mikelley@microsoft.com>
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
> VMbus synthetic devices are not represented in the ACPI DSDT -- only
> the top level VMbus device is represented. As a result, on ARM64
> coherence information in the _CCA method is not specified for
> synthetic devices, so they default to not hardware coherent.
> Drivers for some of these synthetic devices have been recently
> updated to use the standard DMA APIs, and they are incurring extra
> overhead of unneeded software coherence management.
> 
> Fix this by propagating coherence information from the VMbus node
> in ACPI to the individual synthetic devices. There's no effect on
> x86/x64 where devices are always hardware coherent.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>   drivers/hv/vmbus_drv.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 12a2b37..c0e993ad 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -904,6 +904,21 @@ static int vmbus_probe(struct device *child_device)
>   			drv_to_hv_drv(child_device->driver);
>   	struct hv_device *dev = device_to_hv_device(child_device);
>   	const struct hv_vmbus_device_id *dev_id;
> +	enum dev_dma_attr coherent;
> +
> +	/*
> +	 * On ARM64, propagate the DMA coherence setting from the top level
> +	 * VMbus ACPI device to the child VMbus device being added here.
> +	 * Older Hyper-V ARM64 versions don't set the _CCA method on the
> +	 * top level VMbus ACPI device as they should.  Treat these cases
> +	 * as DMA coherent since that's the assumption made by Hyper-V.
> +	 *
> +	 * On x86/x64 these calls assume coherence and have no effect.
> +	 */
> +	coherent = acpi_get_dma_attr(hv_acpi_dev);
> +	if (coherent == DEV_DMA_NOT_SUPPORTED)
> +		coherent = DEV_DMA_COHERENT;
> +	acpi_dma_configure(child_device, coherent);

acpi_dma_configure is for devices represented in ACPI. The commit 
message implies that these VMBus devices aren't represented in ACPI. 
What gives?

Robin.

>   
>   	dev_id = hv_vmbus_get_id(drv, dev);
>   	if (drv->probe) {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
