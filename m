Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697B8C433FE
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 00:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3BA540569;
	Wed, 11 May 2022 00:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0xzJLQLIqUgu; Wed, 11 May 2022 00:19:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C9858400CB;
	Wed, 11 May 2022 00:19:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D669C0032;
	Wed, 11 May 2022 00:19:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AEA7C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 00:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5518E8139D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 00:19:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PUc-qPqri1zh for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 00:19:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 657BF81393
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652228366; x=1683764366;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LNZ2ZyGFyAlorvMsKBypZZXVIJmC3rzFpuJmCI9ge4U=;
 b=UtnQKdZtCwQyjlRI0chzgeGdekgqUJ134XiXEgEDZ+SDDTd5COtBYXUH
 a7l1MJpJ13geafW5xrRKodjPbMkKbCYqIgD+02cPnM3VQxtWLUYrIoBUJ
 qPVh7NNeVCairCGzckRFzYNvbyvIC/PNrPvM2M/YzYaB2h4kpumQQ+RJC
 JDjYETBT2pdAoZidzIrr/ybD3pXwjcW4mnFsjC/uO0jhoZbJuvqcakh+k
 esK8bNkNxYyX/zmYGYgy5J7WKjHt+tR29NEOd9yrutfo0VZoKa8w2xz1n
 sXKsvUVYdYp8lR7bf7CDI8JAi0P6uey7LBHlyFYBCDs2PEaIetqDfFNF4 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269675102"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="269675102"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 17:19:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="738965315"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 17:19:23 -0700
Date: Tue, 10 May 2022 17:23:09 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220510172309.3c4e7512@jacob-builder>
In-Reply-To: <20220510232121.GP49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
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

On Tue, 10 May 2022 20:21:21 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 10, 2022 at 02:07:01PM -0700, Jacob Pan wrote:
> > +static int intel_iommu_attach_dev_pasid(struct iommu_domain *domain,
> > +					struct device *dev,
> > +					ioasid_t pasid)
> > +{
> > +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct intel_iommu *iommu = info->iommu;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	if (!sm_supported(iommu) || !info)
> > +		return -ENODEV;
> > +
> > +	spin_lock_irqsave(&device_domain_lock, flags);
> > +	/*
> > +	 * If the same device already has a PASID attached, just
> > return.
> > +	 * DMA layer will return the PASID value to the caller.
> > +	 */
> > +	if (pasid != PASID_RID2PASID && info->pasid) {  
> 
> Why check for PASID == 0 like this? Shouldn't pasid == 0 be rejected
> as an invalid argument?
Right, I was planning on reuse the attach function for RIDPASID as clean
up, but didn't include here. Will fix.

> 
> > +		if (info->pasid == pasid)
> > +			ret = 0;  
> 
> Doesn't this need to check that the current domain is the requested
> domain as well? How can this happen anyhow - isn't it an error to
> double attach?
> 
> > diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> > index 5af24befc9f1..55845a8c4f4d 100644
> > +++ b/include/linux/intel-iommu.h
> > @@ -627,6 +627,7 @@ struct device_domain_info {
> >  	struct intel_iommu *iommu; /* IOMMU used by this device */
> >  	struct dmar_domain *domain; /* pointer to domain */
> >  	struct pasid_table *pasid_table; /* pasid table */
> > +	ioasid_t pasid; /* DMA request with PASID */  
> 
> And this seems wrong - the DMA API is not the only user of
> attach_dev_pasid, so there should not be any global pasid for the
> device.
> 
True but the attach_dev_pasid() op is domain type specific. i.e. DMA API
has its own attach_dev_pasid which is different than sva domain
attach_dev_pasid().
device_domain_info is only used by DMA API.

> I suspect this should be a counter of # of pasid domains attached so
> that the special flush logic triggers
> 
This field is only used for devTLB, so it is per domain-device. struct
device_domain_info is allocated per device-domain as well. Sorry, I might
have totally missed your point.

> And rely on the core code to worry about assigning only one domain per
> pasid - this should really be a 'set' function.
> 
Yes, in this set the core code (in dma-iommu.c) only assign one PASID per
DMA domain type.

Are you suggesting the dma-iommu API should be called
iommu_set_dma_pasid instead of iommu_attach_dma_pasid?

Thanks a lot for the quick review!

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
