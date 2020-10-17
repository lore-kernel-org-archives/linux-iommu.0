Return-Path: <SRS0=0/ZC=DY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD30C433E7
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 04:38:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5007D207C4
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 04:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tk/YA6qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5007D207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 25DA4884DC;
	Sat, 17 Oct 2020 04:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bny3NubUfzNq; Sat, 17 Oct 2020 04:38:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B75CC884DE;
	Sat, 17 Oct 2020 04:38:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A56C2C07FF;
	Sat, 17 Oct 2020 04:38:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 140EDC0051
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1070788EC3
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l3o3Zs66yF6c for <iommu@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 04:38:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B1C4888EC2
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:38:30 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id h62so707491oth.9
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 21:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R/eL9BOLO7lfTYwfmIUA3Aou+j6yOxaxr5STlBPy4E8=;
 b=Tk/YA6qo/6rOkDz5xz5TMpyb/nimdkJlU2E/WNrecuaem8ut0FqfNLxQpze6aI/o81
 U4mvWAxfiHjKzj4PppSiggeSvuFmijySekSmYFElvLaMVfQHjGuxy4wvRDr7G6kqQZG1
 r6d9JpAOfpJJSbcjoj2nLJyCuxlpDa4oOLAWXjjVXmTy9ZP3TSdR3RfgFIAI3n+YDToD
 NVyno5FjnfuvMuyD7kiaTVriaksYl2c4mePBekhgwlPoHfNIo/PeDDoqIgoN70E6Acsd
 r7imQQ/QlbUNQaw8OBvCQ2JnZgI/W5vVdDOBWRWxUTe7HwcY+tzKupk0Gxo04G22vTJd
 Fd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R/eL9BOLO7lfTYwfmIUA3Aou+j6yOxaxr5STlBPy4E8=;
 b=pokgRsdp3+9zgx4uR0sbnvbp5o5y3CBBosJltJdhsyx/fa352GLHsBOsd+nuWKEHr2
 IFlhGX3vlUMUMI7BXSNhIhcgCrDrFvSkOXNblDQ1zSnWSNra7N6BT9Sk57H00Gl2+OZD
 g0+zcc4QHWD/Y1y9riNpjmgrpIDU+vPjE7K0ZrsnPKaDaSwQg0Fs0UkzmsMLrsLQsBWa
 wejH9E8NH9rKS5bR99g73MwhkdhahECFhKToUzeLVxiSwRyldEUnHok3ShkK7RFlLS4Y
 K0lvzk10s6qGqPmSrldvK0G6JAVA9z95dh4H7GpSqINhrYRc90zXuVkAgImBUuZsOkz7
 t4Vg==
X-Gm-Message-State: AOAM530en2DGgmUzeOh1Pf+CFYkLupDA/+/zTwjFaHy5nF2vMUghRCce
 spv3IBWsV/lp75+dyJHmFeXc+g==
X-Google-Smtp-Source: ABdhPJwYTHQyiuBoo03LmtYktPRELqpF0a1iE0YTfXNgfPbXq/MBB3sgEV7hoaQd0dVnrJaUTkda5Q==
X-Received: by 2002:a9d:7c87:: with SMTP id q7mr4988506otn.140.1602909509962; 
 Fri, 16 Oct 2020 21:38:29 -0700 (PDT)
Received: from localhost.localdomain
 (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id t65sm1640038oib.50.2020.10.16.21.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 21:38:29 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 Thierry Reding <treding@nvidia.com>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v4 3/3] iommu/arm-smmu-qcom: Implement S2CR quirk
Date: Fri, 16 Oct 2020 21:39:07 -0700
Message-Id: <20201017043907.2656013-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
References: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

The firmware found in some Qualcomm platforms intercepts writes to S2CR
in order to replace bypass type streams with fault; and ignore S2CR
updates of type fault.

Detect this behavior and implement a custom write_s2cr function in order
to trick the firmware into supporting bypass streams by the means of
configuring the stream for translation using a reserved and disabled
context bank.

Also circumvent the problem of configuring faulting streams by
configuring the stream as bypass.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Move the reservation of the "identity context bank" to the Qualcomm specific
  implementation.
- Implement the S2CR quirk with the newly introduced write_s2cr callback.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 0089048342dd..c0f42d6a6e01 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -10,8 +10,14 @@
 
 struct qcom_smmu {
 	struct arm_smmu_device smmu;
+	bool bypass_cbndx;
 };
 
+static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
+{
+	return container_of(smmu, struct qcom_smmu, smmu);
+}
+
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,mdp4" },
@@ -25,9 +31,32 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 
 static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
+	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	u32 reg;
 	u32 smr;
 	int i;
 
+	/*
+	 * With some firmware versions writes to S2CR of type FAULT are
+	 * ignored, and writing BYPASS will end up written as FAULT in the
+	 * register. Perform a write to S2CR to detect if this is the case and
+	 * if so reserve a context bank to emulate bypass streams.
+	 */
+	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
+	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
+	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT);
+	arm_smmu_gr0_write(smmu, last_s2cr, reg);
+	reg = arm_smmu_gr0_read(smmu, last_s2cr);
+	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
+		qsmmu->bypass_cbndx = smmu->num_context_banks - 1;
+
+		set_bit(qsmmu->bypass_cbndx, smmu->context_map);
+
+		reg = FIELD_PREP(ARM_SMMU_CBAR_TYPE, CBAR_TYPE_S1_TRANS_S2_BYPASS);
+		arm_smmu_gr1_write(smmu, ARM_SMMU_GR1_CBAR(qsmmu->bypass_cbndx), reg);
+	}
+
 	for (i = 0; i < smmu->num_mapping_groups; i++) {
 		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
 
@@ -46,6 +75,44 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static void qcom_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
+{
+	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	u32 cbndx = s2cr->cbndx;
+	u32 type = s2cr->type;
+	u32 reg;
+
+	if (qsmmu->bypass_cbndx) {
+		if (type == S2CR_TYPE_BYPASS) {
+			/*
+			 * Firmware with quirky S2CR handling will substitute
+			 * BYPASS writes with FAULT, so point the stream to the
+			 * reserved context bank and ask for translation on the
+			 * stream
+			 */
+			type = S2CR_TYPE_TRANS;
+			cbndx = qsmmu->bypass_cbndx;
+		} else if (type == S2CR_TYPE_FAULT) {
+			/*
+			 * Firmware with quirky S2CR handling will ignore FAULT
+			 * writes, so trick it to write FAULT by asking for a
+			 * BYPASS.
+			 */
+			type = S2CR_TYPE_BYPASS;
+			cbndx = 0xff;
+		}
+	}
+
+	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, type) |
+	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, cbndx) |
+	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
+
+	if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs && smmu->smrs[idx].valid)
+		reg |= ARM_SMMU_S2CR_EXIDVALID;
+	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
+}
+
 static int qcom_smmu_def_domain_type(struct device *dev)
 {
 	const struct of_device_id *match =
@@ -87,6 +154,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
 	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
+	.write_s2cr = qcom_smmu_write_s2cr,
 };
 
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
