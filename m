Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C067C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 15:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E881883DFE;
	Wed, 11 May 2022 15:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0YEoPcHQCHem; Wed, 11 May 2022 15:31:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C05CC83332;
	Wed, 11 May 2022 15:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9852BC0032;
	Wed, 11 May 2022 15:31:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F2E7C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 15:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8049A819F5
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 15:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OqBi4o92Vvja for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 15:31:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B88978138F
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652283114; x=1683819114;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ndczgwyznivdqv1iFCHWhopQvKb+2Iqd5Yk+4O3ea9c=;
 b=Ir07NK4Bjm6H0lGJB91uLi+qMWqdZzVneLrd1K7rA8KNhZtGzIDiBoCg
 JKuF8wvOHUt7NQdeA4xSuK3X8vHjEtXOo/dJy8wSsMKFb5Iic7A1RpEtt
 e38VaAFsdF2kNu/d7IK3KYZKLRo2ICjPoiGCXPOjExsNZDFsoJ4dUciet
 6LFMehG5cyHEMyO5dmjBd9zBi8aXIfOwF+4nae4nOJyBUM8QQlaIKKq5+
 VDz9Tv7rcJ17zOvHdv1xAHUMk9COYkfmF5ENKgY5gfYRfwZj9ubG7Khop
 D7SYatQG49HpgSU8q9bHVrjsfBz0TAEG3BU6ANKJnSWO5M8i+9wx7R8SL g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269862675"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; d="scan'208";a="269862675"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 08:31:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; d="scan'208";a="895392286"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 08:31:32 -0700
Date: Wed, 11 May 2022 08:35:18 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220511082958.79d5d8ee@jacob-builder>
In-Reply-To: <20220511115427.GU49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
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

On Wed, 11 May 2022 08:54:27 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 10, 2022 at 05:23:09PM -0700, Jacob Pan wrote:
> 
> > > > diff --git a/include/linux/intel-iommu.h
> > > > b/include/linux/intel-iommu.h index 5af24befc9f1..55845a8c4f4d
> > > > 100644 +++ b/include/linux/intel-iommu.h
> > > > @@ -627,6 +627,7 @@ struct device_domain_info {
> > > >  	struct intel_iommu *iommu; /* IOMMU used by this device */
> > > >  	struct dmar_domain *domain; /* pointer to domain */
> > > >  	struct pasid_table *pasid_table; /* pasid table */
> > > > +	ioasid_t pasid; /* DMA request with PASID */    
> > > 
> > > And this seems wrong - the DMA API is not the only user of
> > > attach_dev_pasid, so there should not be any global pasid for the
> > > device.
> > >   
> > True but the attach_dev_pasid() op is domain type specific. i.e. DMA API
> > has its own attach_dev_pasid which is different than sva domain
> > attach_dev_pasid().  
> 
> Huh? The intel driver shares the same ops between UNMANAGED and DMA -
> and in general I do not think we should be putting special knowledge
> about the DMA domains in the drivers. Drivers should continue to treat
> them identically to UNMANAGED.
> 
OK, other than SVA domain, the rest domain types share the same default ops.
I agree that the default ops should be the same for UNMANAGED, IDENTITY, and
DMA domain types. Minor detail is that we need to treat IDENTITY domain
slightly different when it comes down to PASID entry programming.

If not global, perhaps we could have a list of pasids (e.g. xarray) attached
to the device_domain_info. The TLB flush logic would just go through the
list w/o caring what the PASIDs are for. Does it make sense to you?

> > device_domain_info is only used by DMA API.  
> 
> Huh?
My mistake, i meant the device_domain_info.pasid is only used by DMA API

>  
> > > I suspect this should be a counter of # of pasid domains attached so
> > > that the special flush logic triggers
> > >   
> > This field is only used for devTLB, so it is per domain-device. struct
> > device_domain_info is allocated per device-domain as well. Sorry, I
> > might have totally missed your point.  
> 
> You can't store a single pasid in the driver like this, since the only
> thing it does is trigger the flush logic just count how many pasids
> are used by the device-domain and trigger pasid flush if any pasids
> are attached
> 
Got it, will put the pasids in an xa as described above.

> > > And rely on the core code to worry about assigning only one domain per
> > > pasid - this should really be a 'set' function.  
> >
> > Yes, in this set the core code (in dma-iommu.c) only assign one PASID
> > per DMA domain type.
> > 
> > Are you suggesting the dma-iommu API should be called
> > iommu_set_dma_pasid instead of iommu_attach_dma_pasid?  
> 
> No that API is Ok - the driver ops API should be 'set' not attach/detach
> 
Sounds good, this operation has little in common with
domain_ops.dev_attach_pasid() used by SVA domain. So I will add a new
domain_ops.dev_set_pasid()


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
