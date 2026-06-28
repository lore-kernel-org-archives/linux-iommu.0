Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58030C360
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671109; cv=none; b=TlK9EipZQ4XMoQPB1d7RWismhYkkv1OKu795KOc5xAICAIHSzihVZLFtaMpoxyNAKBV29x0IqIbkN1YnP8Oq28a/ITNC2AS+mtvn8rhjl+pn98kRkLZbFt+ISajsvQTCdxOAaiNQwNlbqepBlytyaQIFENwrEIfjSKLMq2TmuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671109; c=relaxed/simple;
	bh=KiQ1l1ncgJCQ6Ugven9VjtURkvNuqAo8RkZ5Qz1K/48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcO8iVN6Z1XbfjdlMUODfGugkYPD8JG92BlkGKDOkEdS+/xRVDLNJ8RyNhMiVc90EuoLbNs6mWXrIEOF3/5ICsbhd1ShJbMzh/KO23LcdUtI+adaO+iMbEgEexzjvLyliV5EZAFCu7AoKS7PqBMDHPyDn/ylHl35fdZsmQ7prd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OZgboEVu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bpXODj3x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZgboEVu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bpXODj3x"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SHihFN410904
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tZWd8W5XX7/HLNdwSpAX6KBOEbdxtoiIAFwHFv69UFQ=; b=OZgboEVuxMcDN85i
	Y5Ji1oWho8PfMGeIZdEbxjJ5YhcbiRGlx1BYYIadY0gw1ON+y14UyGDxP9tbV0PK
	HQi5qL1YHZkIr7FkYaTYWSeNBj3qEUFlot/67+zbO8oIxIVTMh9LdMwOu9rEElbq
	ikEo/IyDHF8/heK0jFMc6LViM6UUyaTbh8LxyQ/4NTmczhRH5Ry/8SRzS9TH+uVS
	NML3evCLmknzYfoGaM3xtTyHWe9PRWKTydf7LxMGmXTnO6pBar/pudLP74K3sO06
	d1eiWBjT06OBmioiovGWr0jppBEvimC0TBPwiNqkR1O9ObmskJ2f2ljbZFoInebQ
	FD0Keg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6kekd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:07 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c62861b3bso8507471eec.0
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782671106; x=1783275906; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZWd8W5XX7/HLNdwSpAX6KBOEbdxtoiIAFwHFv69UFQ=;
        b=bpXODj3xu8Ruto+Boy3Y7pEt8ejlya8x/TrDo+P6mEnIZ8GtQCUsfIY+i9woX/S+mN
         L/CB09IqfR8YmY1svflEfWkvB2t+oBJJxz5220cBgi82HPtMwbJZdL/NnX6KM+LHoJXQ
         93H69JzL/klv+vJoRBuX8YDl+67gRMfA63+b1irCcM4WZf0VQqt1XyaRGZm/4bhc4EiK
         V/UUoiakvdEQBu+MMSRAOChRFKhM7fJsFEFWrBvZOw+3Y/p4VZORV/3+7rn9LjOav4ZJ
         y+i/oBqFqGyccLUgQPnBuHfDTvYZzcrtm8ESP7eTlc2qumKklrLQpyYBhFMDaj5AHHNg
         qTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671106; x=1783275906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZWd8W5XX7/HLNdwSpAX6KBOEbdxtoiIAFwHFv69UFQ=;
        b=VNa5Kyzy6ENq2cwEy+i1GBanFSbBdQ0cLLBIbRWyo+71uWNKHJH4hcM2xeMqQUKte7
         l0jG//SsphXRPOB6IHrRMMwKbKjKTxYqY9hOq9xbL8DvFfJ+nqRYJNyofjZzVZb28wSX
         Yeprl0ZHOgXZapKa8wqMn33xQ3X1WOJOAnb+206WvybhYpbiM4v6hpwryg+UXSSD8+00
         uusqoSG24ex2G1L6dmJxa8lDhV7Pl7GvePYVj2fR9rvOxFr3KIeMjPmb9a/HFinM5bCa
         fS4nQm5hpnLe3/LmAkD6e75MgCiV9r+qpxyosM9zleSDM3e1bNGS/7lkKgHJNTxjlrcI
         9WwA==
X-Forwarded-Encrypted: i=1; AHgh+RoLV0kxRn0UWkJ+pRU3BZgHPWiNw8jWQXuM6RZ6+KUsyA1JR95ozJ/qxr9Dg4K7i3gidThpOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPygbYYjAOrHUJaU4tYhx3tuxOFavXbjZweM4JjFIPDyntMOio
	ZQpu5qHg+ZG20AAwpTb87Je/3aWX4JIm6iXaDcBxUjUOisL2xrUnZ2Ux3xptYbCYWRj8W7UqZSD
	DfHGEzr85PhGjeYHOzwhCYn1a4S5SzLmJtTeCMSK4paapSL2YMkxcYl0eRQ==
X-Gm-Gg: AfdE7cluv8qJjFEsUYYh8gRuV22hTqihGmpf/5/cpck0hC6LCbYcCYjlr6I88VAbaOt
	0fkdu8/r6V+4dF+pbCBNQPyizXhREpqDvdNeNfpGE/ldNSmO1ur1g9ZzjIRlpe1qkAYucH8KyVs
	voqnz1NpvZWFB1+XzpDcSFkBkV2AFF1NSrSrCC9o0mCAZvBkK7qCXHjSyEIjW+T8N1AFb4v99YQ
	4HAaQdJdNX4tLqphe6CL1op4VkP31BDVAvNZytTMEbNTmh2Tdv5o8vxMdCXbBKcaEkCmhOAXgS5
	bMHApnbXV36l0bFCmgmueGxGwC4PxbjGzqA+ro9TVcZg6FDCkWgVGKziEnPSvoyK7Iotd9X1fxI
	Sk3H7A+aqyOOQ6TRJ7xVJfB7GZ4+9WRZ6e/4=
