Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC32C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 22:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3CD760BA4;
	Tue, 15 Mar 2022 22:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zaG2FJSVoYrf; Tue, 15 Mar 2022 22:20:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 764FD60B1A;
	Tue, 15 Mar 2022 22:20:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41C0EC001D;
	Tue, 15 Mar 2022 22:20:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92D0AC0012
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 22:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D0A960B1A
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 22:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ek9eWptUP_Yj for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 22:20:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A89CB60B83
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 22:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647382804; x=1678918804;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ftAV5fWCIIwIFJtTVZEpph+lygZNASFk6VFTJssfJdE=;
 b=HXXtGQpebUulFiIlpKaKIakhFa1VsmdyTxH9/5t09xpcbHGzH/DzSC29
 148Hlbr759ms9GlC/f1GooqKrVT8zLcIMe+qvGgs7LF7xYDhdW487JyeI
 eshm2eLn4GLFHGACxnaVvddRbl/Jp+V6cdFTrli1DXFEPKQ1YYPNVVt8+
 Nyno4rXyDZC/trVt6D81N7d2Fwk6sXWoG9u+W8Yl/rvD9/TdePXZMswrm
 VqHKbfKytWurmZ6zhDDF8U3566y/XwED8qGHjBGvJuEjmvU4O1M44tgzP
 HdK+ImnGTp54pGSjYcQsBq8ebl0s+rt98kHKOs/TqgcUWE/ATzsGKR88l g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255264274"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="255264274"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 15:20:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="557137205"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 15:20:02 -0700
Date: Tue, 15 Mar 2022 15:23:18 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220315152318.262dd0bf@jacob-builder>
In-Reply-To: <BN9PR11MB52768A46ED515D2E02FFEF5D8C109@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52768A46ED515D2E02FFEF5D8C109@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Luck,
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

On Tue, 15 Mar 2022 10:33:08 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > 
> > On VT-d platforms with scalable mode enabled, devices issue DMA requests
> > with PASID need to attach to the correct IOMMU domains.
> > The attach operation involves the following:
> > - programming the PASID into device's PASID table
> > - tracking device domain and the PASID relationship
> > - managing IOTLB and device TLB invalidations
> > 
> > This patch extends DMAR domain and device domain info with xarrays to
> > track per domain and per device PASIDs.  It provides the flexibility to
> > be used beyond DMA API PASID support.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 194
> > +++++++++++++++++++++++++++++++++++-
> >  include/linux/intel-iommu.h |  12 ++-
> >  2 files changed, 202 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 881f8361eca2..9267194eaed3 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1622,20 +1622,48 @@ static void __iommu_flush_dev_iotlb(struct
> > device_domain_info *info,
> >  			   qdep, addr, mask);
> >  }
> > 
> > +static void __iommu_flush_dev_piotlb(struct device_domain_info *info,  
> 
> piotlb is confusing, better be:
> 
> 	__iommu_flush_dev_iotlb_pasid()
> 
yeah, that is more clear.

> > +					u64 address,
> > +				     ioasid_t pasid, unsigned int mask)
> > +{
> > +	u16 sid, qdep;
> > +
> > +	if (!info || !info->ats_enabled)
> > +		return;
> > +
> > +	sid = info->bus << 8 | info->devfn;
> > +	qdep = info->ats_qdep;
> > +	qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
> > +				 pasid, qdep, address, mask);
> > +}
> > +
> >  static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
> >  				  u64 addr, unsigned mask)
> >  {
> >  	unsigned long flags;
> >  	struct device_domain_info *info;
> >  	struct subdev_domain_info *sinfo;
> > +	unsigned long pasid;
> > +	struct pasid_info *pinfo;
> > 
> >  	if (!domain->has_iotlb_device)
> >  		return;
> > 
> >  	spin_lock_irqsave(&device_domain_lock, flags);
> > -	list_for_each_entry(info, &domain->devices, link)
> > -		__iommu_flush_dev_iotlb(info, addr, mask);
> > -
> > +	list_for_each_entry(info, &domain->devices, link) {
> > +		/*
> > +		 * We cannot use PASID based devTLB invalidation on
> > RID2PASID
> > +		 * Device does not understand RID2PASID/0. This is
> > different  
> 
> Lack of a conjunction word between 'RID2PASID' and 'Device'.
> 
> and what is RID2PASID/0? It would be clearer to point out that RID2PASID
> is visible only within the iommu to mark out requests without PASID, 
> thus this PASID value should never be sent to the device side.
> 
Good point, will do.

> > +		 * than IOTLB invalidation where RID2PASID is also
> > used for
> > +		 * tagging.  
> 
> Then it would be obvious because IOTLB is iommu internal agent thus takes 
> use of RID2PASID for tagging.
> 
ditto

> > +		 */
> > +		xa_for_each(&info->pasids, pasid, pinfo) {
> > +			if (!pasid)  
> 
> this should be compared to PASID_RID2PASID (though it's zero today).
> 
ditto

> > +				__iommu_flush_dev_iotlb(info, addr,
> > mask);
> > +			else
> > +				__iommu_flush_dev_piotlb(info, addr,
> > pasid, mask);
> > +		}
> > +	}
> >  	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> >  		info = get_domain_info(sinfo->pdev);
> >  		__iommu_flush_dev_iotlb(info, addr, mask);  
> 
> Thanks
> Kevin


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
