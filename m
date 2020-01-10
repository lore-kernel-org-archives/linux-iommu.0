Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D06DC282DD
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:29:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5108020838
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLkuLRiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5108020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3387186B83;
	Fri, 10 Jan 2020 15:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QeWRwcFB6jlH; Fri, 10 Jan 2020 15:28:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFDCA86B20;
	Fri, 10 Jan 2020 15:28:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92770C1D7D;
	Fri, 10 Jan 2020 15:28:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DC6BC0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2045D87C91
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vc2lTGKDPFJh for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 15:28:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7FA1187C8C
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 35C6E2072E;
 Fri, 10 Jan 2020 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578670137;
 bh=ahdxfdIjALO4E1DfYPrQ3mWPi2V7mWynaKkIQzETaJ0=;
 h=From:To:Cc:Subject:Date:From;
 b=PLkuLRiHhENh4kbiHti7nMQR83afwfNZ1SCnF9R8bBSi/5+zaXkGEWh2ZFnR8fWGi
 0LVlLE1TFGJ4df+gdQzGuj0Fcf6kpQSBKB0r6Ubph2C2XR6+EGWYecSCV01RR5piEh
 jAj5CE4jIsyosrFSO+SusBszgYX5LYqbGhdEKSOA=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 0/8] Finish off the split page table prep work
Date: Fri, 10 Jan 2020 15:28:44 +0000
Message-Id: <20200110152852.24259-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Last merge window, I merged most of the split page table prep work from Robin
[1], but there were a few patches left pending some rework. I think Robin was
hoping to get that done for 5.5, but what with the holidays falling like they
did and other committments, I've ended up picked up the bits that were left
over.

I'm pretty limited with regards to SMMU hardware on which I can test this lot,
so I might have broken something.

Applies against for-joerg/arm-smmu/updates.

Will

[1] https://lore.kernel.org/lkml/20191104202012.GN24909@willie-the-truck

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jordan Crouse <jcrouse@codeaurora.org>

--->8

Robin Murphy (3):
  iommu/io-pgtable-arm: Rationalise TTBRn handling
  iommu/io-pgtable-arm: Rationalise TCR handling
  iommu/io-pgtable-arm: Prepare for TTBR1 usage

Will Deacon (5):
  iommu/io-pgtable-arm: Support non-coherent stage-2 page tables
  iommu/io-pgtable-arm: Ensure non-cacheable mappings are Outer
    Shareable
  iommu/io-pgtable-arm: Ensure ARM_64_LPAE_S2_TCR_RES1 is unsigned
  iommu/arm-smmu: Rename public #defines under ARM_SMMU_ namespace
  iommu/io-pgtable-arm: Rationalise VTCR handling

 drivers/iommu/arm-smmu-impl.c      |   2 +-
 drivers/iommu/arm-smmu-v3.c        |  60 ++++----
 drivers/iommu/arm-smmu.c           | 171 ++++++++++++----------
 drivers/iommu/arm-smmu.h           | 228 ++++++++++++++++++-----------
 drivers/iommu/io-pgtable-arm-v7s.c |  23 ++-
 drivers/iommu/io-pgtable-arm.c     | 155 +++++++++-----------
 drivers/iommu/io-pgtable.c         |   2 +-
 drivers/iommu/ipmmu-vmsa.c         |   2 +-
 drivers/iommu/msm_iommu.c          |   4 +-
 drivers/iommu/mtk_iommu.c          |   4 +-
 drivers/iommu/qcom_iommu.c         |  25 ++--
 include/linux/io-pgtable.h         |  27 +++-
 12 files changed, 381 insertions(+), 322 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
