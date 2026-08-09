Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AF3D79EF
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306557; cv=none; b=CZM6F5+5SrpO2KZxEii/Dnepxsa0tZVD1S0Ao6HH9WcyPabj/lf+eyatGoalZy/CWh9PGftqqBNIfqeRy23Ztar46vbY8S7a96B0vP1eeEFBtso92vYuQaN1hjQWuSLDj300HW+akmp2wb9xe5TKT+f4eHT0eM6LF617VxbiZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306557; c=relaxed/simple;
	bh=csEY5kAK1o0MObErtcP/fI47l7/+8j45w1x7Lk7YzUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtB6nATZRaF0frNoGPDR/jLJlrqll01HuAv31dtvKGEjwzGZ6d8wNzZpptNzTuEfUAvZ3lvBFgIu6xGZVGyi0MOIsgpMrZV+xFQcOxaxEbi4iEbeNldeGWmxLDcx3oF9w2iPq6Nsm4kctfZS5ELYiUjLpSi+gQ8huAlmSZGoOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PaUMagiH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gEc/qaFv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PaUMagiH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gEc/qaFv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679I9cbK3117705
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8yX2uvlIC/AyCu7NKmE2TS3xQ1wV6P6EK8NgrBlFOpE=; b=PaUMagiHy/M083UU
	OPCrXT8i+jMRrju1tVMeF3pJ6smSm4MHRNEpiCxUoYbk2SjYnCUGfCb4wny53Hu/
	HrCTZbKwoUYLOFdCGZWtWwrJGCzNuqG/qX3BA9sz6zSomCKV7/nJ8c6xSYWGdyuW
	Ama4SLlQN13tpbWk31/TSbxWoaMdcLcLINRPJgvA/w5eN9qnXkGwDaj8NDpAfy1F
	8YOHAVtr3YNiEmo8vg9w64ZTkNL2q+yOgXXxm0v5T9CEw3f0Kjs1pBj49/LZeF4I
	5G2OWgMA/wreXDayPlrIL+arwnma/AU3bbR7NLq4nPMpeaMBFF/rpwD/Rm1r3d3a
	dQ8Emg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fww7cud6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:15:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0199faafso15045671cf.3
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306554; x=1786911354; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8yX2uvlIC/AyCu7NKmE2TS3xQ1wV6P6EK8NgrBlFOpE=;
        b=gEc/qaFvWy6qZsnO1wtRo6OQipMxido/Hzd7/06lETKzqRXZ8vICasLpjHoJFZDCWk
         iuhKM17a2e9OMJ4/8rNxvGEfGIe70Rno5FrD4vRN4V+aHNkq05JXRk+LalkiZO8vwCsB
         fL1i3/5mmyZ2me0FZc8RRakG88a35BdXj9JXuxP7Tj9nfJ8r2I8k/l8lYEyNjt/68X0y
         CLg9Q02BNmwOB3MZUNf1LFgnVEd5znWYasA+IpZfPe8OjrLi7Zrfc13IeQXYo12w1EFJ
         QiRuwcubhtRvqShBPVqiEil8fCPCibNm02ideiL8r0YYZaRIlRnAphjSoEv7lZMcF04A
         6b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306554; x=1786911354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8yX2uvlIC/AyCu7NKmE2TS3xQ1wV6P6EK8NgrBlFOpE=;
        b=GhVSZsvM2v9lw9q1RwYpr9PJJSURMEXrn9vrMyZ7cZts1+1GJYjwvku8hjjgMcTINw
         Hj0SF2w6WMb6U1VEDXSVU7UeUZv9f1OFYEqtGrhI9v/t4BLkQ8iVNQdAeCRuePrVQoT9
         e3lmozNA57oBRMbdrwojRhdRzhhhZ8j6tN7h9ZF1mnCaa92VJ3BMkZ8OxdNdPf1fXMp3
         293iue9DhIlVXAAlyjf32dIVbWyeO2Vv1wyqVqQMgNyDzeBY6m7MGylO7M0LlNkTHUJw
         I9au7JxK1nzCvEzz0xAFnAEjvjyWdqQNpTetinCWxGnl9ydab/trEnMHix5hICMOfPoh
         Kn4g==
X-Forwarded-Encrypted: i=1; AHgh+RriX4F0CJ4C2U0xIMmBmdtiEuOJRgtkNwW3JTKV2sEtGcrGgrnEiMqhNrsdFdIUGM3jV8A33Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoFgo2z0zyxR41hqZWEDCeDjy1mrJVebOM8nUeonnDlMKMIj8h
	HAf0vtvm5MGeP1PX676NWQi0Oj68w09aFVZtO7gk+qNPL2N+KcG3c1QV9v1J4myMgxV1duCNqzl
	+B+IdHRXvTpLC49X2Mh2fxuqsIgOw30+DHM/lMPxng9jbKJ2sMZj4FCCEoQ==
