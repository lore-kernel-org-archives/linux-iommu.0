Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172833;
	b=UFnr9oaevJvS/lHnMMhcNnmExBbUwt7EeUcIDYOoH06ZXISouvo3ya8Ibiejdbnzqdi4
	 w02Sk2dQKKee1tRh23mbzkmkB8Z2UfHu4q+thVBpKyoo94caotfosAEvBtn1ZU4r/gcRa
	 cWE7LWQbusnHmAB68wIRQsQq1asAz5yPrz/b1Bltg77wW1LflTRkzlh4GGXub6JoVCaAj
	 cYikB7/XbeskhQAIuTGW51u1hrBePkF2OQwVlAW7rKbrt9zG7npf6jbpvppE19ME7U2wr
	 9rEJ73/A6OVYhxs31UNd+6iWOiFwhZveuFU0CW6hMeQzePUOIAeeXpIwuVVP+tDWPfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172833;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cX77h/9JYEKncD7zN6WTTwnGVQ+PExqNCDHg6+L+QbA=;
	b=yt9BXtwHyfL4PQ5f8P5M7SNHscp4wQW7heM554/MqYBWRSr6Ib4Ah35t2OlyyzlDjtlT
	 FCSAeHGxW6OdZjjn3eLtG/wx07LmOiUGjUVvyIGG/MTECl0i2GbU/J4+9f3L90XTIOxoO
	 vrQiy+1aioI6DjheBUXE5Gkhk93wCPv0eZY2/k4vfev51Vdvd7yNvBd6fKLr2UaR7dxEM
	 8OTRFsPDIrf1Rbzw1DKB7qdXTHiheT7kenVrrqnWhap2CMJfG6HIchaFC6S55TvgPAfEI
	 XzuFWTffVYOIs8tiGReMf4/6AoRhVmWOD/WSgPyhl26XJICSh9JIcu9RAXUTockXVJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QzZ29Kkb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DyzcV+Un;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52060A262D
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A52060A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QzZ29Kkb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DyzcV+Un
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjoOw1462862
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cX77h/9JYEKncD7zN6WTTwnGVQ+PExqNCDHg6+L+QbA=; b=QzZ29Kkb8jPUNzaL
	tD9uX3Jh4A0ugKkJgKV0cOt7CS6/HnNa3uJ5E+jyN9Dtxf8glUCo9FqtbCgZ1G8H
	tkGSfdvmi53szEDW+MUHncxhTmQ87jA3+jSV/oJrSsmtu7GobAK2epjTWWox3jSe
	YAeAPTcc9r/oGhmno4VqMycNoL42okck5BzwpnIY/Z6orYaU12MCMyp1PkDb/nRi
	MngcPQxZgIWnFMCQCbxcH/VLT25578C9TaZznRFPZhEiu6DwQU9r16K8YfNShLlo
	Tiaw+TyF5Rv6XTs8OomFaEsNjUCiO6VL2u5ocGR3mSGfyRzdLInBgqxhNMpqoiG5
	sFlgVw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2guah5pn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:11 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-382af5cfc58so2192786eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172831; x=1795777631; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cX77h/9JYEKncD7zN6WTTwnGVQ+PExqNCDHg6+L+QbA=;
        b=DyzcV+UnSlcHFSPnbYWXdZdzQng/cprU0E7Nt1GK0QfMIDcH7apBvgX/zEXrEMEUIr
         lBJt9sKMLZcFw3gVF1rP536sS4eGZnZXX7ghmdvdbRCXnl3FI192OWhAXW/96IUa+jIW
         jr6ySDewGWc9pEiGOe7IoK+URMOx9bRRj9sNlmVzZBpCVEKUlXJ7DuGHOWCsBCD52cCj
         t+o7mzmVORID4EB/f5sUZMA63KaOCF685CqQHPMGFgPM4bqpzVU4k3quUoGtvhDSeYJO
         g0eoBhE+HaWnCK+AN6WmGAud1ENCyvn4rKkw6tY5lF/RIe9YwmC6OyWcHRoCskv8zgkJ
         dsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172831; x=1795777631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cX77h/9JYEKncD7zN6WTTwnGVQ+PExqNCDHg6+L+QbA=;
        b=hOGfZrJgW2Fc6jVtAr9GpuA4tIT8LFJV/VOoQlr5LizXIsjxip7wO7Z4vmc7hR5Alg
         MkG+RDm2oJVo/8O1DyFpaXfzp/poRWkkddvIWNE5oLMuYZiWeoC7b0GkMjQBvUTEgJJT
         SoxaOaD3tCTluSh74oopaeyMGinM7FrafnXhxj8vAwZhVUmQ66ZCDukBE64sBfEFZ0fq
         NYKszw3UuvXgdGXQZTAfVQjOIArXQHGgkDlQdDEPd7e7G+cRBSjSypkRQOMQI3ZlR/mN
         HGokRT1lYXQyakC8ZCE9Iia5l8IR7JbNM6ksdwSp0IkvXI1Dch3HcPGeOa1aSeFKMDyk
         aqug==
