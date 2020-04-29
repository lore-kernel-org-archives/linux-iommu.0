Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C37C8300A
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 13:37:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D5321707
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 13:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D5321707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 28F0685533;
	Wed, 29 Apr 2020 13:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muEG1NQufikx; Wed, 29 Apr 2020 13:37:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8CB96869F6;
	Wed, 29 Apr 2020 13:37:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72966C0864;
	Wed, 29 Apr 2020 13:37:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A15EDC0172;
 Wed, 29 Apr 2020 13:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8223D203F1;
 Wed, 29 Apr 2020 13:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id okld2FZQP1eJ; Wed, 29 Apr 2020 13:37:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 7CA3B203AF;
 Wed, 29 Apr 2020 13:37:38 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 49DD72E2; Wed, 29 Apr 2020 15:37:35 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 00/34] iommu: Move iommu_group setup to IOMMU core code
Date: Wed, 29 Apr 2020 15:36:38 +0200
Message-Id: <20200429133712.31431-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Cc: linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org,
 jonathan.derrick@intel.com
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

Hi,

here is the third version of this patch-set. Older versions can be found
here:

	v1: https://lore.kernel.org/lkml/20200407183742.4344-1-joro@8bytes.org/
	    (Has some more introductory text)

	v2: https://lore.kernel.org/lkml/20200414131542.25608-1-joro@8bytes.org/

Changes v2 -> v3:

	* Rebased v5.7-rc3

	* Added a missing iommu_group_put() as reported by Lu Baolu.

	* Added a patch to consolidate more initialization work in
	  __iommu_probe_device(), fixing a bug where no 'struct
	  device_iommu' was allocated in the hotplug path.

There is also a git-branch available with these patches applied:

	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device-v3

Please review. If there are no objections I plan to put these patches
into the IOMMU tree early next week.

Thanks,

	Joerg

Joerg Roedel (33):
  iommu: Move default domain allocation to separate function
  iommu/amd: Implement iommu_ops->def_domain_type call-back
  iommu/vt-d: Wire up iommu_ops->def_domain_type
  iommu/amd: Remove dma_mask check from check_device()
  iommu/amd: Return -ENODEV in add_device when device is not handled by
    IOMMU
  iommu: Add probe_device() and release_device() call-backs
  iommu: Move default domain allocation to iommu_probe_device()
  iommu: Keep a list of allocated groups in __iommu_probe_device()
  iommu: Move new probe_device path to separate function
  iommu: Split off default domain allocation from group assignment
  iommu: Move iommu_group_create_direct_mappings() out of
    iommu_group_add_device()
  iommu: Export bus_iommu_probe() and make is safe for re-probing
  iommu/amd: Remove dev_data->passthrough
  iommu/amd: Convert to probe/release_device() call-backs
  iommu/vt-d: Convert to probe/release_device() call-backs
  iommu/arm-smmu: Convert to probe/release_device() call-backs
  iommu/pamu: Convert to probe/release_device() call-backs
  iommu/s390: Convert to probe/release_device() call-backs
  iommu/virtio: Convert to probe/release_device() call-backs
  iommu/msm: Convert to probe/release_device() call-backs
  iommu/mediatek: Convert to probe/release_device() call-backs
  iommu/mediatek-v1 Convert to probe/release_device() call-backs
  iommu/qcom: Convert to probe/release_device() call-backs
  iommu/rockchip: Convert to probe/release_device() call-backs
  iommu/tegra: Convert to probe/release_device() call-backs
  iommu/renesas: Convert to probe/release_device() call-backs
  iommu/omap: Remove orphan_dev tracking
  iommu/omap: Convert to probe/release_device() call-backs
  iommu/exynos: Use first SYSMMU in controllers list for IOMMU core
  iommu/exynos: Convert to probe/release_device() call-backs
  iommu: Remove add_device()/remove_device() code-paths
  iommu: Move more initialization to __iommu_probe_device()
  iommu: Unexport iommu_group_get_for_dev()

Sai Praneeth Prakhya (1):
  iommu: Add def_domain_type() callback in iommu_ops

 drivers/iommu/amd_iommu.c       |  97 ++++----
 drivers/iommu/amd_iommu_types.h |   1 -
 drivers/iommu/arm-smmu-v3.c     |  38 +---
 drivers/iommu/arm-smmu.c        |  39 ++--
 drivers/iommu/exynos-iommu.c    |  24 +-
 drivers/iommu/fsl_pamu_domain.c |  22 +-
 drivers/iommu/intel-iommu.c     |  68 +-----
 drivers/iommu/iommu.c           | 387 +++++++++++++++++++++++++-------
 drivers/iommu/ipmmu-vmsa.c      |  60 ++---
 drivers/iommu/msm_iommu.c       |  34 +--
 drivers/iommu/mtk_iommu.c       |  24 +-
 drivers/iommu/mtk_iommu_v1.c    |  50 ++---
 drivers/iommu/omap-iommu.c      |  99 ++------
 drivers/iommu/qcom_iommu.c      |  24 +-
 drivers/iommu/rockchip-iommu.c  |  26 +--
 drivers/iommu/s390-iommu.c      |  22 +-
 drivers/iommu/tegra-gart.c      |  24 +-
 drivers/iommu/tegra-smmu.c      |  31 +--
 drivers/iommu/virtio-iommu.c    |  41 +---
 include/linux/iommu.h           |  21 +-
 20 files changed, 531 insertions(+), 601 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
