Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C89292B2E
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142870; cv=none; b=bHoMBCLkEZ7pOSNpWHZcgtEoSNvYw/BC2U8TcbNQZGLA0LOLfCRBFUqSUqj49y5igASZZTxY0n8BTBHtt1bzuFF0TewLHljlG5287z4KnMvUmsHORWs2R0heOWPvZPl8P+6JjvTHTGeC50ABULyqs5HuHrjuZnvP5yXigu7rWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142870; c=relaxed/simple;
	bh=k/iLL6i9cSC1voO1ylu5486m6OrCS5p/BDSfTTakIQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbgjYyTpJrnUFFasZ1SvX9Pwz2w+Bbp16d2EbQpHISpcayeqiMc7Ow0wFVHxlR14vjI6QwJ+hjx0A+niMJUhJRw67MU9yGaHUvawne0VH7RjO5q5No6S6o6Wgu5J1/3OBi4nL+golY3nTAsDH8Xp9rFtqSs/MvVpOtdcBcdrnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DycRsYL0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=drW+aQou; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DycRsYL0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="drW+aQou"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLBDDP3157450
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D6HQxjbDqFuXOrhbP1pIiGDugFED9NzDju7QMGKMoO8=; b=DycRsYL0sKiuQLhu
	tExU6NTVmWTFp2rblL0HvuAkuRhN7bxsYbVNWev+xqHIm/u0ubNkW4AL8ZTaxAbp
	61Xuft3Bmlpy3VbWXnG/J4qjA3CuAGqYUo1+5JPtuuIPEIVNW0/W2LpzFDyD1ezc
	wk6LhneHicE4nRwjcmBU0WmwAuJx2mI5MVkBbeHCPlOp9ot7DYCTzRxNMxYPafd2
	GyKrffOpG93XHzA7qBrCR9eVMm9chpzcfltOFvBpTpTT+7No98dh5nSpEs88r1Re
	MKFof1RkX97UUHQ9XSoEkRQc/2WUIKJM3IfC1kgjsNhi9BRPtqnxmrjXWNWeTqZT
	U0fomw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86b920h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2e06219cbso30931625ad.3
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776142866; x=1776747666; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6HQxjbDqFuXOrhbP1pIiGDugFED9NzDju7QMGKMoO8=;
        b=drW+aQouxL1FU7XM68paIwtAM5pqeZqcNkcNA0QdeDxVRgtrP2biyuGzKBEyqzRqo5
         7YxBJO1SHiJbAtW3O7bOwElqZf+B2jdrqKEGqizaX7bPoKORpW61Q695pRTixSayMEk7
         oWsKHezm+W0DQLNjsl1vYZIkEXa6tcB8DQ+gEd16Wkq4TlKSkmAUnrbsFVRYxoS1PXvX
         j7oVvO7/d87JyAV57+AjonxffGt6XVS84jBlvAZ51z7r9mSZVduBYnr3z0pAMQYxtNKz
         QIFVr5gqWKYkFG2if76y0UB4+5Dt61lSH+SItTS9QFqqF2iNauosoa+wK0vGCS6HSvil
         Ysvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142866; x=1776747666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6HQxjbDqFuXOrhbP1pIiGDugFED9NzDju7QMGKMoO8=;
        b=bIdTR7oUTyq0hxha+7H36k9omOsGI2h8RwPFZB5hhoVWOS2xAECyzCJ8NikPQxCUdT
         nCAXtNxw9V+mucckAnVasN/6CK0NwJx8hNmZ0svI1FGFVJ6ZFvE+A1k4+towAAW8q6N/
         uzbHTAGVyXWSTVgMM50CMYTSzff7x112FZ5V/JhSH3nU5MfAvAtAldBijkYpd0XzitZf
         oL8udh/azI5/sDbAT/Mks6QHRYrhFOh00//kw5qxMNv4NikPWwSbU/NnNcAdxGEYAmXn
         IEvBX7JZKX48sIldypXJ1pt2GV/6rGLFk84frLY/RKgVIdvQU1Y9i9jBF6TN4IeP5M6B
         UDsg==
X-Forwarded-Encrypted: i=1; AFNElJ/cewy8NELO+N9xIy1ppPyiNOjhwtL2MzTE8VCA6HXLluKobx0gg0h1LProGGNcFUzXWMUCGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw72QPnCjMHBfdA2ALKPVc1AB8wG8w45xqnbmgaZDE7qdHZhm0v
	6+MX9TCJWMcpffvgFSw/uJIcJPpdeDYShfx5N7dTytXgXh2wnas51u8faIffpYfhyvVfH6iQsMF
	KB4KiFt96BbC6ficQTFn/QGVtiAyds0+lOcUQCvvBqrutukDu04yIMdEm8Q==
