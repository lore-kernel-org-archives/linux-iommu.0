Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E65C433FC
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:01:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71987207D3
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVltUbDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71987207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4942D88223;
	Tue, 19 May 2020 18:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FUe4kMKhRVnU; Tue, 19 May 2020 18:01:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A594C888A5;
	Tue, 19 May 2020 18:01:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96C54C0891;
	Tue, 19 May 2020 18:01:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17820C088F
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0E31B888A2
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k4CsTwDPgIZs for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 18:01:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 167C488890
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:53 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id z72so213159wmc.2
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OlE3rnOB9MCKbV81bgfQSo1zIBpkt/AF9XwsE8EZHww=;
 b=PVltUbDtiUNJUYohQuAJijXOuB5A5bH0xkzVWvUq1H2+e2ibU19HCBKJgHG0LpvJOO
 Ig0UqvmrBwPjchj2eoYBA6yTE2yZMjt27StiBfvKzwPY0A4BZboeHT5Mq2aJCYWh6O3p
 Q4Dn6OKJZaLDx+E+zM3jpPFK6EoXV1JbeExIqt2da3BtZrBlufWbqYdyZBpifE02CiWo
 Dpcps1X5V7yvnFwAb6dgOCso+myoqErPY0GbTB3T56uonYvfNM2sdhN6ZZlzeHJdmz9V
 sW1KoZznYpI78h/lNulsayaggPntaZw0EAA8Mo+eWW+YEWyHD4MAwpzLho0o134xN2lw
 mKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OlE3rnOB9MCKbV81bgfQSo1zIBpkt/AF9XwsE8EZHww=;
 b=EP+wKDQLCerHKvDxugHShOucWbN7AbReHFSCQK9ElORwhMoF/qR2ZF52zamdBfRXRL
 1VN/uS30sYuKumL5htb+xAvr1ghLPUWagvIsqja9klYoYP3xYOQe9wXTS4/oZnPlgy/S
 sU9t6TV0RIyWiQA0NmcHM93dbsN/rNCfHYxx1HUTWtFVEE0CMQY3u/foUrXh2LBbOpn6
 vLBN3SCHaNvl8qlaJI+4iVk1/3X7O0HElnmuwMc9ykKLORToPbgRQDqwfwT7Y2apFqEg
 dmer0q1NVe1xw9aublWali6ffiKsxc63Ejb0W+eOCLTPJCsUJO053aos4SuHY2aCdoKb
 hJKg==
X-Gm-Message-State: AOAM531IUy82f8vQ4QAWCDVtSRXcR1+A+vMhU1MEI6lfrkJ2gdcWCCTi
 tcYiVkL5zeX7ey2g74Gf5dHn/7dPIAmRTg==
X-Google-Smtp-Source: ABdhPJxm6LwKarbOgqdR2lNw/X/XowWuMGizAMxxxXwhldyYMSyTlek4+lJ4QVEwMcaSb4ml0HljTw==
X-Received: by 2002:a1c:2e41:: with SMTP id u62mr615750wmu.91.1589911310989;
 Tue, 19 May 2020 11:01:50 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:01:50 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v7 08/24] iommu/arm-smmu-v3: Manage ASIDs with xarray
Date: Tue, 19 May 2020 19:54:46 +0200
Message-Id: <20200519175502.2504091-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 felix.kuehling@amd.com, will@kernel.org, christian.koenig@amd.com
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

In preparation for sharing some ASIDs with the CPU, use a global xarray to
store ASIDs and their context. ASID#0 is now reserved, and the ASID
space is global.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b5467e3e9250..847c7de0a93f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -667,7 +667,6 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_MAX_ASIDS		(1 << 16)
 	unsigned int			asid_bits;
-	DECLARE_BITMAP(asid_map, ARM_SMMU_MAX_ASIDS);
 
 #define ARM_SMMU_MAX_VMIDS		(1 << 16)
 	unsigned int			vmid_bits;
@@ -727,6 +726,8 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
+static DEFINE_XARRAY_ALLOC1(asid_xa);
+
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
@@ -1765,6 +1766,14 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 	cdcfg->cdtab = NULL;
 }
 
+static void arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
+{
+	if (!cd->asid)
+		return;
+
+	xa_erase(&asid_xa, cd->asid);
+}
+
 /* Stream table manipulation functions */
 static void
 arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
@@ -2450,10 +2459,9 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-		if (cfg->cdcfg.cdtab) {
+		if (cfg->cdcfg.cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
-			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
-		}
+		arm_smmu_free_asid(&cfg->cd);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
@@ -2468,14 +2476,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
-	int asid;
+	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
-	asid = arm_smmu_bitmap_alloc(smmu->asid_map, smmu->asid_bits);
-	if (asid < 0)
-		return asid;
+	ret = xa_alloc(&asid_xa, &asid, &cfg->cd,
+		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
+	if (ret)
+		return ret;
 
 	cfg->s1cdmax = master->ssid_bits;
 
@@ -2508,7 +2517,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 out_free_cd_tables:
 	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
-	arm_smmu_bitmap_free(smmu->asid_map, asid);
+	arm_smmu_free_asid(&cfg->cd);
 	return ret;
 }
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
