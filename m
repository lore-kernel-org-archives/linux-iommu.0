Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBC1C433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:13:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFE923128
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFE923128
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0BBC886AA5;
	Fri, 15 Jan 2021 12:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ctNGo_HMTE3Y; Fri, 15 Jan 2021 12:13:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4B90D86958;
	Fri, 15 Jan 2021 12:13:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32291C08A1;
	Fri, 15 Jan 2021 12:13:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B910C013A;
 Fri, 15 Jan 2021 12:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4A86986A37;
 Fri, 15 Jan 2021 12:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c0PtzWgDqQtb; Fri, 15 Jan 2021 12:13:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0C01586958;
 Fri, 15 Jan 2021 12:13:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A55A11B3;
 Fri, 15 Jan 2021 04:13:52 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C64663F70D;
 Fri, 15 Jan 2021 04:13:47 -0800 (PST)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
Date: Fri, 15 Jan 2021 17:43:27 +0530
Message-Id: <20210115121342.15093-1-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, alex.williamson@redhat.com, vivek.gautam@arm.com,
 robin.murphy@arm.com
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

This patch-series aims at enabling Nested stage translation in guests
using virtio-iommu as the paravirtualized iommu. The backend is supported
with Arm SMMU-v3 that provides nested stage-1 and stage-2 translation.

This series derives its purpose from various efforts happening to add
support for Shared Virtual Addressing (SVA) in host and guest. On Arm,
most of the support for SVA has already landed. The support for nested
stage translation and fault reporting to guest has been proposed [1].
The related changes required in VFIO [2] framework have also been put
forward.

This series proposes changes in virtio-iommu to program PASID tables
and related stage-1 page tables. A simple iommu-pasid-table library
is added for this purpose that interacts with vendor drivers to
allocate and populate PASID tables.
In Arm SMMUv3 we propose to pull the Context Descriptor (CD) management
code out of the arm-smmu-v3 driver and add that as a glue vendor layer
to support allocating CD tables, and populating them with right values.
These CD tables are essentially the PASID tables and contain stage-1
page table configurations too.
A request to setup these CD tables come from virtio-iommu driver using
the iommu-pasid-table library when running on Arm. The virtio-iommu
then pass these PASID tables to the host using the right virtio backend
and support in VMM.

For testing we have added necessary support in kvmtool. The changes in
kvmtool are based on virtio-iommu development branch by Jean-Philippe
Brucker [3].

The tested kernel branch contains following in the order bottom to top
on the git hash -
a) v5.11-rc3
b) arm-smmu-v3 [1] and vfio [2] changes from Eric to add nested page
   table support for Arm.
c) Smmu test engine patches from Jean-Philippe's branch [4]
d) This series
e) Domain nesting info patches [5][6][7].
f) Changes to add arm-smmu-v3 specific nesting info (to be sent to
   the list).

This kernel is tested on Neoverse reference software stack with
Fixed virtual platform. Public version of the software stack and
FVP is available here[8][9].

A big thanks to Jean-Philippe for his contributions towards this work
and for his valuable guidance.

[1] https://lore.kernel.org/linux-iommu/20201118112151.25412-1-eric.auger@redhat.com/T/
[2] https://lore.kernel.org/kvmarm/20201116110030.32335-12-eric.auger@redhat.com/T/
[3] https://jpbrucker.net/git/kvmtool/log/?h=virtio-iommu/devel
[4] https://jpbrucker.net/git/linux/log/?h=sva/smmute
[5] https://lore.kernel.org/kvm/1599734733-6431-2-git-send-email-yi.l.liu@intel.com/
[6] https://lore.kernel.org/kvm/1599734733-6431-3-git-send-email-yi.l.liu@intel.com/
[7] https://lore.kernel.org/kvm/1599734733-6431-4-git-send-email-yi.l.liu@intel.com/
[8] https://developer.arm.com/tools-and-software/open-source-software/arm-platforms-software/arm-ecosystem-fvps
[9] https://git.linaro.org/landing-teams/working/arm/arm-reference-platforms.git/about/docs/rdn1edge/user-guide.rst

Jean-Philippe Brucker (6):
  iommu/virtio: Add headers for table format probing
  iommu/virtio: Add table format probing
  iommu/virtio: Add headers for binding pasid table in iommu
  iommu/virtio: Add support for INVALIDATE request
  iommu/virtio: Attach Arm PASID tables when available
  iommu/virtio: Add support for Arm LPAE page table format

Vivek Gautam (9):
  iommu/arm-smmu-v3: Create a Context Descriptor library
  iommu: Add a simple PASID table library
  iommu/arm-smmu-v3: Update drivers to work with iommu-pasid-table
  iommu/arm-smmu-v3: Update CD base address info for user-space
  iommu/arm-smmu-v3: Set sync op from consumer driver of cd-lib
  iommu: Add asid_bits to arm smmu-v3 stage1 table info
  iommu/virtio: Update table format probing header
  iommu/virtio: Prepare to add attach pasid table infrastructure
  iommu/virtio: Update fault type and reason info for viommu fault

 drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 283 +++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  16 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 268 +------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
 drivers/iommu/iommu-pasid-table.h             | 140 ++++
 drivers/iommu/virtio-iommu.c                  | 692 +++++++++++++++++-
 include/uapi/linux/iommu.h                    |   2 +-
 include/uapi/linux/virtio_iommu.h             | 158 +++-
 9 files changed, 1303 insertions(+), 262 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
 create mode 100644 drivers/iommu/iommu-pasid-table.h

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
