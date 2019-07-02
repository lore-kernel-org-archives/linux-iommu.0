Return-Path: <SRS0=9cYo=U7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B807C06510
	for <iommu@archiver.kernel.org>; Tue,  2 Jul 2019 20:31:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5215421897
	for <iommu@archiver.kernel.org>; Tue,  2 Jul 2019 20:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll0agao4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5215421897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 246B6215C;
	Tue,  2 Jul 2019 20:31:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 93B69212A
	for <iommu@lists.linux-foundation.org>;
	Tue,  2 Jul 2019 20:27:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
	[209.85.222.170])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 18640782
	for <iommu@lists.linux-foundation.org>;
	Tue,  2 Jul 2019 20:27:24 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id c70so15486194qkg.7
	for <iommu@lists.linux-foundation.org>;
	Tue, 02 Jul 2019 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=f88teEGjW0nN2FOE42nXfLv5A25XcE0eqQQ8ZnR07JU=;
	b=Ll0agao4aIAnYcVNBBJOi+jd2NnL7QD8TFl2aymNrYa8HK9DfMy3v495p9gROFHA/u
	tBjVOgT8daPT5d2w7eD0aIAJcOnV2Rm0aXDybT+G8nVx45y3yWG9lhFLBDmME6FqEjta
	Ijtfff8L3j7Mg5evQw8L84tr7CfFcwbnR7f3OrWMYv8cO2+3YB5og9XSOe+WXbhBmh0X
	zMnRegRXhZdqaIRGzM4fRFZzs3v+M9wwYnC0urB7YLmpETZ8ohPdGl9Q9vwZkX3eIeTH
	GDEss+h6oeE5WZoM2Or2mJg/DW82eGWfRdwgsyXaTb+yeU+DW8GtpUyBE2U19ecsdLAX
	3X5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=f88teEGjW0nN2FOE42nXfLv5A25XcE0eqQQ8ZnR07JU=;
	b=bGiC5RTVoWZd6L7nGlaXx4M4r8PYfPgM8yXxyXP+niBRb4mqvRV/my7VNP589bBAlA
	5M6eH4DeEOqnOwMdiE9ZSLc2hUOBqt03+CqLY0nM5VPoVQaXV/WVBwEszXiLEDwOaDhe
	pKB1R9VyQl0bKBkAxYKEatnL4Zwc2icvNjWumhP9n5q0SOr2G4vtQI0pUafVSUyoecet
	cpAJJDTiDE0kfExl1XqaDLru0uvsk8QSzjOXzEdPK0Q14lc9SqzgtPD/zo5ahDtKVN8X
	JJl202pZiNbrrNvoVCqmA7gKxBl6cSfvMUWJO27hE2VaH/MK3jPYB6zrtDb/XPQIEIER
	wElw==
X-Gm-Message-State: APjAAAXziqeVEoll2gp6vwi/lL5CPWpHsjDrvaZ4kaUQyijUWpcMAiYK
	NJHAy4gsvweblpESRGAUi46GU7Ibgx1Orw==
X-Google-Smtp-Source: APXvYqwAlzApaqBBZtvqYr3CR/RH/kfQMFwRY/ZWxa5i4JJUxMfatKd6fTCEHxCx0jSEgts8E1Dq7w==
X-Received: by 2002:a37:a882:: with SMTP id
	r124mr27068226qke.398.1562099242989; 
	Tue, 02 Jul 2019 13:27:22 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
	by smtp.gmail.com with ESMTPSA id r17sm10510qtf.26.2019.07.02.13.27.22
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 02 Jul 2019 13:27:22 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/msm: mark devices where iommu is managed by driver
Date: Tue,  2 Jul 2019 13:26:19 -0700
Message-Id: <20190702202631.32148-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702202631.32148-1-robdclark@gmail.com>
References: <20190702202631.32148-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, aarch64-laptops@lists.linaro.org,
	Jonathan Marek <jonathan@marek.ca>,
	Boris Brezillon <bbrezillon@kernel.org>,
	David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
	Mamta Shukla <mamtashukla555@gmail.com>,
	linux-kernel@vger.kernel.org, Bruce Wang <bzwang@chromium.org>,
	Abhinav Kumar <abhinavk@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
	Daniel Mack <daniel@zonque.org>
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
index b907245d3d96..d9ac8c4cd866 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -441,6 +441,7 @@ static struct platform_driver adreno_driver = {
 		.name = "adreno",
 		.of_match_table = dt_match,
 		.pm = &adreno_pm_ops,
+		.driver_manages_iommu = true,
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 39378ace57a6..001fa7986f31 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1127,6 +1127,7 @@ static struct platform_driver dpu_driver = {
 		.name = "msm_dpu",
 		.of_match_table = dpu_dt_match,
 		.pm = &dpu_pm_ops,
+		.driver_manages_iommu = true,
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 97179bec8902..2a1b8709d0dc 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -1100,6 +1100,7 @@ static struct platform_driver mdp5_driver = {
 		.name = "msm_mdp",
 		.of_match_table = mdp5_dt_match,
 		.pm = &mdp5_pm_ops,
+		.driver_manages_iommu = true,
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 31deb87abfc6..16094b8c5418 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1352,6 +1352,7 @@ static struct platform_driver msm_platform_driver = {
 		.name   = "msm",
 		.of_match_table = dt_match,
 		.pm     = &msm_pm_ops,
+		.driver_manages_iommu = true,
 	},
 };
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
