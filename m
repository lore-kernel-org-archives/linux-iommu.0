Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCF7CA9EC7
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 00:07:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F0620856
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 00:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CXOTXa9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F0620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5678EE9A;
	Thu, 31 Oct 2019 00:07:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 575CFCDD
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 00:07:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E8B9787C
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 00:07:30 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5dba25c80000>; Wed, 30 Oct 2019 17:07:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate101.nvidia.com (PGP Universal service);
	Wed, 30 Oct 2019 17:07:30 -0700
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Wed, 30 Oct 2019 17:07:30 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
	(172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Thu, 31 Oct 2019 00:07:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL111.nvidia.com
	(172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
	Frontend Transport; Thu, 31 Oct 2019 00:07:29 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
	hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
	id <B5dba25c10000>; Wed, 30 Oct 2019 17:07:29 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: 
Subject: [PATCH v4 0/6] Nvidia Arm SMMUv2 Implementation
Date: Wed, 30 Oct 2019 17:07:11 -0700
Message-ID: <1572480437-28449-1-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1572480456; bh=twA38AxT+vglESgZl57xrwZUdLq1unS/ukF862ESTCs=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	X-NVConfidentiality:MIME-Version:Content-Type;
	b=CXOTXa9hDqtYTPrMUbv9IfoOpO1/9f9EMLBpdpoSn/wVbLzM2MUmiJbuX19RhEED5
	cRqL83gefTkE5qRcLQqUj3AeUxKVImFw6srlsXgK/TD21H9rHkLtByRtQgneUKgp/j
	pO7ItNbHh9tNWRuWYejbSAmpotFxxVnf0SlPz43D6W3/dlONflBdcVZCB8x5+sNiaE
	BuUki5rEoQxXfhU0sf22IksBlRcasT+hvRYTzQ2v0UIF4QMGOKSvCPfCNKvyNgBMgG
	6osi9xp+E0Q/pGpH3D3ke0shqbjzBCmE2HBGmZTq1pWp4KJxj0u2UuSXbLoPy7yUZV
	VvoYeDvWLT4Qg==
Cc: snikam@nvidia.com, jtukkinen@nvidia.com, mperttunen@nvidia.com,
	will@kernel.org, linux-kernel@vger.kernel.org,
	praithatha@nvidia.com, talho@nvidia.com,
	iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
	linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
	robin.murphy@arm.com, avanbrunt@nvidia.com,
	linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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

Changes in v4:
Rebased on top of https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/ for-joerg/arm-smmu/updates.
Updated arm-smmu-nvidia.c to use the tlb_sync implementation hook.
Dropped patch that updates arm_smmu_flush_ops for override as it is no longer necessary.

v3 - https://lkml.org/lkml/2019/10/18/1601
v2 - https://lkml.org/lkml/2019/9/2/980
v1 - https://lkml.org/lkml/2019/8/29/1588

Krishna Reddy (6):
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
 drivers/iommu/arm-smmu-nvidia.c                    | 261 +++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           |  11 +-
 drivers/iommu/arm-smmu.h                           |   4 +
 9 files changed, 376 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
