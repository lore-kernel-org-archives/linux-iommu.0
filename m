Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92150C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CF16105A
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48CF16105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01F2060A3B;
	Wed, 22 Sep 2021 05:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UlD51-2zSq2d; Wed, 22 Sep 2021 05:13:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C1C49607D7;
	Wed, 22 Sep 2021 05:13:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5993C000F;
	Wed, 22 Sep 2021 05:13:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39D3DC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21DB440428
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Vw5HryMzmaP for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 05:13:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9528400F5
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:11 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="287187642"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="287187642"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 22:13:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="550107660"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:10 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>
Subject: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Date: Tue, 21 Sep 2021 13:29:34 -0700
Message-Id: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, mike.campin@intel.com
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

Hi Joerg/Jason/Christoph et all,

The current in-kernel supervisor PASID support is based on the SVM/SVA
machinery in sva-lib. Kernel SVA is achieved by extending a special flag
to indicate the binding of the device and a page table should be performed
on init_mm instead of the mm of the current process.Page requests and other
differences between user and kernel SVA are handled as special cases.

This unrestricted binding with the kernel page table is being challenged
for security and the convention that in-kernel DMA must be compatible with
DMA APIs.
(https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/)
There is also the lack of IOTLB synchronization upon kernel page table updates.

This patchset is trying to address these concerns by having an explicit DMA
API compatible model while continue to support in-kernel use of DMA requests
with PASID. Specifically, the following DMA-IOMMU APIs are introduced:

int iommu_dma_pasid_enable/disable(struct device *dev,
				   struct iommu_domain **domain,
				   enum iommu_dma_pasid_mode mode);
int iommu_map/unmap_kva(struct iommu_domain *domain,
			void *cpu_addr,size_t size, int prot);

The following three addressing modes are supported with example API usages
by device drivers.

1. Physical address (bypass) mode. Similar to DMA direct where trusted devices
can DMA pass through IOMMU on a per PASID basis.
Example:
	pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_BYPASS);
	/* Use the returning PASID and PA for work submission */

2. IOVA mode. DMA API compatible. Map a supervisor PASID the same way as the
PCI requester ID (RID)
Example:
	pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_IOVA);
	/* Use the PASID and DMA API allocated IOVA for work submission */

3. KVA mode. New kva map/unmap APIs. Support fast and strict sub-modes
transparently based on device trustfulness.
Example:
	pasid = iommu_dma_pasid_enable(dev, &domain, IOMMU_DMA_PASID_KVA);
	iommu_map_kva(domain, &buf, size, prot);
	/* Use the returned PASID and KVA to submit work */
Where:
	Fast mode: Shared CPU page tables for trusted devices only
	Strict mode: IOMMU domain returned for the untrusted device to
	replicate KVA-PA mapping in IOMMU page tables.

On a per device basis, DMA address and performance modes are enabled by the
device drivers. Platform information such as trustability, user command line
input (not included in this set) could also be taken into consideration (not
implemented in this RFC).

This RFC is intended to communicate the API directions. Little testing is done
outside IDXD and DMA engine tests.

For PA and IOVA modes, the implementation is straightforward and tested with
Intel IDXD driver. But several opens remain in KVA fast mode thus not tested:
1. Lack of IOTLB synchronization, kernel direct map alias can be updated as a
result of module loading/eBPF load. Adding kernel mmu notifier?
2. The use of the auxiliary domain for KVA map, will aux domain stay in the
long term? Is there another way to represent sub-device granu isolation?
3. Is limiting the KVA sharing to the direct map range reasonable and
practical for all architectures?


Many thanks to Ashok Raj, Kevin Tian, and Baolu who provided feedback and
many ideas in this set.

Thanks,

Jacob

Jacob Pan (7):
  ioasid: reserve special PASID for in-kernel DMA
  dma-iommu: Add API for DMA request with PASID
  iommu/vt-d: Add DMA w/ PASID support for PA and IOVA
  dma-iommu: Add support for DMA w/ PASID in KVA
  iommu/vt-d: Add support for KVA PASID mode
  iommu: Add KVA map API
  dma/idxd: Use dma-iommu PASID API instead of SVA lib

 drivers/dma/idxd/idxd.h                       |   4 +-
 drivers/dma/idxd/init.c                       |  36 ++--
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
 drivers/iommu/dma-iommu.c                     | 123 +++++++++++++-
 drivers/iommu/intel/iommu.c                   | 154 +++++++++++++++++-
 drivers/iommu/ioasid.c                        |   2 +
 drivers/iommu/iommu-sva-lib.c                 |   1 +
 drivers/iommu/iommu.c                         |  63 +++++++
 include/linux/dma-iommu.h                     |  14 ++
 include/linux/intel-iommu.h                   |   7 +-
 include/linux/ioasid.h                        |   4 +
 include/linux/iommu.h                         |  13 ++
 12 files changed, 390 insertions(+), 33 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
