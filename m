Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1565C433B4
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 17:21:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48708613D0
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 17:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48708613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B4884017C;
	Thu,  1 Apr 2021 17:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KYZGvK7XKIkL; Thu,  1 Apr 2021 17:21:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D13BD405A6;
	Thu,  1 Apr 2021 17:21:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4D97C000B;
	Thu,  1 Apr 2021 17:21:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDD2CC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 17:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCB3A405A6
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 17:21:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qE9GF1z9fFjo for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 17:21:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2664240015
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 17:21:25 +0000 (UTC)
IronPort-SDR: 7PoJP1fdIpdT0KmFCl7BemYNLSZdsHSO9MWyZVtrXiiuRRWXCpKbVbWnMpsSO6lE6UJUf808T9
 nD6Ksfuw7W+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189035220"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="189035220"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 10:21:24 -0700
IronPort-SDR: FFJ3yy27N0ijmymlKcf7V8zicG08idghljFw0s4Y6KD/UjpiAbD1gOdnFbw1W3kJKMbXkxqAG8
 ft75EXtnVLnQ==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="394609303"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 10:21:23 -0700
Date: Thu, 1 Apr 2021 10:23:55 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210401102355.38b0b7d7@jacob-builder>
In-Reply-To: <20210401003705.GS1463678@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132740.GB1403691@nvidia.com>
 <BN6PR11MB40688BB2693A657D411E33C8C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331123801.GD1463678@nvidia.com>
 <20210331164621.5f0b0d63@jacob-builder>
 <20210401003705.GS1463678@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jason,

On Wed, 31 Mar 2021 21:37:05 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 31, 2021 at 04:46:21PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 31 Mar 2021 09:38:01 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > > > Get rid of the ioasid set.
> > > > >
> > > > > Each driver has its own list of allowed ioasids.    
> > >  [...]  
> > > 
> > > The /dev/ioasid FD replaces this security check. By becoming FD
> > > centric you don't need additional kernel security objects.
> > > 
> > > Any process with access to the /dev/ioasid FD is allowed to control
> > > those PASID. The seperation between VMs falls naturally from the
> > > seperation of FDs without creating additional, complicated, security
> > > infrastrucure in the kernel.
> > > 
> > > This is why all APIs must be FD focused, and you need to have a
> > > logical layering of responsibility.
> > > 
> > >  Allocate a /dev/ioasid FD
> > >  Allocate PASIDs inside the FD
Just to be super clear. Do we allocate a FD for each PASID and return the
FD to the user? Or return the plain PASID number back to the user space?

> > >  Assign memory to the PASIDS
> > > 
> > >  Open a device FD, eg from VFIO or VDP
> > >  Instruct the device FD to authorize the device to access PASID A in
> > >  an ioasid FD  
> > How do we know user provided PASID A was allocated by the ioasid FD?  
> 
> You pass in the ioasid FD and use a 'get pasid from fdno' API to
> extract the required kernel structure.
> 
Seems you are talking about two FDs:
- /dev/ioasid FD
- per IOASID FD
This API ioasid = get_pasid_from_fd(dev_ioasid_fd, ioasid_fd);
dev_ioasid_fd will find the xarray for all the PASIDs allocated under it,
ioasid_fd wil be the index into the xarray to retrieve the actual ioasid.
Correct?

> > Shouldn't we validate user input by tracking which PASIDs are
> > allocated by which ioasid FD?  
> 
> Yes, but it is integral to the ioasid FD, not something separated.
> 
OK, if we have per IOASID FD in addition to the /dev/ioasid FD we can
validate user input.

> > > VFIO extracts some kernel representation of the ioasid from the ioasid
> > > fd using an API
> > >   
> > This lookup API seems to be asking for per ioasid FD storage array.
> > Today, the ioasid_set is per mm and contains a Xarray.   
> 
> Right, put the xarray per FD. A set per mm is fairly nonsensical, we
> don't use the mm as that kind of security key.
> 
Sounds good, one xarray per /dev/ioasid FD.

> > Since each VM, KVM can only open one ioasid FD, this per FD array
> > would be equivalent to the per mm ioasid_set, right?  
> 
> Why only one?  Each interaction with the other FDs should include the
> PASID/FD pair. There is no restriction to just one.
> 
OK, one per subsystem-VM. For example, if a VM has a VFIO and a VDPA
device, it should only two /dev/ioasid FDs respectively. Correct?

> > > VFIO does some kernel call to IOMMU/IOASID layer that says 'tell the
> > > IOMMU that this PCI device is allowed to use this PASID'  
> >
> > Would it be redundant to what iommu_uapi_sva_bind_gpasid() does? I
> > thought the idea is to use ioasid FD IOCTL to issue IOMMU uAPI calls.
> > Or we can skip this step for now and wait for the user to do SVA bind.  
> 
> I'm not sure what you are asking.
> 
> Possibly some of the IOMMU API will need a bit adjusting to make
> things split.
> 
> The act of programming the page tables and the act of authorizing a
> PCI BDF to use a PASID are distinct things with two different IOCTLs.
> 
Why separate? I don't see a use case to just authorize a PASID but don't
bind it with a page table. The very act of bind page table *is* the
authorization.

> iommu_uapi_sva_bind_gpasid() is never called by anything, and it's
> uAPI is never implemented.
> 
Just a little background here. We have been working on the vSVA stack
since 2017. At the time, VFIO was the de facto interface for IOMMU-aware
driver framework. These uAPIs were always developed alone side with the
accompanying VFIO patches served as consumers. By the time these IOMMU uAPIs
were merged after reviews from most vendors, the VFIO patchset was
approaching maturity in around v7. This is when we suddenly saw a new
request to support VDPA, which attempted VFIO earlier but ultimately moved
away.

For a complex stack like vSVA, I feel we have to reduce moving parts and do
some divide and conquer.

> Joerg? Why did you merge dead uapi and dead code?
> 
> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
