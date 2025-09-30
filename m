Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867842F39D7
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220881; cv=none; b=QIN4Bnjx0laSB/AI2tew9+AWrDFxq1/UkQ22juCCzSMiNSzbEwoMugXqJ9Jq7soxWoTGJ1IhPtV3G71o1VyNb5K3uPoqBm/pdvHknxFcsLRc0W01quZ6bPMKgn6IUoMs5YJpq6OXGcBD9BVM4jOz0l7DBVMFQCDZCNQKiGLDSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220881; c=relaxed/simple;
	bh=rPh3kRVZ4h/rrupdBcJxTF42eQ6u5qVrD5lU2D2cpQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANvLKOCCdL9qkCndE4qHtsr6SR3KjHC4n62sypHdzOrwfmUMvWIksNSUA9z75QDqiLhUlcMtVDl56Pp698Cu5d+UW6AmOUOUe1AskPySYE0W6Dz3FDNRJlvrClpXAdzGbOyUfE+s6LyZVUZ8VB9FkZQx5Raevhrg1LthmbF4tiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GKXn4H+9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GKXn4H+9"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HOjH032518
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 08:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=te/ZoQVF9PRW/Vcak1agQLB+rzLOMt6hZjDiPBIvFPo=; b=GK
	Xn4H+96BGGnzBwd5vTeveqmwm2+ROJlE+usawWAKSsuwebQBlbNMkoDT5ysh/2l4
	j4KztS+NSFkvSI/GoyRcLqKba4lJme06Y1FICjT5MBx7/+CrgdoW3XwpYr7YSidn
	I1nUCog2rCBgFD1rZhjDpcPxcQD2IxHtkg2mzlCbWP9bOWLCXVCAOuXyWTqmjZaX
	DPprIu4mKijgTo3ND894o5PR3Tyf4tq0Vecl3JsrqWd4G76MwlswbzRViTdcWOJ1
	WTG4IvyGi6P7WZE25Hoxm8TqpJsgvKYuw9hR69Nv47O0kBo1PxgimsBuP7cCARq7
	nqi4JQnq21omtIlpzbEQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr3rbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 08:27:58 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-43d3063f5c9so1052460b6e.2
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 01:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759220877; x=1759825677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=te/ZoQVF9PRW/Vcak1agQLB+rzLOMt6hZjDiPBIvFPo=;
        b=o9fmGqQB9S+TqNbWIxOne+TQCkgl5Z+pAT0kP5vAnCCE0hYN4GlCXO/ee4s1wYycKJ
         OmrIDy3T11a403bV+3VIFFWLw/bht3OQ97dTCZjBn5NWSoZHhmZ6/qyBDCRHSrisV808
         3HP7EThZFzpjYyNyvVCNKM2W8jpOGnLf3kKCq+os6/vFRtGkxhGrhx6cfDUbxnJN7a3s
         w510JIrVIFF1ZlwJ6NLBCsyYhBDTH12tOx8Kq2ByEGUuhZJQ90zdGE/8CyjmJW3o5hSk
         1qZC+h/oET91WnllhEtSF7F7siYP36BAbdEdsz9I49720YbW1se7u8uhsbFR5AKnLXgb
         nlUA==
X-Forwarded-Encrypted: i=1; AJvYcCXpEbE38MSxRSL1YWcPlxPSlE8VPPfCcqDEm/wrSwmtJQ/hSU+plE1flwJbndoQ8tVhUDbJPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFd+U2E42OWXtrnefhGLWQrLZIzCkiM11Ped34BaNc+cRTmXRv
	QP6M8Ned3ALHKQgW6UBT9/Z8jibAMvhYqIXdfxYmgakcp360w2ZBYUgsNyjniDm+GNsQsLcqe15
	hfKTtURvYZQR2lkNxVHnFDfDhozlW/DpjF3bOFhPkv/xn/sFj+Y78Egn6dSXpB4XaWsMCYvG+BW
	krNeZZ/LsoItffM5PBo2Z1nKF+/IkfDDHf
X-Gm-Gg: ASbGnctfE8JhSnOlxfrp9PA2UP22T2mnKiTmvQG7ecifcsRd4+EWiKUCQmDQZdcH9Oz
	Kc8Ix7Mcnlm0dEhYOT061UxJa58JGDG59VHmQU7Sl7tXTXikdNOJ9hvaShuip5TD9JmnaQmpHT9
	RpkJfn9wmJT1kIqlXjK3ZxL19EOjsauUI2RJSHf8Or6/0ttj/3IiIkO5o=
X-Received: by 2002:a05:6808:4fde:b0:43d:25a2:e28c with SMTP id 5614622812f47-43f4cf464f3mr7573987b6e.49.1759220877228;
        Tue, 30 Sep 2025 01:27:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH814E7mWrVlAtwKKyT7opGmi1FUZDDSJRR4sEXqt85rC60tExf6mnWRjS+3W0gCgMI5Vtl3QqcYmH2Ktkkf/U=
X-Received: by 2002:a05:6808:4fde:b0:43d:25a2:e28c with SMTP id
 5614622812f47-43f4cf464f3mr7573965b6e.49.1759220876731; Tue, 30 Sep 2025
 01:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com> <20250930-kaana-gpu-support-v1-13-73530b0700ed@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-13-73530b0700ed@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 01:27:45 -0700
