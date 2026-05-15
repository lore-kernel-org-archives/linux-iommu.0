Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E59480DE9
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844292; cv=none; b=NgoAnAt6edSpDPjvorcnLvQsC5L7kkk1duutifB0M0scjj+61QSwKuDrSwJPrvAJgekad3Pk9LWoO2ivDbTBfAyJ0ND34XisUGsQYuksZHraoeODqIo3QullH/LIUK5Pq5b7Q6Nm3XC9xrg9qPbGvYNjf4o5axTPFUAW1lbu5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844292; c=relaxed/simple;
	bh=PD1gpoX4LAukVY7c9h2PcdOHpE6W9WE7RaExHqCiq04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EblSM0sa4/oatGrfeZBLspi2woQdVLVE6OU1LiR5AXE5WMrlUwS+fjiWJ4ecGvL/oKvIjf6QawIBArlZYUN1WlUF1BT2FxbaSd0aAcjxdtyK91Tx9vHz26rBVqIW2B5p6EmPapZnxebTyV/hgq4THgveXFDjKHmRHeztWdYvKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hERO8Hl3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hWqtrTZw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hERO8Hl3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hWqtrTZw"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F8kZKT1714932
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	geJxq8Fym74xZf3sPrd/0n2hwRmsRBx/QMPFY1ao6wk=; b=hERO8Hl3xPxqS3SN
	t2kMhuGHwde75G4FYB8m6Sr/8ihrh6zqw4NrEOWnA08R5sKtl6tvNhahDO1P1G05
	KRYymDA5SXXN9ViRrWtJnkH0LALa/BRdKdnGgq2dJJs8XI+4SOwDukUCYbZJ1i1f
	xOyLGKBB0V/FDsKQrCNnsDktcJtak7CSBE46jqiRN/Bb+ekEaZXoNiNeBwd+qbcF
	SpySJ06RnoX/0oED/ndj7KzcwlrBnytkxJpIANi2TVDWp9KxiZDzA6eKMfXQA2ni
	g+3pIkKX1AW2UikLDHLcPCfCMjTBqlfE+syXR433DLmTzarkVtYqblrTVNK90Hfd
	a1EI3w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5tyxst9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-365faf6006dso10541212a91.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844290; x=1779449090; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geJxq8Fym74xZf3sPrd/0n2hwRmsRBx/QMPFY1ao6wk=;
        b=hWqtrTZw5+SUJILf2BPlaw99KlEAs8RwW3hSoQ7UtNZxaAWUqVC3qiP9fbjiVVuRrr
         S7l3oiqilOhR8xLsAPPQuZc9EVD+PoMJNzHTP7YCv8rgFQZMVoFyAg/z48kBdTVzaQgj
         5qzItTLuNlvH47sqpkwZde8cb/8UYuYkql9VILLo4NUhsYmPoKGZQHa2E9+avio7Jwqf
         BYnCcbPauSIei3IdxX1LBFsi+6YDiY7CJ+mip0YOf6UtZfQkge3iX5aZjpLLyMjbuwgM
         n9/LFPQHIlwx/WI+i2dRfe0CJvwLAY6sbQZ3EXY6Iny+ZkitZnoTN16lOH2eMA0QzWcr
         vrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844290; x=1779449090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=geJxq8Fym74xZf3sPrd/0n2hwRmsRBx/QMPFY1ao6wk=;
        b=MNqhL9FC0soGEaUFLqWI4EXoHpD8I1fV5CnrqfOdFOoA4bfmbz5CrDk9tQbMaQeshD
         hzpORYNtr4wSGKtG7t1nCrw8b9R0/wTQx2qPTH80IzyCjMl3V83gR/8e3cZ8Xf4iUCKb
         ez6i9mzDtu7MpgrQUHiM4J3cOrFJ2DQVoQjt0k/jpKgpUqAYW4NNzT9QlvLok79xBlMX
         ijS6uemwlG/76r0V3Zr8JwerUOj25LmRwbEs8B4r15yAXLcd0TkPZtaW+H1W17IoLQvi
         l4Ol1ln5NfujT2yWeET9BDdHl6DA9X8Lt6Fgf/3k0acc3B3PtQ9H13MVkfKF+eborbSD
         Wkyw==
