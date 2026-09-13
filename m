Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883A3F870C
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325444; cv=none; b=SaA9/bXiORfbJlAQ7v8iGpWzyEDsxqc8hZBcbLWCHspJdGkwtyhVE1XaS1V6XkOI+P29aK7fFDM1vcWmUzBZN9UwDe5EGjebhiUfkt8EHG+9IjURNEwz9/8woYwl3twe+541UUSB20pkxazkNiqt701l48cpKcHxmPGH1DdzRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325444; c=relaxed/simple;
	bh=u4T/TiBVjk6sDPMeOEWKmkDa4GYeq4h6p7YKB7q310c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YB6SVmxC5rK9In14UxlrgmQ1fwv2pGtD47omNF9cJrGmfy5g0BZwLBW5yQNqOHNC6LI377ki5AjgHxr+sJHPYkmRr+b1hwnIsP1KkYvI9r+JNjoF0elzYlPt6QJkfBD19aMBO8YRgLW3no7apgsiYwUl5HX2sMv77HlvQJvaGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3RVJXJb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ShXNO/0N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3RVJXJb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ShXNO/0N"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DI2XB83284310
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6m/+51lEBEN8BFk27SUULRpvRuJnuqvGtKovB+gc4D8=; b=D3RVJXJbDMef+7qr
	wM18t2813Qyobh3pgTt3yRs0+10ZMEookR+KMS5Vf0U7Cc2BS5oEg820O77ULNKS
	5YWWOz2cfDPrLsF0qAQ9NMx7PoG9KSyMUUErzl/Y16+GFTizs3JF98Pz1mU9364z
	Fi8IiAwQYdsWRQtBN7hbm1IYOTXsm1XTovJyuHNH2N91pbzY0ZIb6gklqkacEM4Q
	dlbkSR4yUm0RNvTfJ/pydKTivGC8xdZ+SMFHAkTLEfrN56pMirvUrrfked6ft2jX
	x8D7bGmu5MNbO0v23puZ11h5rtyUsQTf7pscuwt4mU+WDtT0QpakMtTz6++y4UMh
	CJDjQA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cby6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db3d832827so31965905ad.2
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789325441; x=1789930241; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6m/+51lEBEN8BFk27SUULRpvRuJnuqvGtKovB+gc4D8=;
        b=ShXNO/0N0kQLQN77Cmgp6GcnEqKel4vTX1+yjCZrxz5t9A+yyyFPnFTd5/SLeV+gFX
         HYNWj8f+/gq4eYyAJyYb7dpuwBQjvHCril1xQ/T3VI+Cum/6xBTCMAPVihQXDXVdRx6j
         HcgGJGjKApA6iznepADP9Qc4NVAzMAeXBD4Rny+HYoAd7XlzvD7/qYaAh4ZNnRXXco2W
         0D9B0NGCtVGpkAx10feEgPleDLolE98fAurWEGbb35QeroNtSlxIJLkqohbjsZjklQNo
         KIKP8Xi3O7/IJNKNx9zsRHcygESI3jM487MPuSasy6m1FPgKIzZt47xJFNK90m11Kp97
         XB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325441; x=1789930241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6m/+51lEBEN8BFk27SUULRpvRuJnuqvGtKovB+gc4D8=;
        b=PeYlFJRap1f8/pAn7CU2p8nqcDUrBSgbrAglFtzkgfQkVXWboXTZi6ih7VJv0KyBUJ
         60IDjgaMI4YF4actfa9X72BxQXfyh22lzuVWxnZSRuabBbyqB0ilrr7CFMCj/Hl7WF5d
         IWCKR3+qktwsFwYHOPnbpyMRYuf9b+T0s5MOvaK8jNRRzxomxLUY++aikjMN/rzLtaPS
         gQFYeLTpz6fLxp3oG428kUHrq2SlP/VKVys4pPn3IQGOTi/KyrJ6qmzi97QTe+T/KnLM
         Ca1Of/4iL+R4V6W6JQDgOdkNhJVrdlOQWCKLa43u932cunZj8kRNxJ9zcAPUiTQBczrB
         UYbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvnIfKodtazU8sgQX/uWuucyf1vGUvPs8IKk9FytZgJ5ycgUB0vBcYxM3m/W73yf1QL8IFzw==@lists.linux.dev
X-Gm-Message-State: AFuF++kftcZq59tKrbqpaQGMe5YYMyztIOhdG/JVY9pn7KEWUVqjUfaJ
	LIahSXxk/SJaxXXK2pQFvHbKflMOian9Bj+f5vWXr/z5e+x245zGIxa+oxctu8V3sT31J3hceif
	ToP34B6Uw20PiDesDDsD/UwLWJ4rkIIif5KQy/nLm9e89v96BvFMp4FaQdQ==
