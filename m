Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856F3DA7E4
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306575; cv=none; b=J23jwf6slC4GuM//pvVH9T/8tdZ1gO+pgRaiJYLjczJZKh9a81pKi9jDuydEQDSGBg6qxNpA2NYZJWNMo+sxWciFUGHq25Atl84IFyletF8pkAZwHG/FeMpd+IDvX714PUK25KlwE6kFoicE2Eg3NdPPEj4I2VLLgmxdx6nkT48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306575; c=relaxed/simple;
	bh=vdP/W44ayt3FHEa9KUaIShbYNvDrdcgmsdVGlcwUja8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfdLwqC/MAln0RAdYC5G9nv6ER/YZKC+NvxG8bsVp5v3Ubu7fx/ewBaNhhItzxgWSTjLKFbzxAjLjt2EubzsmMOgM+qAfUYIaZ8VCEV0FuTEPkktV0oOV2evA5bW4AxoT1FhxENmxrDayAiOg/9IGZEG1Afaq81zTRcUgDTNPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=irpKRk8R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bLdR7jGn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="irpKRk8R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bLdR7jGn"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679IasN43533041
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iNPk9I4Upyn1iuvNFg1ZZoqQjoBVK1nqXfEtDMUZc8A=; b=irpKRk8R9ejJ0k7F
	W7uQs76hjB+J63bTajkby5HIL0fF9bzl6ZM2AHKQKsamwZBOO2i8EOd0YF+aFUqb
	bMF9ImOINAOhJksg1AeXDa12ldb1pYp0nTZ7cRX9w9p65/hyPRGw4fNKn03wbjrQ
	4AAV5L59BOFA3k2qxmNQeyjkEkG//yJkEkhSS7J/IeLKa7vO8be9rvtJdWF0xZ5G
	P4alCOWr2dTIrH2vy7brxybAlW48CW2deVBL3z9zAjSgtiB6DNaYYI8yVzKKsknz
	KiBkzWqSBdJf8d5ZJnGlhR44/zRB/gXigIjch4kTb+KnwzrehKu1tEprK9BofpNw
	BlR9bQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvp1kdq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:16:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bf321d786so15339581cf.1
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306572; x=1786911372; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNPk9I4Upyn1iuvNFg1ZZoqQjoBVK1nqXfEtDMUZc8A=;
        b=bLdR7jGnD4F4GRri0dN8wChzEQnnUIj559prNqEhQMSORW6ZLKyiNdxiXtX3syuzfy
         TY7/2a17bmmn7UL8yip/331FnDWhLxowxXFBUvf2cNQSx14rF+1aauxx8pNCoLhbuXlB
         aiYlEdxfFYaS6krm0dfYQTa6Pju3X7PcS1YhiB/L7s7Rz0S5kvp9AFPBgSpVxYAubCFB
         XBi0sZnUzpLJ7aEoHpivfgY3p+8kj0Oe4HwnS/Ghdil+CymHwWF7RPbD5tOkc3X8AVvG
         8clZfvR8Q59tNkcuPm+KPDdyVqc0Kwg434eGkdJuOrdmaoOrAHNX0zru0HOZp4uZgAAM
         +3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306572; x=1786911372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNPk9I4Upyn1iuvNFg1ZZoqQjoBVK1nqXfEtDMUZc8A=;
        b=esP2fktQPAiHqHyLBllNazKu5rGQZXgQBikSCRo7PEYeHjrd1KqzWQ3AlUSFKgAbsZ
         qdOHiF5uMyI4hOQakiLdsQ/TOzFn1vlvBG99onYU2ij033/9sxw7mEYgVpJ9CO1MRdLl
         9dRPPPtsBSQMj+LSOs6BLjmlDhrPTjx3O91LoCIXZJh4tnXjJP/DuQ+SvDbX6h+fUtsD
         bbMI7kLy+v7i/PPPKKl+X5dLrNAhWjWYtBFayY4+2wyLBUNTyrgC2Dh6C1WeWi0S2/Ta
         1slCwjQRSgQuC+Cg215vcDZUy/USal0RcDxJ8Oz/+3Llaq93shNxKPTCyvr1nv3fcoSU
         TAGA==
