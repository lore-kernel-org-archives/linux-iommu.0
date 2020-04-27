Return-Path: <SRS0=6Sm1=6L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CACAC54FD0
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 17:22:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D239208FE
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 17:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D239208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E5A44869C7;
	Mon, 27 Apr 2020 17:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2sNtlq3Zb-Dl; Mon, 27 Apr 2020 17:22:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EE5E58493F;
	Mon, 27 Apr 2020 17:22:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D76A4C18DC;
	Mon, 27 Apr 2020 17:22:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93A3EC0172
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 17:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8CD6F20528
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 17:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YlyjltbcJWns for <iommu@lists.linux-foundation.org>;
 Mon, 27 Apr 2020 17:22:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 2ECC7203F9
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 17:22:18 +0000 (UTC)
IronPort-SDR: yTeu5CgNJzPCzDDbjnyTOE8Zg4eOzAMuDR/yKx8xDoe3Kxk5XEGITmH9/f05u9Wi4I58gcYTH5
 ekC60wwUYAkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 10:22:17 -0700
IronPort-SDR: cty6BTaKNAuOIqyV63AVgsffvuSJ2Go2HVrN1ezpx76NIyJffdY5+R/v/Z9EypFUyoF6tCYQ2u
 rb+jwhftVCyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; d="scan'208";a="246211449"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 27 Apr 2020 10:22:17 -0700
Date: Mon, 27 Apr 2020 10:28:18 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200427102818.5f877d53@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D826F9D@SHSMSX104.ccr.corp.intel.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <ab57b85b-235f-dc80-1c25-9b3d42dc5f4e@redhat.com>
 <20200410124557.4012b99b@jacob-builder>
 <6d9721a8-2198-5ecd-6c8b-fc43ff2ad7e1@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D824106@SHSMSX104.ccr.corp.intel.com>
 <2025736d-e7f2-d746-e030-e609b2f465e2@redhat.com>
 <20200417082839.45d6321e@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D826F9D@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Yi L <yi.l.liu@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On Fri, 17 Apr 2020 23:46:13 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, April 17, 2020 11:29 PM
> > 
> > On Fri, 17 Apr 2020 09:46:55 +0200
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> > > Hi Kevin,
> > > On 4/17/20 4:45 AM, Tian, Kevin wrote:  
> > > >> From: Auger Eric
> > > >> Sent: Thursday, April 16, 2020 6:43 PM
> > > >>  
> > > > [...]  
> > > >>>>> +	if (svm) {
> > > >>>>> +		/*
> > > >>>>> +		 * If we found svm for the PASID, there
> > > >>>>> must be at
> > > >>>>> +		 * least one device bond, otherwise svm
> > > >>>>> should be freed.
> > > >>>>> +		 */
> > > >>>>> +		if (WARN_ON(list_empty(&svm->devs))) {
> > > >>>>> +			ret = -EINVAL;
> > > >>>>> +			goto out;
> > > >>>>> +		}
> > > >>>>> +
> > > >>>>> +		for_each_svm_dev(sdev, svm, dev) {
> > > >>>>> +			/* In case of multiple sub-devices
> > > >>>>> of the same pdev
> > > >>>>> +			 * assigned, we should allow
> > > >>>>> multiple bind calls with
> > > >>>>> +			 * the same PASID and pdev.
> > > >>>>> +			 */
> > > >>>>> +			sdev->users++;  
> > > >>>> What if this is not an mdev device. Is it also allowed?  
> > > >>> Yes. IOMMU and VT-d driver is not mdev aware. Here mdev is
> > > >>> just an example of normal use case. You can bind the same PCI
> > > >>> device (PF or SRIOV VF) more than once to the same PASID.
> > > >>> Just need to unbind also.  
> > > >>
> > > >> I don't get the point of binding a non mdev device several
> > > >> times with the same PASID. Do you intend to allow that at
> > > >> userspace level or prevent this from happening in VFIO?  
> > > >
> > > > I feel it's better to prevent this from happening, otherwise
> > > > VFIO also needs to track the bind count and do multiple unbinds
> > > > at mm_exit. But it's not necessary to prevent it in VFIO. We
> > > > can check here upon whether aux_domain is valid, and if not
> > > > return -EBUSY.  
> > > Ah OK. So if we can detect the case here it is even better
> > >  
> > I don't understand why VFIO cannot track, since it is mdev aware.
> > if we don;t refcount the users, one mdev unbind will result unbind
> > for all mdev under the same pdev. That may not be the right thing
> > to do. 
> 
> The open here is not for mdev, which refcount is still required.
> Eric's point is for non-mdev endpoints. It's meaningless and not
> intuitive to allow binding a PASID multiple-times to the same device. 
> 
That seems contradictory. The refcount here is intended/required for sub
devices such as mdev. Since IOMMU driver is not mdev aware, we cannot
treat devices differently.

Perhaps Yi can clarify if this case is handled within VFIO, then I can
drop the refcount here.

> Thanks
> Kevin

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
