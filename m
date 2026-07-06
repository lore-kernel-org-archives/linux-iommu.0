Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E60435A8E
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357040; cv=none; b=ZOTa2rh8ZyC45zoBUVK3h0QhKi+X5rzGthc2ZWTlsziAPJGCtxeJfJHeX/ABdyBUfdsJijbYPmvMUGwRZ/l9R4yyEYoWa513VhVTdbnsx4RoCPEvBxVyHJs+b8pTF46G3haPYJNQRX4cOMiJYJnpwty17X2LsTVXMr4FN/dro4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357040; c=relaxed/simple;
	bh=08vr6cxy5ZZ+9RWNCtExcFI/JcQWlwcxowK+x8XsFaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KyxePbF9Nx1EpJfh1sa326A+FZ0wV/ub0RBsaGvOyw556jRRnBINp/6/nEgSzMwt0JnHyJurhmE4/LBhuLiXsmsRnRU8WzBbqQ1Wt8U7uDzInHbOlY2iPIXAwxCucfBN22/V0O6c1E81GRx1ffTMQpoZkHzA8rqOrC//YP8j4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NIwo0nFg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P9TNmHtr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NIwo0nFg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P9TNmHtr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF30u981419
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 16:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IvXc0//BOtPwrceNXqPLWm6VM7eQI+cAM0eRpWoytQs=; b=NIwo0nFgjVYs78GI
	/xbEprZ2h/6NoCvaGe+APXZxcYLiTxHwSc9U84Y9vleZ0Q3wUIyckLMPG13KlSNP
	GRdJS8f+Uh8m/qV0Ucjboql6keAxSsL2OmRAGSEqUUsYHDC0ixqAaam6UH+2DWoH
	tzr9zq46NZoMilu4w6yUCLgbvGbV2/sKkjGGZEbJq9MQed9KKDmXVbj/WdNqfb9h
	ii4tG/UQwvukIeLJ2VACNXk0B8rtSIJQ+QIrHn8JlwGPZ+CS3/ItwEBGgl3MqMSE
	zK4u99GOFBZwUShmxllvKDVoM1x7doYcPSjnNem9iD1FmOkoJZ9K2j7ea9v8TDDH
	1VxIaA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgt3tc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 16:57:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-845317fa7e6so4974850b3a.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783357034; x=1783961834; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IvXc0//BOtPwrceNXqPLWm6VM7eQI+cAM0eRpWoytQs=;
        b=P9TNmHtr5MI42M810KUsA7py1MbIE4Ld4xMsVekeFbF9PfRyGoiauAesPq0GvUEY3M
         sGX8iz8MAG1oxs0Va9Qf2MiEelQktp7UhaeLa+GtqMHu51+790FiY0thf4bu1xdhHd7/
         fxxLaohXhG4s4MQ03H+nuLdmn7VQ1IPSEaDROcIRDuqGHQ0JbwP45NT54NJHhat6109l
         rRa98zx8891rIKo31mGMLO6/Z0mRhXL92h/lWQbjKPxdBgZ9hNnhxGB1hVVAvjjR+DLP
         3uWirXlBmd9WSrgHPtVyjYzLKal9X10ak9AL0B9pbCX0liNCVdtJZFc1kF0Lp64DZoxX
         Z/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357034; x=1783961834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvXc0//BOtPwrceNXqPLWm6VM7eQI+cAM0eRpWoytQs=;
        b=FGEO1fOHqdWfYqbzftjdMk/4r72lIJzOj6coUtt3prI6+6eaYhCJ762xBK4HJNHyLN
         XDBF59lSGLMZR1KM4VQB7VdM2CpaUvzAzofUuBWMQ8MjKwP+B8f0K0BsMa3jNgPj9YWI
         ER38UdwrATfyHOziQguKtnIw6lnZWRhBwxTetW6JcgHNaqQ5cyup1y1lu3Pbw80ZHKTs
         Rtop4QURIRKU7ym7qiTa6lODyFxdhoRj+ZPRlVdT10zZhHmO02FXUh2jc87mNgmPYMje
         fHmqa/dzBN+KUyRd0df6h4Wv6HimDz9+lmB8omi0aKP4aTHVudIM0NkggtEINcDfcmxg
         +GLA==
X-Forwarded-Encrypted: i=1; AHgh+RqgWN6kWte0HC2WyUrmB44U7NYFUoRni35ZK6obayQr0GS5U2r0xAC5bnygw+Dk3fbAS4RpSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1ojp6bmBrosbXwf00rFe2jD7muZifqbjUCdC1tCv2An1ISHJl
	ivDm02M+wPyOyOX6SC4JC9EJjv7O9HEeHD9rkfpqAZdDkCE8A0BG0W3WF79pPG1GfJRE55Pz5/5
	elZDF2SJQKQqq/IQrhuskua80laH1Xhxz69gOVv1GIDE0N5bZtw3cXgbtrNmdynFiZQ==
