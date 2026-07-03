Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7494321457
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110929; cv=none; b=Nfym4yeG3kTBlFghIluA6BuWhRgankR/cpmWTZbW9AycuDtHXwr0TLWuGdNEweSQrhGs/RzP8zYzed/pnMqDmkz1Na5LY1Tbb8KVm1rlPDqobd+VYKDiP5BfMVHL8b6JY4XyMxJbbh6EfDxp/S6Q9hhBdsgxT4SdGZuPvlOg364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110929; c=relaxed/simple;
	bh=rYZUtLoMbkIwkI8yFMTr/hVq0ZeMXm4yVfo/qe4LXmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7DIL0mj6bdUkEn3LgKsnUQB+400wEsv5QeZc1aiE8rQk1VQuWQoM1BknPk7aC4oXBAuWihMIqdWIEZEh3Y3nxBaT/hz67d6r/nxWZlJqYzA2FboFs+Fz9arfH3PSTL6w1x+ybqHG0PfjSmu5hLENeDUVSBEbesg/vZyuycxpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bkVbzb/m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CKDJ3c28; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bkVbzb/m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CKDJ3c28"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPZ17888407
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 20:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=; b=bkVbzb/m/+c8R/ds
	OquV2I1Ep8YCvaIC++gxM4vg7K7PZSyc4jMj+AKyLx7efXnU0ngZBlfbyE/mz8zx
	QoBQ5aHHH4Omjfwr6F1zNttJLcZsyTllra9bIKwHyEXb4rO5nagPVeFhUP54TACx
	BN9fYt8B7UxDdMnN0szkJvvg0GJLKEAjAQ9/9220RZT361nl7NK6ut2o/3loNwy9
	ohJeLY82VilBIvVO6UhCaERmW7I9zGtDYy86C6yqUarNARTNCN+WJ3Btlw+T4040
	eI4rQ9QPKPG5sicGAXAes68UDQNbBYYCHYOHpDUt2rb4I3IVUCtIxAimKEXqF8P/
	pa15gw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682btv48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 20:35:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3811ae55313so776809a91.3
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783110926; x=1783715726; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
        b=CKDJ3c28yL4G8EOQ29TqwqnKS611giZD3nyfwoaYt2Et0GATcnYflU2gTggsBAzRVc
         Er/amEhAekWhU3G1Yu6vHsIzdirbJ2lYsyXpBsRaqCQ8QM1mVV/1OaUHwASESKyblcTG
         zF4FqLvqvTGwl05vyoSZlvEhOOgoX7HB5ULEz7guj3DZJHb1vvUFmUqCVjqO6zSTp13n
         nYXrNUCa8AG1eTl7ZGWi//RXgGZxE3YZ8Q7VteNcf/m0MUaqCEhhLU2ovOtQ0Ut8fmkh
         Ajt3fZw38aA+beAsEBj1AYaWCXFWAKrVZYl1Fr7o/pYKPS7h5DK2y//wE2jisdVVvr7I
         M05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110926; x=1783715726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
        b=dOaWCmInMqhwkbeEseyM8Nb7ejn3kj6PXdnXicdJwUNZMCdCD3WGrEjfiXOMwZ3vW6
         dBwlzHbrp06Upk5rU+I/qQeOVwh1XbqDIZfxOmupTmZC63V027ckRy7zJOp0C9jobZy1
         WpzyeX9fM0a1mlcVqHhTNFhJvgLXbFVUpvKia9DhjdMlY5vG8mBPKwSFeYP8NFq8YxeF
         O5r/cfHr5pHiSf2yCOGriBMPs1xJGp6B/pGWxOCfPJYc6h5P8IhfSLDUdm3jcyeISAso
         xujfwAtHSzu2NNNZQD+IrP2DbgsA8lCvdCjRbMGWvXHj2cPB1rPabAAMu/9UySnO9Vxi
         R6YA==
X-Forwarded-Encrypted: i=1; AHgh+RrZV6T2xMCwjXqAX77/LDB7o4FE4J44G6ra1PPDlV6gSV/r2r9xGhSvJmoUgRyUvVLO5IDauw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtWQ8iEqJh5AGGgfZDbQX0zvkefXGmv+xkxkmMcuMGPY6etCY5
	2ImVKRb9hEIcl1BTwujqRFOkcqIp0h0wlvs5xraAxzjDiq8HBSN+lafwAm5E1nK9HW1coi5S3ZD
	4fjzODkgnaTLGIPob5aAWsgugCpMkqRYEWu27lF/eKOmPkZiMgWWRIZreig==
