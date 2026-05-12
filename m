Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1435F609
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613753; cv=none; b=fYuFl3QnZ6hwv1whNOa9PLRjgpPZgN5+bZindwTdroFaMdkv596EcGLfVbmWyyYOG5WPYdgabn4aVs+wTAN0grbhSDc6vkc2zqXIftNaAsmr1dyp/Pg69sEuuCB7GcYaXPZjb1NVHqaMF5d5bdzo+m5/r/wEVb+SnNs/JQrHzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613753; c=relaxed/simple;
	bh=9LRaMcv2V4zbaC8556pmvtif80qwwMxTZ4+jktXJcsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiJb3tW0TH+YIhE07/iECS0CacUjLIZ0tJLeLs3CBNnr5k7B+B2rE7ag3MlmdR2xsFV/F6nd/31jo8szFZoCPjtsCW7Xy8dfBXzYOHNPYe1thbW1Wb/ldbvmt5hyvejXKaCUUkT0mKRldlE2l0ws9+J2i1XaQj27gvn9gdZP8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KbmXYF26; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aqkDf2Cd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KbmXYF26";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aqkDf2Cd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CIs0YP1058250
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rOy8/GU3XQkZVyXsjJI4YrGNfteshSum3AiTJPnkXFU=; b=KbmXYF26jkZTborq
	T7OldvLD9B+H87usnK9ghy9C/o7N1UZK5iRHrhjNqhHftGGhpU7kcUwmi5z0I5TC
	kwpct9d94CJ8j1VUorF8nsetRO9k1Wi9fBMMLgoosg+0JQ6Sbpc9QcAsmNupqQsz
	qPZ23L88B76qF5B+dkIYpPNw1ptywphk762jXjuTVdYBV0JAfWf6VWFAIDc0h9RN
	hKzDyYgBHoYE1TxCzboZJn6/PG/RK/bkYYXoq9fFigbq4O2p17Vmd3gJANI/iE/9
	aSFCdurpY6R+O83x0Q1Siqfz+60SnMbB8JPt/qZpCR7+UNPJJo7UatrStGD/WLch
	ijumuA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vx831g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:22:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba6ca20ceeso65375435ad.2
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778613750; x=1779218550; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOy8/GU3XQkZVyXsjJI4YrGNfteshSum3AiTJPnkXFU=;
        b=aqkDf2CdHUVh/d6+UsVqhrYSl+4A+f7UmzHmwVpFzx7YtWPGZXUortAAiha68HhlqQ
         lGICbn1a1n6Wb9tQmx5pPevbT1UDmwVhVoDcDkcS52iLEmzM5rq1D50AP97DaS8ZE+8t
         Ltq41MggtfZieI1H7O/eITO4A9BEiyMPqNJZs89p8vDR7x4clgxS7mub2966aBUHWAf7
         ivEupjQRr6GjH9m4Iz/6wIz5LQBQ2Ijn17drYrHMXa4MGLoM9OyZ4Sab/yCsHanny/5Z
         n7jr0G6obO7A4KwA3Icn/EPy/Fw48boDzBCErLSsaGYJFZRmUiC6cWjWsayPqPG9Qdmf
         NtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613750; x=1779218550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOy8/GU3XQkZVyXsjJI4YrGNfteshSum3AiTJPnkXFU=;
        b=rljGL7BQXGfTVSEY9VJiWwsa8VdBwcB0toabJAlLUHXLJt24PNPZRuM+NmAqR4Du3Q
         OjFd3K2hjvhibPjJ5pjo9CxKNq/q8lvjs7WtpQlMr7TGPH6Gu6dcmklflxQMgiAfqAfe
         qVnuVE50RRNct84ETok9oTlvhNBeK/Q9OtsXy28hNIpk9fulVOFDpezk6LfvEWLlVoEO
         z2Vqbl4JPAClMiHtnu8QZJwmvtKCfqsMTgV7oi5BW3YmDAwzLaImNvut9iwxGdDpRi+A
         dNqJsGCaOWAFr0JKSl+quLL3FC+w6BOnGYzapI0+Tw6BXtCYospXmvIe9WurG+/53g40
         T2Ww==
