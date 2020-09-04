Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3836FC433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018852074A
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ0GTxEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018852074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B8E3B874AF;
	Fri,  4 Sep 2020 13:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id prlHjtNftTO5; Fri,  4 Sep 2020 13:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A92208748F;
	Fri,  4 Sep 2020 13:00:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97528C07FF;
	Fri,  4 Sep 2020 13:00:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52244C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 384D720407
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id btxoOiKOYmxC for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:00:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by silver.osuosl.org (Postfix) with ESMTPS id E5979203EB
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:11 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id g4so6042854edk.0
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ED83ClsltKl6ZtFlLHI8TWQIT9oSGeGONF7WLhe+X04=;
 b=SJ0GTxEmI87RApG2Nm2xqHkbFuk4dJ6yhm3b/beBjIC1TMCez8zUa9zx4QAYz0OSDQ
 6eR6wUSL0g9IBGcKMe6r1tILP2Z+egOoDLyjGj03xRL1y+sNWpie4PAVpPOJPwiDicCP
 ss23jzOxg11d1bkFN/mN8Ir9WNd1fygw1T7XQ4FztAzs40FPgKvhQT0xrCs+qb0ciMJN
 UB/CMqXjXf+83yzqRLjuGT24bkmj+GRuP3tYOYNuHadcrCdY6IVP6pa4jG4gIbAISd3M
 bpCOmwfAImflOLX/lig7SbLwJTO1XoC6LHq00r0ROAE9AlLMpNqkrBg7D2Ks0CE3bU68
 FhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ED83ClsltKl6ZtFlLHI8TWQIT9oSGeGONF7WLhe+X04=;
 b=p/Ac8jZOL+JhaZpmsogtwgfBSV2Ct+zWSle0wx3/+r57pkqJzexGlqPRqw60Xu9/77
 Ky3tdYPk7oA3f7/xFc1fSqeh5MIuJS3wKI9o6FgRX7pZH6wHW4XLGgCH5vv+axFy4j4p
 v+lCyLvsRhxK1emwzyWXN/G3BjkRplRafqu/f4XsBN4+gKBmb9oc16UecIHTABt2QS6H
 n6j/lozvXYpb1x28zSoYEKkYfm5SDVX1DBnGmcEKvdNISI8wIRHIiYxe6rUZHmmrfJgb
 aoTdHmN19R1jG1hxvoh3oTjG4q6Fw763mTwR50f9v1KMaBY7MaRmfYDJ4uiqhrxbukKe
 Dfew==
X-Gm-Message-State: AOAM533MWAbyN+JGjbKNeOzJJMqz2wKH37O1/8GLTPHJZwLSqRWS4FaG
 tIzJ4qQTs3D+Y+Od7wWV6ig=
X-Google-Smtp-Source: ABdhPJwnKE/4voTUtlCVakxWkblsJCw+pNCNo078hfIGVA8aCxC+aag5yU6c35xKJU1ZjgNkO0g6iw==
X-Received: by 2002:a50:f081:: with SMTP id v1mr8566185edl.161.1599224410229; 
 Fri, 04 Sep 2020 06:00:10 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id g24sm2040948edy.51.2020.09.04.06.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:00:09 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 3/4] iommu: dma: Use of_iommu_get_resv_regions()
Date: Fri,  4 Sep 2020 14:59:59 +0200
Message-Id: <20200904130000.691933-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904130000.691933-1-thierry.reding@gmail.com>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>
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

From: Thierry Reding <treding@nvidia.com>

For device tree nodes, use the standard of_iommu_get_resv_regions()
implementation to obtain the reserved memory regions associated with a
device.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5141d49a046b..1c36ca6ec2a3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -164,6 +165,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
 
+	if (dev->of_node)
+		of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
