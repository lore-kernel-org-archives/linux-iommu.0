Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA936CDF8
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239330; cv=none; b=dZV13lPUJ8gCU/OOS7NrTzwJG3oGTaHE9QW94qiKwHBcrPav0JOlteFewNwKlYni/il8FlniokvSxIpaFaXTFSMWYnqtv6Xs/PMU1ZCj9NjobF9QS8CYcpLCJuGJe+khFmEcU36H8rlnQwLcUjxzVTT2PMPSZB8W3pygIVwy978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239330; c=relaxed/simple;
	bh=VxVfs90+RVyIFj8A0qDzTyazRfecJmozpZRL0X2Homw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUzI4BJsjKarOmEEF62yCoHgPulFyD7lk5ZyrmxQDG5rH+AHmHxQSJCFxkZZ/9aKgohPCfddsLy0w2Cl1UnnUjGmGIxZXO+tAZoDcLkGYvRQmrbHVMJKYdIvvxIFkX+IJKhmIYsolK5RvoE0VteuppvuxxtXJhbhfDltxwidxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hw6Uej52; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eaPTd67r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hw6Uej52";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eaPTd67r"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6650xeYQ167999
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=; b=Hw6Uej522PtLL0i7
	AAjOq6lllFv7kxd6XU77DgLv0U/97Vkz4XF6yNeEzalbgTu1BPmgeYEeTpi1yloQ
	CBNAj58vinX1TxVcisvmbVu9dccnNB0z5ElUpQXwK+r9XRRv9/2iHoyQKSYEWvXA
	eWCKJGepkjhAIp7/RKAVbKS4IKtYxciDkj5YrtrrU7tMI25IvYfPbFitM/xUYqJV
	bO0NBVcCOpXJZuWXQGIjkSJkpf9jzFqyUQixI6IJsWPWH1+TfjTfmcbD1iHP8KYT
	A5wBo0jYfeU/OfUEGoONWXF1bAq30ioHB+KzlWwHdSr2I7MLQXRkR+4VnUKanfpo
	SCQnCw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txej8bh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:15:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2caf4173b1cso33801355ad.3
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783239327; x=1783844127; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=;
        b=eaPTd67rWA9gNkaZk6bsEGQOS8HDw4MOmLE1NnGBj9ZhpV81bZ8WX0w+ayviaXQu5p
         dKtwNLlRX2HE5WN1MWaQTUmScwjXcU9eBDaUmeCoQ/i3mboDJz3q+2+qLA6JPyMn7Lvb
         ke88z8BbtrgKt2rUOBrNBN10aOkNq42Vcrl09NZVkpRwtouKzUM5LA5cFU7Ube4qEoVh
         zJc11dbhWbNc+pDmuLxzpK1azbSmsTt7ohuuoNFK1Zcph9gAtXrIN4S1SqqKTqBHjJve
         qJwjX5n86/E4oaMY4N+2BjRGifPigzED/asauLL6rg9TW6xGnzo1YjyFHmywwCh+JqXE
         trvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239327; x=1783844127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=;
        b=qm7C6U3CpneTzroNhdJdQfSz3nR5Jcq+zn2/XlbR5klLrtBRtDbfThF6k3V+hby+LR
         wm48P9jyFAVG4X4+1p+UVxsE7HLryMDfTMXi1MJvUFIbbZ0hl95la95sWY3Hzsg7NzJX
         EQlDn3vZ8v6Cr7AnLZDvXOR8MCV1cF/CueQyVW6DO7dDAMu8bD2F4p9F7wRnM3/iqfwi
         YPCMDREAeSlSbttb9Erww5/GU5id6oP2k6L493epmJMviSjZLU6n94HMOXzVqNboYLtQ
         GPqQxxTt2BoGgyHpGbC50u/8aQY0mqKbFIiDbKDueyiE2VVmXU7Ffk0TTpuYiJHhirk6
         C6OQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtPQSG+Wty5+D7zemIx0dwvdKpvfvoC4Svh8o+nJxyD31zkFfgkVToPTldwlWA87ad4QxwUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3l226SQIS4hGYuk9bAkrVmFgZ5BdNZd72/lnA3oktgS84aOwf
	8146MFPrneQe/zWX98x9tt130DJ57K1xTbYfH6CUEZ/Suaryl7DlenbPOlSiuw+saMogHIyv6fH
	Gwpp8NTw8dTj7/cKDLAIcoykdZsqFmSWoRB8qJUh0vpXkaGA9lOwkdhw0Tw==
