Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A749C433E2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 18:21:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAEC221E3
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 18:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAEC221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5AA9387098;
	Wed, 16 Sep 2020 18:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MYS7kbUheqbF; Wed, 16 Sep 2020 18:21:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8B05886246;
	Wed, 16 Sep 2020 18:21:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C753C0859;
	Wed, 16 Sep 2020 18:21:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AF9AC0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 18:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2934B86B5B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 18:21:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lCpYghBDcJPe for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 18:21:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 80ECC86B54
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 18:21:14 +0000 (UTC)
IronPort-SDR: yedFGXkvupG/baNI5Qb7jhrAYzFGlJKeI3Dx+sC89NUaWdi/ygHHEuyd6PtINOm3w+GN9hSRal
 BC8zQFjZXlCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="159591686"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; d="scan'208";a="159591686"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 11:21:13 -0700
IronPort-SDR: juzWmbnvtkvHCD/V5EkjPIxuDdEgR3cVbtJpmnnFPdYrQM+3YPyUTVV5beblXc5j8JzJg31a0b
 oGAsbrgkE0BQ==
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; d="scan'208";a="343994210"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost)
 ([10.213.174.80])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 11:21:12 -0700
Date: Wed, 16 Sep 2020 11:21:10 -0700
From: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200916112110.000024ee@intel.com>
In-Reply-To: <20200916170113.GD3699@nvidia.com>
References: <20200914190057.GM904879@nvidia.com>
 <20200914224438.GA65940@otc-nc-03>
 <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03>
 <20200915184510.GB1573713@nvidia.com>
 <20200915150851.76436ca1@jacob-builder>
 <20200915235126.GK1573713@nvidia.com>
 <20200915171319.00003f59@linux.intel.com>
 <20200916150754.GE6199@nvidia.com>
 <20200916163343.GA76252@otc-nc-03>
 <20200916170113.GD3699@nvidia.com>
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
On Wed, 16 Sep 2020 14:01:13 -0300, Jason Gunthorpe <jgg@nvidia.com>
wrote:

> On Wed, Sep 16, 2020 at 09:33:43AM -0700, Raj, Ashok wrote:
> > On Wed, Sep 16, 2020 at 12:07:54PM -0300, Jason Gunthorpe wrote:  
> > > On Tue, Sep 15, 2020 at 05:22:26PM -0700, Jacob Pan (Jun) wrote:  
> > > > > If user space wants to bind page tables, create the PASID with
> > > > > /dev/sva, use ioctls there to setup the page table the way it
> > > > > wants, then pass the now configured PASID to a driver that
> > > > > can use it.   
> > > > 
> > > > Are we talking about bare metal SVA?   
> > > 
> > > What a weird term.  
> > 
> > Glad you noticed it at v7 :-) 
> > 
> > Any suggestions on something less weird than 
> > Shared Virtual Addressing? There is a reason why we moved from SVM
> > to SVA.  
> 
> SVA is fine, what is "bare metal" supposed to mean?
> 
What I meant here is sharing virtual address between DMA and host
process. This requires devices perform DMA request with PASID and use
IOMMU first level/stage 1 page tables.
This can be further divided into 1) user SVA 2) supervisor SVA (sharing
init_mm)

My point is that /dev/sva is not useful here since the driver can
perform PASID allocation while doing SVA bind.

> PASID is about constructing an arbitary DMA IOVA map for PCI-E
> devices, being able to intercept device DMA faults, etc.
> 
An arbitrary IOVA map does not need PASID. In IOVA, you do map/unmap
explicitly, why you need to handle IO page fault?

To me, PASID identifies an address space that is associated with a
mm_struct.

> SVA is doing DMA IOVA 1:1 with the mm_struct CPU VA. DMA faults
> trigger the same thing as CPU page faults. If is it not 1:1 then there
> is no "shared". When SVA is done using PCI-E PASID it is "PASID for
> SVA". Lots of existing devices already have SVA without PASID or
> IOMMU, so lets not muddy the terminology.
> 
I agree. This conversation is about "PASID for SVA" not "SVA without
PASID"


> vPASID/vIOMMU is allowing a guest to control the DMA IOVA map and
> manipulate the PASIDs.
> 
> vSVA is when a guest uses a vPASID to provide SVA, not sure this is
> an informative term.
> 
I agree.

> This particular patch series seems to be about vPASID/vIOMMU for
> vfio-mdev vs the other vPASID/vIOMMU patch which was about vPASID for
> vfio-pci.
> 
Yi can correct me but this set is is about VFIO-PCI, VFIO-mdev will be
introduced later.

> > > > If so, I don't see the need for userspace to know there is a
> > > > PASID. All user space need is that my current mm is bound to a
> > > > device by the driver. So it can be a one-step process for user
> > > > instead of two.  
> > > 
> > > You've missed the entire point of the conversation, VDPA already
> > > needs more than "my current mm is bound to a device"  
> > 
> > You mean current version of vDPA? or a potential future version of
> > vDPA?  
> 
> Future VDPA drivers, it was made clear this was important to Intel
> during the argument about VDPA as a mdev.
> 
> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
