Return-Path: <SRS0=Tv0G=2I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F89C2D0D1
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D59E227BF
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfRSQKT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D59E227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AE5AE20784;
	Wed, 18 Dec 2019 13:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mH4i7k6iwL9; Wed, 18 Dec 2019 13:42:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 09186203E4;
	Wed, 18 Dec 2019 13:42:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA624C1AE8;
	Wed, 18 Dec 2019 13:42:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78252C077D;
 Wed, 18 Dec 2019 13:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 577F186C53;
 Wed, 18 Dec 2019 13:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7zowCK9NGQHA; Wed, 18 Dec 2019 13:42:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C47CF86B67;
 Wed, 18 Dec 2019 13:42:16 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id 20so1828293wmj.4;
 Wed, 18 Dec 2019 05:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZKV3MGTA/2/bfoWX89xXRBHVgU6rKIgrBLKBmEiF8i0=;
 b=lfRSQKT2ByflthOsB87RU7Gv/2PvSlciEuSa+25UiwhrLnL0iHnn4+2G+tmdPp6eIi
 8hHBOM9wp0okgjScFvYx5MLMnZCEA1TJeR39OBixx1o2ZnuxowVkjoeoO2DDOM4mt8ji
 fsCW3642Geo5wK1ektqMm7d3ZJxUKDc6qwCIiDzcnm+LMdzaYs+qxHNzNlZLqVXDSfKG
 DbkTv0PbLwZweD1bhIX0ug+7Z9kb9qmyACSOGMFISjfDtNe9DeJxvIQUmtd5xZ7N2Tgq
 CBX1HNtqdjmwRk/3NrQefKgfSxDTLW8img+98wK2TfAwYs6tSKsZBZzWgROCMNUri9KQ
 EIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZKV3MGTA/2/bfoWX89xXRBHVgU6rKIgrBLKBmEiF8i0=;
 b=NHuZhtp4wDUsTBKKiRRdQ+eiKBzvhLaIcMHQQNuVx5eeWWi6lNe5O+6vq6Wl2sndVF
 swqvF4h3bcpUn3JxR8oVOWC5nC9MV/p9UYAgQL09o52BqPjymyPHmH/S8hZFwlWxoi2G
 xScyp2PAZQri437VqtizJWBtwcxWbK3CpDoxJyRgHoPC3gm6tyq0mTCFyYlpb2WoM5gJ
 iPM5zLhQhnmLWogyTI5R9asDNZuWG9kEKB1ABFnuUTTD2j0aIvIVudueoO3bHFOo0cJU
 4YXd+K2bD9aX/2Z6Dsi6pZtggE6yauIwCbCE9/mz9bKZ1PbgP4jXZNd60nQRVEjzqcJg
 c3Yw==
X-Gm-Message-State: APjAAAWUYKxOudJmdxZcKXs0pWL+U1HXfmUyV6HJ/adRm+YuHOg811Vu
 iR22tPCJsnUAkA95WILtIo4=
X-Google-Smtp-Source: APXvYqxmdcdJB1mXOevGjXDjzCqOvxzn0AuQ1Uyb5JkQ9iCe5BgU+bDq2ZCvGwKiujMBqMzfvOdIJQ==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr3619567wmc.42.1576676535246; 
 Wed, 18 Dec 2019 05:42:15 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id j130sm2640695wmb.18.2019.12.18.05.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 05:42:14 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 2/5] iommu: arm: Use generic_iommu_put_resv_regions()
Date: Wed, 18 Dec 2019 14:42:02 +0100
Message-Id: <20191218134205.1271740-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218134205.1271740-1-thierry.reding@gmail.com>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu-v3.c | 11 +----------
 drivers/iommu/arm-smmu.c    | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index effe72eb89e7..7f5b74a418de 100644
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
+	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 31ad3fe9a6d1..7a5978bbeca8 100644
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
+	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
