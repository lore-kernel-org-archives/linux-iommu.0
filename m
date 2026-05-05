Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16093DA5D1
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964446; cv=none; b=BVG0A3h90DZ24pBKEnFgnmSFzA4a2I+31OXVWBFo7ZvG1pDm5poHQQxeBH9nuGvJBFVF/lt9Qnl3ELdr1vgnAK0HdcMnDFwQrsbXrdt9mkracler6WKbKeqkUtWw8O2aX33NHT8f/DJyyRd1qw8tLTGO3qRxDnD6VjyVCuo/+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964446; c=relaxed/simple;
	bh=YXK+1kgquuMBIXjQrVSRCBE4q5ESQLclNWvU0QR64sE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sx5vqffQWy7N59DNh5n1HG6y6pP8JbYSvvP3ETkZmFW2igaibkYb2vVztoT+1APY0ZgG4ku+jY9iTXO0x4hpWkSkRSIY2E/YCyM69ienv08Zt3YDk+wf/zodAIYcsJtqlaHPLkNqmAOz7bLQPh7dVO59qby/nsu2iMQbXH76zwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PDDxS1pD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B7fKZerx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PDDxS1pD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B7fKZerx"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456CSsA3467600
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 07:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3FtecQ4utCQQhYZ1lQ2laqIkmzIbFQvnTmfCWCJD5gc=; b=PDDxS1pD8LTZlUzF
	WRykcGdhCXhawKasfeSjVCkLIlNMhm5jqbVk0D/cLGHx9hkHF95P9xmvKSUTVLJf
	A2nVGzSLgpBJxPcHlJMIRX4aw49M3kkyut/N7iY/U9LEqYA0HOt/lfXT9kbPAUHL
	VJTjx9o3vzAORfYg1uCdDYO4gROTB5ShpsEgGgl1Uk7dfclsiZxCXOIRNTlqWv1T
	q+tuDnIx+MSNPD6qLEEjFXB147mEkujX6KtBs0hgv/oodf0B/DRZhjW6vb9WDrn6
	ISdjmB72L/725wVhT5+GvNe38DtTx0ljgZnCKeI/qZGkJNI9NKWJyyx/gpLqnOS+
	f+fb9Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvtju69f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 07:00:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fb969a4c0so5905359a91.3
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 00:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777964443; x=1778569243; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FtecQ4utCQQhYZ1lQ2laqIkmzIbFQvnTmfCWCJD5gc=;
        b=B7fKZerxH9g9MfwwRCq4x8E3rF0kvatdNLXuEWT926wHDRRcVfjiML4aaiqUPWlmzR
         2+pTGjkNgCPSx2SkxqxkGbxdmXB772Ovr53HpfDzKr3QtF6fkYuks3jb+HTdzWz7irOJ
         mJRhzykEmSspBsh1qsOTN+fsnDY2kdenApUFk8gsdSNI8BtLq8eGZ6sy+LB6EEbiaP/N
         Qdi1wCXSNkwEVsontNLUONe5jJvjU3typwe+BVA4ZZjcUYwgkq3MLC1bmtgnq1FNFw4x
         WQ03jRehanbTSZCGBxwKdx03b/cCyn2kcGeuKyivrGktmCjEWV2BSkO6TJ9LvtZotrXW
         ExMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964443; x=1778569243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3FtecQ4utCQQhYZ1lQ2laqIkmzIbFQvnTmfCWCJD5gc=;
        b=QMb+V0/bxVtcIxRTbR6haXYyNvMy9DqDsUJ551OxKr9fpEZkKlPGSRF8COQd7vIrg8
         ZWEC6TAW0/+AhWF+vjWfoOYuoQbmHIH+47cmKuCzdR6OOFqMg7FPlouyHPKk3LV60Jrc
         OVnL5yg3FA1+wJ1OSHiFvbANg+kVcm990m6k3inMD42PDDGifu4o/O+mnGOHBsUYWuSd
         w9zT3KKaH14KsrdIqWpLw0ZE+DDK5DvWW3GeZClUYe/NWdA6SgE0zNv5Rk5Zn3l0EdaB
         9PmvsmZFSznWBkOYdwu5cMB6E4w9iJuhm9gp2zsw2JHNwfLercYbInzbe4MIWLBxvqMt
         2GnA==
X-Forwarded-Encrypted: i=1; AFNElJ8QnVn29VyTHrTsEEwadiulEI1CyAkVSHIKBH7L60gVredN7jMg2bFeZ1AfpuG7ZKGKBycoDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyN6gzEIhvoKFVzG4XfqAQ604rk1Gl1uIgnRxe8sYkspgN0kXex
	X/utt+oU2a70+KIF8XiyQMHM7igC9ZTAfsXXntBUD5f3IvScYu2Eq0277QD65lI9r8fF/fwHsJM
	7r3giUdZ4yIuJpt8wM/+U8/vvzNWT6PvuInZ8DAvFWGxPb3Q4F4SizAERRg==
