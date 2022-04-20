Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1731CC433EF
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 03:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF72E60FE9;
	Wed, 20 Apr 2022 03:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ph-jMOJgsmyu; Wed, 20 Apr 2022 03:07:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8A2A260A4F;
	Wed, 20 Apr 2022 03:07:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 728FAC002F;
	Wed, 20 Apr 2022 03:07:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C190C002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 03:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDB964023B
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 03:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JUe8Bd-9tqEK for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 03:07:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F48A400A4
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 03:07:36 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id s4so417035qkh.0
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hpmyg8XLS13nF/sVE65s2xiBisYTpjV5/f0AVee7Iss=;
 b=TAL2aCc91h+Ay7idog+nOlQuP8J6jP28XTdU1Y6wUy6VMnZoqEl54ET/e3GXf0xNi/
 15Ha0PlwVZtDaWDVIyaEGFBnNyueQU/dhknbMFUvtPau6P9z03NTa6yDXfMkyk5V0OiK
 drcgS8fUset703wRlXMEpyRGj6d4xp8hhQlpWH2yciub/lYl+ogS1nnw38IHkk7+KcMH
 ZczgNtLLy2JAhxX7sA6Em58ijKp626XjEJ9dD5S3C/8w/IrYbZ8rzkf6h65BpLx0IL/B
 RUdEeNxproDeP4HEdaAxvRf9wmdrv6N/MKQcrENdlZS7UmKC7+VliEbfXTU58oi54ACa
 JdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hpmyg8XLS13nF/sVE65s2xiBisYTpjV5/f0AVee7Iss=;
 b=PEhjoD4zZToGBsXEC/efw0ZlMcMZ9V3uZPtzDmNINKscv4AqP+7ieCJe/Dn2GNHJbW
 kvtJG0HM10oX6JmYug0fSSCOwMjiAZ7R2Y5Q/n31Ir6af901ZJRN++g2uobimoN64/qX
 7rKepq4QT7Q7Vy7XGGgvXbhd8BuSX3muoOEy9+McXmT8tgQ56zLyYsfVlvWsIgBc5D0t
 gOeEUnJsdJzMycPT/HhAEoECc/b46DwgXpLGFjCXWZsf0Ru/PyCatRgvwwmjMUO6CXt3
 64G1DQ/Ju/mges+rWJ2qQDb7qUZo5ErpyhbgUOn1lyd1zkJgBPxBGmkI27oHrwS4P88n
 nQtA==
X-Gm-Message-State: AOAM531G6H4YqUw+sava1oo8kx5HQsX5F8ApDB54J1SgkrYDYwktRoOV
 /jT13i5a0r7msF+m747vc4s=
X-Google-Smtp-Source: ABdhPJy4wHrCRkO6ny5AYzUzvmrLJxHazJY5R+UASEjdsR+b+H3QhIPr7QTeV+IrTguLc4w4HJjKcg==
X-Received: by 2002:a05:620a:30a:b0:69c:10ef:c87f with SMTP id
 s10-20020a05620a030a00b0069c10efc87fmr11279776qkm.634.1650424055254; 
 Tue, 19 Apr 2022 20:07:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id
 l130-20020a37a288000000b0069e8290f28asm914740qke.97.2022.04.19.20.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 20:07:34 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To: joro@8bytes.org
Subject: [PATCH] iommu/omap: using pm_runtime_resume_and_get to simplify the
 code
Date: Wed, 20 Apr 2022 03:07:29 +0000
Message-Id: <20220420030729.2576005-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Zeal Robot <zealci@zte.com.cn>,
 will@kernel.org, linux-kernel@vger.kernel.org,
 Minghao Chi <chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/iommu/omap-iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 4aab631ef517..7cfa80ccd9a8 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -193,9 +193,7 @@ static int iommu_enable(struct omap_iommu *obj)
 {
 	int ret;
 
-	ret = pm_runtime_get_sync(obj->dev);
-	if (ret < 0)
-		pm_runtime_put_noidle(obj->dev);
+	ret = pm_runtime_resume_and_get(obj->dev);
 
 	return ret < 0 ? ret : 0;
 }
-- 
2.25.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
