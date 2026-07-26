Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213451E4BE
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045070; cv=none; b=QQRHXOLEpWkau+ghqModks0kIa4LgAgn+1oeAbYumoRfb01JrRuQecWrzBAmqupI3CyCJ1PdLDc72t3Cl8E8XeBsRQ2FiJ4OOjlxHxv7a+lxUH/JCimZpUy3g7z0AWEKLBM5pMS2s00hKNfH+PulHW8KWlplEDUVwV0XLBVviq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045070; c=relaxed/simple;
	bh=xDKjG51jBAk9EXSAgV+S8o6yhO9zrtRBIJx3AXPH7vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkcAPcvxZnMyxzJ7NIFrMOS2G5HtbrLchVTEsFVRxWkDgI7ezC1260K1bfi11rBCj1orxdXD2R/FKO/OLfRh4CGNGNPun+sbOPpgYXksYtf/Q7bUQA2bOxEUhA+79o4Q3lLNpMyb/hGFaaeARhmMydhZwzEaLuSeRWa5iJZ3N3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KwGTeHUW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eRVRQnDI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KwGTeHUW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eRVRQnDI"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5Ro0N3723132
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jQ1czwxEPod8YlqEh+zmO/6OKv3iOp22VfF1LBuIlCI=; b=KwGTeHUW6FX7mFlK
	GU+AWAHgeY7SH9E2NjijxyawjAIoSyqw2XXqZSW58ACr5lQ6oYbtAPmbQ1Zf2f2z
	Q0UuN1yn24nZ9JahVMy08dHfN1CLIAoe+5eg37CZkldTetU1g3AwKsburbwzOs6Z
	+8zobuvYGOTjOmSRMWZACGFZh0nLjmST8Wjt3BGiZkpKu7UCbqv7df5UlBufSkZH
	to8SLm01PU/LORBn4XNNQgzsHHXmWryDtxCIcayJ1w6Ihs56GyZ930GnMwNMD5T2
	iZYxrl+L0WiLJjVz3fNBJ5OCCSbxE1ADdnLUjvsvJvWOgmYT6jkwWxQX1nT+nnYT
	ThoIeA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpeea5sb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38827cee19eso1869948a91.3
        for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 22:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785045068; x=1785649868; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQ1czwxEPod8YlqEh+zmO/6OKv3iOp22VfF1LBuIlCI=;
        b=eRVRQnDIYgRxu4BOwX+OFXtjmocXLum1csRk/R6QCqyDeRW991nTtWW3RbH90ZPXoX
         aNLHP1a2m9glxAs3jigJEogurnceRF1d0xQjMLgUdbYuCWR8GAjds7UHpcYcK0ZMdC5D
         E4ad0SPiQMISAwjzP6KyABYFflWuvYWkoLiWffSuHQhlzHOJ5/aDGsskuOnOAe3z//Eg
         LMdX89Q4vxxHJc5sP/maoRZA0bGaWZjkxnR4tkdl1q2KUHCagdMeNlmIxGieWe7IQHA2
         1JtuGFvpkbAvzhu6Mxl5NC7Wj9J1IyxVGvwoRMnkedNGQlCeRGZeP1hD7VbDuGBkCKGu
         jWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045068; x=1785649868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQ1czwxEPod8YlqEh+zmO/6OKv3iOp22VfF1LBuIlCI=;
        b=R1NCpipvN3wAQKScdJCjan8tnEryC1W0mVC4OHYR0nll74gdpN9Y62CZpF+3pmwQrp
         rNUOGJUtwx6v7Hu7LwVNUOWBWLCSxjIPfXRfYHg3McPkROZearutWDiT0DllbfFGw9TC
         6QKaLr8V8NV9O5o/sD178vpsqtYsWJOAeja+CL4ZX5EE/dsIVYTSIoRgGe3PdwIRJUEh
         hvuovzieqEBgRgskMbNk6nQBa408+vvApmx9gtuCtMVO27/0EHvhVwPVHz3NhBkzPvJW
         T/GXVozz7XV4PsP0NZQie8cj8CZJ+gH6dSkxxYy40i664SbuqlHtKLC73SmFbIYgDePM
         BGSg==
X-Forwarded-Encrypted: i=1; AHgh+RoaKBTnH08964aFhU4JRLoV8KB3fqjOHAXZS2ku8an0Vdqj6JLGaS1wGvDOoQ2f3Y+fSwWU1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDGiCHNUBHWpG/hzyAz5B0hOEixc2JtX1uh0mrUaJ4DvkfrafO
	qpSzaVQ1hK6nyRuVrqBhF3cCKFbFJd0AB5Pu5At1i6BhwC1sFcbSDfngAvoO2jA87++uVJ7UsDS
	nO65RGAKbPfrF0IFrIJjOzsQSKqcuZ4s9YTUWQtgmUICQ60+BUZm4fozHeg==
