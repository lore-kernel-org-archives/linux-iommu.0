Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182170;
	b=JRTcr6Lfi3SWgt1vhZmTXVnHRrKi8W11J+VyDyZCP8CvdVgXw89Ne1gGi9KqUHeAxxkF
	 gryVxIm3Duob78u96pGD2QNk3WRsqpKDs3YOPbDeHllSgzdnMb5FsynOVA69WoiV+bn3R
	 /LoDWamzGNqXlC1uLI0rP8K+qdfWjOr7B6k0Lsd39KbYSsp+WrUksTwWw4/QQyXqsHJDI
	 ISZ8E74ca7w5ufLbhhmOM09zgsO0R9/b69ejny2TpqlI7j3BCeAJ91ZFnHj6f8OMMwEQ0
	 BY9KtEys4lik+9rq8gK7dBkgrBs5ghFyqs+jDXQcAKHzZilKq3iZjYHipe/OTNCjXKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182170;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cX77h/9JYEKncD7zN6WTTwnGVQ+PExqNCDHg6+L+QbA=;
	b=2uRbtBgKNskKh3+n6nZOBIWEgg83uzflf/X9/oc7CADGfPu9uPrks7mdmmV6CwnMyOai
	 p/p8Bb/XUrGEruoGlU4BSZXWxSxbkCr7u/bcOskxhhmyiF5GoCm0b97pv3wByPHo2WhWC
	 3iOdPov/u5kGJuJesb7f88EN9OvAHtekUOa+zZ8sZySEg0Kk4hklvrPgWW0fJDFdBqjCs
	 B0noBoJb6WiDNXTIClbFbPphastVT5iTVF5kN8vBlop9xK+UPn2HywdzhlmmuxGQ09Jnc
	 cg364HiFHiCyNSdz4bGFGkLPEaolTjQnIz4dwZBGrWetNgVfRMBeavDD/UC621wt8cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O4brvdgV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NlhlX7El;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02EB606A32C
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D02EB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O4brvdgV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NlhlX7El
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjtJ93731152
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cX77h/9JYEKncD7zN6WTTwnGVQ+PExqNCDHg6+L+QbA=; b=O4brvdgVbiXuTMc9
	LN62Jg1q5tbIRntaWRcl3gHKiwH/ChVhSvmetIuALcoqkh2eEgyuRKknvmJ7fNPV
	AUvlfaWXST3o4P/Tivqu/+rWteNLV5YIxg6oQVDmXM2dFp9JP3P/fSFSmEcZhkQL
	ZKwVapbDXEvrHmL8Fo5Tkl4ahOYZEltCgO21hN+AA2zDCqtRZz1pPlVpClBldPoE
	7hiUZwYrItU49V/3zOMkWRL31X8Egy3EM5fO+JDlhFsYUa52ok3gYZJ97cn9cicH
	FO7Je6M/A7ryMgyt6Z448yXcLQ4TQK5bbbX2lVMEDZTo0qhXWrEDY/luGO3evel+
	spNcsQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2mm4gncd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386177b0516so1465689eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182168; x=1795786968; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cX77h/9JYEKncD7zN6WTTwnGVQ+PExqNCDHg6+L+QbA=;
        b=NlhlX7El+2caqIvJFzmQqs95y8ww1luMyO/VIrcYA6P3oobuVZtiSQorQ/h9TtKX4X
         1+8+Rzm2FyNoOvhaVWnLhPke9hANnu7+hh5SdfPCZTqX7kC4pv8qMmZ9h+yohd0Bmynd
         JavDhNDy0AxfUilakwYa63/7soEw8sjppfWEzE4muxXqDmPFlv3iWRf0yw/ch8+C4j5S
         GJkjBXACryEyYTCSUyHJX9fc22t9FAVFM0816YcBoBkVSlDmGIEIMJWCwibbRfWS99wz
         EkhjpYniUF5o6luY5KJ2lNPymKxuJi6ym7fADQez9IOwwzqTavVrQuUBkMGNXYoIO49e
         b+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182168; x=1795786968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cX77h/9JYEKncD7zN6WTTwnGVQ+PExqNCDHg6+L+QbA=;
        b=RgbFrCr6VcGtcn/8FXQE/6bbqKRKIfDcT70q1UkfHzBJZiiRHo51Y/lTZagxqAOqGJ
         nI/kZj/RPJCk8tTuOEPUIhWDEbgl/mdcymWqAZs0bDe5cl/FnhObl8SAs+csyKgXlzhy
         3rat26U5y7ajHFZnk8plM3SFDI7ZHagxKHuo/N5KvPO7VtIuqfQZ2XfMM4qaSAZT49jZ
         wpXwbcpysBu5LkXMgJiRMX9Wv9jKVhz0ASknGqE/J+YLgWqgf3NZJRjzHOKVSOxgEfGP
         8qiEoOK0eKQRD9XuUOr3sISPILa/dNXL0jK9Oo8H5UQR/5ItwiX14KzPaXSqZ4OTNfKx
         1waw==
