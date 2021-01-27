Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EF1C433E6
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 16:29:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29E0207A0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 16:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29E0207A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7080787203;
	Wed, 27 Jan 2021 16:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GDrP3J5UuA2I; Wed, 27 Jan 2021 16:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8534C87201;
	Wed, 27 Jan 2021 16:29:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67060C0FA7;
	Wed, 27 Jan 2021 16:29:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 735B1C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 16:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6313D84B80
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 16:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JlvfMYeU6cLu for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 16:29:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A952B84DD4
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 16:29:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47F7511FB;
 Wed, 27 Jan 2021 08:29:38 -0800 (PST)
Received: from DESKTOP-VLO843J.arm.com (unknown [10.57.47.135])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BAA8E3F66E;
 Wed, 27 Jan 2021 08:29:36 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 2/2] iommu/io-pgtable: Remove TLBI_ON_MAP quirk
Date: Wed, 27 Jan 2021 16:29:29 +0000
Message-Id: <5abb80bba3a7c371d5ffb7e59c05586deddb9a91.1611764372.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e95223a0abf129230a0bec6743f837075f0a2fcb.1611764372.git.robin.murphy@arm.com>
References: <e95223a0abf129230a0bec6743f837075f0a2fcb.1611764372.git.robin.murphy@arm.com>
Cc: architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, srinivas.kandagatla@linaro.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IO_PGTABLE_QUIRK_TLBI_ON_MAP is now fully superseded by the
core API's iotlb_sync_map callback.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 8 +-------
 include/linux/io-pgtable.h         | 5 -----
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 1d92ac948db7..3a92f06aad43 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -535,12 +535,7 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	 * Synchronise all PTE updates for the new mapping before there's
 	 * a chance for anything to kick off a table walk for the new iova.
 	 */
-	if (iop->cfg.quirks & IO_PGTABLE_QUIRK_TLBI_ON_MAP) {
-		io_pgtable_tlb_flush_walk(iop, iova, size,
-					  ARM_V7S_BLOCK_SIZE(2));
-	} else {
-		wmb();
-	}
+	wmb();
 
 	return ret;
 }
@@ -759,7 +754,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
 			    IO_PGTABLE_QUIRK_NO_PERMS |
-			    IO_PGTABLE_QUIRK_TLBI_ON_MAP |
 			    IO_PGTABLE_QUIRK_ARM_MTK_EXT |
 			    IO_PGTABLE_QUIRK_NON_STRICT))
 		return NULL;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 2a5686ca2ba3..06753323a15e 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -68,10 +68,6 @@ struct io_pgtable_cfg {
 	 *	hardware which does not implement the permissions of a given
 	 *	format, and/or requires some format-specific default value.
 	 *
-	 * IO_PGTABLE_QUIRK_TLBI_ON_MAP: If the format forbids caching invalid
-	 *	(unmapped) entries but the hardware might do so anyway, perform
-	 *	TLB maintenance when mapping as well as when unmapping.
-	 *
 	 * IO_PGTABLE_QUIRK_ARM_MTK_EXT: (ARM v7s format) MediaTek IOMMUs extend
 	 *	to support up to 34 bits PA where the bit32 and bit33 are
 	 *	encoded in the bit9 and bit4 of the PTE respectively.
@@ -88,7 +84,6 @@ struct io_pgtable_cfg {
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
-	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
 	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT	BIT(3)
 	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(4)
 	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
