Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7EDC433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 15:17:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0256127B
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 15:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE0256127B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7669F425A1;
	Thu, 30 Sep 2021 15:17:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hX_j2Y90OAMh; Thu, 30 Sep 2021 15:17:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0582F4259E;
	Thu, 30 Sep 2021 15:17:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D11D8C0011;
	Thu, 30 Sep 2021 15:17:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 301EAC000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 15:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0917140352
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 15:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BIxZCgo1FthU for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:17:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E01DD40346
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 15:17:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="212287597"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="212287597"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 08:17:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="487364233"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 08:17:41 -0700
Date: Thu, 30 Sep 2021 08:21:21 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Campin, Mike" <mike.campin@intel.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20210930082121.444299be@jacob-builder>
In-Reply-To: <CO1PR11MB5153C703BC0E0112CE7F65B2F3AA9@CO1PR11MB5153.namprd11.prod.outlook.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210929123437.721991dc@jacob-builder>
 <20210929193953.GX964074@nvidia.com>
 <20210929155720.794b6e65@jacob-builder>
 <20210929234301.GC964074@nvidia.com>
 <CO1PR11MB5153C703BC0E0112CE7F65B2F3AA9@CO1PR11MB5153.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>
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

Hi Mike,

On Thu, 30 Sep 2021 14:22:34 +0000, "Campin, Mike" <mike.campin@intel.com>
wrote:

> I need support for mixed user PASID, kernel PASID and non-PASID use cases
> in the driver.
> 
This specific RFC is for kernel PASID only. User PASID native use is
supported under SVA lib kernel API and /dev/uacce UAPI or driver specific
char dev. Guest PASID is being developed under the new /dev/iommu framework.
Non-PASID kernel use should be under DMA API unchanged from the driver's
POV. In fact, this proposal will map non-PASID and PASID DMA identically.

Thanks,

Jacob

> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com> 
> Sent: Wednesday, September 29, 2021 4:43 PM
> To: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org; LKML
> <linux-kernel@vger.kernel.org>; Joerg Roedel <joro@8bytes.org>; Christoph
> Hellwig <hch@infradead.org>; Tian, Kevin <kevin.tian@intel.com>; Luck,
> Tony <tony.luck@intel.com>; Jiang, Dave <dave.jiang@intel.com>; Raj,
> Ashok <ashok.raj@intel.com>; Kumar, Sanjay K <sanjay.k.kumar@intel.com>;
> Campin, Mike <mike.campin@intel.com>; Thomas Gleixner
> <tglx@linutronix.de> Subject: Re: [RFC 0/7] Support in-kernel DMA with
> PASID and SVA
> 
> On Wed, Sep 29, 2021 at 03:57:20PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 29 Sep 2021 16:39:53 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Wed, Sep 29, 2021 at 12:37:19PM -0700, Jacob Pan wrote:
> > >    
> > > > For #2, it seems we can store the kernel PASID in struct device. 
> > > > This will preserve the DMA API interface while making it PASID
> > > > capable. Essentially, each PASID capable device would have two
> > > > special global
> > > > PASIDs: 
> > > > 	- PASID 0 for DMA request w/o PASID, aka RID2PASID
> > > > 	- PASID 1 (randomly selected) for in-kernel DMA request w/
> > > > PASID  
> > > 
> > > This seems reasonable, I had the same thought. Basically just have 
> > > the driver issue some trivial call:
> > >   pci_enable_pasid_dma(pdev, &pasid)  
> > That would work, but I guess it needs to be an iommu_ call instead of
> > pci_?  
> 
> Which ever makes sense..  The API should take in a struct pci_device and
> return a PCI PASID - at least as a wrapper around a more generic immu api.
> 
> > I think your suggestion is more precise, in case the driver does not 
> > want to do DMA w/ PASID, we can do less IOTLB flush (PASID 0 only).  
> 
> Since it is odd, and it may create overhead, I would do it only when
> asked to do it
> 
> > > Having multiple RID's pointing at the same IO page table is 
> > > something we expect iommufd to require so the whole thing should 
> > > ideally fall out naturally.  
> 
> > That would be the equivalent of attaching multiple devices to the same 
> > IOMMU domain. right?  
> 
> Effectively..
> 
> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
