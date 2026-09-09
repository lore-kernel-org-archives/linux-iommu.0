Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028E583AA9
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965911; cv=none; b=hifrfx6A3IlJcTZxhvPh9eQexlIIKK88wH9A7f0RQl9Faxc5WRhSIKHXekGo+5piSyUw2U/jZYwQMDoA09Ejen2989JOyBnTEmIbd+GEfn7uAPmxv8KQqoG6bo90cy09RRP9qThJu1nhbkdISfhgw8OArm1L2RhmaSry+Sqwq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965911; c=relaxed/simple;
	bh=P0mNJFeoCU6tU7rrQorPgkeC1RVweTgvH8tb7j9zhEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4vsUSWpcy2j1ACvI+jGTZ46BmK1F5a7uZiwlVInEmm1IFBAw9iNrAidjSbbVFa5avmmk/EVjc1dFun/pWR9YnGFgSgR59ymWYH2pIxfKmWaYcNWVRaSCobLgBK94hoZ9riH/W082EQGv+JML/urS64cSCSC5GhigSS+HLwFh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzGWXeH7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FDBfGD9R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzGWXeH7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FDBfGD9R"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU3h01183629
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 14:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qmdf/9peUPSB/yZJlznGcLTDuFu/YJIWa9uggXF29DI=; b=UzGWXeH7BgWZKVza
	sSwfqPaHnxfVnudesso6SrqOrGTuTaBTYW3xJOVlp2ni4fZKfE8j1P8pZ33SXt5A
	tkCiUI5V1zehilUFQ4y3DkwWFThvJr3vqQSUg+9L5ODxsW20bXasgt4qYnkU5O2G
	MHQgLgGxE5OJVOMddY2bflzFp0/mJVUklE6oEXB/39IlsbemWsekXGENHgGGq123
	d5WewNan50vsZcjWD95+gZZBtXr7I34asae6Irx8TkaiScvcAVw5jyeGZdEXGA8S
	dEcNVw+jt/u02H/Lx1IU8PkgHOoY188+LwA4uylL6IXE0Bos+eh4wJJq943Pup3y
	JW86Xw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk559s8hy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:58:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dc7337e2a7so15799475ad.0
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965908; x=1789570708; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qmdf/9peUPSB/yZJlznGcLTDuFu/YJIWa9uggXF29DI=;
        b=FDBfGD9R6zIc40L6GK8I0Wgdlwp/Jfo9y/S+7YgwADlJ2ezCxQx/PEbr1G/CCkKeIJ
         iiFtSmz3hWppqZLhbtAlo4OC8cTyjVuVD1QmSCUqoobMAVUaHgO40Pam0OukjvNYMNWh
         tuRodJPpzporF5RliEpnaOFgR2YAkDDOys2u/kanMbP/usjlQOC4JMI7opAux11+tkU5
         pschRy5T3tz2x6F9Y+qpUav+r0BTuXi0yuPklmJgFSy0L9VXQ3gq2oM45ukgQUX2hGwI
         63GNnXcsgFhpBkLvn7mYmNdA9BAH5LG2C8KZCLYy291eNqeiTjP01oaEwBC2BMj17uPJ
         mdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965908; x=1789570708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qmdf/9peUPSB/yZJlznGcLTDuFu/YJIWa9uggXF29DI=;
        b=fQBj9DDn/amlha+wIFVI+to3pvTsCMWr51cmE97YYcY4856CcPHkXlY9e32Rj/GUq2
         yNT4bKzk8YkfVrLJJ3ukw1v/p7umCcOj6Cj+tVnzWX0CRbyJXxg/OYqBLs27PnTXMKXe
         EebvYeUDVQ3efqIl+pJKa2Ch3pMbojYcdrfsmjZcQ4/pcOn40aqEXo2mwp9KZeAUx0zb
         ztWyoRxjhHebUJyWK6wmk1kxhsMyXeIOoNbeyQjEaIKgL6mzSyVFeLdsEAluDE3gsaEf
         85HMZ5ivgRUPKz9VF1nj186RUzNoyafsaVT6+Y3MkBi/0szzFVYBNmHH/KXY0fa/ezb5
         qPWw==
X-Forwarded-Encrypted: i=1; AKwUvBz5tlVp4F8Se6fRSYJqC66UiByHs3lCFZ6idC4QKpynhLZn928YtcrAlrrUpVSiNMBrMpo/Hw==@lists.linux.dev
X-Gm-Message-State: AFuF++n7hXEvmqOYjwj4cuotflzwppdbMgOat4rvpRiyf3hbGgD4dLTQ
	m6kQL3Q3ZOSvKEUMv0lMIrUZn1nT40jNMBKfg97gpCB9+Vd5QT4fisOsjNCOHr5m6651+gYQEWR
	c3kyx0HwbCrhAYiADb6QHZCKk4ZsGiwvML0oJNtyyEX1jA6whIy3dyAR0eA==
