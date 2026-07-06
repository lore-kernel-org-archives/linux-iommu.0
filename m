Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9797435AB3
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357026; cv=none; b=oW1glmJ+gTeKSEEvCiSN8OXKS7KV5m0OyTFDC4cBFcjGuKoH06jWqDHf0x/KKiat36A1fX3Qd1Jpumo34R+3slwQMaqYN/iEO4I3fpM/avmVzfq0NlB/3D5y3B2vQGUnRTzkx7I+8QZQZgAJ+oIZKM4R6jXZNwMOtFMs1mrFYzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357026; c=relaxed/simple;
	bh=lat7Bx/Hq+cGZXWIYs7lxJhgcpijDQh+OJ5u9DwkhsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7P2WFhTQxId9anb4mvJmQRErPLe0mNJgiuBkdSuHik6dbZubwmj/fFBn/tCOUfwFC+JgoMJ9EsdX3R8y92cfrhL8M4gSxS33DKGaPStn4lr5LOQyBJWaWK0XImX1FIcmvsuxcVQmhsfKzmZbQ0D3mTR5xuVOzWfoLend2/h418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GK//fDZd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X0Gu1Mni; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GK//fDZd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X0Gu1Mni"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Fshrw1050572
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 16:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eeMZFJmS8I6MvmecXMPUITG3bfspevNiFJM+WXQ5LoY=; b=GK//fDZdOHa5Ov5E
	1Q6DboppC21nvaIz6DWKAKlzeZFQ/4WZCHriDrQ0j1LPkmDsgR6RaHtRFOS2QwQ6
	sXfH/wgCUdjIMgyEc1k1T5KmZAndK5qznar5uHSUZJGNGgQzh6rB2A2miqN7qO5d
	E/BcznIboz+P6iFOz8QG4AKLxF31Pa981cqbtkVrz9O31ZD0/vu7ZqWKTyBTJLHF
	54Yiys9b2UONurX00oHr5yFZ+RtgP8i9hOodCM8pTNwJfEht+S09fQ79EHHD/H+M
	zkilUX+SHk404auE3sUt/jNueddEp6jpvp7SzalPe1p5EirkSIw9x++rTphy6CHv
	/g3/1g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw0amy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 16:56:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c98a4ded1d7so2931572a12.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783357019; x=1783961819; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeMZFJmS8I6MvmecXMPUITG3bfspevNiFJM+WXQ5LoY=;
        b=X0Gu1MniLwdz7UQHerVgkuytTi7Hk1C7BF+9mf2gy9yhOvg13Z5nhNdgRXnRNR+5cT
         +8RYNTwxEYeAzH0qJZs/u+FSVegwxtY1ESSoCahSyE8HuTxhr2SHTSFSLCTJN5Zy8Nx/
         GI5O6Dobv5+ufiE5DeWWI5ltmSBOlifjGO6EFdWEzBYLJJaPKPfc4VgGli1eZdIMLQVH
         9N+ib90jvDC8THmpTrGLKbCMiQKzwJrD7tO4OqphmBpZ/HGCxtovKfz6Nin/OmIdV5oD
         rjQ4Y8h+PPmbr05P4L+aCsjFiJdyhMxtkqekpykdh7LjdOCmocBJW4vc9+Cu4QMh2y/Z
         5glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357019; x=1783961819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eeMZFJmS8I6MvmecXMPUITG3bfspevNiFJM+WXQ5LoY=;
        b=KbGMkA92PgZUKV2e7r7ZXVkVCI/V3geT9vKbywpo8g2m5ku+7uPf0d2wA50D7aRgdw
         BDuMPSvWSbRbJSMjsfJS9I0AArfV5CRuLB/LHvzYwe63EkwyMksG13YL5HvXxvygA4k9
         o48yZVz3bEK6jHbBs1iCX6CuQ6YFLpyaDe1Q5lR0jPWnd+QuzCewDDJhrEB4ngc9s6Nb
         5Xk12yxIQ3uSs2wQQ5YaU1/rHlb40UWngM3qI9rtPfawezX7bXcBS+NCWI3G5J1qiPsb
         HR5wIvdITpddd21YYNJa+vsxb3K34cAZRVEev42pYs9nRRguO82L/UWvLu6KV9AKNAid
         IyCw==
