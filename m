Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFD349CDD
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045127; cv=none; b=JZ2naleZZaZG4SbWstZBQtgSkokoqUQnAaYVf/7dqktcFTM8CZwSmxZhgEuC7t0uhIUl8aQINgIFApT6/kiZAObCmUJ6dZIFyojT1IvZh5sF2eXOc5+/qV0s6DKSRbu+EJMqCme8z3073rFSJslk394W30vHnqWh60Lo5eJO4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045127; c=relaxed/simple;
	bh=ON8srqd3aUgowhj67UGEbvHl9QpdnL4HJawBK/SEEvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjxQqcpPpWGlu0kSCGzUpFOZoCevhh+MFXCmTUN49r4EFqJr1z75gGWOgX6aBy+r63QC9jm8K7yZGqjR2idbj062Loh1PKwCIzAX0WNX1Lup6Q0gatnTnAie3cUAFif1/kF1nrNBU0OU2c1uW+fXZ+wZl8rXN2f1iMjBfR+SaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lMMtALhG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UILtq7zf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lMMtALhG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UILtq7zf"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5RmVb4103215
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KSqOAwb4/u/nEQFyuPvcZ0hNY/Ka6J87mP3j2Yv50Eg=; b=lMMtALhG/S5RiQcN
	rT5IJgZRLI9W2VtMn5IWhKoiPRr7bdVMwQ2aqjhkn5z6woxYmr5gi7u11X7v64Em
	GJdDV9UPy9h7esLBUqyy2c7NDJ6mfZZhTfsjmWeql8Aiaq0P5GpYBWKDRW6p34wx
	0yIdfVu9adQvge+bwfWYoZhhzn2Z8N9WKHxGgfDfb/2rwzbZTHuwhkX+h5N3twhd
	p77/yvQj3ufJgPkkyJKPqH/9OsF8cFrXwTYKMDED+q5ez7EYaPOtEUeS3RKZpmaS
	gLP+u3xGxR7TSqHcZs+EdkPGnFXBkB0wTFg3f5HYP5yTDqjJESM1wLA8QmKJXYXv
	tokdkQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmn7va9w8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:52:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c860544c077so3809023a12.3
        for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 22:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785045123; x=1785649923; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KSqOAwb4/u/nEQFyuPvcZ0hNY/Ka6J87mP3j2Yv50Eg=;
        b=UILtq7zf6NeH6VDiAuLgR2jsAGNa5cNhScZLZXS/SjKGfVCI/BXdmpTZJary7hv9Tg
         ehhdxkmu/AZUDoNXjvAPKCnLOfrqSJLwMGGRwPTcrH6ufteGu3nOnhynRxRx2eopEGGv
         CYRGcgcEcGxUQEkYPu0FNYipg2RqntxO9n9IsibVZcguyNaV77RqU24KGUhNiYVhCnHr
         DzV4NQKDl7RD6EmkG6SQqwyK7H/ZkHfx6TQ6HlWu8pojHIdRXNb5ss1LKIagiP2HarG6
         MENkqbC5DxHn7e4uXsS4jx7AWkk/BiS3uZWHwuAJR4bztp54EFMpvXrwIvJ36PxjAWy9
         VoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045123; x=1785649923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KSqOAwb4/u/nEQFyuPvcZ0hNY/Ka6J87mP3j2Yv50Eg=;
        b=Es3rDOflofnuwtMzlplYIVmmiQHUvWB845bpw/+4e3jfTy4PFsOZWnxUCb9qqFe+rI
         1f4zbinUTnt7Y3lWtfNNN1itaedXTeiT9xnHI6tGYJU+BR7SugZlwTJQXrAGI03jdjHA
         hI8bBAzHaoO9R0CddOMHhc9nXdXlMblHABcUpja30Mz7QiaOJ8OOcYsjp+hCC2PNkY5S
         FAN6ur74vqvopAiGHN2TccaqhngumA+euu/sdughpCbtwb5qRCLE/wEv3dIlfmGqfiyw
         YlDaWTpqI2HEr6aHayZpzJAkK+3dV6Dvs/mysa41yKklLAuAuaQoxf0ta1DomWH1YXo8
         foLA==
