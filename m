Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F179C433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 18:19:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD73650A4
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 18:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD73650A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CAA24EC41;
	Fri,  5 Mar 2021 18:19:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wei4Potjq8Ut; Fri,  5 Mar 2021 18:19:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FB134EC3F;
	Fri,  5 Mar 2021 18:19:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 369CFC000B;
	Fri,  5 Mar 2021 18:19:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8E0FC0001
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 18:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AAA0D430E5
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 18:19:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PWGue4Kk47WD for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 18:19:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9CE242FBD
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 18:19:14 +0000 (UTC)
IronPort-SDR: +1PIvSCw13EKr+Kf2/IfTLyEZRFaL+sM5BxbECpA2KZ0UwCPsHiHvgO+UthPnXAeLiyybG8MZX
 dIQ/2yGQ2wYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="187051278"
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; d="scan'208";a="187051278"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2021 10:19:13 -0800
IronPort-SDR: Yve4Xs/BQQO/dPrUERl1ezaSRoE42oOdpR/DR9drzbbAJMBbkvwbwxAPL/sU8t0amziAK3gbiO
 W9p6P5svTYjw==
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; d="scan'208";a="436593317"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2021 10:19:13 -0800
Date: Fri, 5 Mar 2021 10:20:48 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <20210305102048.7c274968@jacob-builder>
In-Reply-To: <YEHsOR/XjDxQapE6@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
 <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder> <YECtMZNqSgh7jkGP@myrica>
 <20210304094603.4ab6c1c4@jacob-builder> <YEHsOR/XjDxQapE6@myrica>
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

On Fri, 5 Mar 2021 09:30:49 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Thu, Mar 04, 2021 at 09:46:03AM -0800, Jacob Pan wrote:
> > Hi Jean-Philippe,
> > 
> > On Thu, 4 Mar 2021 10:49:37 +0100, Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> >   
> > > On Wed, Mar 03, 2021 at 04:02:05PM -0800, Jacob Pan wrote:  
> > > > Hi Jacob,
> > > > 
> > > > On Wed, 3 Mar 2021 13:17:26 -0800, Jacob Pan
> > > > <jacob.jun.pan@linux.intel.com> wrote:
> > > >     
> > > > > Hi Tejun,
> > > > > 
> > > > > On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org>
> > > > > wrote: 
> > > > > > On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:      
> > > > > > > IOASIDs are used to associate DMA requests with virtual
> > > > > > > address spaces. They are a system-wide limited resource made
> > > > > > > available to the userspace applications. Let it be VMs or
> > > > > > > user-space device drivers.
> > > > > > > 
> > > > > > > This RFC patch introduces a cgroup controller to address the
> > > > > > > following problems:
> > > > > > > 1. Some user applications exhaust all the available IOASIDs
> > > > > > > thus depriving others of the same host.
> > > > > > > 2. System admins need to provision VMs based on their needs
> > > > > > > for IOASIDs, e.g. the number of VMs with assigned devices
> > > > > > > that perform DMA requests with PASID.        
> > > > > > 
> > > > > > Please take a look at the proposed misc controller:
> > > > > > 
> > > > > >  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> > > > > > 
> > > > > > Would that fit your bill?      
> > > > > The interface definitely can be reused. But IOASID has a different
> > > > > behavior in terms of migration and ownership checking. I guess
> > > > > SEV key IDs are not tied to a process whereas IOASIDs are.
> > > > > Perhaps this can be solved by adding
> > > > > +	.can_attach	= ioasids_can_attach,
> > > > > +	.cancel_attach	= ioasids_cancel_attach,
> > > > > Let me give it a try and come back.
> > > > >     
> > > > While I am trying to fit the IOASIDs cgroup in to the misc cgroup
> > > > proposal. I'd like to have a direction check on whether this idea of
> > > > using cgroup for IOASID/PASID resource management is viable.    
> > > 
> > > Yes, even for host SVA it would be good to have a cgroup. Currently
> > > the number of shared address spaces is naturally limited by number of
> > > processes, which can be controlled with rlimit and cgroup. But on Arm
> > > the hardware limit on shared address spaces is 64k (number of ASIDs),
> > > easily exhausted with the default PASID and PID limits. So a cgroup
> > > for managing this resource is more than welcome.
> > > 
> > > It looks like your current implementation is very dependent on
> > > IOASID_SET_TYPE_MM?  I'll need to do more reading about cgroup to see
> > > how easily it can be adapted to host SVA which uses
> > > IOASID_SET_TYPE_NULL. 
> > Right, I was assuming have three use cases of IOASIDs:
> > 1. host supervisor SVA (not a concern, just one init_mm to bind)
> > 2. host user SVA, either one IOASID per process or perhaps some private
> > IOASID for private address space
> > 3. VM use for guest SVA, each IOASID is bound to a guest process
> > 
> > My current cgroup proposal applies to #3 with IOASID_SET_TYPE_MM, which
> > is allocated by the new /dev/ioasid interface.
> > 
> > For #2, I was thinking you can limit the host process via PIDs cgroup?
> > i.e. limit fork.  
> 
> That works but isn't perfect, because the hardware resource of shared
> address spaces can be much lower that PID limit - 16k ASIDs on Arm. To
> allow an admin to fairly distribute that resource we could introduce
> another cgroup just to limit the number of shared address spaces, but
> limiting the number of IOASIDs does the trick.
> 
make sense. it would be cleaner to have a single approach to limit IOASIDs
(as Jason asked).

> > So the host IOASIDs are currently allocated from the system pool
> > with quota of chosen by iommu_sva_init() in my patch, 0 means unlimited
> > use whatever is available. https://lkml.org/lkml/2021/2/28/18  
> 
> Yes that's sensible, but it would be good to plan the cgroup user
> interface to work for #2 as well, even if we don't implement it right
> away.
> 
will do it in the next version.

> Thanks,
> Jean


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
