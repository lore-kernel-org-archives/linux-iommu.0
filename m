Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0A2C433EF
	for <iommu@archiver.kernel.org>; Thu, 31 Mar 2022 06:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F3EF60C0C;
	Thu, 31 Mar 2022 06:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7oZpfJOKyaaE; Thu, 31 Mar 2022 06:25:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7732E60A81;
	Thu, 31 Mar 2022 06:25:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B786C001D;
	Thu, 31 Mar 2022 06:25:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9C57C0012
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 06:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 949C383403
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 06:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FdksWesz_uBb for <iommu@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 06:25:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from muru.com (muru.com [72.249.23.125])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1771833FB
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 06:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 45FA080FA;
 Thu, 31 Mar 2022 06:23:13 +0000 (UTC)
Date: Thu, 31 Mar 2022 09:25:20 +0300
From: Tony Lindgren <tony@atomide.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 8/9] iommu: Remove unused argument in is_attach_deferred
Message-ID: <YkVJUBK5uHl7ELdv@atomide.com>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-9-baolu.lu@linux.intel.com>
 <YkRiawC2T9g+CHSJ@atomide.com>
 <20220330142340.GA2111031@nvidia.com>
 <YkSRKZcJO0q3v5WL@atomide.com>
 <20220330173323.GA2120790@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220330173323.GA2120790@nvidia.com>
Cc: regressions@lists.linux.dev, David Airlie <airlied@linux.ie>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

Hi,

* Jason Gunthorpe <jgg@nvidia.com> [220330 17:31]:
> On Wed, Mar 30, 2022 at 08:19:37PM +0300, Tony Lindgren wrote:
> 
> > > > __iommu_probe_device from probe_iommu_group+0x2c/0x38
> > > > probe_iommu_group from bus_for_each_dev+0x74/0xbc
> > > > bus_for_each_dev from bus_iommu_probe+0x34/0x2e8
> > > > bus_iommu_probe from bus_set_iommu+0x80/0xc8
> > > > bus_set_iommu from omap_iommu_init+0x88/0xcc
> > > > omap_iommu_init from do_one_initcall+0x44/0x24c
> > > > 
> > > > Any ideas for a fix?
> > > > 
> > > > It would be good to fix this quickly so we don't end up with a broken
> > > > v5.18-rc1..
> > > > 
> > > > For reference, this is mainline commit 41bb23e70b50 ("iommu: Remove unused
> > > > argument in is_attach_deferred").
> > > 
> > > Are you confident in the bisection? I don't see how that commit could
> > > NULL deref..
> > 
> > Oops sorry you're right, the breaking commit is a different patch, it's
> > 3f6634d997db ("iommu: Use right way to retrieve iommu_ops") instead. I must
> > have picked the wrong commit while testing.
> 
> That makes alot more sense
>  
> > > Can you find the code that is the NULL deref?
> > 
> > I can debug a bit more tomorrow.
> 
> Looks like omap's omap_iommu_probe_device() is buggy, it returns 0 on
> error paths:
> 
> 	num_iommus = of_property_count_elems_of_size(dev->of_node, "iommus",
> 						     sizeof(phandle));
> 	if (num_iommus < 0)
> 		return 0;
> 
> This function needs to return an errno -ENODEV
> 
> Otherwise it causes a NULL dev->iommu->iommu_dev and dev_iommu_ops() will
> crash.

You got it. This fixes the issue for me. Looks like the regression already
happened earlier and recent changes just expose it.

For reference, fix posted at:

https://lore.kernel.org/linux-iommu/20220331062301.24269-1-tony@atomide.com/T/#u

Regards,

Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