X-Forwarded-Encrypted: i=1; AHgh+RqLCzfCU01W6WOX8T+fpjoW9GjZhSSVp/PgurwmNnDBqexLPy6+Jg756rDQjuUL/fG4P+JzaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzr3UK7w51f+cCzpa7Co6hdLeIVYYgRvCFqrCCOhrDS5jmuzMFs
	FuHVifVI2DAgxv+PLuaDtH6eBQ3po5RIfd6NVLE8YgNPZs7Gq5gOqbYbGs12q1yS9ckPcOoKiB6
	FLbvm1vL/F8UlpD6ydAPxLG1DFBSeywmP+hfBHmR/Cq2AfcYip5bXmZXK/Q==
X-Gm-Gg: AR+sD12cXWhOH7sIXKwY5Z1RTa1Qv73+gjAZLSGfdJdEojcJyIJz2FdxWsmca7GzIyC
	EhxFC5L7qD/6bvSM/9/8BItVT2QxB9kdLIKF1HV2bXEsPC6JRMTPA3LAH+3IX1Vx8Bk9td2LEHD
	j7QQM/Dkkzybxobj6uouBo+tcyNDYp82FXe7oLnHlWNCtBV2z5k9ZiFWiKfeQugBfGG7A3ChTqB
	yiUJyl6bWskif0Qz6OlS9GXeSippng1XduOH1sYN9Wz1I3inhHlWjCS19pSfOkveKh9N3Ql+cig
	b0ivpp7FQkGnYfYsbx9LMlDipuKOrg+SREZqtq6sE3kchifXPWWrqBx2Z8iC2chER9DSfTor3Tb
	Tdj5sHhpe2RIuo+CSrZ/gaUqdnWXp2Jfdag==
X-Received: by 2002:a05:6a20:1605:b0:3c0:9c1b:d0b5 with SMTP id adf61e73a8af0-3c67e02704cmr4106577637.64.1785045122676;
        Sat, 25 Jul 2026 22:52:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:1605:b0:3c0:9c1b:d0b5 with SMTP id adf61e73a8af0-3c67e02704cmr4106550637.64.1785045122205;
        Sat, 25 Jul 2026 22:52:02 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm67106334c88.15.2026.07.25.22.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:52:01 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 11:19:43 +0530
Subject: [PATCH v10 13/14] arm64: dts: qcom: glymur: Add iris video node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-glymur-v10-13-de451559e88b@oss.qualcomm.com>
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
In-Reply-To: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045024; l=4683;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=ON8srqd3aUgowhj67UGEbvHl9QpdnL4HJawBK/SEEvE=;
 b=6Rqw3lz4PWJFC9yYr4KT8o59dlDL482bmFfYG/TgIWXXX/w0DmRLnn229Akstw47/jpW6SlZZ
 MoSULRG3RV7D5nGNI5nlfMtq7PjFrpNoUSEvcTglOqDheQ2CwdSLvp0
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=GKk41ONK c=1 sm=1 tr=0 ts=6a65a083 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cZ5fV4nVeeMGK4x61nkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: hGVbG0Qhrajm4UvRmeNTFyMxEDtwfDu3
X-Proofpoint-ORIG-GUID: hGVbG0Qhrajm4UvRmeNTFyMxEDtwfDu3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1NSBTYWx0ZWRfX1wmrA8Bl4oOw
 sSnaeQbmS7JARl7xqXGZH1INf0T0YGBeX2J3egPfz2s/U2feTuFTUd3gHFINMCNDSmwgxELhbe9
 eY3MNYP5rNvKGRISco2wNM1voOfo8oE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1NSBTYWx0ZWRfX+am736Dgg2ob
 GQpA23YyqaLrFIU2EPm19rSRFGT/Il4D4ydTssxHwQfLa9ZH6nyelpPnrJQy6Ki8zbvXLkp9vfI
 0hT5Lfu36iwk7tUkBcMnA4WqKDAmzIzy5SLLRwjDYwoCd246SDvw8eHK10ixx/md7HbyRIk7El2
 AUzYQR973RWsJno8zeSPa9goH7Qkv7CpZt+AzfkhAU/2mxWXzY3dgHvnG1ezmehtXmWmUlsV4hy
 +rEQ3AgcVI0Z0OzuFHyRPjhzYG0OttHDFnzRB5pBswVy5VhZiLbrXpFGngBgQqmTRRN3hwJP8zg
 CB2p/80cmdpYiF11QJU1cCFz94IdaNA9L/KXNbVUyq7tPNlYogoqliItsSTX3uKgfRMjpy7hFx2
 BiehkxdZ4UNMIw1SCn8JODZoi8GSVWDEHcKOY96R3wtbx2bWy0ea33Rzt9ncBjzuqS9Aa7U3enT
 jp69UWJEP/aNDRh3gYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260055

