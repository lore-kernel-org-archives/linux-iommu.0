Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED12397AA
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765257816; cv=none; b=l1jUBTghndYiynK09WwG7QitBQO9VMk4p9wK5zxEp25a1ZIyqSE5F/bz72SmHODyrtWrCK8WVRcNupHmeE8lq9ayo/ZZhfl1ntO3Wheb0uTR8lAl46eiCCz75bivgAxbs5f2ask+le6NqrwWpqSX/A+F0FOUQ5eHrs3+Jefvcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765257816; c=relaxed/simple;
	bh=dZS6zhd6+GkbbUazMraqft39XgxKGwbsJuLJFD07Ylc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N5xg65sjHJmRT0NU2/GwIr9Srk0irhyPrtb/U7jSbvJpA0e2jLiN+z8ZN0YeQlR8TOkOfI+Czkoc543mDVvEb30H1+kNIq/cwpBQLxFmF2vNG3tspEwq43bknOSj/5ddOfmw3Pi02p4GaQhn42j7R8D8UyUXM5L3NHtaGVyXXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PBv4z3C9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fv8nd4Na; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PBv4z3C9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fv8nd4Na"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8NXRuP2368086
	for <iommu@lists.linux.dev>; Tue, 9 Dec 2025 05:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uG7XxevFFopqW9UiOO2+6ZHSivqxQgyRx4K
	FhHzzqao=; b=PBv4z3C9yVF8IR3u+hm60r+T8nbVH/cPuOYfacCauoRDefc9Dsr
	p9BgtAxTHMkQqxrPeR4ZgeSUD/QGdXllS+N15dZYV5xBgkwCq4lvNXnqawoqeUAp
	a1/zq8lmha9EfBHxt/0+on446WBB0J9aKPNRYPdlDLTSFjZQbcPhfwW2DLNi/Tnd
	sOEVG2gC/BswLZinYCZyk509DpmHFbgFJmPlu4UCuwZSbl4xclI4qqYK5lKva/b5
	AFu2oWRWNwV5SaDurG4J/9wFpajMGX2o9VsRYcpAHIaRGFMXhLzd31y0sM73uQOa
	/rTSvwe27o9DUzgCJbgcUsOmIHPBw5/IAuQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ax4fqhfbs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 09 Dec 2025 05:23:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34374bfbcccso4449338a91.0
        for <iommu@lists.linux.dev>; Mon, 08 Dec 2025 21:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765257813; x=1765862613; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uG7XxevFFopqW9UiOO2+6ZHSivqxQgyRx4KFhHzzqao=;
        b=Fv8nd4NaLz+fm9Y3OHcFbLxasPIjZLbm4MWFFRcNkBUOfAuBh0bf//Hn5zX2JA5Vts
         8JexYeaDX12pnsiQTBsDN1p/87SdjYC9FkWZzDKrOfS3irdaCoR6K6gTu8d9dUX6W34D
         evATN0+g+pgG4+ylA10gjP19hJn3lRHwOVTzb+eJfmfVu8lqJXAZOBlKnC90fp/+o6lj
         riEYy2WKQRxCmQPcOWA1hUjfIf/4gtdLliRwmP46l8hlmUl9E7TkQgKuWaVF4Hz6xr0s
         L+au73Lgc7pR6DJc+JDSYm+WPlcwq7wq43BVn8i1wjplJl4rkI63YkXzKt9aRmsvMx0w
         gSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765257813; x=1765862613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG7XxevFFopqW9UiOO2+6ZHSivqxQgyRx4KFhHzzqao=;
        b=Oa8Br6cPTq5P1+9SfsY7X8P9O7Sn9YlI7kkeCSuRvpkRRoShn9G9UI8QGI+xGIbQqa
         sDP9b6YgZ0V7RViek/iHTl2Y817OlRgBoUX9op/nv5J0sOtCHtuHazCyq68sj6xK1Ao4
         p3xpqJ2s3LisGqXUmyFIX8g10kJ5ZVE3MIbZzTvRj+3tfKzRZD+PJbWwQVB/3Ws7j8bV
         GCF/t8bR3p+lmaWNL6/za52zFmx4QKAQBvFFNF1FZEXl0pBO8JPf6JIWzB/N+1WLj3Qm
         0kl+/BHIDojRD1dylQBWcBTQcRNi3GrusUVOnfoGmSF4FgINj7ZQttpB9qlGLvkYV8fQ
         Nz8g==
X-Gm-Message-State: AOJu0YwwnMxuWXtcbKdFy+2qlt/YIBB86l39liivn0u13xCQZ1yS1+BP
	vzEUJ77lgja0A3S0PXwnIt6g4JJQFms9Kf427iytwBYwYwB6mZDx/Ej73x+wjcdGtW9YatTvmgn
	PQ2zbtLacGPucBHFVITtaAnqGIIJdIdoJqWJq/BeUa3CHe1Sb+2s67ZRT1A==
