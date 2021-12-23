Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF5EC433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Dec 2021 07:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2514C60B5A;
	Thu, 23 Dec 2021 07:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VSZ0frsS7Ag4; Thu, 23 Dec 2021 07:13:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07E3860ADF;
	Thu, 23 Dec 2021 07:13:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8B9EC002F;
	Thu, 23 Dec 2021 07:13:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13AAEC0012
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 07:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDEA060B30
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 07:13:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OkuEJyrwNQ5i for <iommu@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 07:13:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1414960ADF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 07:13:28 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B970BB81E98;
 Thu, 23 Dec 2021 07:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BCDC36AE5;
 Thu, 23 Dec 2021 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1640243605;
 bh=yIZy+IXiNwlPro62GwZKOzKJyYp9ZVwUyRkhzfCo5Uk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RgquxtfV+yuQOJyPb2PfMc4Lc2pxHNJ6ljVc/4MoShgz9XCyOKVzWEynI2uNkeKld
 GiI7eYSqDI2wdjpmTXG6UMelhNYaji1XcL9xekE0a7xSj41VBa502BAeW0J/nmtQvG
 5FhjLfWMrrd4OqTsVFHhkcQQB8reAtmIm707kyV4=
Date: Thu, 23 Dec 2021 08:13:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 02/13] driver core: Set DMA ownership during driver
 bind/unbind
Message-ID: <YcQhka64aqHJ5uE7@kroah.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-3-baolu.lu@linux.intel.com>
 <YcMeZlN3798noycN@kroah.com>
 <94e37c45-abc1-c682-5adf-1cc4b6887640@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <94e37c45-abc1-c682-5adf-1cc4b6887640@linux.intel.com>
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

On Thu, Dec 23, 2021 at 11:02:54AM +0800, Lu Baolu wrote:
> Hi Greg,
> 
> On 12/22/21 8:47 PM, Greg Kroah-Hartman wrote:
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void device_dma_cleanup(struct device *dev, struct device_driver *drv)
> > > +{
> > > +	if (!dev->bus->dma_configure)
> > > +		return;
> > > +
> > > +	if (!drv->suppress_auto_claim_dma_owner)
> > > +		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
> > > +}
> > > +
> > >   static int really_probe(struct device *dev, struct device_driver *drv)
> > >   {
> > >   	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
> > > @@ -574,11 +601,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> > >   	if (ret)
> > >   		goto pinctrl_bind_failed;
> > > -	if (dev->bus->dma_configure) {
> > > -		ret = dev->bus->dma_configure(dev);
> > > -		if (ret)
> > > -			goto probe_failed;
> > > -	}
> > > +	if (device_dma_configure(dev, drv))
> > > +		goto pinctrl_bind_failed;
> > Are you sure you are jumping to the proper error path here?  It is not
> > obvious why you changed this.
> 
> The error handling path in really_probe() seems a bit wrong. For
> example,
> 
>  572         /* If using pinctrl, bind pins now before probing */
>  573         ret = pinctrl_bind_pins(dev);
>  574         if (ret)
>  575                 goto pinctrl_bind_failed;
> 
> [...]
> 
>  663 pinctrl_bind_failed:
>  664         device_links_no_driver(dev);
>  665         devres_release_all(dev);
>  666         arch_teardown_dma_ops(dev);
>  667         kfree(dev->dma_range_map);
>  668         dev->dma_range_map = NULL;
>  669         driver_sysfs_remove(dev);
>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>  670         dev->driver = NULL;
>  671         dev_set_drvdata(dev, NULL);
>  672         if (dev->pm_domain && dev->pm_domain->dismiss)
>  673                 dev->pm_domain->dismiss(dev);
>  674         pm_runtime_reinit(dev);
>  675         dev_pm_set_driver_flags(dev, 0);
>  676 done:
>  677         return ret;
> 
> The driver_sysfs_remove() will be called even driver_sysfs_add() hasn't
> been called yet. I can fix this in a separated patch if I didn't miss
> anything.

If this is a bug in the existing kernel, please submit it as a separate
patch so that it can be properly backported to all affected kernels.
Never bury it in an unrelated change that will never get sent to older
kernels.

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
