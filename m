Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777F36897E
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239286; cv=none; b=qtSeaaEVoj892e4ABgPQa0q5khDCYys8d0z2VMH4XW/iti/CdhqeQW+0id8cUZ5AnPwT9YA0S9/P77ohY4E/LBirmF9Kl4gr1r5RCjnRyvnjbxsOAgGKOJMydtkJ2Phv3WHt++3kLM/OXJV6aBQIc49n5RM7Vq7XMmUXIZJsjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239286; c=relaxed/simple;
	bh=HZVp9+yu5Mjb0F7vgiRaX5z1PEYeaeliEtjK5AzdYdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZKBzXWtsFfHfdwuDfGoeaHJEs30ue4E3+7Swbq6Q/9/1zj+psjtmQrzBqVSibjLK2NS8QfhWeIrNBMI/1HnvzSsRtGjjsOZX0v0MbITpW+c94OVokCivxYRfl/ibUSGVmPSeMkkEQMKmZCu94jtB01ApnLvmfnaQnKfBmFB4xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X9dTxtoQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c9JA/nrj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X9dTxtoQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c9JA/nrj"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664MjtGl4092232
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qot1YLP4Qw62VVQl33YtNMriD45vwXzabf/W6bmpClc=; b=X9dTxtoQsWPjTwA5
	Gj50OTqt/zygM17ti3yhh7M3q02i2+/8io4M/dCZWKo8aDCDbJFY5L/6IXNX2FtX
	sJ1GN/oXfqwAOrhE2Vv1azlgdptslqSW6CDfwwhWzEtDUKRRNWfACP485i2RDt7M
	HCiCnfm6A82Qix9OrxwmJhAoOQ1ZkGVQJQPaLn6kmdtnMNoXcjqSk/jgt3zgPTFp
	yF3F/SWTe3k+hCZcLnPHb7P+kyBpq92NIfUaY2YND+as39H7W9QTNw+GFpiFBODU
	mK/j76efBSjNZyKLMXsKvt7gXvPupnQYXWn3/ZKgBGUr9iD7HTIvTKawfHZAFp0y
	nzXvLg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txej88u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:14:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c9e9cb6a44so15059355ad.2
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783239284; x=1783844084; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qot1YLP4Qw62VVQl33YtNMriD45vwXzabf/W6bmpClc=;
        b=c9JA/nrj9cKGm3yfmEfdmVjtHbLoaOHV6DC1mi2XmdR3WIKfinuNdtCN6Wpm5ExxQb
         QpYwcSyqHbfqhHXvytAp7rkje1JgHt5nL/+hvi6U6QlusLDDhccDru8yyUALgVftNuG0
         cyRjBe/WJfNIyYBlPlC6rPLIlkvYLuo3+ykF4hyJYKabd1ZAF8y6FlntajfTAHISWFIf
         sb6baYr3iODsdGFmGo/KLe6xq/vqtPbPK7Z0AkQ160J7wKX1+J9PHQOh5iYfp4prhR4t
         83bm+Ojmjc25WUeWT4HqWQDHEwGlH4wPVjFaKZS1GVGzVrZWYBP/6QonpSwLo5GO9c/2
         kwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239284; x=1783844084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qot1YLP4Qw62VVQl33YtNMriD45vwXzabf/W6bmpClc=;
        b=I8iDZscbnwmKt2aA/ydaiISylLEDRZag7JqMkeEjCMVjTt0LmqFaBKqvtVV8lCacX4
         3zYZefrlQIdb5OiRFBNBJdYB9vthn4p42oLAi2jU+gv/ZR9KDtNd3Z/WwYukbW4HN+/+
         5EoEPX3yBHzrxcAV3rZATT0UAGQLTMC0BZLv1OrPox3ooOWOk90Q568X+g+aP+Ws5aPn
         /bB0zfHaF01uMyHLhgr87ZPH51zD/NUU1CWTXSJAiZY1B1AjWky19jW5GKsj+SBC6JNj
         4g9oEoRg5cP5tXhKUncWBeK8YGfuDdZn9sgQ6y3GWhpZWThhNwxsoWbkWkVCa4MSGemb
         U1xw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0/+bBUCaxwiTLkDNOygB5FxmTMjlgsaXQuV6vLa/8iu0mbHgjSc6aUFoMmNIuA4UVtoyZ1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAKCO51b4kjOtHXiKKgflR+wuWgfjxJPN5fjCrdWQ2DyhyDtA8
	J5wfjQoTHEAzG8r1rVP3Ojz5mRSKERbnmsT3arv1nawoZkn5OBSwS2MeZCQSp5BCCJQzV2vLBYw
	5lgGx16Nu6WGzDakW7crDyNnJul7aedkh/8uLoTcoGDfLAk1q4f//16sP3Q==
