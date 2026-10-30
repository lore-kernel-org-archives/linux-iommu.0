Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397928;
	b=Dew2S+byn3AQE45HFIVky+iM1jwnQl2szn6AGKLhEWiGVWGloPptOMHW4Gt8Z4YxhwSn
	 GhtAGULHVt6/DcOKgSRA7ZB4Zlu3jHLSo7TXmHGoqkRJtZu3+BVzzAbHxkZY3g+kgZmMQ
	 6ZKs7X+0t+W3BuuwBS65Z1+6/9QlWuRHN2uRkpOuKBzqasSiZzh3x3XPdKbD/S00uuL07
	 4fXLQMbacIr33vtuemCjHXFh1dnoWjke257wRzVm7HZf8AqU8KseXujBE/l/KLvL3cB+1
	 SRaxlAdHeGLNt+bfPwqlNwsQmkCCr1MJPNxYa1ZcBmj2vpkI8ilGXYsxflp4z9WzbJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397928;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RBQYFH9qY/8wfFZRkj4H/m6BfoRm9sVnmTawEHfr+ek=;
	b=wLYuzd02h52vLljmrcQz93cVxHZ6AbVk6ac7b484OaX7UbRqWNIWfh/wbnSZMg2aY6uN
	 P84jJ+4fo7uuh6i+jRZCI1gOBaJUUvQuA8JlMekfBd6RNwRGjEwYnJm8AWtPI5WDx1SHC
	 YZcGxQFlQTuB0K3Ui+lvTHb7WgGQ7xh2itbbv7DlBHU0Qeukegv6aPBhUzIMkEupj1gBt
	 +eyMo/8JwWXM3w/tc2FI5RKIImes6yOfvrZNrljWYgtQSUztcCTLE80Puncy03j0DPpoa
	 J4yeAzs5hSOnvENFVs0Wfznz5avnM++wc43E61Fa2Mjj4XLvGheKqFkElA2DW60TZxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HnQz40G3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I2wmpGVu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC4606A330
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EC4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HnQz40G3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I2wmpGVu
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ULtL44905582
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RBQYFH9qY/8wfFZRkj4H/m6BfoRm9sVnmTawEHfr+ek=; b=HnQz40G3QjylPR5R
	yig72MUD6M490+bCaOkbfMQyo2euaiC6V9IBBLWMSQjVqN00Jk9LFZneG2rtog9U
	QKSLhqoJ+6f3nVhKorUsrVWT7npCkjxmnP/l+wiYxOTu95C0Rxb0RdF0/QxdN3au
	xRXLJpm8hWEJtZ6hRy6Xfn6wZkDQH/kcXuruMnsDDTmMnDVJt7k65vmISDCpkvnI
	5aniU08RbgmWIwA2kDu2uAxANg1M+Nx25OgBko7hsOkggb5cQqkwx5Zl0nydM7Fx
	GOoZoXI6Gj10IFxKHEuVLUbV3n4Hmap2Zh0YTqYriUyRCj0yYQzpfZdlEhFYYtgg
	hlDW3Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x10a7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ecdc701a2so146613785a.3
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793397926; x=1794002726; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RBQYFH9qY/8wfFZRkj4H/m6BfoRm9sVnmTawEHfr+ek=;
        b=I2wmpGVuG3VmwX9WCuQ7e/bDybv5zz7uNc9hNojpte1g7LwD2I13T8ZF5oOaQpjrMD
         pOnhd7g6otLUcN4We6RRQ7uHi0iQUph+2uMXZPZjf0oIKXwjPRjZCh3NTXHhMabkYDOX
         NC5uG4+zM9Ks23JYct5yc+O+XIQl7dxneAJ4iMP6OjG5d/754ApSLsIObFiCjNX9JTFq
         cJ0EylzUEVVKwab7R348Jn7KVawY4lQouAzyiViaq7/p6JhYC0LBXQM+Gb4Uq54rPAly
         pHfu5bGbnNZv5rXnm3YwmSauQdDWIXlfIVsIprSS8uInJhgAksO15YKsSEx14a/WIHKg
         JEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793397926; x=1794002726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RBQYFH9qY/8wfFZRkj4H/m6BfoRm9sVnmTawEHfr+ek=;
        b=c1dtPFmNkiRsxhSKaIyb07KJFNwdLZ/OHTbjV29RC4rmSdptCMudKTQRBFfkR4Vv6x
         nilZz7X+w+lASAUpjgyfkCTnLeg8n4ODANcEMPracKOMbEsUHc9mO/X1Gpc5fGI7azD7
         mywXXx6iRI5lIdl0DaNF+jjKlfa28VndB8YUGA/pM2a5Ian87ojojq4WAcwbpIuWvkGh
         IlDPcHL8zq5rvS2qv5eiLTr+1Ofq7BCnD3Xf8o0Duhce3P8zSKjGQZ621v8zK6UN1rHl
         4SWTeESNaoVXepwgbmBaW+FWMtJObXKSTI1L/lpTjVk2S+5jFBwFtVhWYK/1BdUrO8av
         Cbeg==
