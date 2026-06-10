Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8246380FF0
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073084; cv=none; b=fk7v4+yA8Bm1MzpbnIR6c6R4weVtKlmOSmbGHrmX1sWJlHrgUihd4h384kpHTk6I+F0Iav4rzBQc0u4XvAGeXKev+XtSHYfWgb3avsng1hnGdrg5z42/VV276V48vKg9pyjxLEc6r4EqPoM1XbQYxZhECFSr0JedaNFKD/02od4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073084; c=relaxed/simple;
	bh=rcTcJpE3yUY0hhm6BFw1uxVSjJS5mYu2YiKIJn49g0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VYWy7tOER+nDXCd5rjFyO+gT252Sg1pK1daja/ovXPYXJBHtehntd3qkQwwAXzuOHLNFykxAC9Rlnk4Vb258HwJw/CdEUe0BHIjTefA5FLqKBeKaNqHDAB2qjltkXRreIR22eC0FiWzAdBNz2H+9jBIxrXm5Vl8kg5/X9g18sAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g35Zk0vg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFGQjq42; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g35Zk0vg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFGQjq42"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A2epXv4061498
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P+ow6PHZ38D9xAFsmHnbWI7u94qafZAXWP1UyjrDZ+Q=; b=g35Zk0vg7iU/BpzS
	O5fKtCwwjUn3F8hCEF6VYLiqgzBcnu7oWGR2asiGBQcnYKEjVipGP/7yzrQZ3eM2
	8B95PiK2sL7F9LGm7e7TgDFoCeWOi3zwgpxEsFaMFeSvNRO8VqEB4XssLnguYbMS
	tAkgYvjhVXiutHWRtlA3avOe8jmjJU8DkYOhxNdYVyR4ZledzZtxXdYk8Nxj6YoS
	0TV7Pzp8TBROhEHRez70cpA++EbSnut76wNcBGsMIqG546VM5nXrbua0Lpwym4h7
	au3K0cZ/ycj+0PlanW0TVXx83i+TCBdPNhKpx6DWRVtHPe8IioKelXqxe5kCtoyX
	GhdPxA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnh13aj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso7197708a91.1
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 23:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781073080; x=1781677880; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+ow6PHZ38D9xAFsmHnbWI7u94qafZAXWP1UyjrDZ+Q=;
        b=UFGQjq42En0s7vmvobcW2IshzX/8HbpwnsX9iDv6zAfsVAGVXmUycXmZieCsi8AGoQ
         LCR9QjA/kO6Un2aiGQ4+urksMgNsc+lqamQHR2ApuONL2B/caAHaL0dQpgU0+BboumcC
         0/xn6mDhw94svIzSt8VzUCWdewLL0aC9tt7je/U7zJ2VXfAeOwqJWOExxaFyJ5BgRG8c
         gRr6MqYyiFtBQDbifM+YyQqSjxiczXwWJ1rQHtQBxIG3nm3AKRQzJTdxEnPvYIgFNWl6
         +Wt+7XcN9TYAMKWkOvguPU0zqNk15tlEsXits/e4w3mH0NvLCPEAYwL9sBxbY8LpFPQM
         Kbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073080; x=1781677880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P+ow6PHZ38D9xAFsmHnbWI7u94qafZAXWP1UyjrDZ+Q=;
        b=YgfiDOECVw/pE1ZzCD8YvxKFR9NPSVaXS4RA6gTvSs750fMn3wpTJE+GR0unFGms7U
         srqTBeMm/+PPkOSdjVtizAXikbLxfE5HN0Wbm2gjzFyCprAZfXHQeFNuL7AkgzZlsRNa
         mDvn/rq+x+rh2hRFmrqh/IPE3BBSlyvJZcHNNEDCnqOnQOUAXqP5bUBPJQT/KN1d4PD6
         RVpx1Cpd0kFlL/nV5BlAnLWIHrM1EmCBHgsqMGJzIGDsruwpKdps4lRppWoE6A3HiZMn
         dCiRcAwjfM164C9ayln1hJ25l2VsX2dLc/F7SqF9g3vrokSxMYDkPwzKU67LyMxUvtaP
         sIKA==
