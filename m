Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C81EBFFF
	for <iommu@lists.linux.dev>; Sat,  5 Jul 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751731722; cv=none; b=MAkRw3ly3KRievSYBBWneNnGB2fZkxeL3Ebfan/twlGJpMm0h2LFkBUaDJ7yA7vBS2cb1MtDupL1HXS+JHbWOkDSM32J7myJqdEbnlPAwr/CDWOHz5oSeMen2n4tysBxI1TIEtMIefGdzhSfJChDjyhq8pwW5FYxIb40EeTtVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751731722; c=relaxed/simple;
	bh=1nHVCwgtw92YQiqaocxAdN057/gIPobtpT6EJm/ltEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e9Y9S+3IZF8cwVbdkIhitm/LVvP5r0LgB/Mk+QH93qWjt0+9IsZnqMdO51nXbsVxO4lJj514uoJUUESTNZJcfX/wiTSDxVvmGk06A/TlgM4OIs2EZavQ6FcJIYj5kJWNEXLuDHKri3ybNOHxtTSM8b4QuHBIQdTwUudH1jC6XFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qti5XGev; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qti5XGev"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 565AFhtD029880
	for <iommu@lists.linux.dev>; Sat, 5 Jul 2025 16:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VQQYkVndGStCPetb0u9KBp
	kX6kw9yPI24YEYcxWZEdI=; b=Qti5XGev3wB1tQ9SAzU+dV5xT98VKholViCmqq
	yIB2Tu+/ihCmC9cabslWbqFrQPI6J9bR28P4m9n0nrfvBkbkuVEt0CpHrK3ouUgV
	dBIz1M22Y3DrsA3m7fTCd+jkHxlrbjgzswnb7kCu9rraGE+1xUW+g7LfffMTeQAZ
	bjl5N2zlYCQ6GL4NTtf4cjjOWtSSrfUaS7PmVZDBTkdrUIXNLFDPwwP2N7juCpxz
	ctDHXqIHXJsgQz1D80O7js6ddYQ6j0GMwhmGcbAUD9FcGYfqQnnP0qHx5WFa1BuB
	DLKYJ4HhKebjwPjnK/Ab9Vw2SpPHk1n38t6Jnq5TZb5De2Yw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvtk1akf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 05 Jul 2025 16:08:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d44d773e23so461713685a.3
        for <iommu@lists.linux.dev>; Sat, 05 Jul 2025 09:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751731718; x=1752336518;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQQYkVndGStCPetb0u9KBpkX6kw9yPI24YEYcxWZEdI=;
        b=LOs2eX1i/PE8pBufMoWdYPJnKgQOSEc0pitjT+7Ya5Uj039WaVGTVTOE4h0kocHTep
         4lVk2+0vvyoAT5APEQlqoorAH9BTGK1G5BLzSSWJK11Qs44hHFUkGOTgjSngQD5wWW2S
         C49YivoDis0Rue4nOcAzYfPCh3rXoQtz+HLZE/90zh0yWPV06HiI8B7ilhPuxUD7Zcp6
         btcUQqyfwRi3ZDLjtTWkt0nLI1i56e4rKs806WKrhJdyo7nM3VwtLzWlf3Kc2P81Lzms
         b0wq7Qh0xljm7gsIA9JQ+dRxmyHjdYPNL3VxNxL6x32jw2E7Gi6M/5wyjRZtZj3yZqo0
         FW1A==
X-Gm-Message-State: AOJu0Yy05t/40Cuhtk/wpgdwlmsjvvBOeBUuAgYOtot2fWKy7krm0U68
	/43Ra/+kPHYtpElIXIHg6cj4Pr/8JMDB+aHKJLjNgJwsKGPPDstS8AUv5j5z9ZfMVosuX9Ht2KJ
	BVxDsCPRm6bth5yUZXKE/PGgY4CxlUnr5feEFofIkZXJKe/ze0hWio6P6cg==
X-Gm-Gg: ASbGncvltO5ShCLujzs99J94/XT5trvqVeWWrldhGvLFJtoFWlTfs3BWbck9mDavCOl
	H2pY9hYwfMa3tIiPOYV19SCNxZA/Tnhkd9MLlEJWawOdo7kZg7BgSbPBWf3sMptgOaBJeMa55Z/
	urn1dFqdtYqpFSpLPR74mv8JsO3BUP+5zmIjR1u5itysuWLgVmlubOuv72H6tUrJei/fC1mV6bp
	cUyCQzwRQvOl0YaRuWTbw4P77nNAuKzb6/9LRNbDkG10r+YFnCFVqRIJh7NKS7ksZDn9eK4F3Ov
	7VKovF0o7ZIA0ZrMvzbzjdOp8X0gA/PZr1EIfpCQXFn6CSd2cJpemKqMwoH5VhapMRa4uBNJmW4
	cwQS2DE23urYXlb4Bu0AItn2Ie9FV2XZf1sw=
X-Received: by 2002:a05:620a:2b89:b0:7d4:4b92:85e4 with SMTP id af79cd13be357-7d5dcc5e457mr896829785a.14.1751731718469;
        Sat, 05 Jul 2025 09:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4B2sgfTjCGK/I65unoqaLkmK0M7K7ayKlHuPECNRLfJUUTIjG5F1QyzFuSBOHTi3v6JDljA==
