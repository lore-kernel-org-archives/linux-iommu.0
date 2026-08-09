Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC93D7D80
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306560; cv=none; b=TlcZYTtUwFVqG/05msLkswfjr7tkM7JGcGlmf6hFBFAme488/wluWTL+Cut3hUBIAnw5HUFhoG3ByWvgoj1tmHc6psDQyG5zeA6yokj6+3b2OXcrBVMi/y7m6cBw7gfKjr6m+WMHb52+DQqGX33Gm01deIJJLmcJkvP7vAVxwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306560; c=relaxed/simple;
	bh=MyFwP51+yZ/c9HWtYLGPLcbLLtgX59e5z1/cjBJidcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SO2RSgJJsw8Hd7MuHFhUs71HaKxTt8jaad907Njk0mrwPSr0HLO90iP4gGnDQQCCZIpbjHJNBs1KW99tiOWifFOjxWixGUrTX5jwrWZpFq/mXzMnGmNUACOVaHomBLEo/g9pIjMC/H17KjIJQe0ysmLPblUb68qzW+eWwE59xCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hugp1TU/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gyP0dT+F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hugp1TU/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gyP0dT+F"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679I9ATU3476236
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8lsx+cwstTAjNdnrioPo3X9hiGJFMki8t0ZkS427TRk=; b=hugp1TU//+Y7E4E+
	+J0TC8uiNW79BzjVj/3E7KOXq2tWwyVHMmKhldTcq3ioaPQW0Mijz82KNAftbuWf
	kfrXLtTMtcxkD1vObp1NBJAzt7RwLppTeYiZ4XNINhj7DcrRUAVDnmJ65Saa+D8L
	LUbkTwkf+o7GM3sJeg5UqMRiFEAi8pcDuOpxW3WhEAW21js9nRAZhQpJSXEt4NTr
	3SOjF7qu32emElhcNClMJ5aTqtQ45DQQjkpx79qJ3vt4D/BNITdtqoQcEEBO/mDi
	CsxKOTF5D3Q+6hD6E44hiJYHo3FoRVqOQiPa7WcI+f3a9gXdMA2PiicJtJeZXngM
	2Pjnzw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvp1kdpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:15:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5283df62d68so14731151cf.0
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306557; x=1786911357; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lsx+cwstTAjNdnrioPo3X9hiGJFMki8t0ZkS427TRk=;
        b=gyP0dT+FZtAhmnC140I2Guy6bOUwML2I6FJTotzAw8XT2odcrEkDpJWoDjEDazF88A
         ElvKyx41lgYC0AaFxge9GgRsSY/DX+jXQSIkxGap3/BR35thNQN0VPo1l3mnvCjQaSwE
         P3iuOmQ2uUwQ1DPBNzNxSbko6wu4SNhIwIJcQgZIWhGd1V9uQr6Xs9dDnavncCPm2V/I
         wormjwqHiOTGQGMmx1WaLWGq2QldV4hu2eEhQ91w3afRFaXJFaNkqE4nyHsh423jA52X
         zk9h/8pIrirdHqoIYOc6wIMVk+5j54hAifHmSTFWzBdpjZMLpZXbh4K+W01HyWzXidKa
         xfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306557; x=1786911357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lsx+cwstTAjNdnrioPo3X9hiGJFMki8t0ZkS427TRk=;
        b=HhaN+uRmSbWzCH591tXe06TgMKuTIYzpXVOY8cJUr4sGRKGgESelOfmUSJy0CirCit
         Pim4j1YVibCdmEUH1UG8ecEyOTbgKXAFyxEc1F8s/XKwT8DdJ4cUnx6+F/ZfZYlKlrUm
         8MBjYV9HzSnxNLHUpQ1FgsdAfDMoGEfTKl7id1Sgn+5UKvG5EkCJkKL9cBW3WJa0/XGp
         FOKFQuil6QIgTSwr7Dpr1FgLJArPV031ZnlyckofBTee6o4ZNgkWgb+WKo1buJN0ikz9
         bASrwWfglwHAFlQo1Roikl9Vjnfm4fcb1jKY+unolPLkaFmBDponPE8ko+/HwKBS+B8X
         DAKg==
