Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCE0C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 12:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D82C818BE;
	Mon, 25 Apr 2022 12:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NuPOhsIqfXLK; Mon, 25 Apr 2022 12:42:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 699ED817AF;
	Mon, 25 Apr 2022 12:42:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4939DC0032;
	Mon, 25 Apr 2022 12:42:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA73C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 12:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A3F2818BE
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 12:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cV6yXKln6HoM for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 12:42:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E2EC817AF
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 12:42:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A817ED1;
 Mon, 25 Apr 2022 05:42:10 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01FFE3F5A1;
 Mon, 25 Apr 2022 05:42:08 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH v4 0/4] iommu,
 thunderbolt: Make iommu_dma_protection more accurate
Date: Mon, 25 Apr 2022 13:42:01 +0100
Message-Id: <cover.1650878781.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
MIME-Version: 1.0
Cc: michael.jamet@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, mika.westerberg@linux.intel.com, hch@lst.de
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

As promised, here's the really-actually-final version, cleaning up the
new interface in patch #1 to not introduce the new parameter before it's
ready, and rebased to make sure it correctly applies on -rc3.

Thanks,
Robin.


Mario Limonciello (1):
  iommu/amd: Indicate whether DMA remap support is enabled

Robin Murphy (3):
  iommu: Introduce device_iommu_capable()
  iommu: Add capability for pre-boot DMA protection
  thunderbolt: Make iommu_dma_protection more accurate

 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            |  3 ++
 drivers/iommu/amd/iommu.c           |  2 ++
 drivers/iommu/intel/iommu.c         |  2 ++
 drivers/iommu/iommu.c               | 23 +++++++++++++++
 drivers/thunderbolt/domain.c        | 12 ++------
 drivers/thunderbolt/nhi.c           | 44 +++++++++++++++++++++++++++++
 include/linux/iommu.h               |  8 ++++++
 include/linux/thunderbolt.h         |  2 ++
 9 files changed, 91 insertions(+), 9 deletions(-)

-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
