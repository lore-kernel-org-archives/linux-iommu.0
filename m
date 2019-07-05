Return-Path: <SRS0=qSbQ=VD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D69C0650E
	for <iommu@archiver.kernel.org>; Sat,  6 Jul 2019 11:27:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C20B20989
	for <iommu@archiver.kernel.org>; Sat,  6 Jul 2019 11:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C20B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 164DE1C3D;
	Sat,  6 Jul 2019 11:27:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id ED7D31C2F
	for <iommu@lists.linux-foundation.org>;
	Sat,  6 Jul 2019 11:23:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6D04A87C
	for <iommu@lists.linux-foundation.org>;
	Sat,  6 Jul 2019 11:23:13 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Jul 2019 04:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,458,1557212400"; d="scan'208";a="158693772"
Received: from yiliu-dev.bj.intel.com ([10.238.156.139])
	by orsmga008.jf.intel.com with ESMTP; 06 Jul 2019 04:23:09 -0700
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: alex.williamson@redhat.com
Subject: [RFC v1 0/4] vfio: support Shared Virtual Addressing
Date: Fri,  5 Jul 2019 19:06:08 +0800
Message-Id: <1562324772-3084-1-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
	jean-philippe.brucker@arm.com, iommu@lists.linux-foundation.org,
	yi.y.sun@intel.com, jun.j.tian@intel.com
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

There are roughly three parts:
1. vfio support for PASID allocation and free from VMs
2. vfio support for guest PASID binding from VMs
3. vfio support for IOMMU cache invalidation from VMs

Related series:
[1] [PATCH v4 00/22]  Shared virtual address IOMMU and VT-d support:
https://lwn.net/Articles/790820/
<My series is based on this kernel series from Jacob Pan>

[2] [RFC v1 00/18] intel_iommu: expose Shared Virtual Addressing to VM
from Yi Liu

This work is based on collaboration with other developers on the IOMMU
mailing list. Notably,

[1] [RFC PATCH 00/20] Qemu: Extend intel_iommu emulator to support
Shared Virtual Memory from Yi Liu
https://www.spinics.net/lists/kvm/msg148798.html

[2] [RFC PATCH 0/8] Shared Virtual Memory virtualization for VT-d from Yi Liu
https://lists.linuxfoundation.org/pipermail/iommu/2017-April/021475.html

[3] [PATCH v3 00/12] Introduce new iommu notifier framework for virt-SVA by Yi
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00078.html

[4] [PATCH v6 00/22] SMMUv3 Nested Stage Setup by Eric Auger
https://lkml.org/lkml/2019/3/17/124

[5] [RFC v4 00/27] vSMMUv3/pSMMUv3 2 stage VFIO integration by Eric Auger
https://lists.sr.ht/~philmd/qemu/%3C20190527114203.2762-1-eric.auger%40redhat.com%3E

[6] [RFC PATCH 2/6] drivers core: Add I/O ASID allocator by Jean-Philippe
Brucker
https://www.spinics.net/lists/iommu/msg30639.html

Liu Yi L (4):
  vfio: VFIO_IOMMU_ATTACH/DETACH_PASID_TABLE
  vfio: VFIO_IOMMU_CACHE_INVALIDATE
  vfio/type1: VFIO_IOMMU_PASID_REQUEST(alloc/free)
  vfio/type1: bind guest pasid (guest page tables) to host

 drivers/vfio/vfio_iommu_type1.c | 384 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       | 116 ++++++++++++
 2 files changed, 500 insertions(+)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
