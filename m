Return-Path: <SRS0=Tv0G=2I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEA8C43603
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C6521582
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plvvtq6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C6521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 56EB4204ED;
	Wed, 18 Dec 2019 13:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VZeJUPO0+vkX; Wed, 18 Dec 2019 13:42:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D37EA203EF;
	Wed, 18 Dec 2019 13:42:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C974BC1AE8;
	Wed, 18 Dec 2019 13:42:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 774F4C077D;
 Wed, 18 Dec 2019 13:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6136287E68;
 Wed, 18 Dec 2019 13:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UqURtqo0jtiz; Wed, 18 Dec 2019 13:42:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 083B487E62;
 Wed, 18 Dec 2019 13:42:20 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id u2so1952300wmc.3;
 Wed, 18 Dec 2019 05:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v3rAFL7K9Q66L7E0oU9UDZZEL6mZmsWSXH1Q6ZKBGZs=;
 b=Plvvtq6hNBzRemtmfg0OOQVAKEe2ZS0q6GtZhWvDhDXvc8xilZ19uFoCpjx74jEXpJ
 ks8P8qCAJWKBqhbaDtBQL1Hih4Ql/EFZcnQYmPK8Aa3/syWbywIPuENOUCwYMg8OWM0N
 Kta3CaS8pcL1eVz+IsmUITZ1gBjilPkpT22E5GKOS+U+dOu3PajJeL3B2YPKRofAlOJa
 3lBOjImT4w83A8/YZWoTyR1N4boV1D1OLTN9LClsnhPVs1lUYRU3EPq1MT+v93zwns+h
 v3CI/i+73+x+7Vvtu8JjixWZXmrddJnac4ndk4DEu9LRISgOWpzi626BNfCgGsz/3sdd
 ktVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v3rAFL7K9Q66L7E0oU9UDZZEL6mZmsWSXH1Q6ZKBGZs=;
 b=LHfqUZsEW72jc8IZodZ8f8x2JP3KUjP+bkFO1wZeBYqpEp/NcQvBKypWLMQyKeJATg
 zhCftzc5H3FyJ0yovmKWc2+f248rcoSxOMFx78FHlx5BVFUf1OF/nWd9qrVl86s7DBrh
 N+RGuTHmRMftfu8/tGNHVJmaOlRa1bu6h1VQ5gqQrxDbtxhLrtkwe2eSm/GPp3gQ13LK
 EDixrHW5NOo4Lxihc2zsgbPkdWrNP8VucIYOe6Asum6J4ighoNeuTxLcOxoLEgtWDjam
 6Yjv1UD2OSWR0sDQFHaYUO53VPCtHLMdTLH4+fOJGxyakNP7Y0nJthWSb0Y5PRvvGr/7
 8zkg==
X-Gm-Message-State: APjAAAWcZjjYI/pHtckareAjKj71dnZ0A8WiW4qrNhn/PTj76Y7988cg
 F6nebZiz3x1GwePemVX5lKQ=
X-Google-Smtp-Source: APXvYqyJ1+myPu5YtHK5IGKXWRZX/+yLfGrjNRT7nLErzDPqwiTRHjmJdpEdLCQnss548bO8HuF5Ag==
X-Received: by 2002:a1c:6809:: with SMTP id d9mr3439282wmc.70.1576676538578;
 Wed, 18 Dec 2019 05:42:18 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id q11sm2667810wrp.24.2019.12.18.05.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 05:42:17 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 4/5] iommu: intel: Use generic_iommu_put_resv_regions()
Date: Wed, 18 Dec 2019 14:42:04 +0100
Message-Id: <20191218134205.1271740-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218134205.1271740-1-thierry.reding@gmail.com>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
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

Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/intel-iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 42966611a192..a6d5b7cf9183 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5744,15 +5744,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	list_add_tail(&reg->list, head);
 }
 
-static void intel_iommu_put_resv_regions(struct device *dev,
-					 struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 {
 	struct device_domain_info *info;
@@ -5987,7 +5978,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.add_device		= intel_iommu_add_device,
 	.remove_device		= intel_iommu_remove_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.apply_resv_region	= intel_iommu_apply_resv_region,
 	.device_group		= pci_device_group,
 	.dev_has_feat		= intel_iommu_dev_has_feat,
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
