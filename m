Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AADC433E2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 00:22:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E99A2078D
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 00:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E99A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 43107868E1;
	Wed, 16 Sep 2020 00:22:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEEXjk_wNaw9; Wed, 16 Sep 2020 00:22:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8C505868B5;
	Wed, 16 Sep 2020 00:22:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CCAFC0859;
	Wed, 16 Sep 2020 00:22:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68A71C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 00:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5E30786CD2
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 00:22:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MskNsgWXx+mv for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 00:22:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 51F5786CCD
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 00:22:32 +0000 (UTC)
IronPort-SDR: CpgawZsBtzTN1VD6ftwZvcVCZSwV0yLhJTNpd+9lq0RLNyC77PGp+SZjnBVh+qLMC4iMY/S8le
 +ZC7uMSHvNpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="156790097"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="156790097"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 17:22:31 -0700
IronPort-SDR: 60HH/dImos/iY7LohpWZz4y8x3C8VG9rPdO3eL1taxgspGYLfX4fCfXjvDmuQc8V3jmK4hl+B3
 EEfmLShfeiFw==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="306845533"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost)
 ([10.212.71.163])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 17:22:29 -0700
Date: Tue, 15 Sep 2020 17:22:26 -0700
From: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200915171319.00003f59@linux.intel.com>
In-Reply-To: <20200915235126.GK1573713@nvidia.com>
References: <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home>
 <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home>
 <20200914190057.GM904879@nvidia.com>
 <20200914224438.GA65940@otc-nc-03>
 <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03>
 <20200915184510.GB1573713@nvidia.com>
 <20200915150851.76436ca1@jacob-builder>
 <20200915235126.GK1573713@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Cc: yi.y.sun@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, jun.j.tian@intel.com,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, hao.wu@intel.com
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
On Tue, 15 Sep 2020 20:51:26 -0300, Jason Gunthorpe <jgg@nvidia.com>
wrote:

> On Tue, Sep 15, 2020 at 03:08:51PM -0700, Jacob Pan wrote:
> > > A PASID vIOMMU solution sharable with VDPA and VFIO, based on a
> > > PASID control char dev (eg /dev/sva, or maybe /dev/iommu) seems
> > > like a reasonable starting point for discussion.  
> > 
> > I am not sure what can really be consolidated in /dev/sva.   
> 
> More or less, everything in this patch. All the manipulations of PASID
> that are required for vIOMMU use case/etc. Basically all PASID control
> that is not just a 1:1 mapping of the mm_struct.
> 
> > will have their own kerne-user interfaces anyway for their usage
> > models. They are just providing the specific transport while
> > sharing generic IOMMU UAPIs and IOASID management.  
> 
> > As I mentioned PASID management is already consolidated in the
> > IOASID layer, so for VDPA or other users, it just matter of create
> > its own ioasid_set, doing allocation.  
> 
> Creating the PASID is not the problem, managing what the PASID maps to
> is the issue. That is all uAPI that we don't really have today.
> 
> > IOASID is also available to the in-kernel users which does not
> > need /dev/sva AFAICT. For bare metal SVA, I don't see a need to
> > create this 'floating' state of the PASID when created by /dev/sva.
> > PASID allocation could happen behind the scene when users need to
> > bind page tables to a device DMA stream.  
> 
> My point is I would like to see one set of uAPI ioctls to bind page
> tables. I don't want to have VFIO, VDPA, etc, etc uAPIs to do the
> exact same things only slightly differently.
> 
Got your point. I am not familiar with VDPA but for VFIO UAPI, it is
very thin, mostly passthrough IOMMU UAPI struct as opaque data.

> If user space wants to bind page tables, create the PASID with
> /dev/sva, use ioctls there to setup the page table the way it wants,
> then pass the now configured PASID to a driver that can use it. 
> 
Are we talking about bare metal SVA? If so, I don't see the need for
userspace to know there is a PASID. All user space need is that my
current mm is bound to a device by the driver. So it can be a one-step
process for user instead of two.

> Driver does not do page table binding. Do not duplicate all the
> control plane uAPI in every driver.
> 
> PASID managment and binding is seperated from the driver(s) that are
> using the PASID.
> 
Why separate? Drivers need to be involved in PASID life cycle
management. For example, when tearing down a PASID, the driver needs to
stop DMA, IOMMU driver needs to unbind, etc. If driver is the control
point, then things are just in order. I am referring to bare metal SVA.

For guest SVA, I agree that binding is separate from PASID allocation.
Could you review this doc. in terms of life cycle?
https://lkml.org/lkml/2020/8/22/13

My point is that /dev/sda has no value for bare metal SVA, we are just
talking about if guest SVA UAPIs can be consolidated. Or am I missing
something?

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
