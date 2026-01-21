Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E97338905
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769038097; cv=none; b=nXGcIQ3H4S1eeG4bATR59PE0cDRsbOwIu7DAxc4S88mrc1lAEzBWQ23PijcOxqNJGbx0bkXRUFOdj9Vn8j4V95FELGKgj4HVMwgHan4oLLya5MCYLB1QmuurkTllcSsBRE392PmTJBRaoc+jXwVMffe3UcnkOBIeYY7rDpD3gnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769038097; c=relaxed/simple;
	bh=2wdp9GH8GOWp/loXnQjcloFEnSMbf9d5DNbDdTk75vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjMMwAjfxQ8KugqBEhquCe47gzN4kPrsuOwQjkpaBDqt8Hlf75qAUpJMYlExepO9i6AWNpBumC6eWMa62FJ9pSTPWkpnMAtwEKJY2FdKj0CjuQTVoLHwNJaZOtg6D6eYpv1QJQJW6rxa0q/VW9YX67HsSv5xTM/otY15/XbFtLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lpdbYA78; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OQ2B2l94; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lpdbYA78";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OQ2B2l94"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LMUHQk4057918
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 23:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+eZGwYuNL/9pmtkPhO1CHKv5sEsHAdFAmDE3I8abf10=; b=lpdbYA781GOrNi3B
	+vtAccJhathnY7Tv8DoTtgLyMDS8oWWIEhOim0DftASW0deFLXViBYAEnRUUz8oB
	wX62B1552q+qpYUK9fjgDRphdHyPxFTgzRQGkIobX9WQ6sKxZdNQLxtPlqmlPKdl
	rsfTvUCIn56R/gb6Os+MvqAXtcGRLh2HZ7hfG/eX4X7372hRT9ggawwZBxqbGWWv
	Lwezhs1mmKWsDXM87vUhFfBPPjOJo77DbcittOzDU/r8xFnk5UrHG0yTmAOgG/7r
	GQuZz4cRfSYTpU4j9gOW3OZMqMwVE6PQdXRzTDXXpvC9KKSrUkXNyFJyTHWqVs/M
	Bxwvfg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu7nbr4mk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 23:28:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52d3be24cso53463385a.0
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 15:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769038093; x=1769642893; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eZGwYuNL/9pmtkPhO1CHKv5sEsHAdFAmDE3I8abf10=;
        b=OQ2B2l94lTUoAtLt+WQOUr4CYQZhlHW8ETnafM7W9WN1VPGcUgZmDpXgF0ldrT5V1x
         LvEeDlCb1OiZGjX5IXnjvRnLp3Z+wJ1DBDpEGLZe8Tn3WawnHLRG4XCI76Teerw4qFCy
         ylfGgqiGV1mYreBBq7rF9JQNuEc4qq5qgnJAvP1A67kb+so1t0IU61nj+N14dQhbk4my
         Sg0p8MFrtiJLCZIrmPEDzUyvuIRqxQJ5iunpk9a9sp5c2TOYkAZUZPjClRy6s9QiOAcF
         7N6mH9i84b5l9h6indcq1bhN9aLFXAm/g32bVgg1QjkWHT2mrXEWNdzSPhRTuabKSnL4
         o1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769038093; x=1769642893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eZGwYuNL/9pmtkPhO1CHKv5sEsHAdFAmDE3I8abf10=;
        b=r0nQ32v9+2Ki/GKVBv5MfOLucEU0ZOg24M8lK/jtHrZxq7qXxnfl2SqsIg1fw1wPX6
         tmWR9+tSbZC/jrYW/rOLVpgZ5+KHOod3M/ptGQMDSMjwliVpVvV9mE5mChjf1dUxauYm
         lMIWjUTjxvhpuTSc2YUEw5+TnuaQVit31b3bX8tQ5DPQ/U9hFM1ziXmK0gcQlA5m31Dz
         NQvt6um+9uCXSsUtcGh6xzPInn78EmLVBvbcL3S0GXhRJHLxGOI8E+oK+OmMdKqp3QgQ
         5bd4TjETnTqZf9rWunjtatmvlNh7w5fSnzoUEBbOMRHAssX3NFOAdf3v0iwiG6KyGh6P
         /HFg==
