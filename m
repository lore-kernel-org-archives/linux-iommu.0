Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFFB3D566D
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217266; cv=none; b=rehTT5XSeWx3sZvZA8zNAb0JpB0rMsfq5qM1bHlOTqOW1OVTDEQnxMcU7AwfJT+YXqPEFG869ZH0eszYGS2QG1YmwhP1eIFwpPqEmgdwEWtKS1GEKiYaAKZeV4OItmY0++eO9rH4TTBcA4z+MmbOdwkfV0wZsyEeD9s6NNHIp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217266; c=relaxed/simple;
	bh=94jfzRBV157ACaB1PXeahfMYSo7DdtPYJEQZlADRXcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6rtyEPgf5BY++sIfV7yqdJ9hmxIHK7znUHeDi3F9ryEUEmkQjTN7S1Y4KumDy7xQ/k96K0GmAvyAdZpKmdRPhUdf51GNS5vwFp9640hnEU0pfeSs7im46XRqHyJLIgMpMaCSKvlnl//7tAKbgrGgMZJbn8PBPQioGaM23CvQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F6m/yzxY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LqAYvmp9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F6m/yzxY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LqAYvmp9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXahj3752857
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1v/ynnXiKbGlgjlxO+YjIk/mxVwZxy5oog6I7VHwP2E=; b=F6m/yzxYQAhVEdPX
	K0AGg49/6psv5sZDCQlGnknWglUmWHw4CbQ8TXmzKKKbRvPyMOFsVWF6mrBBY6/d
	R3GonF9jFoa53XKMe660gYN8KfuT/Q50oltNwzBClRuQrZZkJKDl/EDOP1Cz52Jl
	GKD0RCTgkUgLxDwKKCYiT+A1+Y4qv6+IEbd9k+hPfsYOpNf0t9n7JjqJ0lvm+6cR
	M34lnTevTc3K6fjlfobSCtM81Mwz6IOCGe2gxPhy7WhENsCMmu+JnAOTLTCF8TKc
	Wyx1ctLGT38NrTmFPo0RsICNSQ6xrJ1v6IoRMwUe7fbjUmguEP+lax1sYf3btG0Q
	VnxXHw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29h2vv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84531eaf8a8so8116637b3a.1
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782217264; x=1782822064; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v/ynnXiKbGlgjlxO+YjIk/mxVwZxy5oog6I7VHwP2E=;
        b=LqAYvmp9Y61KY8KryYS7sZySiDasaQtf/I1t5lPbWe6kRlWilI38LiLU5mmw1EVznx
         CA9KZ2cew/Rlo1+rZfOvXJwSNf0ybaJIrf1mo/ZGjIAP6mzz55hGn/j9LFBrqMF8l6bd
         lxw7/0NV/VeJIVXHO0I2voJFbWqvrbgQHTFsihdx6WxT3vp8zhnk2SLAZp5K3gu+JNzj
         vov8CufKLBWdUt1mf6ca2f7jL2b5yjhWSqkeUEIYUf7q8RCupVHitGg5q6a4s3FIjZSw
         IjEaYniu7q4XCX2LJMc2/dfg1ZOI0KOWd3OZxe9owh9bFd4XKgO+MHndaAVAUfxwE/YX
         APUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217264; x=1782822064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1v/ynnXiKbGlgjlxO+YjIk/mxVwZxy5oog6I7VHwP2E=;
        b=Joe1fUQqUMHp76zE+3WfK46RukJG3/FEjLbQM4mhbLf9UETEw872/aCftCYDQqNZeO
         3qHh1Cg89AJ9FRqAYUzBwAph+3EaiQ6T1bWeWJsiWxPTAFgh7ITO/WqhyMMrj9wAx73+
         bK95XzWMDDjSXmR25DaFfwSRjY2cWda+OYCZb3nd0WZ5nL2+9s22CdpXrofO/c2ZAtiL
         +kqIp431rR1n1fQvzo91ELH8v+KCTLpr4UXej6YH40AFFgZlPIiKWVKg2FHrZ2dIyf9Q
         mKA4j6sEkQTsWOmqpVUmfib+UpbTj5LpG/xTt+gDZ4rdqjwDXmaIoIf8Ku7nM8QZspgo
         5ouw==
X-Forwarded-Encrypted: i=1; AFNElJ8h4DcYmLp+k/ACzpXYiJeDKfp3hMoxt0lXQEzLDo0gRTBdPbHPIN/sK2b9PuT1ijpw0IDNsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqM2l8TTu0yehCDhGFdnSg0P6p+ap+6NCgPMkK8Kx4jdxTBQqs
	CvML+InIoxDeU5oqVV2y/l+UCGhE7ZLxKIejQ0eBnAyPGFxWUf+IPd0Qwc47kQ8ylTq0ViedsTN
	QfCeiuhZzxH+++y+/Euza5BrNrj/02ha3UN314QUTwxiaFs2cDhf3rf+mBw==
