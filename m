Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3328394EBA
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371965; cv=none; b=KQC96bwuuJEuxL6ni1Si6x1qWT7Nf229Dbk9o9mKKqKwOYl+En1eU+lMhS6a7vRLnzbk3iv191gHK1R4kMhoaFfYmINW9St8vN3HbJGojE3ccV5RqDQrC5d11AQujU3X2nXFfOIVwkIlUOKOghDpfLZmpNf/Zmwu5BJv0UebErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371965; c=relaxed/simple;
	bh=I0NgFN3rF+KkU4yqBh/hyP5wG9C/1rf8uLv6/y4DOzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peeeGfUZ8zsYg0AV8cbAUWmCURZVhpBwgzgQSgHGJSFep1SO0kssqRklHTOrMui9aXGCIPF58LyVhWY41hvoqn7NxBcw8zmlODTMN9xmDCY80KgB9IU7rd67jjHp3+OTfroDZqRzhiA7Mk3nfArf5jWo0i+cHW1lKzNPNVc9eOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AbccwYny; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eAzPVfHw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbccwYny";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eAzPVfHw"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEEW41665540
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=; b=AbccwYnywChyPTgF
	RBrC4+h2W36mvrkx3GLid2XD8jzQPcYsCBVJGtpVUJgTXhdJutcHjTzD+D4t3OmW
	lAYD/YbakPxt2eAcAAgatuogf9tjrG0N3iZnhxmtMXA+tqUfaMGgFLTSup/4a7uv
	Ai9+L9f6UpPHNpTh5q4IE4Pf/vvUYu1QZathG5DaDd80P7UTdzhStjUgkoSyK+lQ
	WulOaq6W7+4URzgUeBfR5sepN6WbPw4AVMZYzUHzxtrLvY43BLm6GhQXeLDN7FFH
	SFsdkd+9rhUtY/gn6R1ofBxxyGg3sYXhf8F+1gFjx9+PAI1fjgUsEukv3e4jEKij
	JNNF/Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gtwnh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:06:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so5357450a12.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783371962; x=1783976762; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=;
        b=eAzPVfHwUlcKbKYTBDJ7paLGeUpAtdXftaCVbv/sFDbK2kIfjb/zEj6920zsrCSpvs
         UfBKYc2BATGFzmP+SFtXwNLZwM8DEXcxl+sXqo4hVMkZV4FrsORMkVv2erQVqAIXxJD6
         q4MUgOavxa1J5uFR93udoY58akCONBdMmjEuJ6vyqbomF/8tq26daV0xZMdKJxCm3zym
         dfTMki/7JlMHVqrKjkysSwiymrPYsT0QMTnSrdXO+s8UGSWXATB0kSfqOXmd+1Qv7es7
         u+AEisvBq6dVPjT3hp3UIszxuM9URFYpGZ8bnGjB8J8D1oEheJHGCPuOV0HXPN5oo8Bq
         kzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371962; x=1783976762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=;
        b=I5A6y0eGXtBKbkiOEliVbIyeOAdr/Q0IpH/BA66VN1WiE9iUHjh/V/CeHVlzsutGQx
         kJfSexWpv8ajvK3MjbfjKC7bzRNfzwWyfLM1yseqr4Cl0Z3G4XJGwJxdlt4PrYVvuQ3J
         zu3JTEoLVQC3b0nzPnW8OA5LIovC9LCiUM4mK4Zoazwt1dNM/r1ouS24GEK5kGO7DTJK
         s9YKk1GHD4BEN1DDHmS7lS4Rw19FAsRXshm2wapwfduhG17FMVqKNsfWKhNU1kORrzXN
         euOJebIBaPPZGaJ1FyPor5+LwhaNGm2mXVTXGTzbga0QayB3bD9HsB1v8gE0UITHfxIn
         JH1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoYkkAcihEFN17RFCr8V/+0MYpH7JwHAOtj2libgAVHR1zg+FgRt57yKMFBPjJDVs42cjOLXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkL6ZImdGKNZzblq+WSwbYMeAkOwn+mZHSv1YhvYnDAiclCJk1
	XpTFjDogH/fiJ6HAZyUQOFGzyZCN7Mndz+jC2fLiVeqXbi4EjIwse1WxHnnLtuZV6lOlzuY1gEf
	ccM8di2rIEeF06VCRoeAr0n3b80P7OjyqzA1hstqpuMDc0xgqVfOs+hPQ4g==