X-Gm-Gg: AR+sD1218NASzlgsgamaPydIkuW4QBBQVYSZsnHGtFNroM0wIkaMQ7dnIlAgP2x+Wov
	j5prMssTwBTCFNmY4pNiVrSeI1wyu/wh5ylri3szleCFsJKMwWLEVb2dA1a+tJT8ARRNF4Z1PfP
	m2ip7MEBgNVw6Xlqdnqz6kEawMcLBrXfccD0WMjxb8MyaaYLXhQjI+GDuLu0rzrxu9QRmwKHfW5
	/13IvYBGL6Esuic6IieQAZm0blwIw+JTiSPAJdfV48qwHkCFvRIaJ7qTZnribxDAGZTGPpNyJuX
	FY1PLBwqPqjXQOinjeIU/UsYpqpQg7hd2C4Bjvxsd2fKgKh1XI70Odd1MTU0ZN/w2IDipXHfszQ
	0J82Mlmumv3j6hJrGf1RMhgwBDYH6BFyTjumsa9M+aoFmHsizBqLAIj6SwpNyo4ygXufqkvmLlX
	U1DpYvT+wtb5SO/w==
X-Received: by 2002:a05:622a:1820:b0:51c:ae7:fa1d with SMTP id d75a77b69052e-52ce5f606b3mr397018641cf.5.1786306553687;
        Sun, 09 Aug 2026 13:15:53 -0700 (PDT)
X-Received: by 2002:a05:622a:1820:b0:51c:ae7:fa1d with SMTP id d75a77b69052e-52ce5f606b3mr397018341cf.5.1786306553324;
        Sun, 09 Aug 2026 13:15:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:15:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:42 +0300
Subject: [PATCH 03/12] iommu: qcom_iommu: extract context bank programming
 into a helper
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-3-87f5cd492560@oss.qualcomm.com>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4252;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=csEY5kAK1o0MObErtcP/fI47l7/+8j45w1x7Lk7YzUQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/uriw60rs+lsE378Y69ErulMz7J4LxQ7Xse
 VKKqpoQgimJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7gAKCRCLPIo+Aiko
 1V4nB/4xLHYwqddsAkj0i7R1FY8Pzik/aBfxcQ7lN5soSofsB1wkagZDML9XPhBgzl4rWtXPqtX
 5tShzbnY0XMI6WJVPz8ZF0+9kaFtmqaRQSZci2m4+Kd+K4mhDWhfks6Bs9oQBEoCkxRPdYYzyTh
 /1aiPPFUYyRkR2qYqmyqENTIAGo9EPjxEPHkDEV/HOEdtGiu8wGwNmsduECngv1h+aaFJkyUEpu
 n8Ml/pyU5SN1GRTxM4VGUhq8umq50AmnPxW0tNWnkBZuMti3nTnvM5/9kiLK5haiP1AsQpH9IH2
 fI5mzihG3hVaNNrA7pZ3+g33/+CRc9ki8oatn/Mpkviu9ZR8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 104xsmg21Hbc-RhgtDY7zWqp6tp85dJs
X-Proofpoint-ORIG-GUID: 104xsmg21Hbc-RhgtDY7zWqp6tp85dJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX50rLjJ1eZg6u
 3oDmNVwlV/ytqG1b7KOAPGfl9rVRIcVLGdMFURxBQ5+yuSqkZXMDLOqsuHkmLv70e9/xfHIm4ck
 k+BX83uOBoPkKP2DUZHTkBHnrd2Wc1L9EEs5AvamP35fiTRke9aIwifAaAVOQB0W+vJsrBLvUit
 zmZaMPkIyUsbWYtj9+ZUxxB3Fml9YDAdlH7lyWGJyk9rBKM4ePzy3Jvi5WhrLxoX5OoVs5rA5Xe
 hqeQ9XDRsUpQuFns8SUknKM1hcEMw//yVx68p7mt8zw4CMp/njH2S/JCsdX7MsyWap0bbddxk23
 Rvmb9/TIEOPQvKThh+7cDM2cpwfu2wz3+qlpQ+w91ZGqQmwwtIVN/JS0vA96pdsp1DTeutTP+oX
 TDxjaL8SNIeCYRCUoYJ5XS8E//hAWv3MBUrSFL4z5dyWso82aRqAOBZaT2nHiTAHGBXRMp2qQKj
 9Cp/ngcvE1Y17UxFhTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX5KxFJt0RwdTL
 F4klEx+B8kSrGJa60xLqvbcftSItq9if9ZhcLnBZler6ijMD+WYbDqGyk2weKRzxEO8t5+S3p2l
 6gVSvaBoddie6O8l2ThS99eYsQuatwA=
