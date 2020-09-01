Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D14C43461
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:46:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB7B2100A
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 16:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeCm/VYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB7B2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C2D1886427;
	Tue,  1 Sep 2020 16:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rgG3U-QAZr0m; Tue,  1 Sep 2020 16:46:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5EED3862C1;
	Tue,  1 Sep 2020 16:46:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C23CC0052;
	Tue,  1 Sep 2020 16:46:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2940DC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1860B870BB
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UMwCRY-olfnS for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 16:46:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 213FD8709B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 16:46:20 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id bh1so803640plb.12
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7KAgNczSpcXSENE7I7HLjPQLwLd/js6kuYT9gLzGMrc=;
 b=MeCm/VYIOe9iYCLfeugzAyL6okJVgG4svLLFNAlw6jwgFSHyxPJTfOhTGLcz+3lmt8
 4Nqb/t7ulGZyBaw+FLZqWnrRTKBHvyy8wk23mtc6mtN1c8ky08w+sHTi6lVuP3a6fRMa
 z6AU4iKXMyPFlrW+d0VSVrr0seFt//Be6gxXDKFsj9k7weplTuaHXFwZvzNqYacw4zb1
 MZoK6jiacE9P6k33ODJiryhUWGzVv8aO5rd2g9ZTMVvwrNpOnaIIPLlHwcAo2RlyKhpw
 d+n7xR/mD2Z78MSBOTKNGKlfBllUivdl7eWaHPAFceBf1i0d+ImM8e50nQfOJw6qsL7c
 0JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7KAgNczSpcXSENE7I7HLjPQLwLd/js6kuYT9gLzGMrc=;
 b=Qt37gO80Lc87H70agczEh0V5kXgGllKjbe5hYev1Efb/GnbqIkuSGts1BZhhXLvjZ4
 Uy3wbUgiDlhQl9YEY4y5Sfelk3kDzFK1c7np532UjGYzqkEDDKZNx3GbBtRHrvyLQzjX
 OHVR1d0tDi5MsqRrkyZLzxkY0A24C9qlaGqeh/eTcOA1RnzSmJQ9LsauEnqZenZ2amzS
 W1RmYoY/Dw2ZTZ0UsTV42f9YqtUqYvfQj8m049p8RJEVPTbAmpTdHBrnK5P4amQNfDsl
 AGk9gmdHn0f1utuuRw9e3UyDR6oxLWDVBEnwXTry+2QmDViUoryt00JCv/EAA3Yepzpc
 R9hw==
X-Gm-Message-State: AOAM531xj137eHbrL0bifY2z1zX5LqwE51FmxMooecNdPppnVz04nrcV
 Uw25qOCZPlxo6oSfo0K2puc=
X-Google-Smtp-Source: ABdhPJwjrPAmB1IlUhm3/lAYNFCsGsLfWotZDUGXrh1rk+DjB79F8gK6EHU9pv/Qpy7KR0JW5A12Mg==
X-Received: by 2002:a17:902:8307:: with SMTP id
 bd7mr2134655plb.159.1598978779659; 
 Tue, 01 Sep 2020 09:46:19 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id p20sm1967660pjz.49.2020.09.01.09.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 09:46:18 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v16 01/20] drm/msm: Remove dangling submitqueue references
Date: Tue,  1 Sep 2020 09:46:18 -0700
Message-Id: <20200901164707.2645413-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901164707.2645413-1-robdclark@gmail.com>
References: <20200901164707.2645413-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Sean Paul <sean@poorly.run>, open list <linux-kernel@vger.kernel.org>
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
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
