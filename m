Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21885C43141
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 00:26:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97AD20730
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 00:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tuogm33j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97AD20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A373186DCB;
	Thu, 21 Nov 2019 00:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wV4iFvpGiNs1; Thu, 21 Nov 2019 00:26:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EFC1286DC0;
	Thu, 21 Nov 2019 00:26:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD7ECC1DDA;
	Thu, 21 Nov 2019 00:26:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F454C18DA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 00:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6E57387B49
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 00:14:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id codaWugsd45M for <iommu@lists.linux-foundation.org>;
 Thu, 21 Nov 2019 00:14:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B162887A87
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 00:14:26 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id p24so654403pfn.4
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 16:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kfKghOlAVdXJ9nfsLtttD5S8horVMD6tIcv1KXk7i6Q=;
 b=Tuogm33jDXPZQJ6ZKv8LQJplcWUWjzjl/wA4KFiUV6FkZILpe6RA/EdesM14ALY1os
 WOnWk1+8B5hfeWjVJALL5VfKIsj16534gZhMaHenObMJALz0oYmbwg7yp78AZI7X3G3l
 ce0j6/xZ8KXvWd+ZPwrXVFYcwQEp1PNAJXfPheQLIyK11RURr7QVckyBMTvPqa37ndW+
 dBEa8IDAbs2NgXYL39nJQ09HvVGTTzseBzjfST0gQi+OAeyuKxKF/MhNHrbmJfKf+gJc
 KWLn1l7qxEm7K/l7P0BzyiTbV7l8VsTAH9c6Tm8v3UX4HG9s1DXRTq52zcCOCCz3vXOL
 H52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kfKghOlAVdXJ9nfsLtttD5S8horVMD6tIcv1KXk7i6Q=;
 b=s4Hono701thTTZ9cKvW0a5D/3W9uBq2Y9FpR8jvk25PmUiR5kdKs1pelT0/1GeQ86E
 8EmqIQbTIIZTw0IR9t9OM8XNPS7/wxCSEWZ0oE5sMhxpMFSPP1EP6HNLGfLSKNoU6XVb
 7la9Ga7S7CAk02gAwN9qlvp1bIZIn4pH6C3xGEBY3PLU90bb5dX3u+G7m9Rvj9EfHS3r
 xnrgp+E7Jdu7l8SmL8QnVsLx3A9jZ3M84W0sBGF9nT13AtaxrloRtXygM7TgDv7cDtFD
 HowAavT449vZxuKY3sZUy5zg/HyBd0kHvvCD+Eo2gguXCT6wUKU7+znIKANx/7bIXjz4
 5Cxw==
X-Gm-Message-State: APjAAAV6PDTCZ6vNH5IKn7xMg+/9TBQDjCGyhmI8p/RwWBSRQ01Zl9Ky
 5oNxvRn9x5msZFMolNe6MECaWCXgMt0=
X-Google-Smtp-Source: APXvYqxSr9HND1eosZsevZQVdQF2PwZ14FVyCJA1A6sxDt0kyZSGxo/xFby5xXAgo8T7nROhtmBLFw==
X-Received: by 2002:a65:6209:: with SMTP id d9mr6459220pgv.220.1574295266086; 
 Wed, 20 Nov 2019 16:14:26 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
 by smtp.gmail.com with ESMTPSA id r4sm565981pfl.61.2019.11.20.16.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 16:14:25 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/3] iommu: optimize iova_magazine_free_pfns()
Date: Wed, 20 Nov 2019 16:13:47 -0800
Message-Id: <20191121001348.27230-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
References: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 21 Nov 2019 00:26:19 +0000
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org
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

If the maganize is empty, iova_magazine_free_pfns() should
be a nop, however it misses the case of mag->size==0. So we
should just call iova_magazine_empty().

This should reduce the contention on iovad->iova_rbtree_lock
a little bit.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 92f72a85e62a..b82c6f1cbfc2 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
 	kfree(mag);
 }
 
+static bool iova_magazine_full(struct iova_magazine *mag)
+{
+	return (mag && mag->size == IOVA_MAG_SIZE);
+}
+
+static bool iova_magazine_empty(struct iova_magazine *mag)
+{
+	return (!mag || mag->size == 0);
+}
+
 static void
 iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 {
 	unsigned long flags;
 	int i;
 
-	if (!mag)
+	if (iova_magazine_empty(mag))
 		return;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
@@ -820,16 +830,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	mag->size = 0;
 }
 
-static bool iova_magazine_full(struct iova_magazine *mag)
-{
-	return (mag && mag->size == IOVA_MAG_SIZE);
-}
-
-static bool iova_magazine_empty(struct iova_magazine *mag)
-{
-	return (!mag || mag->size == 0);
-}
-
 static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 				       unsigned long limit_pfn)
 {
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
