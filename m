Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B956F42F712
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374062; cv=none; b=f+npVb58L4YpMiuUVd9D8TpG+h+Q3FQlKM81DRxRxGyV/NAvhm/d0lBN/MN11NqN+gXj1V8bRxEdXn+fO0Dqc3YJ6pmoepuEv/8X/Cfk6cHYmQKWfvN4/qpLvp3WrDYekJe3GjvGGCqJHHTUnjgl4Wc05eg+T3Ph4GM71fGkWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374062; c=relaxed/simple;
	bh=u0V7GQzqEDNpecJi/Mrlfyjnpl1XHgYKPvh7ZJaslcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqnacWhxEqThqrS37gIWkxzAgVNnq1sCdr5O79Jh2ylPsV1Cfnv2PUoChv3QgzFkT4zIef4wlWJxLrjkv3RbiO4QwD+73l8qgpenbaOkGX4ktqsEnm8B8RbE4Jajyfy6MQw1C6ckUwZASUpRnr1gGzFq+bfAHl9i1/1RnCKDNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ceZjQ8eB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y6cKGnQ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ceZjQ8eB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y6cKGnQ0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KE3BF1650804
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fkXnf93yLRWoLQTfGMAiyn37G03qiS7uTjdBHZXSW0k=; b=ceZjQ8eBnqJyvJ/n
	yODW0D+GvmdiU6wVotMh8dFHnitj/J9b2rykVHx1hMIlo6l78Eg/RGEZdY/S85ZP
	eQWhwktOgE0fMKVx+pAsrYvcwOjivisetF/2tV3nn349JI3RAyDxYwG1RuZ7LeE/
	/mXXFkWArw7P508NXBDPdpu1CBETqAR3QEgMiihW0ybfhhBFgHRf/3+VZAmIaRT5
	JB0Vs6NYJKkyrZXeowdCoSvha5XAus1xmlH4gXvwGFpXnYFFM50QoU47z1wv200n
	VgygfrEsUrW+4ylZZBvVeUjTHwN/j5L0OtxjPeFoblqOkecHZ6Q59Fa2ECbS+K8b
	3Sj/kg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgu5sg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:40:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc86a9ef97so38071015ad.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783374059; x=1783978859; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkXnf93yLRWoLQTfGMAiyn37G03qiS7uTjdBHZXSW0k=;
        b=Y6cKGnQ0IAGZx+/DTcZBVHJYHInjBCF/wL/cbYF/wyx1blK4Ut1Ytuynnd7SAGZO7f
         Y8+08yv3h5+ZEk+5ZgOZkBCrQat57RftH+kOxOYYruME/MbmTBYhDdr4cEVcECg4op0w
         OC/F9LZeEml7IffrmmTOh/WvKBgAisF8jyHIQNVPiLMb76wy2yx0RaqmB2ob4ZMLWSn7
         64KvOStbrNCWx2zYyKcIdlPLtOfRplsngkb16lFyYko8D8/e2kLB8ic7klLSA/jXlfZz
         cOxfkvKLe9KtgWe65fkAT5SkRWIu+hiVAexCCmGrornVcBNYtEpKtHe0yAgnUlOOp6us
         G4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374059; x=1783978859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fkXnf93yLRWoLQTfGMAiyn37G03qiS7uTjdBHZXSW0k=;
        b=Svp+DEEHZux5g91dMjqXT98zCNa9p8PyD9c8k50qODGgsybkD01XWco3ZIbEi1jfOc
         gpCFfNAcAq+EsxOz7BB+mPEvIVrXAoW0TCbZNRthOWIbD3ZwbR8lEqq1YAv2TZMXXXWa
         pVJlTwsJMNFthNykZCqneCSE0HxBuvijjToCtp9/HtqFjG4qWK++JaiqnSf7ulX2UnJr
         4FkWaNuJo5X3UIIkipacPn+awfZQ1oUJ62bH3lpTS74S+MGFUYqR3j/lRNIDO10YQlwz
         1Q/ERR+lsQHx6o3G8M557P13LOEk/FqRknT7op6sMIFOLVmwj8zmyD2FA5IER05hllT2
         PZDA==
X-Forwarded-Encrypted: i=1; AHgh+RqcQF5pqxkDBGkMUcSqMyf/Z3bR/MfqSQs+JA0Vz4OEZWA0LWuFsJdgDIe6K+iQLz9HoPSoVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJIKfFcEhWqoot67WzoHlr2kwPBVV5LYoMP5jdHrcbGGDkUr3D
	K4WN2lbfil223Oon97c/ukhOj4cNsdj4R509Z0WjMtfzb2Hi222yHimvujlxSMlcDSmc10lSUWv
	wpW0lJ8sY1G41ki0Nzz+tFrn0Tj4Um0c6OKUvOwwJe9Qree0+JFQmhNfetA==
