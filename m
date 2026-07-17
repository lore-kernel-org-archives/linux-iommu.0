Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE33A16BC
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784320974; cv=none; b=bLe35xSBAsvdySgFFyWaV9JZGRfcVVb/B/Kdx88iA8oyo5f14qfuh7O8plBKVVEOiPUMGl/XUM4UJCoQDIo1z4/Egj4hh7fX9dCjs8LD6o5bQydrytIT+t9QAOJP7eLGFNStSa6KWyrcuWgx/ygbkW0pS7nAVVQFB+352831gK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784320974; c=relaxed/simple;
	bh=vQlIcgFAKYX/5ZAZklrZCNWjazzEwZ+v2QyY+72sT2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfkA3xDYR6zO976ylcbxR0/gLmxJ615pBOZrit1cBkWyelDiFEbSiS5XF3JzFUwgm6dZXIl9U9NyV/x9ybgWmKKQ7lAI7mj7JjQ7dugkjq9QWpeyUKoQM+TgLWBwS/ZjwiutiOD5F5+m6PGRmtRXwDy14qNLsDDSqA9VZeFHCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l+KULMYp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cTl5ybqu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+KULMYp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cTl5ybqu"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtZiN2780289
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p5EABLMYgrPqX+e6g9POPOLdFY8Rck09SBi7ZSFcSKQ=; b=l+KULMYpfhx31Xm2
	SEo+MCsYLBw0rqvsugbSuJE3U8AVVu9n7JQbKyTOwTopsx0Baxebl2TPoyQjTWgP
	ndTlv6auJpOfA9jfxYIpbn8Wh/D2dNzjTyRQMEUzi7uprVcvljwUkw8NvlFnZVaO
	2jb+MQggIjV7J/yERkZ1dw7e59EITu+O2P2P5uMNzvJ9rAFf+0UNL828GGRz+7VT
	Krbn6NkPe3Gs7OjPVJnBpB3duWq19K0vDf5Wh1HsE5+BoAUeKUbKomCmqeRdy+UO
	RHCBCGd6QD5xP94aykQe9weASI0/1dW4vQ+1+In5Hfv3UjgsZb9+k8USEkzfoFl7
	aBl42A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gu993-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so11025802a91.3
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784320971; x=1784925771; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p5EABLMYgrPqX+e6g9POPOLdFY8Rck09SBi7ZSFcSKQ=;
        b=cTl5ybqu6twpeH4XKvoqhWk9A8MeILjTkn2mIEGzZfG8LD1qBCmwSYxJUq1k168Umd
         vjwDycyVH1VTiaIUdx33Fn8yVZgbT/+l2dxuBJ2VLlIpWz3T1oyX/NvE0w65Jy5DEq4K
         x8HX7nD+MdwYcSKY7Heg7qMkCvWQAOl1SdCXy47bUfji1y1haugySYR76iAPRPpoHhqf
         kV7H52Pld8+/kzPMJRLXUTCchDoSdSCLTGu7Cqk0IdbdWHSr1XtZILH5X5AQk/vQAVH8
         USF3A90H4YDM66Y2CdpdMTBmdinpWWJUDee33UYj/iHj870tdDtFUBUAUWfBiAAvadiB
         7i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784320971; x=1784925771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p5EABLMYgrPqX+e6g9POPOLdFY8Rck09SBi7ZSFcSKQ=;
        b=ATLX7HcLy2Ab5IFBiLFGbXHyJrrDW7lmXYYlkf+aLLMPtVHHeNtzKr8nn90cVGtHWk
         XhPoKRqUYQWtXqQi1WbQqV0f9WJOWQGAXkXldgknPIRkaGguxtYAYJCwn0jr9B+t6hWV
         4KkX1ggg49+KvJGBh8A9D6me+BHGKl2sJV4VgwZBZrwCs18ed6S47QrVfLX3FXe79pDp
         r5FXII0tbZYdsGpNUbHVZlSOluQM9BUaArwkva6xsY9JYNtoTrvobywzjq52AYMtWEMK
         o3n7oehdqPEGwNdqi0O+JbMVBJ3CIRHHuj16teQ53oSEPKqF9xR0SXhSxu8UdMgU+INb
         fUwA==