X-Forwarded-Encrypted: i=1; AFNElJ9UxvBglLvSurwzMNFtNrDbyjoCrdbZpuudCntg91Q5KkMrDJIQDX/+yyJh0FBYRremjFn3WA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhUW8YNfeEeHoM/XPReSP3CD1l0ZmrW90C3cKpMgwhol3VDJtW
	FGCp0NE+KfBvAlwl/HRcqfeR8Iv36jShsfJ39D34nKNEuLOHOJNGhQgjYW0nO8ip8rXStFi+foJ
	s/SWNMZZ0+pbBH7e5n+bKMQXd/HkkUV61jOw9jnSNIJ4oabv1b5hM1XR4XQ==
X-Gm-Gg: Acq92OEvqWF9ZkQNCp5CnCM2HZtG+29Xo3pTOvkmwX0BiPUNUexJWHumGUnHdDEMnM/
	yMwRGh6DgCHMTdSLglPlJKyXbhMg+Ev3cbYw0kqER8SwkbwyIh2/o+u2NJiYxnLJqE4eV/i+U+F
	jfL60PYdxlNpgwJLtce5egXA3EH1FM6BLzF+FVjYyQ6xh+QXU/QOwSkAWL7GOvFM22v9ng8TGzX
	5vgf7ovLtmapvPisrbw7LOW9E6hAHjckhXCco0u5fRNga/jgxi6v0PKDjtPO2g5PBBs53Qu76o7
	uX1qM9ScIf7fTr6sMhBn/uphaFY+7IcykoiNNqaSFs90bWLYaVaK+aJv8FHy3c+5Z5VuxnMwtbH
	hFc/cr4/MM7uDffR5sGpuw+tdGkXcCcyTC2WFiLhTL7TFMgWPM9R+Kc0Hj6/+jQz/NQ==
X-Received: by 2002:a17:90b:5808:b0:368:b881:b2da with SMTP id 98e67ed59e1d1-369519e2d13mr3830601a91.9.1778844290385;
        Fri, 15 May 2026 04:24:50 -0700 (PDT)
X-Received: by 2002:a17:90b:5808:b0:368:b881:b2da with SMTP id 98e67ed59e1d1-369519e2d13mr3830549a91.9.1778844289795;
        Fri, 15 May 2026 04:24:49 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:24:49 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:28 +0530
Subject: [PATCH v6 13/14] arm64: dts: qcom: glymur: Add iris video node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-glymur-v6-13-f6a99cb43a24@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
In-Reply-To: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
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
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=4603;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=PD1gpoX4LAukVY7c9h2PcdOHpE6W9WE7RaExHqCiq04=;
 b=RafsrPim/rP3V0hWeEn1IFZtpupVqQAaWH4UDuUEcPA1FE3rDk252otVElqHF1B667wj06Lai
 xA6l+LxgTOSAz47lfmEmHmMoLAbV+wm19GnyKSFgLI8CdZ5wqWGBcvH
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=dMWWXuZb c=1 sm=1 tr=0 ts=6a070283 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VYrRtalYO0MCCBblpesA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: _v0w1q-kgLyRbgZRVJVaHAHaEXjYtPrB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfX0zt5Ab992wH+
 OA+/gopVQNiytPQGqw1/+PFrjgLsdMP9lFwVwKtgoSVCso9Qdq8P9+U+VqpB0zjYdY+/i5fRvOe
 F42gZ5kHr8+G5M1fmNgSoYheGhVl9pbR3LxEq/gXZTltl3HCEWrsMzTkshin2LEbiX4ReoIw6zX
 TR/5XRXsi8YHp9ib2CSti3kIqnd1EYNdYp090/5Mg3Rbv/234isBtZpt8Uq3pi8w+pTXCxfb2qb
 FQCxxH4dHTTXNLBn69GNUBvEBAf6j2dMBiHxK0vJTxqcpEo/j4kdCXesphZ9K2kgrnMoBwrMJ1T
 cO+tNlXo+Nl3lF+65wKYUP1GP+jecYFahc5oILbXMs1L8poWzqbSEk+EBDb1EG35M0sewURYB+n
 AcQkz/PDK3nfykBHJu/VvmXUeGL/UoMk63rlYoWO4BWsDGxC6+6O6Vod23mNs1fQtcMfLtVyGTj
 mccKxet8BDrqTEV8TSA==
X-Proofpoint-GUID: _v0w1q-kgLyRbgZRVJVaHAHaEXjYtPrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115

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

