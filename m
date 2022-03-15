Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0603C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 16:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C31F400D9;
	Tue, 15 Mar 2022 16:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YjtmuJD33HOd; Tue, 15 Mar 2022 16:11:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8190140012;
	Tue, 15 Mar 2022 16:11:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EDC6C001A;
	Tue, 15 Mar 2022 16:11:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDD31C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7045814A0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:11:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FIEJtZWVTzzZ for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 16:11:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FCF381464
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647360661; x=1678896661;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mYoawQt8/mjlKy6DboqveGnemw0SfDUDHd8XG2dieWM=;
 b=mQp/8dfF4NXRQck3+CNIJS0TvOmbAdEldG2QOPKy3l8OcG5rGy58TmXZ
 SZHK0ZZsET1twA0VXFiQ5xiggLhtSNSLIzdGEwYxCLQ24IxGoR+K6T652
 owz6fhQlK1/mIlHBMgq1D5x+YTeJ/mU+Uez2VCJwWWRNaus0xjGCKASkn
 /KKtremobwPMfPoVRH59aDnRHKrDmJ4Rbs17ywojhlbhjXhbNri/1EG/q
 /wugcKlZ9SS37Ln3u8NMlQ6/ZGDx+h28cftTXQB6PlaMQ0KJ0WQDhPgpk
 oRst1UrJxEZSPsmgmuRxqY+Buh2pMoCUTk3u5ynmk3mIUVp5CUawCLZ4F w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256298396"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="256298396"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 09:08:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="540497258"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 09:08:00 -0700
Date: Tue, 15 Mar 2022 09:11:16 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <20220315091116.26e10b1b@jacob-builder>
In-Reply-To: <BN9PR11MB5276D5B88C05B509C2C790A98C109@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
 <YjB4AyrgsnbUrlLe@myrica>
 <BN9PR11MB5276D5B88C05B509C2C790A98C109@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Luck,
 Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason
 Gunthorpe <jgg@nvidia.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
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

Hi Kevin,

On Tue, 15 Mar 2022 11:49:57 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Tuesday, March 15, 2022 7:27 PM
> > 
> > On Mon, Mar 14, 2022 at 10:07:06PM -0700, Jacob Pan wrote:  
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > >
> > > An IOMMU domain represents an address space which can be attached by
> > > devices that perform DMA within a domain. However, for platforms with
> > > PASID capability the domain attachment needs be handled at
> > > device+PASID level. There can be multiple PASIDs within a device and
> > > multiple devices attached to a given domain.
> > > This patch introduces a new IOMMU op which support device, PASID, and
> > > IOMMU domain attachment. The immediate use case is for PASID capable
> > > devices to perform DMA under DMA APIs.
> > >
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  include/linux/iommu.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index 369f05c2a4e2..fde5b933dbe3 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
> > >   * @aux_get_pasid: get the pasid given an aux-domain
> > >   * @sva_bind: Bind process address space to device
> > >   * @sva_unbind: Unbind process address space from device
> > > + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> > > + * @detach_dev_pasid: detach an iommu domain from a pasid of device  
> > 
> > Isn't that operation "assign a PASID to a domain" instead?  In patch 5,
> > the domain is already attached to the device, so set_domain_pasid()
> > might be clearer and to the point. If the IOMMU driver did the
> > allocation we could also avoid patch 1.
I agree, we could let vendor driver do the allocation inside this op. On
the other side, we could also keep the flexibility such that this op can be
used for guest PASID bind, with a SVA domain.
> 
> iiuc this API can also work for future SIOV usage where each mdev attached
> to the domain has its own pasid. "assigning a PASID to a domain" sounds
> like going back to the previous aux domain approach which has one PASID
> per domain and that PASID is used on all devices attached to the aux
> domain...
> 
yes, that is the intention. I plan to lift the requirement in patch 5 such
that device attachment will not be a prerequisite. That would be after mdev
adoption.

> > 
> > If I understand correctly this series is not about a generic PASID API
> > that allows drivers to manage multiple DMA address spaces, because there
> > still doesn't seem to be any interest in that. It's about the specific
> > IDXD use-case, so let's focus on that. We can introduce a specialized
> > call such as (iommu|dma)_set_device_pasid(), which will be easy to
> > consolidate later into a more generic "dma_enable_pasid()" API if that
> > ever seems useful.
> > 
Right, at the moment it is still a single address space. i.e. the current
domain of the device/group.

But this limitation is at the driver facing API layer not limited in the
IOMMU ops.

> > Thanks,
> > Jean
> >   
> > >   * @sva_get_pasid: Get PASID associated to a SVA handle
> > >   * @page_response: handle page request response
> > >   * @cache_invalidate: invalidate translation caches
> > > @@ -296,6 +298,10 @@ struct iommu_ops {
> > >  	struct iommu_sva *(*sva_bind)(struct device *dev, struct
> > > mm_struct  
> > *mm,  
> > >  				      void *drvdata);
> > >  	void (*sva_unbind)(struct iommu_sva *handle);
> > > +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> > > +				struct device *dev, ioasid_t id);
> > > +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> > > +				 struct device *dev, ioasid_t id);
> > >  	u32 (*sva_get_pasid)(struct iommu_sva *handle);
> > >
> > >  	int (*page_response)(struct device *dev,
> > > --
> > > 2.25.1
> > >  


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