X-Gm-Gg: ASbGncttja6XebJEs8rKlM3KODVnOkPtpqz38gULIZ4CbSzADIBi1w6On654RSwq4fE
	xeEt/JA6X3AfifjrDf0Vn8tjaQ7uz5NcVqmDaFUABoL3PHiTLggyemGSx/Z/63CYnI+mIBd/1Gu
	LO88btexqX7k6AcwpJO/VMtvNLYhtqJBxOfkOMEIs74H2E7DtfGBD2EQ9VODBydG4XAREdCVAgL
	wo+zqom52hUJ/L9KQ08Y4mZXN/6Ct+84D4q4GF5bUa/X3qIRce2ztZlt1BdZxuf4+5DIYd4lLjK
	Vxa9HaGDIX+40yUALiuNdigTCbNOYbHqwMrFyqnMTKHSaK0lRaJs2EO3WiQtIiRNPca20zyJ9zU
	NWJNp8V95fBzeuhyvtJwpzrxXhPYrEEwhw8UFZlwU
X-Received: by 2002:a05:6a21:338f:b0:33e:84f7:94f9 with SMTP id adf61e73a8af0-36617e36987mr8467045637.9.1765257812943;
        Mon, 08 Dec 2025 21:23:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG12qBZJHj72pTnfDyARxsCCIVd1WYnNqLKhxyYwxqdUyBBqLzkbHg8OuzNL/sOcMsTqbi/eQ==
X-Received: by 2002:a05:6a21:338f:b0:33e:84f7:94f9 with SMTP id adf61e73a8af0-36617e36987mr8467023637.9.1765257812372;
        Mon, 08 Dec 2025 21:23:32 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf681738a29sm13689924a12.3.2025.12.08.21.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 21:23:32 -0800 (PST)
From: bibek.patro@oss.qualcomm.com
To: konrad.dybcio@oss.qualcomm.com, robin.clark@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: [PATCH v5] iommu/arm-smmu-qcom: add actlr settings for mdss on Qualcomm platforms
Date: Tue,  9 Dec 2025 10:53:23 +0530
Message-Id: <20251209052323.1133495-1-bibek.patro@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDAzOSBTYWx0ZWRfX5CojYrypMbeG
 aXQWJHpkAeIgAEFXJZRqqZ0yPMqaA+n08PUIwObGVq3LPHBqfxtgqLlIBvX31jxiKYye/XVepmP
 U9o/ozTSIkE3FWtAJetDkxhq37skywuuILijmyeHb41/54cjE8MKE1AEmBktMawUqO3zPdUXcxZ
 /SSb4MZg1ZhZIj+2YWFWyIvoRzNyj1XmotCxGKrJTKVaVODfmaFjumPoYZDLMgRWLVYroIFGPkQ
 De+QxW4XJ9NwdvK3ojlnKoeSqZgq3UvzrJaEO4XAl5KC954ONmNrFdW6p2rFjqotpd+n/FvHmiV
 fJQLjiX19kYJeMXuOXpN42dhv+m0lPvYMc6wn/sBuQZNe0CAx4PnRs4+Iu84elHytYIelgzzW3M
 wPXSNPpt+7UAipq06KB11q2MXyShMw==
X-Proofpoint-ORIG-GUID: Aj3GHqz2_oCD0sFtIzs8kX-nq4B4OSIu
X-Authority-Analysis: v=2.4 cv=TPFIilla c=1 sm=1 tr=0 ts=6937b256 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Nhz1Ti08P7End7UVPfYA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Aj3GHqz2_oCD0sFtIzs8kX-nq4B4OSIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-08_07,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090039

From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

Add ACTLR settings for missing MDSS devices on Qualcomm platforms.

These are QoS settings and are specific to per SoC thus different
settings, eg: some have shallow prefetch while others have no
prefetch.

Aswell, this prefetch feature is not implemented for all the
platforms, capturing to those are implemented to the best of my
knowledge.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
Changes from V4:
 1) Change subject prefix to "iommu/arm-smmu-qcom:"
 based on the changes. -- Bjorn
https://lore.kernel.org/all/20251202125447.2102658-1-charan.kalla@oss.qualcomm.com/

Changes from V3:
 1) Add actlr setting for missing sc8180x & sm6115.
 2) Improved commit message.
https://lore.kernel.org/all/20251124171030.323989-1-charan.kalla@oss.qualcomm.com/

Changes from V2:
 1) Add actlr settings for all the mdss devices on Qualcomm platforms.
 2) Improved the commit message that explain why different ACTLR
    settings
https://lore.kernel.org/lkml/20251118171822.3539062-1-charan.kalla@oss.qualcomm.com/#t

Changes from V1:
  1) Added actlr setting only for MDSS and dropped for fastrpc. --
konrad
  2) ACTLR table is updated per alphanumeric order -- konrad 
  https://lore.kernel.org/all/20251105075307.1658329-1-charan.kalla@oss.qualcomm.com/

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 57c097e87613..c6645df97bbc 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -41,12 +41,38 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
 	{ .compatible = "qcom,fastrpc",
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
+	{ .compatible = "qcom,qcm2290-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
 	{ .compatible = "qcom,sc7280-mdss",
 			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
 	{ .compatible = "qcom,sc7280-venus",
 			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sc8180x-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sc8280xp-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sm6115-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sm6125-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sm6350-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sm8150-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sm8250-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sm8350-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sm8450-mdss",
+			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
 	{ .compatible = "qcom,sm8550-mdss",
 			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
+	{ .compatible = "qcom,sm8650-mdss",
+			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
+	{ .compatible = "qcom,sm8750-mdss",
+			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
+	{ .compatible = "qcom,x1e80100-mdss",
+			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
 	{ }
 };
 
-- 
2.34.1

