Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CDFC433EF
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 16:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49C8161227;
	Tue, 24 May 2022 16:08:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O1fNwLMcycdJ; Tue, 24 May 2022 16:08:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2D2D660F3B;
	Tue, 24 May 2022 16:08:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0197DC0032;
	Tue, 24 May 2022 16:08:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B180C002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 16:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48A134146F
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 16:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OEeYYbK9XM1W for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 16:08:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC2F1410B5
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653408522; x=1684944522;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5Gcuxx4a6dpgfqmvk6ReqxoKJmrbkWXrK0zygSxYLWc=;
 b=DssTE33FcP57A1PJL1r25JbNoV8n8+tbQGqAPvkfTS4JyEfRRTStJye7
 oPgMMoKqn7VvE5f0j4o/TeD2JoXK/G1Dolx/KRYH/h3Mxf5pDsj/x3AtO
 bqTIcA/hlCjsndaAyqbKjDnCQ5NmYrqRJUhKoFydCoXW2VOJwvVjQJePK
 l2DocEXRikFyGjdxZJACZcenc8A//8N49laD6n2BnHcMmdGGSUAbm2Kec
 PpQlDRFhVlFtWMD/tMQg0jDS79ghP4eQrXTOuME9+Jd6xFvwt6CdfOvPM
 ou9xmGxdW6qAYXplQWmu3JQFCrOj1rEXKHuhwUxL0mlBwZ5c/5IEVLWbs g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273299579"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; d="scan'208";a="273299579"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 09:08:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; d="scan'208";a="703531762"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 09:08:42 -0700
Date: Tue, 24 May 2022 09:12:35 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 3/6] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220524091235.6dddfab4@jacob-builder>
In-Reply-To: <20220524135135.GV1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-4-jacob.jun.pan@linux.intel.com>
 <20220524135135.GV1343366@nvidia.com>
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

On Tue, 24 May 2022 10:51:35 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 18, 2022 at 11:21:17AM -0700, Jacob Pan wrote:
> > On VT-d platforms with scalable mode enabled, devices issue DMA requests
> > with PASID need to attach PASIDs to given IOMMU domains. The attach
> > operation involves the following:
> > - Programming the PASID into the device's PASID table
> > - Tracking device domain and the PASID relationship
> > - Managing IOTLB and device TLB invalidations
> > 
> > This patch add attach_dev_pasid functions to the default domain ops
> > which is used by DMA and identity domain types. It could be extended to
> > support other domain types whenever necessary.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >  drivers/iommu/intel/iommu.c | 72 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 70 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 1c2c92b657c7..75615c105fdf 100644
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1556,12 +1556,18 @@ static void __iommu_flush_dev_iotlb(struct
> > device_domain_info *info, u64 addr, unsigned int mask)
> >  {
> >  	u16 sid, qdep;
> > +	ioasid_t pasid;
> >  
> >  	if (!info || !info->ats_enabled)
> >  		return;
> >  
> >  	sid = info->bus << 8 | info->devfn;
> >  	qdep = info->ats_qdep;
> > +	pasid = iommu_get_pasid_from_domain(info->dev,
> > &info->domain->domain);  
> 
> No, a simgple domain can be attached to multiple pasids, all need to
> be flushed.
> 
Here is device TLB flush, why would I want to flush PASIDs other than my
own device attached?

At one level up, we do have a list of device to be flushed.
	list_for_each_entry(info, &domain->devices, link)
		__iommu_flush_dev_iotlb(info, addr, mask);

	
Note that RID2PASID is not in the pasid_array, its DEVTLB flush also needs
special handling in that the device is doing DMA w/o PASID, thus not aware
of RID2PASID.


> This whole API isn't suitable.
> 
> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
