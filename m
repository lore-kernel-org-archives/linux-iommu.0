Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2753D9058
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306572; cv=none; b=VRiZNi7d7FnwdkH7vyWHCWqdQnDf0XaBA6M+PWFoWJHCsx5Fzgw7TfX7LosC158BqlKK0iK45ZY4UF1TNUMO1TqcsaZS3+WtA/f3UKO3gGpBkP7o1mkw7a/bTYUayz8CeFoHJ9YeKab+cL7uHOtuRlv2M2s3JtO9EY7w88klMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306572; c=relaxed/simple;
	bh=eWQLDpa3TqCo4a5U/agcUYC2p0tFCZgkGn1lkr3Ubro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szXBDeVp/9NZpJDhOJaPE7XZBs3uMua4e0XGv1bmLNKsPN5Bwa+80EUUtjiHhd9IoRf6xwYzJ3q/mMYLnWj6yxEDb9B0R/hbj4llLss+Z77XpvyOIiOomT59FY+W6IOH8mmw7CFCbuXm3aZmaD4pW9m76UhvZurVhJWW10kTF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qb6CJz25; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ifv2yDs5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qb6CJz25";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ifv2yDs5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679I95BA3076917
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	niNCsZBrzIAQrp1eBI5we31XmUPx78SVfLUuwrIpCKI=; b=Qb6CJz25S4FQJlTx
	833BUXomBMUMS14QDTk19YWp88mdoDpnzTB0TVxNpYXS9GClRQi03eM5u6o8rKNz
	Yg5pxNwz9n9bQbHSBFCa3jmIiSOJGDVOZTvMd1yop7i4W8dk5uaoI7J0k+SgFGXS
	RqPEHqSVKWQFl4b/y/sNqgdJOWF5Dk/Bgid4X5C+x18VIEYkUOnjmVqWr9KFOFjV
	+q1QO4cmeMmaGbmcVE1IliunDMNVdCaI+Sng0rm3EQBA2+U4FzJoJGQIJaRCuGhv
	9oeB3mZUB/KbMl3LeRC610xu6i40GjZANd6GFkT42XulsueMaCiQiEjNt0buOyVn
	J0FjEg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwr9kbps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:16:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0e702df8so18347741cf.2
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306568; x=1786911368; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=niNCsZBrzIAQrp1eBI5we31XmUPx78SVfLUuwrIpCKI=;
        b=ifv2yDs54e1Fm3T9IzKeNL7kisZ4RDCAwAPV5Wjh2InIRNEE+98NhR0AMIotuLwvFf
         gf9BciIqD+61jJ0v7+3x8UkLPyT/w806HnBMIfM1uEmLzHzRRMkNEAG60n/6N0PE62Wv
         QIQbeFR2OioY1DCTgcG9Ov1hBc2ZOq0cBIAQ+v5ViM00JlebP4qChgW8ohZ92H0pG3pV
         sHd+dpE1LALOcAtxSJ01vtthzT/k60ycNTIeW8GtH+Jf22Dz1HPsVtaW3dUcL4LPMBX8
         TU2w/vFuBY0De46aVAiiOK8krYnYD27UnxiR2wV4Fi9gw3dtSSdKa4eI5JT43Bm+UOMz
         caww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306568; x=1786911368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niNCsZBrzIAQrp1eBI5we31XmUPx78SVfLUuwrIpCKI=;
        b=hy4JDElRRjhiBgA0xTRy83dIxG941zekOAHIs83zBWVcDSRhaEB33LLwPZWvBSjrHk
         q394TUckXLuIp7Cmx6n1w+pFDiT52aubQk7FrIE6MWMo8kVhr8vBX58PmumQX9xgDX2E
         EiP3ECnwbmsU7TFS+2xXDozkycYY5gb21azxeAh38oZguGtXmlM09ihCG9+9KhSGPA1m
         81F4HSPbmeewpKBeDscbywq4vlmLCZwMHZuWd0yCn5O6qMp0sGItnh5pn6UrzvHxxFVp
         tFIZFeTzwI7fpFE8T5z+3vLChqeKl1JRtUy9SSmKgguqFcvv9M/uB0z+73Jtx27Gmwpy
         XLug==
X-Forwarded-Encrypted: i=1; AHgh+RoLt/8n691Y9DJ/T2GD0y1JrpECytgQZWc0xLvNJpYtyWwOfy50oGjD6RQ3/A/C3uKIK5CYJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxa4iTSyI3zbyfxQAcat1xq2TAikVow5lPybeUCedJ0J29GUCl5
	1zIbTN5a+A98TBTXWgvDtHJ7EA3e2nJ1MPKgZ3JHxEOy1iZ4KEGQKPqfUDYCQa8OR4CPE13z5YN
	gPtJDrF7PGhdwEQ+onVB3WSU1Onz4d7ScYO3d0EyK+Vc/uiRmy4w45uHR2w==
