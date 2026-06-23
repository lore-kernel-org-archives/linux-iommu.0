Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF33D6480
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217286; cv=none; b=ex3SWvbmYPFOwwpaozE8ZKRWTYKpvO7livIXOmhbj7ACxgzNAgpqsdDWWhmwPz/C6jQPtbUPKOWYsuyV65XFFFr2TH7dqGp1cyYJQvGU5pCL1nMLO8PvFymkKvjx4cRc+Z/KAFjkt7FBqRu3bUN3NkGNhjk2FJpFGZo880+4leE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217286; c=relaxed/simple;
	bh=1btS+uahA/dpI1zSLWZlGibsdw6yI9eSlm1CTAaRCUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGEQ/ZWD8fVW8a1T0BCuPdyyID9ZQbQlLhMBpIvfgukcqtQCLv9BfIv0SKkQuNkPm+ruQ0VRnkK1+H/i0O9d9P/C5lpkRtuU9SpRzadPicPaIfcMXbHhZ6dtffMDB0E+8EOU8hNVfh5Y/GUqQ/6MLOf/jmY6NC1dY/U8jukcG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IzVVX+bl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a6IV9NvH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IzVVX+bl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a6IV9NvH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NC6feE3744630
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PSlGePwHyRY
	cFLv8EJamVpEvdvRpZ3GdhYpvSgrdXIA=; b=IzVVX+blTX52AsCG1uVLGDaDf9Q
	T/Josst+RPqMNJBDKYZZn5siB7ZIH08gOPHHVPWVkpns1uSvYpOMJhaL8XQdj6ZK
	oNHNTkMBTqBbnaLTFYzEmmZjP6sZ7QTgexX3xzsXXTV5WIvgog2F9hQEUJBmLZXG
	NS4XwHvCXN3r8Ahjk0Nccj2m7lONUEbBNmrDD42hrFS5XNccFP5eixjqcfpo0iJ+
	gA2doEIfp/V582jq0LkSb2tELSjlskyLLJavLdyJOGSfAOlAmUoYd3wpxvg7EqNC
	XK795HEdYWH6bCrEwGJs9AK2Cjrwc2TK84zxAAbkTgPa4CMZ6DcKu/CrpPQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eysv3g1hb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8453031c57cso7839629b3a.0
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782217283; x=1782822083; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSlGePwHyRYcFLv8EJamVpEvdvRpZ3GdhYpvSgrdXIA=;
        b=a6IV9NvHCYZHzvHPXCYOFCskaMDCeYlYZa8O5EEwkoj8JEwXTgeHmqf+Qw3yeNqqtt
         3xjtGXw5hSziz3iOPlH6Sl4c+yTw1r9whx6RbvBpZJMkSNtmfn4YCmEVEeSPuJjNC3jQ
         EsB9uwk1oGHIlodQ1QYYrjXNJDXlmOmahKjDuZvkDXA1oFauWZgtdJ0zq7OvBbUxLFoG
         GvZ8mgt4KtBkLpQoFjvm2bHmSXn3WEXF1BBWtyY0km/mTvjxlE6GXZV6PJzXtnAF723k
         am/U6J+0D70jov/WtZpesIDLj4FBu5K1Py6ZVRJrSiprF+oZZzhBrdYa/Tjx4MSg6ihX
         kpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217283; x=1782822083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PSlGePwHyRYcFLv8EJamVpEvdvRpZ3GdhYpvSgrdXIA=;
        b=rYx3fH8sFi96PqNuhr8tWbnk7VeMGunaeGNs4WNAJxjIajXW2YdwV/ewAzsVZpEYv+
         4ge61cCNmet+jH3H13atLOmTSSmGbu1vj5wGDu2Y40HbbUG/6Bukq8zIr+GANFFft4RA
         J7uzpNlH8Ytf5XsTUoS1xv/NrLRgt5nLk/pOzMZUf3g/bUYrrUiDaep+aH85hWZjX84h
         rhpe3/8lYBKsfz9y0/FTIzYHXG36tJeXIX2HGpNmjpAVT6092vbOGV9ZUTDSIxI+njVk
         RhPytSf6cZF4ezJIaCb92nsueLQPgE+tckFLoESbCdhKxZQVUVCfGKsdHXhTX0pNIrc+
         j/wA==
