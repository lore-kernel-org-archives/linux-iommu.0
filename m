Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A8EC433E1
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:41:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EAC2074D
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMBfFYqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EAC2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A656F875D4;
	Mon, 24 Aug 2020 18:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OWPu1LQbqWkh; Mon, 24 Aug 2020 18:41:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B8E5875A1;
	Mon, 24 Aug 2020 18:41:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16E36C016F;
	Mon, 24 Aug 2020 18:41:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17994C0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 04749875CB
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:41:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGGR-0tPniNb for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 18:41:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 28C7F8758B
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:41:45 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id 31so2739547pgy.13
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fFdgtfwZrc/kVc+fLHaAXwOBlYLh1Scshg8PrDPV2cA=;
 b=JMBfFYqJssdNSpKeUnYwIYl16ci2D3KflwOOxfvM3CU9HPQiYllCH5sZjJPFSv7cRc
 1fmivhMx1dEE/3e/XzIlSNWneWOqC/cCvVnVehH+9VJW3f5N31ucofST7kI3KW1XQgdB
 XiVWya9r4ICUQOX0+77Xay6fR0AFrkVucVF5OuTzI33dNbktUe5Hebd1IK78Ddv7K0IA
 r7LUfRXepbKvcNwNwlw/U1uBZVkJDUrROyPnBnj5pJvPHyQFrEl4PjqHT/hYiP/4sZTq
 cb39WH8a6lTBuxtGkHAJ5OuHyeEqK5qDSMvNljF0qeTrTb0JeWGON4CMxhGVL+tnWK7m
 EGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fFdgtfwZrc/kVc+fLHaAXwOBlYLh1Scshg8PrDPV2cA=;
 b=XdpuS9BvmXEd+vMHt22LGx1J+wdqRxfmkhFRD9wCdjJYDL6FX3OlXKiknKwkNjCYJM
 dICpW3EMTQcSvB67FcYma/U6LGvV1bO+NQJq8w6ef+m+CBI7O8ElCdakOuZ/ijC82Pq6
 BULZjYfyzzPoMwfgi+UZkE0H1zPG36T38yWJvyTUS9+5seW80cER1i+TWgyI4ozVCSdR
 N2Ut4kE40VT/9965o6gm6DFrIMLpST8B2zW85QQWfEYJQTkX+vDeH5KqLQBPXeBTjjBS
 vVCALdA8DXTdufV9GHk5+hQ8ItARSZQSDIVUM1v4d/tE1W+wBnk+DP1NqTDia33wbLt/
 qtgA==
X-Gm-Message-State: AOAM533JNQ6UOxZu33DQyj92oo2XNkAzgrB/ejFSBMBcNGrxWs+vjsVA
 TaHJc6C5YdO762oS6q6JTow=
X-Google-Smtp-Source: ABdhPJzrk/w8HSHD4F2CriYbzO3IkcbXkvduywKAs1ONUCGEOtsuxUrphk9jrVQS3ajL5jYLaF+wQw==
X-Received: by 2002:a63:f44d:: with SMTP id p13mr4124438pgk.363.1598294504582; 
 Mon, 24 Aug 2020 11:41:44 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id b23sm11949461pfo.12.2020.08.24.11.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 11:41:43 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 01/20] drm/msm: remove dangling submitqueue references
Date: Mon, 24 Aug 2020 11:37:35 -0700
Message-Id: <20200824183825.1778810-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824183825.1778810-1-robdclark@gmail.com>
References: <20200824183825.1778810-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, Akhil P Oommen <akhilpo@codeaurora.org>,
 Eric Anholt <eric@anholt.net>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Sibi Sankar <sibis@codeaurora.org>,
 Brian Masney <masneyb@onstation.org>, Joerg Roedel <jroedel@suse.de>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, John Stultz <john.stultz@linaro.org>,
 Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org,
 open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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
