Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDDD30C360
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671126; cv=none; b=X6YcsfJLgaJTPjEnc9xvfEHn42pfk2wNPhv0iCAs2sojR9CZHZA/XjG/QrNt6S6aF/vzKcHBRuilxj4bLkQSJSJ0l+z/pEsH+BaWWjBEqboORPmrpxDNAdSEUgrxJIpd1fEIa8W8BHVHUV+jY8M7gnJ6DbNYJn59lKdyBy/Rsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671126; c=relaxed/simple;
	bh=4CnhHAH08P2sZu1lx5Z5rOG9mt5xMU4OOE4XsN2DX24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LhMn9c2tvNo8JI1HgGYKonY1zWdlnPaP4gQvyWEvwMzmH3Winj2kJth3jj4UgdGNj7Dt0HahDFx8PbPOw9XoRGIPe89TGeZqC+GvhEisAEW3TJ5peZRBWjUFXxrnmORkf30V1pKlmDxgnmNNeVq3inRH1mb7m3B3AWnrGZY7QzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Orqf+F0p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=enoFOxag; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Orqf+F0p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="enoFOxag"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SHivpa406746
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E/Adwkoxov+upvWUoqX+Dqc020CT53dbeXdpXRu0FmQ=; b=Orqf+F0pLb/58jZI
	FhZ8Ls+LPFICJ+Jq1rTtdumHPi52Mvy70o2Yugkd0K6l1w8x+aW69fkBewkOuFVf
	tMgiGcjUqbj9ho/thCLppGa+4rStJetrNuoYz/Enkx8/VUv0yW3GRYti3Yn/UaF5
	i5Cm6xAvzQjoNl6Y177spR5jSt8J+D1wfTjYP8poRNGLyhfEY7/2DfNBfn9/EEXK
	56daBXJURjprC3Mv4Nehe/YB0ZzxGIGH9cecGNdMnix3An1TiL42O15OmyA7fVGW
	2QyNNahUgG2+CO8rjmJ0aFtS6yFv3xKzgJGNIQdLz1LOdvNm4oPMzZaAxFXcENXO
	ugjaJQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf39e7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30cb2bcbf7cso1972717eec.1
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782671123; x=1783275923; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/Adwkoxov+upvWUoqX+Dqc020CT53dbeXdpXRu0FmQ=;
        b=enoFOxagCpFgvo2rRFxlLBQi8m5K36bV2HwrUWKxZIuQO0OjbrrvlecIG2wP+gR8LL
         QXPdaj1vJ48YkN+rt13lS7MnYqArCKRttjMP8kp3QSrSizTvhS4hl9l+xvd/5SwL2loY
         yxrAXX/Hl/q5XURGdNehTQnJmNn2YCQYZhHsY4sKcvhwJbUmwQ+yrGBzbZzQ+t1HmLTu
         Zc10pZij2j1pSVM2NGAiOxRVy5W6uOpyIZUUAllsBKCW8NaNchIjMQLZ3Hn+DpvDj9mq
         YGThZFHp3OSIX4sMZGQD/3t22VfvWoYeRuOeLvf6WS9uaJap6MsR+LFBLeyjp8AnwV5o
         WKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671123; x=1783275923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E/Adwkoxov+upvWUoqX+Dqc020CT53dbeXdpXRu0FmQ=;
        b=DzlmOAn8fjz4zMxBNjRmDAFdqLoxVmV/kz+kb6R36ssWTy9x795dzfZaby4DUYimq4
         FcONaQOjNCt1Wcj297A0bwysYRZzIni33qTK70GStT0gxrzCmFqSkoNx1ongY6W1eg+t
         LZ6Di31RWMet0WL2BXcS3Nh3WOBIvb+2e3SYJeTfi/9gGwodQT77GVnepNBysxtz7J+4
         qmyLzd4bd9Q0jJkQn4HW6XO8xVoptcb4GUMXNbF3/OAn2mDfiVvm7WdcRnIMEk+O6/U4
         vh4TGVffxC6rR5jxxD33sTa8Bwmm/rpItKyot6JNc3pY+l3e+YY8V0Jl2nScBxtjv50b
         KsLA==