X-Forwarded-Encrypted: i=1; AFNElJ+YETJxRQIv4zENN+MFnEhIOINLiHQfoyhkvclb/BiMt+JKBRCUJMHtruUEN/PPEKuraH8eOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdT3mzxp/QRyHuJ4z1Fj6IVN1vO0+iODa9sk0diDNnzJTgf1zL
	aT0E7CAfzoHXQsKkvOLJWDsHe443M3V3dK+WqLDqeNTqcFFg9qkU57w5LGgzNgaqJOG5GZYNGF5
	Bcp8XE1TC6KzZxsxTro24ChHM9gKQXpwg/dAkdh8x57DRorv2TDCt83Wgiw==
X-Gm-Gg: AfdE7cndwz5OQskL6IyoDwjbrxHpvoFlVYp7MK4LOYNiiWCjrt9Vo8ElEQjsrNqL1TB
	IkAgjNtUVCiHbGssReBY/+T5i9op+NELCIS8eTUXEpD2OLX5fovXZlsOCRVB+KS/1Fkno92P7U5
	Ypiu+54tqhDQ5sRiKzFr1mqBbUnBohRGohR50Uz8Th/667zMOBOG6S9DgUxnRCT4wF9zt1XceGF
	J0oBQoGE+aLClTFSgk1kJ5NsAbgSGD7IrqnXC9rkPUpjgaEQvs8vmTqB24icnaz/pZyvJ6rj6O9
	4UbRG9o4b4TuAk45kp/EYvmxoc8w6t6rK1CEsA82FS+oj7zpTRngNAdxcC2aTcQUwRn0wQsUv7j
	YFS4//rAcDmh5OlyPdnjsKgQ1CccVwT3OXb1gxQ==
X-Received: by 2002:a05:6a00:951c:b0:827:2a07:231d with SMTP id d2e1a72fcca58-845970338ccmr2760028b3a.17.1782217283409;
        Tue, 23 Jun 2026 05:21:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:951c:b0:827:2a07:231d with SMTP id d2e1a72fcca58-845970338ccmr2759991b3a.17.1782217282893;
        Tue, 23 Jun 2026 05:21:22 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74646sm10171856b3a.29.2026.06.23.05.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:21:22 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 7/8] iommu/qcom: Enable clocks before hardware access in qcom_iommu_ctx_probe()
Date: Tue, 23 Jun 2026 17:50:33 +0530
Message-ID: <20260623122034.1166295-8-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfXw0F2nDOjS+fG
 LAnzEPpSHRBLxUxQQkLJmfdbivaEbPJP/GWrgfTEMOyBSBPIHtF0fqUGD79ZVhBJasrAVVNI6Ev
 2ZnPQ8hBoA+Aclfj+W3XTSUeeotCMsY=
X-Authority-Analysis: v=2.4 cv=WtAb99fv c=1 sm=1 tr=0 ts=6a3a7a44 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=8cASqgOsboiLGU4YZykA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 1mRN89n4KBmN0BE2oX6PPqVoZqfAGVnm
X-Proofpoint-GUID: 1mRN89n4KBmN0BE2oX6PPqVoZqfAGVnm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX/hxCk/7P3AGB
 OFDmRaonABIwDK0K9ZFvr25+1Ch8tRD4okVJFNhHClJkSw0L+OBFMEQK0uRV+E6saZgad/gMKW9
 EyVPt3k0OH8vN0bawuj6YiV2TGaXY9Wt3BubZlpzd593ObRIKCjyjSaf1sy+ggL0ih4AE4kFXs7
 743Is07UxR4lPpkNOZ4Zy/XFv+Gzo+hrJHI2PI3tFFpNT8d8MCekSXnRtbwdEuygMMCiqaczsJv
 6XwRdxn/YP8TVI21aqKHhE7fZgjhMCv2lBC7Lwg8FEuGoAVX6LbzRZcSjqGOaL1bHQVbfcp0ZW6
 KHkJR1RUhRfliwZb9gp6FHGQzeLGxDRScb+v8xSITagg6ecPh9hKSBNBhpgBrVkIreY9ls7jkKv
 kDMeAgkmnWjDJGvksK7GT32ImKZL8zXLZRbxq3XdB625wlVqzD9HCgnKjW+jhYYoGE9ksfgu0Ch
 Mvsqso0JJ3hbj9tnbZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101

qcom_iommu_ctx_probe() reads and writes the CB_FSR register to clear any
stale IRQ left by the bootloader. This happens during
devm_of_platform_populate() which is called from the parent device's
probe before any pm_runtime_get(). The parent's clocks (iface, bus, tbu)
are therefore not guaranteed to be on, making the register access
unreliable on rebind or after a suspend cycle.

Use pm_runtime_resume_and_get() on the parent device to ensure clocks
are enabled before the register access, and release the reference
immediately after.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 51b60b296bb8..0df8c2af8eed 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -714,8 +714,13 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
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