X-Gm-Gg: AeBDietjkARtH9gYMrjf82YPKlvB6Rc9/WALlVVFe8euuyDHRjkTA3u8Dd2oDC6gO29
	nrnOYTNjcuYi8BzwuKdy/f8OTx6Wv/C37CnZXEOzl5Om5nQGGtw1ZMZ3Xk1LLThB5HPArtL9agF
	hh85kBhC1Gq2BqA2/MiyB6pBxl6zd81oi/4MzpoVfF5Vt/9TqTgdg2lCjlv54jJtXIMnMeBZysN
	57IVstyH5/w8EL6PpZctxRkAIIxfZS7WGFV+w66vmqL5l94oI6nVu9b6xIy1+buMm2+KjRs85il
	JOIy4LQhNVGbNjdsJ35mHnTxvbsmp8g6ASn+olPdVIJrw//MJgO3q5BTAO/7IzNgSxALoAAHJYi
	+ry8rCXl0IO0xK8aTOJjEJGsLa0CiuUV6lszz6sz4SqC/+ZeYYjA2EMk=
X-Received: by 2002:a17:903:acb:b0:2b2:4eec:980b with SMTP id d9443c01a7336-2b2d5940ec9mr167893355ad.7.1776142866325;
        Mon, 13 Apr 2026 22:01:06 -0700 (PDT)
X-Received: by 2002:a17:903:acb:b0:2b2:4eec:980b with SMTP id d9443c01a7336-2b2d5940ec9mr167892785ad.7.1776142865748;
        Mon, 13 Apr 2026 22:01:05 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm134678425ad.3.2026.04.13.22.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:01:05 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 10:30:02 +0530
Subject: [PATCH 06/11] media: iris: Fix VM count passed to firmware
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776142821; l=1298;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=k/iLL6i9cSC1voO1ylu5486m6OrCS5p/BDSfTTakIQI=;
 b=IDdYjVDuPd+/LIcDpu0hs7fw68aCaSf03QnL4XqN5BY6zxcLwqtD/gxA7DiQ6KxUkJXTgnuW0
 jr1xLST8M7hCVpscA3WPXDA5mCtM9B4AJB0TyCukzzaeACVFzkD3gOX
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA0NSBTYWx0ZWRfX0qDcHNDmNDvS
 Po39babqViQil4OHMZdtdcKBRCxo05jU8oRgsR/3Hnp3+r63aa26JtQ94WJS7yckecu/KK8lkgA
 g38OCjQcd5VvvM2/CoA8vKIxVdgRH3wAWDY8yeS3EoQDmWEEr2amM1ePjmQyUokKekST4cL/Gh0
 SvaYs2YJJzruhQEO2liT9N+0mIlGS+On1q8aRTc6+St/RsCsfm2yhDp39t+2M6GmjkGcGMIhGY3
 OAEffxgP/dTe4bOB74grswOaSEEdiFFQUKeK1ySBN1Ky9Nd8oICPx3O06o0tsQh4OSlScmUPmmP
 LqLEIX63VDcOGCk7vaypIDjsZUyHCw454tXkRQWCAVCckwyzmcNzficfsru1Tcn+q+2H353rUXl
 JxwpKCQIl54rBUkYNRNgay21SceKivrAFD+Y6k+ABP8ojQ2bkIj2/DGl3YR1AW2L8pabcbCkQpm
 vfLK25ohQZTywxyeG+Q==
X-Authority-Analysis: v=2.4 cv=MahcfZ/f c=1 sm=1 tr=0 ts=69ddca13 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrYi3PkkErC94SPB-twA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: rz6RiuGHqfu0ivpzmoqSczyxRpKO-u2L
X-Proofpoint-GUID: rz6RiuGHqfu0ivpzmoqSczyxRpKO-u2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140045

On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
the number of virtual machines (VMs) and internally adds 1 to it. Writing
1 causes firmware to treat it as 2 VMs. Since only one VM is required,
remove this write to leave the register at its reset value of 0. This does
not affect other platforms as only Glymur firmware uses this register,
earlier platform firmwares ignore it.

Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 548e5f1727fd..bfd1e762c38e 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
 	iris_vpu_setup_ucregion_memory_map(core);
 
 	writel(ctrl_init, core->reg_base + CTRL_INIT);
-	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
 
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(core->reg_base + CTRL_STATUS);

-- 
2.34.1

