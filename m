Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A485BC433F5
	for <iommu@archiver.kernel.org>; Sun, 28 Nov 2021 08:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 42AA440103;
	Sun, 28 Nov 2021 08:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v6DE-y8OQa1H; Sun, 28 Nov 2021 08:10:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D4181400F5;
	Sun, 28 Nov 2021 08:10:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFB6EC001C;
	Sun, 28 Nov 2021 08:10:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A09E9C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 08:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E60661C64
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 08:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GFZQ5QGMNM8L for <iommu@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 08:10:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF85A60744
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 08:10:20 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F0A5860F1B;
 Sun, 28 Nov 2021 08:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FC9C004E1;
 Sun, 28 Nov 2021 08:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1638087019;
 bh=Jh73NsijwFN5QPrga4uDXyFTpW6yedRJeVQ94xz/BvE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r8dqk03D2jeiNpbJLBgCBKZqW0HDJ5Tm6QLq+9y6d6qfyxcrdfgUx428Ks8OXlp00
 DFMNAg0jGMqvpHaytnxROgOKNdVnYWbWHi7Cvni3o9RcgZZbTFm+1iRq/chyaLAgqQ
 Fug0KlfEBeP61C9AXRDp1L1G0lUVzzX8IelrbImA=
Date: Sun, 28 Nov 2021 09:10:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 04/17] driver core: platform: Add driver dma ownership
 management
Message-ID: <YaM5Zv1RrdidycKe@kroah.com>
References: <20211128025051.355578-1-baolu.lu@linux.intel.com>
 <20211128025051.355578-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211128025051.355578-5-baolu.lu@linux.intel.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Sun, Nov 28, 2021 at 10:50:38AM +0800, Lu Baolu wrote:
> Multiple platform devices may be placed in the same IOMMU group because
> they cannot be isolated from each other. These devices must either be
> entirely under kernel control or userspace control, never a mixture. This
> checks and sets DMA ownership during driver binding, and release the
> ownership during driver unbinding.
> 
> Driver may set a new flag (suppress_auto_claim_dma_owner) to disable auto
> claiming DMA_OWNER_DMA_API ownership in the binding process. For instance,
> the userspace framework drivers (vfio etc.) which need to manually claim
> DMA_OWNER_PRIVATE_DOMAIN_USER when assigning a device to userspace.

Why would any vfio driver be a platform driver?  That should never be
the case as they obviously are not platform drivers, they are virtual
ones.

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/platform_device.h |  1 +
>  drivers/base/platform.c         | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 7c96f169d274..779bcf2a851c 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -210,6 +210,7 @@ struct platform_driver {
>  	struct device_driver driver;
>  	const struct platform_device_id *id_table;
>  	bool prevent_deferred_probe;
> +	bool suppress_auto_claim_dma_owner;

What platform driver needs this change?

>  };
>  
>  #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 598acf93a360..df4b385c8a52 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -30,6 +30,7 @@
>  #include <linux/property.h>
>  #include <linux/kmemleak.h>
>  #include <linux/types.h>
> +#include <linux/iommu.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -1465,6 +1466,32 @@ int platform_dma_configure(struct device *dev)
>  	return ret;
>  }
>  
> +static int _platform_dma_configure(struct device *dev)
> +{
> +	struct platform_driver *drv = to_platform_driver(dev->driver);
> +	int ret;
> +
> +	if (!drv->suppress_auto_claim_dma_owner) {
> +		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_DMA_API, NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = platform_dma_configure(dev);
> +	if (ret && !drv->suppress_auto_claim_dma_owner)
> +		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
> +
> +	return ret;
> +}
> +
> +static void _platform_dma_unconfigure(struct device *dev)
> +{
> +	struct platform_driver *drv = to_platform_driver(dev->driver);
> +
> +	if (!drv->suppress_auto_claim_dma_owner)
> +		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
> +}
> +
>  static const struct dev_pm_ops platform_dev_pm_ops = {
>  	SET_RUNTIME_PM_OPS(pm_generic_runtime_suspend, pm_generic_runtime_resume, NULL)
>  	USE_PLATFORM_PM_SLEEP_OPS
> @@ -1478,7 +1505,8 @@ struct bus_type platform_bus_type = {
>  	.probe		= platform_probe,
>  	.remove		= platform_remove,
>  	.shutdown	= platform_shutdown,
> -	.dma_configure	= platform_dma_configure,
> +	.dma_configure	= _platform_dma_configure,

What happened to the original platform_dma_configure() function?

And single "_" prefixes are odd, please just spell out what the
difference is in the function name, "_" gives us no hint at all.

thnaks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
