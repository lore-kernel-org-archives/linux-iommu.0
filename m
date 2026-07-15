Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61336F915
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124700; cv=none; b=DnnMulMfH8wwhHKMKoDo6wCp0HqyUk+hHMddfhAboA4tQuynUpYS2Mxug9Xj70dy4c61KHElMlGnqDkRNhAH2ZEfAmgjPyzhr4c0ibBgWWbOtfP5g4ViaVVidcbHVAXd+0q08QpuX2w9/hUJThF/5vBQsq4ShE1a6GrwBqI6s0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124700; c=relaxed/simple;
	bh=ThEpJZbAgvG9pFpNsommlTVzoWTwpScz9NRkCoa7E7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSBxBroR3LT/e88n3bLDC0ZutRVy9CORElD8m546rkdCR4Zj3OXiksGSXXtxH6/NKJ7Z+kJPVYaE0EZvvFsGYp8yH+04FZwVPAaal8rRAQC+cEb3s5stWGKXjArBCRpXposNnpcsiUoU/1rPh9HYiYQe9OhAUMayomRnJ2UKLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqlTzEc8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HBhjT3pr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqlTzEc8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HBhjT3pr"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FE3dba3806326
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vvV4pvswORAcEQzKnup026bCMWgfqp/zeG31LYavPqE=; b=lqlTzEc8uu+6lhsR
	p0PT64rERBqTMNOoaJ29a6OamYGcs15P0W1NSl5jmBE+oHGAuy8whoMotkIcVCLc
	sSLOiGyW7XYvwbNFsQ3G/Sf79WQivb4xRCMEdVHKzVdBfIRJDiRxX2m4LMBPXptr
	cYDuSJj8QUQ7N69uGtcVMQ+PjjdmFqg51rjRsf3CiE5X3mWY02BxVbsPtMf1Ce1/
	hkOXNPCtxk8eOPhqDbG6ChlI+02IUqWdO0ytswLBGtEFWYIkPOw0F3bD/ZLTFH0T
	8tGN8QEdcfwEm+N7ucXDUu5sOq/wAogG2UTBylrv8Zd2d+gYlByf4I4Ohbq0aaB6
	NB0bxA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe56h9pyc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:11:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cceabd70f5so50740595ad.1
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784124698; x=1784729498; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vvV4pvswORAcEQzKnup026bCMWgfqp/zeG31LYavPqE=;
        b=HBhjT3prKqCi9+J+ZtXOoPObCD1PffwtstoEctI41nIJ3YjkbLNsuY3y1zyOCBFzRt
         JN7wbuQkpqc97TyZTk++sKp98e1ocqWYTUBNWnZziZS39byYzBTum9tJMtqxpkOn1z4A
         NBp5FLg63QYR+u/A0jE0VBMkNyrJf9UEjxNa9OcxtpzW6ROWhO8cI438RRjZOMBQgoMj
         b30Em9ea2oJPnX/ZndzcZqGPjHg8dAXuf2cmSxQ/qXVPem899kE/cT/PxtPre0SpAhKe
         NMvkBA1iUWFnzDAlHQ63fjMpMik1siJbQhGH8Hifj5xn3MdvKMaD/U/lmOoJNAfp1s6E
         dh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124698; x=1784729498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vvV4pvswORAcEQzKnup026bCMWgfqp/zeG31LYavPqE=;
        b=VhGDILW8ebe82mBb2Ymtxu6/rlUhBGLA9b+yUKmortl5MF61cIY8/3bg/XSCidm1Yv
         F4qARcAMdZCOb7I63deFQozJpSkBtmSTwj4aMXrAAYl9yyeNd6/tUweV4QlnCdUjsS9h
         SFg0M0N7DEPtNv9clvCD6ZXedKlL5a4e+picFEyCoPi4CXV7R1gIFNZt/xrCeTrfIM35
         2xxGP0HT1SME2jIdouVvtn16DRaKo7arnblx31Pkrh8F1iVU6+InU+Jp9pVmm36tByLj
         T++FHKDbAc0R9DcYLLlcfFBB19OqwcPosECmP70Us6bRAVZ2/9Rq3jl3to2C6O45RjR1
         6A4A==
X-Forwarded-Encrypted: i=1; AHgh+Rr64Tu36wGHZA7gYqmqjyIBucPhjnXirQycZd4hmcazj006vqFz5UvOzjuj7IgeI464E6HcqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0EBw09pNHYugSid0mpF6BLofAb13Mo8ILkpji1unYfBfO7YeT
	c8o8ax0wGkwx8qiG+97uV/kFVu9/xcqzKVjFe51dJT101AoScVi8O6FL/edjp5N8R1BbtikSjB8
	RK6Eqx1B9/exM5WqLX38H1SWUorHNZzrguE9wa/w4GKzLJ/skK07ClJsriQ==
