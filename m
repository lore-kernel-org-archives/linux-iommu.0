Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC768C433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E42613C0
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E42613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 254384044F;
	Tue, 20 Apr 2021 17:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yvgPzBjuUCDY; Tue, 20 Apr 2021 17:25:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1DC3B4044E;
	Tue, 20 Apr 2021 17:25:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B2DAC000E;
	Tue, 20 Apr 2021 17:25:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67EC3C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5659460ABC
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t5S16nXCKH24 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:25:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1D4460AC4
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:44 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id r12so59483484ejr.5
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vYLUVZhwumDd6iKqlvn3vWsQCDgb86syRKsPwDitvKM=;
 b=MrQzk8xsX/zig2TNikMkG/b+PJY2QfTGcsvUoQ5y26uS9va8coblKQPbgaS8kOGMHb
 xmCsGMllAzPwJhSr70PtB1ZDjsqrZHRksVsgu6KSLSe584UVW/eZrmiEaYcnLx76raP5
 RDfGVyxn9MTVo+6eVUNerw/TguDRLoWjXElDLdADXjmHAtZ2w+iY5r/4N+nJzJhu6Jq4
 3u1/f73oz8G8r5wYgv5mKhVTtZuqUiDL/o4L705D+D3asKLlCMPQtytPBjrsTOohKfsT
 x4UP8kJ6I1UjfZ+byHhGY1N/7y12q09oWHro0zoq6KPk5fb1xBZuqju7aZL2BZrO7KmF
 co2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vYLUVZhwumDd6iKqlvn3vWsQCDgb86syRKsPwDitvKM=;
 b=qiyJKPekJtNjlYlkeQ8nXeCjZwQw36waa87+GLN/5TyMaJbwcQD6pylkL70aFKXLWk
 +eUNtDZnEAAdHRjuBf6IZMLU87H9J7zHjmYPg1HubegDNU8b3sO51g2Ysn0X8SYp8lMo
 AjisQ+cuCjWnnhttDYgtuhTyMhXjJP/lmX0FWX8Bpf6fppbjj86XVPab6QhMcqjwfIAz
 owxD0ZNCtSfzjBaMctABWvnoG1gGa8w+Py2ONcYVnNQxkMF89dLt4v7gYI7bY5fxr1Ay
 LjFqSmk0XKPtMewxFASks6AJl0O2SI9S1FnmxUlu885UQz6L0jjPBvUziplSIiv2h68O
 5GIA==
X-Gm-Message-State: AOAM532Ss6wONWS2cna4qL93hkz8JNZgq1uY0AMRoZ0DcJmC8Zq9Jeya
 1600HibROPbdKGRPfjQuFCc=
X-Google-Smtp-Source: ABdhPJzTOoaDZ6q+yYNmSPXPlq9tSYmOoDWfckBljTEm8mgC71rzmaANjq8LT4+KoVyI4ceEso+rbA==
X-Received: by 2002:a17:907:e8a:: with SMTP id
 ho10mr28819689ejc.110.1618939542924; 
 Tue, 20 Apr 2021 10:25:42 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id n11sm16791090edo.15.2021.04.20.10.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 10:25:41 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 03/10] iommu/arm-smmu: Implement ->probe_finalize()
Date: Tue, 20 Apr 2021 19:26:12 +0200
Message-Id: <20210420172619.3782831-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420172619.3782831-1-thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
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

From: Thierry Reding <treding@nvidia.com>

Implement a ->probe_finalize() callback that can be used by vendor
implementations to perform extra programming necessary after devices
have been attached to the SMMU.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
-remove unnecessarily paranoid check
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..d20ce4d57df2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1450,6 +1450,18 @@ static void arm_smmu_release_device(struct device *dev)
 	iommu_fwspec_free(dev);
 }
 
+static void arm_smmu_probe_finalize(struct device *dev)
+{
+	struct arm_smmu_master_cfg *cfg;
+	struct arm_smmu_device *smmu;
+
+	cfg = dev_iommu_priv_get(dev);
+	smmu = cfg->smmu;
+
+	if (smmu->impl->probe_finalize)
+		smmu->impl->probe_finalize(smmu, dev);
+}
+
 static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
 	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
@@ -1569,6 +1581,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
+	.probe_finalize		= arm_smmu_probe_finalize,
 	.device_group		= arm_smmu_device_group,
 	.enable_nesting		= arm_smmu_enable_nesting,
 	.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index c31a59d35c64..147c95e7c59c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -439,6 +439,7 @@ struct arm_smmu_impl {
 				  struct device *dev, int start);
 	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
 	void (*write_sctlr)(struct arm_smmu_device *smmu, int idx, u32 reg);
+	void (*probe_finalize)(struct arm_smmu_device *smmu, struct device *dev);
 };
 
 #define INVALID_SMENDX			-1
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
