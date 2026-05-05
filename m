Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519E3D5227
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964522; cv=none; b=K+ZodaV2Z7b1RaZdc1OEJjZoBUf8xWxhJGh1K/GxPHA50aw7oXvO4wUcnJDDSy3rDGtnlMJWmjmAsXYkq278PxANGonOtWMEAs8MntvlMI27BdkMLRyTy7llCEGESeOlcgo6+nozmcYDV3x2BOx99kd1L2ZKT53bCgOg/LSDYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964522; c=relaxed/simple;
	bh=RTc/vH0vt6hY/PLcGoh+fAhXOnRXNDvqwH0e2EW2IiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwQBYGxtZdFWggG3HyCvoJRwFnGeHW5R3o8wwscaeuQt6GFwDqYYZfkiHrERHUo+UfljPtulV9fKOIwOHcS7NvXvIeGZzgbpPVtpTe+p7np5ZWgkFbXCLIWSEw0Sqr1rTeE8/ZMGMT4t448q3HblR0R+GA/AgqNXzMWxHHtsNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aOUqkoS/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vu6HTXob; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aOUqkoS/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vu6HTXob"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456lWCk331129
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 07:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zCm+mAfWcg0BGWf4HLB6gdhaUA9jwfO1VsKytcd9sLw=; b=aOUqkoS/py4oK1TI
	SbfE/nDLRbQEfYd+02eiTVJ4QI4xf5KAtXuNeDMvAMMGDHWYmSkIUgY224i2gwES
	Uk8E4LBjdiCxNxDAdku83IBgqB8fXQMeZl6Y8al70G7RmIrFPT4sZhA6UJnwN6nC
	iivw23ifmkQMSDTQD3rd0NVdUEgpNDvKdz5Xpc9azAOZFswSod64AS4Y9Vw9syRc
	oR15Q9Oc1ta/0Ds9ffxmRrdwNq4P+VHaLUn7LxAL9mRFSs8J4CA1PSbv5+hLMhYM
	DICQ1hF+a+oIXdMxTwzMTve3mdS5b1oUtXVEGE10DoaMpzS6FN+x/6qwJM7yQBTS
	nNJN0w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr1b8ck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 07:01:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35e56ed5d5bso6629967a91.0
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 00:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777964519; x=1778569319; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCm+mAfWcg0BGWf4HLB6gdhaUA9jwfO1VsKytcd9sLw=;
        b=Vu6HTXobpk/3Z2rNbjMgXr8t1dnJNt8YaMsLg3O+HJb2iew4UDuFQtXY5JMPcuQ50Y
         e14HZfYp4pg9V2LcWMRRqaIJZSr55E4Yh99CvsJYLlz7wRXAEMyg7bGHeAxh5p7Bb79p
         VTaHsnE/1v7Fw0MYBADrnRCe71JHVI8AwRsdd5nM1qrOoVYZtWw02ztXc1VzAoC9211A
         sp9h67iGKUcSlpeGITnLvxyx8y5R28TIf68n0MCHbOOmgZ0eGVJofU3yOMt8fV+3bxFG
         wof3Y04TTOVTxgqLFzZpIoon4nltCf9o23t0w5OE5vzlvP5ZoFaHp+Qu95M4krXHgce6
         H8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964519; x=1778569319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCm+mAfWcg0BGWf4HLB6gdhaUA9jwfO1VsKytcd9sLw=;
        b=ndnlS6BS6/TJChft9GK8VmoiDAmEz2rGJ1VDSK27qzbPsgWyPeo38VT/GWgtcFqK2o
         +r50l/mHnQUbTrXBu5mx/Q5d9awzybcW9kHK7qtnSL7Rqh8U9CSqbakrAV8OfKW03qnR
         +htfhkjoTpzNOnuAtwWmK/vuXnydplikXkNn3NS8dzzMZOo50VYebdVMEwa19hCML6QZ
         /hWwOl2ay+0iV681nHGtF4rn3cay377AcDRWHXwnWg36SVH+HD3muoLH2P0a3yHFl2bb
         nypCmiU2uJNgwW+cktpcWATjj3TfVnJQq2jmKE8BUe2G8JVN7hwv86rmRDwhixRFdgqF
         Bwtw==
X-Forwarded-Encrypted: i=1; AFNElJ+dXwGtfxFkYeGk9szhY9oT+Piv9pYLzLmqScHVGqhnL7ezO0SHcAEziesI9ekFTzDwtBS03A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCvRroBPqTLskWfvWDRSaPcrldesABRzqFXbKGHFX+RA624WMK
	mFWCz1vNGbtXW3rdgAVWOwTBDRutXfB3K6vJT83wJdUgMKhDFUfaNxZ/mohrO0p3RExnQFQaIw/
	WGbxrxgwMWwNITCXQ2TQpaEMwdHLJb5fPK15/mpBivSSgLiLWjaIKNU9FxQ==