X-Gm-Gg: AR+sD12eeS0V1N66Lfwftw0Q3X2l+pKYDu1TOSZ84u5k3q5C4nQ3h0/xVFH+bz0WHQx
	JnrVSog8gDCwd+48zpT9ylTpY6Ea4b5G8Fr3y6S1E3PAi3CJJZVd5A7XPNSQLITGsgFRIHcmYVv
	HFYk2MSJxnv6qqsp7Kpk2TAzsxuogzq0jm7rBsreR5WoHS73R/IU8tkJ8nRy8Xf6o761ClT5sFZ
	BHzRibE9SYbemhB5hNQMqpFLTHC2wkdVyUhBm14ZV4LgrkSVy6GQ9NcKt2Mm3PN0wYdz5q6+VXp
	30abKa24znImn4zUxXZJXAQFhPtVRLF6e4A1PYb2oqUfvbRX1zu8mXerbuipPZaQqLpMNfgvzim
	8eL1KE3ogfE/n8JEjBGiaHxvMAKyjYhIErg==
X-Received: by 2002:a17:90b:5826:b0:38e:5717:9cc8 with SMTP id 98e67ed59e1d1-38f29641b0cmr3946336a91.31.1785045067926;
        Sat, 25 Jul 2026 22:51:07 -0700 (PDT)
X-Received: by 2002:a17:90b:5826:b0:38e:5717:9cc8 with SMTP id 98e67ed59e1d1-38f29641b0cmr3946316a91.31.1785045067506;
        Sat, 25 Jul 2026 22:51:07 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm67106334c88.15.2026.07.25.22.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:51:07 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 11:19:35 +0530
Subject: [PATCH v10 05/14] media: iris: Skip DMA mask setting to core
 device when IOMMU is not mapped
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-glymur-v10-5-de451559e88b@oss.qualcomm.com>
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
In-Reply-To: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045024; l=1589;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=sjEt7zVED5HiiTDKACtd2anjSuOH/+nGuerIdCCDwyY=;
 b=TXxBZ2BqMAGG7mX1CbjEnNvxqlAPSN0TiUg1f9lAQu0t3F7vfKudeZS+AxNfuS6qb6gqBDoH4
 lQBGTFPNT9BDHhP4A23MEhPt6BoAPfTtzMFhc1SaHmivbzMpYkNxxAN
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=Jr3Bas4C c=1 sm=1 tr=0 ts=6a65a04c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=2w7d1ukKp82XeiQ8bL8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1NSBTYWx0ZWRfX3tobJaVgCN5Z
 wdMY8mZ4viwcylQKAh2NtsOH6Yzn+XZ+2V4GjmRcYI3CS/5OkTOhcAH85h8zaLcO5JGBAbAG2G7
 lOTVlPKVWCyn+OGmZbABIn3e1gE7ro0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1NSBTYWx0ZWRfXwGawgDSNhkWe
 qFZF6zAXevWh2LJiBYSR1K+crTRl34M1Uz/DMeBosmS7pWZWrOW8xFKRZjL3kinl8hHAnQ9zFDI
 ceZU7OS037vSCzAATQwmOhgvKRsi7TjhgMcjD2t35ATR8D+TOtiDvKKjeL+LCEw6Q4UIlc696Vb
 R81Xkhuts5cTbpVWVAfdOvDPsfLezJWL68Uj2J0+vFhADyiZC9rD5JUlmxcSen7oarIpP5i89rj
 SyVDilYSLiuxKnkvfW/P/jhLdpBBI/QSCCrSPm8LFzKkqiWway/30p3v4TWbOZUrBUk0z7PD4S2
 9zhYGmhcwusaj3za3SHSd12wi4y9exPcI54KwXMKeOB13rzwbL5V9dUW5yibXx6r+Hzokd1TSkR
 mRXMATdoN6O1kzGtGBs+0aIBb6iZTgKrxmxd3I3dhouC9aawpbBAyT3DYu6MtdbGMvmaFGNAfFO
 1Sd8pT5qivDpwkeaAhw==
X-Proofpoint-ORIG-GUID: py_s4LJPrl7bU8B7zQCQc-x1uMK1XyjU
X-Proofpoint-GUID: py_s4LJPrl7bU8B7zQCQc-x1uMK1XyjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260055

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

