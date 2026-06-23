Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA073D5C32
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217289; cv=none; b=aIkjS7zxzNPCo18Y3rRiF40Q4YDX9kV9koYsd2GOM+bcZ753WJE58XjXh5qD/cDiyH1eXN6w9dGUlhVLSBfsTIijanek32iUbJR7Uho6RsVt81v4IdCoULjdRjLbT8QTucxs+GhYc5n5b+fNzitWGj4+De1IgDg7sFcmjxDBLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217289; c=relaxed/simple;
	bh=wWGDMXGD5TISOPAYxck+Bim377mn/yH0BJMgpaHrpCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch6JtN9uMNz11ajkHb3UQxXWmpjKAqTlSlirHde1xztM/b6gYAW8t7x2qZNLwXLFurc2UJcAA2cDMO68MWMwtHG7qJNto+Kv8Zvw1gOZ8oNvMoSjAl9YrJtVoTmVOpcRhxyjwtHHDZM00yO6alLr+qnlERCfKoS2eITBjgkGzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TYZQL9E8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c+KVbHrZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TYZQL9E8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c+KVbHrZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXoA63668842
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JBzpNmWrMK7
	7dv+oRp9gwFSkRedXf34HcCV2tGd28wc=; b=TYZQL9E8iFOu/LED/EVmRVaQnqM
	kltxe15x145sds5k3qvCjnnnbPX+49+ggmv2QX1KCaqUNgYIvbaE2R17t/aT9nLu
	1Q24L4rFnRQhE/uZY8tEQSqd0i6W/7vSlhV/qDRZTSeo6AWxSznmbRCJUnzq0AcT
	bOwxIZ/9uKDGJOfkqEmkJz2+2iTeQGYkivkeHzwSlitvorn/ldk/jRIKOeDRnaT1
	n+fIrMQZrhI+QEw/WZCgQ9psRRuIGDLV3s0HzWwPXP7lNaFd0o8vNElsC1xT+ffL
	VClykvintZVJI88aqR0BQtJLyaEIjV/TEGuN5+QbgTL872HOk6eRVBRk/nA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppygwxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso3914519b3a.2
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782217287; x=1782822087; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBzpNmWrMK77dv+oRp9gwFSkRedXf34HcCV2tGd28wc=;
        b=c+KVbHrZfdozjabEQ1VnqWyY/zTLIjxaphr0UY4wdXZBnzZ4omzlVGF1s++9RXnLwr
         RQxL19RZb8a/oyPcQI2BeLlAHQ6jdweNNsg4g88wauK7dYqiv4mqqrBVSLVhSIMIojDo
         I3kCawU/d57FZ98K2rcbc1HdfjQyFnClNm+kYDYXT0suCEGCrJRLj0NB5ScwxNi5hlOj
         +fHMx7/Fc2sK4Oy4hR+IoMIAUXKJiSwoG9gNYwE0wv0MQtRFPT7P/8q1zjoYMN7N/H7k
         4dTRU7u3/DFfhNT33c4Bvir0OeZHYwB6Iffg/U2yDKdGP6lbOt84JNsLlpIF6OJb0VVI
         OuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217287; x=1782822087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JBzpNmWrMK77dv+oRp9gwFSkRedXf34HcCV2tGd28wc=;
        b=FZ9r2MZ433/xPqOz9B1g5UG8z+vSEhxhW4LS4YzgveFAv3mv8GO9bqgtaaJnGhL5M9
         tEH8Y7dm7Te8pr71bavJem6dJlndDGa6NvjGKco3F+odLHYFmqjNfkCGfeYVcraFPbf6
         SNuODxHTlsl5dDvZp8HFOunOkVNc+jKza6VuPS/yeFh74ewD7a7GwffK5taw+1KPALHo
         vjRYUBpLJUgQ/GnR2r95FcqHEB6z54cqxCLYcT1rZpnPQc2eAXHQQdSoIhqUeroxDlyN
         +C4N3pNz85UVBQYQcI1nPTUy4mK9kjaTscXTnkd1MLXTEf1XabmnshpGG2PSbnShfwAK
         HIcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rrecqCpLpQCoLIU1npCnT0q2HAorw5PPFLekbc29KIdwl8lzyKTz1chEcYNabFshJ34c9sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQaDbbmQgpmftAnhOVug6ZSYVhTexjOT8+8GVjZZ2Kg4H0Z8tk
	I0PpULMdEOqv+cX7QzjYHWE5pqMHOxVLXRDNFzeE0LevOnnSQfB2A+RvHJ3mI2yGk/zYnVNgQfD
	i/6FLpDrzfttqAvr04PL++r0bEHDUw7DkB2UT6BF3acYTz2iZksbvUpHJwg==
