Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AC5C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Dec 2021 12:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65CBD404E9;
	Wed, 22 Dec 2021 12:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WYEgvadHzhxR; Wed, 22 Dec 2021 12:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B25424051D;
	Wed, 22 Dec 2021 12:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85009C002F;
	Wed, 22 Dec 2021 12:47:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97FA9C0012
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 12:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7750F82C04
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 12:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mdp7JxwhpaHr for <iommu@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 12:47:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3842E82907
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 12:47:38 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0D8A061947;
 Wed, 22 Dec 2021 12:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86F6C36AEB;
 Wed, 22 Dec 2021 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1640177256;
 bh=qZ5Me6WI7mkDi0azDBPQq5dSpsFYy5Bph6HB3I2DDz4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AcvTYGw/SzfCslxuTb0DnXeiXRptpHokYrNiFvO00bOd87s7zOWmIrZu53i1WWVN5
 NI8Yo8M3YRytp4C3Bo0sZcBWeaY2GOfSVn8HKiaHKAXVB+OLomcypI4oxR3cvgXRS7
 JQ7zwu8Uhw7hM6wCp4CIT9Bj8LSOQuda7PHW5Prc=
Date: Wed, 22 Dec 2021 13:47:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 02/13] driver core: Set DMA ownership during driver
 bind/unbind
Message-ID: <YcMeZlN3798noycN@kroah.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211217063708.1740334-3-baolu.lu@linux.intel.com>
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

On Fri, Dec 17, 2021 at 02:36:57PM +0800, Lu Baolu wrote:
> This extends really_probe() to allow checking for dma ownership conflict
> during the driver binding process. By default, the DMA_OWNER_DMA_API is
> claimed for the bound driver before calling its .probe() callback. If this
> operation fails (e.g. the iommu group of the target device already has the
> DMA_OWNER_USER set), the binding process is aborted to avoid breaking the
> security contract for devices in the iommu group.
> 
> Without this change, the vfio driver has to listen to a bus BOUND_DRIVER
> event and then BUG_ON() in case of dma ownership conflict. This leads to
> bad user experience since careless driver binding operation may crash the
> system if the admin overlooks the group restriction. Aside from bad design,
> this leads to a security problem as a root user can force the kernel to
> BUG() even with lockdown=integrity.
> 
> Driver may set a new flag (suppress_auto_claim_dma_owner) to disable auto
> claim in the binding process. Examples include kernel drivers (pci_stub,
> PCI bridge drivers, etc.) which don't trigger DMA at all thus can be safely
> exempted in DMA ownership check and userspace framework drivers (vfio/vdpa
> etc.) which need to manually claim DMA_OWNER_USER when assigning a device
> to userspace.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/linux-iommu/20210922123931.GI327412@nvidia.com/
> Link: https://lore.kernel.org/linux-iommu/20210928115751.GK964074@nvidia.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/device/driver.h |  2 ++
>  drivers/base/dd.c             | 37 ++++++++++++++++++++++++++++++-----
>  2 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index a498ebcf4993..f5bf7030c416 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -54,6 +54,7 @@ enum probe_type {
>   * @owner:	The module owner.
>   * @mod_name:	Used for built-in modules.
>   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> + * @suppress_auto_claim_dma_owner: Disable kernel dma auto-claim.
>   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
>   * @of_match_table: The open firmware table.
>   * @acpi_match_table: The ACPI match table.
> @@ -100,6 +101,7 @@ struct device_driver {
>  	const char		*mod_name;	/* used for built-in modules */
>  
>  	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> +	bool suppress_auto_claim_dma_owner;
>  	enum probe_type probe_type;
>  
>  	const struct of_device_id	*of_match_table;
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 68ea1f949daa..b04eec5dcefa 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -28,6 +28,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
>  #include <linux/slab.h>
> +#include <linux/iommu.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -538,6 +539,32 @@ static int call_driver_probe(struct device *dev, struct device_driver *drv)
>  	return ret;
>  }
>  
> +static int device_dma_configure(struct device *dev, struct device_driver *drv)
> +{
> +	int ret;
> +
> +	if (!dev->bus->dma_configure)
> +		return 0;
> +
> +	ret = dev->bus->dma_configure(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (!drv->suppress_auto_claim_dma_owner)
> +		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_DMA_API, NULL);

Wait, the busses that wanted to configure the device, just did so in
their dma_configure callback, so why not do this type of
iommu_device_set_dma_owner() in the few busses that will want this to
happen?

Right now we only have 4 different "busses" that care about this.  Out
of the following callbacks:
	fsl_mc_dma_configure
	host1x_dma_configure
	pci_dma_configure
	platform_dma_configure

Which one will actually care about the iommu_device_set_dma_owner()
call?  All of them?  None of them?  Some of them?

Again, why can't this just happen in the (very few) bus callbacks that
care about this?  In following patches in this series, you turn off this
for the pci_dma_configure users, so what is left?  3 odd bus types that
are not used often.  How well did you test devices of those types with
this patchset?

It's fine to have "suppress" fields when they are the minority, but here
it's a _very_ tiny tiny number of actual devices in a system that will
ever get the chance to have this check happen for them and trigger,
right?

I know others told you to put this in the driver core, but I fail to see
how adding this call to the 3 busses that care about it is a lot more
work than this driver core functionality that we all will have to
maintain for forever?

> +
> +	return ret;
> +}
> +
> +static void device_dma_cleanup(struct device *dev, struct device_driver *drv)
> +{
> +	if (!dev->bus->dma_configure)
> +		return;
> +
> +	if (!drv->suppress_auto_claim_dma_owner)
> +		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
> +}
> +
>  static int really_probe(struct device *dev, struct device_driver *drv)
>  {
>  	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
> @@ -574,11 +601,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	if (ret)
>  		goto pinctrl_bind_failed;
>  
> -	if (dev->bus->dma_configure) {
> -		ret = dev->bus->dma_configure(dev);
> -		if (ret)
> -			goto probe_failed;
> -	}
> +	if (device_dma_configure(dev, drv))
> +		goto pinctrl_bind_failed;

Are you sure you are jumping to the proper error path here?  It is not
obvious why you changed this.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