X-Forwarded-Encrypted: i=1; AHgh+RqhEdj0NAdOp/thTaGwDPzX0fo5JS+E6AHtTXYTrSljgBrzY84A18tydWP2N29w1k4iGqe2Mg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUmxxmhxmOu2vPuaP/zrjRcTVm7YPSyhUrq3olVv2wVI6kDDpH
	BXPPwsXDXfq27mQKu/GRdcBXdWtwFJ8AA03sGaVBMFrKCGF/gUlq+Y3t0GDCAHBGt75aVtxjqOB
	GquqopshEGiJMe2dPs+ATLpZwwefzqI8zfoy1Lz8hwZjStiMEd/mgfMxVQA==
X-Gm-Gg: AfdE7cn53ymUplxS8rpfcfoqcCU7dDwkxLd5b6qgI/RZAGotg57H7LVOTgb+/dxqkx4
	IBWfhFjgXUmCZ1vVfWB4XicDLfmhoP+DUoXAYx16HMBKNsQTr6V42Ub7CjyKLoq9xZ3/rLMiVl1
	ZsVrnatuKT/ESdUHU8wxP/mpymtpTecAaCiT4LntGABIjIB0X6W08cMC6MEhdH6SXexhqKaGwVL
	41iib7ALoQLdxZTLBUIPmCnsaxt6gQoxOYLJ5pIkTQrhGIUc9KwfxpIS1ukbVsrau+UQVNNnr6P
	gNtL88Bo4fsQ9rkIoOnxhoIh1hpVjQX+Y9AJ0IeemWZtx7IdUCuEnag6JzlV8J0SiAPHBcVoTZZ
	pHZCv/X6Vk+SiF8QJ9ufWZCvMojpzjxbzSVk=
X-Received: by 2002:a05:7300:6d23:b0:30e:c38f:eaa8 with SMTP id 5a478bee46e88-30ec38ffbc9mr2680824eec.4.1782671122841;
        Sun, 28 Jun 2026 11:25:22 -0700 (PDT)
X-Received: by 2002:a05:7300:6d23:b0:30e:c38f:eaa8 with SMTP id 5a478bee46e88-30ec38ffbc9mr2680808eec.4.1782671122355;
        Sun, 28 Jun 2026 11:25:22 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:25:22 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:54:00 +0530
Subject: [PATCH v3 7/8] arm64: dts: qcom: shikra-cqs-evk: Enable A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-7-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
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
        Aditya Sherawat <asherawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=803;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=tpJR8ANAaLpNkDfQVcPg2PDtoJzHDFbD5ZJyKcQDLI8=;
 b=UrwtznvEchsCPw2f5j1Z1h0DtgwgaYYoTKCdTBRg8y+Ki3D0VxImpc45UOndP3zz37q3BG6yE
 WXiLutKmQAqAzUYa1pzJN0Hib1HgeJhRpwgbC9jZgny/fpmO9bmcx20
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX79fEv1SMXn8L
 E+d8lZ4x5PIDSoN8jE3PpftRomZe/HzCpJgVD33kPToEcmwIWTmydRqqewjszijQHC9OUBUQD+8
 OWMj7adU9n2wjQfpkd6AGU2TPNZi/i0=
X-Proofpoint-GUID: qWoOx3a7ryLjjcG26jzMHhelQJaaIq7S
X-Proofpoint-ORIG-GUID: qWoOx3a7ryLjjcG26jzMHhelQJaaIq7S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX7BQt9JRJxE5l
 o/KFoUuOTwB2xBQ3eT3XHSw2kroj2AB5ndWLFNM03y6ViWp5aNURMdD+sYi72jbyGn/5/rJMNFR
 9FP4+WHK9AnVAqTwR7dvpdYJ65GaCnTqSQp0AgGy6ZTF0x5tGfzRLx52moSH1yxuELk+8wG8Rqe
 N+jPM0bwwNnwzwSS4bpzZtaHsCVGgZKdlGHmVG88ES2Io8w61uc5hwUngPNalHKLSDSHkHh8oWg
 HK/dK4jbrSOkPHlJZQQIocNHO7xottfAlTqdIrtRFB3W6Ko6Gzlu+XrPJgxeopHria3yQgSzhzd
 JGwmvkdFTJP+PyFOGhbioQ4pJRSen0U4MWEinOufVN0LEg0J8Wn24HPM02/e9YqndQxQJ45L0fS
 HQf7s4Hp4hxgkDayJI9bnqBSKtKyM1FOY2GT8H7pYiLYEaLKez2eyNFSOrxO9vN9oVFmLzjfJCy
 hhmnXwZP9Vl/WShEywg==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a416713 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra CQS EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index b3f19a64d7ae..94ef498a2467 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -23,6 +23,14 @@ chosen {
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
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;

-- 
2.51.0

