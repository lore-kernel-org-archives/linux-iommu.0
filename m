Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1512DA75B
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613746; cv=none; b=r2xK0cOpHv1LvjGXq/NRHhECjCqkziDuG1H9Tnrt+tuVDU7O+huvX3P2GAN7+KA2NWMUiZUsRhoVri5TiGD7e5V8WTz0m6vCBL27iFicBcXCuRaCJF8vqIuYy3tC59YP4xTnT3Y+tbXUy6WikE2ot6NDhl9QFgpHW3t7JLTQOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613746; c=relaxed/simple;
	bh=GnY9q+Xc2Y+VqHrDqGOayOA+eKomJ1efauJwSslPH28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlkorBUxHPt91+zYlvFTN8m3Ry7mWDLi0d2zAtXzH1rPJY2cpEVi5iCrgZKbKoM9txNEV5ntRaOioPAZe4QzXHt8259Zd88FPdQ2ivFKlWNy0S2CYY7licDNaqFr9KCEV1yVE+Ld27DtRaQ7n0pRljK5rSx0R/hzr2G6FXZUM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AHIi4XZO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kqhLiaVr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AHIi4XZO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kqhLiaVr"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCLCv4545413
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=; b=AHIi4XZOid2bnlQb
	QIHtIk5OsfusjNOScnd7fdBKK8XoScIVE8weXJViPK6qOIkFnMDHkzuSXXl3ya4/
	bpcD4oP4jkNV9ukkZTlqRsMojjMcK1FyOWXrq/O1YQbP3t3mbQ7HF9qYAEw38sTo
	NKvqTZMO6cNaXE/9rcm+9nzEpdMaHDd+VT2BCuPUOMEzlz3enK4tIcEZ2XYxYNf+
	1M/xnjIAeV42EbXcQzJuamxAJeElG+D9nzcgTUv67R3R8lHicTuNTbMhksRX1Y6B
	fvz0WGu3BWiBZ0eu58gVfp2UXR8lStUa34jyR/YzOBDa5Nf4yd8ZXKmsa+Vs6Y78
	lHA9SQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e444ssmb6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bc763c7256so77872545ad.3
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778613742; x=1779218542; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=;
        b=kqhLiaVrDVpBJdgbD8kzWPtFy5N9Bo1mNcrSMfbR5OlvIHTsFTkojOe9C9R9qELIl7
         VOcZlQ9l7DL1t6AIvMsiGyNVp0jwd9qCngHixWKcvCS7j4GpvaJOeShAs5wMBJtLMXOJ
         brkZIkNL3EsHXX2QZw5bmNjtKvod+BVMatFJ75v0hpU0798vY6xwk+rS3qF2KN/n5Db8
         ppd5EGPy9uNa2T+/cl/Q7E5pcLLUapAHbZKrtzw2hZvmn38s8N9W5jAwRAvRBeglrUMS
         xWbP/EmVTriOt6TMBEWZdSoWas3xrpE/PdGAkDOuqdkGTg6gSogkhTHcJdwl7ZM4FqPL
         o+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613742; x=1779218542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=;
        b=NFMXEm2VFJCl661I9GaVCAALAc/BqcelQuOh8lUFvH+73LNozhQOFRPYIN36WhhLVa
         8BTUbOkUcGhxyjfJ/JRf+RAbaiXyfKPeJJfLXW3TOP2iO/SsICmQDC8h8Io04sWZyxBm
         AkjQPnV5riqHs1IoHMhzX0hGBO0Ta84kYxH/RgGiZTMg6MZ0KNIZEXZcZw+bKRh6ykLU
         F8fTxQkvz4VmJQpYbMAugrvxBXOSAHzGP3kMIlIpCQTri+E4qFPJsIlqNaEiQi1FHx1e
         XbjsD+nXrPoiFjhaUQye+xFT9Ql+PTZPlMBdMP5Ct5JLLxpjdIlYkzf5pPoh1e9SafzL
         qMZg==
X-Forwarded-Encrypted: i=1; AFNElJ9u7JY5LvTnd9dv0Uiq03v2sVIuZp0tZ4MrdE62asimrPfL2dhc2o7n77dgoiQm8MVMuLQkPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBGLeEFiCA14fDTkGUeqkhwrHTAgi0MgLu0g6LtcrTAtwqH7Ou
	jbNrN9ywZ8N3IEcJ9WQGBY2vHlmBnj9RbJ0rEEz4I1imw4AQAoNKGAo44UcrMZGIUGyxtKo/dba
	RU3RjJrJu00DQT7/klmUvT9r2jCrebeeRUwmfIRL0ZSDlg4AZ5bFaZYSLcj816kAl9g==
