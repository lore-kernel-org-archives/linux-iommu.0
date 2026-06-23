Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376AA3D566D
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217247; cv=none; b=Tv8nmDp4sr5Rjbq/hRqxzO6NCssms3fZIKL/mG15/xhXDiX83XypzIc3dvNxRtsS5s6Ok75kNRqJAUd7CTYq7Un7e7gPibrugTVLYNOK+hf7tS2nlZvSkJvd5wXsMAki582+SG88TGCsMmDzOrBFSKsCxJm9u5gRVLiVLQ9ZP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217247; c=relaxed/simple;
	bh=+andxJoQaxh11RwL5Ar3DWavOKD9vT0Vcjr438MV6Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PIv2OP2bMEQEwNWfLC0KNSu4VaaWPzQwE8jCFF9DfszGDuLA0FYCsboDas5mk2u3Z+m915l7lLcHp+nZYl6oTptqQvgkK50O7+SBWhQ/b0xiZ5jtzUIp1I4bKvaAf7MxAjzuHXj+tv/0499DkDUxIMSuQkyDk3l0rTNwntAclaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MDTJXwf4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iE8zJxlQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MDTJXwf4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iE8zJxlQ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBasnj052535
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+KblVWqnrcQ1YGvHTJZqI/
	1q++EEgqUk0YUHE+Mq35M=; b=MDTJXwf493TWigh9NJNfuYpSVEBYPxoCmWI+yv
	WrU/nAcqPopzAuR9Ia5erv/ccTMfF6R24bDoFyfKW36UPjwIUjJypRvq82nlF2Hb
	XD44LPyrC3g3XWTDKOZqCMq1MXraXCsoOp0v3D9qfQ671lzSqYEdLKxPQtgDZift
	vWUhCo8JnAyiPfTj4Bipsnbfvt+wJye2sa8SdGmORF4g3/oz6TUbu00qa8nnmyLs
	z4oZ/L0eMwfzDyfLzHfQfQY1dPRaXnUTdeJ7o336oE+fc8fENaYDTUGRFcHsqq0O
	UdPR+RjranIVYvO+YDb7yEq6rXQkVfqmpOriE+uZfY1ZeJDg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n44pdh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:20:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84534f17866so4624630b3a.2
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782217244; x=1782822044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KblVWqnrcQ1YGvHTJZqI/1q++EEgqUk0YUHE+Mq35M=;
        b=iE8zJxlQJtD6K4RPMrB8blkddbgy3pyBRY6hEfmieLVPQf0CYrxCJx0/9uu0rlAHCs
         a+57sy3KX5A5uhZr9S1yhahAN57vOAT2ml8/l8Palz99k7eJcU4rwY6RIuNbN/M5MAvL
         HAfDdF3xCwSEz0HYkRBjBqGj+ja9AQJ8f9U4nGNKfOCN2r7L9dgn6zLg2Gii6SHj7Oe0
         hAOZVaAiEEzfW1J9kFvw5D0BaH2bMAdYhit5Y4WkpiKTB2Tn3b3Ydbt6I8RWANAPv239
         kD0Wz6XmtYCSqBUDFN13wQ67zu1T7nZafg9evf2YNtrD3IQ5w6Gj5zEjSdGvs5Gc8+4m
         c+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217244; x=1782822044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KblVWqnrcQ1YGvHTJZqI/1q++EEgqUk0YUHE+Mq35M=;
        b=B86Ctcm1sv8/1G5sK51pS2tvqV9z17b+bUQGKHRh28LPkeRUXr2s2inQbsYuHrcGRI
         cCBIgTMhkUMLlmlGtubGOshDN/OeKqNYUsrlrrp+sx4DYZJX0gQH3jA/I78on5sDb6yy
         tZ9c4yJZvyYWejoNTpitHIWWAEkNy15oddkZMBPXCot25GAYnx6+zAXGRZPOClEN0uWt
         toi2xCYaNKuMZn3uNwA29uPdgUnV9VCwO3RKvVfWqT4hDKuR6GMt1b8+omyffgu2o+1k
         WIi5iJit6laqxWxJgZubJ0/RKodL5kHHq9ZZyqsTb/4urcQwYe29k+wAmY8xezyvsGjD
         Xi4A==
X-Forwarded-Encrypted: i=1; AFNElJ++vcEUr5cPCMktsJp7tlWzEJb2rF4CRrzCFzYcML5dpabcJojAKiAH+alWvwnl20718LNBKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFrqUh5F8GLg3CDcFmsp1nMmcSJbFGy7YP5WJf+odGFUj9+Xtr
	ESJuek89O5GVnQ4U3uzdeZZDSISE+ylRhfNnIV48gdYWuft9E73IfZbJmtRw9mxT3OzwJBiMsED
	ekX7sthAKx/HZoWIgN3+/W8mrYjT/WyZlmIEMQ6lpayF1jL30RI0ePRHOuA==