X-Gm-Gg: AfdE7cnJ79uNQnvkRAElBXQt0lBHP60LPWnF+5DBC17D09ZlEKWlxOL+7Th2PUxVGS5
	IXK5dmP/FkVN4ZIZ0YzmFQouQAyDgA3JfcyF58x33L5AxTt8Nv21Aj/mMjlBZeKusoK9okLMqpW
	RgqEXsO4GbqNf9BKUro2U9XKlvWnAe2ywXih+kl1D+jYMtCa3+NL+Bxs7rc1f40lme/+Kv+CW8z
	X3W/g6AvObGttVJWQBUZTZNLVsO2JoZzgow9hu1X7lRum98YlZsrUsFPTvpPHoPj0/4OG7VhIOS
	Wb4M+quE0od1do5+5G6z9V541fhmGJwe/lIr0JOkWTSj8rW7vPuKEAliOSsevj7MCSuuq8cDP/Z
	2ZQ6AzfOaClJvSKHy2MhwaihjKEZtOmPP3WEgfQ==
X-Received: by 2002:a05:6a00:2e22:b0:82f:abc8:ae0 with SMTP id d2e1a72fcca58-84597066cb7mr2782734b3a.17.1782217286766;
        Tue, 23 Jun 2026 05:21:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e22:b0:82f:abc8:ae0 with SMTP id d2e1a72fcca58-84597066cb7mr2782687b3a.17.1782217286206;
        Tue, 23 Jun 2026 05:21:26 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74646sm10171856b3a.29.2026.06.23.05.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:21:25 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 8/8] iommu/qcom: Document why sec_ptbl allocated flag needs no locking
Date: Tue, 23 Jun 2026 17:50:34 +0530
Message-ID: <20260623122034.1166295-9-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfXz32EZVpNFrnY
 Ji+H9vcaVh1CR88OeAuyaEWYJGSiSGi0L6wC39uqzr11V7uVxk8VunqBnl8lyEPh2VH2WKTGkmE
 NmlqH9a+AAt+n8hDV6ZDRNBfrFY3/NvqkDQbeUZhT9bQi1cw22GixQxFAU3BVXiUx1KUJMRKNBZ
 fTiribEG+SzEI44JlCxq42Km4Tz/CC71QT8aUVRjXXA3erQzjoWz/zEOZ0G8UHbOvsOuqk6wGvp
 /RPCydLuPLnKg1cpUQCQUKZaaD/KqdFNETmoIT45AsXbKqpK5ND5brmjJWAA1jEqNFWROqNGfGl
 xXBGUGxiepXFrNqCrGh9654PcOKZ1MCePpfvvP/yGcDH2sEdhiQOuXUNG91v2OZYcP8X3L4pZWn
 5eahOUwLWVrCP7EI7eV7g85UuEBnHjr69/YGB048+wRyLIJi4BQAhimLsy4u19LK0UxMGAu2XY8
 831qHVlxKKzb+wX9Bvw==
X-Proofpoint-GUID: YOzWFx4Cr-XlKTfFP9w8JvNrFN39Xzeg
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3a7a47 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=KL97T5h_q3IXvoetim4A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX6OJH7JPN6o2b
 BC6cjNErmdAhQgbTL7FQVOY07eA1vvA0y49m8GtUcdosA045pNQ+M8Zgxkvs62S7zwv7RZYH4/G
 iy1efu/da0lY8+OFujlSOLTr0B0tpGU=
X-Proofpoint-ORIG-GUID: YOzWFx4Cr-XlKTfFP9w8JvNrFN39Xzeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101

qcom_iommu_sec_ptbl_init() uses a function-static bool to track whether
the secure page table has been initialized, with no locking around it.

Only one IOMMU device per SoC has secure context banks (the others have
only non-secure context banks), and platform devices probe serially since
the driver does not set PROBE_PREFER_ASYNCHRONOUS. Concurrent calls to
this function are therefore not reachable. Add a comment to make the
absence of locking intentional rather than an oversight.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 0df8c2af8eed..bcf5ab049aed 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -624,7 +624,11 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
 	void *cpu_addr;
 	dma_addr_t paddr;
 	unsigned long attrs;
-	static bool allocated = false;
+	/*
+	 * Only one IOMMU device per SoC has secure context banks, and
+	 * platform devices probe serially, so no locking is needed here.
+	 */
+	static bool allocated;
 	int ret;
 
 	if (allocated)
@@ -651,15 +655,12 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
 	ret = qcom_scm_iommu_secure_ptbl_init(paddr, psize, spare);
 	if (ret) {
 		dev_err(dev, "failed to init iommu pgtable (%d)\n", ret);
-		goto free_mem;
+		dma_free_attrs(dev, psize, cpu_addr, paddr, attrs);
+		return ret;
 	}
 
 	allocated = true;
 	return 0;
-
-free_mem:
-	dma_free_attrs(dev, psize, cpu_addr, paddr, attrs);
-	return ret;
 }
 
 static int get_asid(const struct device_node *np)
-- 
2.53.0