X-Forwarded-Encrypted: i=1; AHgh+RolWxpNzxdU10g4ADFHfND+FCHcF2bA1jvmz1GUeXuYLlOcDyUcTuPpQpF6sfuhQoMLNShQgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDxgG5f8rXl8JcMb+mCfGmAcgu0MoD1LUfwov3CIiZ0DwWkvNP
	GBwyXXu+mNID7VWsHcoRxGHgM4kWpBGPn9kUwuB5L2WCA/EerYStQ81b4+U4TDCRYhBGDrbE0aY
	eayizHdEPET1pnEM8ZHcyLeqsAC3LtoPM39ad8uxyFfGDL7gVYzUku6FrYg==
X-Gm-Gg: AfdE7ckfxm1RR48Qz1arTpsdqvhgJ9HypuQO6IUTPlGJD4TgAlNaHLx37NFD7OxIjMv
	X4zJqUP21K+PWUda6+7j5C+qtTksxaeXZrUEF8R7jSurwmXIbboy320J7iwLfuVaI/vqGzXtRN3
	W+K179e7syu+GWKiodyZpP8kFqyrYty/+3Ie7vBUxU4NCWK8SF5klPWVricr/WJM82ZXSAVNE2k
	2GOWaVyrLC3AWgWvhRc8e5LNxO0jgl780ohoGkB2zw9P4AyN/yoPixl//VfgYJ/WcbIR43qcUUB
	c9RGZMBs0D0YAQ0fMZq0uerkDyv5Fuitpat56qm+SI9VBa4Rkm5hF+8fA7Y2pTWFu+5bGRjEBTW
	3ZqDgKosgRcBUH2Y6Kma3JwjV
X-Received: by 2002:a17:90b:4d09:b0:38e:2fa0:491b with SMTP id 98e67ed59e1d1-38e4b594eb3mr4384629a91.31.1784320971047;
        Fri, 17 Jul 2026 13:42:51 -0700 (PDT)
X-Received: by 2002:a17:90b:4d09:b0:38e:2fa0:491b with SMTP id 98e67ed59e1d1-38e4b594eb3mr4384579a91.31.1784320970601;
        Fri, 17 Jul 2026 13:42:50 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:42:49 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:32 +0530
Subject: [PATCH v2 7/9] arm64: dts: qcom: eliza: Add GPU nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-7-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=5441;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Tc760x2HSzCAh01NrUqagWazPo/xG5E3TZ5FY+sYPYo=;
 b=HA2PZqykYBrV4RxYXVrVfdMUsWyeU8C73KsGv99Xxxv8wFWMitPeXYsK/BRKzqOJIoyWF4R1r
 moUX080nk0OB48kkfTJC4ii2Cs8Joi8F03FvySccGIMkTAqODwsuEWv
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX2YJlVVlqgsME
 uJYINQNZ/AxOFB8viAmGCgTbWQcGJKuJpJZnY8ALl4hh7d4mePBrsaQwmLb+aiwpXQfPEKXDkjy
 6vi6SUM4LShDv2CupLgCXtGPpuiJ6Ok=
X-Proofpoint-ORIG-GUID: pOdsC1l2wjrFocCifJ0kMj8UM5Pa-xfx
X-Proofpoint-GUID: pOdsC1l2wjrFocCifJ0kMj8UM5Pa-xfx
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a93cc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=p8LQYYvwJZuHz2WWpfMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX0701u7sXbFUm
 TJQJeBB6VjOJbsR60m3R0+0NDJKBLTi768NCsuq1XBVjMPpv/SYZCt6EaIyouNzp/4OZIL4kDlr
 R+wl27c7GbdpKS+PA/Lb7SAIDPBcFIRKClQ+iWPmresNPr6FSApcvUqu28eXKZcL4MHeu9lrMfh
 gd81LX5TAE764sShd5QX9k2+yjPPwGKxo0iMWVCeViZR4s/kycU8yOQ4thN5bPefa0dwasINSwO
 LPAdeucDNAkxiqboVp8YJ5ee1MGzJmcQK/XJRnvB5OzQ4e3Z3rVbk+PskmySJhgP4EXH7T+BuBC
 rcbstZuakk6vS/M83R4ClMz4HXEposM3icIB8u/An+meG4ZowkURazrrqp4zcXHlRMPJIdu11bC
 B0RuNar3mvJEN0+Mg95KhF/kZ+CMf8cFhZiRnQj3B5AeirXj5aK0gkAg7b51956FjoCUcxed34s
 Bv4keRJJ3JTmzV3j32Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170213

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Adreno 722 found in Eliza chipset belongs to the A7x GEN1 family. It is
derived from A730 and shares the same IP-level configurations: HWCG
registers, protected registers, GBIF CX registers and gmu_cgc_mode.
Major differences include lower cache/core counts, 1MB GMEM, no
Concurrent Binning & LPAC support. Some of the peripheral blocks like
RSCC are from A740 that resulted in updates to RSC layout.

