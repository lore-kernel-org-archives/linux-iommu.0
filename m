Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BA6C433B4
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 16:22:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39C861132
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 16:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39C861132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91E4F607ED;
	Mon, 10 May 2021 16:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0DaiQInB19po; Mon, 10 May 2021 16:22:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45D00605ED;
	Mon, 10 May 2021 16:22:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 189E1C000D;
	Mon, 10 May 2021 16:22:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4F71C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 16:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CFD283DF3
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 16:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x82LxRGrupVJ for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 16:22:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4B8583DAD
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 16:22:25 +0000 (UTC)
IronPort-SDR: hjtPsSXO0m1d2GGPwjqMsBE6IzsFQyHqWuBZkYcMCXL9w59GZ/2uKx3qpWjY4ZsdscWs0B/HZN
 KtRG0/X6/Iqw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199283271"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="199283271"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 09:22:21 -0700
IronPort-SDR: PSDIYCv+v5/565b1johrUPvDffu7yaTeziOG+Xchpr2KFyq0xNo9Jj57VHKOCNE78gJgfRcsiE
 Zc6vhCpTZawQ==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="461362383"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 09:22:13 -0700
Date: Mon, 10 May 2021 09:22:12 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210510162212.GB90095@otc-nc-03>
References: <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <20210510152502.GA90095@otc-nc-03>
 <20210510153111.GB1002214@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210510153111.GB1002214@nvidia.com>
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

On Mon, May 10, 2021 at 12:31:11PM -0300, Jason Gunthorpe wrote:
> On Mon, May 10, 2021 at 08:25:02AM -0700, Raj, Ashok wrote:
> 
> > Global PASID doesn't break anything, but giving that control to vIOMMU
> > doesn't seem right. When we have mixed uses cases like hardware that
> > supports shared wq and SRIOV devices that need PASIDs we need to 
> > comprehend how they will work without having a backend to migrate PASIDs 
> > to new destination.
> 
> Why wouldn't there be a backend? SRIOV live migration is a real thing
> now (see Max's VFIO patches). The PASID space of the entire dedicated
> RID needs to be migratable, which means the destination vIOMMU must be
> able to program its local hardware with the same PASID numbers and any
> kind of global PASID scheme at all will interfere with it.

The way I'm imagining it works is as follows. We have 2 types of platforms.
Let me know if i missed something.

- no shared wq, meaning RID local PASID allocation is all that's needed.
  Say platform type p1
- Shared WQ configurations that require global PASIDs.
  Say platform type p2

vIOMMU might have a capability to indicate if vIOMMU has a PASID allocation
capability. If there is none, guest is free to obtain its own PASID per
RID since they are fully isolated. For p1 type platforms this should work.
Since there is no Qemu interface even required or /dev/iommu for that
instance. Guest kernel can manage it fully per-RID based.

Platform type p2 that has both SIOV (with enqcmd) and SRIOV that requires
PASID. My thought was to reserve say some number of PASID's for per-RID
use. When you request a RID local you get PASID in that range. When you ask
for global, you get in the upper PASID range. 

Say 0-4k is reserved for any RID local allocation. This is also the guest
PASID range.  4k->2^19 are for shared WQ. (I'm not implying the size, but 
just for discussion sake that we need a separation.)

Those vIOMMU's will have a capability that it supports PASID allocation
interface. When you allocate you can say what type of PASID you need
(shared vs local) and Qemu will obtain either within the local range, or in
the shared range. When they are allocated in the shared range, you still
end up using one in guest PASID range, but mapped to a different
host-pasid using the VMCS like PASID redirection per-guest (not-perRID).

Only the shared allocation requires /dev/iommu interface. All allocation in
the guest range is fully in Qemu control.

For supporting migration, the target also needs to have this capability for
migration. 
> 
> > When we have both SRIOV and shared WQ exposed to the same guest, we 
> > do have an issue. The simplest way that I thought was to have a guest 
> > and host PASID separation.  Where the guest has its own PASID  space 
> > and host has its own carved out.  Guest can do what ever it wants within 
> > that allocated space without fear of any collition with any other device. 
> 
> And how do you reliably migrate if the target kernel has a PASID
> already allocated in that range?

For any shared range, remember there is a mapping table. And since those
ranges are always reserved in the new host it isn't a problem. For shared
WQ that requires a PASID remapping to new host PASID, the VMCS remapping
per guest that does gPASID->hPASID does this job. So the guest PASID
remains unchanged. 

Does this make sense? 

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