X-Authority-Analysis: v=2.4 cv=IPsyzAvG c=1 sm=1 tr=0 ts=6a78dffa cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=GTiPovFEgKA3HYAQ8hUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090183

qcom_iommu_init_domain() programs the context bank registers inline,
with values computed on the spot, so no record of the programmed state
is kept. The MSM8974 QSMMU instances about to be supported sit in MMSS
GDSCs and lose the context bank state whenever the power domain
collapses, which requires the driver to reprogram the banks at runtime
resume.

Stash the computed register values in struct qcom_iommu_ctx and move
the programming sequence into a new qcom_iommu_program_ctx() helper
that can later be replayed from the resume path. No functional change.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 66 ++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 21d18ce67b98..5bbb51d9bd65 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -61,6 +61,11 @@ struct qcom_iommu_ctx {
 	bool			 secured_ctx;
 	u8			 asid;      /* asid and ctx bank # are 1:1 */
 	struct iommu_domain	*domain;
+	/* programmed context bank state */
+	u64			 ttbr0;
+	u32			 tcr[2];
+	u32			 mair[2];
+	u32			 sctlr;
 };
 
 struct qcom_iommu_domain {
@@ -213,6 +218,32 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static void qcom_iommu_program_ctx(struct qcom_iommu_dev *qcom_iommu,
+				   struct qcom_iommu_ctx *ctx)
+{
+	/* Disable context bank before programming */
+	iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
+
+	/* Clear context bank fault address fault status registers */
+	iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_FSR, ARM_SMMU_CB_FSR_FAULT);
+
+	/* TTBRs */
+	iommu_writeq(ctx, ARM_SMMU_CB_TTBR0, ctx->ttbr0);
+	iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
+
+	/* TCR */
+	iommu_writel(ctx, ARM_SMMU_CB_TCR2, ctx->tcr[1]);
+	iommu_writel(ctx, ARM_SMMU_CB_TCR, ctx->tcr[0]);
+
+	/* MAIRs (stage-1 only) */
+	iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0, ctx->mair[0]);
+	iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR1, ctx->mair[1]);
+
+	/* SCTLR */
+	iommu_writel(ctx, ARM_SMMU_CB_SCTLR, ctx->sctlr);
+}
+
 static int qcom_iommu_init_domain(struct iommu_domain *domain,
 				  struct qcom_iommu_dev *qcom_iommu,
 				  struct device *dev)
@@ -267,32 +298,13 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			continue;
 		}
 
-		/* Disable context bank before programming */
-		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
+		ctx->ttbr0 = pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
+			     FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid);
+		ctx->tcr[0] = arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE;
+		ctx->tcr[1] = arm_smmu_lpae_tcr2(&pgtbl_cfg);
+		ctx->mair[0] = pgtbl_cfg.arm_lpae_s1_cfg.mair;
+		ctx->mair[1] = pgtbl_cfg.arm_lpae_s1_cfg.mair >> 32;
 
-		/* Clear context bank fault address fault status registers */
-		iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
-		iommu_writel(ctx, ARM_SMMU_CB_FSR, ARM_SMMU_CB_FSR_FAULT);
-
-		/* TTBRs */
-		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
-				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
-				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
-		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
-
-		/* TCR */
-		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
-				arm_smmu_lpae_tcr2(&pgtbl_cfg));
-		iommu_writel(ctx, ARM_SMMU_CB_TCR,
-			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
-
-		/* MAIRs (stage-1 only) */
-		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0,
-				pgtbl_cfg.arm_lpae_s1_cfg.mair);
-		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR1,
-				pgtbl_cfg.arm_lpae_s1_cfg.mair >> 32);
-
-		/* SCTLR */
 		reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE |
 		      ARM_SMMU_SCTLR_AFE | ARM_SMMU_SCTLR_TRE |
 		      ARM_SMMU_SCTLR_M | ARM_SMMU_SCTLR_S1_ASIDPNE |
@@ -301,7 +313,9 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 			reg |= ARM_SMMU_SCTLR_E;
 
-		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, reg);
+		ctx->sctlr = reg;
+
+		qcom_iommu_program_ctx(qcom_iommu, ctx);
 
 		ctx->domain = domain;
 	}

-- 
2.47.3

