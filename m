Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF723CAE72
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041426; cv=none; b=phlwNA7lK+Ekb5kfQ4rSMpHRkOrJZTEa5vCeHeyMdkrFMnB9W53bm0jagFe/kpGYyKx0yAza0o0ri1CFJVreWrtmziwclrV2wcXINjz6lIAnM6IeJwCPXgxNdBFDXfthP73NJT0/MHHsQ5vXIwtAnBGAJena7GR3LgT4QIr0msQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041426; c=relaxed/simple;
	bh=Z7UubD0nbMVEh0Y171+jX7DCQQjHM40ZOHv5ApHrDbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6Zl4c2SYblpquESFHdHL5w+HflOg3D+c1okkl/pd19uIBcEbnfGbaTeWn4DZZOA9j7eSfmm6gEQYU1IfJtpZAlVGGVnpooNMeBrvgec2A5ttLjUi6FD2At4yAKaN78W9RRONRsynBq8Yf+azJmzqufdocidtgKCzbClJ7tY/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S6kEBRRb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UZTVAExK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S6kEBRRb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZTVAExK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HBvtc9503822
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YCjoQRyXXAzAPRC76KDlYSqx
	pQjcG8I9xbZRDJMHxR0=; b=S6kEBRRbbcyzoSMMdn2bw1Cb7mf0Q4oBhlHYi3z2
	deMxPkVYhG7ZnRLT5kklgXXiRpiYqxmPIScls4eTq31fpywiCZF4vqFR3Ad/29mC
	t6CwYJWAn78p7cGWzZXAIiaWgRoE1CFQwZ9lpx5crPegy/L42lOC4Ao6Mu8NqIJv
	FFTgLpvyRhGIiSWx7A3hU3xm0kVjDrGP+azwIWbRawqi7uqzEUQyI/Ci54hg7oRZ
	OcMRB/8KlXyw1pNv+wA5w1xw3wO8rjYwopQ8sjyKsKHIXLq2OF+0KWhrOo5bS9WN
	GJ+OWddnloxEvYzxNkk+MvnRxWGUjSYKIkXogHX+JiZnQg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvyubnx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:10:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d5d1c2289so50688311cf.2
        for <iommu@lists.linux.dev>; Sun, 17 May 2026 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779041423; x=1779646223; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCjoQRyXXAzAPRC76KDlYSqxpQjcG8I9xbZRDJMHxR0=;
        b=UZTVAExKftd/L73uyqlOubabxjn8+eQLtnUC+RmhHjm8Dr3hcfv5MJBI9Fh+MGFZA+
         dR2hZzFK2imJcFhgyvL+6hsp9K4Lfa1PCZxQYGg6L8vhHRibEtgwkGX0u60dJq5sJgxv
         4UVKtC2Fw0KqUI1DXeq/0McrbdkUfOdHFP1nAkr09HqsuAxWV+EVzW29RMC0R0/9KARb
         vJs/MzCZOu4V1QHTahlLrdi99mAnicMxP52L/3iHawPiLVFeSNesXbk3/XJFbJ40+HNG
         E2TifcLNTTkR7+9IzMQLBzqj951oFZdiWd8l+3roCQlCEGKvqC8d7H4uagiTUkGib4ee
         bpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041423; x=1779646223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCjoQRyXXAzAPRC76KDlYSqxpQjcG8I9xbZRDJMHxR0=;
        b=bV1f0FkEWcGQBXcz42EQHze3/R0WTVCCwY+sW7A+YkcnNHKunIKme06PVQSQ5pRu8S
         h/IrOXexoR8EGtlvD3n51mI4/4GKLPUYK95UaIkqtyPHddCGYM8BCvmUyvt4p6JxFWws
         +MTXK6J6kn1M3GGNOeymOTrF+AHRWFg9aclWGtQ4JQqwXth7LmfiZhqtwu+4flJKGjUM
         OrwaRQowKKznOK+0UNBoPwRRvplrVTn+QQSpfgbHDtDHMcOPDt7HGN9PUszMhQcVbNLY
         fTa4iiEVUBf7vLfpth49uEa1FQAI5TrB0m9ry0WNqOPj8vBCL912Tpm5TVwGBwXJOBuO
         3+lw==
X-Forwarded-Encrypted: i=1; AFNElJ+6tIxziY6bn4sgYS3mDhrPKRYQE1dK4alj6GrwRCTOlDX/tAHF61pP5ufYwZRRULkopaiESw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTEMrrowswwBm8uyZCYxVY+8Ejf+GKkJuylyvrtVrYy9bzUz9z
	t+0Cv67qF9PCNOFjeugWlhX6ndLi/ycZUW8NGzbd6OM4O2sf7+p+1LiUI79VKBmHBGH5p2F3GaO
	NVILiZVtgtSVKyEN7ReiKQAFen3z3W8dzLAmWjfUY4zSPC8wfMfZyXaZ5vQ==
