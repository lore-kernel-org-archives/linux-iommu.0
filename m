Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F355C433ED
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 23:43:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C0D61006
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 23:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C0D61006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A524A405E6;
	Wed, 31 Mar 2021 23:43:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8POToUdF4nhR; Wed, 31 Mar 2021 23:43:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 297D34057D;
	Wed, 31 Mar 2021 23:43:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 117F6C000C;
	Wed, 31 Mar 2021 23:43:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AA11C000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 23:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B86A60B8A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 23:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mgcf_Yv866ET for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 23:43:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 753B260681
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 23:43:51 +0000 (UTC)
IronPort-SDR: xKm7l5NLv0bLAGfRvb3cq97nr1D4mRE9s4fC5tWyEyIxBbOW3iv8/UBEkH90mVCJH1WpWOCP/a
 UheAICfkZSXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171530256"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; d="scan'208";a="171530256"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2021 16:43:50 -0700
IronPort-SDR: VRxcxsUEV0sH/4DZfBI5I2LaEnMUx/NQkTnVoC7WXr8JeuKEuNiKMslo/z7SMKRlFQ9KRG92fm
 ptyyNqAhMyTQ==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; d="scan'208";a="379087406"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2021 16:43:50 -0700
Date: Wed, 31 Mar 2021 16:46:21 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210331164621.5f0b0d63@jacob-builder>
In-Reply-To: <20210331123801.GD1463678@nvidia.com>
References: <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132740.GB1403691@nvidia.com>
 <BN6PR11MB40688BB2693A657D411E33C8C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331123801.GD1463678@nvidia.com>
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

On Wed, 31 Mar 2021 09:38:01 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> > > Get rid of the ioasid set.
> > >
> > > Each driver has its own list of allowed ioasids.  
>  [...]  
> 
> The /dev/ioasid FD replaces this security check. By becoming FD
> centric you don't need additional kernel security objects.
> 
> Any process with access to the /dev/ioasid FD is allowed to control
> those PASID. The seperation between VMs falls naturally from the
> seperation of FDs without creating additional, complicated, security
> infrastrucure in the kernel.
> 
> This is why all APIs must be FD focused, and you need to have a
> logical layering of responsibility.
> 
>  Allocate a /dev/ioasid FD
>  Allocate PASIDs inside the FD
>  Assign memory to the PASIDS
> 
>  Open a device FD, eg from VFIO or VDP
>  Instruct the device FD to authorize the device to access PASID A in
>  an ioasid FD
How do we know user provided PASID A was allocated by the ioasid FD?
Shouldn't we validate user input by tracking which PASIDs are allocated by
which ioasid FD? This is one reason why we have ioasid_set and its xarray.

>    * Prior to being authorized the device will have NO access to any
>      PASID
>    * Presenting BOTH the device FD and the ioasid FD to the kernel
>      is the security check. Any process with both FDs is allowed to
>      make the connection. This is normal Unix FD centric thinking.
> 
> > > Register a ioasid in the driver's list by passing the fd and ioasid #
> > >  
> > 
> > The fd here is a device fd. Am I right?   
> 
> It would be the vfio_device FD, for instance, and a VFIO IOCTL.
> 
> > If yes, your idea is ioasid is allocated via /dev/ioasid and
> > associated with device fd via either VFIO or vDPA ioctl. right?
> > sorry I may be asking silly questions but really need to ensure we
> > are talking in the same page.  
> 
> Yes, this is right
> 
> > > No listening to events. A simple understandable security model.  
> > 
> > For this suggestion, I have a little bit concern if we may have A-B/B-A
> > lock sequence issue since it requires the /dev/ioasid (if it supports)
> > to call back into VFIO/VDPA to check if the ioasid has been registered
> > to device FD and record it in the per-device list. right? Let's have
> > more discussion based on the skeleton sent by Kevin.  
> 
> Callbacks would be backwards.
> 
> User calls vfio with vfio_device fd and dev/ioasid fd
> 
> VFIO extracts some kernel representation of the ioasid from the ioasid
> fd using an API
> 
This lookup API seems to be asking for per ioasid FD storage array. Today,
the ioasid_set is per mm and contains a Xarray. Since each VM, KVM can only
open one ioasid FD, this per FD array would be equivalent to the per mm
ioasid_set, right?

> VFIO does some kernel call to IOMMU/IOASID layer that says 'tell the
> IOMMU that this PCI device is allowed to use this PASID'
> 
Would it be redundant to what iommu_uapi_sva_bind_gpasid() does? I thought
the idea is to use ioasid FD IOCTL to issue IOMMU uAPI calls. Or we can
skip this step for now and wait for the user to do SVA bind.

> VFIO mdev drivers then record that the PASID is allowed in its own
> device specific struct for later checking during other system calls.


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
