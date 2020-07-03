Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3083DC433E1
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 16:26:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012AB20760
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 16:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1qYfEO29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012AB20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE36C88C3F;
	Fri,  3 Jul 2020 16:26:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XXYGFIrIpMFn; Fri,  3 Jul 2020 16:26:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 03AED88C30;
	Fri,  3 Jul 2020 16:26:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECAA3C0888;
	Fri,  3 Jul 2020 16:26:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C7EFC0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 73142231AB
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bXTp6aKF5dMk for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 16:25:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 29D1A21503
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 36E912073E;
 Fri,  3 Jul 2020 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593793559;
 bh=7F1X4zquMazIejX1qFVDckVNrvMQPCeEeV21KqUMgQw=;
 h=From:To:Cc:Subject:Date:From;
 b=1qYfEO29U/AR6nzkGg3y7uXyIAPVmDGsC8iauC523Qrz/zmUTIsIMZBI3AcANp5iz
 8Z1CHFffsgekV8r2xrpsOXCwK8F0VEAZ3FggIUNUCSFW8aS2dI7XzBGhZvONg7RVJW
 QKqSNJqxFwa3sfgtV77ajRS7v63QOdPSfAPGzVW0=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag
Date: Fri,  3 Jul 2020 17:25:48 +0100
Message-Id: <20200703162548.19953-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
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

The IOMMU_SYS_CACHE_ONLY flag was never exposed via the DMA API and
has no in-tree users. Remove it.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Will Deacon <will@kernel.org>
---

As discussed in [1], sounds like this should be a domain attribute anyway
when it's needed by the GPU.

[1] https://lore.kernel.org/r/CAF6AEGsCROVTsi2R7_aUkmH9Luoc_guMR0w0KUJc2cEgpfj79w@mail.gmail.com

 drivers/iommu/io-pgtable-arm.c | 3 ---
 include/linux/iommu.h          | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 04fbd4bf0ff9..8f175c02f8e3 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -438,9 +438,6 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		else if (prot & IOMMU_CACHE)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
-		else if (prot & IOMMU_SYS_CACHE_ONLY)
-			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
-				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	}
 
 	if (prot & IOMMU_CACHE)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5f0b7859d2eb..bee1a8fa1fb1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -31,12 +31,6 @@
  * if the IOMMU page table format is equivalent.
  */
 #define IOMMU_PRIV	(1 << 5)
-/*
- * Non-coherent masters can use this page protection flag to set cacheable
- * memory attributes for only a transparent outer level of cache, also known as
- * the last-level or system cache.
- */
-#define IOMMU_SYS_CACHE_ONLY	(1 << 6)
 
 struct iommu_ops;
 struct iommu_group;
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