X-Forwarded-Encrypted: i=1; AHgh+RpTNcj+j2oBRtk5aa62C3MSym9dchVIDc0X2qLWW4LmH7Q52u1vlyhwb4zTJrMUxg5IwLqxmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxscC7Xf8JrjVyDxSKwY9qJXI+GrTO7/rnUgF/U4QJlE6Tqfuvt
	CUUVgEA8/uFYfi2EOQmoiFZxIjick9swny7/PG7OWOELaB1QM6Gw6SnRjSPPK87INJdS8qSclKg
	KM0NkDfDZargBBG7cpxZI52yVrI74uhdjEBn/rkRPkMwXXivNd+LNHE//oQ0jK67c5w==
X-Gm-Gg: AR+sD12saVE1l/NW/oVHnck5BM4Mw/iGpWJWbGdTCx5Qi1BSANIk82HpqEyssse79iX
	vgiEPNzoNGicYJkduCxCOqyluU5tBzb78v6PylozhfdzHY3JZACyR1DC1iI3Z95Wn9i3e49m2f7
	946D4blHJ9obn1DpqV4A1kv2MfTIJvw+hBA3MqHr/lT8rOht33gL6C2vEjQ+XIx/BJCc52B0REt
	+wo5/tjFm++kO14uLIHcClr/phoE0UpSg7NCrsGEpUdVAp5EGbHMP5rLN0qOs4rbtQkCoCjML1S
	W69L47VYamFsz1s2tWoHHTYH8Q/egc+bJ4lsJhenxNyb+1SobbW34kuPnYp5GTs5rbB1AaXO9Bc
	frxyuverafFmC4pv4xVDTmtrHjOEFF0ZZA7V+wv8RV7AXN9g6cBCAl+32gxXcaQbDN+tcMVP1i+
	gv1s08Qz9WZKLvHQ==
X-Received: by 2002:a05:622a:480c:b0:51c:1c73:5943 with SMTP id d75a77b69052e-52ce6145233mr458824071cf.23.1786306557157;
        Sun, 09 Aug 2026 13:15:57 -0700 (PDT)
X-Received: by 2002:a05:622a:480c:b0:51c:1c73:5943 with SMTP id d75a77b69052e-52ce6145233mr458823271cf.23.1786306556491;
        Sun, 09 Aug 2026 13:15:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:15:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:43 +0300
Subject: [PATCH 04/12] iommu: qcom_iommu: support the short-descriptor
 pagetable format
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-4-87f5cd492560@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6439;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MyFwP51+yZ/c9HWtYLGPLcbLLtgX59e5z1/cjBJidcU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/uxbRFsDXIdIPxjyJX5z4BPN+Bao/YMpv3M
 /rtWeCXf4iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7gAKCRCLPIo+Aiko
 1ZmDB/wLpAF5I4ooO0aH/Ttyxv6B7kwIdY7FJlzh/jVhEqu7WGpxIjwqBPSn/IwhalxN6KIsw2m
 weEaL02pDPZy+sckhBNY/F17ukcL0NfQLd8T99WbxSbkuJj0LXW2u5tQE6D02tgTpmH1DhpUNXc
 ivHOOVGrJ8vX47fH4yzAjAfTkl91QQRYwNctqyZQNBgKgMSWeklmY2ywG4tPL+2ueckypB7UjaR
 8r93l7jf1ka2KqlhJYSUlAdSEA6/PZv4Cvo4TxtnLm5XWC7T5/fe3EcGZm582npaPaz2p591qdo
 71N1zJP+3f0W3lrbjBGgGJIqrkbk4g1wVkgtkOz7hwwPa8Ze
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfXybJ6YNGhX9vq
 pKefYRaSJ0PHPV/KEVXG3tuX0xn4Df4zarjCfpKngz8FwS+7uzKBO91PPEV+2mbbJRLmNwUvmBt
 BwuU3pjnYN50d6rJO6xXLvTnf06KGD45ZjldcKMBqBH6UVOUAuLsVbzqp/AnWJer0+dxhOJ3qHT
 wzP7Hp95c4oW2OvCEiO2EtTgY3uomJxkt9K2FYK2i0TWnTYk9wFiOC4hCe/LDfKUWIAX4athNAw
 9SHDJX9YMcR6vEZtBmquhfV8IxJoWay0soZYlOITxF4BKMIYIbAT2olzp7Mdv1itr7oNQpbITMD
 iOGcpMtzTjHr938jCpSDNpadKAv+q+2mjkgeyeAMfMmVCDHURV3Ci7vxzCfFPU1yzoK5Vq+CpDi
 3j3le1rZAOMQP+dw2ROjW4/1GnE5lsHbIdGbkZUuFSkt0Lq6jo+At7SxAexGnuBhz4gP2O3NnlZ
 ZeCfuDJKvdhSGdrkSLg==
