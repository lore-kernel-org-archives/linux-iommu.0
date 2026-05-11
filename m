Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45472383309
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538257; cv=none; b=UEHo2zzkoMEGPpNEEUjYXXimg4iEXmo17w7KQ4+7p2YrSr4psaX0k7S8HE9IECx9OOaFwfZdz36IE6EVaOeyFzA/Zp6/YQi//BXgKzj5Rm2TAZk+wEZQrhQNisr65IOJc0I7URz59QKOYtw2/txEF3B+jKj5e9CUbXb3uT2MjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538257; c=relaxed/simple;
	bh=04qu+sqiESXvq4vvHI0DHaSeLTlPn1EdVFCIopBEhMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XrmvB2WU5Pw/+sz61HuUWNFoJg6opntTc/NNn85DRuXBgWcw2KVmyGd3n4RhhPIp1PcgFQ4WWu527IhWQHuyLA8zwual+Xnw8MCLdXYt9nFmH8jSYFc5imjGcvp2uPJUX6mxPPgY5E9AfxiBtSD7TYl8c8aAj1hJujlWLwY2XMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aMevEelD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lnz7S+W+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aMevEelD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lnz7S+W+"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6ddL2573854
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FBlygsgGnxpPMz3OC32mVCAkxjkMriPy5M65BYzsWwU=; b=aMevEelDPgBpPBKd
	820JcWpezKtVXryRm7ieHXKBnYKlXJNsczb9JH9PnQgi+Dt+7T+R3UdAtURDJfxO
	GahvsmKHgD3++i0nq+9Y0dqHVyswpAXlVHpVlBcayTzXi4sbFmm4KXuHklzw27mh
	Dqmd+AmNXhGJ80R283HfR46NhYhrvfd6rIJ7xwwi3H1zocPpmjtWLUegaXO3B+6F
	anIWxBuc/Fwje72Ot8i8wXwaqc0qstB9eAHfBhIE51ZeuvPc7716EW3cvyAcdtR6
	+uixQ3UXczHwQlSt/GIKg6RUqK7B+F5V3fwFZKNGVXDg3PfC2axuQwzQQk/3CadU
	xHEY6Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv28fcq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so5490893b3a.0
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778538255; x=1779143055; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBlygsgGnxpPMz3OC32mVCAkxjkMriPy5M65BYzsWwU=;
        b=Lnz7S+W+WqT4vX5uAarLuxzK8UlvzH/nqNIbeyO/AeGDmwMsobbNeIeD6+tUjXvSWk
         Y6p5QeH/0AYQ/W4t2JQfc/cpvJe2WfvtIWn6Lf8Ycj23gqoAanzPujfij6DKm9IHedk1
         MmGJUFDns6kCbAwVAB3/CuUuMRmK3o2+sK9sMkFIG1zGHjU8hJTCmx6AZ7v594IpRAva
         NC7S2xOWyjLQs3kemGlKHbwTXCYlqRp6vAw2ttR3cs9NpUYRCPFK82cWZ/6LCZ2UjPP4
         usVFvWO6zQdCwOEaRHQUUO5KgyXVuprcNoMiNxiIQA2R9cpInqvS5q9oFeT4K3JEVSH/
         E3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538255; x=1779143055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FBlygsgGnxpPMz3OC32mVCAkxjkMriPy5M65BYzsWwU=;
        b=Y9OpLQzvK9E8Fxk2O3Zfk+6LrPJNtNj9Z+z6Y5SY81W4seabaI4DlrqK0WOACPkJIB
         p5H0YrgvKWMTkGANMSVxG1Zp42s8VHcIuJ3sLba/Gy+nnoE8bzqO5u0s275HUrfpL9HY
         5FiEhAKZPsNsZvQwvbzMsEhIvja0j0KFgdHSSfAjoWVa+DTCXrBlxV2qZtt82OGmqo2D
         dnkHYHbYHyfTuamzGDroY4fuRU5Xc6LZiEGSs8hcv4ugi2ubGp79Fto45pwmhmyWuQmk
         r5JkhiH9PGkVps/404GlnTRKbtUfN0ydxiNsn3FSq0Ks+OYDgKtoAhCzq6V0mEEUjJ5V
         z1zw==
