Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310942D760
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299608; cv=none; b=uW4tZ/wTZcRN3EhBwSPxe53Sr5CtXgF4SDgKeL3X2fYWnUh5nY5vkKfEbaSAiI/0Ls61xNXTrW1OkjBYyaJzPLqde2Tjb4jB3nKBpvGdERD56oN4d0WJ3SpLTNHRaIqwyVZuXEmANc2TAwde/pDRoEH3Ux8k3JCILTxOyOpyMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299608; c=relaxed/simple;
	bh=oxWmsAM+twLfUwPG6xTjeDdTAauKY9ZVnOSmNHJl3x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1Qpv/q8Vk0IILJgH5jSOz6eYCpC50DgZOkXCqjMLx2P86hkdms3mLdklR/YJ1gprqDTNvKArdTPdiBtFMg3z4VFNekSFh/wOdCHznfLdJmFX1IDB3Jv+6y+M1LALYTlXaMokkSD9axAgoIfuWUs/EhrIp73BoAHC4Nh0FgHEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QFmBSEvm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XIw2cK95; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QFmBSEvm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XIw2cK95"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7rHk1973903
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4z0ymWVrqeq
	o9gDHe0QR+vDogR/CFdnt/t7HVorr9fc=; b=QFmBSEvm/dWDDiIafCacepPcjO0
	Dzs5trvnUgoOOYLlOjQ5KmnXdYre9sG7etR3hQoYxjj/FB2zfRkVOj0QTb5kzP/3
	q+b0MqRlnlJiW7yJoC32vUe6nkxaQmAea9WN3ZdhpPyyYCcH9FB5DxQkOuLUdUhu
	vicC7ZfWrUov00yCEEZeJgaQuchyy9Y1pmyv8y+CWUvvFstdrpFRr32jKCuL3EwG
	+7d5wgGh6c/lFUmmhd9GbvMX9vhpC/xWiWoYVEoS6zKe/bQLc/V4EplFu58sZAnc
	D4Tu2pLRh66HzgHJCoy5NbCWWFNXLFahfY2+Rd4iTi1YGXXtLQ4ibwZBUXA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff2f2vq0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a23afcbso60452521cf.3
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299605; x=1784904405; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4z0ymWVrqeqo9gDHe0QR+vDogR/CFdnt/t7HVorr9fc=;
        b=XIw2cK952MQZezykCNY0qHtp59I3tJxp0QZCi1CxAVYw1EBc3Fv6eRIQ0jvdKIfTHZ
         7wBCcWlAguCm7ebUZjXKrvc/AWzNoorj/8Vn18UJsexX3WQ+Nt6QZAfnfypeBe5jC4OL
         Cb5pQAFTG/o3MkyC/ASx1OKevvy5PPK8p3F8gcQRnMTdJqq4rEQGtgOlmvm7Cdlyw68a
         kUXrWF0xuzHstisx7xmfDmWtDKJOdmdcaoq8bw/2MSKk/RkbRYgQ41SStGALmK5a4h3a
         VGOcph45F5X+EakTt6aVLnkMnp/3SK94dkFCu+uxQ7VQXSozsfluEpj94LliavSd36hI
         7mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299605; x=1784904405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4z0ymWVrqeqo9gDHe0QR+vDogR/CFdnt/t7HVorr9fc=;
        b=ahu61l4sFvbtx8Pi1DSwNfnsPO+RSjyw6ZDWWKwgnohs2m3YOYUBdUCEnebiRWNd29
         vnmmdy5Aq1XMHQgqrYv2ZZ/LEWmknO8ccUhrepoE3ZEeo0p7Ch34po+7iSeP7mWvm56b
         Sy+smhJESgddslF7AvXuim7CEWxXPld6mOwYSyTaAboeJWkQGOQN+S2SYT6i2H/o4TJA
         SxvX0xSzs/02l4EPUQeRZORkt2sdMFw9djXixAONLlzrU5wtwym0ANUl4xtEadB1qIq7
         woKIPg1jnLDkb9IDURkzyGfqu0ZiUMyj/j6BaCvGjZ/YPvguYJGFKxZOCzJVxj/kT9PT
         SsTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrscdk5PhPABmEP3vlmgfokbKALTE4laVoyPqXLUNRyZ8evlnPd23wzQydeBfSUu/t26Eio6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YytxHI+X1PfhcNrA3Iw4YFGfVW+B3TufZ0PAfJdSdvFPMvpat6K
	53SMmuZ9LaLZCPdhK4kFqNmqHESilo/VFmpTosLet44P95o9nYjKIclsC1vOQtTpVdOAMZV+LMB
	ZUru+t5awE8qzmxtf5ubvQMQM+tkNihPGOUsDpmrQEGaoXFhSOntgDGeAQg==
