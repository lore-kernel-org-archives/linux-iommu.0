Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE1A3ED5BD
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163136; cv=pass; b=AVMdCiLZOiXs1+vtwcGZidGNBhv8ECyJ2NP73X8WP5aKmOW6Y7rFcSTbYWQzNGmXyU/KyR3wPlAsgTpkeQ10TiDVXbNkYNowbYMbH9AYvG9Q/GAJekEjMzC8npvRekFgcSL9p8RkIgfPBmVNf/57rAHtIYKuZq9RshEfnmbdTKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163136; c=relaxed/simple;
	bh=YDEz/HqlgT2mzMp8AOX3hhutHXAm5UI6pWslhh7kjlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McYlk9DSPNw5TbmEpuhaaQbja0F8OBaldxYuCw2IYU1l1pALBBa6PlPiPYD/xcRX3AJ7V2Yi7iNgMmXoDh3xfjp8cqKUQKd78Fb+QWXHYgHW3aT+RW+sQUIdiQ+hrmLVLV7OBSmiP+3jgzEcnXxFauhs1OkcwLqHe+a64gAro+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mwhIjCFl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HQJqqpXi; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mwhIjCFl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HQJqqpXi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BaE3k682810
	for <iommu@lists.linux.dev>; Thu, 7 May 2026 14:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=ITASyWtze482haPnIkil8QJ16Tn75RV5cHgG/8SP38Y=; b=mw
	hIjCFlAADRB4EQu1PsxvhkWXj++PDxFddKi6BpOGlPqm+c5q/K8g11sZFroe0kbA
	aLrzZ2+uMMMUBqCf2r+2WTpPqU6zZAbASifDUhuwoX/BTXLMlIJ1aHwNxR4xCLJx
	qOAB+OUj3nnAoftesJdhTkB9eWwrjqRoaXGwmQBTh/4CUlZbXNn114DxPvzlgcJe
	uBKuanjqJrU+boda+TdeP+K72lHPUzAXCKW1cmPUc7O/OjbGLc7HzsaQaPAD7YoD
	4oh0n4Epu3NHDkaQwggX4BRSGC1yOQIC7iVdCfDta3ZxXZPjPY1RULUznlqLGIqj
	eDD3tWAKscsCJ74DQXwA==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhaswrh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 07 May 2026 14:12:15 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-69492bc3a38so887986eaf.3
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 07:12:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778163134; cv=none;
        d=google.com; s=arc-20240605;
        b=V18Mt9iT/dHd+u1W7p6PYOag0kTOQdYfsl7vvbz53LNJXoYsgYVUhJpnoAUsaPlNgp
         2NPXR+G4neMaPjKuDcS+q34k4XsrAPMn3DGPOMFzhWjkv43viKji9WE4WxDFXwwoP9Zr
         OjzekMYTEjyeJY6R8jX7Rm6raPCae/HClHUvW2X53VublO6hpNQe7+jusNxRWTO0/Tw/
         NGiJzXYjyl+IiF0uSylz/FZIHllzt4Z3g+YZUJ6FxA+V9UR4+/N0urFzTCClwLev+4nL
         y5k2YfrV75oMKf5+dcbzKkyCGpeG/+mRdKQu2PpN4hDNXSnMEsTDU9fPO8EpdtB/qiKf
         1cDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=ITASyWtze482haPnIkil8QJ16Tn75RV5cHgG/8SP38Y=;
        fh=erOASG14HTCsfjaHxT2MsKObdsD3prsUyffXuJipUE4=;
        b=RpzpKbScAD3+EAGI1vs4AJSTC1toxDcoLck+FHxD0ORFER9X6utBOCMBIBBZpAP0Ff
         mkBFLK/ORwLRk09R7Eea/ALB0sghXxLzoLmZr2YW0t0/MuwUr8kYm1nvyGjbgkEsDa1C
         Rl0bSbJnMpZ93+dcKVk21SzNnWjESPK+a8Y5O0m/sujhpQmMHqCdyJ3qbVSaX0GSg49E
         kyg/rQ2nsBZtLsKNGgZslz0GNjKdtXTdzFHjQQ5RUo0deY1UupqZiVL+9cJZhTW0FFkg
         6iVh7Iv3kDrGcGWDwlE9IY6mTeaySEqMRpdZVF0CQMiW+6DLtgORSxt1BHNXCjBiripX
         DFZg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778163134; x=1778767934; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ITASyWtze482haPnIkil8QJ16Tn75RV5cHgG/8SP38Y=;
        b=HQJqqpXiEovKFIVL3Ur7rYnJuTEoiW6/5eRk1Qx+ssKeDG81pNCr5bxKy+E5S6/bAD
         grJOwJAkLrzDJ2BUgueCMLONBDpsdjorteUC+8R54bRLrS47zlcZfmp6UGRb5CRgQhtx
         yhAddo62eW2FgqYRr5/f/o7FuRxZaAFr6R/TXLshho0Dm0wXQFObv3ZNbfzMpYxxPqDw
         SqUfcvoAQF2Wo0Aq9A47xGVZcAasDi2PsmB42tOWkJ5RLHu3vTKzZzqpOsrB9S91poFz
         Ja9vVpr8k3GaC4k7G4FwbSPYBDd/ZNXnI+Z9MCD1oZoglFnqZH+TEsQoKsG8rkmi/DFw
         T7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778163134; x=1778767934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITASyWtze482haPnIkil8QJ16Tn75RV5cHgG/8SP38Y=;
        b=pD//X0jgMDs1bt043Df3xSogDUfA56WYSgu/3tBha02v1pXOzXe6r4PwIaUZBwOGqO
         rDoH4mKqCzXl2ZkM1Hu+unIhc/B3EwbXAN7oGsj5V/TY+Wj9hCpjWaA9ULk0IFFDKNOd
         ZROuZZZH0eDDeKQCc/4Ya0frzSAKhZJjUwZspKv2uwmB89WTCMDKVrUPisQFdDnngeki
         yM6CNnTcukM4X3O1DeQiAHDZrw2BjdLfRUqRtzfQxCRGwvy1wq82hSPqiPfWS+pDjAXH
         sxQzx3FEaO+s4HKr65xpAd1A1AxX+i8b5Uij395vAsZxEhqdUoAss7NwsMZKf7NZv3bY
         QpyA==