X-Gm-Gg: AfdE7cnxBztRxs0Bn6dcLdxZbvo7abFB5Got0CfmKKsj30VRnx3ShuSgU4dhT2znbn1
	zUOyKnBXX5fn2qo8/JMxwZw8yVUDXywXEdpMjgsorqnJGQRHtsTuCx/pJaHnPJy0DRr8NvQyZ+B
	Bv0fCQ7r8vXbSHzkrSTWo6rQhBNJdOQ0pu4J1HLrUIn/HrXbF/Nh70/jJoSp7gE+/qSN0NASYRj
	Idk1hmBv+XSoocoIWxniFg83GoaABt9NbZuAygay/Ohyr8ueHHta23kK8ktMcEkge+ON+vSPl+T
	K7L0IoErGPYJsB2C/NH0ApfxyJcdluvO3EMGJbOvBkjAomY2LjAGfnsDxHdUEYrkySHOy3H2h2X
	TPjBHo4mc0dAha67BdZMB3tlzTMNWUrcowsNhqw==
X-Received: by 2002:a05:6a00:c8b:b0:842:5da3:9b8c with SMTP id d2e1a72fcca58-845970e08d1mr2741599b3a.36.1782217263414;
        Tue, 23 Jun 2026 05:21:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:c8b:b0:842:5da3:9b8c with SMTP id d2e1a72fcca58-845970e08d1mr2741555b3a.36.1782217262806;
        Tue, 23 Jun 2026 05:21:02 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74646sm10171856b3a.29.2026.06.23.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:21:02 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 1/8] iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
Date: Tue, 23 Jun 2026 17:50:27 +0530
Message-ID: <20260623122034.1166295-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3a7a30 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xmDQi4VeJV1Yj6r8B4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: g2BBdFyYV-Fdego297vUEGaLruJM5mTE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX8YSzlFPnPnIb
 dE+SFdmLx6Ym7wQcVuDUz7m9R2kwBmFRZVosmx2/+L+/M082W0zZ0rP1qhWIlAmFA0VssT4PiHh
 Lh+8UkzfWlBh1O1MQZ012kLc3YC8c6M=
X-Proofpoint-ORIG-GUID: g2BBdFyYV-Fdego297vUEGaLruJM5mTE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX3fqlDoEau9sY
 brZFQDYHcWKHFyfPwA16Zwdesi72djk9Mb6gaDCKD2wBgQtPtKwCOD0O1TQZZX86Un/dFyDEsR1
 ThwPhwjwZFgNw5GSYjIHjD6YbJmu30PSLPNyzK0DBNEs+sX1JZt07KGdIA9ZhwWKaZ44rEwg4PY
 CNTG6Eord+35/zGtiQx/QU7X/APMbYuxeQ7hql3MgAT/kNAhdB6DLi9g198LCh7JaakxdqP+v6S
 CBq4fqP3wFxyiuP9FRmuH4kexINsGoqCDJnJOSv0ICfBzJXk+A8UCwggx2M83gZC4Pxg1usaTRD
 bOaY2kemTGo1V5/6xX+EeetqQAiu7fHtc9CEmWbM+U8oKDxZ8lquUOigaPgc/qae0ojxWTvBcWU
 sHM9jGryxFy0AHUokl3X/uVZ03kG22tQYO1HtaFhMYNGMpW/27PQR2Fp/aOG7Y37w34xeAOPHGN
 coepkzpi4WpZVWddpCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230101

report_iommu_fault() returns 0 when a fault handler successfully handles
the fault, and -ENOSYS when no handler is installed. The condition
'!report_iommu_fault()' evaluates to true (printing "Unhandled context
fault") precisely when the fault *was* handled, and stays silent when no
handler is present — the opposite of what is intended.

Remove the '!' so the driver logs unhandled faults correctly.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 32efef69e72d..09f2ee6be988 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -200,7 +200,7 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
 	fsynr = iommu_readl(ctx, ARM_SMMU_CB_FSYNR0);
 	iova = iommu_readq(ctx, ARM_SMMU_CB_FAR);
 
-	if (!report_iommu_fault(ctx->domain, ctx->dev, iova, 0)) {
+	if (report_iommu_fault(ctx->domain, ctx->dev, iova, 0)) {
 		dev_err_ratelimited(ctx->dev,
 				    "Unhandled context fault: fsr=0x%x, "
 				    "iova=0x%016llx, fsynr=0x%x, cb=%d\n",
-- 
2.53.0

