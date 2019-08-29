Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62538C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:15:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3519B20674
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+xj84R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3519B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5B1CC4700;
	Thu, 29 Aug 2019 11:14:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E20C146E7
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 11:14:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5E5733D0
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 11:14:14 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id l2so3421512wmg.0
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=IaiScEIM2pI3Ga2qURu31RnQ0vP3+posJvio/TvHvqg=;
	b=F+xj84R55A1bQiWth2fqIYGo6UX6UgizupUvoLz120sQwCOcC4uXrlMfUAgcXj24TI
	+ictMX5b1GqoSUahPBQMokCooAzTr3wSMGpPceFi8ChyQILgqg/XiKu47sm6eO+k/2zO
	jD6zqWPf1Oz8eXvpidcfVoJe505sZPr99n9GmW/NluuemBu+j5tNN81z4G7rU/BaVXiO
	6Ls+OoqMSfZSlKaBq2chZJBP8WXng29zEIhaOt5TLB+kQp0xCQ/4AYq+9RHLu+4P7YOF
	BAt/X3om9seoBn0GBvShIun4Hdkb0EeQRZlv4/sI/MBS6XxB48gGZIAvMvE5cn/If/y/
	TyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=IaiScEIM2pI3Ga2qURu31RnQ0vP3+posJvio/TvHvqg=;
	b=iLD45XpA/tCOOrFsaLOFcljt6h26jL0se8XTGckpkLn+fMAV4QdWFXENRG8kJQeABO
	Kc5sKfBuXAh3ydyL3OQnLFx3hXawqmPnQWdNAczjDHRXhjLzTWNMoRVln85pCrsg5v3f
	w+08eXQEpeLpWqx9+xULJLlqpRuPXgSTj91ura2IvzbtK1AjzV39tcee/PfHu6FgJ+wh
	ui/Dr1mpVYr4k33dms6NMT5JDJ0G9dnLtyXR4bUZsfBkMEsi24t5uUbNQt63Sjbqr680
	nc1ptvYDT6aBa0UD65vs6+R9WuCLMUXSUxkxnGSWiAuVLG0aWY8vuxx4argnnuOznkmz
	GnNw==
X-Gm-Message-State: APjAAAWLb/a8doI/Rkj5pVtOKGMtGB4RVj7Zb2KhHWDP/O4gs4RbigFG
	MbnALAGjmQ6P26nemfARY4A=
X-Google-Smtp-Source: APXvYqxxJAd9VKSbtqu650m3xr1fElGjWbcWB3LkSAuhJv9Q6X+YMJCxf4QK1m44yZLZh+CImBf3Ng==
X-Received: by 2002:a1c:f703:: with SMTP id v3mr10575246wmh.107.1567077252984; 
	Thu, 29 Aug 2019 04:14:12 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
	by smtp.gmail.com with ESMTPSA id j9sm1823662wrx.66.2019.08.29.04.14.11
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 29 Aug 2019 04:14:11 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
Date: Thu, 29 Aug 2019 13:14:07 +0200
Message-Id: <20190829111407.17191-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829111407.17191-1-thierry.reding@gmail.com>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

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
index de68b4a02aea..31d48e55ab55 100644
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
@@ -164,6 +165,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
 
+	if (dev->of_node)
+		of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
