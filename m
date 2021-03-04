Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D498FC433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 17:43:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B96364F4E
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 17:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B96364F4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 474168397A;
	Thu,  4 Mar 2021 17:43:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Elj3LAw4Hi4d; Thu,  4 Mar 2021 17:43:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CD4983955;
	Thu,  4 Mar 2021 17:43:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41822C000B;
	Thu,  4 Mar 2021 17:43:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1401C0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 927BF83963
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZjF_6-nMtb8i for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 17:43:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B41D83955
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:43:51 +0000 (UTC)
IronPort-SDR: wfb1iHYTsVsdKyIJ7olEi1QrrTVyrQu9LZ7BylgcV1QZNCqRail4kpOWv02hmQKRFFH5izj3f7
 cjtkHuwgeQ1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="207182858"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; d="scan'208";a="207182858"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2021 09:43:47 -0800
IronPort-SDR: mAlWpKOZKEpvY0SmGMBDm5RRe6QJJdnh0KUxB8DpjbEG7MHIzGWbj1rly16CjcOejbx4bxe9LP
 bGhX6pFCtY4w==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; d="scan'208";a="368260744"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2021 09:43:47 -0800
Date: Thu, 4 Mar 2021 09:46:03 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <20210304094603.4ab6c1c4@jacob-builder>
In-Reply-To: <YECtMZNqSgh7jkGP@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
 <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder> <YECtMZNqSgh7jkGP@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

Hi Jean-Philippe,

On Thu, 4 Mar 2021 10:49:37 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Wed, Mar 03, 2021 at 04:02:05PM -0800, Jacob Pan wrote:
> > Hi Jacob,
> > 
> > On Wed, 3 Mar 2021 13:17:26 -0800, Jacob Pan
> > <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > Hi Tejun,
> > > 
> > > On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org> wrote:
> > >   
> > > > On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:    
> > > > > IOASIDs are used to associate DMA requests with virtual address
> > > > > spaces. They are a system-wide limited resource made available to
> > > > > the userspace applications. Let it be VMs or user-space device
> > > > > drivers.
> > > > > 
> > > > > This RFC patch introduces a cgroup controller to address the
> > > > > following problems:
> > > > > 1. Some user applications exhaust all the available IOASIDs thus
> > > > > depriving others of the same host.
> > > > > 2. System admins need to provision VMs based on their needs for
> > > > > IOASIDs, e.g. the number of VMs with assigned devices that perform
> > > > > DMA requests with PASID.      
> > > > 
> > > > Please take a look at the proposed misc controller:
> > > > 
> > > >  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> > > > 
> > > > Would that fit your bill?    
> > > The interface definitely can be reused. But IOASID has a different
> > > behavior in terms of migration and ownership checking. I guess SEV key
> > > IDs are not tied to a process whereas IOASIDs are. Perhaps this can be
> > > solved by adding
> > > +	.can_attach	= ioasids_can_attach,
> > > +	.cancel_attach	= ioasids_cancel_attach,
> > > Let me give it a try and come back.
> > >   
> > While I am trying to fit the IOASIDs cgroup in to the misc cgroup
> > proposal. I'd like to have a direction check on whether this idea of
> > using cgroup for IOASID/PASID resource management is viable.  
> 
> Yes, even for host SVA it would be good to have a cgroup. Currently the
> number of shared address spaces is naturally limited by number of
> processes, which can be controlled with rlimit and cgroup. But on Arm the
> hardware limit on shared address spaces is 64k (number of ASIDs), easily
> exhausted with the default PASID and PID limits. So a cgroup for managing
> this resource is more than welcome.
> 
> It looks like your current implementation is very dependent on
> IOASID_SET_TYPE_MM?  I'll need to do more reading about cgroup to see how
> easily it can be adapted to host SVA which uses IOASID_SET_TYPE_NULL.
> 
Right, I was assuming have three use cases of IOASIDs:
1. host supervisor SVA (not a concern, just one init_mm to bind)
2. host user SVA, either one IOASID per process or perhaps some private
IOASID for private address space
3. VM use for guest SVA, each IOASID is bound to a guest process

My current cgroup proposal applies to #3 with IOASID_SET_TYPE_MM, which is
allocated by the new /dev/ioasid interface.

For #2, I was thinking you can limit the host process via PIDs cgroup? i.e.
limit fork. So the host IOASIDs are currently allocated from the system pool
with quota of chosen by iommu_sva_init() in my patch, 0 means unlimited use
whatever is available. https://lkml.org/lkml/2021/2/28/18


> Thanks,
> Jean


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
