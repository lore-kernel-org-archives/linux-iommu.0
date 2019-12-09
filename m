Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0AFC43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:43:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C6D2068E
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwiWLgyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C6D2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DA9D5850D6;
	Mon,  9 Dec 2019 14:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bb9Z-rAnMutr; Mon,  9 Dec 2019 14:43:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 72652850E0;
	Mon,  9 Dec 2019 14:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B628C1D85;
	Mon,  9 Dec 2019 14:43:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0E08C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 14:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9FEB7203B4
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 14:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 90u1zPZvOX1M for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 14:43:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id B978120336
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 14:43:02 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id n9so15252155wmd.3
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 06:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NV+OtFNHEPzK4aALA3wGiz+UFBKhhJOcbOzMP5xc22k=;
 b=bwiWLgywo4bf2Dm4Ihu3a9OQzCW+Bcm0MRmMhP3dm7qO/brttTj8L67XJibxd6vTix
 3G+uINewRv4VhP7E8F03AWBILGLSbVisz/lwn+KlM22BnGqwogFN9uMxSZsGliB0Xonm
 DfLcXpIDyUJNd3iAs4fo17prGdJ2Pw1ZxtYFsBSDsaa9k2oF2tM2ZdQ0POIj3QThtByc
 2IYQ6VQpbE/rxx4ktCnSocpdE56KR6KLf0cB1pwS1W33hBSan/WK1DezW0reo4WaxshO
 B6vjyjQ6+MIxm+lttNugyuDpOpTxTlqpqeGDjzhLKcVQA2PIoS+nW+3So8WR8p051Lou
 Wa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NV+OtFNHEPzK4aALA3wGiz+UFBKhhJOcbOzMP5xc22k=;
 b=Q3jJMiOFUx1UobNsYVn9btB+l2D7w2cIUGhl/QLNwYdABvCKq1uLXheePlLr/tGj7r
 +snAIVQ2m/4wcAG5y13I/m5tmqGUOE76JxHjW8l4PTsbPOxyoCDNcITMVa1ZuODkr0o1
 m2AYtraf/Le/fOn0jypz0v5/SdePR7SBfaK/Q9GSCtQfx5H6DtVHhhOwd9x4aPpi+Y/X
 gtxZbuFA/lt6thev9JifIXkMxM+IPlpYOupHwbp4akxJp1/kKaK/nL+YtX9nBU4YRBEa
 sEsMHaBL70E/El4ys8mu8w8xynb2z6RZdOyupSZvLx5XLCiDSrA1rTdjN8YRs2qfdt8y
 UKlw==
X-Gm-Message-State: APjAAAVdQSgQ6VJm4XajOXaJLWE8fxanOXvsNahDiQMtflscCmrlHjsx
 62I0iRJmy17xDw3lFKtH8Z4=
X-Google-Smtp-Source: APXvYqyJwFHV7cm833OQ2PvjlHHPlHPTguHfZPFEEjeLQsJeto1AdNMXKAMXnzYvun173UkWc3IHKA==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr12937576wma.32.1575902581139; 
 Mon, 09 Dec 2019 06:43:01 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id b10sm8756152wmb.48.2019.12.09.06.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 06:43:00 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 2/2] iommu: dma: Use of_iommu_get_resv_regions()
Date: Mon,  9 Dec 2019 15:42:56 +0100
Message-Id: <20191209144256.2396808-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209144256.2396808-1-thierry.reding@gmail.com>
References: <20191209144256.2396808-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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
index 76ef31123cd9..2b2ec643b7e8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -165,6 +166,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
 
+	if (dev->of_node)
+		of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
