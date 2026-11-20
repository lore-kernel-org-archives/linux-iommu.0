Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172886;
	b=BS3ZLIINKANecRHrrOrrqPIOycGAqE84Uw7WmePAVrfhcyhqRCG5jhFBOSx5rfDeUR49
	 Pi/5uYzuiKsUsAbiJs5T5Pm0kWpz1hAHCOrqFBzVbPRGsG05cwC3ppeSUVWa9QwZo4xcJ
	 HnwrbBy6G+k0uONCnb7TPY/JIOotfmygOHoUoml2TPXnOqLYDxZ8PUxWT51J9oKqUxyMC
	 m9OOtWKPlxl8oG/9DQhIyN1kS58j/dX/6rrAj2Sh+FzHf2zjkLQXJ0ZIE7o7j6X82yA2I
	 TGRU6VLx2HK0StqsSrNiKo2WvpEOHykBuICSRANpOAPbGXTTF0yB0AwY1tVAXf2LGxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172886;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=drpSu4HheKaqlFGXfa2FVpmGxrRLS+U8hS+KH99KJHU=;
	b=bNnIqRc0KIF/Bcb5QnqPomHAq7o6DCqfKXmtTT8Uiu6IFYZqQQqdtwADiaVtTSXIt+9Q
	 S+AYYHsu3d6gAQjbKuEx6ih6JlpNI8n/0gycvcEDOXRBtEkbpaA2gSKFAIwLjYdFbYjA3
	 K03dGQMSUJphSvmgLuQAM0z/KOdKZx/PiyjoVJUcqMeAk5Xv3sD5RJ84VA5JHle8/7dYY
	 bAVZdsr76ZlNyFVlDKj+fIA4w+YsUe+GiPfWqxPOf4uApHyWHxIgOJYrXqF4XYP+hFrkp
	 6xLKmzovB41j1sStsOSLQb0m0es2/C2hXWdn75mH23PgAPRmczdffI6VTbzMNIkb/9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="ggyc8/hy";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QbdHIBJI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DA60A2630
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E4DA60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ggyc8/hy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QbdHIBJI
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkfow3107607
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	drpSu4HheKaqlFGXfa2FVpmGxrRLS+U8hS+KH99KJHU=; b=ggyc8/hyxmlWS//p
	IvODsdges0NNEEIs43B2ATBJOjzvWfwHStiFyHfdclZtyYmrcTVan/UBSiHQPiBa
	pmXLOae1fWbk/32MeJlctcEPkuIMSxbMywnbCUSY+HmnoJjt3/kMtGJwmQg1GPi2
	LDFYYFBreFl3GDYzDzum3yJtPAEaRcU4u8COdKB7jjj/Wb5xGaAg2yX0CasB8QP4
	fDAxoXG+cC/xd75ozCAYeK/hIqrqHIggVHmH9iUqprcFZy1Pua9rTq9BloUsEvCi
	sMLxmlbxFsWJAUbIhPhe0fxgI1PXerT7PRRYYsLz/OxfZBcc3oR6yIJn6GYqAMEB
	5BtBBA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au3c02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3854627c1c8so1079129eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172883; x=1795777683; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drpSu4HheKaqlFGXfa2FVpmGxrRLS+U8hS+KH99KJHU=;
        b=QbdHIBJIlDpdA/u2FgMy4SDrAoEL4p4g4DhvfeXYeUH7p16NTeG75f+WIk4Mg0Dali
         W8VndT57xOzv8e9sdDZEP0iaYP8QYS/n7hcn6SGMfX0XVa+PsOdh1W+9Uvi/F0cF0RMU
         0w5miWuTzDVj4WmMTKCyAQDZw0ZpouZJzEvUAu3UNKYcfwhwapQS5P9MpdXx6ax9Cd2J
         ktkGKx7QBe/ZCo+AheGtrldtGMcuwFau1CXEb4EeDNCHIc47GOdmjIzYTdl733/JL1Nu
         8jHdCbcmx1WBjaIHpe1wPq9fpsa7iEsI5tCwU5T20E2gc2qAl08YlfK59NKaG8Zv3d5X
         vRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172883; x=1795777683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drpSu4HheKaqlFGXfa2FVpmGxrRLS+U8hS+KH99KJHU=;
        b=b6NcLZroPA2edaOqi1VUabiV1oyml6b7joMxTkAokgoO8wLKCpDKCImDJ/IKGY2P+B
         OS+SC4AxyBfsmgL7DlPqMmm7U5lgoEkNBQmotA2yWL2heREy4vzvpuXVPlqdx9Qty//Q
         GrFtVVKp9FP/HgaRjUQbO0BnPTRxg9Hi+6cM7Y42MeiDUyUARodIWg8WRcWqJafpFpNx
         O43zKQPwjGQ0M1vR95wCh7PpLUy7PmhpzTb8Ovd/IHcU7R2eW0KSGPdA1/1tlNEwO4FE
         zNnT9Glbc4R0W6KGp67m3YxuJroPFrGYqJKW6ipzTYJATmvSSoPM/+lK+sOrdvI4toVH
         CJyQ==