X-Forwarded-Encrypted: i=1; AFNElJ9AfRLhKOVxcGohuTyHj7d8gQlznN8S5EUNMgs/70Vy0x4Fq9QsJmynHZ005Dy9w9H/7bOX9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YztPcL9yJS54+2yXs4ABn1fZCXpYTgctjTlb0E7eswAQb6JOAQZ
	WIo18mEu1WzvU4j69VleBscqMc2AdNdsgltBdhTS0xOkMdh4hqrm1dVcgx8h8OMNiX1IEH1KSO7
	oeBMzrn2qkW5ePSFSfuHJjejmA/NcNFSRsJjMlH2Ic0kRX+YtSFm7l6O9oQ==
X-Gm-Gg: Acq92OGc1AyZRUoYdhRfSWbctN4e0I9vzF2TGUNWxqrBtPZrKcZlcvxoKLJ8jb68xhQ
	wSJ1aVEUghsTMVZCpLmAoXk6vbLS+dyY27sfisHlkSbMVLzgHe6tdQ19Ygeagh7X2jf05aqr/rO
	HwuymwU4P9EII639OpziIeLnRaEbAEKSFPbx9tbt0Ilu2Gqcy/y7QCXSeGy6aASuho3JmK+ti/h
	7hWMxYdU8MjdhujbrTfY9Evd4ltCdtaetGBvtvoNmMQwjOsecTk5E/qd4tFtTYTAVzoZEIU4rMk
	coSHQ9AgrKSlyZOUUSRChcSkUUZFrmaLyYHRMXbh+OGD/VG48q8h8gbl4C8SekxdS2P/h5s+J0e
	0WWJEmB+0Q0uBeGK6eBXZ/fR7VZRK48MDGEm+z3rX99N0I+n4EmL/60fK
X-Received: by 2002:a05:6a00:4484:b0:835:537a:6f15 with SMTP id d2e1a72fcca58-83ee836743bmr1216717b3a.15.1778538254809;
        Mon, 11 May 2026 15:24:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:4484:b0:835:537a:6f15 with SMTP id d2e1a72fcca58-83ee836743bmr1216671b3a.15.1778538254242;
        Mon, 11 May 2026 15:24:14 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:24:13 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:19 +0530