X-Received: by 2002:a05:693c:6383:10b0:30e:c2c0:a7ea with SMTP id 5a478bee46e88-30ec2c0b39fmr1605931eec.41.1782671105997;
        Sun, 28 Jun 2026 11:25:05 -0700 (PDT)
X-Received: by 2002:a05:693c:6383:10b0:30e:c2c0:a7ea with SMTP id 5a478bee46e88-30ec2c0b39fmr1605909eec.41.1782671105369;
        Sun, 28 Jun 2026 11:25:05 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:25:05 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:58 +0530
Subject: [PATCH v3 5/8] arm64: dts: qcom: shikra: Add A704 GPU support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-5-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=3396;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=esFO/JAL5nI43vIKxxFbdEl/5ME/PRB6OGuZfuTuB+I=;
 b=cVh4g1YdCpiwy7z9vQ1tG/9H+36qvoH8yaJMvnRIf/86r21odJv0LC0eJ6esfGD/OIpgsy8dl
 bSGuHuQPLv5CJuKWNam17yWd+3YB9Sd4PLC20Ocorpubqx9Ndcb9TJy
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: VnwGBevZAtJUMQ-8n5Iyw3xnfPo5daO2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX769eawWBWkMD
 v0BLd7CPSwekyVhN/fP1DAr1B4Io7dovujzwxtC6ETvObbr+ruXiCC9+Zve9TmecOJQhu0Y/7WJ
 z3zMi1HKYSVSyepW1z8FE9YKgMnEPoo=
X-Proofpoint-GUID: VnwGBevZAtJUMQ-8n5Iyw3xnfPo5daO2
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a416703 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=jWRUczSHPS-Ra7sZ8p8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX0SQNMqvSrs6k
 mwxxO7Ci5R6XL7v2sNU63R8UgEotKp1C8eslOEbNaHJA6Q/IZEhaDm8pHqHRlDjs9XaE59XwApA
 bPfhgyDK0tpZWJ+JSOmvlcvZSUZhUvwYKheCxyjsqK3zpPvkkJeSSKwACTts+8B0AM4WsaB7vbq
 HWxEZabcEOSRuF00zU0cWkUeD4kIL5yK0e0Yl7naxWdydunFLOobHPjMmNUgwsInKrK9OZt9ayh
 oO2uzIPU2Dh+HxePjG065L+k6k4Dv8shaewAQakZcM60uli2015jQf1rbOhRd8ZM3BzafhPmNJd
 Il6opSD0iQflkn/skOe5sH5gnMVx7ef4YJ/tH2A4fNzhYgg0U5zlvg8ARumd9zzWHzKSF0/aS2/
 tAsl6dCJ6QxTorY0kCzpHUfTt1dWuqAs0gfxxootLKIiA3MJRoe4HHYP9MER/tbxMMndmgUH1UI
 AsL3UTbSq2FsPTLIfDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Add the A704 GPU and GMU wrapper nodes with register maps, clocks,
interconnects, IOMMU, OPP table and the zap-shader region.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 98 ++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 398cb1a4dc86..89cc5dc767e2 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -642,6 +642,104 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 			};
 		};
 
+		gpu: gpu@5900000 {
+			compatible = "qcom,adreno-07000400", "qcom,adreno";
+			reg = <0x0 0x05900000 0x0 0x40000>,
+			      <0x0 0x0599e000 0x0 0x1000>,
+			      <0x0 0x05961000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&gpucc GPU_CC_GX_GFX3D_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "mem_iface",
+				      "alt_mem_iface",
+				      "gmu",
+				      "xo";
+
+			interconnects = <&mem_noc MASTER_GRAPHICS_3D RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+			interconnect-names = "gfx-mem";
+
+			iommus = <&adreno_smmu 0 1>;
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
+			qcom,gmu = <&gmu_wrapper>;
+
+			#cooling-cells = <2>;
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_micro_code_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-1142400000 {
+					opp-hz = /bits/ 64 <1142400000>;
+					required-opps = <&rpmpd_opp_turbo_plus>;
+					opp-peak-kBps = <8171875>;
+				};
+
+				opp-1017600000 {
+					opp-hz = /bits/ 64 <1017600000>;
+					required-opps = <&rpmpd_opp_turbo>;
+					opp-peak-kBps = <8171875>;
+				};
+
+				opp-921600000 {
+					opp-hz = /bits/ 64 <921600000>;
+					required-opps = <&rpmpd_opp_nom_plus>;
+					opp-peak-kBps = <7046875>;
+				};
+
+				opp-844800000 {
+					opp-hz = /bits/ 64 <844800000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-peak-kBps = <6074218>;
+				};
+
+				opp-672000000 {
+					opp-hz = /bits/ 64 <672000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+					opp-peak-kBps = <5285156>;
+				};
+
+				opp-537600000 {
+					opp-hz = /bits/ 64 <537600000>;
+					required-opps = <&rpmpd_opp_svs>;
+					opp-peak-kBps = <3972656>;
+				};
+
+				opp-355200000 {
+					opp-hz = /bits/ 64 <355200000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <2136718>;
+				};
+			};
+		};
+
+		gmu_wrapper: gmu@596a000 {
+			compatible = "qcom,adreno-gmu-wrapper";
+			reg = <0x0 0x0596a000 0x0 0x30000>;
+			reg-names = "gmu";
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+		};
+
 		gpucc: clock-controller@5990000 {
 			compatible = "qcom,shikra-gpucc";
 			reg = <0x0 0x05990000 0x0 0x9000>;

-- 
2.51.0

