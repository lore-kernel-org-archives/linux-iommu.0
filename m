Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12156377ED7
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266871; cv=none; b=PgFoVgFe7PjPKn5qAr2b1nFDyIIRQlBv5YM8wm3okzxl6x/QjFrJgwIQ5qPItG0MxsL3rs6NQOkmJk3PggpMQfTtFJS9IrZQLsGNBWDn1ja5ExsoeqV9lmpkA2+/Kkhm8afJitLN/W5mPHOcKuwu6ILVqtgbvW60DihpiY3Nsbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266871; c=relaxed/simple;
	bh=ECsH5Gs45CqpRqX5C/jNn1QZ5iDd0NScn6UK3/KsjCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0OAxqadXfe2tMLPxFhlePpSGLXI93dOGSE5Mg8YHMa3L+SrPz7GtvfIeWWXPZjF+cBtf7kYfUQ9SDzaz9FcydI7bXIoenirhMaIlQ9taqJGS4oGfpmWxjiOv96vrlqVXFCXm10IiS6a16UptmGJwpCB7LOl4zRwyPhiFOTKobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iel1ax2r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HEFxFZzK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iel1ax2r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HEFxFZzK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648DGFCo317527
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fVj1LCoNAbiYzDIsSvQ2jgFnqlAo1QVaSmbijliR4Pw=; b=iel1ax2rWwLeO8uZ
	D6yJn+0z+XjVZA72k9D5bRPJhMSmXyjx8TszMpMcdCpmpefZ0FzZeaA6yZULSurC
	o1J0PfV1r7xBL5qNUabH7LmldPwb4rGDwOBOIFZ7mbYrE80r+OR8f4OioX2NyPnD
	eJ6dRM5lLpW9U8HeNOOe4UTKye7tcOoeqA4STQAtNluiEXMwnaE9Ja7VykIQlR/R
	j7qX5dpXrAZHdRYH82Js+uYqks4Us7YJasAvcZsNvkCkaC3YxdYSDQRIv5r8BKml
	UR5akM1jgReQtOFpbJD8vdr/jbKuIzpnpU9Ltmbgw40UngID18yUIBEbnpoArlBi
	iO4yog==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1bc02tan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:01:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8271fb4407so56927a12.2
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778266869; x=1778871669; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVj1LCoNAbiYzDIsSvQ2jgFnqlAo1QVaSmbijliR4Pw=;
        b=HEFxFZzKWhath3XO0QGg6LGQwITcSrVWE34SkT173ugqnz+wUgdH9LN3ASasGIb5hX
         pMh1gB1dY05bYy+nCyZ68uoyPxjbookhlxYFZHq0qDPlMX3Q2WyxGLasyI9g46KGsPCU
         HrlMpdeUT2+83w/SZuZVUbWqlbic1ssumSCuIHTi7vfIi6KzHXWZEAaGV9dxoo/mc3e+
         fV0FdihobXWFBE+ZjqsAyE/mID90QuNq8NXjKIQ/qqCzjJASlNyYZShkiV0mlGlkZE+H
         gGhfZzd7XJzON/DV2++CqlccMcXpaItuvhPBp9OtSobYAvR2qSNPELSsvCFRtQyHZzXF
         zrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266869; x=1778871669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fVj1LCoNAbiYzDIsSvQ2jgFnqlAo1QVaSmbijliR4Pw=;
        b=L+4x9vTP5D9YSaL/2Dwfrwi6crMnRTamwRalgF/eyB8qwlgKl2Vib1uSRCoMyFzZyI
         CAmOlR2THeWlcEI7WtlmxFXj8F76MC5g9srbTj/ajnIe0Jubc45JWOh7+GsgTbyY0yZh
         WRzbUtEfaHcCeslWzLSMvekB7aqHSKk4FgRM1ms6B82GlnDiHu5LVs+b1Q8IqicvZhvi
         R/lLIn5KxOo7K+4kzZK15qXKPOQRj4hgwokZfQ6VKnFlw6d1bFEiprbQD7RInqvDT5GT
         CpYt50LnxJL7f4MkCTeho8Y7sOUz2ZHriUSfuETKoVXO2qVvppguy5ajvtOLeNjSZyjI
         udMg==
X-Forwarded-Encrypted: i=1; AFNElJ+vGTuKeo8bTuIESTTD/5OUyRzEcxlVr3MkU6B0Uw6c/6oasEGd+b7dELPT5pdQA39D9lWHwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxszSYTa0CI/4HGF6+Mf4FiaWO14QZ9L0V6r9/HN7itf7W+Q2tK
	qn1jw46/BT2NgB7fKLjMieaj3C/7DcDI6C4tMfPC2Ox91TUaMTu/t2u0ECYkUiZe93nlw+FO8FR
	XuMOgWjpqYHQd5MuljPOMvl9i0l9735/SzuLjEkvjH6UcIivKtMwdnihk3w==
