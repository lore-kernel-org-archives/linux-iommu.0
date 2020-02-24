Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2711DC38BF8
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC8520880
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxiRGOVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC8520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4BD72050F;
	Mon, 24 Feb 2020 18:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q9-q0HMy8VxZ; Mon, 24 Feb 2020 18:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 367CA20501;
	Mon, 24 Feb 2020 18:24:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23CCAC18DA;
	Mon, 24 Feb 2020 18:24:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4931C1D88
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9BF1985CE2
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YETAPMC0qa-V for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:24:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C747A85582
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:48 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id c84so336706wme.4
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1/v4/yX+Rb+z7FmgKRxusFg6LNtZiO3DMXvnBgeOuHA=;
 b=zxiRGOVQbUYycQsFrjTLJX2IpngMLUiFnM9zOzjXR47e2SetqBWdJnpHlovEcuPFBv
 FexG3YDDT1ALrD/D+FKHkP2MIXaGBqx7A0sQaHVDRDNDQVr6jS2GdDb8Dv4EB4Ft15Rc
 X+Oex0fYMVCjcbrMtfUHVdIYJ1+hcTCMOOiPeqQ4R0z6xH0F4B7muTW0XjymSxneLuIP
 UjsAEBRJN0lKsKcUb0AF5d72SsOmuIZT45CPqq1FHWour+tr4KPFS8ATERhupHhS/6vO
 NnLNTmMYIpRJABwOkWxXIjD1Zqj0p9uyUCjjFEDFuUat5g+KAY0cf2+EDDRSjS2adgZy
 cP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1/v4/yX+Rb+z7FmgKRxusFg6LNtZiO3DMXvnBgeOuHA=;
 b=TfZt6Dw+Da/Vnmel3xM8Aw6goxGMCdQR68caPB1DAxGTO0ayX2iz/cJme5WLkbpEtx
 PuCdqw798YijZbJRlzCc35z0rU5UjR7l9mWVyefJc9FR9SBGEvTMZHkD2wPJXmZy719V
 gz++13uo/rwf6g2chce9vcB4jzu1A4rqmLJxKo8jT54Faa+oUvIYCrkB8hGEE/eEoiXM
 AGbwQqDPpk0wP587Er1xADv7Fk5sQO0Rjp2gkrocyW6qgYvGJdIzOf4QpgHnQaAFdZst
 IuvKcQ9BrOQqt1/Vh9fF0qrqGDCHu1YXRGQUAbPuhLyR332z6TkI5pAq06yl9Bsh4Dm8
 TqHw==
X-Gm-Message-State: APjAAAX2Tr8752no8LkIDbk+n+eO0SJbbh0t0WwPhZkkL+dENx2eumJP
 oU9F4lVkrx+VutQZF+b8OGAn5Cqz+h0=
X-Google-Smtp-Source: APXvYqxqoFKehhPoecAVUtglmpmoNhk6pIi6LUZIxLg0IgobfRPy8bO8YntSNF9Wq6iiPuinGYBuMA==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr309717wmm.79.1582568687070; 
 Mon, 24 Feb 2020 10:24:47 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:46 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 16/26] iommu/arm-smmu-v3: Add dev_to_master() helper
Date: Mon, 24 Feb 2020 19:23:51 +0100
Message-Id: <20200224182401.353359-17-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, kevin.tian@intel.com, catalin.marinas@arm.com,
 robin.murphy@arm.com, robh+dt@kernel.org, zhangfei.gao@linaro.org,
 will@kernel.org, christian.koenig@amd.com
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

We'll need to frequently find the SMMU master associated to a device
when implementing SVA. Move it to a separate function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 77a846440ba6..54bd6913d648 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -747,6 +747,15 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static struct arm_smmu_master *dev_to_master(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec)
+		return NULL;
+	return fwspec->iommu_priv;
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -2940,15 +2949,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
 	unsigned long flags;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
+	struct arm_smmu_master *master = dev_to_master(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_master *master;
 
-	if (!fwspec)
+	if (!master)
 		return -ENOENT;
 
-	master = fwspec->iommu_priv;
 	smmu = master->smmu;
 
 	arm_smmu_detach_dev(master);
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
