Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8C0C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 19:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3753542486;
	Thu,  9 Dec 2021 19:14:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fvxXSWH8fQBx; Thu,  9 Dec 2021 19:14:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C95BE42482;
	Thu,  9 Dec 2021 19:14:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A965C001E;
	Thu,  9 Dec 2021 19:14:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9FA1C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5A71426E0
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qD5bkLWGSINz for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 19:14:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC2D84264C
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:14:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218211859"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; d="scan'208";a="218211859"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 11:13:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; d="scan'208";a="564935042"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 11:13:59 -0800
Date: Thu, 9 Dec 2021 11:18:17 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <20211209111817.6a84a55c@jacob-builder>
In-Reply-To: <BN9PR11MB527617F8CC015E4F15EDCC9F8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131358.GR6385@nvidia.com>
 <1ffc1366-2711-3026-fb09-8f60a260f618@intel.com>
 <20211208175116.GC6385@nvidia.com>
 <BN9PR11MB527617F8CC015E4F15EDCC9F8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Luck, Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>
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

Hi Kevin,

On Thu, 9 Dec 2021 01:48:09 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, December 9, 2021 1:51 AM
> >   
> > > > > +	/*
> > > > > +	 * Try to enable both in-kernel and user DMA request
> > > > > with PASID.
> > > > > +	 * PASID is supported unless both user and kernel PASID
> > > > > are
> > > > > +	 * supported. Do not fail probe here in that idxd can
> > > > > still be
> > > > > +	 * used w/o PASID or IOMMU.
> > > > > +	 */
> > > > > +	if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) ||
> > > > > +		idxd_enable_system_pasid(idxd)) {
> > > > > +		dev_warn(dev, "Failed to enable PASID\n");
> > > > > +	} else {
> > > > > +		set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > > > >   	}  
> > > > Huh? How can the driver keep going if PASID isn't supported? I
> > > > thought the whole point of this was because the device cannot do
> > > > DMA without PASID at all?  
> > >
> > > There are 2 types of WQ supported with the DSA devices. A dedicated
> > > WQ  
> > type  
> > > and a shared WQ type. The dedicated WQ type can support DMA with and  
> > without  
> > > PASID. The shared wq type must have a PASID to operate. The driver can
> > > support dedicated WQ only without PASID usage when there is no PASID
> > > support.  
> > 
> > Can you add to the cover letter why does the kernel require to use the
> > shared WQ?
> > 
> > Jason  
> 
> Two reasons:
> 
> On native the shared WQ is useful when the kernel wants to offload
> some memory operations (e.g. page-zeroing) to DSA. When #CPUs are
> more than #WQs, this allows per-cpu lock-less submissions using
> ENQCMD(PASID, payload) instruction.
> 
> In guest the virtual DSA HW may only contain a WQ in shared mode
> (unchangeable by the guest) when the host admin wants to share
> the limited WQ resource among many VMs. Then there is no choice
> in guest regardless whether it's for user or kernel controlled DMA.
I will add these to the next cover letter.


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