X-Forwarded-Encrypted: i=1; AL+hErEVZVUpp0P/c/yFDHQmGrdBrnCrgrDaEKl9dF+DWDu9cRin04A7qoot9BYbbrxEMeDYilarMg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9PLGpVY50sTLgAaqNxxhu4fl5M9jnPD+fBt4CvHO9CWKxCLTg5
	sKQ1XpsKRgR+5v9hKLXeyiPGRTEhDl4cYKMeukahVMiS41LqlPI3in2t1gy5xWOynU2QfVUGtXc
	ufZcYvlV7HHd0no/97MWK1jKSzg6C9b8KeIwjgdQHz9NVf94eFMu7qLmgrCOg/k4Ztw==
X-Gm-Gg: AZFdTZeiX601WlRMfIHwdclDbIOcV5KuvBIujULyV63xQ5MVrOh/MdP5n99rn3UTiq6
	Y2HpAD52CuKw9TTMwnrZ2QF6cmfFOxg1HNR3SUU9yCeQdCDpROs6tPWKeAmlnB7LybeloIMq+BN
	1O3MYfw1bliddYBrqscOa9QfW6/74+eOBELH614eHNWu3285OH30Jp7c8dBz3JtTV2dKG9xcuaM
	9ehFVfSVmgg/lWjyNKtl4Gnar96fqokNB837FUOCFJF3z4wFCH0N7hI3lmCOW5mczwXcJHWZQ5g
	V8kjC/0bwkfl9AqgaYKHNUFchatDDbiqYS0HCLW3npsbttKrApFswfwEFHIQvnAH9r5tVWJK6n0
	a6UhCVoPO3LAyaTgV4QPzWL7bMpXbQ57ZtbewDTBKSTfs7XJNaQdlESyJ3uKL2vwchfYXKfazgF
	5yMMve
X-Received: by 2002:a05:7300:8188:b0:382:61d0:f375 with SMTP id 5a478bee46e88-3856e63b050mr3380273eec.7.1795172830872;
        Fri, 20 Nov 2026 03:07:10 -0800 (PST)
X-Received: by 2002:a05:7300:8188:b0:382:61d0:f375 with SMTP id 5a478bee46e88-3856e63b050mr3380234eec.7.1795172830267;
        Fri, 20 Nov 2026 03:07:10 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:09 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:45 +0530
Subject: [PATCH v4 04/20] arm64: dts: qcom: lemans: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-4-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1069;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=J9MtDhNBRc3o2KPFtx8zuqYMoIVGqmO1gPFbpzrqgQo=;
 b=CxzlhjeUr8VvYUtjmp7JKW6HknNkVY9G9NNb994Oy2SYh/r7FFm1+OnmSzS9taDYET68xu9f6
 qG++w8LB6UOBPYBepaj5kOZ56dOvRRtQdRwSI+9scxEhST270OTcHXu
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXxYtlbIKRC3bg
 vTFXj4PgraO+XtODuwJ3wZeIqRNP+fA3+2ZPIfDp+pbob92l74fUJQTbanWajMB3lJ3KnNF0S4W
 i2N/eW7OkNAxvUqEBwnfoo0vTfXR8Rz3+iDbjRx/3UbbLxuNHZyBi1wSuFXZ7CwPG/dInSuoGoz
 aYgYvCKlWbn/RAHKid5ZRrHH9yyrsC/Ma+eMZC3M5PhYrofztaB7zVhHDWB++LtRw5ll6T5FxOv
 com7ifl2fGxXpce/FM19WtAcLB/dQGdd/21MAAiGCXEsjvxiNuATHfjEqMFVo/vFD0HEPw26Ix3
 JHAEBv1MDNFQ7vDHCZiNTeya063jvpsTHFLIe27H8qSUNcvzZWgj1uUziHhseaDzFx6qMIdQ15V
 Is/mJ8xMmthwU7onVhVJILIC4aM0xS320/lNs5W2OQm4ysTWWQeqHIn09lKcVY+0d2dIVr5VR3o
 2eN21BGK598hEKHK2kw==
X-Proofpoint-ORIG-GUID: _WWtE0RJqxeWwWgIIDk_nq8EZCSba0f2
X-Authority-Analysis: v=2.4 cv=BIYmP1QG c=1 sm=1 tr=0 ts=6b0029df cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=JCeWlrImN8qIMoXkfH0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: _WWtE0RJqxeWwWgIIDk_nq8EZCSba0f2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX/4TFCo51G3vt
 2qIxT88Bk1qCSFh2ARCCnMIz3BZAtPlMOzhFcfWJXlYHeL+yVR0QbvPyqXnw2coj1bX20RfTB+Z
 cIeZGLE4qhHJwZ+rUWEr9fFQwk4hDUU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200044

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

