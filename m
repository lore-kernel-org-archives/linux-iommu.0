Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF712C47409
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8592467B
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5aFBHpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8592467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 747DE87F8A;
	Thu, 19 Dec 2019 16:31:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pzx58TqF9ewS; Thu, 19 Dec 2019 16:31:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4B62287F9B;
	Thu, 19 Dec 2019 16:31:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44A4BC1D84;
	Thu, 19 Dec 2019 16:31:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C727C077D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 68E7B87008
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RpeXXqPcqSyi for <iommu@lists.linux-foundation.org>;
 Thu, 19 Dec 2019 16:31:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3BAC786FDB
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:31 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id p9so6080236wmc.2
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 08:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FYioDhZ/j/78qMyUi+NbeqzegCC3zzPggnOI7+kacPU=;
 b=E5aFBHpxzJkkIdtB9W66GN6ZLoFLgZNBR0wli2z1R1GfTj4GDjCqIV7HMTgweAZs/m
 ERMXbIUqhoOBDH6Y6yVu9fvJUbv1S/8bk4nVNiphi6Bj9Hr+xJPMF+CM0wdD4p/Nxi15
 DDZ2eWHA4Po8SV0rJ2mSAgR36BjhDGY65Cg+Nrvt9skytm0oy8yLdbTRRrrti8PY8sxG
 GqI3y8AJ1hhG5ISFHxJBz9r9FQVWnJK5gOR2aOQHSLuQPhBDyUQ6M6IhwH5s6ciR9Vts
 9/GMh/foacnJ6Etj2gcl6Fz+phGe372ALVmMIdUJmCb95IS4K+ulNixBQU6NY1edO0qz
 7V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FYioDhZ/j/78qMyUi+NbeqzegCC3zzPggnOI7+kacPU=;
 b=Y0dJ87NTSYAUfI8nLHXihIOhxkxHIWltO1IzuXjMLDNXHT+uPBe4UDWKqrIM2OU/bG
 oOhGoLF/LGI9nPEqR5jlRl8vVwZ9rtuoazGQbrmd4Dej7USocd5ClveRi2533fbDm44y
 L1PPPNHmzHaw18LqzFNXctZ3awp6NSvcrDAie6lY/+CLVOl5vv2ckUmAZT4sqXZQAFD8
 IWmflpbUBWQ5uniPWMuCCNG3eAfw3qC9D5PcetBFzHnMNHj+Ji03inYmpAKuW6er1Lt2
 OYtLsqMTRDbXAImay6GJw5rd1GQW2RQI3rMUqb1CbkJbj7wswPXL6xTT9NmoE0ELrSwY
 ZBoA==
X-Gm-Message-State: APjAAAVRoYoiXfuNqPc9mwqh/SvAO64kji8zgz2Lz7cdSkDLnBDtv/jm
 6uafQWfkuNPQa0O8HhWv2VbRcQ==
X-Google-Smtp-Source: APXvYqz3tbndDtmJIFC5nyvsIDtpq2oUpdByujhcgVkyGmtlGJFmTfIjiRRUks4oRR3Fv+Nm/TOV1w==
X-Received: by 2002:a1c:80d4:: with SMTP id
 b203mr10896801wmd.102.1576773089551; 
 Thu, 19 Dec 2019 08:31:29 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch.
 [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:31:29 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v4 08/13] iommu/arm-smmu-v3: Propagate ssid_bits
Date: Thu, 19 Dec 2019 17:30:28 +0100
Message-Id: <20191219163033.2608177-9-jean-philippe@linaro.org>
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

Now that we support substream IDs, initialize s1cdmax with the number of
SSID bits supported by a master and the SMMU.

Context descriptor tables are allocated once for the first master
attached to a domain. Therefore attaching multiple devices with
different SSID sizes is tricky, and we currently don't support it.

As a future improvement it would be nice to at least support attaching a
SSID-capable device to a domain that isn't using SSID, by reallocating
the SSID table. This would allow supporting a SSID-capable device that
is in the same IOMMU group as a bridge, for example. Varying SSID size
is less of a concern, since the PCIe specification "highly recommends"
that devices supporting PASID implement all 20 bits of it.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e1bec7e552b9..e147087198ef 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2279,6 +2279,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2290,6 +2291,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
+	cfg->s1cdmax = master->ssid_bits;
+
 	ret = arm_smmu_alloc_cd_tables(smmu_domain);
 	if (ret)
 		goto out_free_asid;
@@ -2306,6 +2309,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2322,7 +2326,8 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain,
+				    struct arm_smmu_master *master)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2330,6 +2335,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
+				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2384,7 +2390,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2537,7 +2543,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
+		ret = arm_smmu_domain_finalise(domain, master);
 		if (ret) {
 			smmu_domain->smmu = NULL;
 			goto out_unlock;
@@ -2549,6 +2555,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			dev_name(smmu->dev));
 		ret = -ENXIO;
 		goto out_unlock;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
+		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
+		dev_err(dev,
+			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
+			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	master->domain = smmu_domain;
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
