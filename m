Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2375FC433E2
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 22:06:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B19120809
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 22:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B19120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 489E786B7B;
	Tue, 15 Sep 2020 22:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KcQXjbageEkw; Tue, 15 Sep 2020 22:06:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8081F86B83;
	Tue, 15 Sep 2020 22:06:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DC2FC0859;
	Tue, 15 Sep 2020 22:06:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C151BC0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 22:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ABBA186B7F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 22:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qu-9N4ciUq93 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 22:06:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EBE7786AF3
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 22:06:51 +0000 (UTC)
IronPort-SDR: 1YFn8DxKzdSAIwRaS/G45X+F2tx7igSzGK56Mricr71cFnPJG1Sxsk7KwSTQJpP2Vg5/W0Bvvb
 8vxsO1v6vuaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="156745600"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="156745600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 15:06:50 -0700
IronPort-SDR: EfDWGJzMGmk10dgnAirVuFw17Os1O9V/Z1BF1Y8pAKaT0+yY+JGcISidpqtFqTI4uX9m7sRxzv
 NzGPvFeRi0Xw==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="302326059"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 15:06:50 -0700
Date: Tue, 15 Sep 2020 15:08:51 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200915150851.76436ca1@jacob-builder>
In-Reply-To: <20200915184510.GB1573713@nvidia.com>
References: <20200914134738.GX904879@nvidia.com>
 <20200914162247.GA63399@otc-nc-03>
 <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home>
 <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home>
 <20200914190057.GM904879@nvidia.com>
 <20200914224438.GA65940@otc-nc-03>
 <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03>
 <20200915184510.GB1573713@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: yi.y.sun@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, jun.j.tian@intel.com,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 Jacon Jun Pan <jacob.jun.pan@intel.com>, hao.wu@intel.com
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

On Tue, 15 Sep 2020 15:45:10 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 15, 2020 at 11:11:54AM -0700, Raj, Ashok wrote:
> > > PASID applies widely to many device and needs to be introduced with a
> > > wide community agreement so all scenarios will be supportable.  
> > 
> > True, reading some of the earlier replies I was clearly confused as I
> > thought you were talking about mdev again. But now that you stay it, you
> > have moved past mdev and its the PASID interfaces correct?  
> 
> Yes, we agreed mdev for IDXD at LPC, didn't talk about PASID.
> 
> > For the native user applications have just 1 PASID per
> > process. There is no need for a quota management.  
> 
> Yes, there is. There is a limited pool of HW PASID's. If one user fork
> bombs it can easially claim an unreasonable number from that pool as
> each process will claim a PASID. That can DOS the rest of the system.
> 
> If PASID DOS is a worry then it must be solved at the IOMMU level for
> all user applications that might trigger a PASID allocation. VFIO is
> not special.
> 
> > IIUC, you are asking that part of the interface to move to a API
> > interface that potentially the new /dev/sva and VFIO could share? I
> > think the API's for PASID management themselves are generic (Jean's
> > patchset + Jacob's ioasid set management).  
> 
> Yes, the in kernel APIs are pretty generic now, and can be used by
> many types of drivers.
> 
Right, IOMMU UAPIs are not VFIO specific, we pass user pointer to the IOMMU
layer to process.

Similarly for PASID management, the IOASID extensions we are proposing
will handle ioasid_set (groups/pools), quota, permissions, and notifications
in the IOASID core. There is nothing VFIO specific.
https://lkml.org/lkml/2020/8/22/12

> As JasonW kicked this off, VDPA will need all this identical stuff
> too. We already know this, and I think Intel VDPA HW will need it, so
> it should concern you too :)
> 
> A PASID vIOMMU solution sharable with VDPA and VFIO, based on a PASID
> control char dev (eg /dev/sva, or maybe /dev/iommu) seems like a
> reasonable starting point for discussion.
> 
I am not sure what can really be consolidated in /dev/sva. VFIO and VDPA
will have their own kerne-user interfaces anyway for their usage models.
They are just providing the specific transport while sharing generic IOMMU
UAPIs and IOASID management.

As I mentioned PASID management is already consolidated in the IOASID layer,
so for VDPA or other users, it just matter of create its own ioasid_set,
doing allocation.

IOASID is also available to the in-kernel users which does not
need /dev/sva AFAICT. For bare metal SVA, I don't see a need to create this
'floating' state of the PASID when created by /dev/sva. PASID allocation
could happen behind the scene when users need to bind page tables to a
device DMA stream. Security authorization of the PASID is natively enforced
when user try to bind page table, there is no need to pass the FD handle of
the PASID back to the kernel as you suggested earlier.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
