Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F2EC4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 16:47:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A456103A
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 16:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19A456103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0CB340487;
	Fri, 13 Aug 2021 16:47:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DJHqwAp6MPvb; Fri, 13 Aug 2021 16:47:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A44A3404AC;
	Fri, 13 Aug 2021 16:47:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FFB5C001A;
	Fri, 13 Aug 2021 16:47:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E068DC000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1ECA40284
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d7ZcHfqPtZtv for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 16:47:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 063E840119
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:47:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43ED86103A;
 Fri, 13 Aug 2021 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628873260;
 bh=TOC8YA+AWzpLpPO1FgCb/XYmAb7MvaYyPY+3sTJWw5M=;
 h=Date:From:To:Cc:Subject:From;
 b=rZ2O8SaKYpf2+wor2v6iJ5KIDtOqkAhJRKy4AQ87te8HAdTMyXVxA9UchwVrFBRQr
 9mwepfj97eWuCWcusaZ/xXr/GfgI3WYkM3KHMU8RX1tbQfEzk96LalijllOxg5Ufr1
 UjbT77f73g28dj/RAIg98dmL6wZcUk0n/iN974D5xIVAu1tRNYj73xB1+r4DZbhnhA
 K0q4RicMBiaDNYQg5XEcQLTwEzC7OZrc1bdIXkZywvNm40SXkHnGYQXUaMDs4e8mdG
 n0CQNbGg9PhhBxylzKIuJl/FQRzSb+saSAWhxWk50m263staH6QhcExH5bnDXUpkIt
 T+s5RaeBxJvXg==
Date: Fri, 13 Aug 2021 17:47:35 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.15
Message-ID: <20210813164735.GA8765@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org,
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

Hi Joerg,

Please pull these Arm SMMU updates for 5.15. There's not tonnes here, but
a good mixture of optimisations and cleanups -- summary in the tag.

This applies cleanly against iommu/next, but I suspect it will conflict
with Robin's series on the list. Please shout if you need anything from
me to help with that (e.g. rebase, checking a merge conflict).

Cheers,

Will

--->8

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to fac956710ab0812f9e395e9f7a27da551412830f:

  iommu/arm-smmu-v3: Stop pre-zeroing batch commands (2021-08-13 14:26:06 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.15

- SMMUv3

  * Minor optimisation to avoid zeroing struct members on CMD submission

  * Increased use of batched commands to reduce submission latency

  * Refactoring in preparation for ECMDQ support

- SMMUv2

  * Fix races when probing devices with identical StreamIDs

  * Optimise walk cache flushing for Qualcomm implementations

  * Allow deep sleep states for some Qualcomm SoCs with shared clocks

----------------------------------------------------------------
Ashish Mhetre (1):
      iommu: Fix race condition during default domain allocation

John Garry (2):
      iommu/arm-smmu-v3: Remove some unneeded init in arm_smmu_cmdq_issue_cmdlist()
      iommu/arm-smmu-v3: Stop pre-zeroing batch commands

Krishna Reddy (1):
      iommu/arm-smmu: Fix race condition during iommu_group creation

Sai Prakash Ranjan (2):
      iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to system pm callbacks
      iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom implementation

Zhen Lei (4):
      iommu/arm-smmu-v3: Use command queue batching helpers to improve performance
      iommu/arm-smmu-v3: Add and use static helper function arm_smmu_cmdq_issue_cmd_with_sync()
      iommu/arm-smmu-v3: Add and use static helper function arm_smmu_get_cmdq()
      iommu/arm-smmu-v3: Extract reusable function __arm_smmu_cmdq_skip_err()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 89 +++++++++++++++++------------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c  | 11 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 45 ++++++++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu.h       |  1 +
 drivers/iommu/iommu.c                       |  2 +
 5 files changed, 106 insertions(+), 42 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