X-Gm-Gg: AfdE7clYQGr99KP4BSb0ytoxcnZPF+d+xOnTEU3h4rCa7x4qgQU1ungd8FzC6tvyxwk
	dij3LoAhyK2hjQ9cX4bGEIMbS+ydO+TE47hwdDQeipJ4Uds0QP0S/UmT4lBtsvoKXJx3YBN+yAJ
	TNXB0Qg6J4tV3vYMdHTOEvnWNM5YDjRBjhv84ONQQSPutl7OY3y9plYVHKPRTmXH9fBj5PWAjPN
	pRMtLR38uVHR+JM8CDAD5EiRpDN9Rl//oqLmqKw07ggmag0CVnl/ToNHSBEmL/PT41emn2eaw9Q
	BptjpjFdjutKM2JbbwP1b75+keHY1xKxQCyAX97SbcSqKrPLD5lQHYWledQt8C9fM1N3qfBY503
	vQeeMNqvVZ7Vk6iTkD8iJPgBv0fQY7pa1E8+lBlL0cQ==
X-Received: by 2002:a05:6a00:2381:b0:845:dffa:3740 with SMTP id d2e1a72fcca58-84826d1260bmr1409293b3a.4.1783357034003;
        Mon, 06 Jul 2026 09:57:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:2381:b0:845:dffa:3740 with SMTP id d2e1a72fcca58-84826d1260bmr1409261b3a.4.1783357033583;
        Mon, 06 Jul 2026 09:57:13 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0efc8sm6960604a12.5.2026.07.06.09.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:57:13 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 22:26:38 +0530
Subject: [PATCH v3 5/6] arm64: dts: qcom: monaco: Add GEM_NOC interconnect
 for adreno SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-smmu_interconnect_addition-v3-5-afdca0125a65@oss.qualcomm.com>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
In-Reply-To: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783357002; l=1018;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=08vr6cxy5ZZ+9RWNCtExcFI/JcQWlwcxowK+x8XsFaM=;
 b=xbqyKoHGYi2uTsIV/EYwj/ozpnriCZVKxtUa+xnUuWnwLuW5YiEE5ZRyyGolLyLSafYzSELC/
 dnYQyfyM39DD93cT2B+RyV3GBdtoOFIAmn2dbH9tad4yH++VMXsVxlp
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-GUID: 02isVSkUg8VUuujA2-wfW0s9h_k5C-5z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX6yWzxHHu17Gi
 JHcxxDp9PVsn6vgxJlCeOn6MrO9Gvl2EIzi2dD1TD9/SU6wL9oFodmfXKbRR9IK3dPDL1l8tr/u
 uti/J4Cf2ijGJmyauVtkcTR4mSLpGq1oJqidbRpoYNfBXIXWuYfWFewAfJ0Xge99cKHcG9UFAYD
 zRQgRZheNriXx2lBBDSmvjQV0OujJ+PREZHHnqT5lfrWVIiWJoZBU6h+zdbDt0NMkbuHMQtp0Eh
 cdNdLoCzy9DZN9Lml9yHHHORON7iiSrC62pZN4PYbaVx+5d8oOOw5eQYUfE53Z2B4tv0on5l8P8
 FhV5aug2g7TqjSNG0G3nLxisX03kGLyzLzbmUqKqx+6GVvVzaRPw8mMzPBwicA2S9SG2WHG3JIC
 csU+JHxoYzzd8C3z1bxhreUpqoNPjCorHo6FwvZMixn9ruvyW6+FLf9XHe6gok/CuwVu3Upn3d4
 dd3YGHbMV/t64pUlohQ==
X-Proofpoint-ORIG-GUID: 02isVSkUg8VUuujA2-wfW0s9h_k5C-5z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX8eLdGD/XHkPm
 7CP4J6HdEgUWbidpey+aKE5ib0fcx/q/LvzIsFV0xU7lIyVHOkEoCuucna3P5cAPNXsrz8OTCOa
 udWCyDHd0SwRswSpJYd0h2UJ3TQYYUc=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bde6a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Jjng17ChVe8r-G2aFk8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060170

On Monaco platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 400c75437978..e3713c2b6236 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -5117,6 +5117,8 @@ adreno_smmu: iommu@3da0000 {
 				      "gpu_cc_hub_aon_clk";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		pmu@9091000 {

-- 
2.34.1

