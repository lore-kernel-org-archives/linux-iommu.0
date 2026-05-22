Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EF3C9880
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444786; cv=none; b=QsDN33QiB2XE2dBvXgIjXadurc4awWH3nCtLci2fEoxxSOhRkMXG3cdXwF1Hz7nh7v9DxzTTm+wp1ehbDjYPNO6p6jfDZpMlxCXQ9Fsiqr4wPJ+AChi+caK2zPJIipzdKOyG/1irR3YSoXCuj469p1vF6/cEvpyJnOOyh5mG/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444786; c=relaxed/simple;
	bh=9LRaMcv2V4zbaC8556pmvtif80qwwMxTZ4+jktXJcsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOVmUsTXOZZ+jD3QyxZ1DVoGhnmdY50k69M6s771j2dmAyCu+h1zt6CcxAbqLDd8mXVQ+kKDy5SS9c7PkGe4f77t2gzlCVNQnmedu7T/CM336O//UHW6FcCRI0ht/e4g7MFqnssLAepAakWEnxY2AKBsVOiGjfaHL/cWfe0edx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I62NlWL+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fQpBRt1+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I62NlWL+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQpBRt1+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MA4AGI3947413
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rOy8/GU3XQkZVyXsjJI4YrGNfteshSum3AiTJPnkXFU=; b=I62NlWL+HLctD+sz
	RbdpGqtnZ8gtEnLvig5e3IfsqmR1E0K/WnzSTvqMmiLj2m6/CmMdCGK5cSh/BCXM
	acKeiFlymox/EyKIIJMzds1mv8hvms9iY2TLGWoEagq3VC2npTRA8CwNoVhHaECJ
	rALL3h6dLHD5QnzbpXdgViGdNfeExl4vUMCVSP13D3+yPcOT6wyXLkEc+x/z3JCS
	iSplzhT2uNRy81QhANJOd9xeMgX5UXSNphM4LUlFJPfvSPOGiWuljPSuFwP/ha5P
	cU8Cey3uBnGW32Cc2H24hN6uvDJCffFrQMPHvG2WSV+b0R/D92k6fBAL5iSxpSBM
	tT74Tg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean2ng156-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:13:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c828659ecd4so3144261a12.0
        for <iommu@lists.linux.dev>; Fri, 22 May 2026 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444783; x=1780049583; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOy8/GU3XQkZVyXsjJI4YrGNfteshSum3AiTJPnkXFU=;
        b=fQpBRt1+G9FJBUg70CFtQuQsybRV7+ummHK+WaTHTrhZY6UwTLrGfft4o2raDGDbm9
         VsD6w6Hmb7+5m79oeIxwb5n67fZ5gLLYd//fq/8X0RiWq/qsz/VurpLM09jlFMAfRZ48
         JwGVsVCskmyQLTkh4Y09JD4//iB+/frtB2NmlkMCGaYaQ2U8cVaEOgjBA+IwetXZQAuU
         TWvelhx43I2ZfefDLXOYX4zDWf3tyqVQP1SExx0CtV1UeKBaVRH2Rlhkn1g+SB74c1gP
         BkWeSJJ3L4bFCmO8q132+WSH71zBptgNbm5QUFhnLFtE08YBj7HXfcVErAgT2goyNkxD
         fJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444783; x=1780049583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOy8/GU3XQkZVyXsjJI4YrGNfteshSum3AiTJPnkXFU=;
        b=nbaw1TSsejRdqLQIaW8uvAOWNfEHH6eglUg5TADKyLXHIgAmt2121N5M+/MSUcXrhX
         Wkn4vlg1fn/XZZn1X1g8ZeQk7hD7iEqM+wgM/QjfFS7yqwoH1n1X8T2IpLqc/9rwgzr4
         SdQuBnEHZtIsECsGaVJ2xSDx3z0Wp6PaPcGziej04WiGxJHtYbC2gpS7iDxql3+aYhdO
         9xfNEOKBa1aMzKdG4rO4DrF24kA7EreuRkyNFg2Wu6of10+XyTraLFzdEdJMzBr5rlQK
         BOqkpCnthwmyxzKw+DqmMef60KtvVeG/f3KFLeP17/x1KxbB7u+G2PqbGEG56k5QqNXL
         rsJA==