X-Gm-Gg: AeBDievWma4E8RX1A53ERPN4ZonwqrtwxBX59Unb3CnZ//IVm5orDmoJVp9GP86IbaV
	EM+wBFFX2J+ahV2D1zHZePJjxrY55jzV9ywNmU0eaCB9SULzqSkcTJdd3kFLyJXRhwXgp6Wopk9
	5+WIjvhR4582zkub1Jo4rB3oazqIUe2vMjlIWHWh9Clro4fySURIgQiJ0M+1tpbzAdgncU2OMaU
	bBUmBi9k4UPaaxnLnPbzKbvt/1AdiwsxXH2RTC3P0XmqDNVMUOkglYuq8MRP90+fL/NFUHemUV2
	WT9MjlMsvxlCjWHR0NiFAxyYAzGhUhKkICcYKvMjbzS5bJ+zF6C31tRY/hQzySoFABR7Zi8FrYp
	VEj0ulFbEpGHrDnTvJ9cuEW7Pi2lXgRKpBaGQ2AepuMjOrQ7cQpdjulNNf2i/L0FfxA==
X-Received: by 2002:a17:90b:4b0b:b0:35d:aa02:d776 with SMTP id 98e67ed59e1d1-365722540e7mr2033870a91.2.1777964519121;
        Tue, 05 May 2026 00:01:59 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0b:b0:35d:aa02:d776 with SMTP id 98e67ed59e1d1-365722540e7mr2033847a91.2.1777964518597;
        Tue, 05 May 2026 00:01:58 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm13840146a91.2.2026.05.05.00.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:01:58 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 05 May 2026 12:29:34 +0530
Subject: [PATCH v4 13/13] arm64: dts: qcom: glymur: Add iris video node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-glymur-v4-13-17571dbd1caa@oss.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777964421; l=4957;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=RTc/vH0vt6hY/PLcGoh+fAhXOnRXNDvqwH0e2EW2IiA=;
 b=BkVRDogYbI1Vb4Nl6mFnz3VKv0fYSEXqpWs84WEDH4JCF6mdHPwbp5fcnLZuwI734JvWRCMWt
 xgPCBPTPldAAoyQNYTBTrO9L+ESdZqjeogcpooUC1f1SVOEr2kEPIxc
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: SqC8WkzgdxYFzdbeHdCoUpCzOemzjY9Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MyBTYWx0ZWRfXzR+aWEGIoNG5
 6kIadeNyKEHEy72lwigEyGZP/OxuNXRQ5Zule8mpHwfmJbVfOwTgh8Cbs7ZSyVpqZHoPLykqeZ/
 V+bxF8ieW/RL8kqVF2Dg2u+M3r4II05p90BIR+eLEd6OAoXHUQz2q4X8jpblG//6Z7jkSqU6eJ7
 jkyBw3oKXe32ovLjwovZf6b7pkRWt8MVM+FHgIJ+a4Huj/NKi7bviiznjLXTFGR3H5i4QJG+R6D
 aFreYoZ1YLt/DpyxOxlMiSS/hObC2aE1TrRWf4Jj/4fFSXqfVkrW5f/y1lMCCB3ghwOcHAMFaK5
 vvhZsP5Vymd2X8VmduRZiLd8XB72NoOv3AG79zZ2nKNj/iFSXNInzp1R2zRc5bWG3GaGqvCK/jL
 cRT42/n/bn6fkfqFUFPVd0YO+n5gd5zmZdKfqOIie28E7IQ1ShFBC0MZlv1tTkofk3VZxrugjZE
 Rw+m5fWesY9VWUaurlg==
X-Proofpoint-GUID: SqC8WkzgdxYFzdbeHdCoUpCzOemzjY9Y
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f995e7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VYrRtalYO0MCCBblpesA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050063

Add iris video codec to glymur SoC, which comes with significantly
different powering up sequence than previous platforms, thus different
clocks and resets.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts |   4 ++
 arch/arm64/boot/dts/qcom/glymur.dtsi    | 118 ++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index 35aaf09e4e2b..8d6ea857634b 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -198,6 +198,10 @@ ptn3222_1: redriver@47 {
 	};
 };
 
+&iris {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index f23cf81ddb77..c47443174f97 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/media/qcom,glymur-iris.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -4163,6 +4164,123 @@ usb_mp: usb@a400000 {
 			status = "disabled";
 		};
 
+		iris: video-codec@aa00000 {
+			compatible = "qcom,glymur-iris";
+			reg = <0x0 0xaa00000 0x0 0xf0000>;
+
+			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0_CLK>,
+				 <&gcc GCC_VIDEO_AXI0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK>,
+				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK>,
+				 <&gcc GCC_VIDEO_AXI1_CLK>,
+				 <&videocc VIDEO_CC_MVS1_CLK>,
+				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "vcodec0_core",
+				      "iface1",
+				      "core_freerun",
+				      "vcodec0_core_freerun",
+				      "iface2",
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
+			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
+				 <&gcc GCC_VIDEO_AXI0C_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK_ARES>,
+				 <&gcc GCC_VIDEO_AXI1_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK_ARES>;
+			reset-names = "bus0",
+				      "bus1",
+				      "core",
+				      "vcodec0_core",
+				      "bus2",
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
 		mdss: display-subsystem@ae00000 {
 			compatible = "qcom,glymur-mdss";
 			reg = <0x0 0x0ae00000 0x0 0x1000>;

-- 
2.34.1

