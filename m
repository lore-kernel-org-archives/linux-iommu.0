Return-Path: <SRS0=sTZ6=KD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B29C433B4
	for <iommu@archiver.kernel.org>; Sat,  8 May 2021 07:07:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7AA608FE
	for <iommu@archiver.kernel.org>; Sat,  8 May 2021 07:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7AA608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CFCBF403F7;
	Sat,  8 May 2021 07:07:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l0nY8pPyfBvd; Sat,  8 May 2021 07:07:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C928403F2;
	Sat,  8 May 2021 07:07:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63B3EC000D;
	Sat,  8 May 2021 07:07:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93DA1C0001
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 07:07:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6BE7B606E3
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 07:07:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tfbP-wi3CIGb for <iommu@lists.linux-foundation.org>;
 Sat,  8 May 2021 07:07:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E443960683
 for <iommu@lists.linux-foundation.org>; Sat,  8 May 2021 07:07:37 +0000 (UTC)
IronPort-SDR: qnFYLZAzCftfUT9Kwe+nZqCy2FoQ2z6S8F6tCJcrcxoqNbRLwqG4gACzrkLSXn+bf+nUWD4evg
 w19DfZjDqmYw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="219792997"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="219792997"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2021 00:07:34 -0700
IronPort-SDR: HcYo65eFc2I9AQ9MFhV/t+Tiui1lCCrJbkRQDdije3CmI44usgCC0xSeoI94otqxA99wpkX9Pr
 7G/V+Gvra+sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="431898036"
Received: from yiliu-dev.bj.intel.com (HELO yiliu-dev) ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 08 May 2021 00:07:30 -0700
Date: Sat, 8 May 2021 15:06:17 +0800
From: Liu Yi L <yi.l.liu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210508150617.1e357fcf@yiliu-dev>
In-Reply-To: <20210505222120.GM1370958@nvidia.com>
References: <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
 <20210505222120.GM1370958@nvidia.com>
Organization: IAGS/SSE(OTC)
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Li Zefan <lizefan@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Wed, 5 May 2021 19:21:20 -0300, Jason Gunthorpe wrote:

> On Wed, May 05, 2021 at 01:04:46PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 5 May 2021 15:00:23 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Wed, May 05, 2021 at 10:22:59AM -0700, Jacob Pan wrote:
> > >   
> > > > Global and pluggable are for slightly separate reasons.
> > > > - We need global PASID on VT-d in that we need to support shared
> > > > workqueues (SWQ). E.g. One SWQ can be wrapped into two mdevs then
> > > > assigned to two VMs. Each VM uses its private guest PASID to submit
> > > > work but each guest PASID must be translated to a global (system-wide)
> > > > host PASID to avoid conflict. Also, since PASID table storage is per
> > > > PF, if two mdevs of the same PF are assigned to different VMs, the
> > > > PASIDs must be unique.    
> > > 
> > > From a protocol perspective each RID has a unique PASID table, and
> > > RIDs can have overlapping PASIDs.
> > >   
> > True, per RID or per PF as I was referring to.
> >   
> > > Since your SWQ is connected to a single RID the requirement that
> > > PASIDs are unique to the RID ensures they are sufficiently unique.
> > >   
> > True, but one process can submit work to multiple mdevs from different
> > RIDs/PFs. One process uses one PASID and PASID translation table is per VM.
> > The same PASID is used for all the PASID tables of each RID.  
> 
> If the model is "assign this PASID to this RID" then yes, there is a
> big problem keeping everything straight that can only be solved with a
> global table.
> 
> But if the model is "give me a PASID for this RID" then it isn't such
> a problem.

Let me double confirm if I'm understanding you correctly. So your suggestion
is to have a per-RID PASID namespace, which can be maintainer by IOMMU driver.
right? Take native SVM usage as an example, everytime a process is bound with
a device, a PASID within this RID will be allocated. Am I correct so far?

If yes, then there is a case in which IOTLB efficiency is really low. Let's ay
there is a process bound with multiple devices(RIDs) and has different PASIDs
allocated for each RID. In such case, the PASID values are different for each
RID. As most vendor will do, PASID will be used to tag IOTLB entries. So in such
case, here will be multiple IOTLB entries for a single VA->PA mapping. And the
number of such duplicate IOTLB entries increases linearly per the number of the
device number. Seems not good from performance perspective.

> 
> Basically trying to enforce a uniform PASID for an IOASID across all
> RIDs attached to it is not such a nice choice.
> 
> > > That is fine, but all this stuff should be inside the Intel vIOMMU
> > > driver not made into a global resource of the entire iommu subsystem.
> > >   
> > Intel vIOMMU has to use a generic uAPI to allocate PASID so the generic
> > code need to have this option. I guess you are saying we should also have a
> > per RID allocation option in addition to global?  
> 
> There always has to be a RID involvement for the PASID, for security,
> this issue really boils down to where the PASID lives.
> 
> If you need the PASID attached to the IOASID then it has to be global
> because the IOASID can be attached to any RID and must keep the same
> PASID.
> 
> If the PASID is learned when the IOASID is attached to a RID then the
> PASID is more flexible and isn't attached to the IOASID.
> 
> Honestly I'm a little leary to bake into a UAPI a specific HW choice
> that Intel made here.
> 
> I would advise making the "attach a global PASID to this IOASID"
> operation explicit and opt into for case that actually need it.
> 
> Which implies the API to the iommu driver should be more like:
> 
>   'assign an IOASID to this RID and return the PASID'
>   'reserve a PASID from every RID'
>   'assign an IOASID to this RID and use this specific PASID'
> 
> In all cases the scope of those operations are completely local to a
> certain IOMMU driver - 'reserver a PASID from every RID' is really
> every RID that driver can operate on.

Also, this reservation will be failed if the PASID happens to be occupied
by previous usage. As the PASID translation table is per-VM, ENQCMD in VM
will be a problem under such PASID management model.

> 
> So it is hard to see why the allocator should be a global resource and
> not something that is part of the iommu driver exclusively.
> 
> Jason

-- 
Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
