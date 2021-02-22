Return-Path: <SRS0=ekvE=HY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E595EC433DB
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 17:58:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECEC64E5C
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 17:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECEC64E5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 312026F569;
	Mon, 22 Feb 2021 17:58:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L4lWbOJOUGQ9; Mon, 22 Feb 2021 17:58:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE1E26F510;
	Mon, 22 Feb 2021 17:58:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7949C000A;
	Mon, 22 Feb 2021 17:58:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B73D4C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 17:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B03CE8717D
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 17:58:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WkQBOfIp04-Y for <iommu@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 17:58:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1897487175
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 17:58:41 +0000 (UTC)
IronPort-SDR: fEXMArdnVwyt2JALwhZHUZRfniJx/JumV/pWjDpBTrS+trnKH/e1zudduZPZzUHYVYsmj204nV
 XG26j947Z3lQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="164372197"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; d="scan'208";a="164372197"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 09:58:30 -0800
IronPort-SDR: IA7AY8wsZOxpoKUHheB4xcj/giQmReA+JZG0euxu7ms2z7uPEeoGak2bviLbsthLmeu3gP6qzR
 znzSJYah6wwQ==
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; d="scan'208";a="432171493"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 09:58:29 -0800
Date: Mon, 22 Feb 2021 10:01:06 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 2/4] iommu/vt-d: Enable write protect propagation from
 guest
Message-ID: <20210222100106.0ae8380e@jacob-builder>
In-Reply-To: <MWHPR11MB1886D3FA49A212684239530D8C839@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1613683878-89946-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <MWHPR11MB1886F4395B64EC23277D88328C849@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210219090841.4ae6f01c@jacob-builder>
 <MWHPR11MB1886D3FA49A212684239530D8C839@MWHPR11MB1886.namprd11.prod.outlook.com>
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

On Sat, 20 Feb 2021 02:38:02 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, February 20, 2021 1:09 AM
> > 
> > Hi Kevin,
> > 
> > On Fri, 19 Feb 2021 06:19:04 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> > wrote:
> >   
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Friday, February 19, 2021 5:31 AM
> > > >
> > > > Write protect bit, when set, inhibits supervisor writes to the
> > > > read-only pages. In guest supervisor shared virtual addressing
> > > > (SVA), write-protect should be honored upon guest bind supervisor
> > > > PASID request.
> > > >
> > > > This patch extends the VT-d portion of the IOMMU UAPI to include WP
> > > > bit. WPE bit of the  supervisor PASID entry will be set to match
> > > > CPU CR0.WP bit.
> > > >
> > > > Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > ---
> > > >  drivers/iommu/intel/pasid.c | 5 +++++
> > > >  include/uapi/linux/iommu.h  | 3 ++-
> > > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iommu/intel/pasid.c
> > > > b/drivers/iommu/intel/pasid.c index 0b7e0e726ade..c7a2ec930af4
> > > > 100644 --- a/drivers/iommu/intel/pasid.c
> > > > +++ b/drivers/iommu/intel/pasid.c
> > > > @@ -763,6 +763,11 @@ intel_pasid_setup_bind_data(struct  
> > intel_iommu  
> > > > *iommu, struct pasid_entry *pte,
> > > >  			return -EINVAL;
> > > >  		}
> > > >  		pasid_set_sre(pte);
> > > > +		/* Enable write protect WP if guest requested */
> > > > +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE) {
> > > > +			if (pasid_enable_wpe(pte))
> > > > +				return -EINVAL;  
> > >
> > > We should call pasid_set_wpe directly, as this binding is about guest
> > > page table and suppose the guest has done whatever check required
> > > (e.g. gcr0.wp) before setting this bit. pasid_enable_wpe has an
> > > additional check on host cr0.wp thus is logically incorrect here.
> > >  
> > If the host CPU does not support WP, can guest VCPU still support WP? If
> > so, I agree.
> >   
> 
> If you change 'support' to 'enable', then the answer is yes.

I agree, thanks for explaining. Will change it to pasid_set_wpe.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
