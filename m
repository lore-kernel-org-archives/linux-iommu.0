Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7091CC433EF
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 06:59:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD476321F
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 06:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BD476321F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDF0340432;
	Mon, 15 Nov 2021 06:59:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpAQw43bfU60; Mon, 15 Nov 2021 06:59:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A07FC40430;
	Mon, 15 Nov 2021 06:59:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AF36C001E;
	Mon, 15 Nov 2021 06:59:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB412C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 06:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9CF7A80CEA
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 06:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UfzujBpsUHaE for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 06:59:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC8FE80CE3
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 06:59:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1323763218;
 Mon, 15 Nov 2021 06:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1636959553;
 bh=luIbbrf+LzBgsq1Go6fjN5SrA/F8WMRXUbE4fwqbwaI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hrHE7vAk9f+9cu3ciMZN1IeE8B/nOoBK5QdMMQW6QfsL6ynlGKHtPbh42Sn/7o2nO
 ckWInmEMUTG3joNbBg71N3N0nuYz6i3HCgHFGqg3gij0L4vA/cvwSARDeM0aBk+3JY
 zvz+GzdhOCTUpJEOEbTHv7x2uSVveGQkoScDVTa4=
Date: Mon, 15 Nov 2021 07:59:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 02/11] driver core: Set DMA ownership during driver
 bind/unbind
Message-ID: <YZIFPv7BpsTibxE/@kroah.com>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211115020552.2378167-3-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 linux-pci@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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

On Mon, Nov 15, 2021 at 10:05:43AM +0800, Lu Baolu wrote:
> This extends really_probe() to allow checking for dma ownership conflict
> during the driver binding process. By default, the DMA_OWNER_KERNEL is
> claimed for the bound driver before calling its .probe() callback. If this
> operation fails (e.g. the iommu group of the target device already has the
> DMA_OWNER_USER set), the binding process is aborted to avoid breaking the
> security contract for devices in the iommu group.
> 
> Without this change, the vfio driver has to listen to a bus BOUND_DRIVER
> event and then BUG_ON() in case of dma ownership conflict. This leads to
> bad user experience since careless driver binding operation may crash the
> system if the admin overlooks the group restriction.
> 
> Aside from bad design, this leads to a security problem as a root user,
> even with lockdown=integrity, can force the kernel to BUG.
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
>  include/linux/device/driver.h |  7 ++++++-
>  drivers/base/dd.c             | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index a498ebcf4993..25d39c64c4d9 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -54,6 +54,10 @@ enum probe_type {
>   * @owner:	The module owner.
>   * @mod_name:	Used for built-in modules.
>   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> + * @suppress_auto_claim_dma_owner: Disable auto claiming of kernel DMA owner.
> + *		Drivers which don't require DMA or want to manually claim the
> + *		owner type (e.g. userspace driver frameworks) could set this
> + *		flag.
>   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
>   * @of_match_table: The open firmware table.
>   * @acpi_match_table: The ACPI match table.
> @@ -99,7 +103,8 @@ struct device_driver {
>  	struct module		*owner;
>  	const char		*mod_name;	/* used for built-in modules */
>  
> -	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> +	bool suppress_bind_attrs:1;	/* disables bind/unbind via sysfs */
> +	bool suppress_auto_claim_dma_owner:1;

Can a bool be a bitfield?  Is that valid C?

And why is that even needed?

>  	enum probe_type probe_type;
>  
>  	const struct of_device_id	*of_match_table;
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 68ea1f949daa..ab3333351f19 100644
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
> @@ -566,6 +567,12 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		goto done;
>  	}
>  
> +	if (!drv->suppress_auto_claim_dma_owner) {
> +		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_KERNEL, NULL);
> +		if (ret)
> +			return ret;
> +	}
> +

This feels wrong to be doing it in the driver core, why doesn't the bus
that cares about this handle it instead?

You just caused all drivers in the kernel today to set and release this
ownership, as none set this flag.  Shouldn't it be the other way around?

And again, why not in the bus that cares?

You only have problems with 1 driver out of thousands, this feels wrong
to abuse the driver core this way for just that one.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
