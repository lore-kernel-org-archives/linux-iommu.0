Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA47C433F5
	for <iommu@archiver.kernel.org>; Thu, 14 Apr 2022 12:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4052400D6;
	Thu, 14 Apr 2022 12:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0aYXBjkRRhXU; Thu, 14 Apr 2022 12:42:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A118440C85;
	Thu, 14 Apr 2022 12:42:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61CDDC0033;
	Thu, 14 Apr 2022 12:42:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B477C002C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E4D24190B
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:42:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GJy3vbTUk9PY for <iommu@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 12:42:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDA1B4190A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:42:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6569139F;
 Thu, 14 Apr 2022 05:42:47 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B932A3F70D;
 Thu, 14 Apr 2022 05:42:45 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 00/13] iommu: Retire bus_set_iommu()
Date: Thu, 14 Apr 2022 13:42:29 +0100
Message-Id: <cover.1649935679.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

Here's another chapter in my saga of moving to per-instance IOMMU ops -
iommu_present() and iommu_capable() cleanups will be ongoing for another
cycle or two, while this one is at least self-contained within the
subsystem. The next steps after this are making iommu_domain_alloc()
instance-aware - which should finish the public API - and pulling the
fwnode/of_xlate bits into __iommu_probe_device(). And then making sense
of whatever's left :)

For ease of review here I split out individual driver patches based on
whether there was any non-trivial change or affect on control flow; the
straightforward deletions are all lumped together since the whole series
needs applying together either way, but I'm happy to split the final
patch up further if anyone would like.

Patch #3 for AMD is based on Mario's SWIOTLB patch here:

https://lore.kernel.org/linux-iommu/20220404204723.9767-1-mario.limonciello@amd.com/

since that wants merging first as fix material. The series is also based
contextually (but not functionally) on my device_iommu_capable() patches
here:

https://lore.kernel.org/linux-iommu/cover.1649089693.git.robin.murphy@arm.com/

since those are pretty much good to go now (I'll send a slightly-tweaked
final version once the iommu/core branch is open).

Thanks,
Robin.


Robin Murphy (13):
  iommu: Always register bus notifiers
  iommu: Move bus setup to IOMMU device registration
  iommu/amd: Clean up bus_set_iommu()
  iommu/arm-smmu: Clean up bus_set_iommu()
  iommu/arm-smmu-v3: Clean up bus_set_iommu()
  iommu/dart: Clean up bus_set_iommu()
  iommu/exynos: Clean up bus_set_iommu()
  iommu/ipmmu-vmsa: Clean up bus_set_iommu()
  iommu/mtk: Clean up bus_set_iommu()
  iommu/omap: Clean up bus_set_iommu()
  iommu/tegra-smmu: Clean up bus_set_iommu()
  iommu/virtio: Clean up bus_set_iommu()
  iommu: Clean up bus_set_iommu()

 drivers/iommu/amd/amd_iommu.h               |   1 -
 drivers/iommu/amd/init.c                    |   9 +-
 drivers/iommu/amd/iommu.c                   |  21 ----
 drivers/iommu/apple-dart.c                  |  30 +-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  53 +---------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  84 +--------------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |   4 -
 drivers/iommu/exynos-iommu.c                |   9 --
 drivers/iommu/fsl_pamu_domain.c             |   4 -
 drivers/iommu/intel/iommu.c                 |   1 -
 drivers/iommu/iommu.c                       | 109 +++++++++-----------
 drivers/iommu/ipmmu-vmsa.c                  |  35 +------
 drivers/iommu/msm_iommu.c                   |   2 -
 drivers/iommu/mtk_iommu.c                   |  13 +--
 drivers/iommu/mtk_iommu_v1.c                |  13 +--
 drivers/iommu/omap-iommu.c                  |   6 --
 drivers/iommu/rockchip-iommu.c              |   2 -
 drivers/iommu/s390-iommu.c                  |   6 --
 drivers/iommu/sprd-iommu.c                  |   5 -
 drivers/iommu/sun50i-iommu.c                |   2 -
 drivers/iommu/tegra-smmu.c                  |  29 ++----
 drivers/iommu/virtio-iommu.c                |  24 -----
 include/linux/iommu.h                       |   1 -
 23 files changed, 62 insertions(+), 401 deletions(-)

-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
