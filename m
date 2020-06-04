Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27837C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 23:44:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB642075B
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 23:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oytOPy++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB642075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD3938738F;
	Thu,  4 Jun 2020 23:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r6qoOqcNNGwj; Thu,  4 Jun 2020 23:44:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6428E87387;
	Thu,  4 Jun 2020 23:44:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B348C0881;
	Thu,  4 Jun 2020 23:44:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1D41C016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 23:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DE49288B00
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 23:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rha8i5hhSaUm for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 23:44:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 24004888FC
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 23:44:14 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ed986f50001>; Thu, 04 Jun 2020 16:42:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 04 Jun 2020 16:44:13 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 04 Jun 2020 16:44:13 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jun
 2020 23:44:10 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Thu, 4 Jun 2020 23:44:10 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
 rnnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5ed987490002>; Thu, 04 Jun 2020 16:44:09 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: 
Subject: [PATCH v6 0/4] Nvidia Arm SMMUv2 Implementation
Date: Thu, 4 Jun 2020 16:44:10 -0700
Message-ID: <20200604234414.21912-1-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1591314165; bh=1K8sRZ1SkGwFAEYz4zuF0KeLx+srb1vTBWbsBByL7NU=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
 Content-Type;
 b=oytOPy++C/iIi0x+cljApZvalwFLriaghJwWsQvzfzAyj36OH6gqpSXNIYgVVdoV+
 EDAP/UyTbZoucW0N/JY0p+GVMvdrcF4WDOwDoh1x5ILJikGQw4wyCc+hSNaMj34TSn
 UsNlmgzIgWtCSVOWGObiPN8vNozhazOYNwPkYFTAa9IiFBKZPsY9bV/rGnscXskrQR
 5batsIh428y1Dj95B8N9NsHIWy6gVUa1jg596iXwoalDdgB5zQSbHc0aDdu4ORG9wK
 7Cavcip58+BgYeqOafr4iPKvEeH2OeEA6Mh75C27kpKKALVcC3XNOJH/PjMAzPCdoZ
 bkkJoj6nFmWcA==
Cc: snikam@nvidia.com, mperttunen@nvidia.com, bhuntsman@nvidia.com,
 will@kernel.org, linux-kernel@vger.kernel.org, praithatha@nvidia.com,
 talho@nvidia.com, iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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

Changes in v6:
Restricted the patch set to driver specific patches.
Fixed the cast warning reported by kbuild test robot.
Rebased on git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next

v5 - https://lkml.org/lkml/2020/5/21/1114
v4 - https://lkml.org/lkml/2019/10/30/1054
v3 - https://lkml.org/lkml/2019/10/18/1601
v2 - https://lkml.org/lkml/2019/9/2/980
v1 - https://lkml.org/lkml/2019/8/29/1588

Krishna Reddy (4):
  iommu/arm-smmu: add NVIDIA implementation for dual ARM MMU-500 usage
  dt-bindings: arm-smmu: Add binding for Tegra194 SMMU
  iommu/arm-smmu: Add global/context fault implementation hooks
  iommu/arm-smmu-nvidia: fix the warning reported by kbuild test robot

 .../devicetree/bindings/iommu/arm,smmu.yaml   |   5 +
 MAINTAINERS                                   |   2 +
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/arm-smmu-impl.c                 |   3 +
 drivers/iommu/arm-smmu-nvidia.c               | 261 ++++++++++++++++++
 drivers/iommu/arm-smmu.c                      |  11 +-
 drivers/iommu/arm-smmu.h                      |   4 +
 7 files changed, 285 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c


base-commit: 431275afdc7155415254aef4bd3816a1b8a2ead0
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
