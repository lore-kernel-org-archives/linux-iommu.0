Return-Path: <SRS0=FJ9b=3U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE65C2D0DB
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 17:51:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F57C206F0
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 17:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F57C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 49D61878AE;
	Fri, 31 Jan 2020 17:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rnQeztIavvsH; Fri, 31 Jan 2020 17:51:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F128B878A4;
	Fri, 31 Jan 2020 17:51:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9A0AC0178;
	Fri, 31 Jan 2020 17:51:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0BD8C0171
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 17:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 996AC20449
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 17:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4T1c11FQShrj for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jan 2020 17:51:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 9E9262043C
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 17:51:12 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 09:51:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,386,1574150400"; d="scan'208";a="377409500"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 31 Jan 2020 09:51:06 -0800
Date: Fri, 31 Jan 2020 09:56:21 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200131095621.6acec2fc@jacob-builder>
In-Reply-To: <20200129144046.3f91e4c1@w520.home>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200129144046.3f91e4c1@w520.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Wed, 29 Jan 2020 14:40:46 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 28 Jan 2020 22:02:04 -0800
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > IOMMU UAPI can be extended in the future by adding new
> > fields at the end of each user data structure. Since we use
> > a unified UAPI version for compatibility checking, a lookup
> > function is needed to find the correct user data size to copy
> > from user.
> > 
> > This patch adds a helper function based on a 2D lookup with
> > version and type as input arguments.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
> >  include/linux/iommu.h |  6 ++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 7dd51c5d2ba1..9e5de9abebdf 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1696,6 +1696,28 @@ int iommu_sva_unbind_gpasid(struct
> > iommu_domain *domain, struct device *dev, }
> >  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> >  
> > +
> > +/**
> > + * Maintain a UAPI version to user data structure size lookup for
> > each
> > + * API function types we support. e.g. bind guest pasid, cache
> > invalidation.
> > + * As data structures being extended with new members, the
> > offsetofend()
> > + * will identify the new sizes.
> > + */
> > +const static int
> > iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
> > +	/* IOMMU_UAPI_BIND_GPASID */
> > +	{offsetofend(struct iommu_gpasid_bind_data, vtd)},
> > +	/* IOMMU_UAPI_CACHE_INVAL */
> > +	{offsetofend(struct iommu_cache_invalidate_info,
> > addr_info)},
> > +	/* IOMMU_UAPI_PAGE_RESP */
> > +	{offsetofend(struct iommu_page_response, code)},
> > +};
> > +
> > +int iommu_uapi_get_data_size(int type, int version)
> > +{  
> 
> Seems like this is asking for a bounds check,
> 
>   if (type >= NR_IOMMU_UAPI_TYPE || version > IOMMU_UAPI_VERSION)
>   	return -EINVAL;
> 
yes, agreed.
> If we add new types in future versions, I assume we'd back fill the
> table with -EINVAL as well (rather than zero).  Thanks,
> 
right, if the array increase due to new types, the older version with
the new type should be filled with -EINVAL.
Let me document this in the rules of extensions.

> Alex
> 
> > +	return iommu_uapi_data_size[type][version - 1];
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_uapi_get_data_size);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 9718c109ea0a..416fe02160ba 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -500,6 +500,7 @@ extern int iommu_report_device_fault(struct
> > device *dev, struct iommu_fault_event *evt);
> >  extern int iommu_page_response(struct device *dev,
> >  			       struct iommu_page_response *msg);
> > +extern int iommu_uapi_get_data_size(int type, int version);
> >  
> >  extern int iommu_group_id(struct iommu_group *group);
> >  extern struct iommu_group *iommu_group_get_for_dev(struct device
> > *dev); @@ -885,6 +886,11 @@ static inline int
> > iommu_page_response(struct device *dev, return -ENODEV;
> >  }
> >  
> > +static int iommu_uapi_get_data_size(int type, int version)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> >  static inline int iommu_group_id(struct iommu_group *group)
> >  {
> >  	return -ENODEV;  
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
