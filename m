Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCED212FB3
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991564; cv=none; b=himWR9QoFmpF6IkJ1CZMhcpnXtqpLQhh6qNYiTjDsCt/uLpOOwzjT2L4YV8WyoqRHVYw223aegGSNf72ARGSScBSJcbHva5L9hVlIgu3YXaa9Y1N7SE2/6Fno1+To0y7vps3nnlGh30sebEI0MAR9Kv/msCFufwNDh+wwip4MP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991564; c=relaxed/simple;
	bh=mJMBo+OyY3l+Gom2loMeyZ4DUTc1rvxg1Ev64Cw9OyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c73orjdFkEboSjfPFIBaamToKMEb1C7FCJ0sipppZhqTAvYRqTgROt4pmGGynrmOMdQjmKmbfGMS7M79g6gWrS5ae88MOT95ZIvzV3fjkkkW7e7hjCzZyYMWapntgUNO4haiX3+51olooQs9x9QgovPTcMK5U77nsGwAjXvGPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gO+Zu767; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WzLZSrPK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gO+Zu767";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WzLZSrPK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609CnJJl3542153
	for <iommu@lists.linux.dev>; Fri, 9 Jan 2026 20:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=e648/KtOd0+
	RWrEfcZlx4oczML3wOVmr8Cexl05A+BQ=; b=gO+Zu767jwDZ3VsfCcLLL2d50tU
	hQM/uMVpQYH9iqo+ymM6vtQvfBkwMU1flEUBgA1+GgwnWFA7c4DW1AGPShZmuEcL
	aAkLHgFmGJFudwCRJDXvf2Un3FNugrgNBFQQIIBzWIeEbkZDvmPB6VC2mwjY7nUr
	d6l8wdsrQ+4gp7E3Lve30fs5DN1Gi1Wje/gmDyntyTs32OqYrMnTNBj3hInmdno7
	T+e4wq0oUPLmvBcaLwQ74jZqxYmCmi5CyueU+pgqSD/UsQAQxrzM31BCYWhrATDw
	C1UC8xUj9iyJr3TgGhtSw6RJnIULwYahG0xY3c4sUzelTBoP+o9odBBTkZA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bju6b2mg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 20:46:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b89c1ce9cfso4309927b3a.2
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 12:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767991561; x=1768596361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e648/KtOd0+RWrEfcZlx4oczML3wOVmr8Cexl05A+BQ=;
        b=WzLZSrPKnUuziSE7CrTO+NQy8xnNSR8CxVdxiHSj5PSCxNwNBhQMNxJEv+ed2FqGQc
         nXdZIovFlfnZxfu4dYq7liOU9drwvNVqq6I1yLyIr1KGK9mqNYuuhXFOZtt4d0q2zaYf
         wAG0TXoBs4N66UbMQiI6lBgngJPPjUmdTPF1BNPCeKC7o3VtZoXWTEdBJCNBYhg8Q+FO
         jh7TUKVQ26847kqcwgSZ6nLynrr59HGpC0PE1i9Ct9gFi0YNVv5q4lfJlu05TZTAFsl2
         reJ8uVejG/06j0/5DzwyJNLBGyLg5i3QJDhKGk3XDfJ+BkfqbNc1JXh3B49na1Gr4vn4
         Q3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767991561; x=1768596361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e648/KtOd0+RWrEfcZlx4oczML3wOVmr8Cexl05A+BQ=;
        b=mM5iGpvFGZlBRdcenXC3dCZIjAvuUwAdiqojEnYulfU3GLcmUkiWYFIX7jK+YxiWmx
         1EGV8WB/OJCAjsQqViciAbrJKHwLzb3ewgzOpl5W71CAMuYLJbjGWanPLFHQTJeodCSd
         cFDLM0ksKPO79XGlWwRBD3lffGotFd8G+5Bw5p5mpDBWWhfydsvkL5bpeo/6KwovHS9T
         PveEYRVxqqnpeIiXL1eQqFFdzD98gnmVFLSyzCRiUDkfbI2Gi8pl78L8zaQUsjf0obuo
         kgvgUu+1pgXEkAdPecyAoRWMdeDoXGnKz0Vnry71MvrBHtgiqifCLyYQbcORVrj4dum6
         G3TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT3tFPCKkhWN0O3/vbClRxQV7l/k7U4k/YiFVl6E/dnU5AIYOyf6bfSktu5u/b1mYRnUCUWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOLuJUW9BscTqktBWrVI/IxwasjGihezDU3ryQ+VNpayQIdOxP
	NRI3YZI0lsNFR43AT07B6nQoo2EKiEzHUdTYg/3gNsWpyctaJ4n/4aFHZTgd5DytlMZHVvRX3DC
	J3hogrpJ6A3hE1Q5pv4KQJga9CB9go+p6/CSner4qDDGgwV/oaJf9ZbhNzw==
