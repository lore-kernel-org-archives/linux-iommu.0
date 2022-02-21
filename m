Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E691C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 15:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 107A4401BB;
	Mon, 21 Feb 2022 15:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bsxgT2pbn3qY; Mon, 21 Feb 2022 15:44:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BFA82401B0;
	Mon, 21 Feb 2022 15:44:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7808BC001A;
	Mon, 21 Feb 2022 15:44:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46ADDC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27106605A7
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7OzasMIE6hEM for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:44:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66C55600B5
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:44:21 +0000 (UTC)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2RRD6bNVz6895n;
 Mon, 21 Feb 2022 23:43:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 16:44:17 +0100
Received: from A2006125610.china.huawei.com (10.47.91.169) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 15:44:09 +0000
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Date: Mon, 21 Feb 2022 15:43:33 +0000
Message-ID: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.47.91.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

Since we now have an updated verion[0] of IORT spec(E.d) which
addresses the memory attributes issues discussed here [1],
this series now make use of it.

The pull request for ACPICA E.d related changes are already
raised and can be found here,
https://github.com/acpica/acpica/pull/752

v7 --> v8
  - Patch #1 has temp definitions for RMR related changes till
    the ACPICA header changes are part of kernel.
  - No early parsing of RMR node info and is only parsed at the
    time of use.
  - Changes to the RMR get/put API format compared to the
    previous version.
  - Support for RMR descriptor shared by multiple stream IDs.

Please take a look and let me know your thoughts.

Thanks,
Shameer
[0] https://developer.arm.com/documentation/den0049/ed/
[1] https://lore.kernel.org/linux-acpi/20210805160319.GB23085@lpieralisi/

From old:
We have faced issues with 3408iMR RAID controller cards which
fail to boot when SMMU is enabled. This is because these
controllers make use of host memory for various caching related
purposes and when SMMU is enabled the iMR firmware fails to
access these memory regions as there is no mapping for them.
IORT RMR provides a way for UEFI to describe and report these
memory regions so that the kernel can make a unity mapping for
these in SMMU.

Change History:

v6 --> v7
 -fix pointed out by Steve to the SMMUv2 SMR bypass install in patch #8.

v5 --> v6
- Addressed comments from Robin & Lorenzo.
  : Moved iort_parse_rmr() to acpi_iort_init() from
    iort_init_platform_devices().
  : Removed use of struct iort_rmr_entry during the initial
    parse. Using struct iommu_resv_region instead.
  : Report RMR address alignment and overlap errors, but continue.
  : Reworked arm_smmu_init_bypass_stes() (patch # 6).
- Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
- Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
  on Type of RMR region. Suggested by Jon N.

v4 --> v5
 -Added a fw_data union to struct iommu_resv_region and removed
  struct iommu_rmr (Based on comments from Joerg/Robin).
 -Added iommu_put_rmrs() to release mem.
 -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
  yet because of the above changes.

v3 -->v4
-Included the SMMUv2 SMR bypass install changes suggested by
 Steve(patch #7)
-As per Robin's comments, RMR reserve implementation is now
 more generic  (patch #8) and dropped v3 patches 8 and 10.
-Rebase to 5.13-rc1

RFC v2 --> v3
 -Dropped RFC tag as the ACPICA header changes are now ready to be
  part of 5.13[0]. But this series still has a dependency on that patch.
 -Added IORT E.b related changes(node flags, _DSM function 5 checks for
  PCIe).
 -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
  discussion here[1].
 -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)

Jon Nettleton (1):
  iommu/arm-smmu: Get associated RMR info and install bypass SMR

Shameer Kolothum (10):
  ACPI/IORT: Add temporary RMR node flag definitions
  iommu: Introduce a union to struct iommu_resv_region
  ACPI/IORT: Add helper functions to parse RMR nodes
  iommu/dma: Introduce generic helper to retrieve RMR info
  ACPI/IORT: Add a helper to retrieve RMR memory regions
  iommu/arm-smmu-v3: Introduce strtab init helper
  iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
    bypass
  iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
  iommu/arm-smmu-v3: Reserve any RMR regions associated with a dev
  iommu/arm-smmu: Reserve any RMR regions associated with a dev

 drivers/acpi/arm64/iort.c                   | 305 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  91 ++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  65 ++++-
 drivers/iommu/dma-iommu.c                   |  25 ++
 include/linux/acpi_iort.h                   |  14 +
 include/linux/dma-iommu.h                   |  14 +
 include/linux/iommu.h                       |   9 +
 7 files changed, 504 insertions(+), 19 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
