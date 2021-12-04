Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2977C433F5
	for <iommu@archiver.kernel.org>; Sat,  4 Dec 2021 22:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38987831C1;
	Sat,  4 Dec 2021 22:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HlLmpNzdtOer; Sat,  4 Dec 2021 22:33:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 06254831A9;
	Sat,  4 Dec 2021 22:33:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD56AC001E;
	Sat,  4 Dec 2021 22:33:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B66DC0012
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 22:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F2E2401AF
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 22:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Op5IaSzQyRlI for <iommu@lists.linux-foundation.org>;
 Sat,  4 Dec 2021 22:33:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B9F8400E9
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 22:33:09 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id p8so13395703ljo.5
 for <iommu@lists.linux-foundation.org>; Sat, 04 Dec 2021 14:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JcR/1TkvkZEzS/XW2AKnFEClRR66tq7M2hycKAeV9lk=;
 b=qyVf/zAn7iCw2B5P/SI7zem1gA4GDvMO8nsQdDYe0OhvMrS0sp3V8eVaWv2JvJFUKD
 9DTRSHVWIP8AycZZMu/lzhppacy6YDwbCKOVEuc1PdndsoOctwvb5UABLpwf3OA7PvkI
 RjTFhUUNTdEh4UuxJ0zEzwYHWT0k6wBS1ry1IDG6xSLpgif16vqVuhvCImbm6hRoZwsr
 dQaQ1tsoDNHwtVk2VaFV2FS+Sko4ti3psW+lHOwwXWGg0SWSyaD6o0QPwG1/fYjbES3Z
 HZWmpQMDqJcwlv65Z0t2iIwlxmGGkx5ePlzvj4IO2bI1VSRjJr0lX2qPlH+uPdjwncMj
 uKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JcR/1TkvkZEzS/XW2AKnFEClRR66tq7M2hycKAeV9lk=;
 b=ypLEedA0n/NICP1wey/vRXkIr4evV7P5lpcWYLHUoxOXY0dCT/PZfGu7QpVOCKfgmc
 NQWXb7/xRor8xWWYaeqjIvqhBvhI/9O4kNCRsLrHmM8O0uZ6DtoL06dyl2bFAmHmzCoA
 nTA4KJBre7Vv9YpUg6Ooq5GoE+7O3Z/zz22UfNqfJvsE5nHME7GO2kpB0I+v+RjR5AGK
 H8+X7XhD2hJF4Zit/xLvsWlfPGDXdzWADDTsOrtUMDXSQIr9bilZ0vPW2RnXZzkEU1B1
 fIsnQHAKwBgT7vENGnj8yJqiNm+AaSyKKRJ/2i46GEwls6qFE+2rXKV5U7/TStfucAJ0
 eV8g==
X-Gm-Message-State: AOAM532ZfJ7IiE6jxr+vnSwfk4LGOCtOrQj0gyhvgy4Gvs5IE9yRhmlG
 aoj0qTOfBnuhX18MEkmZBWE=
X-Google-Smtp-Source: ABdhPJxDC9IzaaRdBdaUhhcLV9tTL5ss7E0UuFEqJAXk8UPPOqTIYFZ5WD9J93rz8GwUd8Ek6nJgng==
X-Received: by 2002:a2e:b711:: with SMTP id j17mr27964564ljo.39.1638657186996; 
 Sat, 04 Dec 2021 14:33:06 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se.
 [155.4.221.129])
 by smtp.gmail.com with ESMTPSA id h1sm886834lfp.249.2021.12.04.14.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Dec 2021 14:33:06 -0800 (PST)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops
Date: Sat,  4 Dec 2021 23:33:01 +0100
Message-Id: <20211204223301.100649-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

The only usage of arm_smmu_mmu_notifier_ops is to assign its address to
the ops field in the mmu_notifier struct, which is a pointer to const
struct mmu_notifier_ops. Make it const to allow the compiler to put it
in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index ee66d1f4cb81..a737ba5f727e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -220,7 +220,7 @@ static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 	kfree(mn_to_smmu(mn));
 }
 
-static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
+static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
 	.invalidate_range	= arm_smmu_mm_invalidate_range,
 	.release		= arm_smmu_mm_release,
 	.free_notifier		= arm_smmu_mmu_notifier_free,
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
