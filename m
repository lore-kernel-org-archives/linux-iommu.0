Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18CEC43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD80208C3
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anRgbzZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD80208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3C9CD21FA9;
	Mon,  9 Dec 2019 18:12:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ebJggPqhCwYH; Mon,  9 Dec 2019 18:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1E6FA22001;
	Mon,  9 Dec 2019 18:12:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BF94C1D7F;
	Mon,  9 Dec 2019 18:12:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A94E4C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9689787E91
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9uPv90gQ3eGu for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 18:12:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4467587C20
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:07 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id p17so317938wma.1
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 10:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xn8FsjkMGRUL2lMLPw8XGFWLAlx3AFwuaWxjs2kDLIc=;
 b=anRgbzZW5eiaVyKyK67CNe9yhPSWdxYWkazhUi0/MhlRnM/XyU4K5WfuI0wsdNBpId
 wVSrIhkwmOAUYrNx04LRBaHZXcyx9x6tcSlwG84LPQoIO5DwXUyczD9QuwK//eJS2DmP
 QawcU+YvRsMlbqkwJJPupgry3SWX2VYufGNDpYwcZ9ac29gEPrCyP2aSx1h2ubrQABw/
 +hxiVhyR0+AF3DJOej7effKQl1/zMbYhcmwVVsaRJVgyLOMBDGqpC31WZrQn4k6CZ9yd
 hzYnX8yIIZmAzi2hVYp70apw0Oh4aCDQihbLCZwfllVVfaK0m+gWTtN8EPC6YEYwMBwB
 b7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xn8FsjkMGRUL2lMLPw8XGFWLAlx3AFwuaWxjs2kDLIc=;
 b=h/yk05HEADEe+KB6RtMBijX2mZ1q+63wPTvpYFex5pliVbwDe4HzNjxQ2M0YFfmKj/
 VMnPBvw+mDifXhz2imiPmK3+UOgzOwjvBw32ktR6ls4ewzIhmDaiR8F/nNw4n9kKck8i
 SFiYd1lFUioL8w27aCYK5X3bUwQgsXJHI1m2qWjUwekvFyGat/1qSvy0e6Njx180FuHW
 srCnD6Qzxw1yzYg17gLBrwJ93ZqQkB6HjAAwF4cLEpoTAz7C9dYFJl3s68zL4gOcNfxv
 zsl+sjwwX2Qjfy8dFT+t1ESltxST1LzERnozowZKj7q8AIzA3xhn2IDcZXii8GVDmO90
 5H8w==
X-Gm-Message-State: APjAAAWSIpYzfJddNR0Ev3ZTA7R8f1e2ugaD+yymSNPRneVoh+8wjzH3
 6PCZR5fsfQvFzBWZsAvI6bYagg==
X-Google-Smtp-Source: APXvYqzD7Zae5R710LjfpSHNK7h76GaBcjbIRxZjwSrVgHzJcpI2I4M1YKhu9AfT3gIv6BnKhaBP5Q==
X-Received: by 2002:a7b:cd8a:: with SMTP id y10mr349190wmj.136.1575915125816; 
 Mon, 09 Dec 2019 10:12:05 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch.
 [62.167.101.88])
 by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 10:12:05 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v3 09/13] iommu/arm-smmu-v3: Handle failure of
 arm_smmu_write_ctx_desc()
Date: Mon,  9 Dec 2019 19:05:10 +0100
Message-Id: <20191209180514.272727-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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

Second-level context descriptor tables will be allocated lazily in
arm_smmu_write_ctx_desc(). Help with handling allocation failure by
moving the CD write into arm_smmu_domain_finalise_s1().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f260abadde6d..fc5119f34187 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2301,8 +2301,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
+
+	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
+	if (ret)
+		goto out_free_tables;
+
 	return 0;
 
+out_free_tables:
+	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
 	arm_smmu_bitmap_free(smmu->asid_map, asid);
 	return ret;
@@ -2569,10 +2576,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
-		arm_smmu_write_ctx_desc(smmu_domain, 0,
-					&smmu_domain->s1_cfg.cd);
-
 	arm_smmu_install_ste_for_dev(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
