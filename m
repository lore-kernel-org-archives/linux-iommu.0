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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F37C2D0C3
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A26121582
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2l0Ln5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A26121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 331D786E33;
	Wed, 18 Dec 2019 13:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qOFBsla0sQns; Wed, 18 Dec 2019 13:42:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 80783876CC;
	Wed, 18 Dec 2019 13:42:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F141C1AE8;
	Wed, 18 Dec 2019 13:42:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D1F4C077D;
 Wed, 18 Dec 2019 13:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9483986DFC;
 Wed, 18 Dec 2019 13:42:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id towvI7tkU8CL; Wed, 18 Dec 2019 13:42:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8282286B67;
 Wed, 18 Dec 2019 13:42:18 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id t14so1943704wmi.5;
 Wed, 18 Dec 2019 05:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SGGKIHFMLqYbZpUM3Q33U5iSErWckLEQGV1WkcVEHI8=;
 b=f2l0Ln5lReEODkQsQ2uA5VClJ+tweCe1nxxLM25wOBTPUawR+6ac4Oh9JJIQXM7izU
 279nW2ndVPAd5tnmu5o34yBm34BQ/CgXFNXfsJYRQZTwly2ugMLdHjRgJNbuOPzWgJP8
 w99o0aQmIh2BnWDic7KwjuDGuyPTQIlwxumobg6+P6U3shJ7PqzEn+FvI5yMVIcR1SH0
 EoMluYkn1DeaDPsFpZoKJQYQB+0uCRwqUzjFAdzkKEN3PWmxuSikgYRh+9y0cxoQBnLA
 lLX0ubFtEcze1SbNZtpuQDnZRGz1S1577k2poja+bugOY23uMXwe6aKHUOLM3s4LpKwx
 dlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SGGKIHFMLqYbZpUM3Q33U5iSErWckLEQGV1WkcVEHI8=;
 b=FtnwEfhIUvTG9vVB/KyxRYkyO9YyQtk8LKYgf4+Ft5YIHyVh45LOnCeKGM/tDMhFgl
 f3ZMLStFKBO6D2lm2JsJ06cYC9VRp3hoKe7KCpbeJ6C/ISuilz90fAfVQ6nmQ28pBLLG
 U5dh7a957oMPF5XX0FxcQYmWCCahnYaHrqIzJND3SYjQDM+sK+PnttPvzuFsDisNT50n
 3VerCFiuhBE0dOo3KZsJrhW2Eu8ylrjMkDROuZrSECzblMdRgRxH/3wvuRgxy/yntnhp
 hZwQleIe152oJzyD3jdsip2bDSDhnLmMbcs8VbNleLVIvQfTlXYi3K0KtIGpwuIuECzX
 9juA==
X-Gm-Message-State: APjAAAXpiftVmkP1gV3PqQk2yfFcNM3Ax0xkG6WITXmTXzflNy1tCuQi
 0nhhiRke9jpPqG/uURTjxR0=
X-Google-Smtp-Source: APXvYqzoxOysiicfnZ8kQPTnP3ixsfrrY57jj/OU+n4GiTzU41Y7nHqcI1DrYVt8Sbn788JPh2gokQ==
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr3530551wml.55.1576676537022; 
 Wed, 18 Dec 2019 05:42:17 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id v20sm2459763wmj.32.2019.12.18.05.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 05:42:16 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 3/5] iommu: amd: Use generic_iommu_put_resv_regions()
Date: Wed, 18 Dec 2019 14:42:03 +0100
Message-Id: <20191218134205.1271740-4-thierry.reding@gmail.com>
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

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/amd_iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7a6c056b9b9c..9ea6c4b8e402 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2638,15 +2638,6 @@ static void amd_iommu_get_resv_regions(struct device *dev,
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
@@ -2685,7 +2676,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.device_group = amd_iommu_device_group,
 	.domain_get_attr = amd_iommu_domain_get_attr,
 	.get_resv_regions = amd_iommu_get_resv_regions,
-	.put_resv_regions = amd_iommu_put_resv_regions,
+	.put_resv_regions = generic_iommu_put_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
