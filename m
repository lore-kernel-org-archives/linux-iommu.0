Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A733BC43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 17:10:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B14720770
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 17:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B14720770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B62448770F;
	Thu, 10 Sep 2020 17:10:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zH2kWR6ORfm0; Thu, 10 Sep 2020 17:10:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4FE6C8770B;
	Thu, 10 Sep 2020 17:10:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 442A7C0052;
	Thu, 10 Sep 2020 17:10:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05A21C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 17:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C7C322094B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 17:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mDxhZrcfMdhx for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 17:10:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id CDC49207A4
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 17:10:51 +0000 (UTC)
IronPort-SDR: wpZrHeOpBgymcS+lzX0x5hycnbsW+sIyObjcnjf0+qExUvSyICbexc3J5pfwcSuuo2y6Xf/MEH
 bOoARqJcJkhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="159538727"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="159538727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 10:10:50 -0700
IronPort-SDR: y3sx8lMTfOuw2CWmGsmU5NWTdrMQUu/FoHHbxM6PaW6Bm+XOz1mC1rsaSguMbPKBBWT+a28ipy
 /9w6SGhO5lXA==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="300623572"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 10:10:50 -0700
Date: Thu, 10 Sep 2020 10:12:48 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 9/9] iommu/vt-d: Store guest PASID during bind
Message-ID: <20200910101248.19460882@jacob-builder>
In-Reply-To: <60feda75-5862-c898-97b1-1f5eafdb8d8c@redhat.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-10-git-send-email-jacob.jun.pan@linux.intel.com>
 <60feda75-5862-c898-97b1-1f5eafdb8d8c@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Wu Hao <hao.wu@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Tue, 1 Sep 2020 19:08:44 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> On 8/22/20 6:35 AM, Jacob Pan wrote:
> > IOASID core maintains the guest-host mapping in the form of SPID and
> > IOASID. This patch assigns the guest PASID (if valid) as SPID while
> > binding guest page table with a host PASID. This mapping will be
> > used for lookup and notifications.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/svm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index d8a5efa75095..4c958b1aec4c 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -406,6 +406,7 @@ int intel_svm_bind_gpasid(struct iommu_domain
> > *domain, struct device *dev, if (data->flags &
> > IOMMU_SVA_GPASID_VAL) { svm->gpasid = data->gpasid;
> >  			svm->flags |= SVM_FLAG_GUEST_PASID;
> > +			ioasid_attach_spid(data->hpasid,
> > data->gpasid);  
> don't you want to handle the returned value?
Yes, I also need to add a check for duplicated SPID within a set.

> >  		}
> >  		svm->iommu = iommu;
> >  		/*
> > @@ -517,6 +518,7 @@ int intel_svm_unbind_gpasid(struct device *dev,
> > int pasid) ioasid_attach_data(pasid, NULL);
> >  				ioasid_notify(pasid, IOASID_UNBIND,
> >  					IOASID_NOTIFY_SET);
> > +				ioasid_attach_spid(pasid,
> > INVALID_IOASID);  
> So this answers my previous question ;-) but won't it enter the if
> (!ioasid_data) path and fail to reset the spid?
> 
Sorry, i am not following. If there is no ioasid_data then there is no
SPID to be stored.

BTW, I plan to separate the APIs into two.
ioasid_attach_spid
ioasid_detach_spid

Only ioasid_detach_spid will be calling synchronize RCU, then
ioasid_attach_spid can be called under spinlock.

Thanks,

> Eric
> >  				kfree(svm);
> >  			}
> >  		}
> >   
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
