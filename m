Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213EBC433E8
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 02:40:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D2F20715
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 02:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+xR5/sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D2F20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C021988890;
	Fri, 14 Aug 2020 02:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VRnKbEOK27eK; Fri, 14 Aug 2020 02:40:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3B57A8888C;
	Fri, 14 Aug 2020 02:40:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34F4CC07FF;
	Fri, 14 Aug 2020 02:40:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3415C004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BCCFF86FFD
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hDWi5GvM3xod for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 02:40:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 17FDE86FD7
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:40:46 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id l60so3717258pjb.3
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 19:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1FUoAbvyEKIH5lQKuzluOyz2/ynwOKVUIX8AS+w28WA=;
 b=C+xR5/svYbw49MY4CeW82SJXbGnX+JNhURW4NRg8W+6hzAFLpOU/my1FRJ5O0gHGWf
 VAlVdoW2esbR7vWEeQUWFH0Jq7GcD+xFsBOUjeG2U9x2SHmPNLxwcvV97RwA1l4fh+i2
 +M/34tH1Wr6XkBaaDg/Jg9eqhDsR+jDTIVk5lXr0M35SPbUSBzfRDX4MI+XsXjmJW5q3
 2sEOICZBbL04zS1AtXchQpXCRnUiNeCTzSTTANAy4nkzofNJgX+QaKLbSAkfsbvzqzyZ
 VjlfYKMGh7pJgaTph9vg4QVkl+kXKsVtraG0hRt1hw5/JDgmMZiwZUh0UUrRcksHgXH1
 Jdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1FUoAbvyEKIH5lQKuzluOyz2/ynwOKVUIX8AS+w28WA=;
 b=FXoFWpwNqW4+8XtO+vx37Q3SR5RY5kre8pPWMAkf+W7/7zvqaSVcf0W8TQ3z7q+HTo
 8Lr+TtVJG3kxfSh9t33GhMjKCvHgdvljvamQknvPKb5CjLdZFipsa7J2lX3uSVqWkdE+
 t+gfD348FkO15rKqsC8usiLCFBBOhOUw43U7cXrjb1owV4AxMDWcB8V0TfNJkN6cyOGc
 u63gRidNIpnmID+gYwOInsfrhBH7aKLGUoklsLrc19q13Qk+K2P1e79A/P8x7TI5AfiF
 cxTYcidxhzGd464YwtiLfWKzCz9oIH9txV7dlf4BtHMY1iJyKuTvKRNv7asJ64PVowHy
 lquQ==
X-Gm-Message-State: AOAM530eJCAU4rHXRuZG1qx2XVqJ/QuZsrZixLrpLfyz0qnMu29JuCtM
 euy++QacjWO2OBRLppyTjkU=
X-Google-Smtp-Source: ABdhPJyTjSmkPtRA6/sXaKkEFWxaxBkZ4HL8mupIi9HzpilQYOPzsg6o2GqsZMiPbcCB0VR+sfOnTg==
X-Received: by 2002:a17:90a:6fc5:: with SMTP id
 e63mr497592pjk.200.1597372845667; 
 Thu, 13 Aug 2020 19:40:45 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id a19sm7294660pfn.10.2020.08.13.19.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 19:40:44 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 01/19] drm/msm: remove dangling submitqueue references
Date: Thu, 13 Aug 2020 19:40:56 -0700
Message-Id: <20200814024114.1177553-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200810222657.1841322-1-jcrouse@codeaurora.org>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
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
