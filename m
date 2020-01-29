Return-Path: <SRS0=Gm0N=3S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340DBC3524B
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 05:56:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0824024686
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 05:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0824024686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F063585D4C;
	Wed, 29 Jan 2020 05:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ukBfeIhuaP-c; Wed, 29 Jan 2020 05:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ECF1B85E51;
	Wed, 29 Jan 2020 05:56:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8B3DC1D84;
	Wed, 29 Jan 2020 05:56:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE2A0C0881
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 05:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B3A0F85DF7
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 05:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jnMyXkzpmlWE for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jan 2020 05:56:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 640A185D2B
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 05:56:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jan 2020 21:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,376,1574150400"; d="scan'208";a="222346512"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 28 Jan 2020 21:56:41 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH V9 00/10] Nested Shared Virtual Address (SVA) VT-d support
Date: Tue, 28 Jan 2020 22:01:43 -0800
Message-Id: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Jonathan Cameron <jic23@kernel.org>
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

Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
platforms allow address space sharing between device DMA and applications.
SVA can reduce programming complexity and enhance security.
This series is intended to enable SVA virtualization, i.e. enable use of SVA
within a guest user application.

This is the remaining portion of the original patchset that is based on
Joerg's x86/vt-d branch. The preparatory and cleanup patches are merged here.
(git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git)

Only IOMMU portion of the changes are included in this series. Additional
support is needed in VFIO and QEMU (will be submitted separately) to complete
this functionality.

To make incremental changes and reduce the size of each patchset. This series
does not inlcude support for page request services.

In VT-d implementation, PASID table is per device and maintained in the host.
Guest PASID table is shadowed in VMM where virtual IOMMU is emulated.

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

This is the remaining VT-d only portion of V5 since the uAPIs and IOASID common
code have been applied to Joerg's IOMMU core branch.
(https://lkml.org/lkml/2019/10/2/833)

The complete set with VFIO patches are here:
https://github.com/jacobpan/linux.git:siov_sva

The complete nested SVA upstream patches are divided into three phases:
    1. Common APIs and PCI device direct assignment
    2. Page Request Services (PRS) support
    3. Mediated device assignment

With this set and the accompanied VFIO code, we will achieve phase #1.

Thanks,

Jacob

ChangeLog:
	- v9
	  - Addressed Baolu's comments for v8 for IOTLB flush consolidation,
	    bug fixes
	  - Removed IOASID notifier code which will be submitted separately
	    to address PASID life cycle management with multiple users.

	- v8
	  - Extracted cleanup patches from V7 and accepted into maintainer's
	    tree (https://lkml.org/lkml/2019/12/2/514).
	  - Added IOASID notifier and VT-d handler for termination of PASID
	    IOMMU context upon free. This will ensure success of VFIO IOASID
	    free API regardless PASID is in use.
	    (https://lore.kernel.org/linux-iommu/1571919983-3231-1-git-send-email-yi.l.liu@intel.com/)

	- V7
	  - Respect vIOMMU PASID range in virtual command PASID/IOASID allocator
	  - Caching virtual command capabilities to avoid runtime checks that
	    could cause vmexits.

	- V6
	  - Rebased on top of Joerg's core branch
	  (git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git core)
	  - Adapt to new uAPIs and IOASID allocators

	- V5
	  Rebased on v5.3-rc4 which has some of the IOMMU fault APIs merged.
 	  Addressed v4 review comments from Eric Auger, Baolu Lu, and
	    Jonathan Cameron. Specific changes are as follows:
	  - Refined custom IOASID allocator to support multiple vIOMMU, hotplug
	    cases.
	  - Extracted vendor data from IOMMU guest PASID bind data, for VT-d
	    will support all necessary guest PASID entry fields for PASID
	    bind.
	  - Support non-identity host-guest PASID mapping
	  - Exception handling in various cases

	- V4
	  - Redesigned IOASID allocator such that it can support custom
	  allocators with shared helper functions. Use separate XArray
	  to store IOASIDs per allocator. Took advice from Eric Auger to
	  have default allocator use the generic allocator structure.
	  Combined into one patch in that the default allocator is just
	  "another" allocator now. Can be built as a module in case of
	  driver use without IOMMU.
	  - Extended bind guest PASID data to support SMMU and non-identity
	  guest to host PASID mapping https://lkml.org/lkml/2019/5/21/802
	  - Rebased on Jean's sva/api common tree, new patches starts with
	   [PATCH v4 10/22]

	- V3
	  - Addressed thorough review comments from Eric Auger (Thank you!)
	  - Moved IOASID allocator from driver core to IOMMU code per
	    suggestion by Christoph Hellwig
	    (https://lkml.org/lkml/2019/4/26/462)
	  - Rebased on top of Jean's SVA API branch and Eric's v7[1]
	    (git://linux-arm.org/linux-jpb.git sva/api)
	  - All IOMMU APIs are unmodified (except the new bind guest PASID
	    call in patch 9/16)

	- V2
	  - Rebased on Joerg's IOMMU x86/vt-d branch v5.1-rc4
	  - Integrated with Eric Auger's new v7 series for common APIs
	  (https://github.com/eauger/linux/tree/v5.1-rc3-2stage-v7)
	  - Addressed review comments from Andy Shevchenko and Alex Williamson on
	    IOASID custom allocator.
	  - Support multiple custom IOASID allocators (vIOMMUs) and dynamic
	    registration.

Jacob Pan (9):
  iommu/vt-d: Move domain helper to header
  iommu/uapi: Define a mask for bind data
  iommu/vt-d: Add nested translation helper function
  iommu/vt-d: Add bind guest PASID support
  iommu/vt-d: Support flushing more translation cache types
  iommu/vt-d: Add svm/sva invalidate function
  iommu/vt-d: Cache virtual command capability register
  iommu/vt-d: Add custom allocator for IOASID
  iommu/vt-d: Report PASID format as domain attribute

Lu Baolu (1):
  iommu/vt-d: Enlightened PASID allocation

 drivers/iommu/dmar.c        |  34 ++++++
 drivers/iommu/intel-iommu.c | 289 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel-pasid.c | 285 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel-pasid.h |  25 +++-
 drivers/iommu/intel-svm.c   | 223 ++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  45 ++++++-
 include/linux/intel-svm.h   |  17 +++
 include/linux/iommu.h       |   1 +
 include/uapi/linux/iommu.h  |   5 +-
 9 files changed, 910 insertions(+), 14 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