X-Gm-Gg: AYBFou2OvfdrVnUD05uJA0uAYAX86r0y7yzk/B68DfwprJM4lLjFMDzDw3/7xDvgwxU
	w/Hc+udiDo/RYB9PBX2+prmAH9zcNsRYYYARo1B7SP4ioSXStcBr1UKpzjPXux96rsFxA6AoYt/
	OdSbVO47g2qtjipmb6AraO3GUDoeghp2XcUi5PagNcG+xbnXnQsA6wdiPPBl2LD6E4WMqCVeHRX
	gUjzzmpFxfhahBlJojG/VHr5FOSvV+BZceMIMZhCCEQdvOwmq4aDz5lftODIv4oMRJySwMbK/n/
	GSWudVYvCUB+JiHYi59QE0cRiS5FoN8WwGfgoEizy4X6eIuUQtaMAOhNqtft9GgoCgOaEgFfJef
	ne+DyZBokaKOufEUCFS8yC98/ZQRv+a5YXp8=
X-Received: by 2002:a17:903:4685:b0:2ca:660:b1d with SMTP id d9443c01a7336-2db126d8c1bmr522698845ad.11.1788965907652;
        Wed, 09 Sep 2026 07:58:27 -0700 (PDT)
X-Received: by 2002:a17:903:4685:b0:2ca:660:b1d with SMTP id d9443c01a7336-2db126d8c1bmr522697945ad.11.1788965907033;
        Wed, 09 Sep 2026 07:58:27 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51270766eec.21.2026.09.09.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:58:26 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 20:27:14 +0530
Subject: [PATCH v3 07/13] media: iris: Skip DMA mask setup when the core
 device has no IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vpu_iommu_iova_handling-v3-7-2fe43ae45495@oss.qualcomm.com>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
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
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788965841; l=1854;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=P0mNJFeoCU6tU7rrQorPgkeC1RVweTgvH8tb7j9zhEk=;
 b=cKL8bboU/o8pJ7st3/DmPUsCFBQx+gHEH1oyDjmqNJa6iQ4GPaKEavhxB97yy4sf3bpCIJ+O6
 LQ+v/XQqxO7CPJV/MD7p0/6LCHQ6EZ31C1xYHZOnC449F3y8lAkD/0B
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=KP1qylFo c=1 sm=1 tr=0 ts=6aa17414 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=t9ty7G3lAAAA:8 a=EUspDBNiAAAA:8 a=1uU0fEruEEfCXXW2WGwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: stu4zzWehRxeKCRl5kgA2YnSC-I635Nq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX/IIharlJBGJt
 bFGSxeB3jKd0XdItuhp4XPIxUWk158JbLoIyrDV6g7jUTFzrAp5jRDKCfYoZazOV3OkM6lmaRBV
 BxPITnWLnU4NZQrN8lYQz3bHZ5IqFxI=
X-Proofpoint-GUID: stu4zzWehRxeKCRl5kgA2YnSC-I635Nq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfXw4jP/ZDhVZUb
 qAkJdjtPwzB7RnX6QqxhISAfuNQ8OpT/eBE9zm3+z5J722iu7wJVJce/YHUG1Vm4enYzQ+kIp6G
 nplC6/hdqolOOLOPsCxF76NyqTPAP+Q5yMQ+JlwSMxB4cZQdNbuQgmPqehbwSRZxQGPXXf2GLyP
 RNKey+6eMjQ33E+kKhiAe7rebqKihpjO10ncTLUsmGBKG//iDVyFfnXxMtsEmAiJykAJwx9slA3
 CKb7DYOTEsLH555GHlLdyTTCZY6E5OYLg+JtlqneZhT0IYfPVD6yVBv5KwyvsEcahbicv8vXtjA
 k/TAxbyqRHRTxZdliMaYdNff3gHsJRU7+9fqei3y1p9S8z8tKhITmAovBQF98sixUGpWY8WjfJH
 irNsOlGYrn3xWulMS3CwbtWIXGMbAYDmbj50tBkinObyjaOuYWFjkyAX/IFmrm4upWFcJoxiAEm
 8xIIv/V8LMfZV2byeFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090167

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

Tested-by: Daniel J Blueman <daniel@quora.org>
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