Add iris video codec to glymur SoC, which comes with significantly
different powering up sequence than previous platforms, thus different
clocks and resets.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 123 +++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index f32af66a3f1c..f3a01a2a1f22 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -695,6 +695,10 @@ adsp_rpc_remote_heap_mem: adsp-rpc-remote-heap {
 			alignment = <0x0 0x400000>;
 			size = <0x0 0x800000>;
 		};
+
+		iris_resv: reservation-iris {
+			iommu-addresses = <&iris_non_pixel 0x0 0x0 0x0 0x25800000>;
+		};
 	};
 
 	smp2p-adsp {
@@ -5314,6 +5318,125 @@ mdss_dp3_out: endpoint {
 			};
 		};
 
+		iris: video-codec@aa00000 {
+			compatible = "qcom,glymur-iris";
+			reg = <0x0 0x0aa00000 0x0 0xf0000>;
+
+			clocks = <&gcc GCC_VIDEO_AXI0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0_CLK>,
+				 <&gcc GCC_VIDEO_AXI0_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK>,
+				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK>,
+				 <&gcc GCC_VIDEO_AXI1_CLK>,
+				 <&videocc VIDEO_CC_MVS1_CLK>,
+				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK>;
+			clock-names = "core_iface",
+				      "core",
+				      "vcodec0_core",
+				      "vcodec0_iface",
+				      "core_freerun",
+				      "vcodec0_core_freerun",
+				      "vcodec1_iface",
+				      "vcodec1_core",
+				      "vcodec1_core_freerun";
+
+			dma-coherent;
+
+			interconnects = <&hsc_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mmss_noc MASTER_VIDEO QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-cfg",
+					     "video-mem";
+
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			memory-region = <&video_mem>;
+
+			operating-points-v2 = <&iris_opp_table>;
+
+			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
+					<&videocc VIDEO_CC_MVS0_GDSC>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_MMCX>,
+					<&videocc VIDEO_CC_MVS1_GDSC>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mxc",
+					     "mmcx",
+					     "vcodec1";
+
+			resets = <&gcc GCC_VIDEO_AXI0C_CLK_ARES>,
+				 <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK_ARES>,
+				 <&gcc GCC_VIDEO_AXI1_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK_ARES>;
+			reset-names = "core_bus",
+				      "vcodec0_bus",
+				      "core",
+				      "vcodec0_core",
+				      "vcodec1_bus",
+				      "vcodec1_core";
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			status = "disabled";
+
+			iris_non_pixel: non-pixel {
+				iommus = <&apps_smmu 0x1940 0x0>,
+					 <&apps_smmu 0x1944 0x0>,
+					 <&apps_smmu 0x19e0 0x0>;
+				memory-region = <&iris_resv>;
+			};
+
+			pixel {
+				iommus = <&apps_smmu 0x1943 0x0>;
+			};
+
+			iris_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000 240000000 360000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_low_svs>;
+				};
+
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000 338000000 507000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
+				};
+
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000 366000000 549000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000 444000000 666000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_nom>;
+				};
+
+				opp-533333334 {
+					opp-hz = /bits/ 64 <533333334 533333334 800000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_turbo>;
+				};
+
+				opp-655000000 {
+					opp-hz = /bits/ 64 <655000000 655000000 982000000>;
+					required-opps = <&rpmhpd_opp_nom>,
+							<&rpmhpd_opp_turbo_l1>;
+				};
+			};
+		};
+
 		videocc: clock-controller@aaf0000 {
 			compatible = "qcom,glymur-videocc";
 			reg = <0x0 0x0aaf0000 0x0 0x10000>;

-- 
2.34.1