X-Forwarded-Encrypted: i=1; AHgh+RrpV3V/WN3PumBXWqWOX6IJKRsgXxKue9Hcbl2sS1KJyAHwB//tyUFbRDT72xbVNNLMF7/7ew==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrJngrYmYkXELUBwVg0SatpdczJ21uy0f5yu+8vDjUCS08oEuY
	Dj7ritv+hbvMfeikgnR4Cgi2c8XTXA5QnK5CmuV6REINu8hYNUV4BpUI/qxnaQWj1H02Il1s4cK
	d9FhtVvzcbAVlJLKxvUNlWmg1bD4MoXNflt1AtLu/CiXT5lKpE1rIK0D9rg==
X-Gm-Gg: AfdE7ckw0m6ykASL1qKz6b5fOZsjDjdW4nBJSkbbfL8mD7t3ARezSjHKrrh7KjFv1rD
	g7aynsvMVUQdpz1GlXFPTxMae7FDDK127MA8E8hkqSZl909niOduiDFsJ300Q/EY9uHKw1Q9Bkp
	xLYBJBbTEK0xGH10x9fjev9xJvYZW8ciEaSo12KsAd0JbDbtyDAtixZM5xFp/hmcgSak+x8XYkK
	q3gkRZpluCEFPdyXbogrGR9SBz77AArWGcPtEGTIprs+1f9DNscb8FYZDHmCvMb3KnayHoUnThD
	5QhpBAjv2OrBoPWUoiL0YNOpLvvhg5W8tjhyXhJJaYOfIR+ErN65bDOqha83FqdzFQtPH4Ux2pE
	RQISPJoPaiI4bpbD21/JTKieim+jjpdiMkUGIa+E8Eg==
X-Received: by 2002:a05:6300:67c2:b0:3bf:d487:4b38 with SMTP id adf61e73a8af0-3c08edc70dcmr1771522637.23.1783357018617;
        Mon, 06 Jul 2026 09:56:58 -0700 (PDT)
X-Received: by 2002:a05:6300:67c2:b0:3bf:d487:4b38 with SMTP id adf61e73a8af0-3c08edc70dcmr1771478637.23.1783357018123;
        Mon, 06 Jul 2026 09:56:58 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0efc8sm6960604a12.5.2026.07.06.09.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:56:57 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 22:26:35 +0530