X-Gm-Gg: AR+sD13P6dnnvR5/1rjWtG0RHhbbqm5+s2MNTBmKXAs3ucWFbd/OTxuIsHlWfBmdmj6
	UtZl5PP+DoTCwNQhWxlh08U6LcdjVILYNDqqqX1RG6cy7XqmogHNCIdtdhPduDu+8NZUz9uaInJ
	0VIoeNQ9K3VH2NM9NG78ypc6+nyMgaWQjpbqx/lNUS1eKnzhZLPUThvTWdDpA5O4waYJ/8ACW/J
	HyFFqT83ACMDYGkB1ttRM+t5WFdVgw+rOqR40Bta3bDYcQC2eJHFuLi+qgpbQTLct+ZqPyfiqQy
	NhLfNWXCbzPSF4d/FWxNVxHglVRtR8/oUBf6x7F+V1kw89iVJ9ZQMRIJ3xUPrYa3J534UgQ22Ct
	IjKZmyMlPS+YKoUbDfjfzCvFta+ZwtibVPdlT3gdRN8wJS+YFFTFBZMoIEBM9jPRPP7r1qu0iQ7
	zBBgESagqe8kMulQ==
X-Received: by 2002:a05:622a:345:b0:51c:73f:e3a7 with SMTP id d75a77b69052e-52ce6108188mr399320161cf.26.1786306568253;
        Sun, 09 Aug 2026 13:16:08 -0700 (PDT)
X-Received: by 2002:a05:622a:345:b0:51c:73f:e3a7 with SMTP id d75a77b69052e-52ce6108188mr399319631cf.26.1786306567794;
        Sun, 09 Aug 2026 13:16:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:16:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:47 +0300
Subject: [PATCH 08/12] iommu: qcom_iommu: halt the micro-MMU while
 programming context banks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-8-87f5cd492560@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4172;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=eWQLDpa3TqCo4a5U/agcUYC2p0tFCZgkGn1lkr3Ubro=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/vrrz5nTKhkhA8RhmCiIASpJNOV07B733ja
 VVfkmPfjWiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7wAKCRCLPIo+Aiko
 1SL5B/91QjVcyjSegd6cf/tLGXyVqJRDRnmGHZ6f//+zYHAc6FdXNDi6ba74FeoxKTtQx+MHzsD
 T33SDClz594ZGavBDNexQ9+LiBrW5qnZCC7hexo59OCPrHqt68x/pBn2s6TT3/X/11zFoeGOkSC
 nQVwW+Ad7yiUkjK/aKaiIeoQiLVeUpCzmgZOX4ofXLznfGr5XuNosJhW7OoHBVAjunRpM5R5KfT
 UN2WBxZhi2bptuWFiLuZjpJCZ2EXtDYI96iMlW0rITgaS42ZC/x8Ol8g1qiMkqeolNzZwPgkxFZ
 TpwaL9hyXttkkGoAUzmaT/tT60KE8ZGtGKXZmICIpVXdsCWm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=d73FDxjE c=1 sm=1 tr=0 ts=6a78e009 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=3K1L26fHcIV91VHLagoA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: UtgJ08BIE6SMQfVhhY18oGzoD_VHZGr4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX8rg7NWmOI3tU
 Gu8oO5ENLgoiZhu2y8TESxna8FMRiYPLo3VbjojX6soufVDdvnA2CE3iZstr/qzXHd96v4PkU1l
 oU8eKctPJ/CzM90ytBC1kBcOK40nIKmzIuXNqQjzodD3aDzT66pnv5BR8AwvLRE6p/pCF3r1r17
 /d8qbi4gpL1EzoinqgsK72s1SkEflbwfu8+ELfpEz3C4wGh9s2nrVVwdM1b4DqFxeLNAqTSYvbL
 LgR94Gj0YUIJIFP031KVjcCjohkNy8tYdHBA8FJ3D/RtjWvzuMdiFbkt5nZiL0mSyFpu04xLuWX
 vNJblJjoOlujPHn8Cb/kFJBMRchSVAzBcrAL0vw08ZToGBgrL3h5vqOzLfe9dXtxJUM54b9wyCC
 YOqBNBR73NLKIpPGrJL/9TAByX86t7KzNyj3IoMGujl+JjixamfzZ2FhEpBsjbDozdlVNWdMmQv
 F9MFXEnZtu+xefCwJhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX2yYA16Ym1EXv
 zHeL2+8BCqo27j99fGSMtrefGaimYYjZRl2wT32XX4QoKpgNCWzxTSlkaDTUPyl0/inSHZSr4qV
 4ywW+GGHavl/BwIDMzI7IkUt7FDMYRo=
