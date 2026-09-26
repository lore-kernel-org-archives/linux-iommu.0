Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BB395AD1
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404527; cv=none; b=bZfklpjzi2Y96O9muzxBY4Zp/chLrLWK49QqWlRvq7JIHrSE33Je5b1MxQ/j8pwhrZ9Yvow7HR0z+fWQgab2jQ9OtYHJBOpEPbJQSiycoQue009sVv3vxkArxCMopljqRYSaWO1yIapiEZaCaaY28TtpkBaHRwcB1iBfDD9k6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404527; c=relaxed/simple;
	bh=u4T/TiBVjk6sDPMeOEWKmkDa4GYeq4h6p7YKB7q310c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+nSClh+46DsvlZVW6T2/w7zwGTnh5StPTKs214znFTxaYKnGZ+bV8OqUI7YqMgaAldsw+rQdNUj4zM7LolfZAGGbK42HSdKwgoelIU1CgFNnZgy1D/UXssOT5QCJtIF9VmPms5y8PjhQhIoHll975MZdeO/C6f4ZJGYRbhl2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WvR/bx7x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=frC14+l9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WvR/bx7x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="frC14+l9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68Q6PQ901952298
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6m/+51lEBEN8BFk27SUULRpvRuJnuqvGtKovB+gc4D8=; b=WvR/bx7xA6cg/5QG
	CGjdZX3ivwO7uwmiG97FC9fd49lpN7cjcvyXxGgGrdoYXGtW2n1caCg68wPEXrQT
	JSoAOlp7TbaAU1S0VEFU04qMjbQE1sJ90/gxC6l+3nKCYfBnPiyvZQzC5eP7ePDi
	Josc4qaef6dbY5tagV480CNnuG9P4PW3DJR8nvZ4GxZYHHtL01xEmvhI1///23xP
	whGLk4HpR3R2Zs9kQcxEDTuaEYLuFetywpEKpApDjmd6O/dgcXvY4SpzEN9HtSx0
	F1C75XOV4D3axqVw8z1hgyV92NhT5Qz7heldK3gOROo0b6YryTIeFSsR7Sz0jajL
	kVPdPw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jr608-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 26 Sep 2026 06:35:24 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3425098ae4bso923626eec.0
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790404524; x=1791009324; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6m/+51lEBEN8BFk27SUULRpvRuJnuqvGtKovB+gc4D8=;
        b=frC14+l91KOGw5KGQ+yHlesBjlKAaLtOjToFFe8ZpSZtFJ+o2jArdCgjdSLJ8a6Ed9
         ayfdV5MobbAYo5dt81NYnJwzeIu8TY9khXnch0EK61BI3bs7edndkc1e8kb6mxXKxUxG
         Y1NpY5Cb+RvycHY7wg5OQl/bTpBZNoyIxRal3gwDrEhEdHoqFQ2EXOr+lAXjvGJ8STge
         0KJpRksxyvQPO2eQNZ/Q+7yaqmT15KjXnrHA01Aa7OSIJ94w126KHxEL7xva/w9DpQgS
         Xc8F/92efgukhseQPF85V+qYYXVa/eZDf/xuM/kT2zb7qHJ1GN3J9QJNJmx4cMnr5pPH
         SOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790404524; x=1791009324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6m/+51lEBEN8BFk27SUULRpvRuJnuqvGtKovB+gc4D8=;
        b=f3LjfKbeLmWORiPW162CIORl67GepYW0ps13ijM0EljvlmnsfSiRNEnsWzgsJkuPLo
         Z0kogqlxUkSHGqOwnsou0JlhpL9/1VVayIAURcNTKHPy3zxJrZV4Kju0tIObfQC1H8ty
         HN61PlxUF6ahAYywJQuq3o0YJg2kxFeY/aBQ0YFWUGnDUlx2YueBs44iMiq/LHfuDmxA
         pFCETUhwNaaMWTQBRYcln4xyuvFfy3ojXUx5Nplx5t3c9tyvZv1nXawBz+qXi1efBIxc
         Y5bsvG28sFuzIxuLQoxof031klBvPb7ckbVojatAhvI7jwbI8NASbdITtpvExW2SPATs
         A1tw==
