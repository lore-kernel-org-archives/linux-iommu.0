Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF74C433EF
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 20:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA5B982A87;
	Tue, 24 May 2022 20:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KRisJOw_NqjS; Tue, 24 May 2022 20:41:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 97D9882A3B;
	Tue, 24 May 2022 20:41:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 653EDC0032;
	Tue, 24 May 2022 20:41:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 619EEC002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 20:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41E2560AE9
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 20:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMyOdf7ZXaR3 for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 20:41:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97E7460A91
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 20:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653424896; x=1684960896;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yIv8vgMmqMTj4IZXd8vqbLx0EuYjS2FZ1lkgJF4zRYM=;
 b=hZ/slkLqe1KPI+TAgOk+e5gDv/9K5Fd3Ue5OP9HBH6AJVWkWkYShLqGR
 ta3SOJ8SlKJbPJCNkJRXTJNxetecyeMUoQmxWflp4GIcTDK/qkwNK6M7U
 WPOoXZuOFBaNoU3qaf+mC/Ua2kkYKNh6vH1PzHG/UuVIaJiRYas1bLmvR
 3nRzNTgqohPzeK2HdafLAHEuUWY3hey7Wsy5meLYkPEBa06LWUSEs5/Gf
 SEyB/e85YYiVsY5pEHxcPdA9Rd2e8Zt04L2TuEV7pfRNUrDoi7Es2WGye
 ZY+idLuM+7bK3TV0caRMI+vVxtHeyE7mkxMDp+y8oychWQYArs3ntcD4i w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="272464959"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="272464959"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 13:41:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="745385856"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 13:41:32 -0700
Date: Tue, 24 May 2022 13:45:26 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 3/6] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220524134526.409519ac@jacob-builder>
In-Reply-To: <20220524180241.GY1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-4-jacob.jun.pan@linux.intel.com>
 <20220524135135.GV1343366@nvidia.com>
 <20220524091235.6dddfab4@jacob-builder>
 <20220524180241.GY1343366@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
 robin.murphy@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Tue, 24 May 2022 15:02:41 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 24, 2022 at 09:12:35AM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Tue, 24 May 2022 10:51:35 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Wed, May 18, 2022 at 11:21:17AM -0700, Jacob Pan wrote:  
> > > > On VT-d platforms with scalable mode enabled, devices issue DMA
> > > > requests with PASID need to attach PASIDs to given IOMMU domains.
> > > > The attach operation involves the following:
> > > > - Programming the PASID into the device's PASID table
> > > > - Tracking device domain and the PASID relationship
> > > > - Managing IOTLB and device TLB invalidations
> > > > 
> > > > This patch add attach_dev_pasid functions to the default domain ops
> > > > which is used by DMA and identity domain types. It could be
> > > > extended to support other domain types whenever necessary.
> > > > 
> > > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > >  drivers/iommu/intel/iommu.c | 72
> > > > +++++++++++++++++++++++++++++++++++-- 1 file changed, 70
> > > > insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/intel/iommu.c
> > > > b/drivers/iommu/intel/iommu.c index 1c2c92b657c7..75615c105fdf
> > > > 100644 +++ b/drivers/iommu/intel/iommu.c
> > > > @@ -1556,12 +1556,18 @@ static void __iommu_flush_dev_iotlb(struct
> > > > device_domain_info *info, u64 addr, unsigned int mask)
> > > >  {
> > > >  	u16 sid, qdep;
> > > > +	ioasid_t pasid;
> > > >  
> > > >  	if (!info || !info->ats_enabled)
> > > >  		return;
> > > >  
> > > >  	sid = info->bus << 8 | info->devfn;
> > > >  	qdep = info->ats_qdep;
> > > > +	pasid = iommu_get_pasid_from_domain(info->dev,
> > > > &info->domain->domain);    
> > > 
> > > No, a simgple domain can be attached to multiple pasids, all need to
> > > be flushed.
> > >   
> > Here is device TLB flush, why would I want to flush PASIDs other than my
> > own device attached?  
> 
> Again, a domain can be attached to multiple PASID's *on the same
> device*
> 
> The idea that there is only one PASID per domain per device is not
> right.
> 
Got you, I was under the impression that there is no use case yet for
multiple PASIDs per device-domain based on our early discussion.
https://lore.kernel.org/lkml/20220315142216.GV11336@nvidia.com/

Perhaps I misunderstood. I will make the API more future proof and search
through the pasid_array xa for *all* domain-device matches. Like you
suggested earlier, may need to retrieve the xa in the first place and use
xas_for_each to get a faster search.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
