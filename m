Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6068C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 23:59:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C3164F4B
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 23:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C3164F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E801F40193;
	Wed,  3 Mar 2021 23:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Os51g0lPjE0o; Wed,  3 Mar 2021 23:59:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D4D104017D;
	Wed,  3 Mar 2021 23:59:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABCC3C000A;
	Wed,  3 Mar 2021 23:59:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C8B7C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 23:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E64A940186
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 23:59:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9HpETw8Bleq for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 23:59:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 236EC4017D
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 23:59:50 +0000 (UTC)
IronPort-SDR: k040eKWWLHL2n/ruUw4lT4SuJUfr+biBY0YukIygQD681eQWeTtHsURGqNb3KcgOSap7Y2+5jT
 jspUc1IWiPyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="186649862"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="186649862"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 15:59:49 -0800
IronPort-SDR: +vxitPST2B82Q3t1Wscr0o0o+AAEVJudR9cF6VlNUJofp/U3LMOqwUGZhjDEiq/KHp0TECf9+y
 t8/bPNCml/tQ==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="445479939"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 15:59:49 -0800
Date: Wed, 3 Mar 2021 16:02:05 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <20210303160205.151d114e@jacob-builder>
In-Reply-To: <20210303131726.7a8cb169@jacob-builder>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
 <20210303131726.7a8cb169@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 Wu Hao <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob,

On Wed, 3 Mar 2021 13:17:26 -0800, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> Hi Tejun,
> 
> On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org> wrote:
> 
> > On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:  
> > > IOASIDs are used to associate DMA requests with virtual address
> > > spaces. They are a system-wide limited resource made available to the
> > > userspace applications. Let it be VMs or user-space device drivers.
> > > 
> > > This RFC patch introduces a cgroup controller to address the following
> > > problems:
> > > 1. Some user applications exhaust all the available IOASIDs thus
> > > depriving others of the same host.
> > > 2. System admins need to provision VMs based on their needs for
> > > IOASIDs, e.g. the number of VMs with assigned devices that perform
> > > DMA requests with PASID.    
> > 
> > Please take a look at the proposed misc controller:
> > 
> >  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> > 
> > Would that fit your bill?  
> The interface definitely can be reused. But IOASID has a different
> behavior in terms of migration and ownership checking. I guess SEV key
> IDs are not tied to a process whereas IOASIDs are. Perhaps this can be
> solved by adding
> +	.can_attach	= ioasids_can_attach,
> +	.cancel_attach	= ioasids_cancel_attach,
> Let me give it a try and come back.
> 
While I am trying to fit the IOASIDs cgroup in to the misc cgroup proposal.
I'd like to have a direction check on whether this idea of using cgroup for
IOASID/PASID resource management is viable.

Alex/Jason/Jean and everyone, your feedback is much appreciated.

> Thanks for the pointer.
> 
> Jacob
> 
> > 
> > Thanks.
> >   
> 
> 
> Thanks,
> 
> Jacob


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