X-Gm-Gg: Acq92OGXx2CvGBrr3QzbneVOWTLhHF6QHC4iQpxooZyLGvx9xsdaCikOv8JY+UABudy
	3pBuU0ddk6OuXo9UeQy1aAyfXqBPzhM3mNqSx1/Wr9qBZW5SdlQCmLeh7VFXy8jmxf2hmnvV9Bx
	HCE/3+dIZaMrBXVyiMMhu7EjWuiTHWPsQdPNj/dB0KuEH5kNNYcGSVVdT1qgaRGlGzuoDrAFMe/
	DNHqtghuUpEUpHylBJ4n1CPIgD7LxFMPGphBr/3KONvBeaUQeI3dmX0i2x3uagnWIM0VZZOHUyj
	dofpc8ynZIs5goP5OHCZK80c2oL/Ow43uIOulN1I+e8iNd00fsGgnnvVs3RhjvIXE8yHal8oBPw
	qwSZE7IoTHFgPMXIY5w5XzfuedQxW0DTk5i87FXJUoUeSfw==
X-Received: by 2002:a17:902:ea8b:b0:2b7:aba0:ac10 with SMTP id d9443c01a7336-2bd273a8a92mr2765845ad.11.1778613741945;
        Tue, 12 May 2026 12:22:21 -0700 (PDT)
X-Received: by 2002:a17:902:ea8b:b0:2b7:aba0:ac10 with SMTP id d9443c01a7336-2bd273a8a92mr2765565ad.11.1778613741469;
        Tue, 12 May 2026 12:22:21 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ead90asm141250585ad.72.2026.05.12.12.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:22:21 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 00:51:21 +0530
Subject: [PATCH v4 4/6] arm64: dts: qcom: glymur: Add GPU smmu node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-glymur-gpu-dt-v4-4-f83832c3bc9a@oss.qualcomm.com>
References: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
In-Reply-To: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778613699; l=2464;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qFdQhBrAHggcU0GWES+ohMA4WsH2wnpDPMNFqXrANzE=;
 b=qewqACwvjsAf5rvaenjM+cLqWEE+eh0c4Ai2zQhfpx1rVMx5eMwCU4q16+hHSs93d6WWBiv12
 Z0Idzufub4tCvGngKqrEcib/6jgSNpiH55A8CXbP5MkDaWFgVCZm9hL
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: OD92WckJ8EUkf1JmgNVH9Cspgvn-7aCW
X-Authority-Analysis: v=2.4 cv=OcKoyBTY c=1 sm=1 tr=0 ts=6a037dee cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: OD92WckJ8EUkf1JmgNVH9Cspgvn-7aCW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfX3PmtOqT75wi0
 J3VM3G1bYnrlOOz7Vm1wshOw0tpeNS02OOzOnKBRsEqcftQt+hzlCxioe+dKpe9W5LECFSqPHUk
 JGZm/fvSB7T7r5uYw4GtE9X6vV1cTia3st5ZIqUkcBbGjEjvbotfuf+Dg7Yo90mnTFXNxbqi+8W
 I9l6YNNP89u35v8EECiO6i+QkLON2qzmpJayvW7AWqLO19yLvav3IGxiNV2bmaRg/QvVoc00wUT
 huIQsY+HXpAskypA0pVdSkJaDzFG5ciXGBXRQ/hJdpVEjW0hqxwz/QZoIlf+cfnhhC33Fsdr5zX
 yBM0QASbHh0NYXGp8T065+rA5Hkvcd5XC5QVvdXnHE9qG4IKT5+Ctzq4xETl8dHWQ9mgzH1xcr6
 D5u1o7ub7y+RY5hyd64yQxoOHlY9JeRJ5/d0sLKhOGnizT4HkmoxxhegZgOM909IC72+zwmnwxP
 QfOA5aBklZoyC8tjPyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120200

From: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>

Add the nodes to describe the GPU SMMU node.

Signed-off-by: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index ed9aac42fcbf..5e76a0d53f01 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3729,6 +3729,44 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,glymur-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 660 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 662 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 667 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 670 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 700 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
+			clock-names = "hlos";
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+			dma-coherent;
+		};
+
 		ipcc: mailbox@3e04000 {
 			compatible = "qcom,glymur-ipcc", "qcom,ipcc";
 			reg = <0x0 0x03e04000 0x0 0x1000>;

-- 
2.51.0