X-Gm-Features: AS18NWCqmbEpRBm5ANsrhcq-Z8jcjiekBnhyIkewW9_rwgY5GXXogY_b-bdPSxU
Message-ID: <CACSVV01UygpiUj0m_Ppd_LSxvW0MFunz+Lfhg20XHR7vyOBx7w@mail.gmail.com>
Subject: Re: [PATCH 13/17] drm/msm/adreno: Support AQE engine
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfX6XrQtj7rwc9e
 FItlNBjEl7skMB9OXx8alBrvpCZASSvPDKxh1Szb6g2eItLvJyKHSOA5aGfWqGYGkK0ira6DWOR
 whIi/vhDQuW/Dms83Lfz6Ungd/orNrJovS4/2SeeRL/HlDVpSZ8zGdeodg9yav4dl3FoXVCZU1P
 UeJ+FPRZDNOBLj+o1dqloNk2X6uhbyQWX9niEQzkeOF5gYRZ/VWQBLyhX0dRQlT3gaWu49C9OJ/
 KX4oq2EPNJ5vmB6VpDIkemDc9gm1u/5BvSo+bw8eVvlsc5GzpkUdHBIFJlJeQobT5S1mzwajV/n
 KF+ocQegRWcs04OU31R0j9HGxDsMuLHV+TLNu1GxuERZc54fEAj7r48tGbmUJmTy4VTxo2EyzhC
 bhGj5DoH8pGKuT/kyEks6HcJyr2eAg==
X-Proofpoint-ORIG-GUID: r4snhdUfOK7wukz65rguodzEkp6QdnFn
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68db948e cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=fhJ7XYdx2Z3gjWMZPJIA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: r4snhdUfOK7wukz65rguodzEkp6QdnFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082

On Mon, Sep 29, 2025 at 10:51=E2=80=AFPM Akhil P Oommen
<akhilpo@oss.qualcomm.com> wrote:
>
> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
> in Raytracing related workloads. Add support for loading the AQE firmware
> and initialize the necessary registers.
>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  2 ++
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c   |  3 +++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>  4 files changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 4aeeaceb1fb30a9d68ac636c14249e3853ef73ac..07ac5be9d0bccf4d2345eb76b=
08851a94187e861 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1093,6 +1093,30 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
>                 }
>         }
>
> +       if (!a6xx_gpu->aqe_bo && adreno_gpu->fw[ADRENO_FW_AQE]) {
> +               a6xx_gpu->aqe_bo =3D adreno_fw_create_bo(gpu,
> +                       adreno_gpu->fw[ADRENO_FW_AQE], &a6xx_gpu->aqe_iov=
a);
> +
> +               if (IS_ERR(a6xx_gpu->aqe_bo)) {
> +                       int ret =3D PTR_ERR(a6xx_gpu->aqe_bo);
> +
> +                       a6xx_gpu->aqe_bo =3D NULL;
> +                       DRM_DEV_ERROR(&gpu->pdev->dev,
> +                               "Could not allocate AQE ucode: %d\n", ret=
);
> +
> +                       return ret;
> +               }
> +
> +               msm_gem_object_set_name(a6xx_gpu->aqe_bo, "aqefw");
> +               if (!a6xx_ucode_check_version(a6xx_gpu, a6xx_gpu->aqe_bo)=
) {

a6xx_ucode_check_version() doesn't do anything for aqe fw (but also
a6xx_ucode_check_version() should probably bail early for a8xx at this
point?)

OTOH if over time we keep growing the version checks, we might need to
re-think how a6xx_ucode_check_version() works.  But that is not a now
problem.

BR,
-R

> +                       msm_gem_unpin_iova(a6xx_gpu->aqe_bo, gpu->vm);
> +                       drm_gem_object_put(a6xx_gpu->aqe_bo);
> +
> +                       a6xx_gpu->aqe_bo =3D NULL;
> +                       return -EPERM;
> +               }
> +       }
> +
>         /*
>          * Expanded APRIV and targets that support WHERE_AM_I both need a
>          * privileged buffer to store the RPTR shadow
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.h
> index 18300b12bf2a8bcd5601797df0fcc7afa8943863..a6ef8381abe5dd3eb202a645b=
b87a3bc352df047 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -58,6 +58,8 @@ struct a6xx_gpu {
>
>         struct drm_gem_object *sqe_bo;
>         uint64_t sqe_iova;
> +       struct drm_gem_object *aqe_bo;
> +       uint64_t aqe_iova;
>
>         struct msm_ringbuffer *cur_ring;
>         struct msm_ringbuffer *next_ring;
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a8xx_gpu.c
> index 6a64b1f96d730a46301545c52a83d62dddc6c2ff..9a09ce37687aba2f720637ec3=
845a25d72d2fff7 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -599,6 +599,9 @@ static int hw_init(struct msm_gpu *gpu)
>                 goto out;
>
>         gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
> +       if (a6xx_gpu->aqe_iova)
> +               gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->=
aqe_iova);
> +
>         /* Set the ringbuffer address */
>         gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
>         gpu_write(gpu, REG_A6XX_CP_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index 6a2157f31122ba0c2f2a7005c98e3e4f1ada6acc..3de3a2cda7a1b9e6d4c32075a=
faadc6604e74b15 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -27,6 +27,7 @@ enum {
>         ADRENO_FW_PFP =3D 1,
>         ADRENO_FW_GMU =3D 1, /* a6xx */
>         ADRENO_FW_GPMU =3D 2,
> +       ADRENO_FW_AQE =3D 3,
>         ADRENO_FW_MAX,
>  };
>
>
> --
> 2.51.0
>
