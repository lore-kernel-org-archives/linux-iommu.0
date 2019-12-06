Return-Path: <SRS0=JKdE=Z4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30828C43603
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 21:39:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0169521835
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 21:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5zrhcIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0169521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E96C387874;
	Fri,  6 Dec 2019 21:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 96WNdnvCWBFQ; Fri,  6 Dec 2019 21:39:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2EFF8876FC;
	Fri,  6 Dec 2019 21:39:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29E1CC18DD;
	Fri,  6 Dec 2019 21:39:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3565AC077D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 21:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 23BAD204F7
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 21:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7pL0Tx3U6R2u for <iommu@lists.linux-foundation.org>;
 Fri,  6 Dec 2019 21:38:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 3720C204EF
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 21:38:57 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id h14so3994083pfe.10
 for <iommu@lists.linux-foundation.org>; Fri, 06 Dec 2019 13:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ch1xpBs7tWZiDXbLKgnS0zrW6JPy9+Lj1zi5nVSNmf0=;
 b=V5zrhcIZ+lgB0oLDpzAmU/ZJmy/R8NImxfJ2KJlSeBP42kPVFPXiqb08QIeQ5PT/W6
 fmp1oZExC12czTG2VTzX6QR3V3u0Nk/rfF7zner0d81r0TmiQB33SGD0csCRtUGj7Rzb
 7mTy2iLbr/DPunqklk69BAecSD8RkbeqiXDPf0DkyrS9zxYWq2ZeRZU7JCEmqjokmwOp
 zPCPaDhxy/CuYwbHOEqG1hTFRsffPDtAmKIgFOhOwAUtHPojQA2p93b2QisfafRVjcRh
 s/WmiqRjzo7RwvfdGKYC3phYmPaDPD/abswLIktlqXwMGooob7mqRiWPYW+2onx+jTT5
 vPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ch1xpBs7tWZiDXbLKgnS0zrW6JPy9+Lj1zi5nVSNmf0=;
 b=jtXXpNipfqW9WIBuxtMI8kVLUAzPsPdVcKpwXgK/TOisghnNCJHLAQEUJsYREt115M
 qJoe4tM+CW3xalvV7HK7eF8GeFi5AsEZmoZJ2ulyYoPaeQrzBiMBF4s+MNLdxlijZPhG
 Td6aMiwO/+2MT3EUYdqtBLubIUC8JtQh9DNSXWjLgiIP1RnuB0bRIBGkV2DYvfsVIFCc
 Ubyx8zs0CyED989lTyYbjU7s3eDg5NuhsDbXcx3y3h3uaS2RVoUBeseabLkImTrGOPGf
 v8KB6DFsgYqyVakYcxJo0fWYfneFrV5nFncatlWU2xgpr5zJEr8yZ5g1xd9EURM65pZa
 e6EQ==
X-Gm-Message-State: APjAAAXHzQK+UmsgeCB8zBN9kXlV9624Zg7hsH8OdRH0cLRTXqnUoCQ1
 CBlGPSr3SVvNDlzEE/WJvl56kY2k2o4=
X-Google-Smtp-Source: APXvYqx+uD4O7H1+/9+TYCWiKg5kvsgcNm/+ynGsIgnQRPs3qOIPEhoqkTDW7BuXV6/Oxzp2OWYlqA==
X-Received: by 2002:a63:101f:: with SMTP id f31mr5951015pgl.410.1575668336601; 
 Fri, 06 Dec 2019 13:38:56 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
 by smtp.gmail.com with ESMTPSA id d65sm17368579pfa.159.2019.12.06.13.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 13:38:56 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [Patch v3 1/3] iommu: avoid unnecessary magazine allocations
Date: Fri,  6 Dec 2019 13:38:01 -0800
Message-Id: <20191206213803.12580-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
References: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org
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

The IOVA cache algorithm implemented in IOMMU code does not
exactly match the original algorithm described in the paper
"Magazines and Vmem: Extending the Slab Allocator to Many
CPUs and Arbitrary Resources".

Particularly, it doesn't need to free the loaded empty magazine
when trying to put it back to global depot. To make it work, we
have to pre-allocate magazines in the depot and only recycle them
when all of them are full.

Before this patch, rcache->depot[] contains either full or
freed entries, after this patch, it contains either full or
empty (but allocated) entries.

Together with a few other changes to make it exactly match
the pseudo code in the paper.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 45 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 41c605b0058f..cb473ddce4cf 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -862,12 +862,16 @@ static void init_iova_rcaches(struct iova_domain *iovad)
 	struct iova_cpu_rcache *cpu_rcache;
 	struct iova_rcache *rcache;
 	unsigned int cpu;
-	int i;
+	int i, j;
 
 	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		spin_lock_init(&rcache->lock);
 		rcache->depot_size = 0;
+		for (j = 0; j < MAX_GLOBAL_MAGS; ++j) {
+			rcache->depot[j] = iova_magazine_alloc(GFP_KERNEL);
+			WARN_ON(!rcache->depot[j]);
+		}
 		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
 		if (WARN_ON(!rcache->cpu_rcaches))
 			continue;
@@ -900,24 +904,30 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 
 	if (!iova_magazine_full(cpu_rcache->loaded)) {
 		can_insert = true;
-	} else if (!iova_magazine_full(cpu_rcache->prev)) {
+	} else if (iova_magazine_empty(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		can_insert = true;
 	} else {
-		struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
+		spin_lock(&rcache->lock);
+		if (rcache->depot_size < MAX_GLOBAL_MAGS) {
+			swap(rcache->depot[rcache->depot_size], cpu_rcache->prev);
+			swap(cpu_rcache->prev, cpu_rcache->loaded);
+			rcache->depot_size++;
+			can_insert = true;
+		} else {
+			mag_to_free = cpu_rcache->loaded;
+		}
+		spin_unlock(&rcache->lock);
+
+		if (mag_to_free) {
+			struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
 
-		if (new_mag) {
-			spin_lock(&rcache->lock);
-			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
-				rcache->depot[rcache->depot_size++] =
-						cpu_rcache->loaded;
+			if (new_mag) {
+				cpu_rcache->loaded = new_mag;
+				can_insert = true;
 			} else {
-				mag_to_free = cpu_rcache->loaded;
+				mag_to_free = NULL;
 			}
-			spin_unlock(&rcache->lock);
-
-			cpu_rcache->loaded = new_mag;
-			can_insert = true;
 		}
 	}
 
@@ -963,14 +973,15 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 
 	if (!iova_magazine_empty(cpu_rcache->loaded)) {
 		has_pfn = true;
-	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
+	} else if (iova_magazine_full(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		has_pfn = true;
 	} else {
 		spin_lock(&rcache->lock);
 		if (rcache->depot_size > 0) {
-			iova_magazine_free(cpu_rcache->loaded);
-			cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
+			swap(rcache->depot[rcache->depot_size - 1], cpu_rcache->prev);
+			swap(cpu_rcache->prev, cpu_rcache->loaded);
+			rcache->depot_size--;
 			has_pfn = true;
 		}
 		spin_unlock(&rcache->lock);
@@ -1019,7 +1030,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 			iova_magazine_free(cpu_rcache->prev);
 		}
 		free_percpu(rcache->cpu_rcaches);
-		for (j = 0; j < rcache->depot_size; ++j)
+		for (j = 0; j < MAX_GLOBAL_MAGS; ++j)
 			iova_magazine_free(rcache->depot[j]);
 	}
 }
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
