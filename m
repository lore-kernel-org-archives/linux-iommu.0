Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F193D6CB6
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369459; cv=none; b=YNtZRJHjRTA8UnUnMG5bkeVBr3t/IEMmciPBRqWQXTZ7BDrohib3XnaffpoZbxQuJpCmr1uI5Vr7RJQXt2PBmNVy2LT/L4t7aIj2N1+nXsduVOVoo5rNyteu4QX8QLQ9ogQfQkrqbfPOOtpx3vmtRfgGb1Q1kb9qu0W0qp9m7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369459; c=relaxed/simple;
	bh=E5Fp9SeBlxlY5LkEyncq8DbWiaXUn9TX29qYsqFaHc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WCD7Ag/M40HPV2O8WY4j2gU9BJq2P32jXYWuIToA9ah7xZUtNxUYPOTF3xNBiseW4cEB8HJDPTYu+S9f7m0ThKFpTsmV3XJBCyMuAvQTD8SqxEw+O9j1SJTJDTpsV3KHlsVzIHQIL+f4un2IIuoJE1i+08YfAlmYt8bRN7XXnWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pS6pWmQg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gdel1MeC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pS6pWmQg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gdel1MeC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S8gpr2663416
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 09:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FbKhSU90NlGW1d2QoysiqJ
	Hk3Yb91hEocxCgqPl/zD4=; b=pS6pWmQgpEyf8EL8Zh74MO9N1JnVlUVRODBVgy
	qddZ8EFDPlZVksZ5FWHdKeSIgxOPPfT954CX5DMAfEy+YUYDC9EJ8OMdXXCkWUR4
	h2jcjzm1pA0QlgbBs6xwj87zlF6iJHMYRyghneAPC55dooXCjbpWVO8zZtLk0dsR
	zf61FQb+HFzYMU78BXgxUWMqHQl85OGAqr+0KdhV/KUUXBDwzP3IktCZX75w0lii
	b838jNLGfVuzdQMr88kZprgra8SXkapRMp4yqJpxyu32BeAQfQYhBlLte017lrKN
	uf4crkZpZfv+bkKFnxeBRhlZsqe4838DCvEA2l7px7gNUstg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n3asr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 09:44:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f460260cfso11266541b3a.2
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777369456; x=1777974256; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbKhSU90NlGW1d2QoysiqJHk3Yb91hEocxCgqPl/zD4=;
        b=Gdel1MeCtgSwkai96NgTxSoptw7wgG9DoZf6EIYqdEZPJWGmuzVGImL/dC/W94Wsh2
         aMT9Lgm0IUsa/ngA4g7mYjXwUzPEt9CvuUOTrDXfuhm74P0S2y0leUjFBIPAsqhILujb
         zoI+FfC4nSj0FwQ10YqjnTxDeVfpF88UX56weL5aK2R4IEWmruyeSMswN0AYuoyGmqOI
         DgHkMT8yvoGRx/rL4UFduJgWcnsG42g0qnER96wqfaF4K6c5aX4RFVM+iuJHrHWewjy3
         nhyrxEk0xgX0qmz/ygzZWKbPHkXCXBq1ojIx0Uat0bvXfSLEWiugvVIZj8xfy3nz6zoB
         xxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777369456; x=1777974256;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbKhSU90NlGW1d2QoysiqJHk3Yb91hEocxCgqPl/zD4=;
        b=VsJRQUcNfOTStkp2Ktl4zHotOQ4RUCt8VQ2cc9BN57SkAMrnbJNFIClDtXWviYod9k
         QzQmwb5dmlHrxD9g8F2DlyEmFqIGxW2ajLzo+/vB0q0NihnE/8WBkCQB210mu0usyS00
         fs6ZKNysk9Pf/pgz7Qa5BdueLOzEdAv12vpYdXwKbKTSjhMoKX7TV0Ezb2UZ+rgUsXNp
         ATa0adX06OTRZZ+2ONHnQCHtxz/apFCmN9msbccH8+hM1cZoP1ol0C8QcXoCL9RqbQ8h
         199dDo8LFRO2Rc175+4Xbh/8wnS0XB0dVnsfqkpb4KZ+nsH3ady7pwo1m1qQaXXW3wBB
         Ykew==
X-Gm-Message-State: AOJu0YzrDmPp8yFipxbMNzAZpCWktdWpx7XGqJHiLvHLq5hgOEtWo/15
	mqgPIS9AER5qwMngKtxwqNBD2/YhxVBDrtONv1CWxmgWQC9Y3vfqY4+kkrx9hbja3jIHpDo43JI
	al+RV1Cf2EuqrWOXWpPKxnpynwAiEczMKcvKRLQRQAxw9mgnyuKijT6yxPw==
X-Gm-Gg: AeBDietCLw2bceXLf5MdyFIZd2zF9z9W3JAiWamvMsshNwwGmSJbHIOTGfO2VkoC8bl
	FpZBNZcX3qhKAwW/vqrMm0i18j0CqIjXQhxibNtguMT/5hrED1BdpgVv22gi9Zb0n/3j6OLw93K
	Ny/66AI/76HqwZBwW6yERiX4LBG5CWAzceO631ruyCm6VodWZdC72t125GoQrk/Sjy4LJXMgRC9
	vHwYIHSlVFyX1z7qUyT6SW+jx7V6KeV4iRRVMLhrFuc/RrAdKjTF9T+Slakv4E118Hp8TUc40V0
	/XlnKDj9fJ4daYmoxjTSf6bOskEbDKICTcwSgd8aTGy0w16YAJIBJidIdl5Ufkb4oGo/H8IQ2LR
	yKKFiPWxDnrGhJDYDTq42j68agDiLgmfDNuwZGWM0GBw+I3HYMnMYh1s+zPvvTHpk4gQ/vQX2Vj
	YFGQXMbPEGt4+D9juLLHB2+nc62gfOzgSxWMYgEBG7lQ9n
