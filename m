Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387593D5C12
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217279; cv=none; b=cujzmH8t9gM2dGn5mk/n5Dodw4UmSLOP9CM6esDlsDxbVCr3pz/x8aI3Ss1zYPedIaVeL43HPNMwhqh2b6NDuTYmj1B77OWJXuxGkUGpyV3YgnqIfL/TK07wcpScWZHMCFYRS8M9rxWWOg7wvdmK/7ljDIxE3i1ws/4ZO2yC3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217279; c=relaxed/simple;
	bh=8BtzNJYd189mxIUKftmER9o/tQq+pg6bO8RXUFVJiDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+C7VqC4F94bcfQNNmaJvauBRVIkGHI8DIIQ+VCqGhGjRFGgvT/UcQ+yI89UkaJBH5LAkWtJxshF4Oy7t4+LLwiomgT8CVBNss3qJlyJj9FkqinwezvXX/CgBGi+sZvKnwY3HyLXJqlkFuEzlaiPh8rC+4t30FkF6WcacPWOJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YHNtFBBD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EFTECYYa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHNtFBBD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EFTECYYa"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NC6gKG3744649
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Tl6TMjOkY0v
	pzUkVoZ6vM0rqRq7dBnGr6QKrXS58jEs=; b=YHNtFBBDs4TKgMga48qTiEUHFKi
	NmksgOIL2hvnjwXE61ef29VKhpTJ0T7IbUYhvOh2TVF9Qpkehu0YI8f8764Y8naO
	xX8+mTSMV6yeVIjL6RZKtfOUgFhRPtMR6ypwkMQ1A5O5sftSQeFh4/81MmplR9xe
	wCcHqiXMoonbj5/wn5u9Ta8Jqd9vi9bqMRUARtvSLDTgJzPciAGC+d+5tjqPx5fP
	lxa9daalE6wcTE1eo2CpcxGwaBEHP3449oEXbgdPCYnDIHQI/c3mx8xw11SJi92H
	djHxlxu3/wuSfosV8PXhRE20g+tb+hSPGQJ8UW55cq5JH3F4DPqsewuq8Tw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eysv3g1gv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so3633491a12.0
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 05:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782217277; x=1782822077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl6TMjOkY0vpzUkVoZ6vM0rqRq7dBnGr6QKrXS58jEs=;
        b=EFTECYYaqEw+sw5fc/qB6St3sHfSbSp/Qm+1UDN94tRO8KQd6qefF4SXfo6OTHySiB
         ZlRsNRJlR75urMVLGHZ+5JWD2noYVgqyA6HPiyuxl4zeu8/QXDEwRiu115s6zIXHzHFN
         t6pB/PjAmXcdJ8LYu4pX1sFCYsotPUyUjqBLmpEynuC2/z39t9FgNPxGLN6A5QoT1qbx
         dnHS314IIr7EyP1HOKqWkEGijlOuyutAGjersVNoNlXlriCJfRT1Ead6/LxAiqdippSo
         Ilq74EWtzn9GNP2OnPTUpk8KlJMJ2t1MDkLTx/f9qe8xHlOJN/iNjtm+wsrbh+hEqjK7
         R/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217277; x=1782822077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tl6TMjOkY0vpzUkVoZ6vM0rqRq7dBnGr6QKrXS58jEs=;
        b=LQ0fc7aydtg3f3PHFy9Lebfw2NV+9wx0sn3qGkJzKHhfJrZijSXagOL2JRhhWmESzK
         yd1NLAHAcmeFHZn/Nov6s5N6BmQhyFW43uwRrtmV4yHEcZoYOsdDENHpuD0v6l1KQm6l
         PpTUqTeQHLJnBbgQd8z7BmTp6zU7nffXOu3qMF0ihpWtN/Nq3xAHWclbhg/vXxyeE1ob
         KNV7BA4XvnuHK9hvoUWcH1DWB7HqS4ul53Et93HSMZKSF3a+wlcCxVaoFIPt2ZfGQSEH
         3GkqWyJt8wfFJI1we/39bATcII27BZC2hxmFXdCIOowycnmppJsH74N3uiInWxHqbce0
         wCGA==
X-Forwarded-Encrypted: i=1; AFNElJ/lqv2HEVvZKiL+upODRuaW2H26lXkM3IAQStNzKFDL0n3wIqo3dTaVMal5k4Yfk1eTkQLo7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzh2dFljwSe9SceXv4Ow/D0GtrDfMzS7PQ0ERCBTKjfJU5XsKQD
	jkTI8Q9Kj8TLUTboapX/rADfJCaEG8frAAFLThpWKmNI7xVwSh1Cf9w1uQMgLlZ/m7nZj/vx9W6
	aEPzVIrMfYWWs+RUcYlonJqTNnTfx1tBRadep32brASu86YmkO7ZDzXueBg==
