Return-Path: <SRS0=UwG5=XG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92547C5ACAE
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 14:42:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF2E2053B
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 14:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF2E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D31601390;
	Wed, 11 Sep 2019 14:42:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 477B31382
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 14:42:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id ECA0D8A3
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 14:42:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D89615A2;
	Wed, 11 Sep 2019 07:42:20 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 444063F67D; 
	Wed, 11 Sep 2019 07:42:19 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Subject: [PATCH 3/3] iommu/io-pgtable-arm: Allow coherent walks for Mali
Date: Wed, 11 Sep 2019 15:42:09 +0100
Message-Id: <8eb563978e7e872ddde45c0413e1a3f30b792658.1568211045.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1568211045.git.robin.murphy@arm.com>
References: <cover.1568211045.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: robh@kernel.org, tomeu.vizoso@collabora.com, narmstrong@baylibre.com,
	steven.price@arm.com, iommu@lists.linux-foundation.org,
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

Midgard GPUs have ACE-Lite master interfaces which allows systems to
integrate them in an I/O-coherent manner. It seems that from the GPU's
viewpoint, the rest of the system is its outer shareable domain, and it
will only emit snoop signals for outer shareable accesses. As such,
setting the TTBR_SHARE_OUTER bit does indeed get coherent pagetable
walks working nicely.

Making data accesses coherent seems to be more of a challenge...

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 77f41c9dd9be..2794d4661339 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1061,6 +1061,9 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	cfg->arm_mali_lpae_cfg.transtab = virt_to_phys(data->pgd) |
 					  ARM_MALI_LPAE_TTBR_READ_INNER |
 					  ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
+	if (cfg->coherent_walk)
+		cfg->arm_mali_lpae_cfg.transtab |= ARM_MALI_LPAE_TTBR_SHARE_OUTER;
+
 	return &data->iop;
 
 out_free_data:
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
