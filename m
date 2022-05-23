Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDA9C433F5
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 17:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D9D240A1D;
	Mon, 23 May 2022 17:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UMXo8IOJvnSS; Mon, 23 May 2022 17:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0F5DB40332;
	Mon, 23 May 2022 17:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E627CC0032;
	Mon, 23 May 2022 17:58:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A08CC002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 17:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 755BB81D02
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 17:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q_psNQ8LZeww for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 17:58:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 382018149B
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 17:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653328692; x=1684864692;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=See9p7fez/HBRV0YvEYQHd38Yl91KOYmJwyLfKNrjK8=;
 b=S93JD/JT48mE/dIcA+kNc9dTvsEKY92RnRvsPeybgYtZb0IziNMP2gpo
 79cIWOdQhW0ggLzsGVCJuKt0FKU9+sbg7A4a8vQyTP2kJGhNwd99tL2BS
 hYSDtenFNJ7MCWWDeYweiKXyO5lcV8UOaN/qNlc8e6qEMYnUVEUSPIpO2
 wvfu89nzZI0OpL/Ku4T01PM/Gso54ie0FF4AM9ANISrrLpRZyiy4pjAfq
 ppPCs0ws/96Qr3NGAxucEdsJNvBBraos5kF21yfHx+Xh5QflmIn6ciUqb
 AymvoA/9gLvoJIqCG4xBIddd6scuNvyKtIiDlOppSZHUrahKYU0Z/lHu9 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273030817"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; d="scan'208";a="273030817"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 10:58:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; d="scan'208";a="744857037"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 10:58:05 -0700
Date: Mon, 23 May 2022 11:01:58 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Message-ID: <20220523110158.3382b5fd@jacob-builder>
In-Reply-To: <BN9PR11MB5276622272BCA2ED982EE3C18CD49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276622272BCA2ED982EE3C18CD49@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "will@kernel.org" <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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

On Mon, 23 May 2022 09:14:04 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Tian, Kevin
> > Sent: Monday, May 23, 2022 3:55 PM
> >   
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> > > iommu_domain *domain)
> > > +{
> > > +	struct iommu_domain *tdomain;
> > > +	struct iommu_group *group;
> > > +	unsigned long index;
> > > +	ioasid_t pasid = INVALID_IOASID;
> > > +
> > > +	group = iommu_group_get(dev);
> > > +	if (!group)
> > > +		return pasid;
> > > +
> > > +	xa_for_each(&group->pasid_array, index, tdomain) {
> > > +		if (domain == tdomain) {
> > > +			pasid = index;
> > > +			break;
> > > +		}
> > > +	}  
> > 
> > Don't we need to acquire the group lock here?
> > 
pasid_array is under RCU read lock so it is protected though may have stale
data. It also used in atomic context for TLB flush, cannot take the
group mutex. If the caller does detach_dev_pasid while doing TLB flush, it
could result in extra flush but harmless.

> > Btw the intention of this function is a bit confusing. Patch01 already
> > stores the pasid under domain hence it's redundant to get it
> > indirectly from xarray index. You could simply introduce a flag bit
> > (e.g. dma_pasid_enabled) in device_domain_info and then directly
> > use domain->dma_pasid once the flag is true.
> >   
> 
> Just saw your discussion with Jason about v3. While it makes sense
> to not specialize DMA domain in iommu driver, the use of this function
> should only be that when the call chain doesn't pass down a pasid
> value e.g. when doing cache invalidation for domain map/unmap. If
> the upper interface already carries a pasid e.g. in detach_dev_pasid()
> iommu driver can simply verify that the corresponding pasid xarray 
> entry points to the specified domain instead of using this function to
> loop xarray and then verify the returned pasid (as done in patch03/04).
Excellent point, I could just use xa_load(pasid) to compare the domain
instead of loop through xa.
I will add another helper.

bool iommu_is_pasid_domain_attached(struct device *dev, struct iommu_domain *domain, ioasid_t pasid)
{
	struct iommu_group *group;
	bool ret = false;

	group = iommu_group_get(dev);
	if (WARN_ON(!group))
		return false;

	if (domain == xa_load(&group->pasid_array, pasid))
		ret = true;

	iommu_group_put(group);

	return ret;
}

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