X-Gm-Gg: AfdE7cnPtZ6CuHKrHa7eVMEtJcbqHS6YmYExoE6ZOszHk7aVnFbEISiys04uJ50/qSw
	oIF6nUUQXTAxYRzf128kNdKNcY14WEcmkbktbXU4gr70Iko/1iWEaGq2gqY8aCfTfTFOKuwXPRC
	f0rO6lyDdTS6qY2H7Ap0onkjvtsXSc43TlhkwRKD1MqWMtyLEGErkkRVxqtBPyYfIyp9tN7Hiov
	c9b3ld+l0Z9ApF5da1nLxEH5VvqAIb3dpbSK6O40Ml9HsI7G4G+/0utYLh40glmTqwDUhWXUJsR
	Ak65fgTDcVAUsgyxIeLy0NZRyKDXJLUyAOF8BjjvmiwVxu+QMpOBSP8fBYz+dXYRzheb8knwzQ4
	Sr53dTgrOcbRiN5xF6nsOhs2bS8hWaZ550ekios4Bx3hu
X-Received: by 2002:a17:903:2347:b0:2c9:e961:d256 with SMTP id d9443c01a7336-2ce9ec0f113mr171957625ad.27.1784124697704;
        Wed, 15 Jul 2026 07:11:37 -0700 (PDT)
X-Received: by 2002:a17:903:2347:b0:2c9:e961:d256 with SMTP id d9443c01a7336-2ce9ec0f113mr171957285ad.27.1784124697088;
        Wed, 15 Jul 2026 07:11:37 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1070b68dsm2913215ad.79.2026.07.15.07.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:11:36 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 19:40:07 +0530
Subject: [PATCH v9 13/14] arm64: dts: qcom: glymur: Add iris video node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-glymur-v9-13-8cf2cbe12a07@oss.qualcomm.com>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
In-Reply-To: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784124602; l=4709;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=ThEpJZbAgvG9pFpNsommlTVzoWTwpScz9NRkCoa7E7A=;
 b=9ujYTpL9Bpg/XiFkL/oBYJbhhOvFR9zlKPdFHI1S6pIGQONr89kga4PtLHFj0EE4yrzDsfSGf
 vZClSs2ZlvwB4pDrCWWJ2drTRWol8wh8HdgdZllJG6oDbuMKh9gvFac
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX0KqCdm7SVL1s
 LS/uo6IfF6000R0z2uYqQjzSzLA7u4lxp/Gd+M9y6D0U9T/wcViOECrGlGWciZz449vLdMTWj4G
 jAtTYlEspaRrtCnWyzFBWBx6vakaR6A=
X-Proofpoint-ORIG-GUID: VQTMwc9YcVOJyfG1JQvDAWIAILvD6U9c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX8r+3Wz1JZO4C
 Wj6+J3PWhSajloW5id7a/5FOOqVSk+huvxU3tjMJJVJrBQcumzLj+JXjK3GmCBErVlf3QymQj//
 dj7Eb4tBWEIT8Z++XvMRDj8o2TSwsvrl2pUoVzJIXlJJtDxA7/fzqvuPLT1BbnD9uVvH1MKOyYP
 mD3xnIYwn9DK0ucwQ8pPCWKBtdwQSN+QRriz24L1IiotQ+U+MBgk+Ge3vcIzIW8iuBNVuIQE5z8
 1/ZkB32DgXdE9JHsLIN0WgJ5XJGDvVa9s8jhPBrl/DD6aDVkUKvwSTUj1wckG/ijv/Jxe306tss
 ecJfq6SI0FzqYDhPGgvis7Xs070PW7Ka9TQRgWEB430gmFh/39JvsKxaYuLg/84jbj9Wa8jOloM
 B8sAhZIT19wvRsETZd0LcTi60Uk7T7IbAQZGpYtpBIvdWYKb/l4nvXB3Gx1Y0zZfDSrpVzRFunk
 jCxpcoa/vMvcOzXgXEw==
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a57951a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6gKgyGQvtKUNEtbwe4YA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: VQTMwc9YcVOJyfG1JQvDAWIAILvD6U9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150141

Add iris video codec to glymur SoC, which comes with significantly
different powering up sequence than previous platforms, thus different
clocks and resets.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 128 +++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 55d91c696a3a..0c09e700f6b5 100644
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
@@ -5321,6 +5325,130 @@ mdss_dp3_out: endpoint {
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
+			/*
+			 * IRIS firmware is signed by vendors, only
+			 * enable on boards where the proper signed firmware
+			 * is available.
+			 */
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

