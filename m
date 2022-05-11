Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF06C433FE
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 16:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE08B60D94;
	Wed, 11 May 2022 16:58:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xyA8O9mD0oBm; Wed, 11 May 2022 16:58:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 87BBD60BD6;
	Wed, 11 May 2022 16:58:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69605C0039;
	Wed, 11 May 2022 16:58:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 835E7C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 16:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 631D040135
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 16:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cp8xxIgK4OAz for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 16:58:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6D79400E4
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652288311; x=1683824311;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L+SbLcoPf9zuYRgUS6mcapuzb8rI2aXPD90HpmL4jgs=;
 b=mML3h5lMQEeTfOgGvKVknUu1AOYyGAeUQLy14UyvKsBM7IJ+4dR8qBza
 AQUtEeLTLYEhCSVmBwi8RHTlDdUhl4J5eWMr7aQaOSyTR2uhfk6cire2t
 WpxBhVfxpbXjYkeGcjDc0G7nO+rj/A3ehNCjkpQo9RTcljWyMHqmzrG3d
 B5gMZztzjXqmJNJ68SfOYQ5dHHz3icYIbqNlsE0RNaJLttyp5JEGcBBNm
 JqMerFSv2YUxgEi0qlZX7Vm7zE0U3Y42d/QgB+Zear0BXpZ2NaNVzJyFE
 dByW1jkcUDWpbat9coRznKUK3/MB7c9T187Jvb4ByGK+BKwamYGVn598t g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="332791594"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; d="scan'208";a="332791594"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 09:58:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; d="scan'208";a="520594260"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 09:58:29 -0700
Date: Wed, 11 May 2022 10:02:16 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220511100216.7615e288@jacob-builder>
In-Reply-To: <20220511161237.GB49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
 <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com>
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

On Wed, 11 May 2022 13:12:37 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 11, 2022 at 08:35:18AM -0700, Jacob Pan wrote:
> 
> > > Huh? The intel driver shares the same ops between UNMANAGED and DMA -
> > > and in general I do not think we should be putting special knowledge
> > > about the DMA domains in the drivers. Drivers should continue to treat
> > > them identically to UNMANAGED.
> > >   
> > OK, other than SVA domain, the rest domain types share the same default
> > ops. I agree that the default ops should be the same for UNMANAGED,
> > IDENTITY, and DMA domain types. Minor detail is that we need to treat
> > IDENTITY domain slightly different when it comes down to PASID entry
> > programming.  
> 
> I would be happy if IDENTITY had its own ops, if that makes sense
> 
I have tried to have its own ops but there are complications around
checking if a domain has ops. It would be a logic thing to clean up next.

> > If not global, perhaps we could have a list of pasids (e.g. xarray)
> > attached to the device_domain_info. The TLB flush logic would just go
> > through the list w/o caring what the PASIDs are for. Does it make sense
> > to you?  
> 
> Sort of, but we shouldn't duplicate xarrays - the group already has
> this xarray - need to find some way to allow access to it from the
> driver.
> 
I am not following,  here are the PASIDs for devTLB flush which is per
device. Why group?
We could retrieve PASIDs from the device PASID table but xa would be more
efficient.

> > > > Are you suggesting the dma-iommu API should be called
> > > > iommu_set_dma_pasid instead of iommu_attach_dma_pasid?    
> > > 
> > > No that API is Ok - the driver ops API should be 'set' not
> > > attach/detach 
> > Sounds good, this operation has little in common with
> > domain_ops.dev_attach_pasid() used by SVA domain. So I will add a new
> > domain_ops.dev_set_pasid()  
> 
> What? No, their should only be one operation, 'dev_set_pasid' and it
> is exactly the same as the SVA operation. It configures things so that
> any existing translation on the PASID is removed and the PASID
> translates according to the given domain.
> 
> SVA given domain or UNMANAGED given domain doesn't matter to the
> higher level code. The driver should implement per-domain ops as
> required to get the different behaviors.
Perhaps some code to clarify, we have
sva_domain_ops.dev_attach_pasid() = intel_svm_attach_dev_pasid;
default_domain_ops.dev_attach_pasid() = intel_iommu_attach_dev_pasid;

Consolidate pasid programming into dev_set_pasid() then called by both
intel_svm_attach_dev_pasid() and intel_iommu_attach_dev_pasid(), right?


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
