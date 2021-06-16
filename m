Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE67C48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 17:34:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03EB61241
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 17:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03EB61241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A44B4404C8;
	Wed, 16 Jun 2021 17:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YA6uqjJ1wBkJ; Wed, 16 Jun 2021 17:34:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 91686404BF;
	Wed, 16 Jun 2021 17:34:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CFF7C000D;
	Wed, 16 Jun 2021 17:34:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A39BC000F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C43F60A74
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DEv9VuQjEqqL for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 17:34:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F265060A6D
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:26 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 o10-20020a17090aac0ab029016e92770073so2173555pjq.5
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FaCmke0KUr5hNz/V/U5Q1ipgm00ep8cVzDtmfH4etSo=;
 b=fGMSdy6veXpnegSm3FPvEItF+n/+ZvhKr/pjbKdx5R3XajlCitXAlcmbgv8GsDoYTu
 +mrfMWOciIb6YKYfgqN4UtR+cjXznHLfZRM7GPGiogS+IFK+ELqllqsCs9mbqpLFFOLQ
 1PPKHkjCzpqURZoLlDZrKKgHb/zgJMUGrstCHNVnmi11x+uceGyWquhSKgEqBHbBSOXr
 lfHqSdLGER8410SkkPVkmHDUzAmOUSjYIkVYSyh64Yf16pgafgMHgfjeKKvj4ikWU+vI
 blZvia5XAni7eUEF/FcRgo6IQ414viVemZaGNvqyE2xbPJUiFu7oKDRYKwclsuEe+6ct
 FJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FaCmke0KUr5hNz/V/U5Q1ipgm00ep8cVzDtmfH4etSo=;
 b=c3SdUjEpz4dvPrYBNBoWnBK6JqNfzaI668CHowAcCzHlqFsfBIdF9zsXrPvFV1D5im
 yGP6BN1yBvs0iq9SU9JKqLi7ItkfP+f8rsQOs728TMSppXPfpnT9akyZLXXlLmuicBZs
 WfZHy3kXE2gPhpJY93z/RoXMbpTdxcSnVyB8ju8MLZgZ/bW8AkrQ3Pa0RZ/9WrvHh+75
 IdHvCujSC1AFnWnsk8OHv+y8TvjEwr6WYNqdTAalzyCKpcYOzcIUFXsBAdePlmMX1N0u
 nWKoRsUa+hAF2fy+2Usfn4secuHzoJgWHAhJr/wOZEK5kG6TjKdY0/OkebUcVNGMScG1
 fJdg==
X-Gm-Message-State: AOAM533ktiJJol2Qii034R/uFMJCZWzgmIuE95xAq0/hVJN1RTMulu2t
 tA+Y5+DU4SamZjZqt0yXvlw=
X-Google-Smtp-Source: ABdhPJwcbD1NYoIUSr6+u8Onq2eIJ/+uWH2eVPZ7NLR9KqyitHvNcNfrt4hT5+Q6OBQFVWbff7XAZg==
X-Received: by 2002:a17:90a:4490:: with SMTP id
 t16mr7376370pjg.183.1623864866304; 
 Wed, 16 Jun 2021 10:34:26 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 10:34:25 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 2/7] iommu/amd: Do not use flush-queue when NpCache is on
Date: Wed, 16 Jun 2021 03:04:55 -0700
Message-Id: <20210616100500.174507-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616100500.174507-1-namit@vmware.com>
References: <20210616100500.174507-1-namit@vmware.com>
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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

From: Nadav Amit <namit@vmware.com>

Do not use flush-queue on virtualized environments, where the NpCache
capability of the IOMMU is set. This is required to reduce
virtualization overheads.

This change follows a similar change to Intel's VT-d and a detailed
explanation as for the rationale is described in commit 29b32839725f
("iommu/vt-d: Do not use flush-queue when caching-mode is on").

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d006724f4dc2..4a52d22d0d6f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1850,8 +1850,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
-	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
+	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
+		if (!amd_iommu_unmap_flush)
+			pr_warn("IOMMU batching is disabled due to virtualization");
+
 		amd_iommu_np_cache = true;
+		amd_iommu_unmap_flush = true;
+	}
 
 	init_iommu_perf_ctr(iommu);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
