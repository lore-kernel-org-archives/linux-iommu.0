Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191FBC43140
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 21:51:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07BE206BB
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 21:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7tJANYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07BE206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9E4E527C8;
	Fri,  6 Sep 2019 21:51:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D3FF427C2
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 21:51:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6C6B87DB
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 21:51:04 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id h195so5460825pfe.5
	for <iommu@lists.linux-foundation.org>;
	Fri, 06 Sep 2019 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=eDpX53pV2w3525Sfc++y574jdtjcTxKRU6k4wrPYJJE=;
	b=R7tJANYP9RC8vMxjaiQJQysGREeC4SukBKwQay9FF+AMJE+MvsYVBFrsati6KaggWM
	VWkpRA7WPb67hbvt9c4rmHWNClvfUZwODODfoY+fH9crahdylzEddDD/2NidH2MKqLAp
	Iapm/hiz0A2mDeZEclyVm+SdU1bJGoc8FP6NklRbcl5IksRx0lwTVYI5cealjOhS7XYM
	gitoGxs4V3Z1Ekpym5seReRqr8Hs7DrGi6GbW553Hr4d3wKFAx1oTU7V3ez1y5WfY1gc
	2nf2SwaiX5AwY5cE+npxZbJaQLMTapIZxsY6RSypeBRKrquK9OECMgG8670DMSeZaHyp
	Vsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=eDpX53pV2w3525Sfc++y574jdtjcTxKRU6k4wrPYJJE=;
	b=ZTSarCbz3fPsw6iYOpVEoOTjYWAAL+NF+itzsRxipookD5V0ezFg2p1N/yS3ty8u6c
	MGme8bY1RngIVnqdAFBTnYgugo/50VNDQbHh/HzgReC9aUCbcW12+iXNV6Tvo3Z+99fz
	HBQC9LsuJiBVjSMut8sQln6kXUbAJKyZgbHItgnpRnAMRSG3GkiM7sYBS+0wT6+z/gjq
	MZulVNPNeFyga4vfQToPgPUPUjb4u2f4yraBY8OpsrNnYRgWWua8cL7xidD/LM1idmi9
	7EH6TiFZHcM+hZEYbyt+sHOqBpelSYxxVr3DDP0yitYlt8haFOMqe0yWLrek+ZIqlUaf
	0aYw==
X-Gm-Message-State: APjAAAUeI+5lKiQPLdG+Ad29leN1a5q4zpcdJ0PfvcElfxoB1EwgeH0t
	o5k0pGksgtkx5TcO42WIjmTEC84et4Xkcw==
X-Google-Smtp-Source: APXvYqxxmn9ULbrQFMLJEtMySO7JBNQkpSXC7k9Y2QPcQyK5SFcavLc7RGYi6hNSQ6p9Iz352cwvcQ==
X-Received: by 2002:a63:484d:: with SMTP id x13mr9803253pgk.122.1567806663646; 
	Fri, 06 Sep 2019 14:51:03 -0700 (PDT)
Received: from localhost ([100.118.89.196]) by smtp.gmail.com with ESMTPSA id
	g14sm6823936pfo.133.2019.09.06.14.51.02
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 06 Sep 2019 14:51:03 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/2] drm/msm: mark devices where iommu is managed by driver
Date: Fri,  6 Sep 2019 14:44:02 -0700
Message-Id: <20190906214409.26677-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190906214409.26677-1-robdclark@gmail.com>
References: <20190906214409.26677-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org, Will Deacon <will@kernel.org>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Rob Clark <robdclark@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
	Mamta Shukla <mamtashukla555@gmail.com>,
	"open list:DRM DRIVER FOR MSM ADRENO GPU"
	<freedreno@lists.freedesktop.org>, linux-arm-msm@vger.kernel.org,
	Abhinav Kumar <abhinavk@codeaurora.org>, Bruce Wang <bzwang@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>, Sean Paul <sean@poorly.run>,
	Allison Randal <allison@lohutok.net>,
	Boris Brezillon <bbrezillon@kernel.org>, Enrico Weigelt <info@metux.net>,
	open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	Robin Murphy <robin.murphy@arm.com>,
	Georgi Djakov <georgi.djakov@linaro.org>,
	Sravanthi Kollukuduru <skolluku@codeaurora.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    | 1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   | 1 +
 drivers/gpu/drm/msm/msm_drv.c              | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7f750a9510a5..19f2bd2d6cb4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -452,6 +452,7 @@ static struct platform_driver adreno_driver = {
 		.name = "adreno",
 		.of_match_table = dt_match,
 		.pm = &adreno_pm_ops,
+		.driver_manages_iommu = true,
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 5751815a26d7..dec8cc6b64dc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1094,6 +1094,7 @@ static struct platform_driver dpu_driver = {
 		.name = "msm_dpu",
 		.of_match_table = dpu_dt_match,
 		.pm = &dpu_pm_ops,
+		.driver_manages_iommu = true,
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index d93de3a569b4..eff1b000258e 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -1134,6 +1134,7 @@ static struct platform_driver mdp5_driver = {
 		.name = "msm_mdp",
 		.of_match_table = mdp5_dt_match,
 		.pm = &mdp5_pm_ops,
+		.driver_manages_iommu = true,
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 3a4fd20a33e8..336a6d0a4cd3 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1388,6 +1388,7 @@ static struct platform_driver msm_platform_driver = {
 		.name   = "msm",
 		.of_match_table = dt_match,
 		.pm     = &msm_pm_ops,
+		.driver_manages_iommu = true,
 	},
 };
 
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