X-Forwarded-Encrypted: i=1; AFNElJ9rZSNLxPGk62BgXfWdOVmPkUu9/fNvYcEoOYp2DXBeWvuEZKuVsZADM+URpH65HLGHykrneg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGUpcBwhn5vB+jYKvoZkvSrMEvnGKRBKYCw0+feW5adJ+yCEcx
	fVEPwKKRfwWrX2jbuYaWkUKJPvtkPMjBowQ/6eiYbVwRn83eCb9GAw+ru/0l0mGd/XDlViHLJOv
	iQu4BswrOBKwHsV0s95UIYwLW3MaK3wbVmstrnbu18to3tY6QmikvnFtVcb+Wn7gZa+lrBDqgxt
	N2t5YtM4363SmoFKNrVklFQti8RlbKCeJKyEGgVBAj
X-Gm-Gg: AeBDievWnS04tPXJnXKd7vXQk3NN5vPLwDvhI1U3AN5D3fMbCu2tFGu+2wjtDJO0izL
	FKbhB3ktpOfUdA7otk/9nKYT10JDXAzDPa2XPqlFi4WfxOc3cYOdS5PX2JQf66I/NSl205wYUFg
	7OrePCFht48Teo9s71e+0okxBRg8tZDqsvtzIYItx1vh1WsH7Xfno0o62L6LQfu7/NFTsJC9s6f
	J6PnaROPgZpi8osKBjXzTDwB4DYhMPJJxyfm8xJ8qMfxcnA
X-Received: by 2002:a05:6820:809:b0:694:9f15:f050 with SMTP id 006d021491bc7-69998d14651mr3951929eaf.28.1778163134128;
        Thu, 07 May 2026 07:12:14 -0700 (PDT)
X-Received: by 2002:a05:6820:809:b0:694:9f15:f050 with SMTP id
 006d021491bc7-69998d14651mr3951898eaf.28.1778163133650; Thu, 07 May 2026
 07:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260325-qcom_smmu_pmfix-v2-1-ba769a6ad0be@gmail.com>
