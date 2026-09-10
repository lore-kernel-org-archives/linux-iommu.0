Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BDB475351
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041130; cv=none; b=P233rZkAjJDaqIpNLUj3RDYN/evDek26JoIHsiue2r3s11RPVrevJ2o1InWEhNSEQT/eJxyW8qooeaA15DaOzBzXmLP/EMdpKc+J6tfkiepnEiVRvpXPUSzLkCbYWrZb5LMgrV8J0xjWe+K+aGCaUgaz5GlBtaMlqrxXFHtYvzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041130; c=relaxed/simple;
	bh=Q9julwOQzBR1EJnwQ28WKTDz9PwswwjgvrS3eTynrs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRs1YpCX1I8G82UiNBIk/ORHk2Ocvpsf6FhIVQp3yYswYPC7R4XcGkWOAfVkJWQm2ea5o7XQ1nzRHF2OXJhJh+EzCr6T4DMWfgMVxGb5JRKJjrIFcbrpZAto6XKTnNQj+M+qEJKxJCwjTVzL5pQcIgtsmskuDxhzNuyfrLQ0bxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=hwKUhWwF; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="hwKUhWwF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789041129; x=1820577129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vv0W15mpHMHqH9IS+b3qKstevX72H67WWMVy9YA0mMU=;
  b=hwKUhWwF7DJmLFNmwCqwb0ulS41UPHbGJbAiKeBkKf3fj0lQNuw8Jsmk
   YOl4rSFELkxb8QkMNYQLGnRzYFKDR0r1Pg8NDL1doRh/1UHwNZl4iJeRt
   KcWKWQ26KrCVJ6buVeKqk87gDtw/YZHijJNax92bPAGScbcMg/uMlffpV
   PGT9bUVrosFt2mlAJv30e3f5RdpJxD9/7vp5xh/1Jk9aQmKadcWpHxY6n
   Lx/FX2qMIiyshNIcLNnrsB3WC1Hyt20XPBNuqR4qqMVC99Ias2qSV9S+W
   IQYh7RctMtY6hFHi0y0qmfH87H40mqd5vE9wn3JSbuBvKFUewHbwR6wwb
   A==;
X-CSE-ConnectionGUID: s0n4v6FARaeDkyw+fEh6Qg==
X-CSE-MsgGUID: tnNjOA1WRJG+2AeJAoqU0Q==
X-IronPort-AV: E=Sophos;i="6.27,95,1787011200"; 
   d="scan'208";a="27819800"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 11:52:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:13550]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.159:2525] with esmtp (Farcaster)
 id 2bbfd2cc-48d2-422d-a687-563dd3edbeb0; Thu, 10 Sep 2026 11:52:06 +0000 (UTC)
X-Farcaster-Flow-ID: 2bbfd2cc-48d2-422d-a687-563dd3edbeb0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 10 Sep 2026 11:52:05 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Thu, 10 Sep 2026
 11:52:04 +0000
From: Federico Parola <fparola@amazon.de>
To: <robin.murphy@arm.com>
CC: <fparola@amazon.de>, <iommu@lists.linux.dev>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
	<will@kernel.org>
Subject: Re: [PATCH] iommu/dma: Finalize deferred attachments when mapping MSI pages
Date: Thu, 10 Sep 2026 11:51:43 +0000
Message-ID: <20260910115152.54108-1-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <52fc7110-2079-4090-8b32-2c913db0f298@arm.com>
References: <52fc7110-2079-4090-8b32-2c913db0f298@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, 8 Sep 2026 18:15:10 +0100 Robin Murphy <robin.murphy@arm.com> wrote:
> On 08/09/2026 5:01 pm, Federico Parola wrote:
> > When a device's attachment to its default domain is deferred, the IOMMU
> > is still translating the device with the tables inherited from the
> > previous kernel. Any mapping installed in that domain does not take
> > effect until the deferred attachment is finalized.
> > iommu_deferred_attach() covers the DMA mapping paths, but nothing covers
> > iommu_dma_sw_msi(): programming an MSI installs the MSI page in
> > group->domain and hands the resulting IOVA to the irqchip, so an MSI
> > programmed before the first DMA map is written using an IOVA that the
> > hardware does not yet translate.
> > 
> > This issue is currently not triggerable as the two IOMMU implementations
> > supporting deferred attachments, Intel and AMD, do not rely on DMA
> > translations for MSI transactions. However, the Arm implementation being
> > introduced in [1] will be subject to it.
> > 
> > Finalize the deferred attachment from iommu_dma_sw_msi() too, right
> > before the MSI page is mapped. iommu_dma_prepare_msi() already holds
> > group->mutex across the call, so factor the locked part of
> > iommu_deferred_attach() out into __iommu_deferred_attach() and call that
> > instead of taking the mutex recursively. The static branch on
> > iommu_deferred_attach_enabled can be omitted as MSI page allocation is
> > not on a fast path.
> 
> So why not just invoke iommu_deferred_attach() from 
> iommu_dma_prepare_msi() itself, before taking the mutex at all, and save 
> all the other churn? The two operations might happen to serialise on the 
> same lock for their own different reasons, but they still have no need 
> to be atomic relative to each other. If it's not a fast path in general 
> then there should equally be little reason to worry about also checking 
> in the cases which might not dispatch to iommu_dma_sw_msi().
> 
> Thanks,
> Robin.

