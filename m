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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67A3C43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A862068E
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+zUhOwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A862068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61FEC88075;
	Mon,  9 Dec 2019 14:50:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m4ayZiD5KoI2; Mon,  9 Dec 2019 14:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2ED5487F9C;
	Mon,  9 Dec 2019 14:50:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17D7DC1D8B;
	Mon,  9 Dec 2019 14:50:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EF26C0881;
 Mon,  9 Dec 2019 14:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 07AF72041C;
 Mon,  9 Dec 2019 14:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J8YPaomHSEY6; Mon,  9 Dec 2019 14:50:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 83F66203F4;
 Mon,  9 Dec 2019 14:50:16 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id c9so16518034wrw.8;
 Mon, 09 Dec 2019 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=irY1spgwK2zJfffTq8hx9QkgkytRwMbw4YTsIN/qTSs=;
 b=p+zUhOwB6ukKqHU1wRnWzmuH1Syry5ctKEBh4K/KnTuMWlFphp+kHl1BAjCMzE8bUn
 JbitSWNYgIJs1Er1uTZ1En5urRIyaOTjdzHSFqWqc6PNayKiJfVSjxdVCnuENRIsqGdZ
 x29ePNxjRxb7+2m0SLIjPgfiL35pn/FNg8zbhtqmtSzgVLotzYNhu0j9rT6izICcYOJ9
 D7obuCApHHIprX+PvKaHEOuN3f94riINTAds1kDs95ws/34M1XPS33udUgaQs9ZdlhvB
 NUixRBi/sfBfmORbHV3VsUJ8qvyPKTYy5ife5AH6b1OYstx8p1mmh3N3omkpyvpvw+1X
 W/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=irY1spgwK2zJfffTq8hx9QkgkytRwMbw4YTsIN/qTSs=;
 b=oXYm/dMvi6WYNVQ0VFa5v0tBZLsvdUXnF0tUNSyZqcgiAc4JudAhNiFiAxkMxAu6z9
 NPU1pZEHgIFHLzJnS3Mrzp03UsUFjEt7cs3Oij/gM/NwU9Fsou+lbSnjuIHIecmHM27Y
 xY+VZj08e0nSFZSWG8tr9lEx20GvCdVhfWXLM2hJwuzgrynWKGry5/tUyGBKm6RNG7Sc
 FNnxgOPbudnMNYzDxX+8l79LvIPTbnMUA9NFC5aB08v1ZWuKta5SDPdk3NwmiMO5FKXn
 WAhneB824azFz7hnkzyeBwdo3yRk6r3K+xHUeL99CGRZ8D7m9XBYTklivPGKq1fW0uQD
 1sXQ==
X-Gm-Message-State: APjAAAXUD2JSE7z2bBMwIglM8OWsZyGePsjShyKajZdzCUhik/0VvzZn
 irfd7qt5EK8iIYlv0YaSF8I=
X-Google-Smtp-Source: APXvYqwsN0YOpBRkErf/6RtkAtfpULTvJ5FiPJAY1U9wSh3s2TnoIO21C8Ievdu6ssFmIdevGhFIbA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr2587731wro.334.1575903014734; 
 Mon, 09 Dec 2019 06:50:14 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id g9sm27179539wro.67.2019.12.09.06.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 06:50:13 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 2/5] iommu: arm: Use iommu_put_resv_regions_simple()
Date: Mon,  9 Dec 2019 15:50:04 +0100
Message-Id: <20191209145007.2433144-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209145007.2433144-1-thierry.reding@gmail.com>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
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
index effe72eb89e7..eebf6086080f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2710,15 +2710,6 @@ static void arm_smmu_get_resv_regions(struct device *dev,
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
@@ -2736,7 +2727,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 31ad3fe9a6d1..d1aef07bb784 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1576,15 +1576,6 @@ static void arm_smmu_get_resv_regions(struct device *dev,
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
@@ -1602,7 +1593,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