Add the necessary devicetree nodes to describe this GPU.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 152 ++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index e5b8377e6c3a..c24c5e9695d5 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -3742,6 +3742,158 @@ nsp_noc: interconnect@320c0000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 			#interconnect-cells = <2>;
 		};
+
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-43020100", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x40000>,
+			      <0x0 0x03d9e000 0x0 0x1000>,
+			      <0x0 0x03d61000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0x0 0x0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+			qcom,gmu = <&gmu>;
+			#cooling-cells = <2>;
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_micro_code_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2-adreno",
+					     "operating-points-v2";
+
+				opp-259000000 {
+					opp-hz = /bits/ 64 <259000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <781250>;
+					qcom,opp-acd-level = <0xc82f5ffd>;
+				};
+
+				opp-345000000 {
+					opp-hz = /bits/ 64 <345000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <2136718>;
+					qcom,opp-acd-level = <0xc82f5ffd>;
+				};
+
+				opp-515000000 {
+					opp-hz = /bits/ 64 <515000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <5285156>;
+					qcom,opp-acd-level = <0xc02d5ffd>;
+				};
+
+				opp-645000000 {
+					opp-hz = /bits/ 64 <645000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <6074218>;
+					qcom,opp-acd-level = <0x882f5ffd>;
+				};
+
+				opp-724000000 {
+					opp-hz = /bits/ 64 <724000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <6671875>;
+					qcom,opp-acd-level = <0xa82d5ffd>;
+				};
+
+				opp-796000000 {
+					opp-hz = /bits/ 64 <796000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <10687500>;
+					qcom,opp-acd-level = <0x882d5ffd>;
+				};
+
+				opp-900000000 {
+					opp-hz = /bits/ 64 <900000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <10687500>;
+					qcom,opp-acd-level = <0x882d5ffd>;
+				};
+
+				opp-975000000 {
+					opp-hz = /bits/ 64 <975000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <12449218>;
+					qcom,opp-acd-level = <0x882c5ffd>;
+				};
+
+				opp-1075000000 {
+					opp-hz = /bits/ 64 <1075000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
+				};
+
+				opp-1150000000 {
+					opp-hz = /bits/ 64 <1150000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L2>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa8295ffd>;
+				};
+			};
+		};
+
+		gmu: gmu@3d6a000 {
+			compatible = "qcom,adreno-gmu-722.0", "qcom,adreno-gmu";
+			reg = <0x0 0x03d6a000 0x0 0x35000>,
+			      <0x0 0x03d50000 0x0 0x10000>,
+			      <0x0 0x0b290000 0x0 0x10000>;
+			reg-names = "gmu", "rscc", "gmu_pdc";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_GEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
+				 <&gpucc GPU_CC_DEMET_CLK>;
+			clock-names = "ahb",
+				      "gmu",
+				      "cxo",
+				      "axi",
+				      "memnoc",
+				      "hub",
+				      "demet";
+
+			power-domains = <&gpucc GPU_CC_CX_GDSC>,
+					<&gpucc GPU_CC_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+
+			iommus = <&adreno_smmu 0x5 0x0>;
+			qcom,qmp = <&aoss_qmp>;
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-220000000 {
+					opp-hz = /bits/ 64 <220000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-550000000 {
+					opp-hz = /bits/ 64 <550000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+			};
+		};
 	};
 
 	thermal-zones {

-- 
2.54.0