Subject: [PATCH 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=7460;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=04qu+sqiESXvq4vvHI0DHaSeLTlPn1EdVFCIopBEhMg=;
 b=Fp2lHKVXgWkT80McpFjFpk7lZesnPTKO8OmzeleCMQcA7tzko3rc4qUbCoqC+IAtunBNHtuIY
 2fEnr0n4vK1AmKVxQ7tsGndv5skP7bhDuYJMozfgwa3oAPLqgIQIKrZ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=IsAutr/g c=1 sm=1 tr=0 ts=6a02570f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=NK6jBuhQyghv6pUElKUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: QeRr568GArjVBtZnzTHM7tg2UuU1wKRL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfXzBDqQoLEA73D
 TUes/vxP2hmJ1UHstNLTASKH8ItQlirKbPjjnLCxvoD5JUmEymEKrNXYJQi9ciQDW29fOpGlSvS
 wpsFxfMexXTIcLkEb+zHS/0Jz4G6RJqaZa3hOd7bqa3ZIkof8nvJUFS/B8//Z9RjSmwGFIZDhxY
 HY8WfHQRVVVSqMoTRmGOwRriiY6hm3io6qIOWPicO+VCyA2UDcnJSpZt0WgmYMKHxzglBs8UTbz
 cbAVfaZ/828CSZvjE9JNm/AkG1SUc2bV37wP4MJscSvkonrR79epUMppaaom097bcL7vmU9aFbT
 wDFEeNW+esV606/gafZbqE51vbNhC5qLjSs5rTpJ/SB+nWMrmz+S4xwkO3liY9IEvwlGLHqmmJX
 3ID6jFpoahZeUDBs8SbXXbNOT/FoKSKqV0kytK9VEKrMcxV7z/Tk11NsRT0r9U8wNUorvtaSXpK
 q5uuAzimn9RKbX1UaeQ==
X-Proofpoint-ORIG-GUID: QeRr568GArjVBtZnzTHM7tg2UuU1wKRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236

Adreno 840 present in Kaanapali SoC is the second generation GPU in
A8x family. It is based on the new slice architecture with 3 slices,
higher GMEM/caches etc.

There is some re-arrangement in the reglist to properly cover maximum
register region. Other than this, the DT description is mostly similar
to the existing chipsets except the OPP tables.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 232 ++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 0211fc9f8c88..c57aea44218e 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2573,6 +2573,238 @@ videocc: clock-controller@20f0000 {
 			#power-domain-cells = <1>;
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-44050a01", "qcom,adreno";
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
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_microcode_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2-adreno",
+					     "operating-points-v2";
+
+				opp-222000000 {
+					opp-hz = /bits/ 64 <222000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-peak-kBps = <2136718>;
+					opp-supported-hw = <0x0f>;
+					/* ACD is disabled */
+				};
+
+				opp-282000000 {
+					opp-hz = /bits/ 64 <282000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1_1>;
+					opp-peak-kBps = <5285156>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xca2e5ffd>;
+				};
+
+				opp-342000000 {
+					opp-hz = /bits/ 64 <342000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <5285156>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe22a5ffd>;
+				};
+
+				opp-382000000 {
+					opp-hz = /bits/ 64 <382000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					opp-peak-kBps = <5285156>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa22c5ffd>;
+				};
+
+				opp-422000000 {
+					opp-hz = /bits/ 64 <422000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa22c5ffd>;
+				};
+
+				opp-461000000 {
+					opp-hz = /bits/ 64 <461000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L0>;
+					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82e5ffd>;
+				};
+
+				opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xe82c5ffd>;
+				};
+
+				opp-539000000 {
+					opp-hz = /bits/ 64 <539000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L2>;
+					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xc82b5ffd>;
+				};
+
+				opp-578000000 {
+					opp-hz = /bits/ 64 <578000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xc02c5ffd>;
+				};
+
+				opp-646000000 {
+					opp-hz = /bits/ 64 <646000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-peak-kBps = <8171875>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xc02c5ffd>;
+				};
+
+				opp-726000000 {
+					opp-hz = /bits/ 64 <726000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <8171875>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0x882f5ffd>;
+				};
+
+				opp-826000000 {
+					opp-hz = /bits/ 64 <826000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <12449218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa82c5ffd>;
+				};
+
+				opp-902000000 {
+					opp-hz = /bits/ 64 <902000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <12449218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0xa82b5ffd>;
+				};
+
+				opp-967000000 {
+					opp-hz = /bits/ 64 <967000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <12449218>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0x882a5ffd>;
+				};
+
+				opp-1050000000 {
+					opp-hz = /bits/ 64 <1050000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <20832031>;
+					opp-supported-hw = <0x0f>;
+					qcom,opp-acd-level = <0x88295ffd>;
+				};
+
+				opp-1200000000 {
+					opp-hz = /bits/ 64 <1200000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3>;
+					opp-peak-kBps = <20832031>;
+					opp-supported-hw = <0x07>;
+					qcom,opp-acd-level = <0xa02e5ffd>;
+				};
+
+				opp-1300000000 {
+					opp-hz = /bits/ 64 <1300000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L4>;
+					opp-peak-kBps = <20832031>;
+					opp-supported-hw = <0x03>;
+					qcom,opp-acd-level = <0x802d5ffd>;
+				};
+			};
+		};
+
+		gmu: gmu@3d6c000 {
+			compatible = "qcom,adreno-gmu-840.1", "qcom,adreno-gmu";
+
+			reg = <0x0 0x03d6c000 0x0 0x68000>;
+			reg-names = "gmu";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_GPU_GEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>;
+			clock-names = "ahb",
+				      "gmu",
+				      "cxo",
+				      "memnoc",
+				      "hub";
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
+				opp-475000000 {
+					opp-hz = /bits/ 64 <475000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+				};
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
 		gxclkctl: clock-controller@3d64000 {
 			compatible = "qcom,kaanapali-gxclkctl";
 			reg = <0x0 0x03d64000 0x0 0x6000>;

-- 
2.51.0

