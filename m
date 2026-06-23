Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8B3D566E
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217273; cv=none; b=dSgT5KdcCbLdLok1XmEB5nJM3NnzYMM022WGJQYcQ8s8YgIuKn8R4oOp+ccncgLZMb5MTUqsN9+a8Q1BEJwzPISQZuqU592k3yUwDXNYNlCDe47O8pdtcOhVTc0LctkZZW4B0M8/s4Cqtn89t73UHlHEk17vi3Wuy+FQP+St6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217273; c=relaxed/simple;
	bh=Uisy2K09oTgbBqztVQlxgX7d4yg7HllsKs/lCKvqdFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5t0X7DoyPoc3oyocLBlH1EcJD3x+FCS7VrLSOz2zHlsTdEQM6F1EeMPiFSENVDCknqgDXE2lU9/NeNEkSkI39TaQveqDvTXcLiatCnNGcUAh8GWYsYpsQ5PMs0Vi165XgS/il/XIyHjlJCf17M0dtvQ3wCl9EIOo8AceRWOCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h6Dplp4l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ob2abMf1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h6Dplp4l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ob2abMf1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBY2kC3669396
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0RnWoMIES/C
	zkhCcSsrHFJ9LX/JyT5AxMedV2CmbIQA=; b=h6Dplp4ljdptQgfUK5V2C5mLp4x
	af2n8dcAiyqdVAfwqqGG3GuI6/2JL1DygKH0XWGHK5khXCzA+EyhUV0g8GNKdz9O
	FBCfxiKNc9l/wubjXek2MK6sUq2P/H93HITVkwqAn3H9mPMAbxBWH4tUSpuFWfPV
	7R9K2ijtYtqgBuLURQdWyOaLEZpAs82NRZaiqP8LXdLhOPDB9BP75tR/aVJ3IlW5
	xr4eMMPBzxOcrrL4UouSQ6KCVHvCnt1pL4G71F0hm/HzYOK85o6W0T2KmZ3o7/2y
	ICYCviZ94Vk5vX92F1SV0UKY8dsJMTutI+r0NF4pjDB138rlixUMfZbMQrw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppygwww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8453e61d6f0so4482506b3a.0
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782217270; x=1782822070; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RnWoMIES/CzkhCcSsrHFJ9LX/JyT5AxMedV2CmbIQA=;
        b=Ob2abMf1zPGlmGjnEgk0kDnHcsDPHa+jF3RbOLxz/0FOnlvPkmglH7Q3k40g7tz5KK
         ie9RXHZLMkjlmOdUXLIWdvrVuaIdr8vBY/4lwccdEdK99+om/+14TL3VPiwwlPx2pkg6
         2Lv5r+Q86I7Ano3L+G/Q9zsotABI7zICf4sSeZOwSwx4UuNsQTUu9K83ywPGd5GJwHTY
         aExloPD5QdSRrO/r07X6uVTRlAr7osVoaGBjwn8qIDI/YGruCGmmPdvqJV+SHqr1OAef
         iaC3R4MYsVHEMp2JiEA0SpO5aljX3AM/2lJefl8AIgJgGNeKyzZgcsn0Trdu9YW41V0K
         RyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217270; x=1782822070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0RnWoMIES/CzkhCcSsrHFJ9LX/JyT5AxMedV2CmbIQA=;
        b=Bev12GP04b+rKFM53zkHfqX/mYZYpvQ1xUrk7ooifWmbGDYGfmbOveE4n5xsrGpSk1
         gwGxvLZ+JBy1L4dskb+uHlEI0Pap5oG4fcFlbv7Ft9uJOZOt8iXEPSBJb+N6/RdXj6cZ
         NnI2tk/stfDIr30dl9FJ/abWn8UEIPYNsAudbnLEomHbvZd7DD++HX1i7DKgcagwuvo6
         vSVUoTg2cjQTo5XDFCImfdjsqPtEPekOm5pgi6LTKc3Ejr21mMqYxRtujO+Y8n0sN1Nj
         Yjto/9/BhVAk7MKfdALjFa3PTX5fYo6Jvydcmgrw7ifTUSOww14esxXz0TI0dgKiNFpz
         0R0A==
X-Forwarded-Encrypted: i=1; AFNElJ8rfD09UumygQ9pUF3JBbB9Xz/qfbbKWrqjTjjqCTFVAMovnalTK9UuTF9TccznSVJqhB1EKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqV7CkFw2S14HmV+i5aRtOC4J1oO7iubWndw5CAXSFnZFLiZhH
	6BA3w9Lor/cHFZEilgq2+5hGcKOD7ucGXtpqB74rl0JV+T8d7E6h3NMNA/fJsypqNP6nfgOzNpL
	J5IB6ppexD0/qg26lCF8HX1POPmyjsCSR7MF1HFiYk2qsZxtgdxLRx1yKZg==