X-Gm-Gg: AfdE7cl253BC+RV7bzAdr2ur4rFMsP6+abHGgOJPRCiJVYmg8IuQGncTLSXuLAwhqgb
	VHx8F+cWtPBPvbVhIrgkLNqnLvExdBmn08kII47TT2CbOgyyWeBgm6CqPiobL7St2rkrCZ34Afi
	2/G8CQr2LsjsHkIzYg5YIL3506bo/9scXV7jGHUQfwMcOmAd5lXfxQLXY5NtV0Q2/3/RDJpf6YJ
	HVGajzd9iotcDIp3xHHHA7mJOjgrVuRdVB7MFS2oo4FIKZRTrvsnKL7/sSnPnZfJB/qjXbqH7IP
	MLtBfqXshke4tzASOsXlpuNf+MG+yhKmR8GHRB9rUdqHUt6nzQ1mf7uagNrgbJHCvtALZpZ5y+N
	oYhlUa2MvAFIspoNtGBX5vnQgtvtLLTIIRLyc2w==
X-Received: by 2002:a05:6a21:1f83:b0:39f:91e9:cada with SMTP id adf61e73a8af0-3bd14f00047mr3463384637.9.1782217276870;
        Tue, 23 Jun 2026 05:21:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f83:b0:39f:91e9:cada with SMTP id adf61e73a8af0-3bd14f00047mr3463324637.9.1782217276119;
        Tue, 23 Jun 2026 05:21:16 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74646sm10171856b3a.29.2026.06.23.05.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:21:15 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 5/8] iommu/qcom: Publish pgtbl_ops before releasing init_mutex
Date: Tue, 23 Jun 2026 17:50:31 +0530
Message-ID: <20260623122034.1166295-6-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX6NRgO+Q+Z9J3
 rdalxbJrql0rJH0Jru61vvd6AH3Z9n1GqbDNXvPAQ8aM8x3QHBZGUJRwLVUtB/k1zaW2nzacipw
 0TxkUEJdI4WlGV8V91SMLZtO9vPCbQc=
X-Authority-Analysis: v=2.4 cv=WtAb99fv c=1 sm=1 tr=0 ts=6a3a7a3d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Ya-8ghbQ4qwRuljleqkA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: bWvZecMPYRnSbyK31GaW9sz2mgswsOLz
X-Proofpoint-GUID: bWvZecMPYRnSbyK31GaW9sz2mgswsOLz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX+S1wfxNnwU3e
 MDJ5j/XkyI5o/a2tUT9ngJdCJNN/3vd+wsl+Sow5ya7U1fpwP3Adp1TBoA4CqkWYyKw7gk3T7sK
 jJN8tDMLhKU3JTHdBGeh43AF9yEhKKaCI0Z8K7qkla1gWSahXeXrCQpq4bRL06xvADjvaz+8ORh
 Lea+gMsmKY4BeZZMy533M0sClRWcuG83205e/NS0blLNQ5LGVcImhqlwMXZxY1w8fvgSVG4AjjY
 U+OuZcsi/7sLJLvf35noyMAh3gVUq6vaWJzu6B/EeI9kxnBwgQlIbFRg3eH8tNt5vnAkKy51XDX
 DHk9t7j3Fov5lO86qlpqoZHW1KRogmyfjvVHab/onBDEU4X0ctZ1Z8N4+t0qsuIlXTavFy5vHev
 WYzS7MZhvjyXxCFAKSJp/86+VQQON+5bC7GHqy4n8eynYR8GHwz5fHxs63IOn24IOMbsZ7OuRiW
 AI9rs3N/b1WbhGaTegQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101

qcom_domain->pgtbl_ops was assigned after mutex_unlock(). Another thread
calling qcom_iommu_init_domain() would see qcom_domain->iommu already set
(domain fully initialized) and skip re-initialization under the mutex.
If it then called qcom_iommu_map() before the first thread set pgtbl_ops,
it would observe a NULL ops pointer and return -ENODEV for valid mappings.

Move the assignment to before mutex_unlock() so that once the mutex is
released the domain is fully visible to concurrent operations.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index b6ce85f7f923..40fb0408dc07 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -306,13 +306,12 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		ctx->domain = domain;
 	}
 
-	mutex_unlock(&qcom_domain->init_mutex);
-
 	/* Publish page table ops for map/unmap */
 	qcom_domain->pgtbl_ops = pgtbl_ops;
 
-	return 0;
+	mutex_unlock(&qcom_domain->init_mutex);
 
+	return 0;
 out_clear_iommu:
 	free_io_pgtable_ops(pgtbl_ops);
 	qcom_domain->iommu = NULL;
-- 
2.53.0

