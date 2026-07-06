Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B782C027C
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371921; cv=none; b=blKyjiKM2W1GNem5TxXnFuEH74DBaBU4oZ/bPK5KaIkD+MM7Vp0mylgsEzjRoPDNRhca0p3AkXD0GOuz3aZqPOgXJL7rBA3VdrNlqpSXNMyBmwoLbohZ/sOKmeQw+pMx/vcr3cEMl4Vms7/AmgSjJel61fmjttE1Xcz7obQyNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371921; c=relaxed/simple;
	bh=rYZUtLoMbkIwkI8yFMTr/hVq0ZeMXm4yVfo/qe4LXmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQAah2wxj2ghJyHYB2eXSuq83q8Bt04pXpoT/NH3+OyESPiVXd5OymMEtPXfCZ+JfzUEj9b197phsOdJFSpvDATvWGE4/37JlVHhTQ5/n6yVJnBHCGUpM20Cd/Z+dJRx80sWTNmx+9G8tDNGBy1vVL2C0TwuLpf6FFvswCMtdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FZ8j/Qwk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lk9pY/9n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FZ8j/Qwk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lk9pY/9n"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEBVG1504985
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=; b=FZ8j/Qwk9OdN6zki
	9ictFYTUl26CmsJYocIGqx+ILtabVxrVN4pGZTTBfkHVczbK30QYv1weMMzUgYo7
	jTvI15GrM1ZEeAKXZsWDSdG/v0AqxDI/Z1LOAL3S+tIvqFmjQddC0zSqrTZXrgk3
	MXvTtfINgtJVdUPKKTpJwB5X3aaEscjc1Dey6kaJH36Ejtmi6XyxullbdYrT6U4p
	HJhLF3n9kQmTMnjM8RzJBvmFfZIxZ4IgVvTJITr22wml8oU1r+X14PwhJAny0D02
	rmO0CfyqzN9iium7+AW3oW/jQHFlpy0SpfcZ37eGJnznIs1O2UN3W0TX8jAPQbZ/
	DUTOVQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98jsrp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:05:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc73f47bdcso43874705ad.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783371919; x=1783976719; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
        b=Lk9pY/9nSPAgv6a4OOkz8wswJvGOH5I3ah6ZoSa6eSPdY3D1tMoLe8KNwAskXenr5C
         SgcqS4QiobWk4eTgX++hacOMizh5/6O3InCUroTGM9FBp/SoToPOHAZ8SHfaK3zUT80e
         4bhtCe3xHfEIUv+zkKCQB1q3q8PLjVtYekw4u1VM+N8atmkkE9/Z0Qxrdcs+Zj40mHy2
         5B8jHGr7QpmiJOLxL8N7dXx7gGc83vhceVkgoGALZ9Datc3dFJlSeb7D8lBKF3bKeDpC
         2Nve9dwlK7yOrz4uncAPd72wzw9KzM7ifhkledsE5TPdp7vUAzDczn91RLKhhin2VriM
         OSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371919; x=1783976719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
        b=XSLjARI0eOLvwY1p0kMKDztTCjciOd90DaC+Ohar0B2wB3WCCqZIbRNhRsAXOpasG1
         DQ6NKKHmhr59qa5XTXOJNSeMxTXYx6zt0NAnO+Im1LZFjCfY97YWFx0lA4t7Jya5uCeT
         2qigVcdEFkkKzxxJCxSOpYnGoTZH741ugzbFWd2A81XZS88NptxqAcFFQhE54AKR9i+L
         bIexbjd2g+T3dBWsexCBT7klqUsoY7+0GV6N5++FDd8js+I+tqC/oRsmpeBCQ9qZk//K
         PUa9XMkISGMA3/DeqT/Ks6iSBT/77u7fE8IfUGDc4Q8LhT0iTwOGtYNxcfIqSiTnW5Qu
         MS5Q==
X-Forwarded-Encrypted: i=1; AHgh+RorxXxPTI/Lv26TaSb0lkt9tntJip3PCBgKR5fiPw71wcKbBPzWstNdDz+KQ66lfcpP+lLBeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBgwSxusnEDE89chEiGLmf1EdylZNdrkrXkoBSVI/Yr/MbyX3J
	djbJzvOmRB6k09mdOo6xPIgyIyA7TDnlkSbcXBKNzP+G6Zfgegs04uZ2csfeI2WJzll5rPxGD2t
	xZ2Ya+uWz3RDE+nadpUTiGCsuSU+sWzI8PlGwZb6Yx6pTJZsU8gYopUyy8w==
