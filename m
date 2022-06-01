Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FD2CCA473
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 14:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CD594174F;
	Wed,  1 Jun 2022 14:51:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xhDcPNRgJs69; Wed,  1 Jun 2022 14:51:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1260241717;
	Wed,  1 Jun 2022 14:51:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2BC7C0032;
	Wed,  1 Jun 2022 14:51:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83C1AC002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 14:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7278A4171E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 14:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jfltHrSmfpLO for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 14:51:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0EBA41717
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 14:51:15 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id b135so2182077pfb.12
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jun 2022 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9Di3AWHfW2BtAUx+vGxYzLY0UoxmZ/0cEx6rZNq/IzQ=;
 b=F5M1gdd1//KZvxx+bojh2vf8rGxdfR/UiBy9WQbK8XpcJkbLuuAKuovT8O6O190tOn
 13+aCTaADNFZr7O9eQAXwZxMy6eHSU2RbvA15JbsD7t+A6CHncAVF68uCkaPqFJ0lfi0
 5dhmh/ftBV9ryrgNlsyFYl3Fdf/hH38oNqYX70lWFYXWR3PmohRY3Us9Kvko+m3qBb45
 Iuw7pu7sn00h9jE4p0VC2kU3zo0JCOQWXc6MLGP/O1E80vRgs4T8dq9WSMeEaLXC3Bw6
 GsfWiZjvjzH8/zEHtYhpD3WG2CkrxqRsCNtoR3oq0lLWxo1NhifLs4WAMnoGweC2ttP/
 79wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9Di3AWHfW2BtAUx+vGxYzLY0UoxmZ/0cEx6rZNq/IzQ=;
 b=gO5hZHoYdZU1P3pKdwNYlBBFwYbUE0ZnoXQmdebv51DbpLsMEJaPJbinlO4ceNRubg
 J8mTHSOUCjT6CQ0uXSYJ0Em7EX/XbbuUKvZ0Z1pZ4qeQBvBBep1WJFH9H/mf9c0238wt
 i2hCNTBdZbqOe9fS4djml2kbmvLjV8Py/SmSPSPBx67ARqyiqcZlFGi/NrJBtk1UW+bt
 YeO/3s1K/9ippONj+jLOVEHa2OYx8t7KLFutkpQuPJjdq/ZA/uGiKixomE9ov61pU/n5
 gCB99Yta8/oBAQ0yjZJ7tNtBnlWBgWnynqD+V7/a2koQn/MS9owsDxnipEOxNoAQ9uP4
 JIaw==
X-Gm-Message-State: AOAM530nyoMoBmP2jAtYZDePVjnz3HK/sFlWE8DsUVc86o+T0DN5t2t9
 +dTkTF18yLpWzTvWYOl+Nc4=
X-Google-Smtp-Source: ABdhPJz9f79ygetP+6T69yOPHwSS/S9j4pj9KLO4dR2e/0Cf8gyv0fo6E+OzSx2kzLuYhi9Pr8/wAQ==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id
 h1-20020a056a00218100b0051b560bdd30mr13725422pfi.44.1654095075073; 
 Wed, 01 Jun 2022 07:51:15 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
 by smtp.gmail.com with ESMTPSA id
 w124-20020a623082000000b0050dc76281f8sm1588608pfw.210.2022.06.01.07.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jun 2022 07:51:13 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] dma-debug: Make things less spammy under memory pressure
Date: Wed,  1 Jun 2022 07:51:16 -0700
Message-Id: <20220601145116.280040-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

From: Rob Clark <robdclark@chromium.org>

Limit the error msg to avoid flooding the console.  If you have a lot of
threads hitting this at once, they could have already gotten passed the
dma_debug_disabled() check before they get to the point of allocation
failure, resulting in quite a lot of this error message spamming the
log.  Use pr_err_once() to limit that.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
v2: Use pr_err_once() instead of ratelimited, and spiff out commit msg a bit.

 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index f8ff598596b8..754e3456f017 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -564,7 +564,7 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 
 	rc = active_cacheline_insert(entry);
 	if (rc == -ENOMEM) {
-		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
+		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
 	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		err_printk(entry->dev, entry,
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
