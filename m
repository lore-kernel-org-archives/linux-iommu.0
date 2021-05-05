Return-Path: <SRS0=LdVQ=KA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E8C433B4
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 23:23:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3575761004
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 23:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3575761004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E026A60804;
	Wed,  5 May 2021 23:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id clqvAt0aiU_Z; Wed,  5 May 2021 23:23:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D930607C2;
	Wed,  5 May 2021 23:23:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44ECCC000E;
	Wed,  5 May 2021 23:23:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFBE8C0001
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 23:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C734607CD
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 23:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mGerd_nOUV8z for <iommu@lists.linux-foundation.org>;
 Wed,  5 May 2021 23:23:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6C8D607C2
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 23:23:22 +0000 (UTC)
IronPort-SDR: fTv7pT6sJqoQFO3oks1zYqPRAFNbIUo1uRbu3bmKQ7NolqxU1/9+2RlTX5uYKTnJ5mIE0f2duo
 F4aeAICgLYjw==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="185458936"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="185458936"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 16:23:21 -0700
IronPort-SDR: y6H1briiY6X5e8Ct0n+c9ZWb74lP1ORzh6BLftnomIRyzmNIFA8xgMXubeYF4fCTApEPrsBn/l
 R9AN4Z2u5GLA==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="532177206"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 16:23:20 -0700
Date: Wed, 5 May 2021 16:23:19 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210505232319.GA5087@otc-nc-03>
References: <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
 <20210505222120.GM1370958@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210505222120.GM1370958@nvidia.com>
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

On Wed, May 05, 2021 at 07:21:20PM -0300, Jason Gunthorpe wrote:
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

Correct, since we have usage with ENQCMD, its more like

- Give me a PASID1 (not attached to any RID)
- Bind/attach PASID1 with RID1
- Bind/attach PASID1 with RID2

and ENQCMD isn't just for Intel, with the DMWr spec in PCI, it brings it to
all devices as long as routing is supported by interim switches and such.

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

We do have a RID involvement with PASID always for security. Every RID has
its own PASID table, but the PASID name space is global. 

So if you have RID1 associated with PASID1, another RID2 doesn't have the
PASID1 in its PASID table. Until when the app binds PASID1 with RID2 as
well. Then you have PASID1 plumbed in the PASID table for RID2.

Is this what you refer to for security? 


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

Like I mentioned, this isn't just Intel going forward. The specs are public
in PCIe. I just can't comment which other vendors are adopting it.

> 
> I would advise making the "attach a global PASID to this IOASID"
> operation explicit and opt into for case that actually need it.
> 
> Which implies the API to the iommu driver should be more like:
> 
>   'assign an IOASID to this RID and return the PASID'
>   'reserve a PASID from every RID'

I don't think this has any decent change of success. Its rather round about
way to get a global PASID namespace.

>   'assign an IOASID to this RID and use this specific PASID'

This seems a bit complicated. Another way to specify this.

- IOASID is a logical construct to specify a page table.
- You can bind a global PASID to an IOASID

We aren't loosing any security by using a global PASID name space. 
Until the application asks for it, that is not bound to any other RID without an explicit
request.


-- 
Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
