Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E911C433E1
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 12:09:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7111E20760
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 12:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7111E20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 477638962A;
	Thu, 11 Jun 2020 12:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zX+kriilfEA1; Thu, 11 Jun 2020 12:09:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A2E1895BD;
	Thu, 11 Jun 2020 12:09:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B220C0865;
	Thu, 11 Jun 2020 12:09:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C6A9C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8441587A77
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SrZ7ug6HcH5W for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 12:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3421785764
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:10 +0000 (UTC)
IronPort-SDR: iF3uEKuK91wGqTOA19TDzjohMehTKTV2+jILYPf+bmX4XsFCqiY+nxTlzyOYKtDoLgoYCnM2er
 DHi29iLUYV0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 05:09:09 -0700
IronPort-SDR: slupFsEoGCu3+aZxDJFA/0zL5b17ZqrOsg0F2camZjWpwi38u1nWMEY+JyM7+b0EFAF+80FeiR
 uSzRmt7F1iIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; d="scan'208";a="419082464"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 11 Jun 2020 05:09:09 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v2 00/15] vfio: expose virtual Shared Virtual Addressing to VMs
Date: Thu, 11 Jun 2020 05:15:19 -0700
Message-Id: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SVM) on
Intel platforms allows address space sharing between device DMA and
applications. SVA can reduce programming complexity and enhance security.

This VFIO series is intended to expose SVA usage to VMs. i.e. Sharing
guest application address space with passthru devices. This is called
vSVA in this series. The whole vSVA enabling requires QEMU/VFIO/IOMMU
changes. For IOMMU and QEMU changes, they are in separate series (listed
in the "Related series").

The high-level architecture for SVA virtualization is as below, the key
design of vSVA support is to utilize the dual-stage IOMMU translation (
also known as IOMMU nesting translation) capability in host IOMMU.


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

Patch Overview:
 1. a refactor to vfio_iommu_type1 ioctl (patch 0001)
 2. reports IOMMU nesting info to userspace ( patch 0002, 0003 and 0015)
 3. vfio support for PASID allocation and free for VMs (patch 0004, 0005, 0006)
 4. vfio support for binding guest page table to host (patch 0007, 0008, 0009, 0010)
 5. vfio support for IOMMU cache invalidation from VMs (patch 0011)
 6. vfio support for vSVA usage on IOMMU-backed mdevs (patch 0012)
 7. expose PASID capability to VM (patch 0013)
 8. add doc for VFIO dual stage control (patch 0014)

The complete vSVA kernel upstream patches are divided into three phases:
    1. Common APIs and PCI device direct assignment
    2. IOMMU-backed Mediated Device assignment
    3. Page Request Services (PRS) support

This patchset is aiming for the phase 1 and phase 2, and based on Jacob's
below series.
[PATCH v13 0/8] Nested Shared Virtual Address (SVA) VT-d support - merged
https://lkml.org/lkml/2020/5/13/1582

[PATCH v2 0/3] IOMMU user API enhancement - wip
https://lkml.org/lkml/2020/6/11/5

[PATCH 00/10] IOASID extensions for guest SVA - wip
https://lkml.org/lkml/2020/3/25/874

The latest IOASID code added below new interface for itertate all PASIDs of an
ioasid_set. The implementation is not sent out yet as Jacob needs some cleanup,
it can be found in branch vsva-linux-5.7-rc4-v2.
 int ioasid_set_for_each_ioasid(int sid, void (*fn)(ioasid_t id, void *data), void *data);

Complete set for current vSVA can be found in below branch.
This branch also includes some extra modifications to IOASID core code and
vt-d iommu driver cleanup patches.
https://github.com/luxis1999/linux-vsva.git:vsva-linux-5.7-rc4-v2

The corresponding QEMU patch series is included in below branch:
https://github.com/luxis1999/qemu.git:vsva_5.7_rc4_qemu_rfcv6


Regards,
Yi Liu