X-Gm-Gg: AeBDietsZZvYJzR9Sg5FXtNgPUSzHJL6LnfPscksL4K9JL0bYfridGUGAwRxkDiFKuH
	cpLMSYUwJDz6okcxXRfrrc3NECH5+k/dJHj484X9QcrffD0tN9Z+dDmCCmBu4KtiKUFB8Cx71PZ
	X6NNTUHttd6Niqp6i5mirbwu95+l+fwFMy0CdiCtBZUTFGd7Xdul++szVTZscbwjG33F0oZ0sxw
	0m4k9gKsHWmr7lpF/ffTq5rVdhFXbbg2RK+Q8v7xK6UXWCOZNe9xz+pLOeVl4zIt8aXXjbL0m8b
	JbC7tf3fWj5YCLoSHPfrEHEdhEZW6YsvdlDGByK+2ZOLzJtKajXWvAcACY6iFAlGWOQQEjaWs9e
	pgbovQGD3MLD9oEfuwYJoMBP8h6GbCGrVyFyTvmAWD+q6aN80bigj9zlvz/6G6yVa7w==
X-Received: by 2002:a17:90b:5112:b0:35f:bcc2:c351 with SMTP id 98e67ed59e1d1-3650cd70549mr13312300a91.6.1777964443330;
        Tue, 05 May 2026 00:00:43 -0700 (PDT)
X-Received: by 2002:a17:90b:5112:b0:35f:bcc2:c351 with SMTP id 98e67ed59e1d1-3650cd70549mr13312139a91.6.1777964441588;
        Tue, 05 May 2026 00:00:41 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm13840146a91.2.2026.05.05.00.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:00:40 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 05 May 2026 12:29:23 +0530
Subject: [PATCH v4 02/13] dt-bindings: media: qcom,venus: Remove clock,
 power-domain, and iommus from common schema
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-glymur-v4-2-17571dbd1caa@oss.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777964421; l=1505;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=YXK+1kgquuMBIXjQrVSRCBE4q5ESQLclNWvU0QR64sE=;
 b=REQWCbQT538q2OfZtlZ8zIjExLWixsiRImG7cUZ40McZz5JR0uUkATzy47T0Xgrc//JP5rRzN
 Gzye7WurnQfC4PYei3rXmcB5CVGYRoloioAa7TSJTJN4AmwWU+cfWXg
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: tRpioAgPGu2Wbu-r44ixjbNKNCdRHSBI
X-Authority-Analysis: v=2.4 cv=KuN9H2WN c=1 sm=1 tr=0 ts=69f9959c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=oAqX9iOIqteJqTbqMNEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MyBTYWx0ZWRfX7oS5AYbpz/pR
 9k9UTuuO3Hw2hrfNp5cOK5VJGtIu29c2PCXQfc10XALeFDYvHmC2NgBiGkvde9jJ+DKUD2IaI0Q
 om44AF4GwW+PBHsNJfrTyeXS5bAxV+DjjoJRgVpUOTs1/nftRcip4I2RkqB5h/xYnWYSktOdiSj
 V8iJwN3RdZ7+QBsh2J89vBDiM5ef/wXFTdMf6PDEZV5Glqzh/b0tVaXK7o3IH4x5FULkh2T5CCN
 yBv5TQoTZC3RhpweTeI9uD29OERaSOOPP6dwWC1UM+dk5iQl/x7KQ63czZMrXCpNQxjB1sLjkW6
 jgu0nmrd54a/Bhgx9v7JZvYhPcE8X68sAQxn0DeOoYNSSJJpkRuGYqyXHu0aw7zGDg6Umwiq83F
 jjZj3Vs8rF8rF7t+XrY5fQeeP5k0E/H5niOuRsiY/OKgWUhZXYlWqJFMq6FOaHsoZW07aioNUVC
 AHsTZMpgPVQZMYDkHlg==
X-Proofpoint-ORIG-GUID: tRpioAgPGu2Wbu-r44ixjbNKNCdRHSBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050063

The common schema defines minItems and maxItems for clocks, power-domains,
and iommus. This suggests that the number of these resources can vary,
while in reality they are fixed constraints per platform.

Remove these constraints from the common schema. Each platform specific
schema already defines its own exact fixed constraints for these
properties, so this change does not affect for any existing platforms
that use the common schema.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../devicetree/bindings/media/qcom,venus-common.yaml | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
index 3153d91f9d18..5d310783720c 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
@@ -18,35 +18,15 @@ properties:
   reg:
     maxItems: 1
 
-  clocks:
-    minItems: 3
-    maxItems: 7
-
-  clock-names:
-    minItems: 3
-    maxItems: 7
-
   firmware-name:
     maxItems: 1
 
   interrupts:
     maxItems: 1
 
-  iommus:
-    minItems: 1
-    maxItems: 20
-
   memory-region:
     maxItems: 1
 
-  power-domains:
-    minItems: 1
-    maxItems: 4
-
-  power-domain-names:
-    minItems: 1
-    maxItems: 4
-
   video-firmware:
     type: object
     additionalProperties: false

-- 
2.34.1

