Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FB9CA9EBD
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 18:08:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1664F2070B
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 18:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1664F2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BE1F1DC8;
	Fri, 25 Oct 2019 18:08:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 40FE2DBB
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 18:08:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id CE6D389D
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 18:08:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8E828;
	Fri, 25 Oct 2019 11:08:43 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 981493F6C4; 
	Fri, 25 Oct 2019 11:08:42 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH v2 00/10] iommu/io-pgtable: Cleanup and prep for split tables
Date: Fri, 25 Oct 2019 19:08:29 +0100
Message-Id: <cover.1572024119.git.robin.murphy@arm.com>
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

Since the flawed first attempt, I've reworked things with an abstracted
TCR and an explicit TTBR1 quirk. I originally envisaged the need to pass
the quirk all the way down to the TLBI calls, hence getting diverted
into trying to make the parameter passing less cluttered in general, but
in the end it turned out fairly neat to just fix the indexing such that
we can always just pass around the original unmodified IOVA. Most of the
new patches come from staring at that indexing code for long enough to
see the subtle inefficiencies that were worth ironing out, plus a bit of
random cleanup which doesn't feel worth posting separately.

Note that these patches depend on the fixes already queued in -rc4,
otherwise there will be conflicts in arm_mali_lpae_alloc_pgtable().

Robin.


Robin Murphy (10):
  iommu/io-pgtable: Make selftest gubbins consistently __init
  iommu/io-pgtable-arm: Rationalise size check
  iommu/io-pgtable-arm: Simplify bounds checks
  iommu/io-pgtable-arm: Simplify start level lookup
  iommu/io-pgtable-arm: Simplify PGD size handling
  iommu/io-pgtable-arm: Simplify level indexing
  iommu/io-pgtable-arm: Rationalise MAIR handling
  iommu/io-pgtable-arm: Rationalise TTBRn handling
  iommu/io-pgtable-arm: Rationalise TCR handling
  iommu/io-pgtable-arm: Prepare for TTBR1 usage

 drivers/iommu/arm-smmu-v3.c        |  45 ++----
 drivers/iommu/arm-smmu.c           |  20 +--
 drivers/iommu/arm-smmu.h           |  27 ++++
 drivers/iommu/io-pgtable-arm-v7s.c |  37 +++--
 drivers/iommu/io-pgtable-arm.c     | 238 ++++++++++++++---------------
 drivers/iommu/io-pgtable.c         |   2 +-
 drivers/iommu/ipmmu-vmsa.c         |   4 +-
 drivers/iommu/msm_iommu.c          |   4 +-
 drivers/iommu/mtk_iommu.c          |   4 +-
 drivers/iommu/qcom_iommu.c         |  15 +-
 include/linux/io-pgtable.h         |  19 ++-
 11 files changed, 209 insertions(+), 206 deletions(-)

-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
