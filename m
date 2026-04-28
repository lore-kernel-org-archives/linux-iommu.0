Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DE333ADBF
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348588; cv=none; b=XrFUrvlxTU3MjItz9fQYxwcNc4qb0mIl2nUbpAF2HyUOzX2CxUITtXGwhuvNmiN74pYcjE5W6oKTVtvl96/akWKkJ6WYWEPDAn6FJ77Fw9iOBO2l0LWyDWoO2vaHhFxpvwJXKy1kbdg6b5x9r1X+bWZ8/kgV+55NLIRRwC4pHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348588; c=relaxed/simple;
	bh=B3HL64Au0aEXfS2Kn2bLGfzZAIxzxv1nhUwhmU2OkmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGIxLZlATbu7n1HGVlDezfWoqkInhvaIxVbfLifNx2tOXLoqTPUKKhe+H/TVkqq2e4utUgPF9xkrcKzBgtLYIws0NTrZiJMKl3Qq++ac4T89NhX3H4IwXWoUUKenfI7yT3PUvdW4IGquJwAPK/iUQIUvxVk+AJ6BMRJI35zF99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bfBqo+VN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UV73xO2b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bfBqo+VN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UV73xO2b"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S0TQuc440351
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dRQKBOvpIQQtqM4o6WXiH6tq8ETJefi9sBfIx2EGNi4=; b=bfBqo+VN3FtzyMS8
	CbXsV1xSN8HzlZLfin41kpB8HSiV6JXvskknW6u6+LOO0C8hqseecqQ7tFeVAp+K
	JL+K1rLKVVn13NfqAG9wc/wWb0HtL6kzxfIQX7+7g3fv3f3J/r7HAAGJoO9dZ3bH
	k1x23WyXop7exHkTgz6BNfe2Jz520uDvlS/Oeg5kxt7ImyzYbKs/zqXAM8gPgip8
	G9AZ7tdGQMSloh2HJobcq5BLMZ1RiDeQawAdyY8fAu+9c35Y/1aRn1WGmjS61MBu
	dejT0rZtKDG/h+QfRsLe0KYip8EYn2KrO4CP3I1O+PYjhsA7sB5pg63NCoECM3x7
	BGFmvw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac42g6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da1c703d1so12863723a91.1
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777348586; x=1777953386; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRQKBOvpIQQtqM4o6WXiH6tq8ETJefi9sBfIx2EGNi4=;
        b=UV73xO2b6DFxRlxP5Eb+MP2fPZItu3PLfYlelBqpr+fZc+XMNbX8dxZWVZ+zh8vViD
         HCNvl4upoNP4g0zZFkTuKC8Wnf7C+SVrfMF8xfXqWSRBAUtJ2+rXcN1nDzgqhTqJSdA/
         84iSvkuA2MxCUBmPBmXa+69souz69eJmWn1GP6t7/ZI4c8MSZCumoMKG67Yip7RqlMg+
         T9AC+p/xXdrSZU7o35hCH9aamnMWOp7iRr4g+R4qvWN8E5LLu94IfJYh9K3zSL5JlFVA
         Lqu7k1+4oxPA9S9k8U8VuV+qER4JPdRzloxQK4XVP5dih8RunnqJwk4wNK/GzUvPJ/PN
         6vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777348586; x=1777953386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dRQKBOvpIQQtqM4o6WXiH6tq8ETJefi9sBfIx2EGNi4=;
        b=maAgAUcONfTi9HisKVkXD2xzDoTyYVOynW3w3JJallGoW1YSnIfbASwW9dZb6wXivc
         gzDTsHhArJH5C4KlHmxHRIooXvgd8MaLU/3BCukMtV7YhA+YAvBKZXuThSonm6gda94i
         lhB1AuTMC57fezDPUNYy6442zZm/RRHf1izQXlAsR9gj/w/QraN42P6XpQ2beF431UdM
         DcSOSxpfOJ8kvc92h9DNPeVa5+bRNaUCrCjU7OZCOpQMQHdjEOnK4yMoWntnIedGktn2
         D+0AU/YAM8sYKvIvx7Mr4qdCHlekKhHABBn4H1gP9JaIIYj8gfqPRqYhIN/p6KoN8c4K
         eDRg==
