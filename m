Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EECC433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 11:56:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC13B239D1
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 11:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC13B239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 832C98721E;
	Fri, 22 Jan 2021 11:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1U1Qc5x8isPf; Fri, 22 Jan 2021 11:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D57F0870DC;
	Fri, 22 Jan 2021 11:56:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE4DFC08A1;
	Fri, 22 Jan 2021 11:56:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2746DC013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0E1BF87149
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u60jVnYm9ToT for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:56:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 24FD2870DC
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:56:29 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id v15so4816298wrx.4
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 03:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pdKDptCHYJAfbzlC3FLHPAJA0x8fbBbYQpyeKd2Vy7k=;
 b=Hl32bO5nl2Cn3RFHu+v+gO/NSZT7WO+5u61rmicU9FUzbEunYciGLmARVj9JRNbERV
 vVYqiVyP5MTcVsS8UK8gFkv0ABSDHboBlDO05z5AjLmYTdKoVD5aZzSChh9R1LVjaVR+
 nTvcwIIcxm9JNldlEpcuOfuZptpEK6qeHS021FtNZpVVlfXwvKOvqV8plBYOECHGWdQt
 gZHuiuFjFMedFF8/LYK8Jq9xWKCdNLS46fn2kKqDulSP1CDxSNO782nwqMVZso7khpJ2
 plYofAVbDtsUpge1Od4B1jtyko3WpP+f6RzuMMYGTCa4eMNRlKeN/VZIddX1LG9Tlxzd
 C3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pdKDptCHYJAfbzlC3FLHPAJA0x8fbBbYQpyeKd2Vy7k=;
 b=ajOrPPe/A/3ZePSsGnYF442FDvYDMX1kXLvk1gGGgVJxNVUk7Y3YExc47c6T6ax3yj
 n1cwC692FGeMVZONBEy1viXDOJGkN+POj4IXiojb08elTOyIlG5jh3HMXmH9msPhh2yR
 kLKp5iGSnmoFHrc8aELIOhwgAPNPMdBWUwQmwMbBSBQSh9hAQyxNUAhM2yNV5DScJcpA
 8e6eX1rAzKWaBX7c3UUz9qCbe1N5liScQnzm1sLNversy6+LhObygpnJOYWtje/r+X3Y
 B9+lJZh29/aS5bfmHaQex/6O2J6RXi8x+/kfKTlom+qst3evqRfdzhDt+DsgfHDEPDPi
 cTlg==
X-Gm-Message-State: AOAM531KSggPx8S1n2XnNLQ+vr9IGqtARqIdxtvn8XtTZS8ZZq3oKqgy
 UbBPaf/Qq61z0AYnCRHSOzpmYw==
X-Google-Smtp-Source: ABdhPJy1bMKqKX25Mz4Uyo7MUE5fAVdKwZqLqA9qO3qq6yPYaKhxlWSa+vbm8Yw67Dyrqqeql1KFzA==
X-Received: by 2002:a5d:4391:: with SMTP id i17mr682554wrq.57.1611316587570;
 Fri, 22 Jan 2021 03:56:27 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s25sm13293901wrs.49.2021.01.22.03.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 03:56:26 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: [PATCH 0/3] iommu/arm-smmu-v3: TLB invalidation for SVA
Date: Fri, 22 Jan 2021 12:52:55 +0100
Message-Id: <20210122115257.2502526-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, vivek.gautam@arm.com,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 linux-arm-kernel@lists.infradead.org
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

To support sharing page tables with the CPU, the SMMU can participate in
Broadcast TLB Maintenance (BTM), where TLB invalidate instructions from
the CPU are received by the SMMU. For platforms that do no implement BTM
[1], it is still possible to use SVA, by sending all TLB invalidations
through the command queue. Patch 2 implements this.

This series also enables SVA for platforms that do support BTM, as an
intermediate step because properly supporting BTM requires cooperating
with KVM to allocate VMIDs [2]. With BTM enabled, the SMMU applies
broadcast invalidations by VMID to any matching TLB entry, because there
is no distinction between private and shared VMIDs like there is for
ASIDs. Therefore a stage-2 domain will need a VMID that doesn't conflict
with one allocated by KVM (or use the one from the corresponding VM,
pinned).

These patches, along with the IOPF series [3] and the quirks [4], enable
SVA for the hisi accelerator that's already supported upstream. My quick
performance comparison between BTM and !BTM on that platform were
inconclusive. Doing invalidations via cmdq seemed to slightly reduce
performance of some heavy compression jobs, but there was too much noise
and not enough invalidations in my tests.

This series does not depend on the IOPF one [3].

[1] https://lore.kernel.org/linux-iommu/BY5PR12MB37641E84D516054387FEE330B3CC0@BY5PR12MB3764.namprd12.prod.outlook.com/
[2] https://lore.kernel.org/linux-iommu/20200522101755.GA3453945@myrica/
[3] https://lore.kernel.org/linux-iommu/20210121123623.2060416-1-jean-philippe@linaro.org/
[4] https://lore.kernel.org/linux-pci/1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org/

Jean-Philippe Brucker (3):
  iommu/arm-smmu-v3: Split arm_smmu_tlb_inv_range()
  iommu/arm-smmu-v3: Make BTM optional for SVA
  iommu/arm-smmu-v3: Add support for VHE

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   6 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  14 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 104 ++++++++++++------
 3 files changed, 89 insertions(+), 35 deletions(-)

-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
