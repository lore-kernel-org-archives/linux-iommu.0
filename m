Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C013A86C
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266955; cv=none; b=e+VOlfvKdfP9+4djnr+HABfJsgzosKBo+xcTSWbjHgIXBil44aOzvRWJwRVYjBfzoBDtmmZxuDJKsg55XWJQqjV1mQKct5h++9/ofnHFskKneEfufo6KW4c5Zd+Dd5/AznHq25l08bXZ1aXaR+pVrnUFkKQFjhGXvbyged1QrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266955; c=relaxed/simple;
	bh=PD1gpoX4LAukVY7c9h2PcdOHpE6W9WE7RaExHqCiq04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eeNn7nMttn+T+27n51qYGwwfaXt3olDf9QZj4gWyd8R3IhKmY4vhmckj5XshDq/m/oVJlx1wtlKEGJDiW62XVbk15FovSw8reW+Cu1EDeKyEwBbvTwri+2+7nBPlNquSc/pA7CZxUYk1Afj9HoqBVr7fSYB5liMlCEWQgdCgwzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MU1m029N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fBEiTdCg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MU1m029N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fBEiTdCg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648CoCI1260579
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	geJxq8Fym74xZf3sPrd/0n2hwRmsRBx/QMPFY1ao6wk=; b=MU1m029NCzcq8bud
	1rBJry2xZkVvtjCxyCQGvWF1WaXKGKl3DH6KGsdRLS7EmylQxpgXUBKWH8UxZwa6
	JKfp5WuLhT3Eq5Z4K3Jef2+JV7IowyiapQFaIOkgmPv3wPjUucBnWF8VYIFRQndH
	RSW4PFMzht7K4hF4aFrwrf8y3SDvdvYPWH120bij44xJE+aF3POzp0lh5O1OwkdX
	+NP4XI7ZaNuBNzNDaiQYGsLyVIZ1kk1tG6rSfSmIt9g/mFMj5Lfvb8m6kii6omxw
	beK1thm4apr11BYp7bxlQlYr6AbGEzHFp1pnCmVCkZdRtHdyOlfxz4CgV2/Xh/04
	aLlmbQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1auejsm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:02:32 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bce224720d8so1284950a12.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778266952; x=1778871752; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geJxq8Fym74xZf3sPrd/0n2hwRmsRBx/QMPFY1ao6wk=;
        b=fBEiTdCg3ZfKaoWcAZaBnj7RY8ZICgOJkv7f6hLVJTOM0EU2S8oC3xxqA9YlzJqjZA
         BdTlINgNR3nnpWw29ZTfeXCT2v5RAdpNfCRDE0oxqsBIerKZPddzjMgEAIHzgnfxl6pB
         HxxVTc0VlWMvJqeLQ3J59T2gVFVKZkbDRi0lilzrzCfhkPCuJvdfIAZvJBQDkm49VeBU
         L3ijN65LXhzoGykpv9a5UH6Yn+RGN3iQbvKJHS+SJK2PU3AI50gMmmAgJTOc/3AWjRNJ
         xM56tTnTzZUleHF6IQRuaXPhsJKIO9OtsVDjHFEJmllUxo+83qtp0/3xtgpwNN7k+IcH
         f4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266952; x=1778871752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=geJxq8Fym74xZf3sPrd/0n2hwRmsRBx/QMPFY1ao6wk=;
        b=YtNiQNnVylQERc+WTMBQXrgcD0qxIqpux5bQyceH9M96dqKxoyVvEiDOH5QXbFo52N
         oDrXIJQjSe38sQslDm0ZzQ7ze5WLjsbuIYEZVOPs5PfQc66rAIN4OLmzLV301olL84MF
         G0CzYogkkHEWv+YIoHZZl6DUWy6aa2vFruyceGrfeDblNbKCUzeDdP9h9pJLKF5gohe+
         4niZ8WhRrD4RpmF1h/Lr4evb8QDu0rta0uufODG0zx/f43BUxGj+XO61bpKzbs0Gp3QE
         6Nl2dzOgvPTOhGR1YwzWwKXpOz2DTBgbx6cv5nX873EE0j7I+aEYb3DA8WeCmSQFVU+j
         vIlw==
