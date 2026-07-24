Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE442447815
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905976; cv=none; b=JdU99MgSRgwvDbDpOCQKqHV7EMtB3GufqSxyjAMXT8i6iq5Qy6UDYTzhFc9vW7IoZhnAH+aafs7unuXwlSg8j//duMrVG4iEMr7UDJfOnI8N7qbGlJAUdqjhYI5dIou2t/89zrryskIFJUDFgn2ZHZ4YtzRGMiXCZ4AIrk3WEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905976; c=relaxed/simple;
	bh=+ofXmQ6aEwgY9wsAg+7EOB4x9r9B1VPmqlK+pXTFlrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEZIw0xfuPIkeYFvdGhy8J1bfZGtS5AwCdgD0KTLFT2HeYEfN19IJBVc5g2iyGnYn4wabR9hMtRi133MDPLJXyjVxzvFQ07Z6IkNk/no1Vig1aTSlLzXZCbRmwdOts8yB9MA2/b0L2eLX+23W5nBh2ko/nrf1XACHLLKILemDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O5btglzr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TObWdTJG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O5btglzr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TObWdTJG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbZGQ3090677
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CZ0/AJS5lrL
	G+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=; b=O5btglzrGJ+cQ7s9v2g3Y5iVbAo
	uZuOFOFT95meGpoi9+PG7QzWxpSZhB0+jy7Vy3wEAVCuNx2Y4RwzIBlAE5ZAvlvl
	LnvytO6at/ABhORaaBy/UGOiZyxxqDUtYo62t+C4E/etbxRHpOetoFxUcCwHQ0nG
	kFPjtbnPik3rzivDjP2WM/Mlcb75uK0Z1fJsR/fmqGwk1g5E+O0H99A7JMNC4YJO
	tgRilQXUQ2K6nYd2nZ8oLgHAMnWv2kh0tWGTXSEjubsOAl0Jh0/iQjxaLtKCxtMc
	ZtWErwXud5+2r+2+DWUvZE0EabXZVWOGFYjvv1L3K3IibC46FP3ovXsoYeQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cgghuk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0f0a0760so13221281cf.2
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905970; x=1785510770; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZ0/AJS5lrLG+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=;
        b=TObWdTJGoIxX4zzXMX1Rvw1y27vG8I+XrhheuZyIxLQWv5oJdFtG9YftlvrZOdsouJ
         jPOJ5UXBruvsa6l0dcrFHAy+VO44/Lp5U1NNcry3o0PEPXbJswlDi3PYwh5RgavKR4ks
         /S8LvmuLvZ2vCu6ZLJFBCmZK79/OMZilq7Ay0Bz1mDKpxVC6lEk7t3lOVtl4vLILhYjD
         ICTzUDzh95om0L5BNv2R2YLQWaXxOFbFMqjPMu7o5Tpj0B/rk3yCwILdvmiJzKEzxjzj
         2tTtwU90wteA8MXfPWF31ODzXEOPkEnNNeDn6xX7CAnrMCR9VmaKYjbJ/h35q8lnBJGa
         /gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905970; x=1785510770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CZ0/AJS5lrLG+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=;
        b=LbW2sL8oskwt0ToeQ88SG9GQJ6McAo1pwUk8D+Hg7RDr9gA45V+yUGMKmkdIWYJNfE
         vElXfN2iD93l205ch3qLW84Dazy3MJtftHx7nO+Ygvs8ge0qDrv5to7vMMhTcn4/PXc5
         sfTdooc9aGK9c/VXxlx9yJ0FqwaPtWKPBRVQAslICqTMgLBXHp444LE0iap1G/D5Q3u9
         el+BTqNU854aAD6r3XtjuroKJb5W8tz0AfCehBO0B4pQKzP36x1xJHS8Y4tWERkQSZlc
         447LGAiBWq4BGGnMcjBHLQAP6Ede/BcgWwRI4aFV7YaCGVkS/3vTxNR7zAbOvzXKEDMb
         NyLg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/5tLEeYT8USkFf+La87VPgK/rqxsSon/oY6ML7XTrotoBTL3gy32Qqvt3BgyfgJp4hgItcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn9f9PTv6ogld2XkqNWbgrvB98QjQZNm+zhhvbYG3OsAwSQvbU
	kw1EVUPvh7ERvoNei8GDG90EaAxAHZQ8rEk00PVivrU/FU7CsHPdTu4EQ/KFN3Xm2nYE+Q8F3M8
	YehVWCySISvMhNhNX5GB3WS+EGwp/pFp9OI7OtJZkEowEhWu7rd+7nLGVfw==