X-Forwarded-Encrypted: i=1; AJvYcCWORIB2RY6BHX6GsUxHX4QTbaaajb+aSy0AWAiSHJ3bzLB1Z1cCHGPFs5uGGVCeVrZ+1r7ydA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/u8CYBMLOi1Q1n3KBm1NvzatsxbkIJQr61Rmu32TdU7SZs8oZ
	dsUjic+/Sm1nna1lSTIhfewmOlbL5LfL7KpjoYZ5+ptZKhsEVjc1cjar8wUidHWkE5YorufyzOr
	u3/nW4V3SLGCuK794QUukjhIBVY++Y5EC/vDfz0Fmmv7I7P0gy7jj3OQUyw==
X-Gm-Gg: AZuq6aId1rmYOgi/pRdPv6ApSl7XxHQyRl73i0aVNojEas1caGcLa7ZsB8b5PP8vVnJ
	tWZ1UivfYpyQUaZph8gdgoi7a/Z4wI8nvI1XfE+y5PfkwOftgshCehdU6vdx4cVRL4PjxE70fqP
	q1bCBzCAE5Xs98H438j16orGS6nZTvFsoTFGEzUI2GEeLveyHMdumgaJm6Zsfr+dFlWSc9REWsJ
	SOuXR9IFxqoPBnjG04o1ZYFtN/6Wysf9lYI//1BDTK8TeLgldLVP18oFTgTgZfOfNy/1fe2XaCT
	AyhepLzKbq1pHaMaACWu1Guf2r3xb/QPzF+82j0PKFjrabYQS2ZnAMLFdgguPsoQJAqrIrwYjcL
	s5yFYed+ij4g9kwMkEfJBtEzy/sq2dUeu0737pYYRgWNgMCQZbqPs6XuXJJCeJlBFx7QDZqU5d/
	SM2Iy/84nExaUg/ygTan6PP24=
X-Received: by 2002:a05:620a:1992:b0:8c5:3143:84ef with SMTP id af79cd13be357-8c6ccf06c21mr849194385a.47.1769038093536;
        Wed, 21 Jan 2026 15:28:13 -0800 (PST)
X-Received: by 2002:a05:620a:1992:b0:8c5:3143:84ef with SMTP id af79cd13be357-8c6ccf06c21mr849190485a.47.1769038093060;
        Wed, 21 Jan 2026 15:28:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf3976dbsm5159393e87.66.2026.01.21.15.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 15:28:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5] drm/msm/a8xx: Add UBWC v6 support
Date: Thu, 22 Jan 2026 01:28:09 +0200
Message-ID: <176903808259.3665431.13908205509840299317.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121-kaana-gpu-support-v5-1-984848af12e4@oss.qualcomm.com>
References: <20260121-kaana-gpu-support-v5-1-984848af12e4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D0obl5d2LwJ8Vq0xM9fc9_hvLnRuUE2u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE5NyBTYWx0ZWRfX9Zo2GBq7EgWo
 FLFHhNoPdJdnhv0zH9HSYrfyiT2UBkGLjNQ/TfP66C5P2h74NsXpwVrFrCZK+MOCbtBYypSkgOl
 RQlGoFO0rgQpuNueDG+Pdv0Hl0QXsmAcAxxvm94dZ2nOawTfr8xj3319273gu8TUDz4t9Ru81DH
 6nw7cNZrLfgsCFfeoF6gsBwwqL9MZICELWvoGauB+IwaaIwMAOCBWutfUkzKg78p/Wbb6XEi2z9
 a3hbHoPXzKXySpQp8zBqqaVLTOswz+zMSZ2QdUogMuOMup6b/NEG4CP4uCmJE3QM9A9dxCGV377
 u6wFEzYlXnesdV35Jgd/AIqESIv2jKhtyJL+pY1W4rdsIWGb4G5Vf1zyvTjQPT5LuoUXPhrK2Km
 RL8yxcOtqUINbriQmokM5poZRvL1sgFWO7OXLBJGPQ4WKTalTzpIhalIh2kzDbpBJ0J6JLijR/q
 Y/FYDkj4zJqLa7Tj0LQ==
X-Authority-Analysis: v=2.4 cv=dZGNHHXe c=1 sm=1 tr=0 ts=6971610e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=75Vji5L2PsKrzm2Ba-oA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: D0obl5d2LwJ8Vq0xM9fc9_hvLnRuUE2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210197

On Wed, 21 Jan 2026 21:31:57 +0530, Akhil P Oommen wrote:
> Adreno 840 GPU supports UBWC v6. Add support for this.
> 
> 

Applied to msm-next, thanks!

[1/1] drm/msm/a8xx: Add UBWC v6 support
      https://gitlab.freedesktop.org/lumag/msm/-/commit/50c4a49f7292

Best regards,
-- 
With best wishes
Dmitry