X-Gm-Gg: AfdE7cmpzVr6hgTuNY9P2WR0HDELd4c5NJMjOnf5DDiLQpvmeDK3ErpouhOo+MObfZh
	UIIGeLMMXy68doafsuFw2QzSSBPismeW/WTmHc5KxEA/zaelzoE0hWqxDYoQa7lKV7mHgoeIt19
	8K1FBplpoBo8MwFe+8Fa4RTluaRtxC3W26TgFeDNOjRVRAtGRfMFBGDlm2i2MqjY3DtqqK79Uy7
	5waJG7FWpn792U03rIqm5K5Z/IA4lyeHwKilYM7GOkaxl1AGGQVbbobo9176clWKZ1G22+wwhGa
	C2gVJ1uHPB7UzzqrM2hKdZhdb9l7txRc6i5LJEjvGtQmA+f9wVnsrBsUhMISPrw/A+LNpqo+EGz
	+xlsNLN1D0z0CKk9hbOmp9R2DnukIOJohJQo=
X-Received: by 2002:a17:902:d4cb:b0:2cc:9473:9799 with SMTP id d9443c01a7336-2ccbe71f6abmr23765115ad.17.1783371918744;
        Mon, 06 Jul 2026 14:05:18 -0700 (PDT)
X-Received: by 2002:a17:902:d4cb:b0:2cc:9473:9799 with SMTP id d9443c01a7336-2ccbe71f6abmr23764605ad.17.1783371918261;
        Mon, 06 Jul 2026 14:05:18 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:05:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:34 +0530
Subject: [PATCH v5 2/7] dt-bindings: display/msm/gpu: Add support for A704
 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-2-d2f373912d3f@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=919;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=e0reXjU4841qQsB76OT4bfKmGmY/z//RRWVRYHDWGzM=;
 b=vX6elNuOWQ/4xTG/AIha28ryHCrqCz3yvhkLfw4vwe9YMkegmgcm19fBeyeVORd5TxSW+WwUC
 /8wVZA0zXpkD5agy1gfq/6ZA/4fyK4Fhy6L2Kfebx+YnGBJfWNznNZy
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c188f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfXxnxvVc4d9wOP
 2RuAUY5FC7KZ7/D4HYnWiLfEFvmonFWgyeeLlCfmX3OKEeOVHAn/1VenxfowKPYk2kGNakKdodH
 WqC/5QAb42L+cgWWbvIczyRL+UuQp3hOF8iB0iHbw5o5IJflfKP3zwEeYHW5NCwPYHCwGBxUkoA
 t564j4RZPLWuD8e/+C75k9kg8rOjuhgZFX7SPZTJF7KhxR6qe8wGv60V69F/rv2y7aot8MPNPlR
 8jDOUf14sKVIplbdCFOgMzbw0kbuj67v8/XoEDyP8sx8LIkqy70M6L4ak7zBKGCnV4ejFD5OWHz
 sOE6k7APDyvwx0oXiVaqoIHg/6pIZ7v6VJprLvZg8vUE/xWmaBd/IiIMotoCGED3olhEk3e+jzI
 LxrlC3Wd6fZ13CWpoXDoKc83vO4w/JycT8CC1qW1tHvwV5TjTto811ut3w+nHD1F1A7UcZvV/8q
 UMQRGYg7Al6xhGozGLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX5C6N+BZ2uBRO
 BerKW5QrUK0Q7ArhiAZrC1359CQTc3Ax4SssPX+TWKutY3Nzy4b9OXPPSGfpivrlMXCmUmIqe+E
 DqVBgRBbbPN0fXOG25xvhNXdM2rgKS4=
X-Proofpoint-GUID: m3C2cjITAkZjemD8C2eiCkN0d7aK1v-l
X-Proofpoint-ORIG-GUID: m3C2cjITAkZjemD8C2eiCkN0d7aK1v-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213

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

