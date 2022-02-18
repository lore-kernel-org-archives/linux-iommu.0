Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09934C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 07:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92CEB84BE9;
	Fri, 18 Feb 2022 07:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QxaUubBtslJZ; Fri, 18 Feb 2022 07:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3504584BEC;
	Fri, 18 Feb 2022 07:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7390C0021;
	Fri, 18 Feb 2022 07:56:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60A3AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 07:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49F7584BED
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 07:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n2nDsKvsdAF6 for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 07:56:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2FF284BE7
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 07:56:03 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A9CB861141;
 Fri, 18 Feb 2022 07:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E961C340E9;
 Fri, 18 Feb 2022 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1645170962;
 bh=JsBUt67lBl87g1fuiSB/RVaxBrwVBKkrB8bcypGwUbs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XjVsoi7Z/c+mYAKm2LjxR3hGvRBIU7XQJoO6tsa+cHUPWw30wEuaSNTYh+DEr7FHM
 ZWb6zwn2JYPBg2Kbu1EGRMM9F2KIASyi/prYKPfl9J3pOSF4OUgUNFm5B34LPjRztj
 +vyImsRb8HTKGQ5Nuj2bYg19qwl3sgp0q0WpEHlY=
Date: Fri, 18 Feb 2022 08:55:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 04/11] bus: platform,amba,fsl-mc,PCI: Add device DMA
 ownership management
Message-ID: <Yg9RD3OHGl73Ag1P@kroah.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220218005521.172832-5-baolu.lu@linux.intel.com>
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

On Fri, Feb 18, 2022 at 08:55:14AM +0800, Lu Baolu wrote:
> The devices on platform/amba/fsl-mc/PCI buses could be bound to drivers
> with the device DMA managed by kernel drivers or user-space applications.
> Unfortunately, multiple devices may be placed in the same IOMMU group
> because they cannot be isolated from each other. The DMA on these devices
> must either be entirely under kernel control or userspace control, never
> a mixture. Otherwise the driver integrity is not guaranteed because they
> could access each other through the peer-to-peer accesses which by-pass
> the IOMMU protection.
> 
> This checks and sets the default DMA mode during driver binding, and
> cleanups during driver unbinding. In the default mode, the device DMA is
> managed by the device driver which handles DMA operations through the
> kernel DMA APIs (see Documentation/core-api/dma-api.rst).
> 
> For cases where the devices are assigned for userspace control through the
> userspace driver framework(i.e. VFIO), the drivers(for example, vfio_pci/
> vfio_platfrom etc.) may set a new flag (driver_managed_dma) to skip this
> default setting in the assumption that the drivers know what they are
> doing with the device DMA.
> 
> With the IOMMU layer knowing DMA ownership of each device, above problem
> can be solved.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stuart Yoder <stuyoder@gmail.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/amba/bus.h        |  8 ++++++++
>  include/linux/fsl/mc.h          |  8 ++++++++
>  include/linux/pci.h             |  8 ++++++++
>  include/linux/platform_device.h |  8 ++++++++
>  drivers/amba/bus.c              | 20 ++++++++++++++++++++
>  drivers/base/platform.c         | 20 ++++++++++++++++++++
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 26 ++++++++++++++++++++++++--
>  drivers/pci/pci-driver.c        | 21 +++++++++++++++++++++
>  8 files changed, 117 insertions(+), 2 deletions(-)

For the platform.c stuff:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


thanks for renaming this.

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