X-Forwarded-Encrypted: i=1; AHgh+RpEmQ3irEpGrb63nzR+edYYqLqlgEaHCEbfREKMHOFsTlkGNFweWGuHPXTXVx3QgWvAqEPDMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9xoIYsQnQ2xQaK0ORs2Gq6mm317naLIpuU7qu0bjTI+mmdfJz
	n4WEgn/TV9245IEpUrvYKPnr+iTGz9jarQ4AdA/3z0BisVvuHGFqdmBTQ6NNeeOGrUmkqIJM/jz
	mD3iadvUnn6ZyDx2NMMzDQl0wm6ME/6zarEwDdI0f5odc0N9gCfOGCgvBNw==
X-Gm-Gg: AR+sD12O41cxwBThyQiT4w3H9AKBH4Z7KQhQyU/jMYFuNOIRSfWr1eNX8nko8uTbUhO
	qgZf+Jhcsf19rY9jVRAznY5/Z4bYdMZwNdGqbKKL4HJilml4br/Q0Ni21uuSIEVdn2cGiKVAFP4
	nZiOHJpAyHCEmRg14fOYw08szUCfwFI4R46rzkg4vnMpdbznLAYcXGpmpjxheHCq18XnZdnwMpx
	d+t8snWQLuwcHR9aK/bMoP7hAQIQJgT9gOV+zcm/BAHyU5z7h7TNNOdkImAI//weBHkjj1Qntdb
	shmFVgGSWHnmFH0gLPEnQjRzB9H0yvbg2PgaPH3XKba8xsccsVF0KiNBwAPTEnoDnYyeDV0jMP0
	+dQFvCVLZV8sFgbPkGCcwIpeDyK8tUe30SpJ2w1DVdjahW6kT758DnhM01lLWtJpwfY3kUWn/se
	y+94ItwCslc9eX7Q==
X-Received: by 2002:ad4:5d6a:0:b0:8b3:f911:c1df with SMTP id 6a1803df08f44-908a7098dcemr230865356d6.21.1786306572117;
        Sun, 09 Aug 2026 13:16:12 -0700 (PDT)
X-Received: by 2002:ad4:5d6a:0:b0:8b3:f911:c1df with SMTP id 6a1803df08f44-908a7098dcemr230864896d6.21.1786306571669;
        Sun, 09 Aug 2026 13:16:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:16:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:49 +0300
Subject: [PATCH 10/12] iommu: qcom_iommu: program BFP (prefetch) settings
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-10-87f5cd492560@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vdP/W44ayt3FHEa9KUaIShbYNvDrdcgmsdVGlcwUja8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/v954t+9nRfN3jnbRFtVv4Id7AvzQk1kHTv
 v+6iLVynGaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7wAKCRCLPIo+Aiko
 1UhdCACM0mYcaBjCCwCd+apqi/GjzhWRRST3w8LuuiNKdjPQjAlSU6FRIgZfH7nvWcZteQboR0v
 GZXKfhZLTXVzkaVl1q3bfVJIqoYeVIZ8veIxt8pxOHPRyn2PA4xivjvRfjr8bGLOf/v5jNsxprg
 UfzI8sAwYE/9O/q2xhPGfSsZLvW/SCNi35M8yljHoviKgSAAhE6j8ZTT7x5GKN+7VceUfgzZIyk
 xIwScXlLpMSTv49jQ2YKMpkuD91i7AryZnSmbN8YmXhRVtRylDUjH+jv8Y0nkMr7qSh0xOcLFfz
 mTHR8RixAfhFsT7ca5pCr/rVWmavhaHe4HJNf8qF0dOtT/HT
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4NCBTYWx0ZWRfX+Y8T8F+lrMFn
 fFPGTK0ayx3xx7jN8I7IWftZB/9YElmNILlZSRvZwyn2D1x+WzwB2YXncc5hNx0+8nTM2IJ+7XT
 KhLBel3VL9RII0v6R+p0nJk9GhAk+1ncDBG9GLTm/YOCT0Ot6MMpJBBJo4/EZ+t9U/TqbRCyczU
 0Bmj38CWSrna4O6QJ7fky5WC+OvR/FkeOo4gqayXnwOTj85LHIj9MBlIm5KGb8RuNXqYbKyV0mn
 ZoLqIfqjoC3DJvWO4HAKFySJWWd/xICWAJm5AurlRI525kSbcMezrVHXMV64QLEZFHfsFBapXip
 BQ9u4VKlBovvz1Vu3q1j1RzQbltZc1pw7ZXZxZ8Vg7QuyfGfjMdG9NehDsGy/2Kzs2C8ht9TDKH
 PtD0JY6VhfQ0sYY1OcynNFMIeyDV/3IUiYn8eQWCjI26leFDOPj/GhCcAfuxI0QlpoDu7/08w3k
 D5d/Q4TRk2U1e29bSYQ==
