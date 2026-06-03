Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D4481FB0
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496489; cv=none; b=EwFJHyGMqn6LZVvtPTJGbFKXBCpXo0e6/E+14IX+ilb9eJnPa5XKLUqC7CVCG5Ki/I+egxMM9V/7UQP1KE7uzgzWcSgMLylo0lwoqPbHAO2IxT3A8IgSDemy2NKWiiFCYxcisznCrR3RXMnKcPjfh+ZKbokKDHrajBepTJ0C6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496489; c=relaxed/simple;
	bh=n9tw5p4iSejXhjQapjH2LFH1zlMXxIR7tImZi/c9gwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9uTm6tujlGF1IidSM+xgCBoVCMVy8E0uYh8rnOXApp2QXe/ZNlCsFq3GPPd5omhAOzCjQ52BODbuGmuH+cImntB7xDSN5fdxxSiphvpchpyM0tnQ7lnWFgMF2yLCY3lNQdtiB6B8mcndveM3VVOHQ5TrHQMddL+3++86lrnne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PhCIyTtk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D6Zy3O71; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PhCIyTtk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D6Zy3O71"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CfIiX2076119
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RzuIcF1SoVoBc6jwuYuHvPur7dxWQoBybR01NlwvIYQ=; b=PhCIyTtkRzae5Ul/
	R/7BFwyR3yriFzyEjMf7zPIVr5d4TbQGi9kr2dXEkQZ9rdRzEQ3ET1tpS6IXnSXH
	4RmgI24TPgV+P2psI8psyAHUEWequu5CPDLp62lew0Ncs8u3KXiL9brg+7wi9nqm
	0bUo3PBuhlaQp6qECGPg4WBJ4uHz8mRCRGuEX/ZB8IlocpNcEJ4LgV2XurBmFVf0
	uJdS/HD0HYDvssLuZUW9TtpE//LUB9WHmqJdrLl9iSsImyOokaoLk0yUF4z0BvcT
	3zLOM78tCwea+30oRLFG0DjZr5Jc81rzMmDx9HONL5oxVLZx64ps68cOERfzwcD6
	FQL3SQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev19xdm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:21:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c20f7581so42873625ad.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780496486; x=1781101286; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzuIcF1SoVoBc6jwuYuHvPur7dxWQoBybR01NlwvIYQ=;
        b=D6Zy3O71CsuoLgiadcIqFCXgW+RY8eoqgR/cTWNMFYR2QwfmNjvcS9Py/pJeXr+knt
         0tj+ERH6+KjxdhsWaTHKPFNYzk/5Vz6oSLy7jO5D6865ScJZwIqe4Z02V4DGXt8od9S+
         cfhrOW8vqnNOk3PoL+bSN8IWnOYlGAhbVRPmA/l7VhOXk8dj/m5kgmcD15IU7cR2p+KZ
         RjRJ6sqIkW9mNU3UJrkN97EsSMs4qkh3n4uoVtQvvIhdN6NwOeMa+K8XKZ8CqlM5lWcs
         OfxL1AmWndFqaJHp5HHP4o5WKf0yH+zcT/b8gV8+PZnCw1aArSdMyZs1c7dREZzjXCS9
         QhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496486; x=1781101286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RzuIcF1SoVoBc6jwuYuHvPur7dxWQoBybR01NlwvIYQ=;
        b=rLqjU8cYeSjQcW2jUqe/N2v/LmyHNRUUbApBXOxRzJPEZszXEwiIAXxGtEPyzOiFcu
         uxJbTcebvCBYPg3YJwKM+a+uHTcbrgk8qtp5kmszgOS38nDE9g7iGkoCI3SJrw6QBQbn
         8u0p3A3R8bl94EKaPC00uWyNtBp3NeVzyFy8bPLwjtTugxLenJO2yovN1qboIgIN5y72
         3g0glermyBbLHm+6fQYLHwzGDZ5oQ5EaU9gO3F1IKZCuv8Qu/G+Cc0kNoSnQkDLkWU6P
         c8GOrjbymAHrQAzNWyR41SclDOL783qT6u6nuARKGmGvaedshQq16JD3aBQ6AWAiqqCZ
         L6NQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kGxdjH978bKvdhxrLeDHAIc0sLIjudY/yDuOlx8iHALurNmA+jgKzhZezLJ0ifgN/H0RQiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDHHHiL16wW6fyVXbHT3Lyp9zNdUQnhSrtcjieYlkQSIMxvceT
	4TgbY8tSJQ9Vh3sZlIJ0tfFoqpXdtAz5SGwp6P8e8vwfmfmLCv44Rw8CO/yFUuw9cNc7YFtZUqM
	Xs/VR6vOE8DN8PoQCR2v1+WpdK8W0I2m9wjKwpxOBKsR4mk3zyOyfqkojqQ==
