Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DDEC3A59E
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 14:22:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B762121670
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 14:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B762121670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 883C6C6D;
	Mon,  2 Sep 2019 14:22:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BEDDA9EE
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 14:22:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5A76C709
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 14:22:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1B4E337;
	Mon,  2 Sep 2019 07:22:39 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79FF43F59C;
	Mon,  2 Sep 2019 07:22:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
	<20190829111407.17191-3-thierry.reding@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com>
Date: Mon, 2 Sep 2019 15:22:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190829111407.17191-3-thierry.reding@gmail.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 29/08/2019 12:14, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> For device tree nodes, use the standard of_iommu_get_resv_regions()
> implementation to obtain the reserved memory regions associated with a
> device.

This covers the window between iommu_probe_device() setting up a default 
domain and the device's driver finally probing and taking control, but 
iommu_probe_device() represents the point that the IOMMU driver first 
knows about this device - there's still a window from whenever the IOMMU 
driver itself probed up to here where the "unidentified" traffic may 
have already been disrupted. Some IOMMU drivers have no option but to 
make the necessary configuration during their own probe routine, at 
which point a struct device for the display/etc. endpoint may not even 
exist yet.

Robin.

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/iommu/dma-iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index de68b4a02aea..31d48e55ab55 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -19,6 +19,7 @@
>   #include <linux/iova.h>
>   #include <linux/irq.h>
>   #include <linux/mm.h>
> +#include <linux/of_iommu.h>
>   #include <linux/pci.h>
>   #include <linux/scatterlist.h>
>   #include <linux/vmalloc.h>
> @@ -164,6 +165,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>   	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
>   		iort_iommu_msi_get_resv_regions(dev, list);
>   
> +	if (dev->of_node)
> +		of_iommu_get_resv_regions(dev, list);
>   }
>   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