X-Received: by 2002:a05:620a:2b89:b0:7d4:4b92:85e4 with SMTP id af79cd13be357-7d5dcc5e457mr896825685a.14.1751731717791;
        Sat, 05 Jul 2025 09:08:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55638494f6dsm622779e87.123.2025.07.05.09.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 09:08:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 05 Jul 2025 19:08:33 +0300
Subject: [PATCH v2] iommu/arm-smmu: disable PRR on SM8250
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250705-iommu-fix-prr-v2-1-406fecc37cf8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAABOaWgC/3WMyw6CQAxFf4V0bck8GEhc+R+GBQ6DNBEGO0I0Z
 P7dyt5Nk9N779khBaaQ4FzswGGjRHEWMKcC/NjN94DUC4NRxqlGOaQ4TSsO9MaFGWulKqdvure
 qAtksHCQ6fNdWeKT0ivw59Jv+ff+ZNo0aw9BIaG3ttL/ElMrn2j289Eo50OacvyaKeWCxAAAA
X-Change-ID: 20250705-iommu-fix-prr-600451b1d304
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1nHVCwgtw92YQiqaocxAdN057/gIPobtpT6EJm/ltEE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaU4EPzKa9ZLkC7fTqOEgSArVBZofNCTdp/Sb5
 6FwPKWtOt+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGlOBAAKCRCLPIo+Aiko
 1V4XB/9PrB6vncaBwBi4dhAA54NytUNQgDHc1uBL88Sca8J1uPGNjP3dU83pKyS3dPTzWNbWHJi
 P3qCHpO7IpOhZcTOxn6JKQbKHGPbS72HwPfbRcvMyQxau8bTHH56A7zy4XMfbStA460Rv9yXwa3
 q2xwWoZmQwz2UDBAa5VcAHulN4szj+eIHAgAqZRxiD5E9qc519YrQ2WtRGuDtv0Kq9mmVL6Q5wg
 I0OpVpxZsTTEsN6KLKTdEwYISyDMKfyrp0WZrSNmBGxmabvnTGaal/jJ4wZlWFDvxJC4LHBmhn+
 XUC1KVZ6mIhKg1QxzophRU7GtdVBmUqpFs3d9UZlhP9w97dj
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA1MDEwNiBTYWx0ZWRfX4cS7/Ps9WFpN
 ZvyuJEopEZEyZuUJ2ja1gOoqy33fhrYbLNAvXAKTLe08UrXrd3DGzlm0OEcF3BxQMXOPip0U05E
 rEfRT8Jpi5n4VT88el2j5tCViQCYsQngdFW4S/zyupfgG2OOcL9ZPv4vQRobaBnxDnCM6NPdK/I
 dbXO3hvrhoUiX1yHiJgxyYt+KGeV2uR6idHR8SMAc+AMT4fHTQY11jF0wM2TXqQcdCK2N2QD3hG
 CmRlGZPD4uygZENl86VlPPge6lZSjGlbKmJ/dZqZK58IPrnEEP27vEEcIXegoFM047PWsaEAll3
 MxDrb1PeNTMc8uxEps9wBB0JBdpNkmucaByyjICtlkrTvhD7+grD8/OKAaLN31bE2zGWgi2xQFl
 7c+OMqTtKUMVNeb03YE0v+JhhRJ4Tbc8en8lQgFdnxwqgY1pmDJLw17RaSnAOiHMEm2LkKJy
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=68694e07 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RJW-fAkOStluX_mlE74A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: p2Ng5vZB9HVmRAJk2cXq2yxBnN0nyjRb
X-Proofpoint-GUID: p2Ng5vZB9HVmRAJk2cXq2yxBnN0nyjRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507050106

On SM8250 / QRB5165-RB5 using PRR bits resets the device, most likely
because of the hyp limitations. Disable PRR support on that platform.

Fixes: 7f2ef1bfc758 ("iommu/arm-smmu: Add support for PRR bit setup")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
I currently don't have access to other devices from these generations.
It might be necessary to apply the same workaround to other platforms.
---
Changes in v2:
- Simplify the workaround as the issue seems to be limited to SM8250
  only (Rob)
- Link to v1: https://lore.kernel.org/r/20250705-iommu-fix-prr-v1-1-ef725033651c@oss.qualcomm.com
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 62874b18f6459ad9a8b0542ab81c24e3e745c53d..53d88646476e9f193a6275d9c3ee3d084c215362 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -355,7 +355,8 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->set_prr_addr = NULL;
 
 	if (of_device_is_compatible(np, "qcom,smmu-500") &&
-			of_device_is_compatible(np, "qcom,adreno-smmu")) {
+	    !of_device_is_compatible(np, "qcom,sm8250-smmu-500") &&
+	    of_device_is_compatible(np, "qcom,adreno-smmu")) {
 		priv->set_prr_bit = qcom_adreno_smmu_set_prr_bit;
 		priv->set_prr_addr = qcom_adreno_smmu_set_prr_addr;
 	}

---
base-commit: 7244e36657076b597ac21d118be9c0b0f15fc622
change-id: 20250705-iommu-fix-prr-600451b1d304

Best regards,
-- 
With best wishes
Dmitry