X-Gm-Gg: Acq92OHd5Hae43cDm677qcAcTuwqOQRexzzTZKmS2zr43URwmT6NgAkGP1KmLttMc1B
	SM3kdVA6YHmNfVwsm3bkSL5hI9RoToQOLhQ0wDv+6UL9eN9zRRgrOpBOIkPHnGxEgiFbT4xZ05Y
	9E33P+jiQCtWJn1TC+cK2Xg6IHEXivEbcE5QYhC4FSSOhAYo1FMHkMMrgEDUWqmTEFxfw80m/YE
	8TCtYwZSMSM0+9tj0Yi7q5hHeCZKfzW9wFKfINQVcGpKrr+8Z5prKyvLZobsfdxQSrs3pf9rD11
	wBLtWnAIglPIxJW5stKoW5AUp/L9q7U81lBEOalIvPfhnIbpIcYyJqMTy0EGZd6XNnJyIqXxCxH
	Bd5N5OMK06d8Y84O/N0la9ai0x5L8p87FvYM74hmobCAECjZnd477Kwc=
X-Received: by 2002:a05:6a00:2386:b0:82f:390a:69c7 with SMTP id d2e1a72fcca58-83a5e347c04mr14043022b3a.33.1778266868598;
        Fri, 08 May 2026 12:01:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:2386:b0:82f:390a:69c7 with SMTP id d2e1a72fcca58-83a5e347c04mr14042970b3a.33.1778266868032;
        Fri, 08 May 2026 12:01:08 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm13395550b3a.19.2026.05.08.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:01:07 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 09 May 2026 00:29:51 +0530
Subject: [PATCH v5 02/14] iommu: Add iris-vpu-bus to iommu_buses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-glymur-v5-2-7fbb340c5dbd@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778266845; l=1118;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=WbVuGY0YNDSgJ/NUQMQmGYDqgQRedyuwh2xVr1Rt3qk=;
 b=g4ip/Dem418f0yjnajSGGs74S3S3o+EBtTgU2gWCC0Y8pQtMZowyDugB0vnAvvkDMUhHColtn
 EHdVoMJlf9gBkirrywja/++JGIhsXzm42t+xad8qNcttOjkBs2PFyVN
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfX1dRBsfiGtPIq
 1PEybQXUtKyEct9Me5loqb9CVOtG7v7vwbtyiV9eMeyGfhD0z0Yp/fmWKCImFf/K/CvgOJ2V9DX
 rwGGVblVf7XyeaGmdOcDvwtEt+mAW2G9voo5Tog+r7pbH94Tj0GVoPuTcR0+Qm9occ6azGii346
 wS0L8ttDJ1ebJb1Mp08nIUb9lHxOFzwAZEqmMRT5Gh6GXt94Tlnt692uyevNbrBuA9W/VMN4TBG
 EJAgw5Z7nkXr/glcm2sLa0Z+GT79ILDzL/BXKIZWimsjDZGiAmX7rzWZAdw1TjOtJIxq3kv4oJL
 RjdRpFIUzA1xiPETMNNoc809fkbzJERnUJAAk8Pdl2nYj1aja8yS26nwNH6YIs9+1o6YUh+hVOq
 STaJcPGjBMPIfo3PrbbRALVw3q5kO6McZADFszUR33tGOuvubmHun4rS/EV2/OY4d/F3cNJMwgM
 0D3hAkLa9FdazGkz9Og==
X-Proofpoint-GUID: kiaWVkC6XlNFSRBU1xh6hWtNOaPBnfsZ
X-Authority-Analysis: v=2.4 cv=JJQLdcKb c=1 sm=1 tr=0 ts=69fe32f5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ZGoT60Gb6PEvP4nDRaMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: kiaWVkC6XlNFSRBU1xh6hWtNOaPBnfsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Add iris-vpu-bus to iommu_buses[] to register the bus notifier callbacks
for device add and removal events. This ensures that when a device is
registered on iris-vpu-bus, the notifier triggers dma_configure(),
which sets up the IOMMU context for that device.

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fccdbaf6dbd5..903a8bd118be 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/iris_vpu_bus.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -179,6 +180,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
 #endif
+#ifdef CONFIG_QCOM_IRIS_VPU_BUS
+	&iris_vpu_bus_type,
+#endif
 };
 
 /*

-- 
2.34.1

