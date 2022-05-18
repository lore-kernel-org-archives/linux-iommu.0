Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9498DC433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FBC383E9B;
	Wed, 18 May 2022 18:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zXv9adUSkAcJ; Wed, 18 May 2022 18:39:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F99883EBE;
	Wed, 18 May 2022 18:39:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE82BC0032;
	Wed, 18 May 2022 18:39:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7370EC002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6802240374
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jpq9SJqTg4c0 for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:39:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 967DB404ED
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652899165; x=1684435165;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M/oKhYTcnY4myTpFoegzGHopmAVVEEzgyLwyapl7tQQ=;
 b=CQSOgYvUw1yDpcJEwwu80X6KSW4saCQnUM/lRNCINrNXR86cuSUqbsqw
 5IyCi4wJ94BK+C0r/Cam1jx12rafFVku9WSDKy6/C/O2nP7zHBnzz/YEK
 YnB5C4lj9KEIM67U3urr6cZN0dNUnO7f9mZiD0oX2zZ9JnThwUZj35Asa
 umJUe/TEbKlWvX9pwoFOBwRIJyscfb2QqA2ElkU//dK96MCZV/Bk7XMVQ
 /bYc3f23jArruiZrZDR8X09+V0rbxa96/KFGAHn2WyiGz+PR+061SbTb1
 7kMt32zrnYhFy4yGais4hb0wtuRyAXzEptS9HENhcsTY4FILzHPVRAjKs w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="332456934"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="332456934"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 11:38:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="569686074"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 11:38:14 -0700
Date: Wed, 18 May 2022 11:42:04 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220518114204.4d251b41@jacob-builder>
In-Reply-To: <20220511182908.GK49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
 <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com>
 <20220511100216.7615e288@jacob-builder>
 <20220511170025.GF49344@nvidia.com>
 <20220511102521.6b7c578c@jacob-builder>
 <20220511182908.GK49344@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, robin.murphy@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Jason,

On Wed, 11 May 2022 15:29:08 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 11, 2022 at 10:25:21AM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 11 May 2022 14:00:25 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Wed, May 11, 2022 at 10:02:16AM -0700, Jacob Pan wrote:  
> > > > > > If not global, perhaps we could have a list of pasids (e.g.
> > > > > > xarray) attached to the device_domain_info. The TLB flush logic
> > > > > > would just go through the list w/o caring what the PASIDs are
> > > > > > for. Does it make sense to you?      
> > > > > 
> > > > > Sort of, but we shouldn't duplicate xarrays - the group already
> > > > > has this xarray - need to find some way to allow access to it
> > > > > from the driver.
> > > > >     
> > > > I am not following,  here are the PASIDs for devTLB flush which is
> > > > per device. Why group?    
> > > 
> > > Because group is where the core code stores it.  
> > I see, with singleton group. I guess I can let dma-iommu code call
> > 
> > iommu_attach_dma_pasid {
> > 	iommu_attach_device_pasid();
> > Then the PASID will be stored in the group xa.  
> 
> Yes, again, the dma-iommu should not be any different from the normal
> unmanaged path. At this point there is no longer any difference, we
> should not invent new ones.
> 
> > The flush code can retrieve PASIDs from device_domain_info.device ->
> > group -> pasid_array.  Thanks for pointing it out, I missed the new
> > pasid_array.  
> 
> Yes.. It seems inefficient to iterate over that xarray multiple times
> on the flush hot path, but maybe there is little choice. Try to use
> use the xas iterators under the xa_lock spinlock..
> 
xas_for_each takes a max range, here we don't really have one. So I posted
v4 w/o using the xas advanced API. Please let me know if you have
suggestions.
xa_for_each takes RCU read lock, it should be fast for tlb flush, right? The
worst case maybe over flush when we have stale data but should be very rare.

> The challenge will be accessing the group xa in the first place, but
> maybe the core code can gain a function call to return a pointer to
> that XA or something..
> 
I added a helper function to find the matching DMA API PASID in v4.


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