Subject: [PATCH v3 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-smmu_interconnect_addition-v3-2-afdca0125a65@oss.qualcomm.com>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
In-Reply-To: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783357002; l=8198;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=lat7Bx/Hq+cGZXWIYs7lxJhgcpijDQh+OJ5u9DwkhsI=;
 b=nAo1SdSTHRgHqoWATvufzYzKXA6ZSzlLu/yclNPZ/Su18G0rQKinCdWabI3CJGi0YHltUYo5y
 O9zxAukcXszCKTXclXBkKXSAOAvDyoEonRQeqlyX4jAe0fn3JicK1Zr
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX5fusplX2Ob2Q
 TlMM/lepYZF8CzykI5rAqsWpxsX+4k4UHRWRMG+yhQI8MQvIUzFJVd56IU0wMzU+Y0uOYx/N4KE
 94wbRp7hvYCOqLCn1As803UvvXh+EeI=
X-Proofpoint-ORIG-GUID: zotr8WudnBTzs9RTTPs7VPfbib9CMbQb
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4bde5b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=EBvdZ6k9WR3IvNukGaMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfXx1RGZUHubUaw
 PvWYfB+mxtHF1QcyEselQcPsyw9COH3+BVL/bi7DBSv1KfGyQFMsGJkRXKW+8VjnHnggisXzNF5
 SdE5DB/kVu10yzmiTlJDxo0GL90Z0hZOaz/ATlisrYtX66+cvZLtXq4hO5PyOH+al1dGb+VWfUa
 VMeEYI1kRCu5chfYATM8sgeNnoECxGG2m4ZWZBPNxDpTsbD2hxKV/ZTWirGh7iVABmyrpTnfQkL
 jp5L1d4uB1KvBnMCTuIF2r/PlxE+Ks5Z7eGVcK7vIVOlsZVb+7NyTdLPnbSUxqCY0hGI9nvvwg1
 fEKd4khARkL5m69TunHVXXq+oQgkpuDfXfToY7kDAi+6Q3Dg9hyKwI5YE4G92tCUotLqFYOoUj4
 fV5euvfIO6SLC4qA3BH+xqVFu2XVUwXbP519JJSj37XCKmoeEqLV6gQfR8FjzQJ6nXlbHwq+1+7
 3BvtFQ85iKXrMKcaRmA==
X-Proofpoint-GUID: zotr8WudnBTzs9RTTPs7VPfbib9CMbQb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060170

On some SoCs the SMMU registers require an active interconnect
bandwidth vote to be accessible. While other clients typically
satisfy this requirement implicitly, certain corner cases (e.g.
during sleep/wakeup transitions) can leave the SMMU without a
vote, causing intermittent register access failures.

Add support for an optional interconnect path to the arm-smmu
driver and vote for bandwidth while the SMMU is active. The path
is acquired from DT if present and ignored otherwise.

The bandwidth vote is enabled before accessing SMMU registers
during probe and runtime resume, and released during runtime
suspend and on error paths.

Generally, from an architectural perspective, GEM_NOC and DDR are
expected to have an active vote whenever the adreno_smmu block is
powered on. In most common use cases, this requirement is implicitly
satisfied because other GPU-related clients (for example, the GMU
device) already hold a GEM_NOC vote when adreno_smmu is enabled.

However, there are certain corner cases, such as during sleep/wakeup
transitions, where the GEM_NOC vote can be removed before adreno_smmu
is powered down. If adreno_smmu is then accessed while the interconnect
vote is missing, it can lead to the observed failures. Because of the
precise ordering involved, this scenario is difficult to reproduce
consistently.
(also GDSC is involved in adreno usecases can have an independent vote)

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 55 +++++++++++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  3 ++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 27 +++++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
 4 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index e2c914fccd6f..5133d3ab023a 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -6,6 +6,7 @@
 #include <linux/acpi.h>
 #include <linux/adreno-smmu-priv.h>
 #include <linux/delay.h>
+#include <linux/interconnect.h>
 #include <linux/of_device.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/platform_device.h>
@@ -607,6 +608,45 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 	return ret;
 }
 
+static int qcom_adreno_smmu_icc_init(struct arm_smmu_device *smmu)
+{
+	struct qcom_smmu *qsmmu = container_of(smmu, struct qcom_smmu, smmu);
+	int err;
+
+	qsmmu->icc_path = devm_of_icc_get(smmu->dev, NULL);
+	if (!IS_ERR(qsmmu->icc_path))
+		return 0;
+
+	err = PTR_ERR(qsmmu->icc_path);
+
+	if (err == -ENODEV) {
+		qsmmu->icc_path = NULL;
+		return 0;
+	}
+	return dev_err_probe(smmu->dev, err,
+			     "failed to get interconnect path\n");
+}
+
+static int qcom_adreno_smmu_runtime_resume(struct arm_smmu_device *smmu)
+{
+	struct qcom_smmu *qsmmu = container_of(smmu, struct qcom_smmu, smmu);
+	int ret;
+
+	ret = icc_set_bw(qsmmu->icc_path, 0, 1);
+	WARN_ON_ONCE(ret);
+	return ret;
+}
+
+static int qcom_adreno_smmu_runtime_suspend(struct arm_smmu_device *smmu)
+{
+	struct qcom_smmu *qsmmu = container_of(smmu, struct qcom_smmu, smmu);
+	int ret;
+
+	ret = icc_set_bw(qsmmu->icc_path, 0, 0);
+	WARN_ON_ONCE(ret);
+	return ret;
+}
+
 static const struct arm_smmu_impl qcom_smmu_v2_impl = {
 	.init_context = qcom_smmu_init_context,
 	.cfg_probe = qcom_smmu_cfg_probe,
@@ -648,6 +688,8 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+	.runtime_resume = qcom_adreno_smmu_runtime_resume,
+	.runtime_suspend = qcom_adreno_smmu_runtime_suspend,
 	.context_fault_needs_threaded_irq = true,
 };
 