X-Received: by 2002:a05:6a00:e12:b0:82f:776f:a78a with SMTP id d2e1a72fcca58-834ddbc0d38mr2135340b3a.30.1777369455928;
        Tue, 28 Apr 2026 02:44:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:e12:b0:82f:776f:a78a with SMTP id d2e1a72fcca58-834ddbc0d38mr2135310b3a.30.1777369455438;
        Tue, 28 Apr 2026 02:44:15 -0700 (PDT)
Received: from hu-lmr-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae00a4fsm2168428b3a.5.2026.04.28.02.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:44:15 -0700 (PDT)
From: Lokanadha M R <lokanadha.r@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 15:13:50 +0530
Subject: [PATCH] iommu/arm-smmu-qcom: Add glymur MDSS to ACTLR client table
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-add_glymur_mdss_compatible-v1-1-8416df5a26f4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFWB8GkC/yXMSw6CMBAA0KuQWdsEa4HqVYhp+hlwDAXSAaMh3
 N2iy7d5GzAmQoZbsUHCFzFNY8b5VIB/2LFHQSEbZCnrUkktbAimHz5xTSYGZuOnONuF3IBCqa5
 yUl8addWQgzlhR+9f3t7/5tU90S/HCPv+BWQcG/1+AAAA
X-Change-ID: 20260428-add_glymur_mdss_compatible-44f5b2837498
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lokanadha M R <lokanadha.r@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777369452; l=1484;
 i=lokanadha.r@oss.qualcomm.com; s=20260428; h=from:subject:message-id;
 bh=E5Fp9SeBlxlY5LkEyncq8DbWiaXUn9TX29qYsqFaHc4=;
 b=GxReak954ZzGmZqlgnafc5bl4MSkvrNHTmLT2Ber8YUDsqdVq8fCPAkZMk2YDZwaMCMRXg7+B
 UyP4R6kL3t1CAtinzijNaV/C076Tk8T76b1SZZ6d+NduSyoDzGzxch7
X-Developer-Key: i=lokanadha.r@oss.qualcomm.com; a=ed25519;
 pk=PfwARBW5uLDUvebYCDLNkw3HD4g2b3T0VDrb1uc1Rxc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4NCBTYWx0ZWRfX5SM4h2L4CbXW
 WM3fxybglSufAwJhz8zIWAaq4KHNSQ81g5UjJdKwx7EhSRFtgKFXHksNqGkZUbYbn5UmP/qVGXz
 GCRsBNe5tW/HWQWwPEkMUFjbvmmaa7Ik+XMe6lYpFKbB5ydXL7eVu1iamOnTnt8GnB8O884uyHd
 uxV7u0XjXyBxUjzKuxAvDCcVIoZ02m8691sUqGZINnQhy6ANVNf6/fhFNeaT6ADzgkr5JraRHa9
 LZD0k3l8nbLUS0mZuBs5ZfczCLY+Y4+YL4cPnP+ByDh7Bv1XJ9MjftxI6PSccHRXMzL1202AhZe
 ZESpt8EM4CztUu4Pzsh8DdHliSuZW778j0qBo0uKZj7O3EYOAfcnnXA+rclVKuQAUujdn4Uqufw
 c1AtjVB93l8E0ChY3wArmJB/pgBjGOV4aAo+ZTch1t8JiJdNvykTNRkj7zNWEE6fRJWi2SpsS/B
 Yh1OVn9lRIrGwlBSJoQ==
X-Proofpoint-GUID: rCO2mdvLVXMgpSLNAtuzPkRq5WXbCBlz
X-Proofpoint-ORIG-GUID: rCO2mdvLVXMgpSLNAtuzPkRq5WXbCBlz
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f08170 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=X4sqO_BnIXgP0qhT90oA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280084

Add qcom,glymur-mdss to the qcom_smmu_actlr_client_of_match[]
table to configure the SMMU-500 context bank for the display
subsystem (MDSS) on the Glymur platform.

The settings disable the next-page prefetcher while keeping
macro TLB caching enabled. Without this entry,
qcom_smmu_set_actlr_dev() finds no match for the glymur MDSS
device and leaves the context bank ACTLR at its reset value.

Signed-off-by: Lokanadha M R <lokanadha.r@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index edd41b5a3b6a..6df48499a4b2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -41,6 +41,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
 	{ .compatible = "qcom,fastrpc",
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
+	{ .compatible = "qcom,glymur-mdss",
+			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
 	{ .compatible = "qcom,qcm2290-mdss",
 			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
 	{ .compatible = "qcom,sa8775p-mdss",

---
base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
change-id: 20260428-add_glymur_mdss_compatible-44f5b2837498

Best regards,
--  
Lokanadha M R <lokanadha.r@oss.qualcomm.com>

