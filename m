Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2898C433EF
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 05:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B6F760A82;
	Tue, 29 Mar 2022 05:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YjVndogdkvUM; Tue, 29 Mar 2022 05:53:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E61A605AB;
	Tue, 29 Mar 2022 05:53:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58BE5C001D;
	Tue, 29 Mar 2022 05:53:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1979AC0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5C2A404D3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28Dfpiqnvt0m for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 05:53:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 472E640377
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:53:30 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id w141so13034381qkb.6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z0ES53g0OOqsPoiGi2d2Co81xUcv6Z1BfsAHsJmc4I4=;
 b=RlMWCaOrAo5dN1BiL6EVuuy1RvRkHVnOIIbStddIbRL5Tff3uKYocdMkA+X90v6Fp6
 q61Ck7S19m2JKbIxic+yoY97H1FNks/88LSGlKfUWzPRfdNrUa4koSZn2i8z9XOxU7Y4
 JoECdrQIT8aOikMti6FwwT1MMczrwysp7zevGR8L97OMkJ5RwafEOZGEWHgjWkAPrNm8
 2hagbnApe8/dJ7jwkppFVBWFWS4pjXfbddsBMdUocBkc4w+uZtBGml7Xaqu+iqPLxz0s
 I4d3z93wekZmLNdVuSz+LaySzuN7N5OXi6jV8X5bPqeCivCAH4GlhqcqFu91MEB0ERPs
 wzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z0ES53g0OOqsPoiGi2d2Co81xUcv6Z1BfsAHsJmc4I4=;
 b=377sqND5tK7faIP+z7UsmqDrXJMEk1c0shxHfOkQmEXYorrzIAoRlopurwBZWJEhvM
 NWxHwHcrrgENUjABNW1o44psXTMhY9Q7pk4A9e2mIHoOe6kmf95lNmQqV//FyYVvsYFg
 kq2AzeSw4SUzThM0eJibbgAaZIqTl34Ziypr+2syDcGzLSVbFS1HOgqjHh2SXufpVK7r
 2/Dv/P7J08buDeileff+J0QWLnnZ3qFNGs+GSF67ksF/H3g72b3C6Yb2jlsAOkZe7CDN
 LUg1jA43asJOu+lcfgMo+BtgzjaF6l7xgD9WtkSn7g4YaQ5Q/dJaekOgJc6dKRCTbsem
 fkZg==
X-Gm-Message-State: AOAM533m1pZKBdIkZoY48GPLIpejMrFcEwKsbLxgVOrV49Uapi2NhA/p
 G49c0cJOMbqgRu/Z/PisKnM=
X-Google-Smtp-Source: ABdhPJzx5EMjqNBolLzGQPqTHbHt0diMdH9y1Q1vkoKXBy0Bq3/cBK5s99yJKHmDbeOjCWuRtwLKkw==
X-Received: by 2002:a05:620a:4491:b0:67d:9929:ddb6 with SMTP id
 x17-20020a05620a449100b0067d9929ddb6mr18554334qkp.47.1648533209079; 
 Mon, 28 Mar 2022 22:53:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id
 h8-20020ac87d48000000b002e1c6faae9csm14153307qtb.28.2022.03.28.22.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 22:53:28 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To: joro@8bytes.org
Subject: [PATCH] iommu: add null pointer check
Date: Tue, 29 Mar 2022 05:53:22 +0000
Message-Id: <20220329055322.2375563-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Lv Ruyi <lv.ruyi@zte.com.cn>, iommu@lists.linux-foundation.org,
 Zeal Robot <zealci@zte.com.cn>, will@kernel.org, linux-kernel@vger.kernel.org
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

kmem_cache_zalloc is a memory allocation function which can return NULL
when some internal memory errors happen. Add null pointer check to avoid
dereferencing null pointer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/iommu/fsl_pamu_domain.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 69a4a62dc3b9..43849c027298 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -152,6 +152,10 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 	}
 
 	info = kmem_cache_zalloc(iommu_devinfo_cache, GFP_ATOMIC);
+	if (!info) {
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+		return;
+	}
 
 	info->dev = dev;
 	info->liodn = liodn;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
