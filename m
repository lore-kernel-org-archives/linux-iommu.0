Return-Path: <SRS0=FJ9b=3U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DA6C2D0DB
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 19:46:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374BB20707
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 19:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374BB20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F39B787832;
	Fri, 31 Jan 2020 19:45:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7zUWiA70gtA; Fri, 31 Jan 2020 19:45:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8311A86C80;
	Fri, 31 Jan 2020 19:45:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77A04C0178;
	Fri, 31 Jan 2020 19:45:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38EA9C0171
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 19:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1EC40883DC
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 19:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n9N9P0eJmI34 for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jan 2020 19:45:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 314CB88377
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 19:45:55 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 11:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,386,1574150400"; d="scan'208";a="218708109"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 31 Jan 2020 11:45:55 -0800
Date: Fri, 31 Jan 2020 11:51:10 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200131115110.1de98286@jacob-builder>
In-Reply-To: <20200129151951.2e354e37@w520.home>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200129144046.3f91e4c1@w520.home>
 <20200129151951.2e354e37@w520.home>
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

On Wed, 29 Jan 2020 15:19:51 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 29 Jan 2020 14:40:46 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Tue, 28 Jan 2020 22:02:04 -0800
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > IOMMU UAPI can be extended in the future by adding new
> > > fields at the end of each user data structure. Since we use
> > > a unified UAPI version for compatibility checking, a lookup
> > > function is needed to find the correct user data size to copy
> > > from user.
> > > 
> > > This patch adds a helper function based on a 2D lookup with
> > > version and type as input arguments.
> > > 
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
> > >  include/linux/iommu.h |  6 ++++++
> > >  2 files changed, 28 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 7dd51c5d2ba1..9e5de9abebdf 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -1696,6 +1696,28 @@ int iommu_sva_unbind_gpasid(struct
> > > iommu_domain *domain, struct device *dev, }
> > >  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> > >  
> > > +
> > > +/**
> > > + * Maintain a UAPI version to user data structure size lookup
> > > for each
> > > + * API function types we support. e.g. bind guest pasid, cache
> > > invalidation.
> > > + * As data structures being extended with new members, the
> > > offsetofend()
> > > + * will identify the new sizes.
> > > + */
> > > +const static int
> > > iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
> > > +	/* IOMMU_UAPI_BIND_GPASID */
> > > +	{offsetofend(struct iommu_gpasid_bind_data, vtd)},
> > > +	/* IOMMU_UAPI_CACHE_INVAL */
> > > +	{offsetofend(struct iommu_cache_invalidate_info,
> > > addr_info)},  
> 
> This seems prone to errors in future revisions.  Both of the above
> reference the end of fields within an anonymous union.  When a new
> field is added, it's not necessarily the newest field that needs to be
> listed here, but the largest at the time.
> So should the current
> version always use sizeof instead (or name the union so we can
> reference it)?  I'm not sure of an error proof way to make sure we
> keep the N-1 version consistent when we add a new version though.
> More comments?
> 
yes. we must be very careful the new size has to be the largest of the
union not the newest. I agree that using sizeof() would make current
version size straightforward. But we have to find the size for N-1
with offsetofend, seems more risk to the existing N-1 code when bump up
version.

I was thinking this array also serve as documentation of the revision
history, but as you pointed out offsetofend may not be the newest
member of the union. So it cannot document which member was added in
which version. Seems more comments is the only way.

How about comments as below with example future extensions?