X-Forwarded-Encrypted: i=1; AFNElJ+3d/qh/dp76otCN4GUMDNG2UirawMJLoC+Xd+FwQzKCWi8GRb+kSvcj8qEgLrptMPFghWzVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCPCI6VJN7Jnr0ERUpqEG7DgwA7cFtH3gTO82V6JO23Y8i84bI
	gz0bwllD+xAHEWwfRVTwN9Zjq7usDfyzz7e6kxxX44RsYRxa5THpb4Y1TohnslvBMJReumPDIic
	I93/Sik/mMW8e1icFwNESaxq+6eNoiIynGImII501+bgtnVymizkdsGk1Cw==
X-Gm-Gg: AeBDiet6KaYDSFmZ7TqQEAFhvfyMcr36Dg+FoWaMCFR3j6ZmnTDpceIpEpmfy5RI2JI
	YiUQk86Bl2xWQQOmKqMYxTvmSr5Cbm+txMRTvcF3+Zsx2JnK2c1aGVD/MkvWAih1D7zMkxyfTKT
	H8E2/3iXB72ELYv1FAWlYSHpkG4n70seoGprrr5QafMeMd2z0C1eym7GZw8vfVk9rVqkeEI8SGV
	j6iUTfsVdh6tqwSy90PyVWSpMF0RYHf6BzwydpFeboQEPhEL7MzZisQ/S06ChMTpbqTMHun3bF7
	9O1KtG1pe/AS4rnzheHzUaK1rRPShHx4bWpdTHw5E1HIJzg52XjbHREyS3m7us/4Sqox19y8S00
	R4iEtN3b1coixPrxA683ODcOckjHIFUjJIrZzpP+X9V006AwzXLRmZ4/oRHFQu8SeMw==
X-Received: by 2002:a05:6a20:728c:b0:3a0:b781:4c8b with SMTP id adf61e73a8af0-3aa5a3b4ae5mr15654076637.2.1778266951517;
        Fri, 08 May 2026 12:02:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:728c:b0:3a0:b781:4c8b with SMTP id adf61e73a8af0-3aa5a3b4ae5mr15654007637.2.1778266950964;
        Fri, 08 May 2026 12:02:30 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm13395550b3a.19.2026.05.08.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:02:30 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 09 May 2026 00:30:02 +0530
Subject: [PATCH v5 13/14] arm64: dts: qcom: glymur: Add iris video node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-glymur-v5-13-7fbb340c5dbd@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778266845; l=4603;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=PD1gpoX4LAukVY7c9h2PcdOHpE6W9WE7RaExHqCiq04=;
 b=htiCnMycUhTW/Y5vw5fcLiYicxLdxT/NNaRRSIKx18osZwk43fBMd9KncaKgqZw8SRXyJSlIT
 SHtVHVWIXhdDFgd/k5ijxLMYZoehFPiEUM8psXH7JzaT9//S1R1QqJG
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfX+gBWGKRU9zwM
 pt5//PLKp6jdQcdhBjGbkMSrXY5lrfpdAC6rz9EynYYSvYIEuEszhqueiHOGwnflgHI34IKlWvH
 1xCtRJBUkqqP7hzOD9YxINvqabXjKtkScTHp7+9Qq210yHssOT0xayNALXhNrVmw4/3TtoSWcP9
 gmFVTVSEuj2W3bvzHi1bskRQ4zFtdCQ+RU0yQENB2wbt5LsiWtsUa0OHD+tL0e4Ah3TTpechi9T
 PwqrSME3oPN6eOs4w0CvDk2dhzxlndZXsaisO29vhExndfc6B6WA9C1xTKU/ou3k1DqNldMHBj7
 OYL5KTx6gT1kT8o3Cn7xyWDdF1/XzgZ3k7TY4HVaostH8b0fem440ujbFCwhEocJBULkX5wGl/J
 rV0RC6BRhusfim3Yx2ovCfgI5TTkoIr0GZ6zItb/93oyoYmMXbmvMAITYpc7qyzgflAGb1vgjng
 RVnWaPYH7l2ZZhL2Txw==
X-Proofpoint-GUID: 7viPbw2tXfAU9buDK8kQT5LXPd_E-pEE
X-Proofpoint-ORIG-GUID: 7viPbw2tXfAU9buDK8kQT5LXPd_E-pEE
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=69fe3348 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VYrRtalYO0MCCBblpesA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

Add iris video codec to glymur SoC, which comes with significantly
different powering up sequence than previous platforms, thus different
clocks and resets.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 118 +++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

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

