Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023EFC433B4
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:33:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51DC610CB
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51DC610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 788D54146B;
	Fri,  2 Apr 2021 14:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iErEY6dat7cF; Fri,  2 Apr 2021 14:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E82940FA3;
	Fri,  2 Apr 2021 14:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02F5DC000B;
	Fri,  2 Apr 2021 14:33:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30CE1C000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D81D84C81
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NVZUgzb9wCqr for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 14:33:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7042F84C77
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=O6atzcUAuHyx4KNuM3iyA6420Zclk51V2q1xoL6iKGk=; b=MZwBTi/4DHEnvBYR+ioQbSquSs
 TE6eVxdeJ6A37dOCVfGkKXaudLWmC5j2miFI9ipDqXQvi3qXqFlGW7zGAuY0djSUGWmU8lt66iScH
 bTD7Rbhehf9rebFA4C3DhyvipBTjc4bIm3AsBba7xDac1gL7RmqjKfuLtsLpWUXqxsO5Hzo2bLyKE
 fYYESK5GsvK8mLh/kNWg3N2KR8smeSlK2PFoYMycQOcPbz4NDHoZ9KcEdR+rsana11UC5YnOtYc3z
 FSnTompFd7AHGESj13xY5SjwTFZJUqNTQMmhala9VxFxA9DSQDRZXsgUYNz1ZFYkjzASQDU1WqV5m
 IbqzDgdA==;
Received: from [2001:4bb8:180:7517:6acc:e698:6fa4:15da] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lSKrS-00FAFc-Cs; Fri, 02 Apr 2021 14:33:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/4] iommu/amd: remove a few unused exports
Date: Fri,  2 Apr 2021 16:33:11 +0200
Message-Id: <20210402143312.372386-4-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210402143312.372386-1-hch@lst.de>
References: <20210402143312.372386-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org
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

Remove exports for functions that are only used in the AMD IOMMU driver
itself, or the also always builtin perf events support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/amd/init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 321f5906e6ed3a..52ede54d7cc97a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -208,7 +208,6 @@ u16 *amd_iommu_alias_table;
  * for a specific device. It is also indexed by the PCI device id.
  */
 struct amd_iommu **amd_iommu_rlookup_table;
-EXPORT_SYMBOL(amd_iommu_rlookup_table);
 
 /*
  * This table is used to find the irq remapping table for a given device id
@@ -268,7 +267,6 @@ bool translation_pre_enabled(struct amd_iommu *iommu)
 {
 	return (iommu->flags & AMD_IOMMU_FLAG_TRANS_PRE_ENABLED);
 }
-EXPORT_SYMBOL(translation_pre_enabled);
 
 static void clear_translation_pre_enabled(struct amd_iommu *iommu)
 {
@@ -3277,7 +3275,6 @@ struct amd_iommu *get_amd_iommu(unsigned int idx)
 			return iommu;
 	return NULL;
 }
-EXPORT_SYMBOL(get_amd_iommu);
 
 /****************************************************************************
  *
@@ -3359,7 +3356,6 @@ int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
 
 	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, false);
 }
-EXPORT_SYMBOL(amd_iommu_pc_get_reg);
 
 int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)
 {
@@ -3368,4 +3364,3 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
 
 	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
 }
-EXPORT_SYMBOL(amd_iommu_pc_set_reg);
-- 
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