Changelog:
	- Patch v1 -> Patch v2:
	  a) Refactor vfio_iommu_type1_ioctl() per suggestion from Christoph
	     Hellwig.
	  b) Re-sequence the patch series for better bisect support.
	  c) Report IOMMU nesting cap info in detail instead of a format in
	     v1.
	  d) Enforce one group per nesting type container for vfio iommu type1
	     driver.
	  e) Build the vfio_mm related code from vfio.c to be a separate
	     vfio_pasid.ko.
	  f) Add PASID ownership check in IOMMU driver.
	  g) Adopted to latest IOMMU UAPI design. Removed IOMMU UAPI version
	     check. Added iommu_gpasid_unbind_data for unbind requests from
	     userspace.
	  h) Define a single ioctl:VFIO_IOMMU_NESTING_OP for bind/unbind_gtbl
	     and cahce_invld.
	  i) Document dual stage control in vfio.rst.
	  Patch v1: https://lore.kernel.org/linux-iommu/1584880325-10561-1-git-send-email-yi.l.liu@intel.com/

	- RFC v3 -> Patch v1:
	  a) Address comments to the PASID request(alloc/free) path
	  b) Report PASID alloc/free availabitiy to user-space
	  c) Add a vfio_iommu_type1 parameter to support pasid quota tuning
	  d) Adjusted to latest ioasid code implementation. e.g. remove the
	     code for tracking the allocated PASIDs as latest ioasid code
	     will track it, VFIO could use ioasid_free_set() to free all
	     PASIDs.
	  RFC v3: https://lore.kernel.org/linux-iommu/1580299912-86084-1-git-send-email-yi.l.liu@intel.com/

	- RFC v2 -> v3:
	  a) Refine the whole patchset to fit the roughly parts in this series
	  b) Adds complete vfio PASID management framework. e.g. pasid alloc,
	  free, reclaim in VM crash/down and per-VM PASID quota to prevent
	  PASID abuse.
	  c) Adds IOMMU uAPI version check and page table format check to ensure
	  version compatibility and hardware compatibility.
	  d) Adds vSVA vfio support for IOMMU-backed mdevs.
	  RFC v2: https://lore.kernel.org/linux-iommu/1571919983-3231-1-git-send-email-yi.l.liu@intel.com/

	- RFC v1 -> v2:
	  Dropped vfio: VFIO_IOMMU_ATTACH/DETACH_PASID_TABLE.
	  RFC v1: https://lore.kernel.org/linux-iommu/1562324772-3084-1-git-send-email-yi.l.liu@intel.com/


Eric Auger (1):
  vfio: Document dual stage control

Liu Yi L (13):
  vfio/type1: Refactor vfio_iommu_type1_ioctl()
  iommu: Report domain nesting info
  vfio/type1: Report iommu nesting info to userspace
  vfio: Add PASID allocation/free support
  iommu/vt-d: Support setting ioasid set to domain
  vfio/type1: Add VFIO_IOMMU_PASID_REQUEST (alloc/free)
  iommu/uapi: Add iommu_gpasid_unbind_data
  iommu/vt-d: Check ownership for PASIDs from user-space
  vfio/type1: Support binding guest page tables to PASID
  vfio/type1: Allow invalidating first-level/stage IOMMU cache
  vfio/type1: Add vSVA support for IOMMU-backed mdevs
  vfio/pci: Expose PCIe PASID capability to guest
  iommu/vt-d: Support reporting nesting capability info

Yi Sun (1):
  iommu: Pass domain and unbind_data to sva_unbind_gpasid()

 Documentation/driver-api/vfio.rst  |  64 ++++
 drivers/iommu/intel-iommu.c        | 107 ++++++-
 drivers/iommu/intel-svm.c          |  20 +-
 drivers/iommu/iommu.c              |   4 +-
 drivers/vfio/Kconfig               |   6 +
 drivers/vfio/Makefile              |   1 +
 drivers/vfio/pci/vfio_pci_config.c |   2 +-
 drivers/vfio/vfio_iommu_type1.c    | 614 ++++++++++++++++++++++++++++++++-----
 drivers/vfio/vfio_pasid.c          | 191 ++++++++++++
 include/linux/intel-iommu.h        |  23 +-
 include/linux/iommu.h              |  10 +-
 include/linux/vfio.h               |  54 ++++
 include/uapi/linux/iommu.h         |  47 +++
 include/uapi/linux/vfio.h          |  78 +++++
 14 files changed, 1134 insertions(+), 87 deletions(-)
 create mode 100644 drivers/vfio/vfio_pasid.c

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
