Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5EDC433E4
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:02:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1366A20674
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6YW9Juq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1366A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D682C86B94;
	Mon, 17 Aug 2020 22:02:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BHvfesNr4ER2; Mon, 17 Aug 2020 22:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 37FE686B55;
	Mon, 17 Aug 2020 22:02:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27A29C088B;
	Mon, 17 Aug 2020 22:02:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 502F4C0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1EC8F204E1
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jGYo4A1Lw5Mf for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 22:01:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 6C56D204E4
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:01:59 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id f193so8908110pfa.12
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1FUoAbvyEKIH5lQKuzluOyz2/ynwOKVUIX8AS+w28WA=;
 b=h6YW9JuqbTq3TVlabwhWg4aAs/38VC0PkSQiYw06ptTsQl3LD5i77zZ+MuC3Pl0b3D
 MKzgD/leyspk69W2ODEpbH7hnzzoSWLmb/ybePpwsl359AQQN7Hb/yV2qgLPnZCrIo4K
 pQbagMAISi+rGuZeV9gGyVKBf3hqVW8hNFkAbcoGs5xWfz6MmEQYRt/vfhiGnW1gbQps
 SqcMH6r+kTFmgfpgUm2HlNhlpLJjfOLZGCSsPtVXizkudwJi6QfH73qJdSeR0H4Thl80
 PW1sQ23avxHUkoq/c+5W5Xh5UwZno0uOtf+ivkbhFSQU/VR5+PtvY2IRX9Who+KKY6Eu
 Nt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1FUoAbvyEKIH5lQKuzluOyz2/ynwOKVUIX8AS+w28WA=;
 b=GaK+2NLnJJvU3YdiBicgPQwQ+40w+qkCF0r+0upxZi69cztp3oZLbWDrNNP9YQg500
 IsBcwLbhFMyiLmd2xn/CgVCp9XkJA1H5H4t3mHf+APGrES3NsaQ/i0f8dkKJIxwZ13zO
 bgteaVU8VPKzd+7qJSNvd+2HM+mSKKQjrfS1+7thbXwbRMSoAtghRfv45kcnjDKEavRR
 HNvTYDf2YMN1tgeUPUJn4Y9aCdhAudMt7jaQeS6Rd/MAqFTOxALCCRofA0VLgqqEHY1f
 0gNZezcGajBmMxyEWEnaCpOLP7qxmbIwhgi40gUq0cOLSbNlVksgJn7Te9Bjpp+Tsfdy
 wYpA==
X-Gm-Message-State: AOAM5326yifJwnmDmXhmxm8erfQza8Svz/SNCAM+Y3u2zEacgq682ITX
 e8su5iq5mVUwfsnIZR3NZwk=
X-Google-Smtp-Source: ABdhPJwfBXHxP+FFJVxeGXrje9tQpj2dyq/Q74AQSixL9Uv0RglMKQZR9H8ViHvx/RDZCaxe40EtUw==
X-Received: by 2002:a62:fc08:: with SMTP id e8mr12486387pfh.208.1597701718956; 
 Mon, 17 Aug 2020 15:01:58 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 j8sm21721753pfh.90.2020.08.17.15.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 15:01:57 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 01/20] drm/msm: remove dangling submitqueue references
Date: Mon, 17 Aug 2020 15:01:26 -0700
Message-Id: <20200817220238.603465-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817220238.603465-1-robdclark@gmail.com>
References: <20200817220238.603465-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
 open list <linux-kernel@vger.kernel.org>
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

From: Rob Clark <robdclark@chromium.org>

Currently it doesn't matter, since we free the ctx immediately.  But
when we start refcnt'ing the ctx, we don't want old dangling list
entries to hang around.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_submitqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index a1d94be7883a..90c9d84e6155 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -49,8 +49,10 @@ void msm_submitqueue_close(struct msm_file_private *ctx)
 	 * No lock needed in close and there won't
 	 * be any more user ioctls coming our way
 	 */
-	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node)
+	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node) {
+		list_del(&entry->node);
 		msm_submitqueue_put(entry);
+	}
 }
 
 int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