X-Gm-Gg: AR+sD13ntDaZe7+ofb0tteKdJsfAuU0jOHLFEvl1lcJ6vnmA26EKonRZEAbpRMa3YW/
	vFgVlN9V6GGUGJTDIAOdrzPE8lDqgsAFZGvos44k57yICy1Umw59+xSQHtMT3VgxGfk6dZCUK7Y
	EjejSEXeBXeRi/VGtQqajH+G0V6vvhIn9JY+nHRcjkYgrnAH38dyfYSGeZg+bLv9mIjT+sYWoi5
	UWw/Nny6X7MFGTuLl6Jzt/wEvHV7YwoVictFS4z5s1lEGl7GlbbBTNJAFxrnmWJBeTxY6l36X1I
	Xkdg++4gEZzvzMlgxA6PfzTkaWWAy+xctXr0TLuhQVrJ5niWHVO44Z19/Nlq7NzgVRgPg40AA1K
	2/VPKie4O4KKvvRxRaZSMCOGb2eWvDZUBdf+X
X-Received: by 2002:a05:622a:15d5:b0:51c:f04:4aa9 with SMTP id d75a77b69052e-5283de0ad83mr75510931cf.32.1784905969872;
        Fri, 24 Jul 2026 08:12:49 -0700 (PDT)
X-Received: by 2002:a05:622a:15d5:b0:51c:f04:4aa9 with SMTP id d75a77b69052e-5283de0ad83mr75510341cf.32.1784905969385;
        Fri, 24 Jul 2026 08:12:49 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32acb462sm364332466b.25.2026.07.24.08.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:48 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 13/14] iommu/dma: Enable IOMMU_DMA for 64-bit RISC-V
Date: Fri, 24 Jul 2026 17:12:17 +0200
Message-ID: <20260724151218.965929-14-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
References: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX6ItMqmgzuawj
 cyhyqw13ihbuBE2xlkyiZkfOGtrvpKZbYmtRtWMVEhZjpmbj6O12QM4Yczxdc/BSoEcMCrC/1d1
 8xLvi7wpEnIXJjkCFtBNMJdshmNYUki70A05aQs3GRSVlZqdVfsMz/DNeR34Wx+mZvQ/2iB4sx5
 UOQDG9UnXPMB7KZlilrEkVFE0gRkC+bZis2db60vZE4N561gqk9EwUAFd9MwVFEgKSvIlgrzbMp
 nGGunIoJIfbKTZ/7ksWXjr6DVNwCyr2fUji0Fe9hkhh00kNm8ruiOTp/XFSQRhYzJUM4D35AlGo
 v5Snps1382S9bsH4RVg9KYPWXDAiHfZhkloB56FNVsK8l+2JBPabTCwV9Z4UZMBr0NiJSAlYoVt
 MCj6fqHQqxHAjwioNFxXCBrVrzENAHtS1WSDXbLjp/fgKCSs1C6EXIcL4h8347JNO9qvb9DLQNf
 OjR5pp/oj9YT7tWQI4Q==
X-Proofpoint-GUID: OtJErgAQgSeVD0W4xIMAM0g9-iSWq5VY
X-Proofpoint-ORIG-GUID: OtJErgAQgSeVD0W4xIMAM0g9-iSWq5VY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX1fxjAYGtbbhA
 GeHSdVW/b+s3oMYCLTs0B3TMbH4Q/dRVx0ak7E+APnX+G/xsK1GgloSCTIhrZQYwAdzd0rg5hTi
 o3yyTrKyPi9BoV3sC0L1vDkJvedJn8M=
X-Authority-Analysis: v=2.4 cv=P9sKQCAu c=1 sm=1 tr=0 ts=6a6380f2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=vvBRGx3AIC5YeKHJuXcA:9 a=kacYvNCVWA4VmyqE58fU:22
 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

From: Tomasz Jeznach <tomasz.jeznach@linux.dev>

Enable IOMMU_DMA for 64-bit RISC-V now that the RISC-V
IOMMU driver supports MSI remapping.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6e07bd69467a..1c9f2ad10f36 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -151,7 +151,7 @@ config OF_IOMMU
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
-	def_bool ARM64 || X86 || S390
+	def_bool ARM64 || X86 || S390 || (RISCV && 64BIT)
 	select DMA_OPS_HELPERS
 	select IOMMU_API
 	select IOMMU_IOVA
-- 
2.43.0