X-Gm-Message-State: AFq9FYLbyuWDSjfXNPSMVHneudGfXisgjSGOYz/Mwc014WX1sd5VK9xQ
	e86qmOyqtQYxbR4bU3EolvrU5/hk4wRdLon4CTE70XzcPG8HnTWsluqLSN0y3qKuuKGkmf7TsCq
	bzitfym8fP5NDAxj04KpujkhAAME2vHZVBdcTrAkvyxP7C5VacwIKc7F7Xg==
X-Gm-Gg: AYBFou1qo+6/qytDR33myBdI/F8bjW3sIEjjLNgemTp3HQ2rhK35Mv3YsxNgPV6oXDr
	/7+iVMayO7qxuXfOg1BdumbFpJKNY3k40/7kLWPJi+Gs5AuzMozskKP+3fFoTxy86XzyQ+YXkUK
	LHk4OninJkdC6L29jF4Nuchmvl34uNsS0RetFP0X896aH+yDpSV1T5sXlEssCHWneFhrweb9dhA
	oysSkHpBPvkIVjVKfGLIOy8C5msr29fvAOzWmRhxXC8hg6VbGSbbkwANK7bmjt9arRzpwUZb2p8
	1T0ozqzlKpnN7ed2Z2TokbSA3L5R0O/fWLJzx0q8OxD1wSsXcNYlotOLRHrsScemNYqQWJAq+1u
	gLKGEQ22CR5vwvwwfU6bw8Tq6JVUyI5w+fyu08lxXeohsSaaP/myvMhbxrt1PJw4TCA1kBFlcdg
	30imXKv7+drDmwT9J2LAUqKOuwXvHFwDIPNo1dgdhFvEMrao8Hrl7PHMI0q9W20A==
X-Received: by 2002:a05:620a:6cc4:b0:93f:34c9:9259 with SMTP id af79cd13be357-94421739a72mr652258085a.50.1793397926126;
        Fri, 30 Oct 2026 15:05:26 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc4:b0:93f:34c9:9259 with SMTP id af79cd13be357-94421739a72mr652253385a.50.1793397925571;
        Fri, 30 Oct 2026 15:05:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe04edd7dsm243930e87.6.2026.10.30.15.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:05:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 00:04:59 +0200
