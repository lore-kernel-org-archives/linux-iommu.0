Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE13C433ED
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 18:15:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E441D61059
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 18:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E441D61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B48D401D8;
	Fri,  7 May 2021 18:15:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7n0FMt9C5MRe; Fri,  7 May 2021 18:15:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75F9D40112;
	Fri,  7 May 2021 18:15:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51169C000E;
	Fri,  7 May 2021 18:15:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAC2CC0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 18:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BDF3401B2
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 18:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xWNJgKNKpCtD for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 18:15:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6EB740112
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 18:15:01 +0000 (UTC)
IronPort-SDR: DkXIkrYq6lsgQ+sv+EOf1aXhqoTorOeZrO6a/DrJTp1oNQp+plQ/36VmgcfqbQXApCQni4xv3/
 90wjthvtBQXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="186237616"
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; d="scan'208";a="186237616"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2021 11:14:59 -0700
IronPort-SDR: KGO5KDQ3aq1E4r48nm26o5wyNsivi8/uYFBHxEQi04F68S1zKd6vtgxoa348+BbryRQGanXZtK
 c/beNWJOh9bg==
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; d="scan'208";a="407516969"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2021 11:14:59 -0700
Date: Fri, 7 May 2021 11:14:58 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210507181458.GA73499@otc-nc-03>
References: <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <20210507172051.GW1370958@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210507172051.GW1370958@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
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

On Fri, May 07, 2021 at 02:20:51PM -0300, Jason Gunthorpe wrote:
> On Thu, May 06, 2021 at 09:32:40AM -0700, Raj, Ashok wrote:
> 
> > For platforms that support ENQCMD, it is required to mandate PASIDs are
> > global across the entire system. Maybe its better to call them gPASID for
> > guest and hPASID for host. Short reason being gPASID->hPASID is a guest
> > wide mapping for ENQCMD and not a per-RID based mapping. (We covered that
> > in earlier responses)
> 
> I don't think it is actually ENQCMD that forces this, ENQCMD can use a
> per-RID PASID in the translation table as well.

When using ENQCMD the PASID that needs to be sent on the wire is picked
from an MSR setup by kernel. This is context switched along with the
process. So each process has only 1 PASID that can go out when using
ENQCMD. ENQCMD takes one mmio address specific to the acclerator and a
source for the descriptor. 

When one application is connecting to more than one accelerator since this
is MSR based filled in by the cpu instruction automaticaly requires both
accelerators to use the same PASID. 

Did you refer to this implementation? or something else?
> 
> You get forced here only based on the design of the vIOMMU
> communication channel. If the guest can demand any RID is attached to
> a specific guest determined PASID then the hypervisor must accommodate
> that.

True, but when we have guest using vSVM, and enabling vENQCMD the
requirement is the same inside a guest.
> 
> > > Which would be a different behavior than something like Intel's top
> > > level IOASID that doesn't claim all the PASIDs.
> > 
> > isn't this simple, if we can say ioasid allocator can provide 
> > 
> > - system wide PASID
> > - RID local PASID
> > 
> > Based on platform capabilities that require such differentiation?
> 
> I think at the uAPI level the callpaths that require allocating a
> PASID from a group of RIDs should be explicit in their intention and
> not implicitly rely on a certain allocator behavior.

The difficult part I see is, when one application establishes a path to one
acclerator, we have no knowledge if its going to connect to a second, third 
or such. I don't see how this can work reasonably well. What if PASIDx is allocated
for one, but the second RID its trying to attach already has this
PASID allocated? 

> 
> If you want to get a PASID that can be used with every RID on in your
> /dev/ioasid then ask for that exactly.

Correct, but how does guest through vIOMMU driver communicate that intent so uAPI
plumbing can do this? I mean architecturally via IOMMU interfaces? 


Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