@@ -658,6 +700,8 @@ static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+	.runtime_resume = qcom_adreno_smmu_runtime_resume,
+	.runtime_suspend = qcom_adreno_smmu_runtime_suspend,
 	.context_fault_needs_threaded_irq = true,
 };
 
@@ -667,11 +711,14 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	const struct device_node *np = smmu->dev->of_node;
 	const struct arm_smmu_impl *impl;
 	struct qcom_smmu *qsmmu;
+	bool is_adreno_smmu;
+	int ret;
 
 	if (!data)
 		return ERR_PTR(-EINVAL);
 
-	if (np && of_device_is_compatible(np, "qcom,adreno-smmu"))
+	is_adreno_smmu = np && of_device_is_compatible(np, "qcom,adreno-smmu");
+	if (is_adreno_smmu)
 		impl = data->adreno_impl;
 	else
 		impl = data->impl;
@@ -691,6 +738,12 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	qsmmu->smmu.impl = impl;
 	qsmmu->data = data;
 
+	if (is_adreno_smmu) {
+		ret = qcom_adreno_smmu_icc_init(&qsmmu->smmu);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	return &qsmmu->smmu;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index 8addd453f5f1..6835b40339ce 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -6,12 +6,15 @@
 #ifndef _ARM_SMMU_QCOM_H
 #define _ARM_SMMU_QCOM_H
 
+#include <linux/interconnect.h>
+
 struct qcom_smmu {
 	struct arm_smmu_device smmu;
 	const struct qcom_smmu_match_data *data;
 	bool bypass_quirk;
 	u8 bypass_cbndx;
 	u32 stall_enabled;
+	struct icc_path *icc_path;
 };
 
 enum qcom_smmu_impl_reg_offset {
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0bd21d206eb3..a27804e15738 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2189,6 +2189,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	if (smmu->impl && smmu->impl->runtime_resume) {
+		err = smmu->impl->runtime_resume(smmu);
+		if (err) {
+			clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
+			return err;
+		}
+	}
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2273,8 +2281,11 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 
 	if (pm_runtime_enabled(smmu->dev))
 		pm_runtime_force_suspend(smmu->dev);
-	else
+	else {
 		clk_bulk_disable(smmu->num_clks, smmu->clks);
+		if (smmu->impl && smmu->impl->runtime_suspend)
+			smmu->impl->runtime_suspend(smmu);
+	}
 
 	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
 }
@@ -2294,9 +2305,18 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	int ret;
 
+	if (smmu->impl && smmu->impl->runtime_resume) {
+		ret = smmu->impl->runtime_resume(smmu);
+		if (ret)
+			return ret;
+	}
+
 	ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
-	if (ret)
+	if (ret) {
+		if (smmu->impl && smmu->impl->runtime_suspend)
+			smmu->impl->runtime_suspend(smmu);
 		return ret;
+	}
 
 	arm_smmu_device_reset(smmu);
 
@@ -2309,6 +2329,9 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
 
 	clk_bulk_disable(smmu->num_clks, smmu->clks);
 
+	if (smmu->impl && smmu->impl->runtime_suspend)
+		return smmu->impl->runtime_suspend(smmu);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 26d2e33cd328..ed08f86cf99d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -455,6 +455,8 @@ struct arm_smmu_impl {
 	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
 	void (*write_sctlr)(struct arm_smmu_device *smmu, int idx, u32 reg);
 	void (*probe_finalize)(struct arm_smmu_device *smmu, struct device *dev);
+	int (*runtime_resume)(struct arm_smmu_device *smmu);
+	int (*runtime_suspend)(struct arm_smmu_device *smmu);
 };
 
 #define INVALID_SMENDX			-1

-- 
2.34.1