Subject: [PATCH 3/3] iommu/arm-smmu-qcom: Use identity default domains for
 MDP5
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-msm-smmu-identity-v1-3-a2a70580eebd@oss.qualcomm.com>
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lLouI/bTmjXpgte/SazsuwobLVMNh7dfXWGAG7Gi6io=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq5RSazf2fJ+5mBp4xuH6MvlX8NsIWizZkVogDf
 HSlZFoW9geJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCauUUmgAKCRCLPIo+Aiko
 1SSoB/wIW+hEwcrwG5R4YcMUL1kBGVFaXiqV5T01kWY39CxgAlb17URcSVuExa5xChycU9gLYNZ
 bc5wDh9hG0nd5BOnfNuyflAbWRpYX77ysC5FN7YmLxrLir1sb4tnk1bESZBJHeSdU5pKV6NcnnV
 IixfdDOsfEhc424rQeuMmHrNaTINCAvuz6P68LFcU1IvyLWZpnuOsqvA5xW/hBJ+tqYcMl5Hd4G
 2nT1aWAVW2bn9PBrz0z/n/UU92wibmG1jUvCFRNXE+rsI7Gg9tYInEYd8OMKhWYHDyaiuY6lEVu
 6H6TNxngELa9cIj3bCS8y/R8ZIZLZaDlU0c/2u9RZMZ4fi/Z
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX/MkGn4LILiqK
 54noyMb9bPLo7URuZhYwYx9sLmZKdHPGA29NJr1XkHQQRKwmwqwX8iWwZr/smvM6JtXMgXUg5Xo
 OjIIUF5zL4Qgo2ZMzQzYuhH6L6cLYhqB+i8gEBGW8QSw/jlFkRTOstdzypMvuS0nC+DH94JhvvN
 Ga3jPX+MZbWUr+Kl+nBqIXhbLhm0VBiA86ZskKgVJsYduTuhU9mFQ6oCAdrTKSGusvxI9fx3H9b
 GINsSN50DcPQlpdMUXECKcxOARo+q6oeF89zUWwJYJGW5YlkB/Gy7JSt7Rne4IdCj/E5FQUVB8H
 TUdPCBe5D0u46zCYNKawZMwMpeCfSlDGMWRgT2gjzdFZMj+M9O5/34uvZnWs91OqJvIPw5gqu5b
 zHutaZDQuDHQRM/gAb05x5MFuUXuYjgQUPxPXLQZ1pSzcO7Tpivt2c349kRgWFfXRrP/aMsvt6m
 aDa4KxcT1Wryudm5XPg==
X-Authority-Analysis: v=2.4 cv=CLG/zhrD c=1 sm=1 tr=0 ts=6ae514a6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=rLj9A8cDlUUE0Zp7hZ8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX93599H/nSIpq
 ehxgwuZX3GQMo+3uhi94TZzBzqfZE+BpwoD4K4H0aXNQZdgdwgXBS9ekCk8VlatDJDE6LfGt8VR
 ZsKmFeWYNlALwealmQNgD0cjjlHC6Co=
X-Proofpoint-GUID: 3xmazTuXeTRu7SnRjSNm6ojGcata2Y4i
X-Proofpoint-ORIG-GUID: 3xmazTuXeTRu7SnRjSNm6ojGcata2Y4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610300088

drm/msm writes the addresses dma_map_sgtable() returns for the DRM
device into its own page tables, so they have to be physical addresses,
i.e. the device must not use iommu-dma. On MDP5 platforms the DRM
device is the "qcom,mdp5" node, which is missing from the client list,
and the msm8996 MMSS SMMUs have no qcom impl at all, so the device gets
iommu-dma. On db820c the SoC then resets as soon as the GPU starts.

Add "qcom,mdp5" to the list, which also covers sdm630/660, and give
msm8996 an impl with just def_domain_type, keeping the bypass emulation
out of it.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 795e8ec7e8fa..addba9074217 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -408,6 +408,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno-gmu" },
 	{ .compatible = "qcom,glymur-mdss" },
 	{ .compatible = "qcom,mdp4" },
+	{ .compatible = "qcom,mdp5" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,qcm2290-mdss" },
 	{ .compatible = "qcom,sar2130p-mdss" },
@@ -642,6 +643,10 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
 #endif
 };
 
+static const struct arm_smmu_impl msm8996_smmu_impl = {
+	.def_domain_type = qcom_smmu_def_domain_type,
+};
+
 static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
 	.init_context = qcom_adreno_smmu_init_context,
 	.cfg_probe = qcom_adreno_smmuv2_cfg_probe,
@@ -711,7 +716,7 @@ static const struct qcom_smmu_config qcom_smmu_impl0_cfg = {
  * there are not enough context banks.
  */
 static const struct qcom_smmu_match_data msm8996_smmu_data = {
-	.impl = NULL,
+	.impl = &msm8996_smmu_impl,
 	.adreno_impl = &qcom_adreno_smmu_v2_impl,
 };
 

-- 
2.47.3

