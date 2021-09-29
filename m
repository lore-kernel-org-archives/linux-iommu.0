Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A5EC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 19:33:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7996128E
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 19:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B7996128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5620083F26;
	Wed, 29 Sep 2021 19:33:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zmqzZGP4cWu1; Wed, 29 Sep 2021 19:33:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5312983F23;
	Wed, 29 Sep 2021 19:33:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EDCEC0011;
	Wed, 29 Sep 2021 19:33:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C7ABC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 19:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC3F760E75
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 19:33:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CUOladRMS3So for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 19:33:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F19660E6D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 19:33:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="225094448"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; d="scan'208";a="225094448"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 12:33:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; d="scan'208";a="554969057"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 12:33:39 -0700
Date: Wed, 29 Sep 2021 12:37:19 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20210929123437.721991dc@jacob-builder>
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar, 
 Sanjay K" <sanjay.k.kumar@intel.com>, mike.campin@intel.com,
 Thomas Gleixner <tglx@linutronix.de>
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

Hi,

Just to follow up on what we discussed during LPC VFIO/IOMMU/PCI MC.
https://linuxplumbersconf.org/event/11/contributions/1021/
The key takeaways are:
1. Addressing mode selections (PA, IOVA, and KVA) should be a policy
decision *not* to be made by device drivers. This implies that it is up to
the platform code or user (via some sysfs knobs) to decide what is the best
for each device. Drivers should not be aware of what addressing modes is
returned by DMA API.

2. DMA APIs can be extended to support DMA request with PASID. 

3. Performance benefit of using KVA (shared) should be demonstrated. Though
the saving of IOTLB flush over IOVA is conceivable.

#1 could be done in platform IOMMU code when devices are attached to their
default domains. E.g. if the device is trusted, it can operate at shared
KVA mode.

For #2, it seems we can store the kernel PASID in struct device. This will
preserve the DMA API interface while making it PASID capable. Essentially,
each PASID capable device would have two special global PASIDs: 
	- PASID 0 for DMA request w/o PASID, aka RID2PASID
	- PASID 1 (randomly selected) for in-kernel DMA request w/ PASID

Both PASID 0 and 1 will always point to the same page table. I.e. same
addressing mode, IOVA or KVA.

For devices does not support PASID, there is no change. For devices can do
both DMA w/ and w/o PASID, the IOTLB invalidation would include both PASIDs.

By embedding PASID in struct device, it also avoided changes in upper level
APIs. DMA engine API can continue to give out channels without knowing
whether PASID is used or not. The accelerator drivers that does work
submission can retrieve PASID from struct device.

Thoughts?

Thanks for the review and feedback at LPC!

Jacob

On Tue, 21 Sep 2021 13:29:34 -0700, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> Hi Joerg/Jason/Christoph et all,
> 
> The current in-kernel supervisor PASID support is based on the SVM/SVA
> machinery in sva-lib. Kernel SVA is achieved by extending a special flag
> to indicate the binding of the device and a page table should be performed
> on init_mm instead of the mm of the current process.Page requests and
> other differences between user and kernel SVA are handled as special
> cases.
> 
> This unrestricted binding with the kernel page table is being challenged
> for security and the convention that in-kernel DMA must be compatible with
> DMA APIs.
> (https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/)
> There is also the lack of IOTLB synchronization upon kernel page table
> updates.
> 
> This patchset is trying to address these concerns by having an explicit
> DMA API compatible model while continue to support in-kernel use of DMA
> requests with PASID. Specifically, the following DMA-IOMMU APIs are
> introduced:
> 
> int iommu_dma_pasid_enable/disable(struct device *dev,
> 				   struct iommu_domain **domain,
> 				   enum iommu_dma_pasid_mode mode);
> int iommu_map/unmap_kva(struct iommu_domain *domain,
> 			void *cpu_addr,size_t size, int prot);
> 
> The following three addressing modes are supported with example API usages
> by device drivers.
> 
> 1. Physical address (bypass) mode. Similar to DMA direct where trusted
> devices can DMA pass through IOMMU on a per PASID basis.
> Example:
> 	pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_BYPASS);
> 	/* Use the returning PASID and PA for work submission */
> 
> 2. IOVA mode. DMA API compatible. Map a supervisor PASID the same way as
> the PCI requester ID (RID)
> Example:
> 	pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_IOVA);
> 	/* Use the PASID and DMA API allocated IOVA for work submission */
> 
> 3. KVA mode. New kva map/unmap APIs. Support fast and strict sub-modes
> transparently based on device trustfulness.
> Example:
> 	pasid = iommu_dma_pasid_enable(dev, &domain, IOMMU_DMA_PASID_KVA);
> 	iommu_map_kva(domain, &buf, size, prot);
> 	/* Use the returned PASID and KVA to submit work */
> Where:
> 	Fast mode: Shared CPU page tables for trusted devices only
> 	Strict mode: IOMMU domain returned for the untrusted device to
> 	replicate KVA-PA mapping in IOMMU page tables.
> 
> On a per device basis, DMA address and performance modes are enabled by
> the device drivers. Platform information such as trustability, user
> command line input (not included in this set) could also be taken into
> consideration (not implemented in this RFC).
> 
> This RFC is intended to communicate the API directions. Little testing is
> done outside IDXD and DMA engine tests.
> 
> For PA and IOVA modes, the implementation is straightforward and tested
> with Intel IDXD driver. But several opens remain in KVA fast mode thus
> not tested: 1. Lack of IOTLB synchronization, kernel direct map alias can
> be updated as a result of module loading/eBPF load. Adding kernel mmu
> notifier? 2. The use of the auxiliary domain for KVA map, will aux domain
> stay in the long term? Is there another way to represent sub-device granu
> isolation? 3. Is limiting the KVA sharing to the direct map range
> reasonable and practical for all architectures?
> 
> 
> Many thanks to Ashok Raj, Kevin Tian, and Baolu who provided feedback and
> many ideas in this set.
> 
> Thanks,
> 
> Jacob
> 
> Jacob Pan (7):
>   ioasid: reserve special PASID for in-kernel DMA
>   dma-iommu: Add API for DMA request with PASID
>   iommu/vt-d: Add DMA w/ PASID support for PA and IOVA
>   dma-iommu: Add support for DMA w/ PASID in KVA
>   iommu/vt-d: Add support for KVA PASID mode
>   iommu: Add KVA map API
>   dma/idxd: Use dma-iommu PASID API instead of SVA lib
> 
>  drivers/dma/idxd/idxd.h                       |   4 +-
>  drivers/dma/idxd/init.c                       |  36 ++--
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
>  drivers/iommu/dma-iommu.c                     | 123 +++++++++++++-
>  drivers/iommu/intel/iommu.c                   | 154 +++++++++++++++++-
>  drivers/iommu/ioasid.c                        |   2 +
>  drivers/iommu/iommu-sva-lib.c                 |   1 +
>  drivers/iommu/iommu.c                         |  63 +++++++
>  include/linux/dma-iommu.h                     |  14 ++
>  include/linux/intel-iommu.h                   |   7 +-
>  include/linux/ioasid.h                        |   4 +
>  include/linux/iommu.h                         |  13 ++
>  12 files changed, 390 insertions(+), 33 deletions(-)
> 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