X-Forwarded-Encrypted: i=1; AFNElJ+gFAW2uOpFkyTmk2pTsxN67C+q7xS6gVyjvFpZJeM7t2OIALaDchRrE0m7E8uFb/NsFDQUPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz+vsEw0U74nvUIyJ8MI/6fe0D2gKSpPOo/XCax/vNvyGwQO+V
	f1wodYIF6cBzPhPnj6I3jWjenCQJ+qsBUg0ljqKyWPeQwhfUeqOonUG2/q4U4wC75iCOWlgcaaB
	QeAJREovfaSnMyba6fjx8ssqkWJOZPF9dpAOWTbA/ulWRqQ8yiVQA9OGOGQ==
X-Gm-Gg: AeBDiev8N6lT4HuM+B3wohOYWaNc1takXD0iVnBq6keXhzrDQVFpbr4UsWE+qrqKGqt
	A6ABIqwIJ4w48V2EDNlFv+eBaimVhu0Tlst5oYN1azbzkULSnVkScFgAHidEajtl+gSpEEx9SWr
	4bgisZ82+qITPwfFG7OVe/YVxFl2yuz+IvRMuH+exNcLQbCBB0CzxILQWYvn1Urfb9GHHxUJYY6
	PVIHijOxnDTBzWZMiJXA/LRBoBnXD5RcF+Ca0ehG+KaARhET93Mz6rH9EWSWCuLZotBQfLUdXB6
	RuMCUVFNslPrySLgC69hG5mM7dPvFlSXAQes7QgquEoYw3LQWtFpd8ICUFGbhWTLmScgu2AnzXm
	8j7SRwpnWga+PQD7FtcsWo1Rw1lnpFDjM88Qvcl+i48eB41BfIhZOsa/UURuDh+d5pA==
X-Received: by 2002:a17:90b:380f:b0:35b:e51a:ec77 with SMTP id 98e67ed59e1d1-364920307f6mr1308412a91.16.1777348585841;
        Mon, 27 Apr 2026 20:56:25 -0700 (PDT)
X-Received: by 2002:a17:90b:380f:b0:35b:e51a:ec77 with SMTP id 98e67ed59e1d1-364920307f6mr1308394a91.16.1777348585379;
        Mon, 27 Apr 2026 20:56:25 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490905648sm393888a91.4.2026.04.27.20.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:56:25 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 09:24:10 +0530
Subject: [PATCH v3 04/12] iommu: Add iris-vpu-bus to iommu_buses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-glymur-v3-4-8f28930f47d3@oss.qualcomm.com>
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
In-Reply-To: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777348550; l=1065;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=DydqIdia9cmT4zC+axscUwQlMujOYL3SDRWZ2LaadIU=;
 b=uv7UAzu7sAsuZDPmxAxOCzv9xYKtBDu7s/YBLJf5okHY+Wt6mzYtJY0/tliLYjMr090ZkEP4M
 nDwoGlXzeIwDq/ZRKXbzxUNySSWceRrt6Bw8UYVepbM2jUG97uOCMTh
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: F4pp0gwe-jGLywUZSNdvFfVczJW5-8Ep
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69f02fea cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=HQKoClRO7b2jHrqM0cUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: F4pp0gwe-jGLywUZSNdvFfVczJW5-8Ep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAzMyBTYWx0ZWRfXyGd1AYLYOUwG
 uEsmxDY6+y4LUO3Xkr1RG8j2VFM9h4EdwMVOTRbbJIwnd9b/CdMS2y5VoXH+1iQJDCAzoxB9JmV
 v7a6zsBhcmnc84dDmaEHN/oDnKcj7EHC6XT12Gah0DRJT43GFwJ0zwvELsY9qySI7y3UdIbTVpj
 VNMf+eDjH4DOaLBiNqQVLmxeHwmyfZLcCnA9c+0VdexCdvnOgHbfgNVSGg9DJQWF/10D9n9jq7N
 PXBbqY+7qmuAYsl7sG53khqYg6ptvGuqoWwdLaTpfYIJ1Mi/qZ6HObijIF0OtyEWdJudDq+5XUb
 MFEmrSTiHrFAE5K3ff9RBXFLrn09jL/r94byXTsYzGQ1qwlw4egUVnJ6KH9iSaBND+F1Se7JBYp
 JSdPJ7xkkq68uJMi9X/G1O4n9F0I72AagrapVsusPIDsZw4fUNdNacPkRNBMp4xMpGk3Gi09b+q
 +06i2U2O7xOVliGWTpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280033

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Add iris-vpu-bus to iommu_buses[] to register the bus notifier callbacks
for device add and removal events. This ensures that when a device is
registered on iris-vpu-bus, the notifier triggers dma_configure(),
which sets up the IOMMU context for that device.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..d8ed6ef70ecd 100644
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
+#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
+	&iris_vpu_bus_type,
+#endif
 };
 
 /*

-- 
2.34.1

