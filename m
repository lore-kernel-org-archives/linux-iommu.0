Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F123328FD
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371930; cv=none; b=aWBS4e4OUGH23mrqHSQ5+4KzOr5M8IlvLtqkHqxFL+2Jlk2HlYIO2UKBIbt39hDyP64onH1sCgWIxM8eePvFa9v4J9HqM+5NF2TLNtZtZxZZVZtZiL7WUe2MDUkfiifMoMlS2he5FKA1VRxaG1U80USMb1cXaCdGi/bHV558WU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371930; c=relaxed/simple;
	bh=8G002/IxABPssrEzt3TqDoNY1L4MUJqdSn00j40u6ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7DBUWHXBtjncsF9SCSp8fIbKSyM3k6tYyuN3TQIoJ5rFh2gkrZtRvIrhPrrR8x88Sm6dKJsduXMyQ5Ya0hZhQ9c49K5AeXWmg+t/V7jlf0LEXwFcNb/fHQmfhyD6DFGXFTwm4XbxUIX9fl9zrTP2BQMmhhQi236XWOxAHJIJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nfe2e3kB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YNyfw03P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nfe2e3kB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YNyfw03P"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEqxQ1614936
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=; b=Nfe2e3kBjn1flEcj
	9fCTeI8Psnisy1AXPGc3a2t5QPCx3o/OX4aze3IGnGTLw/W7oHQbVFny8/lWiokG
	jBNGIGUimQ98xkXAiv2AOmVBNnqF7X780OUA3zcJwXQ5Y/2mUEBO3H0Uvg6SHVeG
	zpS7ooPd5lUJ35xhwjS2anhkpvmI8Ng4uGuFKiaDIWGk2luoKo7N+hVyo/2hzOtY
	k1ewLJsHXcu7FzvLbheLXOeJXBH0Q/W5sC5MA7E6FP/hJ9/57cJVE/U+UD0erleF
	zjUhO2/MQuszqOdM262shEHp3EBhx/GorCp/N/+NNfgiBvnPUq2+R2V4U4T1nQxj
	Jj8LEg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h539ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:05:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c889d1eebafso8353444a12.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783371927; x=1783976727; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
        b=YNyfw03P8GA8xOwXG+1JNXrAysM37lMH7Bw2gi0D4lXb/o2Z4oq8TXLu6Ram4bDJPc
         vZ1Z/eqEh1mJSI/8NtP5pvEEIbpzhB1ISLXre95GDmxUauTLrZw0JY26BVXA0DYMcHfq
         fXCzvlf9hSxM3KY/2Zqyp0LcdrTtk0zjzjwwkKgHCcCpnCSSuyGUTaif2NSC2R1AkMCU
         n9JJpXX2UDImR9r4JvCvH/4BHoTpUees0dJNTlxN9uKTfZuXVdPWSPVeTpBduY4aTddf
         I8MdXfd6tY0R4Zo506fZZzXfyQphzp5qqcb9XzOYyNv+2d5t5XzCiBR2ucnnG8E2zYZQ
         lNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371927; x=1783976727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
        b=E7EM0Fen2PBF48mpu7ytfTBC7VN1wXFwNFTgA4Ti5rs1XyDcVDxBqbdynzwtYZehia
         eI4g19Bqfa3+2zwGRgSRTIYbQGK5NAqvM4/jlTVsvm+jljMoGZQ8SCXyggqsqg9D6271
         kP9VWzz/nZdm9sEKQd1Aw3VqqIvEhtd9HHP5kryF7nKTZxHiQi+FBpny0+GtAm9UOfq0
         YYgVQV9slokH6EOt9cHpI0K6QAsCzsCbm1KkF+ZT0fCBdg+ViBf3KtcVbpfKOuwdhjsJ
         3nZbvdPmGxIqDpxcUdnhJCU0n/okA837u4CraT5UQAunCSK6Hn34piwdByufsb75SPGz
         U2lA==
X-Forwarded-Encrypted: i=1; AHgh+RrogCs6wtyyhyAzhDwzK5p5l5Wq1GqU18qtnYWeMJCYw5sEuieb9y25A2GB2mNavp0aJoRwUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww0jh3qEYrPOxmAGlz3mc/zO3l511DrWzNCLIrgWIoz8ZMaezL
	sLUMXAFARLqqonRR9/RlqFL7mTtcxuJzZu7lGo8qePBzvzFIlvHB6zMgVRZiOh0dzmy3rNebs72
	XpjKVksRxmSo1nbaXpArev2SmyTwKG4PRok1Mis+ObFJC+HAVUiQWzCXRkA==
