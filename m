Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2705C55179
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 17:51:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F7B2242F
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 17:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F7B2242F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 70559874A4;
	Wed, 21 Oct 2020 17:51:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6tPjJwJ-Rjip; Wed, 21 Oct 2020 17:51:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CE92087469;
	Wed, 21 Oct 2020 17:51:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BB44C088B;
	Wed, 21 Oct 2020 17:51:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3071AC0051
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 17:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1D76187480
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 17:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q2Jizt9OZc8Q for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 17:51:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4781487469
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 17:51:48 +0000 (UTC)
IronPort-SDR: Oxq4FbQzUzo+YnBikxNUzl+pPuaws+IVIvlYiJ64QKrpPmxtHz3egp0FssL1c5SZ0EuzaOJRQc
 MQgtpO+44SXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="252108040"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; d="scan'208";a="252108040"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 10:51:47 -0700
IronPort-SDR: nFaU7IqUVQFKNumGJ/O1yc0Mzip0lJxesUnBPBkk77D+dGCEh3jTfpKDy3QXKu79tSmu7h0pjr
 Y6Np+1E56OMA==
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; d="scan'208";a="359584998"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 10:51:47 -0700
Date: Wed, 21 Oct 2020 10:51:46 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201021175146.GA92867@otc-nc-03>
References: <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020140217.GI6219@nvidia.com>
 <20201020162430.GA85321@otc-nc-03>
 <20201020170336.GK6219@nvidia.com>
 <20201020195146.GA86371@otc-nc-03>
 <20201020195557.GO6219@nvidia.com>
 <20201020200844.GC86371@otc-nc-03>
 <20201020201403.GP6219@nvidia.com>
 <20201020202713.GF86371@otc-nc-03>
 <20201021114829.GR6219@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201021114829.GR6219@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Wed, Oct 21, 2020 at 08:48:29AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 20, 2020 at 01:27:13PM -0700, Raj, Ashok wrote:
> > On Tue, Oct 20, 2020 at 05:14:03PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Oct 20, 2020 at 01:08:44PM -0700, Raj, Ashok wrote:
> > > > On Tue, Oct 20, 2020 at 04:55:57PM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Oct 20, 2020 at 12:51:46PM -0700, Raj, Ashok wrote:
> > > > > > I think we agreed (or agree to disagree and commit) for device types that 
> > > > > > we have for SIOV, VFIO based approach works well without having to re-invent 
> > > > > > another way to do the same things. Not looking for a shortcut by any means, 
> > > > > > but we need to plan around existing hardware though. Looks like vDPA took 
> > > > > > some shortcuts then to not abstract iommu uAPI instead :-)? When all
> > > > > > necessary hardware was available.. This would be a solved puzzle. 
> > > > > 
> > > > > I think it is the opposite, vIOMMU and related has outgrown VFIO as
> > > > > the "home" and needs to stand alone.
> > > > > 
> > > > > Apparently the HW that will need PASID for vDPA is Intel HW, so if
> > > > 
> > > > So just to make this clear, I did check internally if there are any plans
> > > > for vDPA + SVM. There are none at the moment. 
> > > 
> > > Not SVM, SIOV.
> > 
> > ... And that included.. I should have said vDPA + PASID, No current plans. 
> > I have no idea who set expectations with you. Can you please put me in touch 
> > with that person, privately is fine.
> 
> It was the team that aruged VDPA had to be done through VFIO - SIOV
> and PASID was one of their reasons it had to be VFIO, check the list
> archives

Humm... I could search the arhives, but the point is I'm confirming that
there is no forward looking plan!

And who ever did was it was based on probably strawman hypothetical argument that wasn't
grounded in reality. 

> 
> If they didn't plan to use it, bit of a strawman argument, right?

This doesn't need to continue like the debates :-) Pun intended :-)

I don't think it makes any sense to have an abstract strawman argument
design discussion. Yi is looking into for pasid management alone. Rest 
of the IOMMU related topics should wait until we have another 
*real* use requiring consolidation. 

Contrary to your argument, vDPA went with a half blown device only 
iommu user without considering existing abstractions like containers 
and such in VFIO is part of the reason the gap is big at the moment.
And you might not agree, but that's beside the point. 

Rather than pivot ourselves around hypothetical, strawman,
non-intersecting, suggesting architecture without having done a proof of
concept to validate the proposal should stop. We have to ground ourselves
in reality.

The use cases we have so far for SIOV, VFIO and mdev seem to be the right
candidates and addresses them well. Now you might disagree, but as noted we
all agreed to move past this.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
