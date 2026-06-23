Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D93D5C0B
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217275; cv=none; b=HNM1Gd31L6s5TQjkMJEAKjMFCX3XTYo/Y5ePFG0TYdEaEw29qqOXh/ADtKcNvjo4NxYqlm4ZoO3YJPjgcOtVP8c47si8TNZhKzI5CclJVH294QUzX9RDKI+yHgIVaC1Tn7XiFavdxrw504AdlSYuSI6qAIkqpPThHpU+Jp1GjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217275; c=relaxed/simple;
	bh=AN6ppwR3kd1WFUbU9DKEq3apKpJ8vyt9ejViggT5/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D56G/6K5xITcLj31QV31K/ad4FvezOxf7uvlY5x/09Ur+GNxWwC+d7fvN2p5ekmQAroD8iKivKMEUgClkJzPlnIYSKnnM8L5TLwZ7S5gwa2wBOyW/5HrwhcVIfHnETK26sUdrTIT1BZaWz9uUrYCISeSnb66FM5smf/Utfpvj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gg212elX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UXEXpTtp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gg212elX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UXEXpTtp"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXT5d3744677
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GaQcQVT5n9L
	HLCVP7PYj+va6pm+vVtEUtpzmlxdT3Kk=; b=Gg212elX8YWQpGYnRY7LnqyzNqV
	8rdTz6d3EdWibWgx7AmJQtRmFGrfcg2+2JnNVbOuq8pdoZ5gPVvRQ/oRt0dmSc//
	x6hb/ct9e9bTnEjzzO9x0UU/YKB8qO8x9ZzE/MXA93jpLHkesWlVNA9Vw3Etyr0j
	tI0WvJwM+S4oVy8XFU/YU7wqUPQKa8Pz/ldmTUgNXUYSJ7Mr1fF+r8gsSnX4l2Ei
	p2KjzibpsEh7MzOeAwXmd1RteQFP7kFMp5qDsn3wukO8m7NUIVxkdMmOB6Qlq2bZ
	ycEpUHPj9/kBcs/1D3P7R6IREjxjSfnUielRKmkxeEYkluzKvf4teiacKpg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eypx38v4y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:14 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so6852360a12.2
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782217273; x=1782822073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaQcQVT5n9LHLCVP7PYj+va6pm+vVtEUtpzmlxdT3Kk=;
        b=UXEXpTtp+hZti7QtMwmCh5A/XeASRrvgns10DWOxBcNvlrmOMl89Ka/523KVfzEo2m
         eggtoFeSRBFR1DmIDGgJTf1L3En6xARGEuc+EQ/7lezM0+BP84Cn433aiwT/+Wq5SPHG
         Bb+PW+FFeOyYaH2G/J9kHTcjgoWLnmLH2Ko3Bn1SXVjLTq48jjTDbZ2b1p0bWa0TiosU
         jZv8KqPqxN3Kg/pb+hfJ+8S16IAqM4CtPcIUTnj8DHq3hzYPhKVlm1yczJFQ3HKiblK6
         mcmcaOu9JalD26G+zQO2/Y/Tw+qaBMWiUbaihKdEjxAAD6vKrHepe6swSOgWdJmyoNLV
         7Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217273; x=1782822073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GaQcQVT5n9LHLCVP7PYj+va6pm+vVtEUtpzmlxdT3Kk=;
        b=inJZC59GOzswrrL5D1INCvMwvobq1JKgVAILS/6hdbVLKExw6iWOSwPG56FFlTgvPa
         GnfTMESKXksr0F6LeJoD201MvuEA78fi1XKEW9Vhzlphp3yf714WfDaI29fZxFxBE7Cf
         PaoOosTXpheCek0epIjGf0LslY9a4EJq3/9yeyW1vaERn5XIOH8oHuSbS3hqum5uvh37
         7wWviMzot6rL1CkLcYqpHV2viwRhIPAC7YjSb9fStTRK/+COqc+j6l3YjfOqNcGuckMl
         PVaLnzw4conquyIp6LYLkcdX3dNr5OOshTQsvRWQAhd4NDMF1iUXqBvJSiT7RSHy52jq
         V9ww==
X-Forwarded-Encrypted: i=1; AFNElJ8/IUe/vDCBOKmbJ8NsutHaTu/9M3qpdiCQvyNv7DXCns1CFfks1WMjqIF7y/iITGWdl1/+Mw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq8BTeyjE5mPQkLinjf98CE95cAVnAt3Px0xxD7Ft2kJ6r0iHV
	mQQTdII/V5zpvk0wsdBh3GCW5FaaGnKSi+ultrzT0qQQyQHfrlWUNuJIS9MNCTh/K7YE2EX7GMc
	jdINndzE5j3EXUVf/NXRef4/xEM6hXMMGZtsJomqL2+4o1N9GMrZ9/czm/w==