X-Proofpoint-GUID: UtgJ08BIE6SMQfVhhY18oGzoD_VHZGr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090183

The context bank registers are reprogrammed underneath a live translation
front-end. This happens at attach time, and again on every runtime resume
for instances that have to replay their context bank state after power
collapse. Rewriting SCTLR, TTBR0, TCR and the MAIRs while the micro-MMU
keeps accepting client transactions races the in-flight traffic against
the new configuration.

The hardware provides a handshake for exactly this: setting HALT_REQ in
MICRO_MMU_CTRL, at the start of the implementation-defined register
space, stops new transactions from being accepted and reports IDLE once
the outstanding ones have retired. Downstream drives it through a
qcom,iommu-enable-halt property.

Add the handshake, under a per-instance flag as the handshake is not
wanted on every instance, and bound the wait rather than spinning
forever, so that an unresponsive front-end degrades to a diagnostic
instead of a hang.

The halt is confined to context bank programming. Applying it around the
global reset as well resets the SoC before the console comes up,
reproducibly, on an APQ8074 DragonBoard.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 8e9488c47d5c..f27f8722ee64 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -37,6 +37,14 @@
 /* GR1 sits one 4K page above GR0 on the msm8974 QSMMU */
 #define QCOM_IOMMU_GR1			0x1000
 
+/* The implementation-defined space sits two 4K pages above GR0 */
+#define QCOM_IOMMU_IMPL_DEF		0x2000
+
+/* Micro-MMU control, at the start of the implementation-defined space */
+#define QCOM_IOMMU_MICRO_MMU_CTRL	(QCOM_IOMMU_IMPL_DEF + 0x000)
+#define MICRO_MMU_CTRL_HALT_REQ		BIT(2)
+#define MICRO_MMU_CTRL_IDLE		BIT(3)
+
 /* Redirect all cacheable requests to the L2 slave port */
 #define QCOM_IOMMU_ACTLR_BPRC		(BIT(28) | BIT(29) | BIT(30))
 
@@ -66,6 +74,8 @@ struct qcom_iommu_cfg {
 	bool				 no_afe;
 	/* context banks lose their state over GDSC power collapse */
 	bool				 ctx_restore;
+	/* the micro-MMU must be halted while its registers are programmed */
+	bool				 halt;
 	const struct qcom_iommu_sid	*sids;	/* one SMR slot per entry */
 	unsigned int			 num_sids;
 };
@@ -339,9 +349,41 @@ static int qcom_iommu_reset_ns(struct qcom_iommu_dev *qcom_iommu)
 	return 0;
 }
 
+/*
+ * Halting the micro-MMU quiesces the translation front-end: it stops new
+ * client transactions being accepted and waits for the outstanding ones to
+ * retire, so that the context bank registers can be reprogrammed without
+ * in-flight traffic racing the change.
+ */
+static void qcom_iommu_halt(struct qcom_iommu_dev *qcom_iommu)
+{
+	void __iomem *reg = qcom_iommu->global_base + QCOM_IOMMU_MICRO_MMU_CTRL;
+	u32 val;
+
+	if (!qcom_iommu->cfg || !qcom_iommu->cfg->halt)
+		return;
+
+	writel_relaxed(readl_relaxed(reg) | MICRO_MMU_CTRL_HALT_REQ, reg);
+
+	if (readl_poll_timeout(reg, val, val & MICRO_MMU_CTRL_IDLE, 0, 100000))
+		dev_err(qcom_iommu->dev, "timeout waiting for micro-MMU halt\n");
+}
+
+static void qcom_iommu_unhalt(struct qcom_iommu_dev *qcom_iommu)
+{
+	void __iomem *reg = qcom_iommu->global_base + QCOM_IOMMU_MICRO_MMU_CTRL;
+
+	if (!qcom_iommu->cfg || !qcom_iommu->cfg->halt)
+		return;
+
+	writel_relaxed(readl_relaxed(reg) & ~MICRO_MMU_CTRL_HALT_REQ, reg);
+}
+
 static void qcom_iommu_program_ctx(struct qcom_iommu_dev *qcom_iommu,
 				   struct qcom_iommu_ctx *ctx)
 {
+	qcom_iommu_halt(qcom_iommu);
+
 	/* Disable context bank before programming */
 	iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
 
@@ -369,6 +411,8 @@ static void qcom_iommu_program_ctx(struct qcom_iommu_dev *qcom_iommu,
 
 	/* SCTLR */
 	iommu_writel(ctx, ARM_SMMU_CB_SCTLR, ctx->sctlr);
+
+	qcom_iommu_unhalt(qcom_iommu);
 }
 
 static int qcom_iommu_init_domain(struct iommu_domain *domain,

-- 
2.47.3