X-Forwarded-Encrypted: i=1; AL+hErHoAvxyhFXe0SEsL6UnnwfaWEe9goZ4XKtu946RrjTg38koI/BWc4juTTL+KivI402kM461yg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/WFDQv/8NahhFJWTmHY+8wfgmMndRErYFq0hHVkKG8n02soYbv
	aqweg37g0swojKPxRMittJrejr/6ijUDsBrpOTfFXTO94Tof9tonhL+MOuFOQhTKF+90pGm8hrW
	+NcFI9YRRVKrF+alBX05xWsSARJQrMHFUN0rOVtL5A4aN64tGiHlIyNIoZA==
X-Gm-Gg: AZFdTZeB6SF/Suaxu5u4S5c6EnubHjCQy3lIgO58ykmUZcEvYu3iuu0XkqCGPeHgH4t
	h4z1Rqd4q28dVnUq1YMf322ju/49OM0QyRRXprAkkowzQKVYJ6rrYg6zwyNBN+SjzrzAUUbK3gU
	I4aHrLPGSPLFtALXojKG+RfWmTku2m2NfLGR4z6kSQae5KLKWavDsQJjEoBZAlFkXdVArK6wfbd
	p7UI8hFu7j9N9ifWe2RsPL5QVfPdfQbjA43IzgGfVPK05/mc3JTr3s59+kgG4O0H1sA45c1EJ/J
	obnKNdg9jptFbm8buEbJCpZC73ilU+xSjLOuALYP4UHbYE+evbdYtG9x3xmJ21t0CziO3WnYM45
	fN473WpyEqbqmojkGwZ6VicNw66v25ZqffZuGmv/Ewo63xC6NXW5Dav06UzUxSpJg/5alJAbuzd
	VjInw=
X-Received: by 2002:a05:7300:7a21:b0:384:b001:4350 with SMTP id 5a478bee46e88-3856f04b191mr3187787eec.24.1795182167455;
        Fri, 20 Nov 2026 05:42:47 -0800 (PST)
X-Received: by 2002:a05:7300:7a21:b0:384:b001:4350 with SMTP id 5a478bee46e88-3856f04b191mr3187750eec.24.1795182166834;
        Fri, 20 Nov 2026 05:42:46 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:42:46 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:35 +0530
Subject: [PATCH RESEND v4 04/20] arm64: dts: qcom: lemans: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-4-be30526391d9@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1069;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=J9MtDhNBRc3o2KPFtx8zuqYMoIVGqmO1gPFbpzrqgQo=;
 b=GunXIg6kgvtDV3uM/J82EzQCVo6lYY/weJi14MRG4ovrA4l4K3ivsa2Ji0ZDR/1rr+ACTwOJb
 JKuZYPMYWySD+fnfBCErjgyWMClxa6InplJWk3v7QoUiLidllSJzi8A
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-ORIG-GUID: Md7QEleIDp70XFOZjt1luE37d5WpfNlS
X-Authority-Analysis: v=2.4 cv=RZYFmFtv c=1 sm=1 tr=0 ts=6b004e58 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JCeWlrImN8qIMoXkfH0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX8i6qnRTfHU5g
 lSyxltjxHddVMImkDRYTG9sx0CCz+Tm4+E5e7P91JC8JMgOrUvfCxRdvULccz39ZJMyZmwW2cGp
 mzQvPfcuMbnZleZpsokj76RU9BskcvE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX+rm05E9aziC3
 RxP9T4LoIUw8Xt49e9AQCqpSKPDV1P/VSnQ/zsbNucMRkFJiJqNPL3momPbxP3ZQcjtTZApC8Tv
 EailUUY78m9YM+NcH3LbWWprmWmf4f99rTbcf44cvPbDyGEQD0znsU230NOy4I0vETn0oqTYvEQ
 x8Fpw/2b+DwAHFfpNtknSeJiZBeickxTX9SojC6I+fL9kk54dmsXyh0be+a04BGln4QKvidBfqG
 FWFMHiUPwW2gz+wLrKD4R8fErGDP1b9w+5LhAHRJrtSDJSPwLsUi4HV8S6etrylYJgxrg6Wk+tC
 hiMm1jvyTvnXyD074X2of+jjB21nTzgyjYSPMy/WmH31cCqglAwpCGF9grRIWb3NtAZ0A7CHDCU
 bxGI/NBsC6A6VfsDkDAmyTA2cW99y5hXm+M/QeifJQ+eqQFdTTPOZzmNWXusJmXrUuOWdAUDdXB
 DIb7IDazDABqXz5w73A==
X-Proofpoint-GUID: Md7QEleIDp70XFOZjt1luE37d5WpfNlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On Lemans platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 20f329c0df75..be71eb30f997 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3127,6 +3127,8 @@ adreno_smmu: iommu@3da0000 {
 				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		llcc_bwmon: pmu@9091000 {

-- 
2.34.1