X-Gm-Gg: AfdE7ckI0JLkULHeaDA4WAwYk+MIeQeIonAX+9sqSgvUkrV6hwRxIrJV4r1VQ6tH4FP
	s45/YT7S5LQbPKLJ+1IuXOq45CLTv9CF0vHh4c5hnqGX/vJ6ED78mWB1vbQSF6JF37zjbk6J5Tr
	OKwt/AW7HKPbvpMPeHdRngjMCiTZJuU6p0U3ii6A5DN9MZr8+N+N+Pq2Gdy9hhq7zZVdsFUPxYP
	Nd2u+4oyTLkgby94ZEeMkMAC7QpnGytYAXaLAfUKVUfHRVekRqoqnJvvTMc9xREr+8x7qXXGiZU
	p6gU1KI7WJigpuIGr1eBMihVJfWnREsTMEk914GFL+PX+UQopkE4bspiLhl9fj1uJjQgPe4R0K+
	ETT6XTdDcAJDlGIHtIO1Hw3SOKKIlvoe2ctQ5QA==
X-Received: by 2002:a05:6a00:1408:b0:842:5b1e:5908 with SMTP id d2e1a72fcca58-84562535544mr19225472b3a.25.1782217270028;
        Tue, 23 Jun 2026 05:21:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:1408:b0:842:5b1e:5908 with SMTP id d2e1a72fcca58-84562535544mr19225423b3a.25.1782217269487;
        Tue, 23 Jun 2026 05:21:09 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74646sm10171856b3a.29.2026.06.23.05.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:21:09 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 3/8] iommu/qcom: Check pm_runtime_resume_and_get() return in probe
Date: Tue, 23 Jun 2026 17:50:29 +0530
Message-ID: <20260623122034.1166295-4-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfXyySJdn2w5pew
 DY2ICpnAPYISyu/IkLQHCj9qHKEAFPlQwjo9pk6Em0tVdYLTJCVpF6aaIQp33XvJCMVKWdVFp6a
 Khi7PNowEC3KVMDTOuwkhmzTJYGQ7x9TbI/29ctesBI57MF2gIZnXJQhAQVVQQGAetE8EPqKnwI
 qvJSrrq1xgz6+bsKe6oqG89ohuESq80XvUicF2ASvs7EsPwoqmsQhjcmk3R+QDIjS5nFG7PHOWS
 U85TMEAsLySchnHxxs3c7nP8WNv6XpNG0v73E8Hn8RoO2GloSzVJmUZhtzL4wcZEw1mXeRWguWa
 RtxdkkMPyMGYpUMRBEZO3q4PaSgXNpYIMRvSNeaxetycawAQsZERa54mBArhExT49gWLaqmqad2
 VsK1CDLMA/tCwMq5rhJgS7uxdv1hx9OyBSH1hThUjo5k75pMWGUXt11ZF5sG1uz51olB0HmEHFW
 WovBcf7RElGk5DaCRsQ==
X-Proofpoint-GUID: cg5tXciYwZkfLBtaac42EunGLmTxIhwH
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3a7a38 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=uh9JkKNIBQsmCcNjqRkA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX2KEpgpo9X0XX
 V4B8oSA14jFKkLzCUo4vpDqTOI07g2iakLIH4SPwbZKG/CUeyfFvU2zOhL9hSclOdyEiXUG1sWa
 A6PeOViBDfIU8eIZ7j2/ZQ/lks8Vpt4=
X-Proofpoint-ORIG-GUID: cg5tXciYwZkfLBtaac42EunGLmTxIhwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101

The SMMU_INTR_SEL_NS register write in qcom_iommu_device_probe() uses
pm_runtime_get_sync() without checking the return value. If runtime
resume fails the subsequent writel_relaxed() would access hardware with
clocks potentially disabled.

Switch to pm_runtime_resume_and_get() which handles the usage-count
cleanup on failure, check the return value, and unwind the already
registered iommu device on error.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index cb43276f4a39..4e714a8e1fac 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -859,13 +859,17 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	}
 
 	if (qcom_iommu->local_base) {
-		pm_runtime_get_sync(dev);
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			goto err_iommu_unregister;
 		writel_relaxed(0xffffffff, qcom_iommu->local_base + SMMU_INTR_SEL_NS);
 		pm_runtime_put_sync(dev);
 	}
 
 	return 0;
 
+err_iommu_unregister:
+	iommu_device_unregister(&qcom_iommu->iommu);
 err_sysfs_remove:
 	iommu_device_sysfs_remove(&qcom_iommu->iommu);
 err_pm_disable:
-- 
2.53.0