X-Gm-Gg: AY/fxX6nGKMPydV8JNaXVcK9eAek57uiR0ZHFxeGGMRxb8Nrin5PZVJUGpJyQ8KGywy
	28Z18xg4GHRaSdKs5+Ou2GC50tOJowJ27U7UBoOOdA0nIk8xVCZ6ATuIbwSvBR9Kf1fHl/q+9EL
	EwIglC2meH8V9rQ+pJWftacOTS9uq/9LK712WG4b3Q+AKBux7p5qjtiho7Z80IhO/8wQNIlCOfj
	Ua/4pn51FoSXJs96499nVXf3hxEeGTVbQIkkg1VnIJg0nOqPu/C0k3aesFwlm/Y5h14/RepKGty
	juLZHZJmJAHH1vhVH0nZlVp+ytF0Inaxj68bD5dal8EI9nsrydYMLOZnxek8mZrxYpR+sAis06o
	zp2bNUgYsyJ3UZJrewpwhu8lfskKOBXaddf/oddh1
X-Received: by 2002:a05:6a00:3003:b0:7b9:4e34:621b with SMTP id d2e1a72fcca58-81b7eb27c78mr10510819b3a.12.1767991561287;
        Fri, 09 Jan 2026 12:46:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqjv0b7lCDCbINP4r0dTLyev/FwhW0Ax5Z9VTaH/LlqyuxmnOU3MdXKx8Xj1jiP03kXOMtcA==
X-Received: by 2002:a05:6a00:3003:b0:7b9:4e34:621b with SMTP id d2e1a72fcca58-81b7eb27c78mr10510795b3a.12.1767991560769;
        Fri, 09 Jan 2026 12:46:00 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e6772688asm2485752b3a.45.2026.01.09.12.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:46:00 -0800 (PST)
From: bibek.patro@oss.qualcomm.com
To: will@kernel.org
Cc: bibek.patro@oss.qualcomm.com, catalin.marinas@arm.com,
        charan.kalla@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        iommu@lists.linux.dev, joro@8bytes.org, kernel-team@android.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robin.clark@oss.qualcomm.com, robin.murphy@arm.com
Subject: [PATCH] iommu/arm-smmu-qcom: Restore ACTLR settings for MDSS on sa8775p
Date: Sat, 10 Jan 2026 02:15:51 +0530
Message-Id: <20260109204551.845959-1-bibek.patro@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aWDsFoEe7PHQaL9F@willie-the-truck>
References: <aWDsFoEe7PHQaL9F@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE2MiBTYWx0ZWRfX85EceXguCkV8
 3zq2pRxvs0wVhATTd9FLm7wiD0L/Y5TSodxFq1xjygcht4aLTpwwMF0EN58blNoL5vI0oHDd9k0
 zOLtjvJJsFDTN9dIn8IT3CpvutKHLutGY3xnz5Gq5ymdLezOhhoth2mijGKfsQEfBavP3Fjp1wa
 FRt+D407MHrdO2TKn18s09RTCzcTxVv/b1xC84FKHS45C0NpRNS1wnbvKh3YFt57OmGRA1a+5RI
 q/RD/UIJi6b1kKs/m2LtJpaSrfzSBcPDLxYlVjFbSzEV5eZ6FeU4Ymyu/k8O0pUvzYRqpyaw20u
 Fi0vxvywuh1rQdaONBTNHpDKXkmzu23vUcbnErUpWKMZBvLQF9S9yoBNt+VCsxHwi5t5C0XsBSA
 NExii2X8wUl7VeZ2HDtoc/9g6nBFakb5veFjZYfJVa4+F8+y/dGuoIJ89Hj3MSv1p1zWGQbm2dg
 vbE93ogyQufB4tLL1xQ==
X-Proofpoint-ORIG-GUID: GRS98XDlMjFpJR4jrlm1aOxwDjV60fOk
X-Authority-Analysis: v=2.4 cv=V+5wEOni c=1 sm=1 tr=0 ts=6961690a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=X4sqO_BnIXgP0qhT90oA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: GRS98XDlMjFpJR4jrlm1aOxwDjV60fOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090162

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

The ACTLR configuration for the sa8775p MDSS client was inadvertently
dropped while reworking the commit f91879fdf70b ("iommu/arm-smmu-qcom:
Add actlr settings for mdss on Qualcomm platforms"). Without this
entry, the sa8775p MDSS block does not receive the intended default
ACTLR configuration.

Restore the missing compatible entry so that the platform receives the
expected behavior.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 456d5146831e..718d102356d9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -43,6 +43,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
 	{ .compatible = "qcom,qcm2290-mdss",
 			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sa8775p-mdss",
+			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
 	{ .compatible = "qcom,sc7280-mdss",
 			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
 	{ .compatible = "qcom,sc7280-venus",
--
2.34.1