X-Forwarded-Encrypted: i=1; AFNElJ+R8GKrkZMauOFcs/k+ADNmbJ3DX6fxpkJsjNJcFVm2zJg7uf6r/n50aLYoWFIJqeHvDUgQ4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0tsyVtAf0k+QTJ/QJM0HhgltoyHv1KSZGnNHwExu6lhugmIm9
	aLM1CoxU3fKv7Ic8OTZ2MBYJ/+xxTiC3GudqAlXP/EQw/K1ajTfirIZuVuN8ZDEl45L8ecYD2RU
	Fll4j/DG3j2LsHZ+gFwe/hgWw5I9gFilLy66mwetO6N6h9PXTUF2GUo4TjA==
X-Gm-Gg: Acq92OGpiZKEhy/SQ5rHveqQoZiY4ELxq+rkZsliLEr7uTV5YBIi98rqxtVl9gi6BOy
	lAmvcAzVBeKKHWrQeVAx8nQoTgnu0EI9p2fPug9lwxjvWIav6ddSAM+zFiG32ITg9ZZjPhkDczL
	PIud3rr/8ZdlDs8ip5ysLjHsxHpSLSqJnW+JETRr3zpE7tbw54qXRb7mICBnXBUnio4a8Pwr+v2
	uKPUVvxB8R91XOFbtba8DjrF0Y2f8zAx+48Q7TG3xmwkPuE9sjH8e1qKUONhG6TjlbonH+kmOL5
	tkLIzwDqrE7CkrArGYQq7nVYIQT3BVxNWWu9ajf4ufbUtGa3b6w7kWMxIfNs3/dLoW+i9RnZijp
	yc91l+zD/Bd+030TQevgE+M37aVWZR5F30m0tZjW8zsGfUQ==
X-Received: by 2002:a05:6a21:e545:b0:3a3:1071:89f0 with SMTP id adf61e73a8af0-3b328c3aef7mr2746395637.2.1779444782724;
        Fri, 22 May 2026 03:13:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:e545:b0:3a3:1071:89f0 with SMTP id adf61e73a8af0-3b328c3aef7mr2746356637.2.1779444782221;
        Fri, 22 May 2026 03:13:02 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b4442sm1143498a12.12.2026.05.22.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:13:01 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:42:00 +0530
Subject: [PATCH v5 4/5] arm64: dts: qcom: Add GPU support for Glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-glymur-gpu-dt-v5-4-562c406b210c@oss.qualcomm.com>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
In-Reply-To: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444741; l=6197;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=9LRaMcv2V4zbaC8556pmvtif80qwwMxTZ4+jktXJcsQ=;
 b=zOl5Y89TsckbbBpFdAJU2lXL8xlzh6ufa28T/1DvnFneuixTugelWjOX7t/1gn4pxgQgmQQF8
 364+zozaWZJD4JlmMOvoAmhkuklertg1pkeCuQafrdtXHBVfOUW7dJD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=XvDK/1F9 c=1 sm=1 tr=0 ts=6a102c2f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=0FMZnqfP4dmqgQdt9j8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: Wlm8ElOE3Bvc13azVB_z_W-Bm7FILyV9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMSBTYWx0ZWRfX1qBBtFTeeHMo
 ZN++jpVzjuQUAVymLdzCdc65KSVZXt/F291CJqydQjmoZRPT9HTFKwOeIsQKSHRZJtK163deJV8
 oxbyNpmDbqA8T9/LDTI/fdSDwTFHwhGp3zFpP9pVVE0iVWk16d8R9j35Oghs0K3es9PjpZBv2zo
 RTI9SKJx+g7cFx22NuF5Xa5prazJkNsXKFEuP8ayktxApy121xVrVBhEXYVNvuVX0LbtXSCjfWX
 MDaQHPf3xjeErHaJLSnnqmiepC1fgj1EE4omr4AE3Zs6b0D/sq8tP5VNrNIA5ApwHQyqRdV4Y7P
 QQyjK+LUWBILvvMZY0NHRrTr4zz38dS2463zdq4ewCnxgSf38DjUeRBRCw8NeaeSyJlZYfUmrIp
 sKTkUctMRh8UTL8GQF4/VRJ+QC2aTmkRMOluH0j2q7X3llG8MlahOc3UMjMy4WymMq49gn70Jnl
 G959O/2hm2J+eG86/3A==
X-Proofpoint-ORIG-GUID: Wlm8ElOE3Bvc13azVB_z_W-Bm7FILyV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220101