X-Gm-Gg: AfdE7cmzHARo2s+7P1LxU6EqQAGOPRLGQemKSz/oB2gNKXqknVfI/XTeasOyjQjtrpd
	mVJ5UPE9YuxUQUq5pFfzr+/95a7U0E+LWgcKUDu/J5HnkkcJqi9klaN1BfVK4U3l6B4itsTbOIc
	tJD87EW6RycFmDbDHRP1k0SFDLDluCjifIaVJyigXFauIwBFy7FVZivmb4G0ZO93oixEV4DfE4X
	q1/ABZr+yNHwmB1DsbgI7psOUZ0Z6Jsz6FQm0EvmGjfpbxbJltXkLLtNbETmdlfWMb7018gL0u/
	NjsmpQc8pmyO5D/+UEwttCOwaLY10klw7lX9tiHRaWZne5eenzzKa0u9/icRCiG5EWpC8+HXv5K
	TD3KC1qBE6o9cK7yeDtf/jLJ6TsoLfGFz418=
X-Received: by 2002:a17:902:e74f:b0:2ca:ce92:6e44 with SMTP id d9443c01a7336-2cb97e58139mr61841975ad.8.1783239283823;
        Sun, 05 Jul 2026 01:14:43 -0700 (PDT)
X-Received: by 2002:a17:902:e74f:b0:2ca:ce92:6e44 with SMTP id d9443c01a7336-2cb97e58139mr61841665ad.8.1783239283335;
        Sun, 05 Jul 2026 01:14:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:14:42 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:16 +0530
Subject: [PATCH 1/8] drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in
 a730_hwcg
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-1-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=1238;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=OoP30nq6efDw/gDTU4tVQRkvylV9nMkq0P7LwxjPzqc=;
 b=K2483gwyhqLi/J7WvjgvqDh88wJZPkPUhmFw5qcCp573LO6/H7fw5XIN7fLqLBDMer82FPplk
 Q5nk2eUH9PNBHF7RtP14pDCYSjIh5szSJQLeY2X1ovfJKHH8/UCoysZ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MyBTYWx0ZWRfXwoTRYB4xQD0B
 tf4p0vu+0hWl91LnwRZWWUZBMXNW/Sw24Bx1q8gAf3wFoVt938NojdgL6F0ZK0m+BF8t52ve0Fw
 OeFvzsDI0V7EKELVhvDadj4Ty6Gq7IM=
X-Proofpoint-GUID: MdT9ZnWTdi5JulQ7urFzdW0Df6AZVp4W
X-Proofpoint-ORIG-GUID: MdT9ZnWTdi5JulQ7urFzdW0Df6AZVp4W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MyBTYWx0ZWRfXy7c1lNoEQxg/
 Zzn4BMqmJmWcbsuYGepctet9NNQfi54wX1mPLSI2c0f/lw24uoUl4qOSFLFRskuMIJnIlGVi/S5
 jLVFib/SReLlqOp32DCP70wbthaFzx838x1d2ycOprU080+iqZb5XlK2aIH3m2leNy1ZiAg90dD
 BzaJDKEGGTV3EEyRaTljvFvHQsmUuOFWzSWSRRoctNmbW4zUceyx3GU87rSzYv/Y8iswpT3gh1S
 lM7hN0GX1a+8kQu7l0e7JvcgNvVxVRmDi9qr8GAQk/Kw2Cdm+qHKfLKUwxtPdn634ph5zsWr+ov
 X1S70LXexFNMskvo/dlEkrVwMGiz0lHN9fU4NOYh/o4AoStCzKUHLa3vIOtcubAwpChWPCDj9SG
 r6pHy1odU41TeWYL9GXgnMbuDmTSelFZGxzOorDwQ579zl8cn1PkAihIhI46L1wpROz6XHlhn30
 I4qE4PEdtp3fThRDM+w==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4a1274 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Vf0ozLlH3VOCCO7dkaEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050083

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

The RBBM_CLOCK_CNTL3_TP0 entry in a730_hwcg has bits[19:16] set to 2
(clock gating enabled for that TP0 stage). As per the latest
recommendation, clear this nibble to disable clock gating for this
particular stage.

Fixes: 9588d2f860a4 ("drm/msm/a6xx: Add A730 support")
Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..a98d550b72d0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1199,7 +1199,7 @@ static const struct adreno_reglist a730_hwcg[] = {
 	{ REG_A6XX_RBBM_CLOCK_DELAY_SP0, 0x00000080 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL_TP0, 0x22222220 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL2_TP0, 0x22222222 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22220222 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL4_TP0, 0x00222222 },
 	{ REG_A6XX_RBBM_CLOCK_HYST_TP0, 0x77777777 },
 	{ REG_A6XX_RBBM_CLOCK_HYST2_TP0, 0x77777777 },

-- 
2.54.0

