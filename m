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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E3AC2D0C3
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 04:40:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1276720715
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 04:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0yzhS23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1276720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C5E9488349;
	Wed, 18 Dec 2019 04:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wNKBIriiLk97; Wed, 18 Dec 2019 04:40:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 45BD488345;
	Wed, 18 Dec 2019 04:40:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33667C1797;
	Wed, 18 Dec 2019 04:40:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C31CEC077D
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 04:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ABABC88345
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 04:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nNWw4Pd5qPdF for <iommu@lists.linux-foundation.org>;
 Wed, 18 Dec 2019 04:40:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6DFC38833F
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 04:40:20 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id d199so481684pfd.11
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 20:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7tnHP49bcbdj6wbVlgmEh/i8N9jDvFKi9kaAZwgRO58=;
 b=O0yzhS23HGtIJZbs0zAM+mSOkQxGOG6AvwAEalcJQrw8ZovBcuay4V1Al0Dj1xAO1f
 wVwcbxEVekcuUvSyh+zo6MysMZ5iBMzSPyuDESXnLF9rM2PPdJsmgWA5pMB+8Diot1EN
 lSQGr0HWcuk9CMYUxTzT93IL2wrD4zOvVqK+OCMm/TxxvRsmeo/R8X13p7tTvk0jwo+f
 j9Uqkm+lpWXaZU7IkuGF6CpBWm39tcrP5N/RouvlnfyqEr7T1O97IH7dS5E/4zZeiggR
 nYUMan99mW+H1e5ehvAYcsf1mOavIMEUaJRhZJv0wLFajDCMFAdkVribcE+GJNceDZkj
 D3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7tnHP49bcbdj6wbVlgmEh/i8N9jDvFKi9kaAZwgRO58=;
 b=QrkwftdKCEsgWWXIN77KMSxh9AOhVy3rV062m5j38WT1mOLmUDs2G5irsOU/qsReih
 qTRt0WD5tX9Jl8AlFkZjRRa6+3RGz+OmVtnKk1wTM+dPidthwcf2nhys17YWXrnPcToE
 EN3mqUBYl3Q0PCSRkoORDk6M0l1C95Gx/OyHqSxcvSMBVcfPodXQNrjDejRMPzhMuYvt
 +irWHTpTumgP0fCn0HX0hgzHXzAF+gBR/XzEd8rnXRa45NrSoLRBh/Ho+Ys2tJk+SXyW
 6uV6a5X0+v8Y02jKN8s/VO3yStturhTfBcKriFp2kFT9o8BqYQBezEhaguSv4SgcYFVl
 H3eg==
X-Gm-Message-State: APjAAAWXK8WrQ0qt1L4or5iZAUmR1F7WH72Suw7X41fVGJxoSh+UFNY7
 866yMquTFIjtiGMmAYTN3MnNwaQVVkY=
X-Google-Smtp-Source: APXvYqzSQ8EkWQ17u7mqdOiOyZaCadH8FPwTAgfdXevSealYbYZ5TAeFeSKvd1+6TyOxHGnOE1UJ0w==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr617092pgd.387.1576644019834; 
 Tue, 17 Dec 2019 20:40:19 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
 by smtp.gmail.com with ESMTPSA id j21sm781105pfe.175.2019.12.17.20.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 20:40:19 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [Patch v3 2/3] iommu: optimize iova_magazine_free_pfns()
Date: Tue, 17 Dec 2019 20:39:50 -0800
Message-Id: <20191218043951.10534-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Cc: Cong Wang <xiyou.wangcong@gmail.com>, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org
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

If the magazine is empty, iova_magazine_free_pfns() should
be a nop, however it misses the case of mag->size==0. So we
should just call iova_magazine_empty().

This should reduce the contention on iovad->iova_rbtree_lock
a little bit, not much at all.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index cb473ddce4cf..184d4c0e20b5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
 	kfree(mag);
 }
 
+static bool iova_magazine_full(struct iova_magazine *mag)
+{
+	return (mag && mag->size == IOVA_MAG_SIZE);
+}
+
+static bool iova_magazine_empty(struct iova_magazine *mag)
+{
+	return (!mag || mag->size == 0);
+}
+
 static void
 iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 {
 	unsigned long flags;
 	int i;
 
-	if (!mag)
+	if (iova_magazine_empty(mag))
 		return;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
@@ -820,16 +830,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	mag->size = 0;
 }
 
-static bool iova_magazine_full(struct iova_magazine *mag)
-{
-	return (mag && mag->size == IOVA_MAG_SIZE);
-}
-
-static bool iova_magazine_empty(struct iova_magazine *mag)
-{
-	return (!mag || mag->size == 0);
-}
-
 static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 				       unsigned long limit_pfn)
 {
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
