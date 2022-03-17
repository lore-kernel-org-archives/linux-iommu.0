Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC55C433F5
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 20:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8C8D418FE;
	Thu, 17 Mar 2022 20:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CQFSdrJ0-BcM; Thu, 17 Mar 2022 20:42:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B72F2418F8;
	Thu, 17 Mar 2022 20:42:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 839AFC0012;
	Thu, 17 Mar 2022 20:42:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 555C5C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 20:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CFA660B0E
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 20:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mksWqVsibJV4 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 20:42:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DBB960AD0
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 20:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647549735; x=1679085735;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZPJPlyM9zhjOGH64p0/EhU5dIkf9pGM8NWxT3n0sIXg=;
 b=bz/BVIIsyH1KhjSQAPbKUF26keoPBz/iASNdfKE+xpo5bGX0Aa1KTWuX
 3OrnW0aI3v8aNk9DoodCXDebLaBir0Xp8Ggetf7q7B/lDV+3XcR103I/H
 DQ3u2S8pI6NwMXLy/aBQsv4F23bwBVLHsbcUZnH+GDXBGTbakYxBB5MI3
 vJGox02/3DxtK8EOkQ5E8KJv39Jdfb4mj5ReDJve04ZYp8MbHVBUhHlhW
 1+OXtvuEcAMyQp+xUaPUEb1qtlkYnrOUFhvIx80Fy93b854+6FsU9gFfu
 F4dclWpBVKsEHv/CXKsV4aFrTMOnEPykL4EgdWinek/OycEihAVckdIkm w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="244433109"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; d="scan'208";a="244433109"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2022 13:42:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; d="scan'208";a="599237997"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2022 13:42:14 -0700
Date: Thu, 17 Mar 2022 13:45:30 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 4/8] iommu/vt-d: Use device_pasid attach op for
 RID2PASID
Message-ID: <20220317134530.36321009@jacob-builder>
In-Reply-To: <BN9PR11MB52766909013F9CC71A61369C8C119@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-5-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52766909013F9CC71A61369C8C119@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Wed, 16 Mar 2022 07:54:19 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > 
> > With the availability of a generic device-PASID-domain attachment API,
> > there's no need to special case RID2PASID.  Use the API to replace
> > duplicated code.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 18 ++----------------
> >  1 file changed, 2 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 9267194eaed3..f832b7599d21 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1683,9 +1683,6 @@ static void domain_flush_piotlb(struct
> > intel_iommu *iommu,
> >  		qi_flush_piotlb(iommu, did, domain->default_pasid,
> >  				addr, npages, ih);
> > 
> > -	if (!list_empty(&domain->devices))
> > -		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr,
> > npages, ih);
> > -  
> 
> this should be rebased on top of Baolu's "iommu cleanup and refactoring"
> series which has removed the entire domain_flush_piotlb().
> 
Yes, I have been working with Baolu. Some of the refactoring patches were
withdrawn, so there are lots of moving targets. 

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