X-Gm-Gg: AfdE7cm+jsCPn1wEdVkdzpiRmauuxKsdoajPgCy0+2nHdftNfqcoC0Xt6QoYBw4s+L2
	b2g9bWj8XVypTqoKjtKXGlYzNf6QpC7nlsrS2T6tCvkRRLKEemeEExvwvF9855QdHMsvvMDzr1V
	srsPDxffNv+jUjupxajxYQLPyv09u5gaI+ij5ZK6I725coNRhxcJH5dYob4dQKQ/IdxRUIFOeJ+
	RFZpWDElizdVq5xOKtTc91mXVT3Hty83Eqxd9Txm23Vi3KHRKqs3ZioCuo6i7HGejf8nqAF6yL0
	+7bX5/EfYDdWmcZfKJUjXCAwe4elYUVMkQhKYvoVZB3JZspyXgjEUXswVGf+wlPUGuJBF6vpEMJ
	Lrjt0yVTw+lFxmbw4RBXR5olqSaf3/Vxj6bq/tA==
X-Received: by 2002:a05:6a00:1311:b0:841:dcbf:e82b with SMTP id d2e1a72fcca58-84562478d11mr15797264b3a.12.1782217243968;
        Tue, 23 Jun 2026 05:20:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:1311:b0:841:dcbf:e82b with SMTP id d2e1a72fcca58-84562478d11mr15797220b3a.12.1782217243366;
        Tue, 23 Jun 2026 05:20:43 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74646sm10171856b3a.29.2026.06.23.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:20:43 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 0/8] iommu/qcom: Misc Fixes
Date: Tue, 23 Jun 2026 17:50:26 +0530
Message-ID: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfXykkbWkgrQDZN
 z/Cp5hA2W8cD0TO7E/Pf+XiVBBluK7wg7GSCkOgBCbVzH1PMt2CynEd3POAgXVb05I+xBdR0u6n
 J0LY1ZCAEBlHXBn88oB/MFrA1WHorO8=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a3a7a1d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=AmUTqjPzaPleRPW9gFYA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: -jfuh3xg7WTjSwMUO1e9tAqwhELHtSwT
X-Proofpoint-GUID: -jfuh3xg7WTjSwMUO1e9tAqwhELHtSwT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX1+sIaAH0IEKz
 ybEzrYsacl11VklIGXGGGJN681j2pkiF/3CEA1yHtCGqmiUHb9zIEPQe7NO8sWyrxN5I0VXWlmX
 41KPUJjIqFwPZJU1l+HPuhRVSOp8cAIu2XFqlJE0XitZ8bSEWJDQ99TIbb4/vMA43X80QHjw0Nl
 TqE5dgFrDmanmqoZQU0gtPQlflKZojMbgfgZt89NLDARZR2t5RIy1j4Lv7Wk/6q6uj982ickmKe
 u1GWKO1n54QUAq86822tir61hC1e96RLoGcLw9Pd/qyFHW7juE9x0z1dvzmsFmdnIgvovmAxvEy
 DYhQsK8AK/bFdO30YU3yoPp8xkhlYpm3Okl6LBKZFuKqEoP+WX97xNtJJB6C6mJYnDk+tQYsShX
 uZd2KcVqWJ2Vi39Gxk/cO1UDLtnpCsvpMoCFg3lfdR8WiyLNG/XM0rFL1A9Xsqa9wflr8Y23tJo
 AYab4+gFt7g+/lyfE5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230101

Series to address fixes in legacy qcom_iommu driver, it is based on top
of  https://lore.kernel.org/lkml/20260623071245.1985938-1-haoxiang_li2024@163.com/

Mukesh Ojha (8):
  iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
  iommu/qcom: Fix missing pm_runtime_disable() in
    qcom_iommu_device_remove()
  iommu/qcom: Check pm_runtime_resume_and_get() return in probe
  iommu/qcom: Fix pgtbl_ops leak in qcom_iommu_init_domain() error path
  iommu/qcom: Publish pgtbl_ops before releasing init_mutex
  iommu/qcom: Add NULL ctx check in TLB invalidation paths
  iommu/qcom: Enable clocks before hardware access in
    qcom_iommu_ctx_probe()
  iommu/qcom: Document why sec_ptbl allocated flag needs no locking

 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 45 ++++++++++++++++++-------
 1 file changed, 33 insertions(+), 12 deletions(-)

-- 
2.53.0