X-Gm-Gg: Acq92OFe0cAg4u65JA4TI/lDly46xiH+e07KStHlCl6dRivPoPXGNSC8TTE8IJKVJeV
	ekSrb+YXBUrjRbhe+1KlaFAnapt3p94EJ7vQYVJ70JDHBhaYg0255qeZZjZAg48EqJs3Im/ZCAo
	MnBcmXycjWwcr016Iwm/g1vB4Udpa9Pm3J2KrdPAK6cupFFJEQfx+8nWYtaILHpbgEfqj3EYu9o
	oP82fplsNXf78uxS3gPvux8ALYJdRIXMUvolV0VpsAnvErofO+/eIitGKTsBOzn0gr91viuCfYZ
	45ydJ6PzguqT+qXfY5SY4vBqZkzGvztMJ2a5lKww2bXkba2JuTp0vfQbbvhsU/LpM238fDIGcRa
	h9y1y28T/l5RnNqc6cMsN9fEi6iBmtvX8fABGcnCD2RtN733Vbf2Jq+yOZ2i5/ADc/g==
X-Received: by 2002:a17:903:1252:b0:2c0:a57c:ebff with SMTP id d9443c01a7336-2c163a256f9mr38533915ad.2.1780496485689;
        Wed, 03 Jun 2026 07:21:25 -0700 (PDT)
X-Received: by 2002:a17:903:1252:b0:2c0:a57c:ebff with SMTP id d9443c01a7336-2c163a256f9mr38533435ad.2.1780496485164;
        Wed, 03 Jun 2026 07:21:25 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm41514955ad.9.2026.06.03.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:21:24 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 19:48:49 +0530
Subject: [PATCH v7 11/12] arm64: dts: qcom: glymur: Add iris video node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-glymur-v7-11-afaa55d11fe0@oss.qualcomm.com>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
In-Reply-To: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780496410; l=4631;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=n9tw5p4iSejXhjQapjH2LFH1zlMXxIR7tImZi/c9gwo=;
 b=RI+ITw2Asp8AXPj0keMrIraI51fgqjmdc5g1Ueprr7b1xjDe6FzeeM9+HdCEVCgGe8ofKew/r
 KZL/pieDZqWDQTE+yEy609ZRRNdIMZoc3uIIfZwC4/oFcgq8Znc278E
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: b_MZzsj0HK_hlH6IbZUcDAmGWEbVRHls
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a203866 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=scTG0D64rx7uByHHbCoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: b_MZzsj0HK_hlH6IbZUcDAmGWEbVRHls
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzOCBTYWx0ZWRfX/slhDQoLb5jy
 5TtD8puCnf6YdIgMFUeeUxyRKGF0cqxQa8Jx8bMvs9DBvGSR7pgzIM0kDwD34Zpv1tsmM+jn/7B
 hs5ebB3qPzAorxZo7GEq8hcsdlQcGaAcef+6qWDzGIWgel1i/Q64hdqhTc2wdQAj6bcD800Z7Cw
 wDhe+jTADzIB3HzCnpm6xavsBn1pqXYs1ldqUkn1DL8LikVItwSXZhk+1kVrkspAEzlMLiPG5ck
 mqRP7mDktpR1TAIEqsj7D6MySXAK1gbIgaoXMblzC+I7L5h0QQIT1xZ1SQ0d7G3o+fwc4d8arcR
 m5LF9t2jzU7vKHBv74Vzloh72KavpMIp/RpjhTMCN3ybwuK6uY8UxSQwTUE54KRF2jW+kk9Bs69
 mz3o2bpx/c8Ato74mkytEIQSrXlY7eRgfXUbub0x6dYjBdVKAgACLLvm11vuS1PxIK263HPONKB
 A1wAwaHRrV+SBNTOfrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030138

Add iris video codec to glymur SoC, which comes with significantly
different powering up sequence than previous platforms, thus different
clocks and resets.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 118 +++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 20b49af7298e..42bcd03c4d3e 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/media/qcom,glymur-iris.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -4788,6 +4789,123 @@ mdss_dp3_out: endpoint {
 			};
 		};
 
+		iris: video-codec@aa00000 {
+			compatible = "qcom,glymur-iris";
+			reg = <0x0 0xaa00000 0x0 0xf0000>;
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
+			iommus = <&apps_smmu 0x1940 0x0>,
+				 <&apps_smmu 0x1943 0x0>,
+				 <&apps_smmu 0x1944 0x0>,
+				 <&apps_smmu 0x19e0 0x0>;
+
+			iommu-map = <IOMMU_FID_IRIS_FIRMWARE &apps_smmu 0x19e2 0x1>;
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
+			/*
+			 * IRIS firmware is signed by vendors, only
+			 * enable on boards where the proper signed firmware
+			 * is available.
+			 */
+			status = "disabled";
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

