Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47676C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0162189D
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwfkK4ET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0162189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 37BD94710;
	Thu, 29 Aug 2019 11:18:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 00B654692;
	Thu, 29 Aug 2019 11:18:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5A2CBEC;
	Thu, 29 Aug 2019 11:18:00 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id t50so3670264edd.2;
	Thu, 29 Aug 2019 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ZPwojxlU3nxe6avL7T6Kd+AiQv8fk2jxvTTMYnp3skk=;
	b=CwfkK4ETEP5Hjh9QDuS6TY8Zo1PblcXa0lLRqegtpq7duQS5I26xq3pXBoOFnPi2tG
	XaNV9J47CQol+jzq805c8oHpg2VKPiUCG8XFl92B896nXi25dv7UVJlG+t6gIkLbHtn2
	VJxyhp5iE0eKfTjlyYOu8g79oIoKs4shF8KUMOg+HI1VgN7Dk29/xyiEETnMEbzMMRL0
	kegcbUw+PE+pZCw6y5c9KevaDR38GrS/fuezIeSXkIm3drhO71yJPIbzsyG32SwwKqiw
	psBbXLRQ1JhWblSmzkl9QZS3D+YUW2ud/KYL/ZXqWkj0oLI1dLhoRP1YkP+QNXG3C/go
	hFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZPwojxlU3nxe6avL7T6Kd+AiQv8fk2jxvTTMYnp3skk=;
	b=QjV68luO64GN2t5rp5sN8BUh3C4F7ypFiV9OKa5O+7C1VyCEARnZdWiVXgrujBs+8o
	Hla19U16GzYNTeZ/3Zi+IW3NpT9BJbc/ucYqJb4trPoHDVbaDrppIPM/BxNyQYEh+zak
	p02jLhqNtFNFkSJfYhnoDCI/awIj0hb7BRUIcHfEc+kxRSoJ5esG2lJYtU1XbcX4Qbir
	Yea1TVsgrGXAwnpn+nhQ07EAiWZYUoKPo+M/y4N+QKighWFHuabeAw2Ei2xcyNdaH1fg
	hMkCip7QsuDUopbk7z3TXRBrRUfxaFzS4Sus8CTIrx5CgSjhEQPnH2DKmdD+HVkc4CKv
	kmZw==
X-Gm-Message-State: APjAAAVBmVjEYJlNS+mXaCaHnv4PtjaQxr1D+k96UoZ6efPDg9DP/kNC
	Ym5VJjrLFy8gUd2GSpC/1EA=
X-Google-Smtp-Source: APXvYqwhGrTdOk/7PuuuqUH1gZ7ETsG0eQQUr9Q9On3z0eSdlzFD2qFPam7txyGlB05pcntKt+cdoA==
X-Received: by 2002:a50:e601:: with SMTP id y1mr2804885edm.221.1567077478117; 
	Thu, 29 Aug 2019 04:17:58 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
	by smtp.gmail.com with ESMTPSA id y20sm334424ejp.60.2019.08.29.04.17.56
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 29 Aug 2019 04:17:57 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/5] iommu: arm: Use iommu_put_resv_regions_simple()
Date: Thu, 29 Aug 2019 13:17:49 +0200
Message-Id: <20190829111752.17513-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829111752.17513-1-thierry.reding@gmail.com>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
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

Use the new standard function instead of open-coding it.

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu-v3.c | 11 +----------
 drivers/iommu/arm-smmu.c    | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 0ad6d34d1e96..b3b7ca2c057a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2263,15 +2263,6 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static void arm_smmu_put_resv_regions(struct device *dev,
-				      struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2289,7 +2280,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d6fe997e9466..e547b4322bcc 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1724,15 +1724,6 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static void arm_smmu_put_resv_regions(struct device *dev,
-				      struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -1750,7 +1741,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