Absolutely. In my first iteration I was retaining the static branch which better
fitted dma-iommu. Without it there's no reason not to move the check.
I'll submit a new revision.

Thanks,
Federico

> > The behaviour of a rejected attach changes slightly: an attach refused
> > because the device is being reset (-EBUSY) now fails MSI setup rather
> > than only the first DMA map.
> > 
> > Link: https://lore.kernel.org/linux-iommu/cover.1788130528.git.nicolinc@nvidia.com/ [1]
> > Signed-off-by: Federico Parola <fparola@amazon.de>
> > ---
> >   drivers/iommu/dma-iommu.c  |  7 +++++++
> >   drivers/iommu/iommu-priv.h |  2 ++
> >   drivers/iommu/iommu.c      | 25 ++++++++++++++++++-------
> >   3 files changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 58c624513cd4..fa7de1b3d538 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -37,6 +37,7 @@
> >   
> >   #include "dma-iommu.h"
> >   #include "iommu-pages.h"
> > +#include "iommu-priv.h"
> >   
> >   struct iommu_dma_msi_page {
> >   	struct list_head	list;
> > @@ -2247,6 +2248,7 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> >   {
> >   	struct device *dev = msi_desc_to_dev(desc);
> >   	const struct iommu_dma_msi_page *msi_page;
> > +	int ret;
> >   
> >   	if (!has_msi_cookie(domain)) {
> >   		msi_desc_set_iommu_msi_iova(desc, 0, 0);
> > @@ -2254,6 +2256,11 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> >   	}
> >   
> >   	iommu_group_mutex_assert(dev);
> > +
> > +	ret = __iommu_deferred_attach(dev, domain);
> > +	if (ret)
> > +		return ret;
> > +
> >   	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
> >   	if (!msi_page)
> >   		return -ENOMEM;
> > diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> > index aaffad5854fc..ba72f9a03b0b 100644
> > --- a/drivers/iommu/iommu-priv.h
> > +++ b/drivers/iommu/iommu-priv.h
> > @@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
> >   
> >   void dev_iommu_free(struct device *dev);
> >   
> > +int __iommu_deferred_attach(struct device *dev, struct iommu_domain *domain);
> > +
> >   const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
> >   
> >   static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index cd1bca7ede9a..d7d70689c784 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2214,19 +2214,15 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
> >   }
> >   EXPORT_SYMBOL_GPL(iommu_attach_device);
> >   
> > -int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
> > +/* Caller must hold dev->iommu_group->mutex */
> > +int __iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
> >   {
> >   	struct group_device *gdev;
> >   
> > -	/*
> > -	 * This is called on the dma mapping fast path so avoid locking. This is
> > -	 * racy, but we have an expectation that the driver will setup its DMAs
> > -	 * inside probe while being single threaded to avoid racing.
> > -	 */
> >   	if (!dev->iommu || !dev->iommu->attach_deferred)
> >   		return 0;
> >   
> > -	guard(mutex)(&dev->iommu_group->mutex);
> > +	lockdep_assert_held(&dev->iommu_group->mutex);
> >   
> >   	gdev = __dev_to_gdev(dev);
> >   	if (WARN_ON(!gdev))
> > @@ -2244,6 +2240,21 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
> >   	return __iommu_attach_device(domain, dev, NULL);
> >   }
> >   
> > +int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
> > +{
> > +	/*
> > +	 * This is called on the dma mapping fast path so avoid locking. This is
> > +	 * racy, but we have an expectation that the driver will setup its DMAs
> > +	 * inside probe while being single threaded to avoid racing.
> > +	 */
> > +	if (!dev->iommu || !dev->iommu->attach_deferred)
> > +		return 0;
> > +
> > +	guard(mutex)(&dev->iommu_group->mutex);
> > +
> > +	return __iommu_deferred_attach(dev, domain);
> > +}
> > +
> >   void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
> >   {
> >   	/* Caller must be a probed driver on dev */
> 
> 
