Return-Path: <SRS0=LdVQ=KA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CC9C433B4
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 17:20:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56641611AC
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 17:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56641611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02A8C405D6;
	Wed,  5 May 2021 17:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wZuQaWVkBg-k; Wed,  5 May 2021 17:20:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2B99405D3;
	Wed,  5 May 2021 17:20:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 819ECC000E;
	Wed,  5 May 2021 17:20:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8080BC0001
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 17:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6180B60A6E
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 17:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fYcWShx_ktWh for <iommu@lists.linux-foundation.org>;
 Wed,  5 May 2021 17:20:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9140C60A6D
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 17:20:10 +0000 (UTC)
IronPort-SDR: uQpFPsIOQap4Jd5s4/AqDhER9sXFFXkZGh3NBYkqsOzkjDiMBmfVl2XRmVCbxwNm/iKhgWmHkL
 O+RFCQWOWL0g==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="198315623"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="198315623"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 10:20:09 -0700
IronPort-SDR: iY7VJJJQFkvN2izb7iyCSnux/+J5KjzfQzVOdrkOuIj75vXIEDSM2Pj2eu6Skcs8Y/rUFmt4UD
 Miwr4xTTFJpw==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="433926176"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 10:20:09 -0700
Date: Wed, 5 May 2021 10:22:59 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210505102259.044cafdf@jacob-builder>
In-Reply-To: <20210504231530.GE1370958@nvidia.com>
References: <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
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

Hi Jason,

On Tue, 4 May 2021 20:15:30 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 04, 2021 at 03:11:54PM -0700, Jacob Pan wrote:
> 
> > > It is a weird way to use xarray to have a structure which
> > > itself is just a wrapper around another RCU protected structure.
> > > 
> > > Make the caller supply the ioasid_data memory, embedded in its own
> > > element, get rid of the void * and rely on XA_ZERO_ENTRY to hold
> > > allocated but not active entries.
> > >   
> > Let me try to paraphrase to make sure I understand. Currently
> > struct ioasid_data is private to the iasid core, its memory is
> > allocated by the ioasid core.
> > 
> > You are suggesting the following:
> > 1. make struct ioasid_data public
> > 2. caller allocates memory for ioasid_data, initialize it then pass it
> > to ioasid_alloc to store in the xarray
> > 3. caller will be responsible for setting private data inside
> > ioasid_data and do call_rcu after update if needed.  
> 
> Basically, but you probably won't need a "private data" once the
> caller has this struct as it can just embed it in whatever larger
> struct makes sense for it and use container_of/etc
> 
that makes sense. thanks!

> I didn't look too closely at the whole thing though. Honestly I'm a
> bit puzzled why we need a pluggable global allocator framework.. The
> whole framework went to some trouble to isolate everything into iommu
> drivers then that whole design is disturbed by this global thing.
> 
Global and pluggable are for slightly separate reasons.
- We need global PASID on VT-d in that we need to support shared
workqueues (SWQ). E.g. One SWQ can be wrapped into two mdevs then assigned
to two VMs. Each VM uses its private guest PASID to submit work but
each guest PASID must be translated to a global (system-wide) host PASID to
avoid conflict. Also, since PASID table storage is per PF, if two mdevs of
the same PF are assigned to different VMs, the PASIDs must be unique.

- The pluggable allocator is to support the option where the guest PASIDs
are allocated by the hypervisor. Let it be the same as the host PASID or
some arbitrary number cooked up by the hypervisor but backed by a host HW
PASID. VT-d spec has this virtual command interface that requires the guest
to use it instead of allocating from the guest ioasid xarray. This is the
reason why it has to go down to iommu vendor driver. I guess that is what
you meant by "went to some trouble to isolate everything into iommu"?

For ARM, since the guest owns the per device PASID table. There is no need
to allocate PASIDs from the host nor the hypervisor. Without SWQ, there is
no need for global PASID/SSID either. So PASID being global for ARM is for
simplicity in case of host PASID/SSID.



> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
