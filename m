Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12719C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 14:17:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D016820674
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 14:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGQGUk/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D016820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9371D8833D;
	Mon, 18 May 2020 14:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xWpX+89fztpq; Mon, 18 May 2020 14:17:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DE273881A8;
	Mon, 18 May 2020 14:17:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3099C0881;
	Mon, 18 May 2020 14:17:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDDADC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 14:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DAF5520198
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 14:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fx1VbcElb6Ey for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 14:17:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 7E361204A6
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 14:17:09 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id n15so1760918pfd.0
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=W3AJP+K6AJWkLLQOo9n4PqYM8LSyyANs3tFVvvOywL0=;
 b=RGQGUk/tfqqGuNXaGCxWTAJNAvEYjiPagQiljTFsC+DRC//qRlcq2CWGWMvHiXJihY
 9uxXBWzoPBe6/fy7ptegsd0TVwq2SL2047RWsMNmixmgsDCE6Nu8PWqddaBuxacnLzq1
 BApJwnG7ysiu3yG4rkBPROgngJtLEhJCGnY1PTcdYMcD/2uNrL59mmwmMcB6pqD/28kv
 7ou+8yie54wvh8+oBAVgWAI1RsEILuVQDtIwbY89Eo8MM2R2DLKTr+pI/rKTFDwf+thB
 hUXJZ5MAhsYufcndvkOLf0IBzdTpuhN3Q7SnhKQ3wZoug1lziVjcDnVeA/fHAbAtCCuV
 7ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=W3AJP+K6AJWkLLQOo9n4PqYM8LSyyANs3tFVvvOywL0=;
 b=ofBQyJuuJqZcgv/8y2rX9NKzWLMkeC0MRE7VF9299uIGjAh+tgG4zl3cxrzONI3MTn
 vATAfm43ZHMF/59bI5DjhLuSJTwjnZXrFy43ZkUE0q7TFG+3UgqxGC2NvQX2LmEafnGk
 o01HyFh6X29Dkc4sCD/rXYI0jVKDjMUdHPjg0KZQVe/8mXRQAnZPCdcoK6JG22Q7cNgN
 pbVdpsLwMPQ/m9RcKZYBJOCKg3XI/3sXBoBuE9qaDlpkXmpZQLQBVeFX78aKlyj4/F44
 GXFtBtyrx5htt6YsgCQuCgH7W6oUOTt85K8WXfX1NKekn0oQIdc0Z6ibRSaGo7ngGa7F
 RNhg==
X-Gm-Message-State: AOAM532r3vD1P3liJTF+KeQMTOGQ0y+YZkuODWrmsF7OeHFWCPwYtBiz
 zzEEKztCvQsHRHF827KnPMLU0w==
X-Google-Smtp-Source: ABdhPJyB3kYEFH6mVDkfhufF/BWyyWJtV7hYZRoT5slsf4JckFiNnVBK34o/hvILNZSnTXLimy+Xkw==
X-Received: by 2002:a65:4c41:: with SMTP id l1mr15489284pgr.43.1589811428911; 
 Mon, 18 May 2020 07:17:08 -0700 (PDT)
Received: from localhost.localdomain ([80.251.214.228])
 by smtp.gmail.com with ESMTPSA id d184sm8730925pfc.130.2020.05.18.07.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 07:17:08 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2] iommu/qcom: add optional 'tbu' clock for TLB invalidate
Date: Mon, 18 May 2020 22:16:56 +0800
Message-Id: <20200518141656.26284-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konradybcio@gmail.com>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On some SoCs like MSM8939 with A405 adreno, there is a gfx_tbu clock
needs to be on while doing TLB invalidate. Otherwise, TLBSYNC status
will not be correctly reflected, causing the system to go into a bad
state.  Add it as an optional clock, so that platforms that have this
clock can pass it over DT.

