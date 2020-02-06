Return-Path: <SRS0=jQQH=32=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEFDC33CAC
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 18:17:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E7B214AF
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 18:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E7B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 82DB7860E6;
	Thu,  6 Feb 2020 18:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AqMAtuZKmMc1; Thu,  6 Feb 2020 18:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5FEE6860C5;
	Thu,  6 Feb 2020 18:17:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53A6DC0881;
	Thu,  6 Feb 2020 18:17:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3D64C013E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 18:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 91D1F869C7
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 18:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eWflQ3CZuZBw for <iommu@lists.linux-foundation.org>;
 Thu,  6 Feb 2020 18:17:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D232E869B4
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 18:17:31 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Feb 2020 10:17:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; d="scan'208";a="226230816"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2020 10:17:29 -0800
Date: Thu, 6 Feb 2020 10:22:47 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200206102247.4eeb5791@jacob-builder>
In-Reply-To: <699faadb-e714-e36d-152a-5b650c0a403f@redhat.com>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <699faadb-e714-e36d-152a-5b650c0a403f@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
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

On Thu, 6 Feb 2020 11:14:27 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> On 1/29/20 7:02 AM, Jacob Pan wrote:
> > Define a unified UAPI version to be used for compatibility
> > checks between user and kernel.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/uapi/linux/iommu.h | 48
> > ++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 48
> > insertions(+)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index fcafb6401430..65a26c2519ee 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -8,6 +8,54 @@
> >  
> >  #include <linux/types.h>
> >  
> > +/**
> > + * Current version of the IOMMU user API. This is intended for
> > query
> > + * between user and kernel to determine compatible data structures.
> > + *
> > + * Having a single UAPI version to govern the user-kernel data
> > structures
> > + * makes compatibility check straightforward. On the contrary,
> > supporting
> > + * combinations of multiple versions of the data can be a
> > nightmare.  
> I would rather put the above justification in the commit msg and not
> here.
make sense.

> > + *
> > + * UAPI version can be bumped up with the following rules:
> > + * 1. All data structures passed between user and kernel space
> > share
> > + *    the same version number. i.e. any extension to to any
> > structure  
> s/to to/to
will fix.

> > + *    results in version bump up.  
> in a version number increment?
sounds good, more specific.

> > + *
> > + * 2. Data structures are open to extension but closed to
> > modification.> + *    New fields must be added at the end of each
> > data structure with
> > + *    64bit alignment. Flag bits can be added without size change
> > but
> > + *    existing ones cannot be altered.
> > + *
> > + * 3. Versions are backward compatible.
> > + *
> > + * 4. Version to size lookup is supported by kernel internal API
> > for each
> > + *    API function type. @version is mandatory for new data
> > structures
> > + *    and must be at the beginning with type of __u32.
> > + */
> > +#define IOMMU_UAPI_VERSION	1
> > +static inline int iommu_get_uapi_version(void)
> > +{
> > +	return IOMMU_UAPI_VERSION;
> > +}
> > +
> > +/*
> > + * Supported UAPI features that can be reported to user space.
> > + * These types represent the capability available in the kernel.
> > + *
> > + * REVISIT: UAPI version also implies the capabilities. Should we
> > + * report them explicitly?
> > + */
> > +enum IOMMU_UAPI_DATA_TYPES {
> > +	IOMMU_UAPI_BIND_GPASID,
> > +	IOMMU_UAPI_CACHE_INVAL,
> > +	IOMMU_UAPI_PAGE_RESP,
> > +	NR_IOMMU_UAPI_TYPE,
> > +};
> > +
> > +#define IOMMU_UAPI_CAP_MASK ((1 << IOMMU_UAPI_BIND_GPASID)
> > |	\
> > +				(1 << IOMMU_UAPI_CACHE_INVAL)
> > |	\
> > +				(1 << IOMMU_UAPI_PAGE_RESP))
> > +
> >  #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
> >  #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
> >  #define IOMMU_FAULT_PERM_EXEC	(1 << 2) /* exec */
> >   
> Thanks
> 
> Eric
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
