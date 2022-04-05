Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F40C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 10:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB37560F58;
	Tue,  5 Apr 2022 10:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6BBhswGShaMd; Tue,  5 Apr 2022 10:41:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C0E9460EA5;
	Tue,  5 Apr 2022 10:41:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A898EC001D;
	Tue,  5 Apr 2022 10:41:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21FB5C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 10:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FAE260EA5
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 10:41:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Ld7kA8ho3Ie for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 10:41:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1624260EAD
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 10:41:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 193ACD6E;
 Tue,  5 Apr 2022 03:41:09 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A35C13F5A1;
 Tue,  5 Apr 2022 03:41:07 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org, baolu.lu@linux.intel.com, andreas.noever@gmail.com,
 michael.jamet@intel.com, mika.westerberg@linux.intel.com,
 YehezkelShB@gmail.com
Subject: [PATCH v3 0/4] thunderbolt: Make iommu_dma_protection more accurate
Date: Tue,  5 Apr 2022 11:41:00 +0100
Message-Id: <cover.1649089693.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, hch@lst.de,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com
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

Hi all,

Here's the third and hopefully final outing for this series, addressing
Mika's review comments from last time and taking advantage of 5.18-rc1
goodies to be even cleaner and more complete. I've also picked up
Mario's AMD IOMMU patch to keep the whole topic together.

Unless there's other pending Thunderbolt development which might
conflict, I suspect it would be simplest for the whole lot to go through
the IOMMU tree.

Thanks,
Robin.


Mario Limonciello (1):
  iommu/amd: Indicate whether DMA remap support is enabled

Robin Murphy (3):
  iommu: Introduce device_iommu_capable()
  iommu: Add capability for pre-boot DMA protection
  thunderbolt: Make iommu_dma_protection more accurate

 drivers/iommu/amd/amd_iommu_types.h         |  4 ++
 drivers/iommu/amd/init.c                    |  3 ++
 drivers/iommu/amd/iommu.c                   |  4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  2 +-
 drivers/iommu/fsl_pamu_domain.c             |  2 +-
 drivers/iommu/intel/iommu.c                 |  4 +-
 drivers/iommu/iommu.c                       | 25 +++++++++++-
 drivers/iommu/s390-iommu.c                  |  2 +-
 drivers/thunderbolt/domain.c                | 12 ++----
 drivers/thunderbolt/nhi.c                   | 44 +++++++++++++++++++++
 include/linux/iommu.h                       | 10 ++++-
 include/linux/thunderbolt.h                 |  2 +
 14 files changed, 100 insertions(+), 18 deletions(-)

-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
