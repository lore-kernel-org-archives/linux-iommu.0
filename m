Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D183326945
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110965; cv=none; b=lbUUyOvB8pcwzWZy+t0OtJnBBqRddfhbmdweg3i4dnVx0kbqEfBggWpHeVmuZagZ5zf9+lI7bs2hjoOOcq4AwUhjabo2sHbHBBq6Pv2To7R413pe/tuC4lKWOxsoFuFijZWLfJXXZ5RX2DaHvrtQgHcHCwXCRRbprE3Wzb2qWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110965; c=relaxed/simple;
	bh=BghuoPAEZNaeJMJPKdJFsDVu1LM7cTUOvUNAAtZ7DPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XONQBx6hBb8agxIU/VVBeYmiMtu+85nlDRTGs2elz+eEG3QucJc1EqifeQBL7Kxz8ABS2rOZEIi0/PcG+27Krz94Gqmv8FlkH4XGJUWsx4QDINXttGP3mdPWobEliI/GOs0DzFnE0+XYYura4hHzpDt7fsNnSdjxHO/SZjvWQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kwWcc/aQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CRU7bnCG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kwWcc/aQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CRU7bnCG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPZL11029409
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 20:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=; b=kwWcc/aQsvDhuNvU
	sR7hpyO1eDnpBJVtmAbr9xTdsoTDV/umabqbahre0b6e4XNHuWEDLADYcmDPoIP5
	RVRpYv46JJcuv42nh/uIRPKVavgKEomucpLkYOCSstuaFiDolNL3MwQkgUCjNV1M
	Qe90JQBTQwnxVYPLP8yzo4Bw1UGjwwsWfb8jFqFKnLLGzoVAVbyTHxlAuBsbD7aA
	u/6rEvqbMjy+myKEK2uvwWQQ3FJC46T3e86XyArv/GU96C5rwAGjgJP2wF+sgEgE
	zc/24HIlzL3Oj92i18QWYdBgSptNqMIFYbW+1NEYBR0ZksdatmJ15lBv7JiFgbrB
	ol6OSQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qckk6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 20:36:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-381ed6616f7so507614a91.1
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783110962; x=1783715762; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=;
        b=CRU7bnCGzjiRWrvkS5oa5EYbJlE3/B3DCPCWeD0IpyhDhzzq9k6hTvI0JRWhSGNiVW
         Z1h6vXB8FN0/JPgHSfa6S1XjWG5Vm4RY835FxmMs82ZCyabz/Qp4m50VxazO/hr3GDDu
         uIjx+BivnGw8XKTdEzkDiJ0YW74gLGEORsToAX3NwAEWk+rh81ZwBfQnOTYLFaqwp/WI
         YRyZa3TRHskF9Uv0DiMQwONfhIzrwilit0CxoIdW554pWV3GaON3wTAvdipn3GmqDzXe
         J8Hs4L7QI2Q3dMqsXzNtQdziE1YlyQqVFnxo4bL0AWeT+Wjj0MS9/t/1SQc2rtoSXjG0
         gYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110962; x=1783715762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=;
        b=miyPqr3lcjYKC+vdHGLH6qyaS4G6WZHmguGvmVhbMhxvDFSd8WRa7WXzXQ9u3iPoBa
         ltfe2msY8GM0HTdzpz0UWcsNkCy/A0vWGhSHS6iZxjpV5b1i2ib/VdCLojHrUtwtzSis
         upPAnEQ6a4rLvbVexpYG/r8SSwAbweQg3nHgcFXl4IaL0jJub13QsMzapkb8ljf3p+08
         d6ASYX4zAhzCwLHFweYN1jQL9a2a42sLKSCu76W3MSN8kfEqTRjGkAiGHxBPjCdO6k+N
         riQvG6ZuVbmyPediISeDf6lZKIJpKYOZ+jhfp4yUUMItLGTx1EjmoJDPsInjcqy1veFR
         4KLA==
X-Forwarded-Encrypted: i=1; AHgh+Rpnip5PuOAAXoxCI0/YkXmAknbwmykHO1dXUCB4pIqks/Pz4dKuCVpwQ01XGyNvNijwk04jGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWy53zMex1OZrQRH0tnHw4GMJWKTvIhXNUhvkDKhPw8MSqHNPs
	d80z8KFUpA+fdQ8FkgZ7Hx1vrTvgAwh9n7nFG0Wa5zcDY6Hm1rfArlyQ/NW79AhxFDDFPib5Y3u
	wwx9r4cEpQ1W5fa4eAJAv2tKfxCpUB6GkqXlCNpuIuqCUWqGF9MjEoxcA3g==
