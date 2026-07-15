Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973F371D14
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124648; cv=none; b=lL727LB7H0Cln4flYYDAIMDtuyArcrnJBh+NrjqV1Yyox8qDofgatbHGIl4/aJBXLyQtUt2RgQKAlapcQMeJV/SsulRNJ5v5wpShFrSBvYTd62yxiQn8/2klmxYfiIsNsF6mxBJrzA0qspxJ7nWqNNzvxq4w64+W+jnjAVCTGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124648; c=relaxed/simple;
	bh=xDKjG51jBAk9EXSAgV+S8o6yhO9zrtRBIJx3AXPH7vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxHnyRR0RPsZSyUkU/nke2fcwriaW2tzNn6rB9bfKmtUMz+byeQ1XrS6AcTy78pw6AHaVnTlCgLk+pPVaEl/11+uXem5Ao1TNyw+XSW6qrpN7IvSp5rRpU0u+pDToAJEadKZI2PeKliy9hZONAKIJKM6uLWkReG6QgFcSOgYnR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XyxjMH36; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KuBXS4Xa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XyxjMH36";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KuBXS4Xa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FE4TbB4025751
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jQ1czwxEPod8YlqEh+zmO/6OKv3iOp22VfF1LBuIlCI=; b=XyxjMH36YcJYCkgq
	TcU5Kyl3MDusL3IHng7fMmA1mootoYxMMTmttEKkJgbs7i4vnplaKd2roZzJ1p1P
	QdGBkf73b3BxR8aByaWY+ZklGtCFDuvpPUUB3Y+s6e4NL++gnWr69Z7RAVRLGvyA
	SBWR/u4Wxa2tcb71VVAONa/ZIXpS6XCuniX0SBuFFcr1fh/B9EFEcYLRWd6v3wxo
	/l0x5N6Y0XIwF9PCeEsgC/cMB99Wgsw/GuVU7/fTOmwyuLbk7ToPo4CgP416peC6
	4pnep2+FnBJFShicP1fPaX1jSxcED346tWWIhIkr2iy6tOanQVJv9ZUx/MPHAQeK
	MGb8mQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe03vjpe5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cce02cb769so28191265ad.1
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784124645; x=1784729445; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQ1czwxEPod8YlqEh+zmO/6OKv3iOp22VfF1LBuIlCI=;
        b=KuBXS4XaWV6LkLuiwbxl3BxwRi85X6DOHfbzN2PpIuWwSxg/FxoeBY8okuNFDeQ6I9
         U0sD3fjrAm6fb6wXs3q0co739oEGmeDKbkj9QmsXCw9IwbMrTQ7LF449+wg1hjYIUm1b
         vBCd0P+NaMYApTozZPX5YfYYZJeF1L/ilr70Vtk07uzjRYLeS6CixwSoqpGuop1YqWst
         yNlnRucjGTREkeW4mWFcPxaeOhu//TCRR6yKQKlwQzxNoBxaJEk6Uy81tO5Cw5NeOje/
         KidEyhGINhalPOXZEx3ificzKvJURmP/gwu55Qq303cIDivAZBFGi24fxpTze9czeKwi
         Mwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124645; x=1784729445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQ1czwxEPod8YlqEh+zmO/6OKv3iOp22VfF1LBuIlCI=;
        b=AyqSyhQJ/7TJnoNh07vZrcTyezpoTrRL0FulKQBLb3V0hM+4eSkwPHer7zvBP7TtJ0
         MNSeeQ3i/lsnVH2pgtQ7hh3/VKwfq7lX+2jXf2v+Z+IZjFbY0bfIySlE+E6JdN4MU+6N
         8OA0WTlKtyqVWAhLDwdkOkEALetoeV1crlNLHuqkPyJzCeLhrnPq76ScmOrFdaVu72uu
         6GaUsDKpgIV9btOXFh/g00bYjuYhejO+yC+y35tR1iwMglfFgd36C2+iiDm5cOeJZ9RQ
         ZjC2+hc0FBzkjuRLRttdZnX6vIzZ4FVv+Mv9M1W4w8beutlzRC7nYJLxtVeBq845pgtl
         5Quw==
X-Forwarded-Encrypted: i=1; AHgh+RqBpQEuHwhQtWZgEIt+ILb2C94EmV7/djdLpDLxtuuoHTrQMSxEvxrQiuWgS0WAXww5obj+iA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH6MSW+8HP2rVe1/u3BOhoIfYHlnI+b4frSvrHBKGF/NZubxjD
	1JYbA4Q1Gf/KorzTczzUhUdSmiJrbIJq25GAFGrH8pFvrc74iiHKurhfxjdqxyXTs6y2Mx9xFmX
	UWWYGoV+mKYHVODBAC/nIDXESv78YgBU4J4jNUwl3Hhr+m1DRH4jjIDg0uw==
