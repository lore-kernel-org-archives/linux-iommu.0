Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED0368974
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951008; cv=none; b=p9IkRdZpr/zZEN/OvoljazD4jP5dATijCEiopUkpkcK3ZwafvDTrqr55CAcjg9xFXcL4VAL2+t7adf3pZx/8xhmuZPFyx9NHYpfd190ea0rk8O0YGrHrgQBRdb9VIXcSdq2CGCKcKmDVmJc43PP5jQkpYSgxzibdJBCqkJxw4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951008; c=relaxed/simple;
	bh=9ojkIAdTpgdWLJL63T3L3LzXB40PPdXzhWOQLp7Cpgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Svmngq2R1YYDWQ3VFCeKnetl6N2VEZItt+rw6tlaXSYT/Hkw7VMfx3bxfqTM+x/yJvw5LUJ2nWpPg1KfkBi23+7OLH25oua9QKhdwkmAhj2yeOpL7L74lOa31Ks/bktm8sgTs0Gkvrz89tUUCCHUtIbQSe3rhxK8rNDqOzSwfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inrUE1eF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fMTnRm9b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="inrUE1eF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fMTnRm9b"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N94fu02319291
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=; b=inrUE1eFryx5382j
	3x7rs59o2EAw0GE7yiTLTv6vxcNjIksca0eovJL55QwMmtmF0ghirHogM4Ku6YGY
	bLCa8odqqLPmBKzzeNDMepoaZaXk8ieuZYRiBHdEWeX5q4ApQBx+p8E7i2r3zqRN
	hm6AApefZAMvcbqH0VoQ4vLcsd+n6kdWs9UhsXDfN3FwN1KxcDl0qS0O74W2XAa0
	wBVmQX1BLh196ISWpAFrH6rYA+Y8xRxVksDSOcw+XLKIAICQYDCzAYACXF5l4vzG
	aI9/WqTstkkEgqEvQVfYA1ljH9cb8f7kjOCvWb/wxda5/10m+yYcBurx4gmsRovt
	zBJ8bA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqgfss16u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:30:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad5fec175so93552835ad.2
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776951006; x=1777555806; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=;
        b=fMTnRm9buryx4V0heyQcQbnnN6hmd+yazVXQYLvTLLyG2fB0HwphVmhFihAfYVLCfV
         hNzNCBEr1sS5deh9WaFjgxtK1gAe/x7kUEvjcGpyG7g6hbE5BZRgD0Q6USpaVPLZBo+m
         HuLsL6mCACaZebAEh/hIeawbHCx6yaIAiuUDA08+rrkPotLCSJ1JL4gI7TzNio0Z9keA
         egAC71LN/AZgmHb1IxTcUdoIKRIOWt2SKFQpbX8DAOjOdsPXYxA991JUHoqiptiGs0qA
         LLMYJhbujuuoDz+lDoAJgkvOEUfZBZ4Kdi38m9pHiMIgVqaby1kvd25vXFlLs0QKnWc3
         KjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951006; x=1777555806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=;
        b=NeSaV+igJI4o/usDxoza0F/XSCmUBju+ZXhIFSxkOsaWvhDHzvLD/rYO6sZgHNg2M0
         eDBMjE6UqbUTMK6ZLrsSOPEiNSNGfezGul+UQ4HjfnsaWYLbeNeyB4494jDllR+l1f8z
         tlNByjluDj5DatDnv/GCyUjBaAUWnpleMtZAgPNfaJeJPb9GOj5zj+5+KdeK6Ffj39nW
         abBHwPPaToYf05Y4hiCdf//M/jdXk/QaWDYQZ4N3x1JbC1PDDImLPk3qbESRKKAcdFwj
         ZbJR38NJphAeq01PkO7VBO4acSTIZL3P5BvIdxMt+iCOiAV3cCzQq7HI2jaq7VoxlRH8
         Vzyg==
X-Forwarded-Encrypted: i=1; AFNElJ+gGPNplunkkhrKL5YW+ukSQaj0ds1aQwth6UroLd7sCYA3Z37BlT3PZPZnXefp6qQnE1SERw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxgscGn1cLRF9xp9l2UARi9Ny5J41TboH1ICy5+Iigtx1K9Fo5
	TD+rMjqITd9v+hkWO+amWcThOAnI0Fff+QBe2QdkqJosT6Ob1wr7BOzsf/6vp6ScV4rKsNdH5y3
	lAfhca5RKMdaf7Bk40YJ6ha4mzsPclyGXeEvOwhJWGoQ4cVaBspznF9pFUQ==