X-Gm-Gg: AYBFou0PBgZaHCPjS4QFihEcY/Tw6ufEVdDuMKmThTmuAar51+QXmiPKytI+FlIH1MR
	VKuqVhBeTk1+7m+li4NDA8IeVTt+3GlizKgxfG/T0RaqvJlY4POWQNpsM0PEbXFZQLbkM+OP4cj
	Hzl0ZDEIeuA6M/l2t4un8x6KxTXRqnQUhrTOw5KI93p/oSvlfW3/3MGqp9DEVZLnOHrSg4KmlUS
	vm68bAtXF+3hxC8PucIbxDlzqX51gQ3/X3nDsL5UtJR73taDks8XDClIpwNygd+xTTHwRJR0GHM
	Os8MjM+ItAFaglnCTTA0UfkbEpB1sUnQhN0VgM7U5YKm1/llP4OqxEB+meLDHLNS9Y1L5vH2AkI
	NxIlnHHnA1rqt71FZU/6uBqSaMhQuDDed/G8=
X-Received: by 2002:a17:902:d984:b0:2d7:f0:896b with SMTP id d9443c01a7336-2dd2a33648emr270824365ad.13.1789325441459;
        Sun, 13 Sep 2026 11:50:41 -0700 (PDT)
X-Received: by 2002:a17:902:d984:b0:2d7:f0:896b with SMTP id d9443c01a7336-2dd2a33648emr270823745ad.13.1789325441023;
        Sun, 13 Sep 2026 11:50:41 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm22473130eec.24.2026.09.13.11.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:50:40 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 00:19:24 +0530
Subject: [PATCH v4 07/13] media: iris: Skip DMA mask setup when the core
 device has no IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-vpu_iommu_iova_handling-v4-7-9b9074a73c41@oss.qualcomm.com>
References: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
In-Reply-To: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789325376; l=1806;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=u4T/TiBVjk6sDPMeOEWKmkDa4GYeq4h6p7YKB7q310c=;
 b=b/OU4xVwL6Uy7p7LysRQLTjOXu92eavws+64eXUu0+bfYdoL+0OiwJJs9umzBS2comu/vew0g
 KOaqouqlj83Cjk5pDwRP/ocj3Qz9nsLuMW5i/1KTFwdM2q1Dnx7kpOk
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfXyKYP1WSZsR4+
 4d2YWfFM+JEI48sqA/BQsH83QVndtX4IyeOd8ZDZwZQ/8uVk7w+/KfQwGYxtynGgoYKEoji8fKz
 KAP9pC63L2GrkAkGONSOE9QpKLgRSjs=
X-Proofpoint-GUID: IKJ-Obt8kraJxQ6nezx86g-vVsrft6h7
X-Authority-Analysis: v=2.4 cv=BdZNQbt2 c=1 sm=1 tr=0 ts=6aa6f082 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1uU0fEruEEfCXXW2WGwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: IKJ-Obt8kraJxQ6nezx86g-vVsrft6h7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX/XXXXp/9Kj+w
 TIC4YxDhLuhUu0w2aFeh/wzYCMOfCpU/dBCwuX5qvAagk/NLEeGOfIfZ5vi9XZDXTt72XOvMXwK
 U7L12M8OhJqB5wQxixW7rRV8HcBEVb1XmEh6IdeU1oBdIoa0W4DDMXLZFCSP+n2XM0+1LfdPHaD
 acrP0WilFsR+XK8fcKabBCSKq84HnkrcHADco1KF+AUuVJFjb0cdMfvglCzip/ZJnwcdbSKdQr5
 5OLNx9KizWtGvUaFfIO1uaHJVpPx43+IXHB0Ea6tntl6P7Hq6GbE5/7TVg12wJXeF35O/mtmDkj
 xBifixjwYh0JJtYZkelCCXBSRXS0OeBuUYWUmHu7bc3ArH6/y6DILXSPNUerZ6FENAUEYLaI9gs
 QKuK/M+rcAiVFmyht2XuvhCliQyugxEeQip+1q2m6XJyolrRIIMlNrzDfRM48mbRl+QR0jbMwg6
 dXqIFRJGAfp8wd1sAXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130267

Once the streams are described as context bank subnodes, the "iommus"
property no longer sits on the parent iris node. That device then has no
IOMMU domain of its own and never performs DMA directly, so calling
dma_set_mask_and_coherent() on it is meaningless, and on a device with no
IOMMU it can fail and abort probe.

Set the DMA mask only when device_iommu_mapped() reports an IOMMU on the
core device. Platforms that have not been converted still carry "iommus"
on the parent node and keep the existing setup. For converted platforms
the mask is applied to each context bank device instead, in
iris_create_cb_dev().

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_probe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index debd1f0e57038d7abf463e82fd80f887b67750e8..4bdb078d83b5c331869dab2409bc4d10ab302737 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -352,9 +352,11 @@ static int iris_probe(struct platform_device *pdev)
 
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

