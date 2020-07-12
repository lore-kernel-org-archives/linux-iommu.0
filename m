Return-Path: <SRS0=M77+=AX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B79C433E2
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 11:14:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FAD2072D
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 11:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FAD2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 31F8788564;
	Sun, 12 Jul 2020 11:14:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PPDAALX8brRl; Sun, 12 Jul 2020 11:14:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 63A2E88652;
	Sun, 12 Jul 2020 11:14:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4790DC1798;
	Sun, 12 Jul 2020 11:14:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC209C0733
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DB3EB893F0
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Z1Dy+AFi3Lf for <iommu@lists.linux-foundation.org>;
 Sun, 12 Jul 2020 11:14:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A2421893BA
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:30 +0000 (UTC)
IronPort-SDR: aMD7xQr+DLg8GrqN0x/88zT/yBgKB7p6GX+Ekt+UkPrhC0f3kFhhUgjE01LIjtssxinQXpo1Mm
 Mvpnv3Luj3Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="148489860"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="148489860"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2020 04:14:29 -0700
IronPort-SDR: KB9Zm3Kpz3+X3K7Vg3F9oTlgzRwMvO81SjSOurB9IGDIXEesFMdG613zM1Sq5s0BXiw5QBerFG
 od2v5RKrYSmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="315788549"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 12 Jul 2020 04:14:29 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v5 00/15] vfio: expose virtual Shared Virtual Addressing to VMs
Date: Sun, 12 Jul 2020 04:20:55 -0700
Message-Id: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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
 2. reports IOMMU nesting info to userspace ( patch 0002, 0003, 0004 and 0015)
 3. vfio support for PASID allocation and free for VMs (patch 0005, 0006, 0007)
 4. vfio support for binding guest page table to host (patch 0008, 0009, 0010)
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
*) [PATCH v4 0/5] IOMMU user API enhancement - wip
   https://lore.kernel.org/linux-iommu/1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com/

*) [PATCH 00/10] IOASID extensions for guest SVA - wip
   https://lkml.org/lkml/2020/3/25/874

The latest IOASID code added below new interface for itertate all PASIDs of an
ioasid_set. The implementation is not sent out yet as Jacob needs some cleanup,
it can be found in branch vsva-linux-5.8-rc3-v5 on github (mentioned below):
 int ioasid_set_for_each_ioasid(int sid, void (*fn)(ioasid_t id, void *data), void *data);

Complete set for current vSVA can be found in below branch.
https://github.com/luxis1999/linux-vsva.git: vsva-linux-5.8-rc3-v5

The corresponding QEMU patch series is included in below branch:
https://github.com/luxis1999/qemu.git: vsva_5.8_rc3_qemu_rfcv8


Regards,
Yi Liu

Changelog:
	- Patch v4 -> Patch v5:
	  a) Address comments against v4
	  Patch v4: https://lore.kernel.org/kvm/1593861989-35920-1-git-send-email-yi.l.liu@intel.com/

	- Patch v3 -> Patch v4:
	  a) Address comments against v3
	  b) Add rb from Stefan on patch 14/15
	  Patch v3: https://lore.kernel.org/linux-iommu/1592988927-48009-1-git-send-email-yi.l.liu@intel.com/

	- Patch v2 -> Patch v3:
	  a) Rebase on top of Jacob's v3 iommu uapi patchset
	  b) Address comments from Kevin and Stefan Hajnoczi
	  c) Reuse DOMAIN_ATTR_NESTING to get iommu nesting info
	  d) Drop [PATCH v2 07/15] iommu/uapi: Add iommu_gpasid_unbind_data
	  Patch v2: https://lore.kernel.org/linux-iommu/1591877734-66527-1-git-send-email-yi.l.liu@intel.com/#r

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

---
Eric Auger (1):
  vfio: Document dual stage control

Liu Yi L (13):
  vfio/type1: Refactor vfio_iommu_type1_ioctl()
  iommu: Report domain nesting info
  iommu/smmu: Report empty domain nesting info
  vfio/type1: Report iommu nesting info to userspace
  vfio: Add PASID allocation/free support
  iommu/vt-d: Support setting ioasid set to domain
  vfio/type1: Add VFIO_IOMMU_PASID_REQUEST (alloc/free)
  iommu/vt-d: Check ownership for PASIDs from user-space
  vfio/type1: Support binding guest page tables to PASID
  vfio/type1: Allow invalidating first-level/stage IOMMU cache
  vfio/type1: Add vSVA support for IOMMU-backed mdevs
  vfio/pci: Expose PCIe PASID capability to guest
  iommu/vt-d: Support reporting nesting capability info

Yi Sun (1):
  iommu: Pass domain to sva_unbind_gpasid()

 Documentation/driver-api/vfio.rst  |  67 +++
 drivers/iommu/arm-smmu-v3.c        |  29 +-
 drivers/iommu/arm-smmu.c           |  29 +-
 drivers/iommu/intel/iommu.c        | 113 ++++-
 drivers/iommu/intel/svm.c          |  10 +-
 drivers/iommu/iommu.c              |   2 +-
 drivers/vfio/Kconfig               |   6 +
 drivers/vfio/Makefile              |   1 +
 drivers/vfio/pci/vfio_pci_config.c |   2 +-
 drivers/vfio/vfio_iommu_type1.c    | 818 ++++++++++++++++++++++++++++---------
 drivers/vfio/vfio_pasid.c          | 271 ++++++++++++
 include/linux/intel-iommu.h        |  23 +-
 include/linux/iommu.h              |   4 +-
 include/linux/vfio.h               |  54 +++
 include/uapi/linux/iommu.h         |  77 ++++
 include/uapi/linux/vfio.h          |  90 ++++
 16 files changed, 1395 insertions(+), 201 deletions(-)
 create mode 100644 drivers/vfio/vfio_pasid.c

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
