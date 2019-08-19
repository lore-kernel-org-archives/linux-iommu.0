Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754B3C3A5A0
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 18:19:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A91822CF5
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 18:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A91822CF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 160B3E18;
	Mon, 19 Aug 2019 18:19:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A1267DF2
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 18:19:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4F4888A0
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 18:19:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0603360;
	Mon, 19 Aug 2019 11:19:35 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D565D3F246; 
	Mon, 19 Aug 2019 11:19:34 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 0/4] iommu/io-pgtable: Cleanup and prep for split tables
Date: Mon, 19 Aug 2019 19:19:27 +0100
Message-Id: <cover.1566238530.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

Hi all,

Although the io-pgtable-arm formats started out with the notion of being
able to provide a complete ready-to-use context for VMSA-compliant users
to consume, the reality is that users inevitably still have to make their
own adjustments to that context anyway. Worse, though, is that some of
that cruft starts actively getting in the way of future work like
supporting split tables using both TTBRs.

These patches clean things up by stripping io-pgatble's context back to
just the parts directly relevant to what it abstracts, and formalising
the expectation that this only forms a basis from which users can
construct their own complete context.

Series based on v2 of "Arm SMMU refactoring" here:
https://patchwork.kernel.org/patch/11096263/

Robin.


Robin Murphy (4):
  iommu/io-pgtable-arm: Rationalise MAIR handling
  iommu/io-pgtable-arm: Rationalise TTBRn handling
  iommu/io-pgtable-arm: Rationalise TCR handling
  iommu/io-pgtable-arm: Prepare for TTBR1 usage

 drivers/iommu/arm-smmu-v3.c        | 11 +++--------
 drivers/iommu/arm-smmu.c           | 14 +++++++-------
 drivers/iommu/arm-smmu.h           |  2 ++
 drivers/iommu/io-pgtable-arm-v7s.c | 22 +++++++++-------------
 drivers/iommu/io-pgtable-arm.c     | 23 +++++++++--------------
 drivers/iommu/ipmmu-vmsa.c         |  4 ++--
 drivers/iommu/msm_iommu.c          |  4 ++--
 drivers/iommu/mtk_iommu.c          |  4 ++--
 drivers/iommu/qcom_iommu.c         |  9 ++++-----
 include/linux/io-pgtable.h         |  6 +++---
 10 files changed, 43 insertions(+), 56 deletions(-)

-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
