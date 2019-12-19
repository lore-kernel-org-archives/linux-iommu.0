Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECB3C2D0D5
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7982524679
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6Y6F/bZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7982524679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 411F086FF1;
	Thu, 19 Dec 2019 16:31:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WJvIwmNZeQ6t; Thu, 19 Dec 2019 16:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9FB0386FF6;
	Thu, 19 Dec 2019 16:31:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DBEEC1AE8;
	Thu, 19 Dec 2019 16:31:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACFBAC077D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9C4D286FF1
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uk1oZ017lzTP for <iommu@lists.linux-foundation.org>;
 Thu, 19 Dec 2019 16:31:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B8BBE86FE7
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id c14so6611756wrn.7
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dMO+Cx5tpHWBU9PvT9K3Ldxua2I75lUQvV4E3iN+Pd4=;
 b=L6Y6F/bZ0X6GnA6kcBZgaXAVjxtjAyEeEzKHLOb7dyE7Xra2EWhN3E2FV1pD/3jeqF
 Yl8MP7t7E6fc/B1SRXICTfrmmBAqXUHJRLw5pJcf29pPUWZ1hZGmH2wiA4Q4PGQA5yp0
 drBOPo+Htx1MMDuIrvO0MavmC3p3Oar5PL9ngjx84tC3hJqd1xQdZ22JINufiVYFahyt
 GQ4Ctzcx0fW8SfJ45uPErgBMYQESIqhJ9DHjaOzF4X5fsvpQM9FzqurIZlWcCEO3++B3
 Y7uc8Bvn0GLBhxmFJ814rKwcuODaQ3avmBF9ttywapAxu57HzjwpSg6Vq2j/vEVr+wcg
 pXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dMO+Cx5tpHWBU9PvT9K3Ldxua2I75lUQvV4E3iN+Pd4=;
 b=jhYbiZSkBwbrjDazjSg9p8DxN0DhwwgWnLbVyFtw5n/coRd6ndJau6G1pEY/gew+KE
 oF9geoGHj3HSvDcNoVx/RZGzz4+IDxVstuiDBBCr8B0jriM5ljHq+NnlzjANt7I+9813
 lEJzNMd7TkKVeSyS8N6JJrnOTpxj3W/uIcia9e8jygg/rhUKoTnTK11g0Tvv66JgWBuq
 GcpLTitQAV92oV8DNA4F3jCAC3EvxXoO04DWU51pHlmH6aptJnon7/Ac0nzHfEiJOgEO
 IIeR4wjfy7tXDxhDksUqEuw/f4ljIWp4OBw5sTx7UvJNdXl2/Rw+rEji56xox9+rALUi
 B1oQ==
X-Gm-Message-State: APjAAAWQR16iQOcxcAsBe3+3u/60AsTE+oqdAyQVKgZryBdCasu7z0i+
 rG/UYCSOgkKyTGJepl6pj5eDsw==
X-Google-Smtp-Source: APXvYqyln7ft1HEYcBhtMdztDRUtjwcelgdooZlJCblVVFeLkALxpO+iJ6Q80B/Q1/dimC5vv0QgKA==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr10031904wrn.245.1576773086823; 
 Thu, 19 Dec 2019 08:31:26 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch.
 [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:31:26 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v4 06/13] iommu/arm-smmu-v3: Add context descriptor tables
 allocators
Date: Thu, 19 Dec 2019 17:30:26 +0100
Message-Id: <20191219163033.2608177-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
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

Support for SSID will require allocating context descriptor tables. Move
the context descriptor allocation to separate functions.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 57 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b287e303b1d7..43d6a7ded6e4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -568,6 +568,7 @@ struct arm_smmu_cd_table {
 struct arm_smmu_s1_cfg {
 	struct arm_smmu_cd_table	table;
 	struct arm_smmu_ctx_desc	cd;
+	u8				s1cdmax;
 };
 
 struct arm_smmu_s2_cfg {
@@ -1455,6 +1456,31 @@ static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 }
 
 /* Context descriptor manipulation functions */
+static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd_table *table,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	table->ptr = dmam_alloc_coherent(smmu->dev, size, &table->ptr_dma,
+					 GFP_KERNEL);
+	if (!table->ptr) {
+		dev_warn(smmu->dev,
+			 "failed to allocate context descriptor table\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd_table *table,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 {
 	u64 val = 0;
@@ -1502,6 +1528,23 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	cdptr[3] = cpu_to_le64(cfg->cd.mair);
 }
 
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+
+	return arm_smmu_alloc_cd_leaf_table(smmu, &cfg->table,
+					    1 << cfg->s1cdmax);
+}
+
+static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+
+	arm_smmu_free_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
+}
+
 /* Stream table manipulation functions */
 static void
 arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
@@ -2145,11 +2188,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
 		if (cfg->table.ptr) {
-			dmam_free_coherent(smmu_domain->smmu->dev,
-					   CTXDESC_CD_DWORDS << 3,
-					   cfg->table.ptr,
-					   cfg->table.ptr_dma);
-
+			arm_smmu_free_cd_tables(smmu_domain);
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
 	} else {
@@ -2173,13 +2212,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	cfg->table.ptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					     &cfg->table.ptr_dma, GFP_KERNEL);
-	if (!cfg->table.ptr) {
-		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
-		ret = -ENOMEM;
+	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	if (ret)
 		goto out_free_asid;
-	}
 
 	cfg->cd.asid	= (u16)asid;
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