X-Gm-Gg: AfdE7cneCdsSRpmFjeCBVpljMpX9mclgkW6djak30uZTYuxbGrLqtoTGByt9a0g4tzk
	YY1FoFxCpVpjSkyZtc3lNF4ye3XaMyfJ2Tfy/kXHTGNL864ZH+v3EmZHxZUkWEcZUp5T7E/6Yh2
	UafoQjucNRitWK99BC/XVcKr7iYVaQb4+swSFOtJF9sRkNhoB7QgjBON4ArbKAt6uzJBJzDOB+S
	KQcT00WpDcjIZqsRDcffu3ClQ5X3QyI/a4w6s3bj0hdLzWq9jUjNMnMnuMqSk5eRMsJZHPT1PCY
	dSeKMeWDyTQ+T/f7yEB7jmcnMel5JSCA93xkzaAvAX5Kclq3N1bxoMTHBt34qOfcedfRcIolDWD
	vxUU4h5KZVOmV18Xto1zvDnVHous=
X-Received: by 2002:a05:622a:2b0f:b0:51c:19a3:4ec with SMTP id d75a77b69052e-5213eb7f5e1mr27613761cf.69.1784299605005;
        Fri, 17 Jul 2026 07:46:45 -0700 (PDT)
X-Received: by 2002:a05:622a:2b0f:b0:51c:19a3:4ec with SMTP id d75a77b69052e-5213eb7f5e1mr27613171cf.69.1784299604436;
        Fri, 17 Jul 2026 07:46:44 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52149a3ce4fsm13414801cf.0.2026.07.17.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:46:44 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Alex Williamson <alex@shazbot.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2 6/6] iommu/qcom: Enable clocks before hardware access in qcom_iommu_ctx_probe()
Date: Fri, 17 Jul 2026 20:16:08 +0530
Message-ID: <20260717144608.3216274-7-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
References: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GOWXOe77HsKGUI3HwYh6mG7vfRh9Pgol
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX0YxlL8mB1zWn
 g+R3MbVLy7qssfF3/IttMVCxvSDtmFGnO2L/BHIYDfje9uPV3MU0f7nhHeiElAjx6hf1J6Ufc7q
 Sj3od2HBF3KGzALpskWttkO4YhPYR1A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfXwX1e46fZsCrl
 9nb1zK+Spx4PP+YU7CCynCRdFaZfVpcmnKZd/8uNsgrH0EjMbDKzZFjJhA2kCWJ9XgtKo+a2Tkk
 25SJu0WKvG+rx8fjLt6KU77FK0cNXxE+DgRiNJCKSpuXQ6ZpoB5MNjIua6e7DsOIPGewTUftYCR
 SyfAEfQEa2QYS37xHUxPhsOBZpHpT2rFRQjW8NsagbAcGD5cEIRD+dI5BMWMbV0fW0fVd3IkBY1
 NvxohT3fwwuPe3fQoLpxCmA1MFH4C4Wb0ynZqgayI73E208B3EvcKYMdRCod4bZ8hRL9XN6+DXS
 ioKzk98bQLgibxAD5Ts4IvHt6BMLqaKHGZSwcSoS5WZMtEV5+FO8RywnxjFuG/kVh1cf2g8LMqg
 pS76G6aXtwLZTyF0dh+cdKW6OdNbtGucTaqyo5/ThAfyKgbDRgMcS06oimN6jOl9Wt4Rjc5kIVA
 0UFCa6ZNmKw0SabyYgQ==
X-Authority-Analysis: v=2.4 cv=NcTWEWD4 c=1 sm=1 tr=0 ts=6a5a4055 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=8cASqgOsboiLGU4YZykA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: GOWXOe77HsKGUI3HwYh6mG7vfRh9Pgol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170150

qcom_iommu_ctx_probe() reads and writes the CB_FSR register to clear any
stale IRQ left by the bootloader. This happens during
devm_of_platform_populate() which is called from the parent device's
probe before any pm_runtime_get(). The parent's clocks (iface, bus, tbu)
are therefore not guaranteed to be on, making the register access
unreliable on rebind or after a suspend cycle.

Use pm_runtime_resume_and_get() on the parent device to ensure clocks
are enabled before the register access, and release the reference
immediately after.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index ecde5ca2d476..5a9f8b39a99c 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -704,8 +704,13 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 	/* clear IRQs before registering fault handler, just in case the
 	 * boot-loader left us a surprise:
 	 */
-	if (!ctx->secured_ctx)
+	if (!ctx->secured_ctx) {
+		ret = pm_runtime_resume_and_get(dev->parent);
+		if (ret)
+			return ret;
 		iommu_writel(ctx, ARM_SMMU_CB_FSR, iommu_readl(ctx, ARM_SMMU_CB_FSR));
+		pm_runtime_put_sync(dev->parent);
+	}
 
 	ret = devm_request_irq(dev, irq,
 			       qcom_iommu_fault,
-- 
2.53.0

