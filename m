Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4772FC433FE
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 17:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD2334026E;
	Wed, 11 May 2022 17:21:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TAz4IyM0Otf6; Wed, 11 May 2022 17:21:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B36CA40135;
	Wed, 11 May 2022 17:21:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B5D5C0032;
	Wed, 11 May 2022 17:21:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90C90C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 17:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D14260A84
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 17:21:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GlPlQg-VT5V8 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 17:21:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 598E66068D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652289698; x=1683825698;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qy7t1Ypki7j0iCcWaRmk0ORRY2L4RZAMrStqlHAMWPM=;
 b=fQ9wnn9rzsJ3W07qpex/trYj0pNUTF7TMiG9QaLo4POX6FQ8nZosuokM
 a59EpU22Dut5n3aMVCOgQbqUsmmqd6xsbaBJyqheFO9gfHi2KLAcATN73
 XEIUSwjVmT7YQXRTM52bM/Vmvr6z4Eli+Dur8lv12PPOch45PtBI3shiR
 eXyZh1D5wOiMp2u/5gHJMoJ+61v0EX/kc9xoRoF/CfVqVbiroP/mC2sIy
 RVSE0wirOcAWafxRjnYw52b3rGRp5ngTeQFZGTm8kHGDkmp1pS0s82MMo
 NkE3Xn/837alGc17nkaTuoyzKkMOHJYlbJwzKRcsr/oGTTOhQ28Y1fF9K A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269433412"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; d="scan'208";a="269433412"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 10:21:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; d="scan'208";a="553414882"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 10:21:35 -0700
Date: Wed, 11 May 2022 10:25:21 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220511102521.6b7c578c@jacob-builder>
In-Reply-To: <20220511170025.GF49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
 <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com>
 <20220511100216.7615e288@jacob-builder>
 <20220511170025.GF49344@nvidia.com>
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

On Wed, 11 May 2022 14:00:25 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 11, 2022 at 10:02:16AM -0700, Jacob Pan wrote:
> > > > If not global, perhaps we could have a list of pasids (e.g. xarray)
> > > > attached to the device_domain_info. The TLB flush logic would just
> > > > go through the list w/o caring what the PASIDs are for. Does it
> > > > make sense to you?    
> > > 
> > > Sort of, but we shouldn't duplicate xarrays - the group already has
> > > this xarray - need to find some way to allow access to it from the
> > > driver.
> > >   
> > I am not following,  here are the PASIDs for devTLB flush which is per
> > device. Why group?  
> 
> Because group is where the core code stores it.
I see, with singleton group. I guess I can let dma-iommu code call

iommu_attach_dma_pasid {
	iommu_attach_device_pasid();
Then the PASID will be stored in the group xa.
The flush code can retrieve PASIDs from device_domain_info.device -> group
-> pasid_array.
Thanks for pointing it out, I missed the new pasid_array.
> 
> > We could retrieve PASIDs from the device PASID table but xa would be
> > more efficient.
> >   
> > > > > > Are you suggesting the dma-iommu API should be called
> > > > > > iommu_set_dma_pasid instead of iommu_attach_dma_pasid?      
> > > > > 
> > > > > No that API is Ok - the driver ops API should be 'set' not
> > > > > attach/detach   
> > > > Sounds good, this operation has little in common with
> > > > domain_ops.dev_attach_pasid() used by SVA domain. So I will add a
> > > > new domain_ops.dev_set_pasid()    
> > > 
> > > What? No, their should only be one operation, 'dev_set_pasid' and it
> > > is exactly the same as the SVA operation. It configures things so that
> > > any existing translation on the PASID is removed and the PASID
> > > translates according to the given domain.
> > > 
> > > SVA given domain or UNMANAGED given domain doesn't matter to the
> > > higher level code. The driver should implement per-domain ops as
> > > required to get the different behaviors.  
> > Perhaps some code to clarify, we have
> > sva_domain_ops.dev_attach_pasid() = intel_svm_attach_dev_pasid;
> > default_domain_ops.dev_attach_pasid() = intel_iommu_attach_dev_pasid;  
> 
> Yes, keep that structure
>  
> > Consolidate pasid programming into dev_set_pasid() then called by both
> > intel_svm_attach_dev_pasid() and intel_iommu_attach_dev_pasid(), right?
> >  
> 
> I was only suggesting that really dev_attach_pasid() op is misnamed,
> it should be called set_dev_pasid() and act like a set, not a paired
> attach/detach - same as the non-PASID ops.
> 
Got it. Perhaps another patch to rename, Baolu?


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
