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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ADCC43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF43207FD
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIbbmsAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF43207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 80F7887798;
	Mon,  9 Dec 2019 14:50:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxzY3A8uUeXh; Mon,  9 Dec 2019 14:50:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 75A73877A0;
	Mon,  9 Dec 2019 14:50:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FB0FC1D8C;
	Mon,  9 Dec 2019 14:50:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B58EFC1D85;
 Mon,  9 Dec 2019 14:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4FD968683C;
 Mon,  9 Dec 2019 14:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8+XdaOG0qEK1; Mon,  9 Dec 2019 14:50:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CB5F686A0B;
 Mon,  9 Dec 2019 14:50:18 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id a15so16482316wrf.9;
 Mon, 09 Dec 2019 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=li3aL6AKer4CD9SxvytTfEJufU4SX6U6gX8As2O4Eqk=;
 b=sIbbmsAKQOinyqrXzcC99G76KdGrMEBizkBgPtvaRxn8ZKhsfY5X977UavqreA+/rf
 6IRczi+ABL0XqlQHMKt9eOe/MtYJQ8CvDjSThFwoQD3J3AyC56sPJTUrEaZLgLEja96e
 dK3bdVprHh6nx24uLGY2MnQvm+2b2lI+H6jfYdfzuO/LR6dBLTl/wDDhsIg6/WLdtBs3
 yqlMPfNu6+7i4kwgT6zFfxpN42GOZF6RWrvZRmmMr9cC0Y8YBjMEUsyaLLL56p2ZicIE
 B5eHoYivdlm1CdYuboV2OPBvt7Kjl4Ce5zeh2hZgXUTSES5/2vzXNFrlcSxEi9+doRrC
 Gk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=li3aL6AKer4CD9SxvytTfEJufU4SX6U6gX8As2O4Eqk=;
 b=bDmxSJaSY4K6T9U7W482tPOcQ8BvKpri6jQ/VUXYysbKc6GPM36kH3ZC8dt9zO/J03
 Bs1XGvpK8x1G3zBamRf6rDbmvbtty9qoDT/zyh9IAUshA6IoPbo3x+avYlpKCP5T0fpp
 b9/4gNapmACPZ9FIYkmMTs5kxo250oqGoI1tCK0YOfj4ZO/1vZbdu3TClL4BbCjZKdgA
 3AFMEh/jA/mzwWJ2Ca/M94eEiGQdocrT3EO91RQyYWMldExwcBpoHIRX5ig2vu7AEdCG
 NvyJZBR1VT3+rojg7/koGuLDhx21FvuqJV2dSdEeK9Y9c+roQL+bMgaF14IhKbEYPYHU
 Lgvg==
X-Gm-Message-State: APjAAAVdMZZ4+X55xMWQLkOtPb53W8M9bdXGzGQgYEeWgve9r1P7tBl1
 N6nkeOItZYCTvHhB6md2rE8=
X-Google-Smtp-Source: APXvYqzHwIqbGPCxhT3/97guWDjWbFdKkbF4/OZcFZLfBqZtJeRr9aLwAe1boBI+1nQud1IyWHXeDA==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr2572334wrw.271.1575903016835; 
 Mon, 09 Dec 2019 06:50:16 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id d186sm8590wmf.7.2019.12.09.06.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 06:50:15 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 3/5] iommu: amd: Use iommu_put_resv_regions_simple()
Date: Mon,  9 Dec 2019 15:50:05 +0100
Message-Id: <20191209145007.2433144-4-thierry.reding@gmail.com>
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

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/amd_iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index bd25674ee4db..5896cbe6106b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2641,15 +2641,6 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	list_add_tail(&region->list, head);
 }
 
-static void amd_iommu_put_resv_regions(struct device *dev,
-				     struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 					 struct device *dev)
 {
@@ -2688,7 +2679,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.device_group = amd_iommu_device_group,
 	.domain_get_attr = amd_iommu_domain_get_attr,
 	.get_resv_regions = amd_iommu_get_resv_regions,
-	.put_resv_regions = amd_iommu_put_resv_regions,
+	.put_resv_regions = iommu_put_resv_regions_simple,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
