Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF27CC00A89
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 09:24:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA672076E
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 09:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="plspxQpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA672076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 99072868C1;
	Fri, 30 Oct 2020 09:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6FSGV68TLbf4; Fri, 30 Oct 2020 09:24:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C5DF2853B9;
	Fri, 30 Oct 2020 09:24:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C02A9C0859;
	Fri, 30 Oct 2020 09:24:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F14E2C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DE8542052B
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:24:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uqPIL3S2BxIr for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 09:24:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by silver.osuosl.org (Postfix) with ESMTPS id EAC4720514
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:24:12 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1604049852; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zksrnauniIarhMtPAMwMG1kAmCvI//iDUpdWPzhiwJc=;
 b=plspxQpkrzcwIoI/SGNrSR2vjQ9XTr9q0Dx/MYxgdhQbhzLMNEgC4oCaBxzgCkMHKISZxEKX
 +nio8y1Sjfg07G2mjD3olVMbCpSbhTy7gihKiME++CfZpYtaGnVE/iq1zNUBOs3sUF1/BS1F
 XUDWTppICukHVxfk1eQX/tNxh/k=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f9bdbbc5dd9f0926470679c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Oct 2020 09:24:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 9FE18C433C6; Fri, 30 Oct 2020 09:24:11 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DF2FAC4339C;
 Fri, 30 Oct 2020 09:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF2FAC4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jcrouse@codeaurora.org>,
 Rob Clark <robdclark@gmail.com>
Subject: [PATCHv7 5/7] drm/msm/a6xx: Add support for using system cache on
 MMU500 based targets
Date: Fri, 30 Oct 2020 14:53:12 +0530
Message-Id: <21ae5ca4d9a566c72fb212f1b25b2e987a1a9ad7.1604048969.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1604048969.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1604048969.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

This is an extension to the series [1] to enable the System Cache (LLC) for
Adreno a6xx targets.

GPU targets with an MMU-500 attached have a slightly different process for
enabling system cache. Use the compatible string on the IOMMU phandle
to see if an MMU-500 is attached and modify the programming sequence
accordingly.

[1] https://patchwork.freedesktop.org/series/83037/

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 46 +++++++++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 95c98c642876..3f8b92da8cba 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1042,6 +1042,8 @@ static void a6xx_llc_deactivate(struct a6xx_gpu *a6xx_gpu)
 
 static void a6xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
 {
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	u32 cntl1_regval = 0;
 
 	if (IS_ERR(a6xx_gpu->llc_mmio))
@@ -1055,11 +1057,17 @@ static void a6xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
 			       (gpu_scid << 15) | (gpu_scid << 20);
 	}
 
+	/*
+	 * For targets with a MMU500, activate the slice but don't program the
+	 * register.  The XBL will take care of that.
+	 */
 	if (!llcc_slice_activate(a6xx_gpu->htw_llc_slice)) {
-		u32 gpuhtw_scid = llcc_get_slice_id(a6xx_gpu->htw_llc_slice);
+		if (!a6xx_gpu->have_mmu500) {
+			u32 gpuhtw_scid = llcc_get_slice_id(a6xx_gpu->htw_llc_slice);
 
-		gpuhtw_scid &= 0x1f;
-		cntl1_regval |= FIELD_PREP(GENMASK(29, 25), gpuhtw_scid);
+			gpuhtw_scid &= 0x1f;
+			cntl1_regval |= FIELD_PREP(GENMASK(29, 25), gpuhtw_scid);
+		}
 	}
 
 	if (cntl1_regval) {
@@ -1067,13 +1075,20 @@ static void a6xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
 		 * Program the slice IDs for the various GPU blocks and GPU MMU
 		 * pagetables
 		 */
-		a6xx_llc_write(a6xx_gpu, REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_1, cntl1_regval);
-
-		/*
-		 * Program cacheability overrides to not allocate cache lines on
-		 * a write miss
-		 */
-		a6xx_llc_rmw(a6xx_gpu, REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_0, 0xF, 0x03);
+		if (a6xx_gpu->have_mmu500)
+			gpu_rmw(gpu, REG_A6XX_GBIF_SCACHE_CNTL1, GENMASK(24, 0),
+				cntl1_regval);
+		else {
+			a6xx_llc_write(a6xx_gpu,
+				REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_1, cntl1_regval);
+
+			/*
+			 * Program cacheability overrides to not allocate cache
+			 * lines on a write miss
+			 */
+			a6xx_llc_rmw(a6xx_gpu,
+				REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_0, 0xF, 0x03);
+		}
 	}
 }
 
@@ -1086,10 +1101,21 @@ static void a6xx_llc_slices_destroy(struct a6xx_gpu *a6xx_gpu)
 static void a6xx_llc_slices_init(struct platform_device *pdev,
 		struct a6xx_gpu *a6xx_gpu)
 {
+	struct device_node *phandle;
+
 	a6xx_gpu->llc_mmio = msm_ioremap(pdev, "cx_mem", "gpu_cx");
 	if (IS_ERR(a6xx_gpu->llc_mmio))
 		return;
 
+	/*
+	 * There is a different programming path for targets with an mmu500
+	 * attached, so detect if that is the case
+	 */
+	phandle = of_parse_phandle(pdev->dev.of_node, "iommus", 0);
+	a6xx_gpu->have_mmu500 = (phandle &&
+		of_device_is_compatible(phandle, "arm,mmu-500"));
+	of_node_put(phandle);
+
 	a6xx_gpu->llc_slice = llcc_slice_getd(LLCC_GPU);
 	a6xx_gpu->htw_llc_slice = llcc_slice_getd(LLCC_GPUHTW);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 9e6079af679c..e793d329e77b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -32,6 +32,7 @@ struct a6xx_gpu {
 	void __iomem *llc_mmio;
 	void *llc_slice;
 	void *htw_llc_slice;
+	bool have_mmu500;
 };
 
 #define to_a6xx_gpu(x) container_of(x, struct a6xx_gpu, base)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
