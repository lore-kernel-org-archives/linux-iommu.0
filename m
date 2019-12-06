Return-Path: <SRS0=JKdE=Z4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339DEC2D0C1
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 21:39:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015092173E
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 21:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyPQPMqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015092173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E757387870;
	Fri,  6 Dec 2019 21:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wjJaWzBwaMgw; Fri,  6 Dec 2019 21:39:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6D7E68785F;
	Fri,  6 Dec 2019 21:39:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A4F3C1D80;
	Fri,  6 Dec 2019 21:39:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0664AC077D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 21:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0271089278
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 21:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DuMPyL1cCgmF for <iommu@lists.linux-foundation.org>;
 Fri,  6 Dec 2019 21:38:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4934189275
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 21:38:58 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id b1so3938563pgq.10
 for <iommu@lists.linux-foundation.org>; Fri, 06 Dec 2019 13:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7tnHP49bcbdj6wbVlgmEh/i8N9jDvFKi9kaAZwgRO58=;
 b=TyPQPMqMEZSbzOq4YJ/CvyzohiFL0nmwcH8xHd7uNVwqdGTgbtf0zTU4yDZK1m7Vyx
 hlYdg2gEo6eO6NHj76PC38ouj8DYqG4UVvy/IzsnpWtq4/6d27V38a3kSPzQTyRtkR8Y
 2M6qvvr0p5NKM43hOouFg3JyFqzJj8i+zZ4l9OaZ89xWFzoA01K5obewearyD4XEXHvc
 zOIIvRBWygSG4Kst7lrgh+0haf87ZCGEIH/a8AKlLmbyJASFzCV/3fynQziQjZUvx72H
 TVDQRhfWyvqzoj/HeARTIzz7Qk776PoUSWj/v2R7ml8Voe5PoswscOetD8p5kipOy5gv
 t7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7tnHP49bcbdj6wbVlgmEh/i8N9jDvFKi9kaAZwgRO58=;
 b=ItFImyt2DUo4OybXZSrWUMEXyPwlI0Zk0QEGqE+7nPZx/Sj9S0pVWglj/IC/CiBfoE
 4A9v7OF3zb0S5nZTZNkdmZVlPaL62BunFtrv/joCAsY4WuSck2wTeWcgiDUaF3PZJxq0
 veUmkUy9TsWNVrZ3vXZiInjiUS0NjOBWqoxkrGKv2lXVSCZOLbdRlohBDphAuF9hHV1W
 gMAkUpfJ8kmscvHIn+fCoeX3pFoO78H6vwnd+FkTulFmB7OiqHVvbdTCNWC3lZ1dzNrO
 NuL1PeAfP2bHqivSLs9CnGtdUlXDdD16Ldl4wG8gn0G7nyHvPF9qvOk/AxRpielLF1yb
 D9ng==
X-Gm-Message-State: APjAAAV8zlRw3R5c6aYs/XLLcHs6phTQWrcCDV4CgkQ1d5DmfH2BqS/a
 ni6DI7iQR3XmdUkNk6xb6b8i43soXfc=
X-Google-Smtp-Source: APXvYqy2mcWYMGqjSshbYvqQi62LTZgqbF8ADTCo4gLwYPawIPjikZb3TSZDYbkVlgy2vV0XN6ksiQ==
X-Received: by 2002:a63:5056:: with SMTP id q22mr5820145pgl.20.1575668337654; 
 Fri, 06 Dec 2019 13:38:57 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
 by smtp.gmail.com with ESMTPSA id d65sm17368579pfa.159.2019.12.06.13.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 13:38:57 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [Patch v3 2/3] iommu: optimize iova_magazine_free_pfns()
Date: Fri,  6 Dec 2019 13:38:02 -0800
Message-Id: <20191206213803.12580-3-xiyou.wangcong@gmail.com>
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
