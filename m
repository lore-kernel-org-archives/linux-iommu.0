Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5404FC433E1
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 23:09:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9AB20674
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 23:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9AB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D0FAD204E1;
	Mon, 17 Aug 2020 23:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5SInxUjfBYoO; Mon, 17 Aug 2020 23:09:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4C67520013;
	Mon, 17 Aug 2020 23:09:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3142EC088B;
	Mon, 17 Aug 2020 23:09:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D082C0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 23:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 92E07878C8
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 23:09:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QsYEmwxB-IFX for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 23:09:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C01BF87850
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 23:09:17 +0000 (UTC)
IronPort-SDR: joksTfdqzksRUFpIOuz9cru3egCTuPkkW26ctMzz49UeSAa9DkXWys1QJ/MPZO7os7qsC9bcPL
 5va2zl/7kT8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154778737"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; d="scan'208";a="154778737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 16:09:16 -0700
IronPort-SDR: KMpVnkvl+UhEi/okXHw8bi5AJiqlz6P9Yyoa9lS+QCz9vQJPiIUsxA0v3Anu2ON4wtYgUePGQN
 dBpBZuXqaaFQ==
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; d="scan'208";a="310244195"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 16:09:16 -0700
Date: Mon, 17 Aug 2020 16:16:15 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v7 5/7] iommu/uapi: Rename uapi functions
Message-ID: <20200817161615.35dac072@jacob-builder>
In-Reply-To: <310ebf1c-02d6-b31f-e92e-619d46fa94aa@redhat.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1596068467-49322-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <310ebf1c-02d6-b31f-e92e-619d46fa94aa@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Thu, 13 Aug 2020 10:58:53 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 7/30/20 2:21 AM, Jacob Pan wrote:
> > User APIs such as iommu_sva_unbind_gpasid() may also be used by the
> > kernel. Since we introduced user pointer to the UAPI functions,  
> Practically this is done in the next patch. What about something like:
> 
> We plan to have two flavors of the same API functions, one called
> through ioctls, carrying a user pointer and one called directly with
> valid IOMMU UAPI structs. To differentiate both, let's rename existing
> functions with an iommu_uapi_ prefix.
> 
will do. Thanks!

> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> 
> Thanks
> 
> Eric
> > in-kernel callers cannot share the same APIs. In-kernel callers are
> > also trusted, there is no need to validate the data.
> > 
> > This patch renames all UAPI functions with iommu_uapi_ prefix such
> > that is clear to the intended callers.
> > 
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 18 +++++++++---------
> >  include/linux/iommu.h | 31 ++++++++++++++++---------------
> >  2 files changed, 25 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index b6858adc4f17..3a913ce94a3d 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1950,35 +1950,35 @@ int iommu_attach_device(struct iommu_domain
> > *domain, struct device *dev) }
> >  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >  
> > -int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > device *dev,
> > -			   struct iommu_cache_invalidate_info
> > *inv_info) +int iommu_uapi_cache_invalidate(struct iommu_domain
> > *domain, struct device *dev,
> > +				struct iommu_cache_invalidate_info
> > *inv_info) {
> >  	if (unlikely(!domain->ops->cache_invalidate))
> >  		return -ENODEV;
> >  
> >  	return domain->ops->cache_invalidate(domain, dev,
> > inv_info); }
> > -EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> > +EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
> >  
> > -int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> > -			   struct device *dev, struct
> > iommu_gpasid_bind_data *data) +int
> > iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> > +			       struct device *dev, struct
> > iommu_gpasid_bind_data *data) {
> >  	if (unlikely(!domain->ops->sva_bind_gpasid))
> >  		return -ENODEV;
> >  
> >  	return domain->ops->sva_bind_gpasid(domain, dev, data);
> >  }
> > -EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
> > +EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
> >  
> > -int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > -			     ioasid_t pasid)
> > +int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> > struct device *dev,
> > +				 ioasid_t pasid)
> >  {
> >  	if (unlikely(!domain->ops->sva_unbind_gpasid))
> >  		return -ENODEV;
> >  
> >  	return domain->ops->sva_unbind_gpasid(dev, pasid);
> >  }
> > -EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> > +EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
> >  
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 5f0b7859d2eb..2dcc1a33f6dc 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -430,13 +430,13 @@ extern int iommu_attach_device(struct
> > iommu_domain *domain, struct device *dev);
> >  extern void iommu_detach_device(struct iommu_domain *domain,
> >  				struct device *dev);
> > -extern int iommu_cache_invalidate(struct iommu_domain *domain,
> > -				  struct device *dev,
> > -				  struct
> > iommu_cache_invalidate_info *inv_info); -extern int
> > iommu_sva_bind_gpasid(struct iommu_domain *domain,
> > -		struct device *dev, struct iommu_gpasid_bind_data
> > *data); -extern int iommu_sva_unbind_gpasid(struct iommu_domain
> > *domain,
> > -				struct device *dev, ioasid_t
> > pasid); +extern int iommu_uapi_cache_invalidate(struct iommu_domain
> > *domain,
> > +				       struct device *dev,
> > +				       struct
> > iommu_cache_invalidate_info *inv_info); +extern int
> > iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> > +				      struct device *dev, struct
> > iommu_gpasid_bind_data *data); +extern int
> > iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> > +					struct device *dev,
> > ioasid_t pasid); extern struct iommu_domain
> > *iommu_get_domain_for_dev(struct device *dev); extern struct
> > iommu_domain *iommu_get_dma_domain(struct device *dev); extern int
> > iommu_map(struct iommu_domain *domain, unsigned long iova, @@
> > -1054,21 +1054,22 @@ static inline int iommu_sva_get_pasid(struct
> > iommu_sva *handle) return IOMMU_PASID_INVALID; }
> >  
> > -static inline int
> > -iommu_cache_invalidate(struct iommu_domain *domain,
> > -		       struct device *dev,
> > -		       struct iommu_cache_invalidate_info
> > *inv_info) +static inline int iommu_uapi_cache_invalidate(struct
> > iommu_domain *domain,
> > +					      struct device *dev,
> > +					      struct
> > iommu_cache_invalidate_info *inv_info) {
> >  	return -ENODEV;
> >  }
> > -static inline int iommu_sva_bind_gpasid(struct iommu_domain
> > *domain,
> > -				struct device *dev, struct
> > iommu_gpasid_bind_data *data) +
> > +static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain
> > *domain,
> > +					     struct device *dev,
> > +					     struct
> > iommu_gpasid_bind_data *data) {
> >  	return -ENODEV;
> >  }
> >  
> > -static inline int iommu_sva_unbind_gpasid(struct iommu_domain
> > *domain,
> > -					   struct device *dev, int
> > pasid) +static inline int iommu_uapi_sva_unbind_gpasid(struct
> > iommu_domain *domain,
> > +					       struct device *dev,
> > int pasid) {
> >  	return -ENODEV;
> >  }
> >   
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
