Return-Path: <SRS0=o1xy=ZV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48052C432C0
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 00:49:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2312176D
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 00:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uv7cRYLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2312176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DB86E884D3;
	Fri, 29 Nov 2019 00:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y2QwuW+pIA-K; Fri, 29 Nov 2019 00:49:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 714FA8845E;
	Fri, 29 Nov 2019 00:49:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5ADB1C1DC9;
	Fri, 29 Nov 2019 00:49:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B80FC0881
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 00:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4504822CC6
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 00:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UUOGS2AHTN5Q for <iommu@lists.linux-foundation.org>;
 Fri, 29 Nov 2019 00:49:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 5528220424
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 00:49:22 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id b137so11278204pga.6
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 16:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DpznRcuYAqspUUeo19X/byGcrul93mEcWyqODmZkSA8=;
 b=uv7cRYLrhvi/aOD4vOaTCjHBCFan3ldiAvc4IyTrphTn6qsfNGu9KJgLDPplUhhsNE
 9rhYnafXvB2m+I68G52zwym3HOaI+9O3+crzu1sv+pykaitf0cs43RAKQwEY8ycEOZMA
 lX9jfVgIKz5YpPqOq0kuGSZTgXt2BDYcNcQVqSdiNt9xPdl0h1F1CphV+H8DfmXXCS1w
 TekYSCJVPgrsCgAi2pb8FqBfPsImxxi6ruIsbwJp1sGaeKZUZigQ3XzGPxvmmKodf41p
 LYSifRjh2RmQrwJmhHJIab+BDFz7f2MnCsz9zMT+0ZvxulqF5SNeaidw9uHSeZ8kixWP
 ZJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DpznRcuYAqspUUeo19X/byGcrul93mEcWyqODmZkSA8=;
 b=WssTwHiNqxYCIafkq9Hn2S49UEKnKkgzRezTyjFFFOhybz3IiNTKfwuRDo5leo+8Kw
 p3FgGKdix3EA6447eAxZ88X8Sd703V33FNoFVStBtv4ggGrgTCXeZmeXkza+d4HM4t4+
 reLFcz76obQH2LVnnVVBPtZOi+ZrQO9vpHlx1hr12D1DQXb93Np1Cb7tkvAPp65N553o
 geOkP4a36QAj7dHK4JFnoDO1qKKHZunwnQb2eaPJO3QmllWvzyfsbEiwQxipvkg3Uihw
 W76qbC+xgtmdIHJoWv4i0CE7MdE/J93wJrxLB9l/b9Th4ZOjLoGrW3dRNtS2Hs1AivAY
 cx/A==
X-Gm-Message-State: APjAAAWCm5qqJ1/FPppOd8B2WqRqWie8kDqeZKfL7GqYSdTsp1jqZs3R
 1zSJ4+aeH+G9rda/+iyP6QlwY+DRCjE=
X-Google-Smtp-Source: APXvYqxhJpBu3a7f3trFLsAjKcUtittnlOzHQt84mLjfEE/MmzfgbT5/Xbz5tchacpJvSgs10fMTqA==
X-Received: by 2002:a63:5725:: with SMTP id l37mr14326615pgb.247.1574988561727; 
 Thu, 28 Nov 2019 16:49:21 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
 by smtp.gmail.com with ESMTPSA id 64sm22418202pfe.147.2019.11.28.16.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 16:49:21 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [Patch v2 3/3] iommu: avoid taking iova_rbtree_lock twice
Date: Thu, 28 Nov 2019 16:48:55 -0800
Message-Id: <20191129004855.18506-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
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

Both find_iova() and __free_iova() take iova_rbtree_lock,
there is no reason to take and release it twice inside
free_iova().

Fold them into the critical section by calling the unlock
versions instead.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 184d4c0e20b5..f46f8f794678 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -390,10 +390,14 @@ EXPORT_SYMBOL_GPL(__free_iova);
 void
 free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
-	struct iova *iova = find_iova(iovad, pfn);
+	unsigned long flags;
+	struct iova *iova;
 
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn);
 	if (iova)
-		__free_iova(iovad, iova);
+		private_free_iova(iovad, iova);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 
 }
 EXPORT_SYMBOL_GPL(free_iova);
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