X-Gm-Gg: AfdE7cnCx+c2ed/72E8SFaKtKpBCC7cp6pllIqLpEscwEdPrg3S4PiCsTXDzAsRYgu0
	KiWbDb2Q/jOMqfYP3ooSi+nHKhkW8vv6JABEJVqPY8GyT/D6GIcDB23bjYhx/v5T3X9FJldKDcZ
	IqSgz7TXG/NXUmnKMr681K6Ga9MxR2tvT3ZiHMxehtq1Fq3iU4B4yJw+toy1w+/DIXgCrlOWk0P
	lCeKouH5aMygtcRo+3W9ZAFt6GcmiBGrfzjdfAPp6TfGivhShRIKNDnr2gB8p7ymqig20hpiDc+
	6RDQ/B9rVJ9mFKEpQr2NnPO5VsS8t2voD7aP90aRabtIEPjG4LqXmPnxeWdpnJ6XSCvn4AOL3QL
	8cxJlQUwJhZDqqKZsY+KTIjE/E2vzRiAmFtM=
X-Received: by 2002:a17:902:f607:b0:2c9:e835:ac67 with SMTP id d9443c01a7336-2ccbeb1e2e5mr25480815ad.19.1783374059377;
        Mon, 06 Jul 2026 14:40:59 -0700 (PDT)
X-Received: by 2002:a17:902:f607:b0:2c9:e835:ac67 with SMTP id d9443c01a7336-2ccbeb1e2e5mr25480395ad.19.1783374058879;
        Mon, 06 Jul 2026 14:40:58 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:40:58 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:20 +0530
Subject: [PATCH v3 2/7] arm64: dts: qcom: kaanapali: add the GPU SMMU node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-kaana-gpu-dt-v3-2-8dac9a60dd5c@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Qingqing Zhou <quic_qqzhou@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=2533;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qEe8ApyufGdls1/59eRBgE6mt3fqa4nJlBW/WwvTUag=;
 b=LMc5mk+WE5iV1TaH/olVocdEf9bvwVBig/I7ERonQcpX3Z63ura+W+n63vue4peLfqeMvQt0W
 tZxG2RqFMvbDzM/WCwXmBJBo2DW8B0e75hW8EtxLW8A48IujYbwUZN4
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: RpZV3aWSXPc7vh5b82dzT9FT3S_uyVmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX8k2ftEAW34p5
 C0pRYQTi0TAn+yZ14sXiPTWmGiiKD8zG3avc0rstmdvZ4BH12H3vQi5CIfz4pHHfHg8Tuf4Auiw
 seRp1iFnsbOhRNTxh2TjA3iyB/KftXunR4wXNL2TSyUvb5GQ77sHn1qVLQHEf4Cs1N4lyhHjO8h
 h0huBQYq/ZP4KwdA2hmZC7eN5kIV1oIJg5o19hD5zcFjyAoIwtIVtVM5yfiOhMcOGa4RblgFoCp
 icCG8zWe3otVrf1ASpaviP0FcQ6nhjjoDMfXeK9nMCcMPMoohae/yijuq49A1BP02dbdrq4Tgbh
 1vcCn/M0k6NsmyYfPDLPT6CGF1o4wLIU69nyLF5PT1kuxBvE6bHM/PTRT4pBWR/ZhAeIyziMkD6
 we1h6n19/55RQ1sGiLSd0BpinFin4N/EEtUxJJFcbcrryfUTF2xZApum1xHuVPl2kf6X2qLz1MU
 UbNzrbg6XdnRqr2wrIQ==
X-Proofpoint-ORIG-GUID: RpZV3aWSXPc7vh5b82dzT9FT3S_uyVmG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX6jHphbet3cm1
 cl9UNn3t1W6XUGdxDAfVGWkqtmxSkgFXMFZXyZYYvFHoxmoOruTjJml+XUSkfSV/mWhyjnsMtAT
 GUNjzOfZwxJe/585P15j2BlHlxHuE2g=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c20ec cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060218

From: Qingqing Zhou <quic_qqzhou@quicinc.com>

Add the Adreno GPU SMMU node for kaanapali platform.

Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 7aa9653bd456..a41962366941 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2601,6 +2601,46 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,kaanapali-smmu-500",
+				     "qcom,adreno-smmu",
+				     "qcom,smmu-500",
+				     "arm,mmu-500";
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
 		remoteproc_adsp: remoteproc@6800000 {
 			compatible = "qcom,kaanapali-adsp-pas", "qcom,sm8550-adsp-pas";
 			reg = <0x0 0x06800000 0x0 0x10000>;

-- 
2.54.0