X-Forwarded-Encrypted: i=1; AL+hErEuackpcAh7oOTfC9vUI8Wyyq4NHmgIAmzJNlhfN+l5pj1U82e80C865W0RB54L3UBl9GEDHw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9GUAlzbXQQ7YIJNYtP1gBEe6EK0WHRk0xzI8QHHg3u/DDUhvgY
	IhNzfsPBkDUTew5Dk4ObDIMUXPaVu+Thjy9Bw96oRNfgTXfELcuHPpPs4/05SrVSVcPuhnfwa2B
	7r9/t6quAvNA3kHEPWm8V1hg2wNsVRp4SB5yPRAO5rSqq5cVOBVRCcRqphw==
X-Gm-Gg: AZFdTZf1LLOyZYqO8rN45uTkJ3ErAE2FmIAJ3Dnia41JR2T4A4adBHzFOzM7UThnMz6
	M/mLRNgROhHLZNmGpLtQ5ABpfExFSmNNZ1G6mxhP1V/8EgulQ+/WHQJdSJ20CyMSVRu7XoIWyTK
	JFMKS2PiIqgHvNBkg2sStjq4KcXv83maTJ0dNohBBKSc8jeS/q/Iw7+FXV5XJsLwCbW/ChCIOO/
	zejAyQDSnT0qmaTkMyRnukyh96CqQCskoO27OaQ44EKmLhmxXU1QLqYg4Q6F1dqQu+R1d6rsWG0
	bF5ELOXC8Hr76lLxw/7CPewIcZ2bMCI7v7FwDjtRX+9/923ZmdJqXj5AKvA8mZR9z0kDmPtoK8q
	IwnmmCetWyoVCn0t8ManD1b94ltrs7OyQCrnGW/SfncvyHR9oMCysC9VLFrBP6TJxfmrf01FuJs
	ZPxe9g
X-Received: by 2002:a05:7301:6182:20b0:381:fe77:7d31 with SMTP id 5a478bee46e88-3856f14707amr2344794eec.12.1795172883000;
        Fri, 20 Nov 2026 03:08:03 -0800 (PST)
X-Received: by 2002:a05:7301:6182:20b0:381:fe77:7d31 with SMTP id 5a478bee46e88-3856f14707amr2344752eec.12.1795172882285;
        Fri, 20 Nov 2026 03:08:02 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:08:01 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:55 +0530
Subject: [PATCH v4 14/20] arm64: dts: qcom: sm8650: Add GEM_NOC
 interconnect for adreno SMMU
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-smmu_interconnect_addition-v4-14-cab8ee8be0b3@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1282;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=nRKWODwhqsti/JCMKzfpHOUMvXfhBSP+GT/cARrj/+0=;
 b=c5WtPJ0sQu94WJMaTQu9JE5PzvJ7kuyQVvPNmn3/oAka+ojdMg0UnobB5jSbCZWOdUIE7w8Oj
 i7g0V7lmEc9BM4/rk317+KDNiQCg0iQXHuwtIRhaaPXA8Cy9CozEvTO
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX7VRNNuxsm3xw
 V21IyLW2/5Xe+d6eLUhBePk8gVhcFPI6vzzZvtZfe+LzL//rHQCfJtnIMXZC+cMyj1zS8pu6nr7
 WqW7s/+T+WD4eA+PgDeyNpJc2jOwERqttVBakVLZkQabgfRwBy+bmxZkKaq2PPM485u6ckCs3nO
 M73IxbayON55yTvNDihwAuVys3BgaQ5c/KirrZIPJT9Rhr5m4P6XIJy+z7c1ACAAhHwtWI4XX7C
 zJaffx0LqC0JC8hwEwaQOY80dc35125lArSmigw3JyQGv8nBrZC2IWF4lK00qab0H+m8+IOy9jm
 NvuW59NEJT35iZvSv5a3qBNjFolZzypG8ygxT32Nt+TtuElDLuTbL46VxvkHjrdvMXVRTIw+5RQ
 qn2iZgwmrGgZk3bg5opPanEcbpLxPoimdSG+AWOH6Mdl8oL4wJkBEbulQ6RNKO/CSbruFthe0BF
 qhDuH5iRXE4z+cn/uZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX4zW7d7YPZqee
 zSIqrZ8kpPWJDQ1wVTSvJkUgwcVfbzKAtxWVB8ojKhBa63tIGEON93IbCLgG4wBV+ALVAB3bW7C
 1M/qwGsZgWQd12QOPwLgW+qA6fgeniY=
X-Proofpoint-ORIG-GUID: P-CgCT-ncd2vDfGIwGb7y9D8ganhIUlt
X-Proofpoint-GUID: P-CgCT-ncd2vDfGIwGb7y9D8ganhIUlt
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6b002a14 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=UZQlob4mJqq41ALSq9YA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200044

On SM8650 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 5a030f9646c8..86b3fa4cf05a 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4214,7 +4214,6 @@ gpu: gpu@3d00000 {
 
 			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
-			interconnect-names = "gfx-mem";
 
 			status = "disabled";
 
@@ -4413,6 +4412,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		ipa: ipa@3f40000 {

-- 
2.34.1

