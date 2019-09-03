Return-Path: <SRS0=5lac=W6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB4C3A5A5
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 03:30:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB6B22D6D
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 03:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kwrJNN0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB6B22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E7632C9A;
	Tue,  3 Sep 2019 03:30:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8C893907
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 03:30:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4A3A289C
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 03:30:34 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5d6dde5c0000>; Mon, 02 Sep 2019 20:30:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate101.nvidia.com (PGP Universal service);
	Mon, 02 Sep 2019 20:30:33 -0700
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Mon, 02 Sep 2019 20:30:33 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
	(172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Tue, 3 Sep 2019 03:30:33 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
	(172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Tue, 3 Sep 2019 03:30:33 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
	(172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
	Frontend Transport; Tue, 3 Sep 2019 03:30:33 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
	hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
	id <B5d6dde590000>; Mon, 02 Sep 2019 20:30:33 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: 
Subject: [PATCH v2 0/7] Nvidia Arm SMMUv2 Implementation
Date: Mon, 2 Sep 2019 20:32:01 -0700
Message-ID: <1567481528-31163-1-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1567481436; bh=T9BbTYlYBfuyCj1sNd2063D0NTKNlCCYjU+ccrUrfNA=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	X-NVConfidentiality:MIME-Version:Content-Type;
	b=kwrJNN0Z9MVA02HH4Wy53rTiwgJNHARlt4xypssjUsxFSJGrizKy75cuamg/sjrg/
	E9Pt+9meLVYnXR+dl1zRa3/lARZKXWQPX8inmBCdazmVCjUQ2G7Z0tVlpNHzHSxIF1
	sZ3oxbnNo77T4+yOPP8NVlvsHwfpUiUeLS0C5nddFZRZShOhuRw4Xv9nktMOChFLo5
	df5dH2Pn6HUbQ1ZnxM1VpoUcfFVGIg7+50ecCIQ3HenSasr61ED+8pVkITeCqA+Tpm
	ChB56uDR2DUhGWujtOHo3TuJRUi9W6KPYzUA+gL5KZglno04DaFZD6McHvjhSW+3ff
	enfvdybAwqu4Q==
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
	mperttunen@nvidia.com, will@kernel.org,
	linux-kernel@vger.kernel.org, praithatha@nvidia.com,
	talho@nvidia.com, iommu@lists.linux-foundation.org,
	linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
	robin.murphy@arm.com, avanbrunt@nvidia.com,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Changes in v2:
- Prepare arm_smu_flush_ops for override.
- Remove NVIDIA_SMMUv2 and use ARM_SMMUv2 model as T194 SMMU hasn't modified ARM MMU-500.
- Add T194 specific compatible string - "nvidia,tegra194-smmu"
- Remove tlb_sync hook added in v1 and Override arm_smmu_flush_ops->tlb_sync() from implementation.
- Register implementation specific context/global fault hooks directly for irq handling.
- Update global/context interrupt list in DT and releant fault handling code in arm-smmu-nvidia.c.
- Implement reset hook in arm-smmu-nvidia.c to clear irq status and sync tlb.

v1 - https://lkml.org/lkml/2019/8/29/1588

Krishna Reddy (7):
  iommu/arm-smmu: prepare arm_smmu_flush_ops for override
  iommu/arm-smmu: add NVIDIA implementation for dual ARM MMU-500 usage
  dt-bindings: arm-smmu: Add binding for Tegra194 SMMU
  iommu/arm-smmu: Add global/context fault implementation hooks
  arm64: tegra: Add Memory controller DT node on T194
  arm64: tegra: Add DT node for T194 SMMU
  arm64: tegra: enable SMMU for SDHCI and EQOS on T194

 .../devicetree/bindings/iommu/arm,smmu.txt         |   4 +
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  88 +++++++
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/arm-smmu-impl.c                      |   3 +
 drivers/iommu/arm-smmu-nvidia.c                    | 287 +++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           |  27 +-
 drivers/iommu/arm-smmu.h                           |   8 +-
 9 files changed, 413 insertions(+), 12 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c

-- 
2.1.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