While adding the third clock, let's switch to bulk clk API to simplify
the enable/disable calls.  clk_bulk_get() cannot used because the
existing two clocks are required while the new one is optional.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes for v2:
 - Use devm_clk_get_optional() to simplify code and improve readability.
 - Rename the new clock from 'tlb' to 'tbu'.
 - qcom_iommu: use bulk clk API to simplfy enable/disable.

 drivers/iommu/qcom_iommu.c | 62 ++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 0e2a96467767..116d8188f87f 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -37,14 +37,20 @@
 
 #define SMMU_INTR_SEL_NS     0x2000
 
+enum qcom_iommu_clk {
+	CLK_IFACE,
+	CLK_BUS,
+	CLK_TBU,
+	CLK_NUM,
+};
+
 struct qcom_iommu_ctx;
 
 struct qcom_iommu_dev {
 	/* IOMMU core code handle */
 	struct iommu_device	 iommu;
 	struct device		*dev;
-	struct clk		*iface_clk;
-	struct clk		*bus_clk;
+	struct clk_bulk_data clks[CLK_NUM];
 	void __iomem		*local_base;
 	u32			 sec_id;
 	u8			 num_ctxs;
@@ -626,32 +632,6 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 };
 
-static int qcom_iommu_enable_clocks(struct qcom_iommu_dev *qcom_iommu)
-{
-	int ret;
-
-	ret = clk_prepare_enable(qcom_iommu->iface_clk);
-	if (ret) {
-		dev_err(qcom_iommu->dev, "Couldn't enable iface_clk\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(qcom_iommu->bus_clk);
-	if (ret) {
-		dev_err(qcom_iommu->dev, "Couldn't enable bus_clk\n");
-		clk_disable_unprepare(qcom_iommu->iface_clk);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
-{
-	clk_disable_unprepare(qcom_iommu->bus_clk);
-	clk_disable_unprepare(qcom_iommu->iface_clk);
-}
-
 static int qcom_iommu_sec_ptbl_init(struct device *dev)
 {
 	size_t psize = 0;
@@ -808,6 +788,7 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	struct qcom_iommu_dev *qcom_iommu;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	struct clk *clk;
 	int ret, max_asid = 0;
 
 	/* find the max asid (which is 1:1 to ctx bank idx), so we know how
@@ -827,17 +808,26 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	if (res)
 		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
 
-	qcom_iommu->iface_clk = devm_clk_get(dev, "iface");
-	if (IS_ERR(qcom_iommu->iface_clk)) {
+	clk = devm_clk_get(dev, "iface");
+	if (IS_ERR(clk)) {
 		dev_err(dev, "failed to get iface clock\n");
-		return PTR_ERR(qcom_iommu->iface_clk);
+		return PTR_ERR(clk);
 	}
+	qcom_iommu->clks[CLK_IFACE].clk = clk;
 
-	qcom_iommu->bus_clk = devm_clk_get(dev, "bus");
-	if (IS_ERR(qcom_iommu->bus_clk)) {
+	clk = devm_clk_get(dev, "bus");
+	if (IS_ERR(clk)) {
 		dev_err(dev, "failed to get bus clock\n");
-		return PTR_ERR(qcom_iommu->bus_clk);
+		return PTR_ERR(clk);
+	}
+	qcom_iommu->clks[CLK_BUS].clk = clk;
+
+	clk = devm_clk_get_optional(dev, "tbu");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to get tbu clock\n");
+		return PTR_ERR(clk);
 	}
+	qcom_iommu->clks[CLK_TBU].clk = clk;
 
 	if (of_property_read_u32(dev->of_node, "qcom,iommu-secure-id",
 				 &qcom_iommu->sec_id)) {
@@ -909,14 +899,14 @@ static int __maybe_unused qcom_iommu_resume(struct device *dev)
 {
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
 
-	return qcom_iommu_enable_clocks(qcom_iommu);
+	return clk_bulk_prepare_enable(CLK_NUM, qcom_iommu->clks);
 }
 
 static int __maybe_unused qcom_iommu_suspend(struct device *dev)
 {
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
 
-	qcom_iommu_disable_clocks(qcom_iommu);
+	clk_bulk_disable_unprepare(CLK_NUM, qcom_iommu->clks);
 
 	return 0;
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