X-Proofpoint-GUID: 9BPwMWeE2y80TwMHYrlD_roPxqbb0mEW
X-Proofpoint-ORIG-GUID: 9BPwMWeE2y80TwMHYrlD_roPxqbb0mEW
X-Authority-Analysis: v=2.4 cv=ebgNubEH c=1 sm=1 tr=0 ts=6a78e00d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=jEMSmkJXngTgGiv5SFIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4NCBTYWx0ZWRfX9YdabIHTUVUd
 JRvO43PoVcFsuZG/0+BxWZLiCqX+8PYAdXbTb6Tq5VJ1GqBbnlXyqz2Sg4b4kuDfMRpdwXQL8+T
 t79Gk+7SHNm7ZulrT3euhEaKEAoFcVs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090184

MSM8974 QSMMU instances require additional programming of the prefetch
settings in the instance-specific space, with the tables being specific
to a particular instance (rather than the SoC). Implement support for
programming BFB tables.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 2b2cf665c39d..9523ae95fa12 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -57,6 +57,11 @@ enum qcom_iommu_clk {
 
 struct qcom_iommu_ctx;
 
+struct qcom_iommu_bfb_reg {
+	u32			 offset;
+	u32			 value;
+};
+
 struct qcom_iommu_sid {
 	u8			 cbndx;
 	u8			 sid;
@@ -78,6 +83,8 @@ struct qcom_iommu_cfg {
 	bool				 halt;
 	/* faulting transactions must terminate rather than stall */
 	bool				 no_stall;
+	const struct qcom_iommu_bfb_reg	*bfb;
+	unsigned int			 num_bfb;
 	const struct qcom_iommu_sid	*sids;	/* one SMR slot per entry */
 	unsigned int			 num_sids;
 };
@@ -286,6 +293,25 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static void qcom_iommu_bfb_setup(struct qcom_iommu_dev *qcom_iommu)
+{
+	const struct qcom_iommu_cfg *cfg = qcom_iommu->cfg;
+	unsigned int i;
+
+	if (!cfg)
+		return;
+
+	/* The BFB registers sit in the implementation-defined space */
+	for (i = 0; i < cfg->num_bfb; i++) {
+		if (WARN_ON_ONCE(cfg->bfb[i].offset >= SZ_4K))
+			continue;
+
+		writel_relaxed(cfg->bfb[i].value,
+			       qcom_iommu->global_base + QCOM_IOMMU_IMPL_DEF +
+			       cfg->bfb[i].offset);
+	}
+}
+
 /*
  * Reset and configure the global register space of an instance the
  * secure world does not manage: global fault state, TLB, stream
@@ -1131,6 +1157,8 @@ static int __maybe_unused qcom_iommu_resume(struct device *dev)
 			return ret;
 	}
 
+	qcom_iommu_bfb_setup(qcom_iommu);
+
 	if (qcom_iommu->cfg && qcom_iommu->cfg->ctx_restore) {
 		/* Restore context banks lost over power collapse */
 		for (i = 0; i <= qcom_iommu->max_asid; i++) {

-- 
2.47.3

