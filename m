Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF777C433E1
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 23:52:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839E32075F
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 23:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839E32075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4487488DB2;
	Thu, 11 Jun 2020 23:52:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H1N5yAbQnt9a; Thu, 11 Jun 2020 23:52:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 194C388D81;
	Thu, 11 Jun 2020 23:52:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F38CCC0865;
	Thu, 11 Jun 2020 23:52:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 086C9C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 23:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EFFE08855D
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 23:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W2KEv+cxE4nH for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 23:52:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F3EB588504
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 23:52:10 +0000 (UTC)
IronPort-SDR: X9X91j9eCTXxL8aMnPH8jcQJHj3s0ifIOfdCUjCi0WXD6M/T3jkNtgUZ2kxtljDFbW02VVTlEx
 /mfXcF0cVeaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 16:52:10 -0700
IronPort-SDR: lFwOGuCA1SjpA7hLnPmN6CUzDgtav7nUF446DywvYOdRRzIqqIM+xsbEgs2dN2ZJ4wLnrvqjxa
 GfjOv0wRtb1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; d="scan'208";a="289709909"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002.jf.intel.com with ESMTP; 11 Jun 2020 16:52:10 -0700
Date: Thu, 11 Jun 2020 16:58:35 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 3/3] iommu/vt-d: Sanity check uapi argsz filled by users
Message-ID: <20200611165835.4de03911@jacob-builder>
In-Reply-To: <20200611145518.0c2817d6@x1.home>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1591848735-12447-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200611110816.4cea7204@x1.home>
 <20200611130224.642ddde4@jacob-builder>
 <20200611145518.0c2817d6@x1.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

On Thu, 11 Jun 2020 14:55:18 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 11 Jun 2020 13:02:24 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > On Thu, 11 Jun 2020 11:08:16 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > On Wed, 10 Jun 2020 21:12:15 -0700
> > > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> > >     
> > > > IOMMU UAPI data has an argsz field which is filled by user. As
> > > > the data structures expands, argsz may change. As the UAPI data
> > > > are shared among different architectures, extensions of UAPI
> > > > data could be a result of one architecture which has no impact
> > > > on another. Therefore, these argsz santity checks are performed
> > > > in the model specific IOMMU drivers. This patch adds sanity
> > > > checks in the VT-d to ensure argsz passed by userspace matches
> > > > feature flags and other contents.
> > > > 
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > ---
> > > >  drivers/iommu/intel-iommu.c | 16 ++++++++++++++++
> > > >  drivers/iommu/intel-svm.c   | 12 ++++++++++++
> > > >  2 files changed, 28 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/intel-iommu.c
> > > > b/drivers/iommu/intel-iommu.c index 27ebf4b9faef..c98b5109684b
> > > > 100644 --- a/drivers/iommu/intel-iommu.c
> > > > +++ b/drivers/iommu/intel-iommu.c
> > > > @@ -5365,6 +5365,7 @@ intel_iommu_sva_invalidate(struct
> > > > iommu_domain *domain, struct device *dev, struct
> > > > device_domain_info *info; struct intel_iommu *iommu;
> > > >  	unsigned long flags;
> > > > +	unsigned long minsz;
> > > >  	int cache_type;
> > > >  	u8 bus, devfn;
> > > >  	u16 did, sid;
> > > > @@ -5385,6 +5386,21 @@ intel_iommu_sva_invalidate(struct
> > > > iommu_domain *domain, struct device *dev, if
> > > > (!(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE)) return
> > > > -EINVAL; 
> > > > +	minsz = offsetofend(struct iommu_cache_invalidate_info,
> > > > padding);      
> > > 
> > > Would it still be better to look for the end of the last field
> > > that's actually used to avoid the code churn and oversights
> > > if/when the padding field does get used and renamed?
> > >     
> > My thought was that if the padding gets partially re-purposed, the
> > remaining padding would still be valid for minsz check. The
> > extension rule ensures that there is no size change other the
> > variable size union at the end. So use padding would avoid the
> > churn, or i am totally wrong?  
> 
> No, it's trying to predict the future either way.  I figured checking
> minsz against the fields we actually consume allows complete use of
> the padding fields and provides a little leniency to the user.  We'd
> need to be careful though that if those fields are later used by this
> driver, the code would still need to accept the smaller size.  If the
> union was named rather than anonymous we could just use offsetof() to
> avoid directly referencing the padding fields.
>  
I will change it to named union.

Thanks,

> > > Per my comment on patch 1/, this also seems like where the device
> > > specific IOMMU driver should also have the responsibility of
> > > receiving a __user pointer to do the copy_from_user() here.  vfio
> > > can't know which flags require which fields to make a UAPI with
> > > acceptable compatibility guarantees otherwise.
> > >     
> > Right, VFIO cannot do compatibility guarantees, it is just seem to
> > be that VFIO has enough information to copy_from_user sanely &
> > safely and handle over to IOMMU. Please help define the
> > roles/responsibilities in my other email. Then I will follow the
> > guideline.  
> 
> We can keep that part of the discussion in the other thread.  Thanks,
> 
> Alex
> 
> > > > +	if (inv_info->argsz < minsz)
> > > > +		return -EINVAL;
> > > > +
> > > > +	/* Sanity check user filled invalidation dat sizes */
> > > > +	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> > > > +		inv_info->argsz != offsetofend(struct
> > > > iommu_cache_invalidate_info,
> > > > +					addr_info))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
> > > > +		inv_info->argsz != offsetofend(struct
> > > > iommu_cache_invalidate_info,
> > > > +					pasid_info))
> > > > +		return -EINVAL;
> > > > +
> > > >  	spin_lock_irqsave(&device_domain_lock, flags);
> > > >  	spin_lock(&iommu->lock);
> > > >  	info = get_domain_info(dev);
> > > > diff --git a/drivers/iommu/intel-svm.c
> > > > b/drivers/iommu/intel-svm.c index 35b43fe819ed..64dc2c66dfff
> > > > 100644 --- a/drivers/iommu/intel-svm.c
> > > > +++ b/drivers/iommu/intel-svm.c
> > > > @@ -235,15 +235,27 @@ int intel_svm_bind_gpasid(struct
> > > > iommu_domain *domain, struct device *dev, struct dmar_domain
> > > > *dmar_domain; struct intel_svm_dev *sdev;
> > > >  	struct intel_svm *svm;
> > > > +	unsigned long minsz;
> > > >  	int ret = 0;
> > > >  
> > > >  	if (WARN_ON(!iommu) || !data)
> > > >  		return -EINVAL;
> > > >  
> > > > +	/*
> > > > +	 * We mandate that no size change in IOMMU UAPI data
> > > > before the
> > > > +	 * variable size union at the end.
> > > > +	 */
> > > > +	minsz = offsetofend(struct iommu_gpasid_bind_data,
> > > > padding);      
> > > 
> > > Same.  Thanks,
> > > 
> > > Alex
> > >     
> > > > +	if (data->argsz < minsz)
> > > > +		return -EINVAL;
> > > > +
> > > >  	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> > > >  	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> > > >  		return -EINVAL;
> > > >  
> > > > +	if (data->argsz != offsetofend(struct
> > > > iommu_gpasid_bind_data, vtd))
> > > > +		return -EINVAL;
> > > > +
> > > >  	if (!dev_is_pci(dev))
> > > >  		return -ENOTSUPP;
> > > >        
> > >     
> > 
> > [Jacob Pan]
> >   
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