X-Gm-Gg: AfdE7cmVumCI8vwRhfY6heh7JCG23nhuhhavRA8kZ4Phb7BUcSVry/k2U5etH9bh2QC
	3THJgQozjlx81zI5TD1LiRgpMWPup6VNUVpZYs+P/H1LmG0JSzk/NIdf9lBI4Ht76TlB+0BOnIm
	G79lQHgpZygCMpwU6hboLejbi0YOnYhOhT4G9259m8QYe1+dmkBnQEyfTpdH8jO1KeYC72mJOoB
	J8ONYi9CZaO5It7mB5dzTbFbaXB6Q2yVRjw4Q+MRHzM+yq/gL1SnCKEEUm4+qbl3mI9hFw81pjQ
	CBKjAJAb20AkGRBqEkQhm5n3tVYkA39GYCF7uJWu33h58wCGx7juuJpamOZt4FplqoViRwrIifS
	BBh601N610SaYXLeupy3iPJ1arL+bvEUnSqOD/hqaTTzf
X-Received: by 2002:a17:902:f68e:b0:2c2:cf20:213 with SMTP id d9443c01a7336-2ce9ee1142emr186081885ad.29.1784124644501;
        Wed, 15 Jul 2026 07:10:44 -0700 (PDT)
X-Received: by 2002:a17:902:f68e:b0:2c2:cf20:213 with SMTP id d9443c01a7336-2ce9ee1142emr186081605ad.29.1784124644086;
        Wed, 15 Jul 2026 07:10:44 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1070b68dsm2913215ad.79.2026.07.15.07.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:10:43 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 19:39:59 +0530
Subject: [PATCH v9 05/14] media: iris: Skip DMA mask setting to core device
 when IOMMU is not mapped
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-glymur-v9-5-8cf2cbe12a07@oss.qualcomm.com>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
In-Reply-To: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784124602; l=1589;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=sjEt7zVED5HiiTDKACtd2anjSuOH/+nGuerIdCCDwyY=;
 b=Akf49Yj7dW3GwqxuoRtoRP9AK2qcSXDAAVD2VoECqphz29qaa69SzMfa0lyuS81QJoZMYeFtN
 VXSV51eLUv2BIs9kTVKE9Zn7eYjgvGiQ1FBu34jm+ykdqzRBARCJtpg
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=Ife3n2qa c=1 sm=1 tr=0 ts=6a5794e5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=2w7d1ukKp82XeiQ8bL8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: oZhN2ReMMErZYz6mSsBYHXSAMg9ZplFo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX/fYPxCB6yu2e
 wGztlQ7j3nzDADxUgfucsAkHDR/gE32UqD+yk7qSFuaQFfkeGtebV3z5uCriZ5H6TIycnA6xe8g
 +F50qOuRHMCmqlT3qOs2xPcuoNv04qcd2IWV5MqlYMCaDmphBZqsO6bf1dnoAVniLPG9Utnjj5j
 s8iYZdCfXSX7rNGbkMAUSaOh9l4bMIogcB9uUlES2ei83l57FgPdBHZnOu0bPtWs1kFxfn2tGxS
 a5IlB5s++v2uWjkKKHhLgHnBgtJZAGa/7+nH4Ktfj5J2/IsHaziEwI+B8I6APRYpSYcGckby5Vt
 T8EHEHEFdJh+A8l6zykV7WUMyPoE+ZbqBDKwmGk2QmZXuJI+EJ9Y/9w3C40t6cWjV9ziRt9XhxM
 iOmoPLfqJ6KJMHKXyWxP3qzycKC+I+mMNxasuWMvG2oMNWp9XRlFywJe8rwVy/sQ0orE9W1lX8P
 OVOFYd2e2jN/u0T7qFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX6a3Ho9/+rTjH
 34VxBKAfT1LhUcbsaFc28FozBtfLKdPf8DcAh8xLnNwiuFu6jf9bjpfrlXHDP8nEHgmXTm6Y2Mf
 hVktnZzsdewRkhf8N7PpE3n7wa2gA2w=
X-Proofpoint-GUID: oZhN2ReMMErZYz6mSsBYHXSAMg9ZplFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150141

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

The non-pixel and pixel subnodes move the IOMMU streams away from the
iris parent device. As a result, the core device may not have an IOMMU
mapping, and setting its DMA mask is unnecessary.
Legacy platforms that have not migrated to subnodes still associate the
streams with the parent device and still need the DMA mask setup. Call
dma_set_mask_and_coherent() only when an IOMMU is mapped to the iris
core device.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/media/platform/qcom/iris/iris_probe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 2594f5a67378..c40c4ec44e83 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -310,9 +310,11 @@ static int iris_probe(struct platform_device *pdev)
 
 	dma_mask = core->iris_platform_data->dma_mask;
 
-	ret = dma_set_mask_and_coherent(dev, dma_mask);
-	if (ret)
-		goto err_vdev_unreg_enc;
+	if (device_iommu_mapped(dev)) {
+		ret = dma_set_mask_and_coherent(dev, dma_mask);
+		if (ret)
+			goto err_vdev_unreg_enc;
+	}
 
 	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));

-- 
2.34.1

