Return-Path: <SRS0=TVo/=HV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A679C433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Feb 2021 17:06:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897AB64E57
	for <iommu@archiver.kernel.org>; Fri, 19 Feb 2021 17:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897AB64E57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4DA0C86C2E;
	Fri, 19 Feb 2021 17:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ezSackbG6Pbk; Fri, 19 Feb 2021 17:06:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B9A0086C06;
	Fri, 19 Feb 2021 17:06:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93A21C000F;
	Fri, 19 Feb 2021 17:06:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01267C000D
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 17:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EA13F86C25
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 17:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x9L48WOkmajb for <iommu@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 17:06:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A81E186C06
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 17:06:33 +0000 (UTC)
IronPort-SDR: i9SrqnEYLFHEikT98kE4fW+PIzmzjIJoREPC8E/NS/f4ioGSZ2NRx7JvKzmc0ieBYsDsR8GbsC
 7J5kioBUw/Ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="183958655"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; d="scan'208";a="183958655"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 09:06:06 -0800
IronPort-SDR: Di5Ms4CVASvFl+T3Rme5u33oluH6arCvcUasfIeAJYKXj11y0k0t/PB7jgFart2Cn8guOS9cq2
 JXo41pR4RIpQ==
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; d="scan'208";a="401112007"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 09:06:05 -0800
Date: Fri, 19 Feb 2021 09:08:41 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 2/4] iommu/vt-d: Enable write protect propagation from
 guest
Message-ID: <20210219090841.4ae6f01c@jacob-builder>
In-Reply-To: <MWHPR11MB1886F4395B64EC23277D88328C849@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1613683878-89946-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <MWHPR11MB1886F4395B64EC23277D88328C849@MWHPR11MB1886.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>
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

On Fri, 19 Feb 2021 06:19:04 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, February 19, 2021 5:31 AM
> > 
> > Write protect bit, when set, inhibits supervisor writes to the read-only
> > pages. In guest supervisor shared virtual addressing (SVA),
> > write-protect should be honored upon guest bind supervisor PASID
> > request.
> > 
> > This patch extends the VT-d portion of the IOMMU UAPI to include WP bit.
> > WPE bit of the  supervisor PASID entry will be set to match CPU CR0.WP
> > bit.
> > 
> > Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/pasid.c | 5 +++++
> >  include/uapi/linux/iommu.h  | 3 ++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index 0b7e0e726ade..c7a2ec930af4 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -763,6 +763,11 @@ intel_pasid_setup_bind_data(struct intel_iommu
> > *iommu, struct pasid_entry *pte,
> >  			return -EINVAL;
> >  		}
> >  		pasid_set_sre(pte);
> > +		/* Enable write protect WP if guest requested */
> > +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE) {
> > +			if (pasid_enable_wpe(pte))
> > +				return -EINVAL;  
> 
> We should call pasid_set_wpe directly, as this binding is about guest
> page table and suppose the guest has done whatever check required
> (e.g. gcr0.wp) before setting this bit. pasid_enable_wpe has an
> additional check on host cr0.wp thus is logically incorrect here.
> 
If the host CPU does not support WP, can guest VCPU still support WP? If
so, I agree.

> Thanks
> Kevin
> 
> > +		}
> >  	}
> > 
> >  	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 68cb558fe8db..33f3dc7a91de 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -288,7 +288,8 @@ struct iommu_gpasid_bind_data_vtd {
> >  #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write
> > through */
> >  #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem
> > type enable */
> >  #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level
> > cache disable */
> > -#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
> > +#define IOMMU_SVA_VTD_GPASID_WPE	(1 << 6) /* Write protect
> > enable */
> > +#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 7)
> >  	__u64 flags;
> >  	__u32 pat;
> >  	__u32 emt;
> > --
> > 2.25.1  
> 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