X-Gm-Gg: AfdE7clrbW6VGwdv+GfIyaz9YX9+2a8OyHftNHC7UscDCYD2fFr3GjJsVyTA/CfL1nN
	kL0KWQsEX73GbSBSB+fsMwmfKoUJWN52iVerhzp1O71x3e5Fu+2ObNmvSl9gWZFmffW+QFlkvRF
	s8rwHts/xm4eZFWDC4jwi8gsg43qoMMkpLjPXNEh7niEJydaV/LwcOLx9f0mOoorDMD0H/VqLDe
	s0IAw7neqQ/3bN4R3IXhXFVnaAnpKh8V8qX/iQEE/UToDI/jkeVEU+dAe50UjZqzVtyogcJYDKP
	Fp2Gdqw5Px02bWsKjOaWnxinEKdjHAi54ztajLXIlnFS26KaBPEr6J7lRGYfnyZP3QrjBGEIt/I
	FDcok+ynFTd5hpNwjgZVUGIr7wgLpBiIS1v2WFw==
X-Received: by 2002:a05:6a21:6e97:b0:3bb:1629:17c1 with SMTP id adf61e73a8af0-3bd151a94bbmr3396900637.35.1782217273370;
        Tue, 23 Jun 2026 05:21:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e97:b0:3bb:1629:17c1 with SMTP id adf61e73a8af0-3bd151a94bbmr3396862637.35.1782217272829;
        Tue, 23 Jun 2026 05:21:12 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74646sm10171856b3a.29.2026.06.23.05.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:21:12 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 4/8] iommu/qcom: Fix pgtbl_ops leak in qcom_iommu_init_domain() error path
Date: Tue, 23 Jun 2026 17:50:30 +0530
Message-ID: <20260623122034.1166295-5-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=EsfiaycA c=1 sm=1 tr=0 ts=6a3a7a3a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=pv9nQ82OMFi3fEhVMZYA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: Iu4USzOUCyipzihnL46L6InB4Frw9dhS
X-Proofpoint-GUID: Iu4USzOUCyipzihnL46L6InB4Frw9dhS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX3lrL0ooPp0pN
 1ET96/knSfCxvRI7fT5jMkrYlkqq0G7oZ8TDbuXVO/nFTXbygzM3GrN6+PFM7F7F/wH3SXdQZx/
 oXdoR1WRe5ZRhQJkEEi2LegkCoj4y3c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX0+oE8HtHVb/w
 PrjrtmjPVN8oTMlttpL5eyb8ZC4j8pazEG6vh/AO/zoh3sUZqOuifhY8IcH6YkWewYRLLCWKyzg
 wEWaK6asWTZW6OfiRVsKrUae+9Xa8Q6N7BjI5vvnuA1vF0IF9778R82cX8u08l6skLbkRmg7Kzo
 mV8n3NIh+OMUteKNgaaMbTTVpVCj0Dn4QjTneHl2pPe5N3ziEGVvDtxJmAAnD7HFlz53ufmNpeV
 MKW31RqlcpQHpoFgtHbx3HKCytmYKkpeG+tRjKDbDp7Iy+DWWZw3u64gZee3dMoxGenEfYm9+dW
 pebTzpCrwHli4sPSxUoBGfvBpSIWQgRqalZMhpk6JHF4W6AUl15rPCnb7qrM8hy1IFQ8rxBJvT9
 C23LTQeJ4+71iNPVXCmkVmzC1N2Wn6BIcoQd/1zbdOLMxnOzpOBHyz9sO6MhepvhbsMt20sAect
 Gj5/RENSkFYFtrIrfYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101

alloc_io_pgtable_ops() can succeed and then qcom_scm_restore_sec_cfg()
can fail for one of the context banks. The goto out_clear_iommu path
only cleared qcom_domain->iommu; the locally allocated pgtbl_ops was
never freed, leaking it permanently since qcom_domain->pgtbl_ops is only
assigned on the success path.

free_io_pgtable_ops() safely handles a NULL argument (covers the case
where alloc_io_pgtable_ops() itself failed), so add it unconditionally in
the out_clear_iommu handler.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 4e714a8e1fac..b6ce85f7f923 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -314,6 +314,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	return 0;
 
 out_clear_iommu:
+	free_io_pgtable_ops(pgtbl_ops);
 	qcom_domain->iommu = NULL;
 out_unlock:
 	mutex_unlock(&qcom_domain->init_mutex);
-- 
2.53.0