X-Forwarded-Encrypted: i=1; AKwUvByDo6MrcQT5UvYyz2w9Mpxst4BimE+YueohMzhX+wrN/6tHNmYUUISgCg0ntGqzDt8aAZLulA==@lists.linux.dev
X-Gm-Message-State: AFuF++n05imwRu3HatCn/TMlDb5BB5z+3dm255lytTjaEPZlsmGDgMf7
	8TA/JCaf66rSJAsSWmT7Th2BKj8Vdz47f4h/eeuaNEF78kgxTugqQSj8cWzHWnSofkI59McD5bK
	D1IPJrxdn50mU6HvLqm+3g3VPRo5iXGwl0I+Yg/m4FzajzpFfxO1ScJkA1g==
X-Gm-Gg: AYBFou1+3W6uK2tXizzwTH7usIOkStaWjownFJZ+TPqICDMCollcedjcTtoK7/5zuLD
	ImsXKTn1J8Uep3RtReBNrnTE6jOy+0i2a0UaSgM7CoY6CO2sZefFhvjRmzLZymjExIGW9qqgD7q
	OdxQ4FhJHc00f5Yv9iame1WshmjLip34maSqpERQ+B5P2ilWaeqiF6KKYYGOO0ADHhz0UZmCQrE
	Nm8XCKy6CbqgeugKRFbsWoxHPdeP6vWB0UvmeIguEgqJLiNPouwDrwQ/gY3PGX8yc8+tSTUtpIJ
	H/63Ip5CEyUUrgOKZqTK5CCiPIMqMwMVj3oT3qvvnN3VCa8zQzeLDge7S8CffLAD9zubWi28N+X
	edQVjlgV4wQ7lpITyWKtO80/vSwR67hDHXA==
X-Received: by 2002:a05:7022:288:b0:144:fb8d:4706 with SMTP id a92af1059eb24-146ce4928a8mr1873686c88.6.1790404523067;
        Fri, 25 Sep 2026 23:35:23 -0700 (PDT)
X-Received: by 2002:a05:7022:288:b0:144:fb8d:4706 with SMTP id a92af1059eb24-146ce4928a8mr1873655c88.6.1790404522317;
        Fri, 25 Sep 2026 23:35:22 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc45f03sm9700691c88.7.2026.09.25.23.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:35:21 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 12:04:06 +0530
Subject: [PATCH v5 07/13] media: iris: Skip DMA mask setup when the core
 device has no IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-vpu_iommu_iova_handling-v5-7-0322ca5dc10c@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790404457; l=1806;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=u4T/TiBVjk6sDPMeOEWKmkDa4GYeq4h6p7YKB7q310c=;
 b=aTqmwyfdbwKoeMl31qn9fn8d/WIqjVmq4VkgJAeoaw/HXo1bp90GA/WRWEOOP9Ty2MVmVeS7G
 45JC5KMPsiYDk2FGCR2jaytaTpGPRzXzBq/kGzSG0HCQj46VCQazbHD
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAyNiBTYWx0ZWRfX7yO3HBiPQogd
 +Zum8n/mgGDniuubbpmblhTsJ3Yxuhba3Tga1CyWvLXtl9K9sMlkxJZKqUTzTS2HcqR9eB0Eao7
 48g2WUn4e05K4VnVZP/AwOHEawWp0kE=
X-Proofpoint-GUID: anlsl30S9au0qme3BCOras_sq6kO0n-A
X-Proofpoint-ORIG-GUID: anlsl30S9au0qme3BCOras_sq6kO0n-A
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab767ac cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=1uU0fEruEEfCXXW2WGwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAyNiBTYWx0ZWRfX8HgouAP57VV3
 tygj2B7MrwZAi+FhIFbUEClcX3mrMDOW+X8ooMrv2I0juZjZ8MrNEu2XjnfS+X3WfAzwvyYCjMC
 vQBqenG3OPbmw0Xrx4SlyKx2rihBxRiqEz8WdJyjMzt/tKDW18Diq5SCn9QAq1YGpqJ0EwJ9IxW
 EM52H2HVw/wLCU0FRljXDVzI8xKTnB+Do8mZOdlXlrjDCMRFYLWRZWbtUMICvrxb942eSnwzNNz
 /RaDmXY5nAahUSoNJRA3nkd4P/IH//5X+W/tEmhy7j1SCQ1grzbKwNF2LhA4htZxjnffOei2lSE
 YtOWDcpXcs/MgKfA6RA8QpbiSzyxe8zOj2MbVXeuskFoUfPa+EgQp5MQNYPzRbDYlr5gdMoqRXl
 ENwbTc2ZveQRHFlWT7iVXkQ0gUVKvwWNf+KejH7iEoE+Fm4ZqtCdbh34+BGEbt48VVqMoU7xPiu
 +gwuNzIk1Jzv+l7RRig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260026

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