X-Gm-Gg: AeBDievz6zsut6mSHh+/ltJVfuaCgPIObvi1o80xp1KYQOyATXmEZ5LbICLG8cMZ3De
	3Zm3Z9KFmM63WFPKqtK5/1m5ZxZzyDckweDxYuJzzDREBwVZfynhb2CSYtwjwoD7BUuGIRKdthO
	gT7I+uqOn6uugVlgpFP2DmP16r1w/+VfqitkFvnQCg/4EA6b5diWVP9veM97hDBSN50kAhv42FC
	mrQlDyEZD45A9IV0Djm2jCptMirm0QCP6ASjKSh7hf0hEqMTkr+sEvkc86bGP0kQoSu2g/9RyJM
	dWURb+ThCUBUmNhLXD+w2E8+BvVuk+lBBtVQe+luTbFpOn6EbEwZVnJdjflOQTfoMc6W993jQrM
	BTrvA/bGyKYOR51lQh8Adnow3cyl9aBAEXZlFfi66ZL+lT57hikClHPm8L5iQ5S55Cw==
X-Received: by 2002:a17:902:f551:b0:2b7:9ed0:4f92 with SMTP id d9443c01a7336-2b79ed0505amr34984305ad.32.1776951005409;
        Thu, 23 Apr 2026 06:30:05 -0700 (PDT)
X-Received: by 2002:a17:902:f551:b0:2b7:9ed0:4f92 with SMTP id d9443c01a7336-2b79ed0505amr34983465ad.32.1776951004706;
        Thu, 23 Apr 2026 06:30:04 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:30:04 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:30 +0530
Subject: [PATCH v2 01/13] media: iris: Fix VM count passed to firmware
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-1-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, driver-core@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=1361;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=9ojkIAdTpgdWLJL63T3L3LzXB40PPdXzhWOQLp7Cpgc=;
 b=kLZ5VkIwiLF40laB5sma2d3q4alpT4zAEZptqRbq23De2A/jVlXuy2rCJ87n8t/knrGPt5QnQ
 BQ50ze3n+5yDir6GHjn/LjLJmJfxx/KjeK3oF0PhnKyu8vo9IOmZtqI
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: kCvHYIIbtJDXQE8b9aJnEacg3QesYmhQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfXwo+ZXTMme9wM
 nDXXgJa6BNpyC1FkJmznaJldmdBIDXrQALuIUKBD3Cd6Xk+oRNPoQKJYJVZh/sHFAC80zr6SBsf
 jBuFSjkcAS/z6sJs5ZobZUxuiAAHXTmcCIPgTxrkE8zzsGfl4gYXMOoz/pD9FMIrtxQEibu6MmS
 k2wzo0TGpMT2XhnZcgeTA2KdbVnepAwKn3MjP7vuCFlQraaFoW2zIH08cTzuFaBH/03tLvxwTzH
 ZLkCgFmh0uRvAt/Rgig2KtzOHaICA5zq2BauQWeDgQ8S2av1CWOzv5lNnalvy3ljJuryezNcQsh
 ffxWC2skYnUzNpyA15WWGulmQGwTmsSKJd9BoRDEaWyaIqYDVJIyfwDEQH/srC75aKhLgWLJrcM
 iwJk5YqW/PkZwb2OsjPWZEcMy+LP6ad6RIPvjUGB2swEgT1iQ9b3IO8Uca55CS+e4KkLENS7O5g
 ZOwDXIpoJB/ejTbaguQ==
X-Authority-Analysis: v=2.4 cv=AvbeGu9P c=1 sm=1 tr=0 ts=69ea1ede cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrYi3PkkErC94SPB-twA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: kCvHYIIbtJDXQE8b9aJnEacg3QesYmhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230134

On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
the number of virtual machines (VMs) and internally adds 1 to it. Writing
1 causes firmware to treat it as 2 VMs. Since only one VM is required,
remove this write to leave the register at its reset value of 0. This does
not affect other platforms as only Glymur firmware uses this register,
earlier platform firmwares ignore it.

Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 548e5f1727fd..bfd1e762c38e 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
 	iris_vpu_setup_ucregion_memory_map(core);
 
 	writel(ctrl_init, core->reg_base + CTRL_INIT);
-	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
 
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(core->reg_base + CTRL_STATUS);

-- 
2.34.1