X-Gm-Gg: Acq92OFGmvzEYSn2Cn78OcxycGjb4xd8Y0xlRGMQWfsijwlI1ZhjW7WtaZT09js9TpO
	50jUvWqfYG/j10T1Wn1FVmFJ/p2lsk713JzZol4b9TWJ3IWizNMg15AnLgg9G0oWJfbkF8z8i/I
	QMWrsE4YYe9Zm/jg0+BSo95GduduSAz1Sw8gjFI4T9C99J/VGCfLaJQMS+3Iy6wWBWT7DyYATTW
	A1Gaf1cFau9oMm2RAdNgxFqalzk0ytFogsXuGseIUOr4zzG5t3I3oVHatdNNBYoRPYRo3d6AMXL
	d3aY8WtKTZXKPSp4XWyLTslFfovAuWc8EGHOFzKx/4YFY3zq4Z58+jePoh5EhOnGgC2TAzasQjL
	4sDMZdlRatCVd2brVRqxywp/TikyoaUXzObZN/+m/2Kt/fjJc3lz/lXCxGexHZnd4W1LfHXivgK
	r0a7j0Jcjv99UTPyil4CkTiw9AkrHwTAJYbIY=
X-Received: by 2002:a05:622a:5910:b0:50d:819f:e7bd with SMTP id d75a77b69052e-51659ff9a0amr171584201cf.4.1779041423286;
        Sun, 17 May 2026 11:10:23 -0700 (PDT)
X-Received: by 2002:a05:622a:5910:b0:50d:819f:e7bd with SMTP id d75a77b69052e-51659ff9a0amr171583671cf.4.1779041422797;
        Sun, 17 May 2026 11:10:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cd939sm2845867e87.70.2026.05.17.11.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:10:21 -0700 (PDT)
Date: Sun, 17 May 2026 21:10:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 11/14] media: iris: Add support to select core for
 dual core platforms
Message-ID: <4g6anygi3vmqomhbjjwlasw2arfvrr4bf425v4ohlatnudz7qk@btriuufbnlil>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-11-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-glymur-v6-11-f6a99cb43a24@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5NiBTYWx0ZWRfXwUtX4n/TEGqy
 QgeVjPhU8QHtZ6FQTzvRT1cIuPLjj2JFjbVC3PQQGMyRDQ+B9Ap+aPXAZuleE/PQx4tDm8vvnUm
 BA9EenL6DFxQIlSu8iwXM70WBmAiSdGFuDydijVvP7bDpmXz1ajxvWtmcddhHuR+PPg0jzQMlNf
 P0U7eKoKlW+PVqa1mjHIr+SbT+DdASIdjYcxEVWopbATOcJmk7R8bTLHwJe05pc+cxyjocUXKKJ
 2ywnLsJMFfdZMhl+l8lTgEt1SXZsIij1hoIzc/dxSvDAKh/hFtyWtOMuIgKGa14FDcvA6ASFq48
 QaLpHr6oeb+MVyz3oVU+EowxFn4Qyc6MmYfNJHHbcs3+/PwoTNdExIKNEsDQzG1K3waS2IL2AAl
 cfE6+wbXDSOBuzloDTT08bzngCfJSrMTjeU/UvZ8SZP7ZzL109MMQsxk1tUjlfMeYlz0RddfJPM
 5R/x5G6N/xDODc5A01w==
X-Proofpoint-ORIG-GUID: RnOSKaAv8H7xm74nRO1GDsS4eDwKhNny
X-Proofpoint-GUID: RnOSKaAv8H7xm74nRO1GDsS4eDwKhNny
X-Authority-Analysis: v=2.4 cv=X5Ni7mTe c=1 sm=1 tr=0 ts=6a0a0490 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=dWoGYy8sgvYCzfpHzJwA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170196

On Fri, May 15, 2026 at 04:51:26PM +0530, Vishnu Reddy wrote:
> On platforms with two video codec cores, select the hardware core for
> a new session based on the current Macroblocks Per Frame (MBPF) and
> Macroblocks Per Second (MBPS) load on each core. The selected core is
> communicated to the firmware via the HFI_PROP_CORE_ID property at
> stream-on time.
> 
> Since both cores share the same clock source, the required clock
> frequency is the maximum of the aggregated frequencies across both
> cores.
> 
> The total session count limit is scaled by the number of cores, since
> each core independently supports sessions up to its own limit.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_common.c     | 10 ++++
>  drivers/media/platform/qcom/iris/iris_common.h     |  1 +
>  drivers/media/platform/qcom/iris/iris_core.h       |  5 ++
>  drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 +
>  .../platform/qcom/iris/iris_hfi_gen2_command.c     | 19 +++++++
>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
>  drivers/media/platform/qcom/iris/iris_instance.h   |  2 +
>  .../platform/qcom/iris/iris_platform_common.h      |  1 +
>  drivers/media/platform/qcom/iris/iris_power.c      | 20 +++++--
>  drivers/media/platform/qcom/iris/iris_utils.c      | 58 +++++++++++++-------
>  drivers/media/platform/qcom/iris/iris_utils.h      |  3 +-
>  drivers/media/platform/qcom/iris/iris_vb2.c        |  4 ++
>  drivers/media/platform/qcom/iris/iris_vidc.c       |  7 ++-
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 63 ++++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_vpu_common.h |  2 +
>  15 files changed, 173 insertions(+), 24 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