X-Gm-Gg: AfdE7ckauCg7OZT+2WizlGSGITL3Nw/z2pXj+4XB5tvOj4BmH4+zolUzCSg3HGXv+Q0
	HhwrYt+ZUweGjc8NWB3W+5cUBmotwutihLD4bY6HCrorY2zFSCV4y7zl5CTpVPe10NpPVasSebM
	RrMlH4dUa7xsEjTCbnbIS2Dl+6LwQol0CbFHZGIpslXYWFjI6ANXWZ5f1kSKHw1H2dHSEL81Nwu
	5EGAGwr9BdsEKXHYgNGtD5GqxheJ4OLta1tFNxVuxs1PYrtUVQmazS2fRLOhLa0MrGSjkuRO3IP
	+9RwaQMXdGHcnydodsc6kGw06XfY2fg1VKSHgab1vWD9enamcoMUcHwUWjUwFXaPf/+F0bv/bGG
	4Bz2Yho/raFfbkzOSKgGOsRu6dzOObIkCwWY=
X-Received: by 2002:a17:90b:57c8:b0:382:1cf1:a0a6 with SMTP id 98e67ed59e1d1-3829f5eadf7mr875869a91.24.1783110962220;
        Fri, 03 Jul 2026 13:36:02 -0700 (PDT)
X-Received: by 2002:a17:90b:57c8:b0:382:1cf1:a0a6 with SMTP id 98e67ed59e1d1-3829f5eadf7mr875826a91.24.1783110961759;
        Fri, 03 Jul 2026 13:36:01 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:36:01 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:31 +0530
Subject: [PATCH v4 5/9] arm64: dts: qcom: shikra: Add A704 GPU support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-5-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
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
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=3495;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=AFPL1mLXpKffrlVn7dhyAuVw3rCpzngGAE8+zg6xtsE=;
 b=ZlRr5sWqKb8250Ap/ksWBqpMq0V4lok4Fs/7+kMo7z64J193DYFwpD+3fTzxPU/vnV3Pvpcyi
 v/N3wBxCT//DPMPx7VhN1Xd25wRLqcduWT3dZQeV4ed2hEg3ZXl8MJg
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: FUbRPZDpWIj-8EDyqC3JJMfi9BEbQdQ1
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a481d33 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=jWRUczSHPS-Ra7sZ8p8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: FUbRPZDpWIj-8EDyqC3JJMfi9BEbQdQ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX7sVKbKAAOt8X
 0BeLIGeycEDrKei1SXmuk5rGFVDAE/6L5qU9eL8N7Px9HjqkFvIGRIEeiDA5jmO9qSR9Bjpybev
 e+XVZisrdsi9xwnaoJOLImeBcpvNI62tsHze8hLI98E/igzjigZ0dfrMk3av1fS45OI0DLzxVjb
 dNxmo0jfLGWjvwf7lSlQLE93IgsPdz1Wvg/QiXd5Fev0M8ZBDWY4YXeQw8Tflqda9JuCQOhTnQ6
 r7c/8nVAq5slTpEDG6uHKvz9zV+y9A7q1b1UDRmLHiyVwit6IaulCz8Ru84UhRdRWdN/Zczcosf
 73oXjWeWn3RWEovTS1y/UlkUeZ7VQ2mhAWYnPwERyfWGiO3VD+d2Ws5HExnd6deGN7C2W9+xrWG
 VlEzEffbapUIridz5tJ1EfqU9KGpO4emUbYk+nm2kwIW2QuhU8ktJJWB9OjSohuiDKbwRuoWkXv
 D3wPUA9UHKxLsgKiO2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfXyDht15eHLHcU
 T6XKpSkt29o2wKSthGsZ+GJjuotuR7xU4ZE6yatk+ZMijUNtp7GYcnDkQ7ki63/ASwlWT6d66CB
 oSKBjBvG80t4FmjWqsDY4v0T/0pfI60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Add the A704 GPU and GMU wrapper nodes with register maps, clocks,
interconnects, IOMMU, OPP table and the zap-shader region.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 98 ++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index bb11e832d9a6..34261221664b 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1992,6 +1992,104 @@ glink-edge {
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
2.54.0

