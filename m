Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F828C433FE
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 19:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6664682FE7;
	Thu, 12 May 2022 19:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zsyDWw4qitS9; Thu, 12 May 2022 19:01:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6CE5D82FCB;
	Thu, 12 May 2022 19:01:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55D90C0032;
	Thu, 12 May 2022 19:01:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF554C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFEC56076C
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iFmmLTkZswOk for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 19:01:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18719605B0
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:13 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id g16so7680754lja.3
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pR4shFXzRu26yKMEBHHOJ50AdyOlvyUzX89NewQfIKw=;
 b=pTgOa8zlPOKkdtQiYwzTqFncYfygTcbEPqQxm68+RTAsTawxZApi6+0x9bhqaFy2pN
 DgOXNDuAXXepOA5Rpn4VK5gA26QAQBKEbp+fON8YDhIrlYmwMCZoPUYW5HD/c2TlCuRy
 LFa2W/n8zf+WfPEDySvAgRJEixD0xqpsbpXMWP2rFhvk3fPNk46Ih1ETQYNY6KGOtsgv
 sBkF8bqdBbUlz/XTbJiyBQf64+eTZVDHL5kccGb21jArMLumAbjVquvYP7GaYRGCp4D3
 dh1P4d8ILL+p0rrr97BT9fi6YdAA9dua6akDdoPjpyg4xpXw6CjTMwTTZlpA1khSLzwJ
 /Oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pR4shFXzRu26yKMEBHHOJ50AdyOlvyUzX89NewQfIKw=;
 b=oVcZ5s5+wK2jsRXct67d9Lh+pjqUpgCTZAFYBC9Qj5sBWTl9Q30gpZnKsq9sIOA36/
 QkY1YbTYs2VMiRUgssdOqyAIYTPBckZzJVF/rsbXnENIMzcsakhWOo5F/VI6gQTvuE+h
 hZdT/TFQ9cgMm4YOcKPvvBA+kS/jgD4EZefMDIq/jl/TTHYWWJyYwhcUPe6ASnySQ9rQ
 Zvn1d9kCxtsDr43c6smwpve14ueIv7nENZm3MLbQA0YmqieHqG8Z2DHebYtJMkQDDJMj
 Ma3k5HD15WroM6keJfn7BH3Hx08A6rHa2TtLD2M4b/RbKARRai9+IucRPIRs//AM9LI/
 SbPw==
X-Gm-Message-State: AOAM532sOorXitDB548QhQ39PIhnPr3mPvtgKfjeS1w0ZGYAj5tGss8R
 jjA7o+Y3mUIElidpe1tzlR4=
X-Google-Smtp-Source: ABdhPJxLj3htze1kQcfEsRJlLAzFMNunGIciZgl4tVQ7CLmBTIxETTW+SJa2zDMNBEkQQv1+ttJ4Cw==
X-Received: by 2002:a2e:9b4c:0:b0:250:b98f:942a with SMTP id
 o12-20020a2e9b4c000000b00250b98f942amr852765ljj.447.1652382070861; 
 Thu, 12 May 2022 12:01:10 -0700 (PDT)
Received: from localhost ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 q14-20020ac246ee000000b0047255d211d5sm51045lfo.260.2022.05.12.12.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 12:01:08 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 3/5] iommu: dma: Use of_iommu_get_resv_regions()
Date: Thu, 12 May 2022 21:00:50 +0200
Message-Id: <20220512190052.1152377-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512190052.1152377-1-thierry.reding@gmail.com>
References: <20220512190052.1152377-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Sameer Pujar <spujar@nvidia.com>, iommu@lists.linux-foundation.org,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Janne Grunau <j@jannau.net>, Robin Murphy <robin.murphy@arm.com>
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

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1ca85d37eeab..3a40ae7a450b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
@@ -386,6 +387,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
 
+	if (dev->of_node)
+		of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
