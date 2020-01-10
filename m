Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7FEC33CA4
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:29:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A2F20838
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRw2ANs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A2F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0C85C87D63;
	Fri, 10 Jan 2020 15:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXf5oKRdOAFb; Fri, 10 Jan 2020 15:29:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9802F87D76;
	Fri, 10 Jan 2020 15:29:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A706C1D7D;
	Fri, 10 Jan 2020 15:29:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B328C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3826082D5F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09jT2aUMD7gg for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 15:29:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C72DA81E5E
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7398A2082E;
 Fri, 10 Jan 2020 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578670143;
 bh=WdNwMexkPV2ze5lGJ306FvJuZTOCE1fFYBtTnKvVsxc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kRw2ANs+mELhK95I5zvuJVCnWVpW4DkCb0IPWkWCXHF+51M3VBh/NOJeb9roRwUZF
 mwzJf7xKTpylH7PUypG0ctOSfbf0CerHi3mbzQjshQqRyDB5W///f/FE/AIgUK1rM3
 mByl6iAvb74IDF3cbFbWxsdRebMIhhal3XrVJbHs=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 4/8] iommu/io-pgtable-arm: Ensure ARM_64_LPAE_S2_TCR_RES1 is
 unsigned
Date: Fri, 10 Jan 2020 15:28:48 +0000
Message-Id: <20200110152852.24259-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110152852.24259-1-will@kernel.org>
References: <20200110152852.24259-1-will@kernel.org>
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

ARM_64_LPAE_S2_TCR_RES1 is intended to map to bit 31 of the VTCR register,
which is required to be set to 1 by the architecture. Unfortunately, we
accidentally treat this as a signed quantity which means we also set the
upper 32 bits of the VTCR to one, and they are required to be zero.

Treat ARM_64_LPAE_S2_TCR_RES1 as unsigned to avoid the unwanted
sign-extension up to 64 bits.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4b437ead2300..89216bf37282 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -101,7 +101,7 @@
 
 /* Register bits */
 #define ARM_32_LPAE_TCR_EAE		(1 << 31)
-#define ARM_64_LPAE_S2_TCR_RES1		(1 << 31)
+#define ARM_64_LPAE_S2_TCR_RES1		(1U << 31)
 
 #define ARM_LPAE_TCR_EPD1		(1 << 23)
 
-- 
2.25.0.rc1.283.g88dfdc4193-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
