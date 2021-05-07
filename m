Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6BAC43460
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 19:23:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4583E61463
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 19:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4583E61463
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 074BD84415;
	Fri,  7 May 2021 19:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OXioNuyUZ-An; Fri,  7 May 2021 19:23:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E042384484;
	Fri,  7 May 2021 19:23:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA564C000D;
	Fri,  7 May 2021 19:23:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9623EC0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 19:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83E4541927
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 19:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id isQ9PHD0fUOC for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 19:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 665CC4189F
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 19:23:29 +0000 (UTC)
IronPort-SDR: 2gW9quYeO1gmaZP+szCFCwCBHxhr1ym03QniY4BlsvOnzJyblMx+ZEwdOuSz7STGc7I4KSSmGD
 3bMwaFqche6g==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="186251399"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="186251399"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2021 12:23:27 -0700
IronPort-SDR: owknbHpIZ3mF/ie4r0R2rDOtoOSVpmTFhlXS/Dz3/RJ0W25pNZmjgimvjqKRfcf2tNEO9hhmvH
 gFAZrLHfFCRg==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="407536474"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2021 12:23:27 -0700
Date: Fri, 7 May 2021 12:23:25 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210507192325.GB73499@otc-nc-03>
References: <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <20210507172051.GW1370958@nvidia.com>
 <20210507181458.GA73499@otc-nc-03>
 <20210507182050.GX1370958@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210507182050.GX1370958@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jason

- Removed lizefan's email due to bounces... 

On Fri, May 07, 2021 at 03:20:50PM -0300, Jason Gunthorpe wrote:
> On Fri, May 07, 2021 at 11:14:58AM -0700, Raj, Ashok wrote:
> > On Fri, May 07, 2021 at 02:20:51PM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 06, 2021 at 09:32:40AM -0700, Raj, Ashok wrote:
> > > 
> > > > For platforms that support ENQCMD, it is required to mandate PASIDs are
> > > > global across the entire system. Maybe its better to call them gPASID for
> > > > guest and hPASID for host. Short reason being gPASID->hPASID is a guest
> > > > wide mapping for ENQCMD and not a per-RID based mapping. (We covered that
> > > > in earlier responses)
> > > 
> > > I don't think it is actually ENQCMD that forces this, ENQCMD can use a
> > > per-RID PASID in the translation table as well.
> > 
> > When using ENQCMD the PASID that needs to be sent on the wire is picked
> > from an MSR setup by kernel. This is context switched along with the
> > process. So each process has only 1 PASID that can go out when using
> > ENQCMD. ENQCMD takes one mmio address specific to the acclerator and a
> > source for the descriptor.
> 
> Oh. I forgot this also globally locked the PASID to a single
> MSR. Sigh. That makes the whole mechanism useless for anything except
> whole process SVA.

Is there another kind of SVA? Our mapping from that each process requires a
single mm, and PASID for SVM was a direct map from that. 

> 
> It also make it a general kernel problem and not just related to the
> vIOMMU scenario.
> 
> > > I think at the uAPI level the callpaths that require allocating a
> > > PASID from a group of RIDs should be explicit in their intention and
> > > not implicitly rely on a certain allocator behavior.
> > 
> > The difficult part I see is, when one application establishes a path
> > to one acclerator, we have no knowledge if its going to connect to a
> > second, third or such. I don't see how this can work reasonably
> > well. What if PASIDx is allocated for one, but the second RID its
> > trying to attach already has this PASID allocated?
> 
> You mean like some kind of vIOMMU hot plug?

Not vIOMMU hot plug. but an application opens accel1, does a bind to
allocate a PASID. What i meant was kernel has no information if this needs
to be a per-RID PASID, or a global PASID. Keeping this global solves the
other problems or more complex mechanisms to say "Reserve this PASID on all
accelerators" which seems pretty complicated to implement.

Now are we loosing anything by keeping the PASIDs global? 

As we discussed there is no security issue since the PASID table that hosts 
these PASIDs for SVM are still per-RID.  For e.g.

app establishes connection to accl1, allocates PASID-X
   RID for accel1 now has PASID-X and the process mm plummed 
later app also connects with accl2, now the PASID-X is plummed in for RID
of accel2.


> 
> > > If you want to get a PASID that can be used with every RID on in your
> > > /dev/ioasid then ask for that exactly.
> > 
> > Correct, but how does guest through vIOMMU driver communicate that intent so uAPI
> > plumbing can do this? I mean architecturally via IOMMU interfaces? 
> 
> I would have to ask for a PASID that has the property it needs. You
> are saying the property is even bigger than "usable on a group of
> RIDs" but is actually "global for every RID and IOMMU in the system so
> it can go into a MSR". Gross, but fine, ask for that explicitly when
> allocating the PASID.

If one process has a single mm, is that also gross? :-) So a single process
having a PASID is just an identifier for IOMMU. It just seems like what a
mm is for a process == PASID for SVM-IOMMU support.

The unanswered question is how do we plumb from vIOMMU without a custom
allocator to get a system wide PASID? 

The way it works today is if we have a custom allocator registered, that's
the mechanics to get PASIDs allocated. for Intel vIOMMU it happens to be a
global unique allocation. If a particular vIOMMU doesn't require, it does
not have vIOMMU interface, and those naturally get a guest local PASID name
space. (Im not sure if that's how the allocator works today, but I guess its
extensible to accomplish a RID local PASID if that's exactly what is
required)

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
