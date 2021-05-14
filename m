Return-Path: <SRS0=wlUX=KJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098CFC433ED
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 14:10:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0456145D
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 14:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0456145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 660D840133;
	Fri, 14 May 2021 14:10:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wNNMI7cUtFDQ; Fri, 14 May 2021 14:10:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C7A54010C;
	Fri, 14 May 2021 14:10:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20B74C000D;
	Fri, 14 May 2021 14:10:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DEDDC0001
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 14:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3E8F83C88
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 14:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CNcftalMbw3S for <iommu@lists.linux-foundation.org>;
 Fri, 14 May 2021 14:10:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43E8083C70
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 14:10:27 +0000 (UTC)
IronPort-SDR: tXnQjaS0ou03+6SaFzUvMSvM0v4plisEXPP9xJhYTFIukWqgNJ25Xon7k2OMiY7agd/w4K+Rj3
 x3ik/ee9WWRg==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="179779895"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; d="scan'208";a="179779895"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2021 07:10:03 -0700
IronPort-SDR: pUa5SXMkaSF0NpaKTA6tiUcvXOhttYEDx/x1fgIAeWUcNO3GmgNDKT6QcTQQVa/X3xwKGqbZhC
 K4LwJCQalHdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; d="scan'208";a="457827997"
Received: from yiliu-dev.bj.intel.com (HELO yiliu-dev) ([10.238.156.135])
 by fmsmga004.fm.intel.com with ESMTP; 14 May 2021 07:10:00 -0700
Date: Fri, 14 May 2021 22:08:45 +0800
From: Liu Yi L <yi.l.liu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210514220845.6cd053c3@yiliu-dev>
In-Reply-To: <20210514133939.GL1096940@ziepe.ca>
References: <20210510065405.2334771-1-hch@lst.de>
 <20210510065405.2334771-4-hch@lst.de>
 <20210510155454.GA1096940@ziepe.ca>
 <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca>
 <MWHPR11MB18863613CEBE3CDEEB86F4FC8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133939.GL1096940@ziepe.ca>
Organization: IAGS/SSE(OTC)
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: " <iommu@lists.linux-foundation.org>, "@osuosl.org,
 " <kvm@vger.kernel.org>"@osuosl.org, "Tian, Kevin" <kevin.tian@intel.com>,
 kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "linux-arm-kernel@lists.infradead.org\" <linux-arm-kernel@lists.infradead.org>,
 "@osuosl.org, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@lst.de>
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

Morning Jason,

On Fri, 14 May 2021 10:39:39 -0300, Jason Gunthorpe wrote:

> On Fri, May 14, 2021 at 01:17:23PM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Thursday, May 13, 2021 8:01 PM
> > > 
> > > On Thu, May 13, 2021 at 03:28:52AM +0000, Tian, Kevin wrote:
> > >   
> > > > Are you specially concerned about this iommu_device hack which
> > > > directly connects mdev_device to iommu layer or the entire removed
> > > > logic including the aux domain concept? For the former we are now
> > > > following up the referred thread to find a clean way. But for the latter
> > > > we feel it's still necessary regardless of how iommu interface is redesigned
> > > > to support device connection from the upper level driver. The reason is
> > > > that with mdev or subdevice one physical device could be attached to
> > > > multiple domains now. there could be a primary domain with DOMAIN_
> > > > DMA type for DMA_API use by parent driver itself, and multiple auxiliary
> > > > domains with DOMAIN_UNMANAGED types for subdevices assigned to
> > > > different VMs.  
> > > 
> > > Why do we need more domains than just the physical domain for the
> > > parent? How does auxdomain appear in /dev/ioasid?
> > >   
> > 
> > Another simple reason. Say you have 4 mdevs each from a different 
> > parent are attached to an ioasid. If only using physical domain of the 
> > parent + PASID it means there are 4 domains (thus 4 page tables) under 
> > this IOASID thus every dma map operation must be replicated in all
> > 4 domains which is really unnecessary. Having the domain created
> > with ioasid and allow a device attaching to multiple domains is much
> > cleaner for the upper-layer drivers to work with iommu interface.  
> 
> Eh? That sounds messed up.
> 
> The IOASID is the page table. If you have one IOASID and you attach it
> to 4 IOMMU routings (be it pasid, rid, whatever) then there should
> only ever by one page table.

yes, ioasid is the page table. But if want to let the 4 mdevs share the
same page table, it would be natural to let them share a domain. Since
mdev_device is not hw device, we should not let it participate in the
IOMMU. Therefore we got the aux-domain concept. mdev(RID#+PASID) is
attached to aux-domain. Such solution also fits the hybrid cases. e.g.
When there are both PF(RID#1) and mdev(RID#2+PASID) assigned to an ioasid,
they should share a page table as well. right? Surely we cannot attach the
PF(RID#1) to the domain of mdev's parent device(RID#2). Good way is PF(RID#1)
and the mdev (RID#2+PASID) attached to a single domain. This domain is
the primary domain for the PF(RID#1) but an aux-domain mdev's paretn(RID#2).

-- 
Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
