Return-Path: <SRS0=zRLl=YR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA901CA9EAF
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 12:52:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8658D20856
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 12:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8658D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5CA421544;
	Thu, 24 Oct 2019 12:52:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BB2A7153A
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 12:52:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 299C014D
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 12:52:51 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Oct 2019 05:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="201464798"
Received: from iov.bj.intel.com ([10.238.145.67])
	by orsmga003.jf.intel.com with ESMTP; 24 Oct 2019 05:52:47 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com,
	eric.auger@redhat.com
Subject: [RFC v2 0/3] vfio: support Shared Virtual Addressing
Date: Thu, 24 Oct 2019 08:26:20 -0400
Message-Id: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
	jean-philippe.brucker@arm.com, jun.j.tian@intel.com,
	iommu@lists.linux-foundation.org, yi.y.sun@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
platforms allow address space sharing between device DMA and applications.
SVA can reduce programming complexity and enhance security.
This series is intended to expose SVA capability to VMs. i.e. shared guest
application address space with passthru devices. The whole SVA virtualization
requires QEMU/VFIO/IOMMU changes. This series includes the VFIO changes, for
QEMU and IOMMU changes, they are in separate series (listed in the "Related
series").

The high-level architecture for SVA virtualization is as below:

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest process CR3, FL only|
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush -
    '-------------'                       |
    |             |                       V
    |             |                CR3 in GPA
    '-------------'
Guest
------| Shadow |--------------------------|--------
      v        v                          v
Host
    .-------------.  .----------------------.
    |   pIOMMU    |  | Bind FL for GVA-GPA  |
    |             |  '----------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.------------------------------.
    |             |   |SL for GPA-HPA, default domain|
    |             |   '------------------------------'
    '-------------'
Where:
 - FL = First level/stage one page tables
 - SL = Second level/stage two page tables

There are roughly three parts in this patchset which are
corresponding to the basic vSVA support for PCI device
assignment
 1. vfio support for PASID allocation and free from VMs
 2. vfio support for guest PASID binding from VMs
 3. vfio support for IOMMU cache invalidation from VMs

The complete vSVA upstream patches are divided into three phases:
    1. Common APIs and PCI device direct assignment
    2. Page Request Services (PRS) support
    3. Mediated device assignment

This RFC patchset is aiming for the phase 1, and works together with the
VT-d driver[1] changes and QEMU changes[2]. Complete set for vSVA can be
found in:
https://github.com/jacobpan/linux.git:siov_sva.

And this patchset doesn't include the patch to expose PASID capability to
guest. This is expected to be in another series.

Related series:
[1] [PATCH v6 00/10] Nested Shared Virtual Address (SVA) VT-d support:
https://lkml.org/lkml/2019/10/22/953
<This series is based on this kernel series from Jacob Pan>

[2] [RFC v2 00/20] intel_iommu: expose Shared Virtual Addressing to VM
from Yi Liu

Changelog:
	- RFC v1 -> v2:
	  Dropped vfio: VFIO_IOMMU_ATTACH/DETACH_PASID_TABLE.
	  RFC v1: https://patchwork.kernel.org/cover/11033699/

Liu Yi L (3):
  vfio: VFIO_IOMMU_CACHE_INVALIDATE
  vfio/type1: VFIO_IOMMU_PASID_REQUEST(alloc/free)
  vfio/type1: bind guest pasid (guest page tables) to host

 drivers/vfio/vfio_iommu_type1.c | 305 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  82 +++++++++++
 2 files changed, 387 insertions(+)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