X-Proofpoint-GUID: Z11davmbpr4ctdNwPvYlgoXdKEA_WA9Z
X-Proofpoint-ORIG-GUID: Z11davmbpr4ctdNwPvYlgoXdKEA_WA9Z
X-Authority-Analysis: v=2.4 cv=ebgNubEH c=1 sm=1 tr=0 ts=6a78dffe cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=aiaqajgxMVtR3Km9lW4A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX/D2jv48TxqFg
 rN9NjZ7hGtvCYSIKfSlkRyDXzWtx+DliopCpdKj1L+WF1cOHdhEeS37KnM8LcYnLeLnMU6YuBxa
 ZVJkIGIQpZ320xgdoeX43I0aHkxBGy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090183

The MSM8974-generation QSMMU does not walk the LPAE tables this
driver hardcodes: every access faults with an access flag fault
despite AF being set in the descriptors, and with SCTLR.AFE cleared
the walks still return garbage translations (observed on the APQ8074
dragonboard GPU, which locks up on its first ringbuffer fetch). The
downstream kernel only ever used the short-descriptor format on
MSM8974; its LPAE support was reserved for the newer APQ8084 IP / TZ
revision.

Introduce a per-instance configuration structure, selected through
the of_device_id match data, carrying a pagetable format field and an
AFE quirk flag. For the ARM_V7S format, program the ASID through
CONTEXTIDR instead of the TTBR0 ASID field, reuse the MAIR register
offsets for PRRR/NMRR, restrict the output address size to 32 bits
and keep SCTLR.AFE disabled like the downstream driver does when the
no_afe flag is set. No instance sets a configuration yet.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/Kconfig               |  1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 54 +++++++++++++++++++++++++++------
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index 5fac08b89dee..596e643961c3 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -138,6 +138,7 @@ config QCOM_IOMMU
 	select QCOM_SCM
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
+	select IOMMU_IO_PGTABLE_ARMV7S
 	select ARM_DMA_USE_IOMMU
 	help
 	  Support for IOMMU on certain Qualcomm SoCs.
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 5bbb51d9bd65..77c01f217d7e 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -43,10 +43,18 @@ enum qcom_iommu_clk {
 
 struct qcom_iommu_ctx;
 
+/* Per-instance configuration, absent on msm8916-style instances */
+struct qcom_iommu_cfg {
+	enum io_pgtable_fmt		 fmt;
+	/* the walker faults on the AF bit despite it being set */
+	bool				 no_afe;
+};
+
 struct qcom_iommu_dev {
 	/* IOMMU core code handle */
 	struct iommu_device	 iommu;
 	struct device		*dev;
+	const struct qcom_iommu_cfg *cfg;
 	struct clk_bulk_data clks[CLK_NUM];
 	void __iomem		*local_base;
 	u32			 sec_id;
@@ -54,6 +62,11 @@ struct qcom_iommu_dev {
 	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
 };
 
+static enum io_pgtable_fmt qcom_iommu_pgtbl_fmt(struct qcom_iommu_dev *qcom_iommu)
+{
+	return qcom_iommu->cfg ? qcom_iommu->cfg->fmt : ARM_32_LPAE_S1;
+}
+
 struct qcom_iommu_ctx {
 	struct device		*dev;
 	void __iomem		*base;
@@ -65,6 +78,7 @@ struct qcom_iommu_ctx {
 	u64			 ttbr0;
 	u32			 tcr[2];
 	u32			 mair[2];
+	u32			 contextidr;
 	u32			 sctlr;
 };
 
@@ -232,8 +246,11 @@ static void qcom_iommu_program_ctx(struct qcom_iommu_dev *qcom_iommu,
 	iommu_writeq(ctx, ARM_SMMU_CB_TTBR0, ctx->ttbr0);
 	iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
 
-	/* TCR */
-	iommu_writel(ctx, ARM_SMMU_CB_TCR2, ctx->tcr[1]);
+	/* TCR; the v7s ASID lives in CONTEXTIDR instead of TTBR0 */
+	if (qcom_iommu_pgtbl_fmt(qcom_iommu) == ARM_V7S)
+		iommu_writel(ctx, ARM_SMMU_CB_CONTEXTIDR, ctx->contextidr);
+	else
+		iommu_writel(ctx, ARM_SMMU_CB_TCR2, ctx->tcr[1]);
 	iommu_writel(ctx, ARM_SMMU_CB_TCR, ctx->tcr[0]);
 
 	/* MAIRs (stage-1 only) */
@@ -252,6 +269,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct io_pgtable_ops *pgtbl_ops;
 	struct io_pgtable_cfg pgtbl_cfg;
+	enum io_pgtable_fmt fmt;
 	int i, ret = 0;
 	u32 reg;
 
@@ -259,10 +277,12 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	if (qcom_domain->iommu)
 		goto out_unlock;
 
+	fmt = qcom_iommu_pgtbl_fmt(qcom_iommu);
+
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= domain->pgsize_bitmap,
 		.ias		= 32,
-		.oas		= 40,
+		.oas		= fmt == ARM_V7S ? 32 : 40,
 		.tlb		= &qcom_flush_ops,
 		.iommu_dev	= qcom_iommu->dev,
 	};
@@ -270,7 +290,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	qcom_domain->iommu = qcom_iommu;
 	qcom_domain->fwspec = fwspec;
 
-	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, qcom_domain);
+	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, qcom_domain);
 	if (!pgtbl_ops) {
 		dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
 		ret = -ENOMEM;
@@ -298,12 +318,22 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			continue;
 		}
 
-		ctx->ttbr0 = pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
-			     FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid);
-		ctx->tcr[0] = arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE;
-		ctx->tcr[1] = arm_smmu_lpae_tcr2(&pgtbl_cfg);
-		ctx->mair[0] = pgtbl_cfg.arm_lpae_s1_cfg.mair;
-		ctx->mair[1] = pgtbl_cfg.arm_lpae_s1_cfg.mair >> 32;
+		if (fmt == ARM_V7S) {
+			ctx->ttbr0 = pgtbl_cfg.arm_v7s_cfg.ttbr;
+			ctx->tcr[0] = pgtbl_cfg.arm_v7s_cfg.tcr;
+			ctx->tcr[1] = 0;
+			/* PRRR/NMRR share the MAIR0/MAIR1 offsets */
+			ctx->mair[0] = pgtbl_cfg.arm_v7s_cfg.prrr;
+			ctx->mair[1] = pgtbl_cfg.arm_v7s_cfg.nmrr;
+			ctx->contextidr = ctx->asid;
+		} else {
+			ctx->ttbr0 = pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
+				     FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid);
+			ctx->tcr[0] = arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE;
+			ctx->tcr[1] = arm_smmu_lpae_tcr2(&pgtbl_cfg);
+			ctx->mair[0] = pgtbl_cfg.arm_lpae_s1_cfg.mair;
+			ctx->mair[1] = pgtbl_cfg.arm_lpae_s1_cfg.mair >> 32;
+		}
 
 		reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE |
 		      ARM_SMMU_SCTLR_AFE | ARM_SMMU_SCTLR_TRE |
@@ -313,6 +343,9 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 			reg |= ARM_SMMU_SCTLR_E;
 
+		if (qcom_iommu->cfg && qcom_iommu->cfg->no_afe)
+			reg &= ~ARM_SMMU_SCTLR_AFE;
+
 		ctx->sctlr = reg;
 
 		qcom_iommu_program_ctx(qcom_iommu, ctx);
@@ -808,6 +841,7 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	qcom_iommu->max_asid = max_asid;
 	qcom_iommu->dev = dev;
+	qcom_iommu->cfg = of_device_get_match_data(dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res) {

-- 
2.47.3