X-Gm-Gg: AfdE7clXwAxY+ty0eLWotzMwkK7UcSwWe88oNAHECCprEpBWbPCg3gzPg34wM0xEo9k
	yM5NbkfJdR42n0OkRr1GMiT/Ac+2nTr+Xk0UuLwcR17u6mmoSaQhCTgaVLzYfuFrzN+Hy44fE7r
	g+pvTzlZXfpTGPESZWvWO4Fom0MWWQ/BcpsPQ9yhictFHzYBcDLSwiiPDtBW/Np5nWuY/U7WFvo
	8QTKzzt+753+9bFNPcsiPpP/8PS30jO/h/LZ8Zc2mj/wY8kayGsJEaAZvqe2zNietWCDtT1uwCX
	4FZNk8x1vhlwScJdKZ9Sf+vOHY9uM2eIEAbHYOmE9wHOmEVrfFblzASBJQg2RrA9SClifS7vEnq
	E4RdeQLj36v8BnLq4b+1kAWxSmWcDaZo4Ca8=
X-Received: by 2002:a05:6a20:be8f:b0:3bf:9615:12da with SMTP id adf61e73a8af0-3c08ede1ea1mr2865634637.23.1783371962481;
        Mon, 06 Jul 2026 14:06:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:be8f:b0:3bf:9615:12da with SMTP id adf61e73a8af0-3c08ede1ea1mr2865583637.23.1783371961997;
        Mon, 06 Jul 2026 14:06:01 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:06:01 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:39 +0530
Subject: [PATCH v5 7/7] arm64: dts: qcom: shikra-evk: Enable A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-7-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=849;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=TpvtLBwihWHNEKd1VwQvgAfHhzoeB2GGOqDfiPe0Xho=;
 b=dfyRRLzk6X22LRvVuarzLJYhr4uXZga/lIRc5OYOiiD8py29ZoBlA877+GkX+z7ssquDayLoS
 i736/Elf9UxAHI+/pIfeTDFCmYSKvza3YQP347A19hJlyWFrrg1G205
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: OrAVjiROtS3KwILIPmD-gxzFSkd1526w
X-Proofpoint-ORIG-GUID: OrAVjiROtS3KwILIPmD-gxzFSkd1526w
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c18bb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX5yZxMBa5zvNW
 w/DkWZ3/ctxb3TnxAOxiTfR2erx571l34USn6OXh7Pc6rtn7iP5n09tyGxv18JGSRUfQRxuchVR
 RoBUs6ee1DWZFmXBe6fAK0AH5tjNAwfeiks04flmOlb8LVSL6OiGlytBhCXy1S8FmcZMEEoDEDk
 o7fxmgjVjQFez6SofURWIkPmVxTE2mN/+bqLZ/LFlXWCm7LdD77laVGyeDH4du4diuqO2fF4pqr
 +vJbszNaRFxcIQ/+8Q6FexIM9X9be9aexaEARnwJ229tVi8nn3OxdryftuKwXmvCF6I7K6vdk+b
 GnRD4pD7iDXPl1aHwUQkwY/ER4RezCRxIOwKjNDKwA+KmPoQowWgKkeRo9086Cf5M3DJXjGJGrT
 OzdyFPZ1soRpeEDCaEEfIJdgevwDqqk0cdo+D5LMTrZGJBIRQ5uY4mqu5KjAvjR1HjdZpwEn1l6
 s1FBMw3wk5NPfIAtuoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX+KZYmOhrqNWL
 Ja6qi5nCnBl46PW0FoUZ0AmYHnSbLLxIeemNXuG3uzwWhcejPGapCxchPj6mTomQ4TfIyNxivxq
 TzC7OfEZP8FLQ8Nk87kv71a9IF/HJU4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra EVK boards.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
index 4b7be09eb5a5..9febbf200f10 100644
--- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
@@ -36,6 +36,14 @@ vreg_pmu_ch1: ldo4 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/shikra/a704_zap.mbn";
+};
+
 &qupv3_0 {
 	firmware-name = "qcom/shikra/qupv3fw.elf";
 

-- 
2.54.0