In-Reply-To: <20260325-qcom_smmu_pmfix-v2-1-ba769a6ad0be@gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 7 May 2026 07:12:02 -0700
X-Gm-Features: AVHnY4Is6EZTha6Wq3xD-jFuVZhC7DTDiI_bwm7HnmP4foPGflVn99bdaEXp8Gc
Message-ID: <CACSVV01+yL+fm7oPVp8xQ=XXxvYHq4U18t9Dg0b4g_4H-JeAXw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: arm-smmu-qcom: Ensure smmu is powered up in set_ttbr0_cfg
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0MiBTYWx0ZWRfXws6vuAo9d4lj
 oWPiJjidDs5yt0IiVcJ+4P1yvdX5VG3MMGG9XqiGHhEBpzh1jvX35r2wGZvpe4jicrYGZwudkMy
 bqLf7Xfw3lGyX0bZNPc0A3SJ5hLjQE1EZUvDYhCn6ozPB04iIlIcNM3Ml0UYUxJTtlj/fD1Ntdb
 iDFzK4xD5vQLXmEEe74RCCJJxLnHpk+p5WLx+7im2YXzK5pvGVnsOCy1Mpkzm4TNQiQ9RKiuTQz
 W2c9VAIeNEBvgCX1ws7emCpW+b+ImXSvDirGQC0Oraz/GweNDb84idrGm339P6WwVFBTm8Se/Hi
 NJSLFvH8laDSshG/RslGVzcEb2KLcaXy7CC6JH/PuIBbP/gGt5l5Dzv4p/xOSrp9531V3yt1Rjk
 Nd0FYxn7KIiFULwkBVEEhIqpRH/thR/qOoHjbzkBwTcn1vpb3ijwL+3vu5nif93xms6gQhO9S1b
 rXHrbQlXGbodqQjlCLg==
X-Proofpoint-ORIG-GUID: hJiSawiBwXUTcdLuL_mpiBRpa7AXCfzL
X-Proofpoint-GUID: hJiSawiBwXUTcdLuL_mpiBRpa7AXCfzL
X-Authority-Analysis: v=2.4 cv=ReWgzVtv c=1 sm=1 tr=0 ts=69fc9dbf cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=KgnJN8VTlqKxrJ66Oa4A:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070142

On Wed, Mar 25, 2026 at 2:11=E2=80=AFPM Anna Maniscalco
<anna.maniscalco2000@gmail.com> wrote:
>
> Previously the device was being accessed while potentially in a
> suspended state.
>
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

> ---
> Changes in v2:
> - Simplify patch by acquiring device just around the call that needs it
> - Link to v1: https://lore.kernel.org/r/20260210-qcom_smmu_pmfix-v1-1-78b=
7143ac053@gmail.com
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index 573085349df3..cab7d110aaf5 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -231,6 +231,7 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void =
*cookie,
>         struct io_pgtable *pgtable =3D io_pgtable_ops_to_pgtable(smmu_dom=
ain->pgtbl_ops);
>         struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
>         struct arm_smmu_cb *cb =3D &smmu_domain->smmu->cbs[cfg->cbndx];
> +       int ret;
>
>         /* The domain must have split pagetables already enabled */
>         if (cb->tcr[0] & ARM_SMMU_TCR_EPD1)
> @@ -260,8 +261,16 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void=
 *cookie,
>                 cb->ttbr[0] |=3D FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg-=
>asid);
>         }
>
> +       ret =3D pm_runtime_resume_and_get(smmu_domain->smmu->dev);
> +       if (ret < 0) {
> +               dev_err(smmu_domain->smmu->dev, "failed to get runtime PM=
: %d\n", ret);
> +               return -ENODEV;
> +       }
> +
>         arm_smmu_write_context_bank(smmu_domain->smmu, cb->cfg->cbndx);
>
> +       pm_runtime_put_autosuspend(smmu_domain->smmu->dev);
> +
>         return 0;
>  }
>
>
> ---
> base-commit: 50c4a49f7292b33b454ea1a16c4f77d6965405dc
> change-id: 20260210-qcom_smmu_pmfix-2aead2ba4e20
>
> Best regards,
> --
> Anna Maniscalco <anna.maniscalco2000@gmail.com>
>
