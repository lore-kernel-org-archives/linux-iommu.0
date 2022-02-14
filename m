Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB18C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 13:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5175E405EB;
	Mon, 14 Feb 2022 13:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id toCWl0JAGCf0; Mon, 14 Feb 2022 13:37:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DF74B400E0;
	Mon, 14 Feb 2022 13:37:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA96BC001A;
	Mon, 14 Feb 2022 13:37:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89E2BC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67A384015E
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7KeY1VGo9kmz for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 13:37:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 830CC400E0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:37:21 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CA9ABB80EBD;
 Mon, 14 Feb 2022 13:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20AFC340E9;
 Mon, 14 Feb 2022 13:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1644845838;
 bh=Oxsn32h7Ub8qAbBy4j6/5jsGWbDXxu1IwJ0TFbQG4Mc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ONb88kmbVsCjwLYnVQN7fyimKn4PW5jYGIgQp9B3El5czr7hq89ykSx0/9NkQmjT9
 y3ZEr/oKkODfMeAHtHkbRHpArLA0nGtK1BtK1bQSnLR4gDFaKfXtZmPOAozVZpPWX4
 gUu9W97fmAjB6K0PHkAlblLuyNeoM4eTHDmQXe20=
Date: Mon, 14 Feb 2022 14:37:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 04/14] driver core: platform: Add driver dma ownership
 management
Message-ID: <YgpbC1u6YFN4GefB@kroah.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-5-baolu.lu@linux.intel.com>
 <YgooFjSWLTSapuIs@kroah.com> <20220214131853.GY4160@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220214131853.GY4160@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
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

On Mon, Feb 14, 2022 at 09:18:53AM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 10:59:50AM +0100, Greg Kroah-Hartman wrote:
> 
> > > +	if (ret && !drv->no_kernel_api_dma)
> > > +		iommu_device_unuse_dma_api(dev);
> > 
> > So you are now going to call this for every platform driver _unless_
> > they set this flag?
> 
> Yes, it is necessary because VFIO supports platform devices as well
> and needs to ensure security. Conflicting kernel driver attachements
> must be blocked, just like for PCI.

A platform device shouldn't be using VFIO, but ugh, oh well, that ship
has sailed :(

And stop it with the "security" mess, do not give people a false sense
of it here please.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
