Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C765C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 22:47:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A54A2189D
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 22:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QpALE+ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A54A2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DE1B759CD;
	Thu, 29 Aug 2019 22:47:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 83F2B55F8
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 22:45:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2024A887
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 22:45:43 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5d6855980000>; Thu, 29 Aug 2019 15:45:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate101.nvidia.com (PGP Universal service);
	Thu, 29 Aug 2019 15:45:42 -0700
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Thu, 29 Aug 2019 15:45:42 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
	(172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Thu, 29 Aug 2019 22:45:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
	(172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
	Frontend Transport; Thu, 29 Aug 2019 22:45:42 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
	hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
	id <B5d6855960001>; Thu, 29 Aug 2019 15:45:42 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: 
Subject: [PATCH 0/7] Nvidia Arm SMMUv2 Implementation
Date: Thu, 29 Aug 2019 15:47:00 -0700
Message-ID: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1567118744; bh=XViQuyFPXRUGjvQSy38KjNjazgSU9GgkmEMvuiC4IJI=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	X-NVConfidentiality:MIME-Version:Content-Type;
	b=QpALE+evxkvz2t8B5iHVtf2dNEUPUWPvjULE+doad73wTU+7rj0j6O1bdNpVgq578
	1OBqgXS7PT0sQOHrrgIRx91SwEbqWNhDLPXLNxmmsZkZlTew9lHA6PnPoFunH0IP6i
	WzyjNcXU1WX7j0FiYtib2AjWSLhiWktGBh+jaIWE9bdZfsfnOSumlSntbGOE3QZbQu
	eJDuY3xzzQ7aj3Nb95YTQVgC8wLfW5X5ahSocRZGg+24yAVWrAhqnB1t4N7S50yTmG
	ywFwt6FKf7J4VgLBLFSQsq0n60zLBCYYwgYfgA4cHnqWmMpvguvVFuZGojRkOYs2qC
	gXhdlXukqQbCQ==
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
	mperttunen@nvidia.com, praithatha@nvidia.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	talho@nvidia.com, yhsu@nvidia.com, linux-tegra@vger.kernel.org,
	treding@nvidia.com, avanbrunt@nvidia.com,
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

Hi All,
Nvidia Arm SMMUv2 implementation has two ARM SMMU(MMU-500) instances
that are used together for SMMU translations. The IOVA accesses from
HW devices are interleaved across these two SMMU instances and need
to be programmed identical except during tlb sync and fault handling.

This patch set adds Nvidia Arm SMMUv2 Implementation on top of ARM SMMU
driver to handle Nvidia specific implementation. It is also adding
hooks for tlb sync and fault handling to allow vendor specific
implementation for the same.

Please review the patch set and provide the feedback.

This patch set is based on the following branch as it is dependent on the
Arm SMMU Refactor changes from Robin Murphy that are present in this branch.

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates


Krishna Reddy (7):
  iommu/arm-smmu: add Nvidia SMMUv2 implementation
  dt-bindings: arm-smmu: Add binding for nvidia,smmu-v2
  iommu/arm-smmu: Add tlb_sync implementation hook
  iommu/arm-smmu: Add global/context fault implementation hooks
  arm64: tegra: Add Memory controller DT node on T194
  arm64: tegra: Add DT node for T194 SMMU
  arm64: tegra: enable SMMU for SDHCI and EQOS

 .../devicetree/bindings/iommu/arm,smmu.txt         |   1 +
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  86 +++++++
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/arm-smmu-impl.c                      |   2 +
 drivers/iommu/arm-smmu-nvidia.c                    | 256 +++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           |  16 +-
 drivers/iommu/arm-smmu.h                           |  10 +
 9 files changed, 375 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c

-- 
2.1.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