The Adreno X2 series GPU present in Glymur SoC belongs to the A8x
family. It is a new HW IP with architectural improvements as well
as different set of hw configs like GMEM, num SPs, Caches sizes etc.

Add the GPU and GMU nodes to describe this hardware.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 183 +++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 5e76a0d53f01..01a2e32e503b 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3701,6 +3701,129 @@ hsc_noc: interconnect@2000000 {
 			#interconnect-cells = <2>;
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-44070001", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x6c000>,
+			      <0x0 0x03d9e000 0x0 0x2000>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0 0x0>,
+				 <&adreno_smmu 1 0x0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			qcom,gmu = <&gmu>;
+			#cooling-cells = <2>;
+
+			interconnects = <&hsc_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2-adreno",
+					     "operating-points-v2";
+
+				opp-310000000 {
+					opp-hz = /bits/ 64 <310000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <2136719>;
+					opp-supported-hw = <0xf>;
+					/* ACD is disabled */
+				};
+
+				opp-410000000 {
+					opp-hz = /bits/ 64 <410000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <6074219>;
+					opp-supported-hw = <0xf>;
+					/* ACD is disabled */
+				};
+
+				opp-572000000 {
+					opp-hz = /bits/ 64 <572000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <12449219>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0xe02d5ffd>;
+				};
+
+				opp-760000000 {
+					opp-hz = /bits/ 64 <760000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <12449219>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0xc0285ffd>;
+				};
+
+				opp-820000000 {
+					opp-hz = /bits/ 64 <820000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <16500000>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0xa82e5ffd>;
+				};
+
+				opp-915000000 {
+					opp-hz = /bits/ 64 <915000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <16500000>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0x882d5ffd>;
+				};
+
+				opp-1070000000 {
+					opp-hz = /bits/ 64 <1070000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <16500000>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0x882b5ffd>;
+				};
+
+				opp-1185000000 {
+					opp-hz = /bits/ 64 <1185000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <16500000>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0x882a5ffd>;
+				};
+
+				opp-1350000000 {
+					opp-hz = /bits/ 64 <1350000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <18597657>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0x882a5ffd>;
+				};
+
+				opp-1550000000 {
+					opp-hz = /bits/ 64 <1550000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3>;
+					opp-peak-kBps = <18597657>;
+					opp-supported-hw = <0x7>;
+					qcom,opp-acd-level = <0xa8295ffd>;
+				};
+
+				opp-1700000000 {
+					opp-hz = /bits/ 64 <1700000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L4>;
+					opp-peak-kBps = <18597657>;
+					opp-supported-hw = <0x7>;
+					qcom,opp-acd-level = <0x88295ffd>;
+				};
+
+				opp-1850000000 {
+					opp-hz = /bits/ 64 <1850000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L5>;
+					opp-peak-kBps = <18597657>;
+					opp-supported-hw = <0x3>;
+					qcom,opp-acd-level = <0x88285ffd>;
+				};
+			};
+		};
+
 		gxclkctl: clock-controller@3d64000 {
 			compatible = "qcom,glymur-gxclkctl";
 			reg = <0x0 0x03d64000 0x0 0x6000>;
@@ -3712,6 +3835,66 @@ gxclkctl: clock-controller@3d64000 {
 			#power-domain-cells = <1>;
 		};
 
+		gmu: gmu@3d6c000 {
+			compatible = "qcom,adreno-gmu-x285.1", "qcom,adreno-gmu";
+
+			reg = <0x0 0x03d6c000 0x0 0x32000>;
+			reg-names = "gmu";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi",
+					  "gmu";
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_GPU_GEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
+				 <&gpucc GPU_CC_RSCC_HUB_AON_CLK>;
+			clock-names = "ahb",
+				      "gmu",
+				      "cxo",
+				      "memnoc",
+				      "hub",
+				      "rscc";
+
+			power-domains = <&gpucc GPU_CC_CX_GDSC>,
+					<&gxclkctl GX_CLKCTL_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+
+			iommus = <&adreno_smmu 5 0x0>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-575000000 {
+					opp-hz = /bits/ 64 <575000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-700000000 {
+					opp-hz = /bits/ 64 <700000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-725000000 {
+					opp-hz = /bits/ 64 <725000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				};
+
+				opp-750000000 {
+					opp-hz = /bits/ 64 <750000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,glymur-gpucc";
 			reg = <0x0 0x03d90000 0x0 0x9800>;

-- 
2.51.0