/**
 * Maintain a UAPI version to user data structure size lookup for each
 * API function types we support. e.g. bind guest pasid, cache invalidation.
 * As data structures being extended with new members, offsetofend() is
 * used to identify the size. In case of adding a new member to a union,
 * offsetofend() applies to the largest member which may not be the newest.
 *
 * When new types are introduced with new versions, the new types for older
 * version must be filled with -EINVAL.
 *
 * The table below documents UAPI revision history with the name of the
 * newest member of each data structure. The largest member of a union was
 * used for the initial version of each type.
 *
 * Current version: V1
 * +--------------+---------------+
 * | Type /       |       V1      |
 * | UAPI Version |               |
 * +==============+===============+
 * | BIND_GPASID  |       vtd     |
 * +--------------+---------------+
 * | CACHE_INVAL  |  addr_info    |
 * +--------------+---------------+
 * | PAGE_RESP    |  code         |
 * +--------------+---------------+
 *
 * Future extension examples:
 *
 * V2 adds new members to bind_gpasid and cache_invalidate API but not
 * page response.
 * +--------------+---------------+---------------+
 * | Type /       |       V1      |      V2       |
 * | UAPI Version |               |               |
 * +==============+===============+===============+
 * | BIND_GPASID  |       vtd     |      smmu_v3  |
 * +--------------+---------------+---------------+
 * | CACHE_INVAL  |  addr_info    |     new_info  |
 * +--------------+---------------+---------------+
 * | PAGE_RESP    |  code         |     N/A       |
 * +--------------+---------------+---------------+
 *
 * V3 introduces a new UAPI data type: NEW_TYPE but with no new members
 * added to the existing types.
 * +--------------+---------------+---------------+---------------+
 * | Type /       |       V1      |      V2       |      V3       |
 * | UAPI Version |               |               |               |
 * +==============+===============+===============+===============+
 * | BIND_GPASID  |       vtd     |      smmu_v3  |       N/A     |
 * +--------------+---------------+---------------+---------------+
 * | CACHE_INVAL  |  addr_info    |    new_info   |       N/A     |
 * +--------------+---------------+---------------+---------------+
 * | PAGE_RESP    |  code         |    N/A        |       N/A     |
 * +--------------+---------------+---------------+---------------+
 * | NEW_TYPE     |  -EINVAL      |     -EINVAL   | largest_member|
 * +--------------+---------------+---------------+---------------+
 *

> Also, is the 12-bytes of padding in struct iommu_gpasid_bind_data
> excessive with this new versioning scheme?  Per rule #2 I'm not sure
> if we're allowed to repurpose those padding bytes, but if we add
> fields to the end of the structure as the scheme suggests, we're
> stuck with not being able to expand the union for new fields.
> 
> Thanks,
> Alex
> 
> > > +	/* IOMMU_UAPI_PAGE_RESP */
> > > +	{offsetofend(struct iommu_page_response, code)},
> > > +};
> > > +
> > > +int iommu_uapi_get_data_size(int type, int version)
> > > +{    
> > 
> > Seems like this is asking for a bounds check,
> > 
> >   if (type >= NR_IOMMU_UAPI_TYPE || version > IOMMU_UAPI_VERSION)
> >   	return -EINVAL;
> > 
> > If we add new types in future versions, I assume we'd back fill the
> > table with -EINVAL as well (rather than zero).  Thanks,
> > 
> > Alex
> >   
> > > +	return iommu_uapi_data_size[type][version - 1];
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_uapi_get_data_size);
> > > +
> > >  static void __iommu_detach_device(struct iommu_domain *domain,
> > >  				  struct device *dev)
> > >  {
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index 9718c109ea0a..416fe02160ba 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -500,6 +500,7 @@ extern int iommu_report_device_fault(struct
> > > device *dev, struct iommu_fault_event *evt);
> > >  extern int iommu_page_response(struct device *dev,
> > >  			       struct iommu_page_response *msg);
> > > +extern int iommu_uapi_get_data_size(int type, int version);
> > >  
> > >  extern int iommu_group_id(struct iommu_group *group);
> > >  extern struct iommu_group *iommu_group_get_for_dev(struct device
> > > *dev); @@ -885,6 +886,11 @@ static inline int
> > > iommu_page_response(struct device *dev, return -ENODEV;
> > >  }
> > >  
> > > +static int iommu_uapi_get_data_size(int type, int version)
> > > +{
> > > +	return -ENODEV;
> > > +}
> > > +
> > >  static inline int iommu_group_id(struct iommu_group *group)
> > >  {
> > >  	return -ENODEV;    
> >   
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
