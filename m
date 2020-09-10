Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59264C43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 09:14:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F7A207DE
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 09:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F7A207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BB8CA875A0;
	Thu, 10 Sep 2020 09:14:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HaqCqCrW7BD3; Thu, 10 Sep 2020 09:14:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6C1D87594;
	Thu, 10 Sep 2020 09:14:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F98EC0859;
	Thu, 10 Sep 2020 09:14:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44112C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 09:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2646A204C3
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 09:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a9vFKDjliM2a for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 09:13:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id CFD73204D9
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 09:13:56 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7F59E6736F; Thu, 10 Sep 2020 11:13:51 +0200 (CEST)
Date: Thu, 10 Sep 2020 11:13:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/3] dma-mapping: introduce DMA range map, supplanting
 dma_pfn_offset
Message-ID: <20200910091351.GA25883@lst.de>
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-4-hch@lst.de> <20200910075351.GA1092435@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910075351.GA1092435@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linux-sh@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Sep 10, 2020 at 09:53:51AM +0200, Greg KH wrote:
> >  		/*
> >  		 * Please refer to usb_alloc_dev() to see why we set
> > -		 * dma_mask and dma_pfn_offset.
> > +		 * dma_mask and dma_range_map.
> >  		 */
> >  		intf->dev.dma_mask = dev->dev.dma_mask;
> > -		intf->dev.dma_pfn_offset = dev->dev.dma_pfn_offset;
> > +		if (dma_direct_copy_range_map(&intf->dev, &dev->dev))
> > +			dev_err(&dev->dev, "failed to copy DMA map\n");
> 
> We tell the user, but then just keep on running?  Is there anything that
> we can do here?
> 
> If not, why not have dma_direct_copy_range_map() print out the error?

At least for USB I'm pretty sure this isn't required at all.  I've been
running with the patch below on my desktop for two days now trying all
the usb toys I have (in addition to grepping for obvious abuses in
the drivers).  remoteproc is a different story, but the DMA handling
seems there is sketchy to start with..

---
From 8bae3e6833f2ca431dcfcbc8f9cced7d5e972a01 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 9 Sep 2020 08:28:59 +0200
Subject: usb: don't inherity DMA properties for USB devices

As the comment in usb_alloc_dev correctly states, drivers can't use
the DMA API on usb device, and at least calling dma_set_mask on them
is highly dangerous.  Unlike what the comment states upper level drivers
also can't really use the presence of a dma mask to check for DMA
support, as the dma_mask is set by default for most busses.

Remove the copying over of DMA information, and remove the now unused
dma_direct_copy_range_map export.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/core/message.c |  7 -------
 drivers/usb/core/usb.c     | 13 -------------
 kernel/dma/direct.c        |  1 -
 3 files changed, 21 deletions(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 935ee98e049f65..9e45732dc1d1d1 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1954,13 +1954,6 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		intf->dev.bus = &usb_bus_type;
 		intf->dev.type = &usb_if_device_type;
 		intf->dev.groups = usb_interface_groups;
-		/*
-		 * Please refer to usb_alloc_dev() to see why we set
-		 * dma_mask and dma_range_map.
-		 */
-		intf->dev.dma_mask = dev->dev.dma_mask;
-		if (dma_direct_copy_range_map(&intf->dev, &dev->dev))
-			dev_err(&dev->dev, "failed to copy DMA map\n");
 		INIT_WORK(&intf->reset_ws, __usb_queue_reset_device);
 		intf->minor = -1;
 		device_initialize(&intf->dev);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 23d451f6894d70..9b4ac4415f1a47 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -599,19 +599,6 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	dev->dev.bus = &usb_bus_type;
 	dev->dev.type = &usb_device_type;
 	dev->dev.groups = usb_device_groups;
-	/*
-	 * Fake a dma_mask/offset for the USB device:
-	 * We cannot really use the dma-mapping API (dma_alloc_* and
-	 * dma_map_*) for USB devices but instead need to use
-	 * usb_alloc_coherent and pass data in 'urb's, but some subsystems
-	 * manually look into the mask/offset pair to determine whether
-	 * they need bounce buffers.
-	 * Note: calling dma_set_mask() on a USB device would set the
-	 * mask for the entire HCD, so don't do that.
-	 */
-	dev->dev.dma_mask = bus->sysdev->dma_mask;
-	if (dma_direct_copy_range_map(&dev->dev, bus->sysdev))
-		dev_err(&dev->dev, "failed to copy DMA map\n");
 	set_dev_node(&dev->dev, dev_to_node(bus->sysdev));
 	dev->state = USB_STATE_ATTACHED;
 	dev->lpm_disable_count = 1;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index fc815f7375e282..3af257571a3b42 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -552,4 +552,3 @@ int dma_direct_copy_range_map(struct device *to, struct device *from)
 	to->dma_range_map = new_map;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dma_direct_copy_range_map);
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
