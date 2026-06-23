Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55243D5C0B
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217283; cv=none; b=QonoR7AR/ugywudQFSgSvij7PKyefHPJfbVHZhM4XkbkZkocDE6T3O5AGxMFuP2DIeCyVntCLVu0iLZyIsB3HTEToyvuME+Hdby0CcFSNSPi93wGdAbkHUlQPQ57Rjh0U+8LUW8UQYYiIbWuHBQ+72J6JUuxh0TawWVr4WncPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217283; c=relaxed/simple;
	bh=0a6sGTnW/ivApoSTTdCDBkct/L9ipegiSq3EoaQIfLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1beQasGgyi+LPOkUFtd4aHkxXPDLSie9Mh2JoHqciFvh4k1/fGRnc0p5tTMMJlrC4JJdObGx/jLN4i3S01AEKMZvd1uGGgQqUf1G6PbF5P3Ioogw8fp2ePS2GVyoDGKNJW5prp1MkN9wU+RHAVvwE7eCRVYjI+Xzq+Fp4Pd9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hN+2ckoR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hE0xF/tB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hN+2ckoR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hE0xF/tB"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXXNC2308431
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o9QcSJ5f45T
	1iVf+TdgPgzAQzuE+vW43HSQ7Okp/gZ8=; b=hN+2ckoRJn2Kj2ng85HOhbwW+Nz
	N9o5FvUgYGk8RJSpx3jDan7nvRF2hkJ4cmM1q2B3X74EbQK4mL7teRb4lPVCYQV2
	nm3iVtAirug4ZGRodY3fqPcuMWkt1QrKLdbhddPs4ApqdvbZ/bHEvyDyGTkepyay
	FMyWOQZtLMP2cnp/mvUEf9EPRO+kpmziENzl55970PvxtVwlN8kiIhQuI2wm/3Bw
	lwa9+ayuJXWvc12K7Lc/z8YM+tsFQ7fZ7s/GxV0t5JQCU9g4BGFWW+EZsPR54ggQ
	vcluBN4dKGwWq2CE5FSfEZywmB+LzK/wdaiDNvigU107RCAeL4kHjhJ9qnQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp1gs2y6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423970cb30so4200377b3a.2
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 05:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782217280; x=1782822080; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9QcSJ5f45T1iVf+TdgPgzAQzuE+vW43HSQ7Okp/gZ8=;
        b=hE0xF/tBB84joSfP0st3DWJQ5GY5IM6fgK/doyboWzi/ux8BmaPKbifMagPZ+0LxLt
         8BzeMo9/W60+CCfF1yfoN8cyRdwbHw2XLPefQdyqWWuCseCMeQgJ8elbYfZmfcAkfbfw
         QD2R9mefc78M+hI7Hqp58HGKgZhLHVE0/IB93Om+A7czsK7FnMwVpCjV6oAc8VDs+QOc
         nEa8po1tTtycWc3hZSXyQM1L0+PqgBCURv9267+IwM3NDnaBVXZ+9mJaIiqfgr3DLsdZ
         cLlSDdqvz/CVhTy7EiIhHhTjllxZwLe9YSeYzIEwRMlq+Z7CNcu1mXFBM+hiu5ChpyBn
         oTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217280; x=1782822080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o9QcSJ5f45T1iVf+TdgPgzAQzuE+vW43HSQ7Okp/gZ8=;
        b=VHYpXfSOUlsSTV+bbZ4+P/Qr5OnrFVUOcYeXUDk2K+Q8pIzm7OkbM/q1J6ttqDGvA8
         eppsos30ZS6Jib4Y4XDJFi0teRFg8JQREUkS5uOWZq7KUBQ2qOVo72d18r3JmgJ0gI7V
         CygDY4qB4y6ysbCTDPxeF0QJY3BIDXibhoMRrOVFb340rbyMK0wz6WnFWzEvoTXeSlMr
         SKLIRpMYTjg/e5PrYHoiyZ4D+NYfx4H4Zk2HDSTwQMZmahvr1AqA2oZ8RuQcOEmLPWTV
         wgv7sK4+p4RKHUChsXMjqZBy4nGk6lDFeisA1r6TXkh+UPIvfrZkK1xWS4dbyeJe8LZw
         U1HQ==
X-Forwarded-Encrypted: i=1; AFNElJ8beVYuW7uTvlJ3ZqLvux2movgnKI0QPEzLwB0gWHxbA8wytphqFHisEIKjwO6mcE4tXch4VQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyANbNyj2Jzh0ExB13vr0E6A2zAlY9h/0Xa7/066C+qm+2zFDQ6
	9sWGxoyMg6t23KP2Y0WpvwZ3vv6NcQP0pz4Ru77qQEkSrLa7rQH/ejNCsu0PFebOFdLMscccZQh
	mHd8+GJYlSTu9ZrH3Oo4P83sswZTar9PuF56gp+MHD4s5vJ9Kbwh+Z+509Q==