X-Forwarded-Encrypted: i=1; AFNElJ/di4e99WbjDr1zJe8560WkrSXwkM6tLW5euhHUH5jaQX2+QBpZMVvirhDBCgWqIo55H9kE4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz82nqa5Y8OR2HzvbPy2JxDT4gKTOUFl0iw6Y6AfIS6OCDN5EYe
	RXm4ItmAiK6KPvIE2cBPCW0fjqqIkX7h867vDYNkNM8wx995ycv8V663av7E40O7AQd4cQ/ubOa
	aUJ3jbcIbQS5+TzlclmroATdkfTsiGoagfMPYPYSrWk3xZqfTycFWBCQSfg==
X-Gm-Gg: Acq92OEI0E+Q3KlGrzpl7RjwkyrG44KiVYSDz/gkB6X1ieQNVAnVktFvkLyTWjFS+Mb
	kxXlyIxceIASGgFJgjCUy66y+7K5BNW0T5dr48sB4fhx+kD/W712xtJexxp+kcCt3pXj9FDIS9J
	0ChEMA9FqA6LLF83iNiwznDphUX1GPhR8mjhFsC2BPNmzuGtQwguYAOvsU6ladL+gZu38UZgOCM
	21euZkf7dwyiddvKhg2VlDkgrXzyZ8VJlFS9CwFwEYL+XTS2HvS34RelYdDunxKnzmrg7vLMfvl
	1IUcUJL0CKmPhAO9x+fLuSJ3KQCsiNf9AHbHj7OjFUM2lfWiJh6X3MMGYX9qeOUElqmdPG33Qkk
	pEyqAp3oMQsBfwtTGEHQ16LzuVN5I0We1LYf8T9Jscmats9PNbetB4DUpbWFBl8IRQw==
X-Received: by 2002:a17:90b:554c:b0:36b:9512:871b with SMTP id 98e67ed59e1d1-370eed0b682mr26380326a91.11.1781073079599;
        Tue, 09 Jun 2026 23:31:19 -0700 (PDT)
X-Received: by 2002:a17:90b:554c:b0:36b:9512:871b with SMTP id 98e67ed59e1d1-370eed0b682mr26380303a91.11.1781073079201;
        Tue, 09 Jun 2026 23:31:19 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm21580420a91.10.2026.06.09.23.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:31:18 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:59:47 +0530
Subject: [PATCH v8 11/12] arm64: dts: qcom: glymur: Add iris video node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-glymur-v8-11-1c79b9d51fc0@oss.qualcomm.com>
References: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
In-Reply-To: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781073002; l=4698;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=rcTcJpE3yUY0hhm6BFw1uxVSjJS5mYu2YiKIJn49g0c=;
 b=WLhP8dSPtgIXOpJAAOfN4Xjiqv7drSdsGLGTvi/pe6540Dq+YvtPdOTo94ABMC+6O06SodSdE
 TyO/p/kkdw3CR/q7PKW41DuU4ilUyX2ad2si7+64vdkTC0ttH9MZi3V
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1OSBTYWx0ZWRfX/IWjeoCrMwNY
 vgr3y5VpEwHysGZhTnCXfnjdXxSzcrUW4mSOTshMWOT+AwKQDLobPuLXBBbapMej0UQtAfDoft6
 HdakMxbXmpy5rvFi4rI3bwjD8Fy07x5LKOZCzOjoyxOdboUl1UiFMYzKvg0qkxY13/A4io7XKSJ
 BPZeT7yFtvJLIG2XEpTBKHHgOvOSQ6SyfQg6iKCO+i3xZzj1AbI6PxMdT87Z0s9yx4WtsQscFDp
 12mbkN5tJf0U2RylhpEVv3X2/90szW0N3P14EceuybaVxN14uci8ij58+aNQygKj7WuBBkfPayO
 +TloMYP7XTqMefbBtrANyTJD+UKTpLx2BH+hJ/zozBTaZaIzSysMHhmwu7c8tBwmsUfSbhCh4qi
 ToPKXHXoReL2Uesc84Jrzrf6sqdPpsBYEt0hIX4Q9UQ3lWDQ6Ac+aGAdUFHpvEuQYVSFiq/8scm
 rb4U9EVx3l7XIbvDYtA==
X-Authority-Analysis: v=2.4 cv=Xce5Co55 c=1 sm=1 tr=0 ts=6a2904b8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=scTG0D64rx7uByHHbCoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: eShIvZFg3ciQheqecwWBeGEuL3322Kq3
X-Proofpoint-GUID: eShIvZFg3ciQheqecwWBeGEuL3322Kq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100059

Add iris video codec to glymur SoC, which comes with significantly
different powering up sequence than previous platforms, thus different
clocks and resets.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

