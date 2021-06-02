Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AEAC47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961F261C25
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961F261C25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 554CA608AE;
	Wed,  2 Jun 2021 16:49:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jleAtmUXGlZl; Wed,  2 Jun 2021 16:49:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F56260730;
	Wed,  2 Jun 2021 16:49:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D961C000E;
	Wed,  2 Jun 2021 16:49:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8471CC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A461402FC
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:49:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id abosHDFRjE7D for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 16:49:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7F7740275
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 16:49:28 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id k5so2001301pjj.1
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ttH2lB2Q3iQhWxz0MO6TSPDv0IHfj1scw5R0SMtBJU=;
 b=nvCYD3LtO/CuojD7wCnU+c6O+R2pp2pb1KXMOskVgNnkGQajATVAekeuE6ORBh0Ejc
 R+rirwTVetIxLdBoJvcWUyV/gTioLE6JphhTZET6wlb79RKHV9XvZeWHYR6je6dKHZhF
 V9BbncwWr9HZVyJY1PRwvutwmxgKkuv8CpK/MGzO/FlSs4oHWlD92lTft0nt3i7IDq7o
 rYIzeDd6rqGScVllo4n47EJUGx0wKYSvfhhA9Z3pyjsJXJZMYyVf1+exgCwiMrudG5CO
 0qy3xgJ8A/YEyVDXLulIRaX6UkQU9K3uybFEK4T83wm52schJGyQx/lKR2yp0XXccXP1
 PthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ttH2lB2Q3iQhWxz0MO6TSPDv0IHfj1scw5R0SMtBJU=;
 b=aol7YcG42sDA0iHZnSWPIamK/5dkeeoAU7kqtk0i6xa88S7lW3lBx2IaPElzPXzppN
 GIZFLlNpbUS4o0xmnxaHPcLBnJTHnaL6Ud0LjYwdqMyYE/w8dEYJg4L4bnVRLe+tozVH
 oET70jt2/ezSiYPWZpsX7OsBYTpvTDX76vPxLu0OccBJQB0sYiwHUDgj+yu2cYsU+fvP
 v+uYSslBz+vGWztGoQTASbpYIfTsgcX+SswjGu51/UVgogDMv35dFigtBzMy/CP0JWpL
 RtcgHT/N2k/MNgRyssoBfZaULbI4uNBtmpIwhVtGXkCMEmTc9fl+D1hsyhz4dZ/EgyCb
 55Ew==
X-Gm-Message-State: AOAM5314h9vFjih2VF83QM9TfCrAYbH5DMMgaxMWKINvA4wG62MiOTr5
 2o8Pl+u/wJG/igc4FL0odVw=
X-Google-Smtp-Source: ABdhPJyNuM1C0B/N7VSYw14UuHjXqYthGnVv3VSYDW7n4ueLVcZgKCAnAlLqEclUOMb0/oghQizYeA==
X-Received: by 2002:a17:90a:de0c:: with SMTP id
 m12mr32297535pjv.54.1622652568268; 
 Wed, 02 Jun 2021 09:49:28 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 z5sm155302pfa.172.2021.06.02.09.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 09:49:27 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [RESEND PATCH v4 1/6] iommu/arm-smmu: Add support for driver IOMMU
 fault handlers
Date: Wed,  2 Jun 2021 09:52:44 -0700
Message-Id: <20210602165313.553291-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602165313.553291-1-robdclark@gmail.com>
References: <20210602165313.553291-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, freedreno@lists.freedesktop.org,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

From: Jordan Crouse <jcrouse@codeaurora.org>

Call report_iommu_fault() to allow upper-level drivers to register their
own fault handlers.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..b4b32d31fc06 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -408,6 +408,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	int idx = smmu_domain->cfg.cbndx;
+	int ret;
 
 	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
 	if (!(fsr & ARM_SMMU_FSR_FAULT))
@@ -417,8 +418,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
 	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
 
-	dev_err_ratelimited(smmu->dev,
-	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
+	ret = report_iommu_fault(domain, NULL, iova,
+		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+
+	if (ret == -ENOSYS)
+		dev_err_ratelimited(smmu->dev,
+		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
 			    fsr, iova, fsynr, cbfrsynra, idx);
 
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
