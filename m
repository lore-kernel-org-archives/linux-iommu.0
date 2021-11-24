Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D60C433EF
	for <iommu@archiver.kernel.org>; Thu, 25 Nov 2021 03:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16595607FB;
	Thu, 25 Nov 2021 03:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6gyaR-cFCGV4; Thu, 25 Nov 2021 03:05:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E0F0B60655;
	Thu, 25 Nov 2021 03:05:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95FADC0038;
	Thu, 25 Nov 2021 03:05:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E989C0012
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 02:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0542C4011B
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 02:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NfUjYRbsG5Hu for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:14:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7989400A6
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 02:14:10 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id r8so1255573wra.7
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 18:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xe4o5Gm3OMdjS63wMnh/ZOlXxoaUWg1l/47qZWglxBI=;
 b=MOSdU1seSeuiSwHUZmk1UhtByoEtzLLRNtdxo0+O4R/7fz4+UeAjOE/Mk9Ow0CSnwq
 3gb8XKhUiw9t3A2lNpl3q5eiIcczC0zHyXPk+jtyM7uSucofkydcKRAj9qKlU+f450YM
 LKM1Suhlyj0yFzGEXiMjzWFh6oCfK04M97deJZ7clVgwi9v7EiyH7UZIfMFbssRYuF1L
 Ih3dfWs8WVzPdYnFBSF/YqpT8bXE85pWjbkFg6Dd1iVfQsXbF0TVt2Ng4cN0fOaW5cjK
 omgfVDAqexKTRZG8mxcZXQaPMnLyKSNmw3orJQkcewv4zXczLHCd4PHMKp7u59S+PCSH
 AbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xe4o5Gm3OMdjS63wMnh/ZOlXxoaUWg1l/47qZWglxBI=;
 b=cM2MQtZa3jcaKig8cxg+kFJTL6rchNzSpLPSt5I4JxDLdpjnX2qHyz8ZnKVJ86rRvV
 31NTwYI05GDyD9JgwfKgGZowdF5e0M9xi5FZeoNGNnmXjXMR1REErEuLdPmWiVZtVk27
 cYn/D8YUMdoPqqPfhLXG25CwVx9DtVreviLV8sX1xrcPfPbkY5V2X0ve7yjRb7Q0tLkQ
 iZUek7gNTjr+Eig53f4YNyKhYR0msMj3jPLQ/wZh5DEDit18PRl8NB0UvJZKL/eZHDRn
 1pQ80QyBiSxQWIK/juW1DHd2dy2Qhd5m+y2RLtRxHNBN9pJ69+NmwxSECQXNTzwYPsXd
 hm/w==
X-Gm-Message-State: AOAM533DQIh7Aj4nfpIwOC0Z+uPmQK1xLZ2CRESTqR0dpkU0zeL0+JI9
 KBJzvA0WLYVfK4rAMxkbFg==
X-Google-Smtp-Source: ABdhPJxya3jKNOzfMuNmHXXGJbUVr3esV/uhag0CYzu7qmZmXnsDI9xK9zK5GsJCJLZTYTGmQtQ6lA==
X-Received: by 2002:adf:e848:: with SMTP id d8mr13671517wrn.3.1637720048717;
 Tue, 23 Nov 2021 18:14:08 -0800 (PST)
Received: from alex-ThinkPad-E480.. (ip5b435a69.dynamic.kabel-deutschland.de.
 [91.67.90.105])
 by smtp.googlemail.com with ESMTPSA id c6sm3909458wmq.46.2021.11.23.18.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 18:14:08 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568
Date: Wed, 24 Nov 2021 03:13:25 +0100
Message-Id: <20211124021325.858139-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 25 Nov 2021 03:05:04 +0000
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 linux-kernel@vger.kernel.org, Alex Bee <knaerzche@gmail.com>,
 linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
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

With the submission of iommu driver for RK3568 a subtle bug was
introduced: PAGE_DESC_HI_MASK1 and PAGE_DESC_HI_MASK2 have to be
the other way arround - that leads to random errors, especially when
addresses beyond 32 bit are used.

Fix it.

Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

I've found this bug, when testing the recent VOP2 submission, which is
the first perpherial which uses iommu for RK356x. I could use it on my
quartz64 8GB board only, when limiting the available memory to less 4GB.

This patch fixes it.

 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 5cb260820eda..7f23ad61c094 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -200,8 +200,8 @@ static inline phys_addr_t rk_dte_pt_address(u32 dte)
 #define DTE_HI_MASK2	GENMASK(7, 4)
 #define DTE_HI_SHIFT1	24 /* shift bit 8 to bit 32 */
 #define DTE_HI_SHIFT2	32 /* shift bit 4 to bit 36 */
-#define PAGE_DESC_HI_MASK1	GENMASK_ULL(39, 36)
-#define PAGE_DESC_HI_MASK2	GENMASK_ULL(35, 32)
+#define PAGE_DESC_HI_MASK1	GENMASK_ULL(35, 32)
+#define PAGE_DESC_HI_MASK2	GENMASK_ULL(39, 36)
 
 static inline phys_addr_t rk_dte_pt_address_v2(u32 dte)
 {
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