X-Gm-Gg: AfdE7ckqY440zXcK/iNNwRK3Sd6o2G6O+CDxJF+uu3QDhnbqzpfrOW/tjNjNuGaxs4r
	XjgMTCf270o1AOtT/lbZ04uJMcW0HXsdlLl8uN3OhEvG/csO9wNt8uLH1GQQ7vkY1M5XKl/ZAXi
	KrbMG1S5sJkB3kPs2yUBsFDW58ggdt8EBUuDeSBgnXWyB4OXnFWY8Es1tDxRUdsEog82kjo8zB1
	OaZdxGYtSJUSfUKSjBVo+/m1Vt/lceEb/OCvBkXvKxaeKdUPhaIk40P9aRQcn1KG6BwyVmicv4H
	jRFcwMRzbkJ0jY8b0SMa1hCuBVhLvafvoMsvHDHw3bqyiw0Er0MuPWZj3CpvlHzv7WUvTVnzqbM
	+X7n27gQWL7Z0pH1Hyjt7evUb5/T4Q7XCRno=
X-Received: by 2002:a05:6a20:914d:b0:3bf:6c08:284d with SMTP id adf61e73a8af0-3c08ef83fabmr2831657637.60.1783371927379;
        Mon, 06 Jul 2026 14:05:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:914d:b0:3bf:6c08:284d with SMTP id adf61e73a8af0-3c08ef83fabmr2831599637.60.1783371926807;
        Mon, 06 Jul 2026 14:05:26 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:05:26 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:35 +0530
Subject: [PATCH v5 3/7] dt-bindings: arm-smmu: Document GPU SMMU for Shikra
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-3-d2f373912d3f@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=1298;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2jQmU1XEfwX7ksFDjORvPn6m0bWV65j9hgt3Tl3GEMo=;
 b=ql7/qNujURK5g0Rtx0oRe5F0EU5W6LTR4C3UxuwOB5V3LYSyWrfhLBHWlDx7ojbZZsimC6+l+
 g7ggaP35tf3BZydN57xyWo8ihHxk0MOvYi4WuQM9x3G919M+PkRSAFe
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 8nJ4lRxDGv60ZhsgqLNnrICOamnIj6kF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfXwBksyn195JVI
 zjZf3bjrj6cLycpfFwWmF8TONTIXO3TVb2YSQMoQFMDzfZ5S83O3orSpGBhxQvezmuRJx+JXFet
 7HjkjgI09wOnzkwhuaN0QHPtVNQvh90=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c1898 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX6WmEQPJiiuM+
 0edwvGaaoRzO0CaF4gxMb4DC7WS0+9D+wVys5URlfJph3Q2tY7hL4eIAQos630fAduagYNMAojp
 wSYWv2xcon/MJozyeXDsmyy5DAjlLq0tB1k/tTSlYdubmRpxWRAEutif7wpVHzV6tpyAhWTqKV4
 XPIBG2sh1qfqYqNyJsPx/pffIMSBqtR+f/70GQtcnbLc4xgUyd7F+G63A7P7Aor9JVC/ZnZMFy1
 lM0r+XAwcqi9ZyjDus+N0oBAfBrwXSimqoP3y5dlATIaAOCxVYtqQs4wfcdN2Tma5i7RXQPCFow
 4Opw70Fv84dMVKFTyx3mkSCKIadK3G6E8Je4+XLbBIUCq4z6YveOWLwU7uSCws+277u2l7xZHlw
 RRoW0L+p9P/hDuFwWj4GJZfzvuFV9uAxSCQ58MCbmJYNBQNmG9UhmLWaLcNymxutT9KDjgeiVM0
 3GXZCrWcyX/wHH7vizw==
X-Proofpoint-ORIG-GUID: 8nJ4lRxDGv60ZhsgqLNnrICOamnIj6kF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060213

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add specific compatible strings to document the GPU SMMU present
in the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..ad15fda5c25e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -108,6 +108,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,shikra-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
               - qcom,sm8150-smmu-500
@@ -543,6 +544,7 @@ allOf:
             - enum:
                 - qcom,milos-smmu-500
                 - qcom,sar2130p-smmu-500
+                - qcom,shikra-smmu-500
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500
                 - qcom,x1e80100-smmu-500

-- 
2.54.0