X-Gm-Gg: AfdE7cnjO5r/JheCYk41HJsTnyWmZUIzmrUYySde+uZoZS3leyp9SWg0zei3cZIzGlY
	MXmc+wGXcq2tvMpJiVuaOrJpIVR75xNwiLpBZTfei4DxzZk5jn1a0YZzcFMnZ2R9Ra8md0NWpnc
	LhxcW5KMYFjXemHz/Kyicpcvy4rrcomRFhCXjpuqNuV/oUUi5ncgFdgqDui4TRCUguhMCVnip/s
	tXWbVPhIMW31AoGHwBNH3Uhf+2y7AnBVpvsACakBqHavpZqoPLdJoTPurcvdguU5hdEy7AJxvlO
	7uTzuxkZfReJSd4rVgHYW6hQm91q8udNpjfApYfBccDn0M8w0HfWeJl/wFMSaikRJ/aBkd9sO7F
	3WqDNJPMU6IaG3JWBJmrgr0KFgbHYHzwFQLuRvg==
X-Received: by 2002:a05:6a00:2e8f:b0:842:5634:3c1d with SMTP id d2e1a72fcca58-845970aff20mr2692026b3a.19.1782217280063;
        Tue, 23 Jun 2026 05:21:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e8f:b0:842:5634:3c1d with SMTP id d2e1a72fcca58-845970aff20mr2691983b3a.19.1782217279518;
        Tue, 23 Jun 2026 05:21:19 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74646sm10171856b3a.29.2026.06.23.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:21:19 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 6/8] iommu/qcom: Add NULL ctx check in TLB invalidation paths
Date: Tue, 23 Jun 2026 17:50:32 +0530
Message-ID: <20260623122034.1166295-7-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ZHrwmvQVJzu1_2cF5pEwe5jSQGyQTglQ
X-Proofpoint-GUID: ZHrwmvQVJzu1_2cF5pEwe5jSQGyQTglQ
X-Authority-Analysis: v=2.4 cv=QJhYgALL c=1 sm=1 tr=0 ts=6a3a7a40 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=9AnWiAp10G-6W0uwed0A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfXz6SobChsaw82
 ukpEWCdpBiCJxAqo2ozMmaK6HTv6QGQ87RX6WHAlI/VZ3c+nTkZVb0b/iQIWQJgGLfwh1prdSj7
 y7cJA9VBVFZWZGbbB12YJYy9unW7Oec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX5E7qHJSi8+YA
 V9RizcVDQ5od1VDOo9GPQ2h+7eAg0Wk39XLHWEoDzuzYcNfZCxrJo9epBLy8q0wcSX2avbOzYCl
 CtQwWW8yPSjh5H+xMsJrHkAUyCoQKeKmZHtu8/5Y9d4O9dQLmaoFYQ8U0jRH0CrVd8bY2xWxL3I
 Zlg1WQbHfFZ/XSmWsc4SUzXz6nnkjMc2PLE/pBH/9AsL/VghkGMsTd2SuecrRuGYEJnFEhlbtlc
 UkF0Eb7C6Up6lvwbRzQURlyYODSedwlEM6RWppHmPU03rYftvdnn2bOorzo65a7NFHHvUkEL7CN
 i0THfPW3O1DTRdViTfWHqNPDZV+DzIKOuwyaUN/B6yCbZBChcOViE4WpRHw+CKeQAQ7jVLgGImi
 rkZ+i3872VWGEAvwQGBNy6gIaLL34YGnSt2jRgKMToMrQI9Ea11MtfrNf0tvQNsVwKlw19xp4AG
 ruTGxQQteDHcuD2BewQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230101

to_ctx() returns qcom_iommu->ctxs[asid], which can be NULL if the
corresponding context bank failed to probe or was already removed.
qcom_iommu_tlb_sync(), qcom_iommu_tlb_inv_context(), and
qcom_iommu_tlb_inv_range_nosync() all dereference the returned pointer
directly, risking a NULL pointer dereference.

Add WARN_ON(!ctx) guards with continue so TLB operations skip
broken context banks without crashing.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 40fb0408dc07..51b60b296bb8 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -121,6 +121,9 @@ static void qcom_iommu_tlb_sync(void *cookie)
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 		unsigned int val, ret;
 
+		if (WARN_ON(!ctx))
+			continue;
+
 		iommu_writel(ctx, ARM_SMMU_CB_TLBSYNC, 0);
 
 		ret = readl_poll_timeout(ctx->base + ARM_SMMU_CB_TLBSTATUS, val,
@@ -138,6 +141,10 @@ static void qcom_iommu_tlb_inv_context(void *cookie)
 
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+
+		if (WARN_ON(!ctx))
+			continue;
+
 		iommu_writel(ctx, ARM_SMMU_CB_S1_TLBIASID, ctx->asid);
 	}
 
@@ -157,6 +164,9 @@ static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 		size_t s = size;
 
+		if (WARN_ON(!ctx))
+			continue;
+
 		iova = (iova >> 12) << 12;
 		iova |= ctx->asid;
 		do {
-- 
2.53.0

