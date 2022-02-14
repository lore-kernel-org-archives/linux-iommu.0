Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA17EC433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 10:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A47D60E8F;
	Mon, 14 Feb 2022 10:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BuQb1qoofnT8; Mon, 14 Feb 2022 10:12:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3442060DFD;
	Mon, 14 Feb 2022 10:12:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63621C0078;
	Mon, 14 Feb 2022 10:12:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5E54C0073
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 10:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87AD6405CE
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 10:12:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1c-bldM49yq0 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 10:12:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A2C5405A6
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 10:12:26 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 66EB0B80E15;
 Mon, 14 Feb 2022 10:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D3CC340E9;
 Mon, 14 Feb 2022 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1644833541;
 bh=4e6jacegMudm5QOO5r4b8aXUbKWQ/KZagciGyXk0tFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dWgOCaq9LwmLUWtMT7HPrs1K+hIb25M6y5lmPLlGADQIWn+ktjprZPDD4AHsRsFdP
 22C5wQvlEiUCP2TIBNNZG0gJ+dQ4/5WAaA8UbkTfOuU3UVef1Kj4DZOkHgKPZU6q51
 6mKzlynGQpisdWw3qFqtDq7e6e382gjSAm2McVts=
Date: Mon, 14 Feb 2022 10:59:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 04/14] driver core: platform: Add driver dma ownership
 management
Message-ID: <YgooFjSWLTSapuIs@kroah.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104015644.2294354-5-baolu.lu@linux.intel.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
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

On Tue, Jan 04, 2022 at 09:56:34AM +0800, Lu Baolu wrote:
> Multiple platform devices may be placed in the same IOMMU group because
> they cannot be isolated from each other. These devices must either be
> entirely under kernel control or userspace control, never a mixture. This
> checks and sets DMA ownership during driver binding, and release the
> ownership during driver unbinding.
> 
> The device driver may set a new flag (no_kernel_api_dma) to skip calling
> iommu_device_use_dma_api() during the binding process. For instance, the
> userspace framework drivers (vfio etc.) which need to manually claim
> their own dma ownership when assigning the device to userspace.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/platform_device.h |  1 +
>  drivers/base/platform.c         | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 17fde717df68..8f0eaafcef47 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -210,6 +210,7 @@ struct platform_driver {
>  	struct device_driver driver;
>  	const struct platform_device_id *id_table;
>  	bool prevent_deferred_probe;
> +	bool no_kernel_api_dma;
>  };
>  
>  #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index b4d36b46ab2e..d5171e44d903 100644
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
> @@ -1451,9 +1452,16 @@ static void platform_shutdown(struct device *_dev)
>  
>  static int platform_dma_configure(struct device *dev)
>  {
> +	struct platform_driver *drv = to_platform_driver(dev->driver);
>  	enum dev_dma_attr attr;
>  	int ret = 0;
>  
> +	if (!drv->no_kernel_api_dma) {
> +		ret = iommu_device_use_dma_api(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (dev->of_node) {
>  		ret = of_dma_configure(dev, dev->of_node, true);
>  	} else if (has_acpi_companion(dev)) {
> @@ -1461,9 +1469,20 @@ static int platform_dma_configure(struct device *dev)
>  		ret = acpi_dma_configure(dev, attr);
>  	}
>  
> +	if (ret && !drv->no_kernel_api_dma)
> +		iommu_device_unuse_dma_api(dev);

So you are now going to call this for every platform driver _unless_
they set this flag?

And having "negative" flags is rough to parse at times.  Yes, we have
"prevent_deferred_probe" already here, so maybe keep this in the same
nameing scheme and use "prevent_dma_api"?

And it would be good to document this somewhere as to what this means.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