X-Gm-Gg: AfdE7cnrbgS0zmRq1SZ9p2MKaXyBrXAw2lcDd2o47FzAsWmWuNm7CRjHfuODM8sSxdO
	gnFrwthY6vQBTfHThYletg/FdYI4eJDv5C8RvBSNbB5/wXc0CtOrYrZsNjsgWgutePJ0rncDmwM
	bCgcT9BHR0GMDkIZ4VVGsX1DRI7m6fJW5k8VqWug8nx78QWrXwc12QgR5/R5f7mb9UJpq/KkrA+
	qvJ2/vZxXTDmsHZLw/im5kcb5XZh++PJXCsEuAgKvGUEV1oorPa1lnv9w3ak58vecAo+hOzjSmJ
	8tM1ZwyO6fgXhz+Mc9mp0CEJ6tHTgCbrSTOAxv2ov8uPwd6GkyAbATZKnysgCLepd84c+r1SthP
	vTm8V4eTvx2k/ZndVEmK4FQIsqxfQ3GKgSds=
X-Received: by 2002:a17:90b:4c4c:b0:37f:eeeb:646b with SMTP id 98e67ed59e1d1-382800d2225mr1038709a91.3.1783110926369;
        Fri, 03 Jul 2026 13:35:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4c:b0:37f:eeeb:646b with SMTP id 98e67ed59e1d1-382800d2225mr1038664a91.3.1783110925866;
        Fri, 03 Jul 2026 13:35:25 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:35:25 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:27 +0530
Subject: [PATCH v4 1/9] dt-bindings: display/msm/gpu: Add support for A704
 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-1-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=919;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=e0reXjU4841qQsB76OT4bfKmGmY/z//RRWVRYHDWGzM=;
 b=366NlHMFnKH7Fuj62J9JVaF1Nr8CsES6ABTopFiQsD6b4y9xxXYodoaDhxIvDxQzXBPtTPNRB
 4O++nujOYdvChSFrKzJQei8xwwbHJTOg5lXp9iD3kMBWnYPuMWgEJpm
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX/BUWrtWT7tie
 67ynVb0caBKGSaSRub6gV5lQUpL9R4O5iZYDWxpVjXJ59du79PgI+CoDwpwME9qIjLaLcKCzEW2
 R4iIJMA3ETQfbCqoUIlWKkotZq+7AugzPuGDXUcMk7paCcApVCOpI3uDld72Sc92kv47sXemWZz
 EE1qXl5gjfl6t0WQv5Ld6o+UufP67o6TleZqssAGqmcL9jevFtJJBZ+sq5y3bWifFR7jzt4+U45
 IpE7ywq61tOUhtuiqql7Bg0nbJ55jSg2gFp2b4F57jZ9nUieH48XsxRDZ2VZCGJhKiEz188PxT/
 dXeTEjAVxUAHsuE59L4jgQzfhWv5b6fXLk6zAa2bXOMaiywTBJgC2NB9BTTiAohm/0VWbh+vviD
 N9PPosFxT8TRFWLKM9uWMtjS3IE0zFTNTomR0ju7PKwYxkj9u0GzyPyPtA2YGL9FrQ0Tyky5pie
 s9Q1ADl38besY5Ygr5w==
X-Proofpoint-ORIG-GUID: 0cTYh_n_qITm_wMDMznDyQd2DfZi-8TM
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a481d0f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX1M1F+heYaM1z
 JUokqFvdd+FIJX98MEdoIs8l1QDO+wrPubFZQi7N4CW0VKeHLiKsiJzWICfvSCiwG+bd6s+V1dB
 PbzX/oJVawav6Q+KABoj5T+FPemDu1g=
X-Proofpoint-GUID: 0cTYh_n_qITm_wMDMznDyQd2DfZi-8TM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found Shikra SoC is an IP reuse of A702 GPU with very
minimal changes.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..8e648bfb3b23 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -353,6 +353,7 @@ allOf:
               - qcom,adreno-610.0
               - qcom,adreno-619.1
               - qcom,adreno-07000200
+              - qcom,adreno-07000400
     then:
       properties:
         clocks:

-- 
2.54.0

