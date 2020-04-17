Return-Path: <SRS0=1rof=6B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC54C38A2F
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 15:23:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80ECB2224E
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 15:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ECB2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EBF8480CF7;
	Fri, 17 Apr 2020 15:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id olkLrfRThkIw; Fri, 17 Apr 2020 15:23:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C1D9F876A6;
	Fri, 17 Apr 2020 15:23:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5F79C1D7E;
	Fri, 17 Apr 2020 15:23:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82F2EC0172
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 15:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 57D8F87EE9
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 15:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id euv2slMDYe+B for <iommu@lists.linux-foundation.org>;
 Fri, 17 Apr 2020 15:23:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6CD4A857DC
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 15:22:46 +0000 (UTC)
IronPort-SDR: pmWyhD9Yd0W0DczDhbV8BJZkIfLQ7pL+K0xFcx1FAqoEa6NSrRey5GaDk0oG0l3pGBNjRDc8Lp
 MWWjfj583uNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2020 08:22:44 -0700
IronPort-SDR: jttx9y4XliPhN5EmpkCynjQPClqI9PL59tfFSuf/z31+Enejj5o2AgxCyiDRK4DT9ud2Ko8scm
 2AlOmCiNfDuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; d="scan'208";a="279887326"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 17 Apr 2020 08:22:44 -0700
Date: Fri, 17 Apr 2020 08:28:39 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200417082839.45d6321e@jacob-builder>
In-Reply-To: <2025736d-e7f2-d746-e030-e609b2f465e2@redhat.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <ab57b85b-235f-dc80-1c25-9b3d42dc5f4e@redhat.com>
 <20200410124557.4012b99b@jacob-builder>
 <6d9721a8-2198-5ecd-6c8b-fc43ff2ad7e1@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D824106@SHSMSX104.ccr.corp.intel.com>
 <2025736d-e7f2-d746-e030-e609b2f465e2@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
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

On Fri, 17 Apr 2020 09:46:55 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Kevin,
> On 4/17/20 4:45 AM, Tian, Kevin wrote:
> >> From: Auger Eric
> >> Sent: Thursday, April 16, 2020 6:43 PM
> >>  
> > [...]  
> >>>>> +	if (svm) {
> >>>>> +		/*
> >>>>> +		 * If we found svm for the PASID, there must
> >>>>> be at
> >>>>> +		 * least one device bond, otherwise svm should
> >>>>> be freed.
> >>>>> +		 */
> >>>>> +		if (WARN_ON(list_empty(&svm->devs))) {
> >>>>> +			ret = -EINVAL;
> >>>>> +			goto out;
> >>>>> +		}
> >>>>> +
> >>>>> +		for_each_svm_dev(sdev, svm, dev) {
> >>>>> +			/* In case of multiple sub-devices of
> >>>>> the same pdev
> >>>>> +			 * assigned, we should allow multiple
> >>>>> bind calls with
> >>>>> +			 * the same PASID and pdev.
> >>>>> +			 */
> >>>>> +			sdev->users++;  
> >>>> What if this is not an mdev device. Is it also allowed?  
> >>> Yes. IOMMU and VT-d driver is not mdev aware. Here mdev is just an
> >>> example of normal use case. You can bind the same PCI device (PF
> >>> or SRIOV VF) more than once to the same PASID. Just need to
> >>> unbind also.  
> >>
> >> I don't get the point of binding a non mdev device several times
> >> with the same PASID. Do you intend to allow that at userspace
> >> level or prevent this from happening in VFIO?  
> > 
> > I feel it's better to prevent this from happening, otherwise VFIO
> > also needs to track the bind count and do multiple unbinds at
> > mm_exit. But it's not necessary to prevent it in VFIO. We can check
> > here upon whether aux_domain is valid, and if not return -EBUSY.  
> Ah OK. So if we can detect the case here it is even better
> 
I don't understand why VFIO cannot track, since it is mdev aware. if we
don;t refcount the users, one mdev unbind will result unbind for all
mdev under the same pdev. That may not be the right thing to do.

> Thanks
> 
> Eric
> >   
> >>
> >> Besides, the comment is a bit misleading as it gives the
> >> impression it is only true for mdev and there is no associated
> >> check.  
> > 
> > Thanks
> > Kevin
> >   
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
