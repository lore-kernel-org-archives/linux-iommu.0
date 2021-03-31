Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5543C433C1
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 03:17:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE1F619A7
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 03:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE1F619A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1143540635;
	Wed, 31 Mar 2021 03:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pk7R4PpBLq8N; Wed, 31 Mar 2021 03:17:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F0804062F;
	Wed, 31 Mar 2021 03:17:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87A0FC000C;
	Wed, 31 Mar 2021 03:17:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1C33C000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 03:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C87C184299
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 03:17:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23nX4avMrbLE for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 03:17:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C11BD8418E
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 03:17:00 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id f3so3962290pgv.0
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 20:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YH7VyiloQmk21ZwkKDneMtghe+woErBUyGKt9DFQjxs=;
 b=M1Tx1fUmT1JZxICY8e/FPzijoytFN1mZY9tk4CIinK2+uwuX2m0XQgS+Z9e8taB8R5
 2ITcVOgv+upLlraexefx1xv9llhTWV0WONT+op8/4RDPgvRbs0B14UWgFDgvzhwfB/79
 vOw0HQV4torLVutoe9riI8nsuCs79yx0iH9jXbqNQUtKE7Ck0QaIs5jFHVMfVLG1MmWM
 lvVwY2l/oANDY3DPgh6snCF/OHggdnKWZbe/oxdT63nploswOVK2UG5buUFn3/mSXJfZ
 /6gP85L2fR5by6Cw5wmfi2S6SzgbDyVS+UfRis4mfgAcBPzfeR7Vel9jqjNa1ywxewGK
 xPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YH7VyiloQmk21ZwkKDneMtghe+woErBUyGKt9DFQjxs=;
 b=cYXyH+yheDR0bXhgDVXrLsoY7OcsCZnQV3WzA+6wJbHz4iC7O8/dZC9RH31Ivajucv
 TDqLCVRuh5tj/KjPGzWRFCmUksFBY1oHakh4iYLuwHLD+d8hMV9hqvdc6KGyxrgm/sMR
 RxsRmYsr7lSOvSMwL3rFBLPINEIE6+Cbm50flzrmhDJ1u6F5mbgh7A4jBmlGrPRHGgFE
 PKNvZbCT8waFthj8pXSR42rf84iTR67ScGhIT20L6uPbuLwSxBcHZJTPS+2f2fj1iLTx
 yuMUVaiALaIJJQ9r48pW8qp4po9j0owrv3n2mP36FP34KiG3n3VJn5vervFaBwD879UI
 6dQw==
X-Gm-Message-State: AOAM533VfkUp7fw+KVjf/s6JooVEtesa2KBXOJHseMl2O8I+RPN749IC
 5vemXSjUPYk3kqaMurs0TM0=
X-Google-Smtp-Source: ABdhPJy8eCVIy9HA8af7r53Q+VB4Rdwh8r/F74zYBiwOL5AvZFNsag+DAvSF2ZRDijJ5mzKgEdVMew==
X-Received: by 2002:a62:6451:0:b029:20e:f351:f1e with SMTP id
 y78-20020a6264510000b029020ef3510f1emr1013447pfb.54.1617160620192; 
 Tue, 30 Mar 2021 20:17:00 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id j26sm390204pfn.47.2021.03.30.20.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 20:16:59 -0700 (PDT)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: sprd: Fix parameter type warning
Date: Wed, 31 Mar 2021 11:16:45 +0800
Message-Id: <20210331031645.1001913-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Chunyan Zhang <zhang.lyra@gmail.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>
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

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The second parameter of clk_get_optional() is "const char *", so use NULL
instead of integer 0 to fix a sparse warning like:

">> drivers/iommu/sprd-iommu.c:456:42: sparse: sparse: Using plain integer as NULL pointer"

Also this patch changes to use the resource-managed variant of
clk_get_optional(), then there's no need to add clk_put() which
is missed in the current driver.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/iommu/sprd-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 7100ed17dcce..371d5715cbc9 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -453,7 +453,7 @@ static int sprd_iommu_clk_enable(struct sprd_iommu_device *sdev)
 {
 	struct clk *eb;
 
-	eb = clk_get_optional(sdev->dev, 0);
+	eb = devm_clk_get_optional(sdev->dev, NULL);
 	if (!eb)
 		return 0;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
