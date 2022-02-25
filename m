Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F231EC433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 12:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9077283FEA;
	Fri, 25 Feb 2022 12:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ytVsfNrs7pPl; Fri, 25 Feb 2022 12:10:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57E0E83FDD;
	Fri, 25 Feb 2022 12:10:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22D1AC007F;
	Fri, 25 Feb 2022 12:10:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C550C001A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 09:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4343A41651
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 09:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g7mZE0e-lw18 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 09:32:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 861D64163F
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 09:32:43 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 m13-20020a7bca4d000000b00380e379bae2so1286912wml.3
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Anr/HpsJ2V3LE7H1qAJzQqqWy2ZK47ULNqlFEib6tU=;
 b=P7ly3xMyPOrr3B0325E0teDM/lnRIOn9XJo7vDUt6oM76ogcTuQmAW6QSIVXm06n6x
 clY6WFc+TmNkhiQfhXRr8z+8+GnhlhufGuUcCpWy72mXjFb/viNp1REsO6MooFRkqJKW
 LiKPKOSqw2QbIhK8uF5COvxCOU35Ijtfx4xyKac9cRmg7dMheotudn9S9JZ3N7Tn7SyF
 7Dz20E21T8NXyZywwDBROSordMx0mgKNb9BsZ3K4K7lDo/5eowmZTV2onhx2j37l5Ond
 fYQvlVkhQXEtA1WzjBBIhYtMWPIIrs+qS4YVXWl27BzzfOPOQwSa5ZBSDUWT2SW3Pkd/
 Wtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Anr/HpsJ2V3LE7H1qAJzQqqWy2ZK47ULNqlFEib6tU=;
 b=IqlnOCfLd8zjNyr64cUtJDYHn7tDgXfP0BMwPDshUND+mUNPvorwvLitYRFkNTSq00
 41utqpsQFRT2KkQirLw3XGf8VPAoZhlY7i0tdQ8EPUP8OzDfrHDzERPt2G4I+F6h5NMg
 KzD3XDby8v83VwzCgUbqWOBk0sGJ+YPgQiVERRoHlQlYcSGqTJxT0cvj5Qt8MVek4kiV
 1dWqDws3tjqT9aWk0URz7/qX8l5jgwSuzHDOBGRyGgxza8FYVC/NsFF+RQMi0RrdhEE3
 8Z+cSPrAFavLNX70QHVZVVj3SGt3UMwi1mKStzU4pDHLuiBUrVz8tXU5YzuFX+fYS4/2
 KyGw==
X-Gm-Message-State: AOAM531Bdi37Ys2U2wKsuq8Yvu3C8hh8GmolfdDyE4blB14e5oOsOfnS
 GhxWSBGSVK82NWvDNxIoTMs=
X-Google-Smtp-Source: ABdhPJwoCKrFbFoCIBMTdfn2qSE6TEQIPQ9CT9XkwjlSqgeqEjqMCQ0M7IbjTCUATIRzbiSlEcckPw==
X-Received: by 2002:a05:600c:20b:b0:381:263:b5d6 with SMTP id
 11-20020a05600c020b00b003810263b5d6mr1904829wmi.73.1645781561681; 
 Fri, 25 Feb 2022 01:32:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net.
 [80.193.200.194]) by smtp.gmail.com with ESMTPSA id
 x2-20020a7bc762000000b00380fd1ba4ebsm7733046wmk.9.2022.02.25.01.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Feb 2022 01:32:21 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/arm-smmu: remove redundant assignment to variable res
Date: Fri, 25 Feb 2022 09:32:05 +0000
Message-Id: <20220225093205.170973-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 25 Feb 2022 12:10:34 +0000
Cc: llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

The variable res is being assigned a value that isn't being read
later. The assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/iommu/arm/arm-smmu/arm-smmu.c:2109:10: warning: Although the
value stored to 'res' is used in the enclosing expression, the value
is never actually read from 'res' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4bc75c4ce402..f83d2c32b5a9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2106,7 +2106,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return PTR_ERR(smmu);
 
 	num_irqs = 0;
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
+	while (platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs)) {
 		num_irqs++;
 		if (num_irqs > smmu->num_global_irqs)
 			smmu->num_context_irqs++;
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