X-Forwarded-Encrypted: i=1; AFNElJ/EvhvkRateXDywB7tbVnyaZ8BUiCnNhmGOolEI0F+HHAI+coUYURhM7e/cbUZtO4uiCZVVsA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2OLuiU6qghr4N/jMvTSZgpsSkUKY7eclv5OFYtAdSx0CVdRCO
	EMCZkskU6jthfMIAbYbWawZdDAlleERfZqgER4cOb5fhoqx7GVzgIWmEUZIZweeg242fUsfr70w
	ZYz9Pk7pgxFkwg04dGa2EBUhl8Gac14jtKzNrHbRQZ0NuZDSHXjwz3jojCDuQyIhy1Q==
X-Gm-Gg: Acq92OHEBc+l4mqa3y1Y67CJffTvjIP6VHyxe6kqqCOUiVPOvW+iqkOEgI+csGzyLWM
	WbqQP6WmrnCGA8PdMjy9p7+fwJ6Ydm1N/zujSEL8ClD3AJouJreydmLjPLjsEqNsuIh8IhhlTRQ
	DF+LZR/JOKFBHEh+FLxrMX5hp53eVbuMPFYNXdtrPL3MhmobylQhJtgR433Lon2WBGTP8ZZhu32
	CuFmzNqlDfBRfMtorthcGhh3KloBiPgy1GUAs+wJmgXoi2xAmgs07QqRuHf1oMOjvEkOcCmHOyD
	Dh4fgovGgr+dgM+97cFuvbG4elE8SDE/omxVugQERqU6VBW7n6RT5mdroFDw+n/r/ks14zsPWLC
	p/HY8wNxPPfSF6tazG/YJ9sZ5wN/wJKAnj3taZMHiCGh2CA==
X-Received: by 2002:a17:902:c212:b0:2ba:359a:9b8e with SMTP id d9443c01a7336-2bd27158ce7mr2590205ad.10.1778613750257;
        Tue, 12 May 2026 12:22:30 -0700 (PDT)
X-Received: by 2002:a17:902:c212:b0:2ba:359a:9b8e with SMTP id d9443c01a7336-2bd27158ce7mr2589825ad.10.1778613749747;
        Tue, 12 May 2026 12:22:29 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ead90asm141250585ad.72.2026.05.12.12.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:22:29 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 00:51:22 +0530
Subject: [PATCH v4 5/6] arm64: dts: qcom: Add GPU support for Glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-glymur-gpu-dt-v4-5-f83832c3bc9a@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778613699; l=6197;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=9LRaMcv2V4zbaC8556pmvtif80qwwMxTZ4+jktXJcsQ=;
 b=aUPShhONF/japFp0uqBBiDWkPvDJ4KKEUUZwLBz1u6qvmwrCImFqhj18AsumEzjekdmQqPZ/D
 nntBRpV6MzaB3hZbAiZP7Q0Nh8OGhxlLYapkDIsMiybEHFhTH0X2v/H
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: Q5g89BpqTxJq-unzhKawNKOYq6Nq1XR7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfXx03uVKxMGfxA
 Thmj42Lk2Taw90Lcb52iLjlTB6hsI5l5jLSM0ZMLqs37TbjdJABhC2yAjGiOXpsxIbRgCZcVesP
 cMc6dT3dfSB/AkREwyisi/XP/vOondAsbEEhfQCu0nPnC0apqmxxzm26K8bHLS3aI24go+uL+UW
 Z8kXnJNvqqkfUcT8TLwDVR8Ew7TdT1WsHM6N7FsxK2XU6JKYCVQNJ+FIgXfFJdg2moB4wI2GVl7
 pJwt4C7f8PyqcPu2nzxiIo9xWSUW52uPkA5+/PV6wkwxCsifPsxuIrxsWjvgsdgL0OzsaqHdYa3
 +5RlnpA7Gba0Rv53J2Bn0RsYfPXxHdg3L+MwS8J5DP4qKX3I0QFxI/+x/JedmP8fTJGZ4hvMGhC
 omNy8QmLpVAdLFxiykStNaorrYMlsCg4gp3eazAyCkGCj+x62TX7qjf3biB4V4UI+c1YgHZZIil
 z/sdK9etc3O07tooUPA==
X-Proofpoint-GUID: Q5g89BpqTxJq-unzhKawNKOYq6Nq1XR7
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a037df7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0FMZnqfP4dmqgQdt9j8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120200

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