X-Gm-Gg: AfdE7cmw4fYQQdvhxdjeuom4ZbKQ1EA5kUVspI4qx6XewUCWykt5VfsAu3bcZWYyLrK
	z9O00gOhklFBgILA18aIcXn/iaxQteqTGjpf6/aJsSFUUkQEOAhW9yzUNgoWRP0NkjS1u7JQsKs
	gwOqRpM2ebukGeStuIRUFZYMeEISB9Dz3brO1XaJ+WIk5SKjdAT5yO1yC2KTFc5c7B7U1oXFn6Z
	6ZkA+I5nv/fSIx+zZf0EGTHSO5yV3sql3lR9NzAbFnV6c/GyP5xhdlS3WOKcMzOaURT/GutZu/e
	pRfweaP7Zz4KInlSg6lLJq+eCD9E8bMYpijSdmSnTlkU4T726eRDq3567EHHgldbpFjIL7dRVtg
	ImnG+rD45hUdOVMtLbChsiDaHvfERaPL0kQ4=
X-Received: by 2002:a17:903:22ce:b0:2ba:924b:3948 with SMTP id d9443c01a7336-2cbb750dfeemr62830445ad.15.1783239327162;
        Sun, 05 Jul 2026 01:15:27 -0700 (PDT)
X-Received: by 2002:a17:903:22ce:b0:2ba:924b:3948 with SMTP id d9443c01a7336-2cbb750dfeemr62829785ad.15.1783239326208;
        Sun, 05 Jul 2026 01:15:26 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:15:25 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:21 +0530
Subject: [PATCH 6/8] arm64: dts: qcom: eliza: Add GPU SMMU node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=2286;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=q+INaEIUNj0EXeDmcw5Jx9wg9/Og5BIcLTww5DoAVnA=;
 b=MohOZP5BSd7gGPu51pY6rKeL5RRxBoIVIbOgZlIdE/wHpMOl/l34w/UKkxBV+hgg0MnC/fet9
 g1adGQtY8KCBh/oGiWWKyTQqqhJ1+0LNhTQDsT9Ph0U7ePkTzbEp3qg
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MyBTYWx0ZWRfXxAxCqnaAYFl4
 yP5Z7xDU/zMucADf6eWmgwe36yVisUVdfwgm2NxidVK2jXRtZX9W/Hb82P3ZKyFUpojOhCALxX1
 xYsUSsCrvhV3WRJbxz+pgx1FHCfCmZU=
X-Proofpoint-GUID: Y2cKjqD94AAIlwz5ti8ULb7L37-sjWfW
X-Proofpoint-ORIG-GUID: Y2cKjqD94AAIlwz5ti8ULb7L37-sjWfW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MyBTYWx0ZWRfXyJ68GJ+yqctE
 087QDqLKapIxJ9K+3UdabSksTbySYOhRIIoX2lfvuNHGm5KloMmr+465+HBruawlnUtYlYpm1No
 MSBLr8+TrF5hFj0DvlnNuJcds7R4QRGW1aEGzlkHd/Yyxc/j3y7lAPDjeIM1+tiwCQp2CLgvu4A
 lxHoDdJn1kqS0GTv6Zt7eh96MGUZ5M3LsModjaJID5k+kDQBIpexx2gITO7HaDSzkHANZzh2thf
 uDMz9HJcjhdk8GpcpUf2r7Pr+0bCAEsDO2d8l9XEdnyXKHiLzJlGORDnNjqWSO2QXxgJ0ocRBOC
 lN0ubZtdeaLkeTUwb5LiX4mhYtt3qWi+S2yB2+LyThotin28NF/hiDQdjrPez/S4JBZmVHzwoKi
 y3eK5xxsoYuc/M26AbQGtWSooxtzi0eHhDheAPiAHwFkUoTMR4I8MN7yzL2CnWV24sVXkNSQQQp
 kcl4hJazw6gYEMlzkRg==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4a129f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=IlPRAfYEAefbqxDJwzkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050083

From: Abel Vesa <abel.vesa@oss.qualcomm.com>

Add the nodes to describe the GPU SMMU.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index c5635f22e2a7..e5b8377e6c3a 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
 			};
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 677 IRQ_TYPE_LEVEL_HIGH>,
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
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 659 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
+			clock-names = "hlos";
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+			dma-coherent;
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,eliza-gpucc";
 			reg = <0x0 0x03d90000 0x0 0xa000>;

-- 
2.54.0

