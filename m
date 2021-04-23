Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B23C43462
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 16:32:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44D061452
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 16:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44D061452
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7014740651;
	Fri, 23 Apr 2021 16:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VhBk8228CzJ8; Fri, 23 Apr 2021 16:32:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 79122400DE;
	Fri, 23 Apr 2021 16:32:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64F5BC000E;
	Fri, 23 Apr 2021 16:32:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB3BC000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98C5B60674
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ls6_uSF5FRj for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 16:31:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0548605EA
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:31:57 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id g5so68005670ejx.0
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QcfymhoYhAwy+sqKo+Bx4zKEukw467+NXOcy0hVDFGM=;
 b=FESlPukByffPHu9CvLIV7AnmA2veAujkMJJetMuD+jr+PVzCDlcGJafOAtL1ymwv3F
 Sv1wT2AQN/qfkPKYWqCiG08fjIzdsljqSdAgZyMYuvcLX/78WjHkxD64Y2Gjs+kS9zC5
 jedlkF5hxMPycWay51n4Zr1F7iVkeTmILL72NsBTWhbfQcbIcD/tMcRH4xcr0hnZCdLS
 V+J4oVzzNRRX/8dDMs8gD6+FYhb59ihRfUENXomHxVjM16BmCrE/Ti1IuYPIxyDl+FfU
 xcC8Tw8MAtWMRHvWFUIEJW9jxVV/58cFPJQwtTaB7iT5dUQh0J4j2VUNkvfbJdJIBwvJ
 nMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QcfymhoYhAwy+sqKo+Bx4zKEukw467+NXOcy0hVDFGM=;
 b=qG6h31LzcsxuWt6mHArd5l6211TGdQ/C3FRNBP4/9WIrY6U7XF8oVs0bn6v5y9uv1z
 kSXCHeha26ewttgIgJa15W1RlVYWJBW5xLIiyS0NaoikFN3q72MyeS8WhazPbfff1vs9
 bZHtB5eCju/JviPDXfzlLKLLDbgnYBCyDDfqQTE9NpWugz7TGEN4V2fHTP2jgdNYvgG/
 5cn7daslUvQ1bdGEo69nKX6Jzal+OlgmySZ4Ydz+lkdMC2TZUWkuKtCwXPSzTTTtbHTv
 UmTQP/0N1EaNOp9lHOWLCfpGcQrHlWKkxeALOpuV+Y75N86605OeV/kf7CGamv7SWafX
 DYBQ==
X-Gm-Message-State: AOAM5314JDHDVgV0VOq976eTHgGZwaiwv1h1dvrTYmg/XRlNq5ez2PRZ
 IQbSLPmM8jtoUDbi5gvLHCg=
X-Google-Smtp-Source: ABdhPJwoBW+602wRSEps/+5/WYwBNnRe76Ww0Z1tDKz4LgLLc/4LOl5Aj9cVnMsdyWPG6VZDxQS6og==
X-Received: by 2002:a17:907:daa:: with SMTP id
 go42mr5140586ejc.120.1619195516115; 
 Fri, 23 Apr 2021 09:31:56 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id a22sm5064750edu.14.2021.04.23.09.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 09:31:55 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 3/5] iommu: dma: Use of_iommu_get_resv_regions()
Date: Fri, 23 Apr 2021 18:32:32 +0200
Message-Id: <20210423163234.3651547-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423163234.3651547-1-thierry.reding@gmail.com>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, Robin Murphy <robin.murphy@arm.com>
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
index 7bcdd1205535..52b424176241 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
@@ -190,6 +191,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
 
+	if (dev->of_node)
+		of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
