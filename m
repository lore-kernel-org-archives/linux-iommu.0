Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793460547;
	b=1BqUZ4T+nvypZfhH5p7CuJWTg6N55X/D2Ao0r9N58ccqlEBdPb2rl1d6oKVASPLtD+6P
	 s6MnFdtogWRnDOouBq1/1pH9k9Y6+Zj5zFUEUQeV4Rro+Fn8m5QSWs1n8O+ziOwGFg/5z
	 G6CI7/G65NuIUiPONcf5XkpWF/PuInskLVrPy3cBP+1/fKSFK0vEh4oQlu61d5U98di7V
	 2LsZJwX4P10deL9OJMSNqMY5HyfsusUcKwpc8SLd2giziS4u87DiNqKnhBnuss3BXahSp
	 NFSLHynd+vNuv1qpFzpYR5bNr5Diy+sxHxx9VXGMbwS1JJ5GEnsN0tMtCKCGfXhKoHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793460547;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G1Nk/k41lamrFq3GiW5/pY8VVOCflUacaIYb3As4YkQ=;
	b=Kqkjmu+CoocDK0/jp5Nd5vC4Cx8gKVgkfC3629LAn5F0z6362Ma7xiWm2Vuajg5SwfgJ
	 CrOE3NVC9Wqt0KU8LNdnqitv8w9wjelR/GyQ2cCVMn/pp37Zc+EMY5TE2N2mrVjCIXqM0
	 /2ZPUe0tl3c4lNrTCrtwLT6xdKyZs5C4OEezOZvhJPdUtmhGFxhCXMxPOEH9C+fAUBTeB
	 6m24dRZPUrO7TMQjvfB0gHOB+a+jPanXg+5L49KxtlrhY6PIz82vQOGOT6TEo9O/JyFHs
	 gyp2+Wr+Bhtft0cvTA8/AEPCNE1MUWU/LUC4eXad6QNeDVowsyIaB02rQeR5r/dJ3cQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPzPh+nf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QmfHXzhc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60925606A31E
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60925606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPzPh+nf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QmfHXzhc
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VCxwne3208251
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=G1Nk/k41lamrFq3GiW5/pY8VVOCflUacaIYb3As4YkQ=; b=LP
	zPh+nfIzFd9fvW+meizE5UlI/0/gV0oPrlbstmsUtnFxGsxSoN27y+3U/Rat0TUq
	2RDrhPMbxk5+kF/bb1GWKDQo9eJ7EslmLQSFOYlBId/QwEchdAwYlIfybEOnEDvR
	1hRu8c6RXGz6QtnG+rFkhj0cbrrfRM68Ewfn9/SBKkt5jEGjsjmDnQSfIP9rL4By
	RGPafwQ4PMyiYUhc21eNPBFMuirKVTbDznmuTyNVubAt1YCSlZjsfVlrkbjyltrp
	NhO++ptbdQLQmy+3zpBKRZ2KYw+rBfIAndeAqgDTGB0YRVxuM4+9Dbk9TVpokYbR
	CQTOzgD8I62VCMLVHh3w==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn79rshw7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:29:06 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4574f1cac98so1949032fac.3
        for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 08:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793460546; cv=none;
        d=google.com; s=arc-20260327;
        b=eLemsgYB4ofulXC5Q5tGSvbRxphYnyqmUWuPM88CWXjs0fgJH3tQziRH2fxl187jbt
         7YV2xmc+aNmftzfLBzBM9x/jeM0GRywoisBHZKxnBukWVfRWhYijMQj9BOk7fUv6+BeN
         skmT6FCDtDKUf+Sfc+o3s9302Sz1DNRvCRkrqJun7tlleuyWjR4y3bfHq28s+JTWHB4L
         DngLJ1++oMaYM8w3ClgKCW4V17eqKwW+OkMGjkAl2RIZZJeXFOm8+OUEj/I2fYqCY7z3
         bcGUNTMOF41b9vL8+L34TTzr/VeVRnp+4wpn7ewWOqdvk9MJKqcT2AAtFqsHhUUqkDKQ
         0dBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=G1Nk/k41lamrFq3GiW5/pY8VVOCflUacaIYb3As4YkQ=;
        fh=fwljRNd6L50BUlDbTzmCiJtEusnzTy4a72svajv13uc=;
        b=MK37ySZjUl6ixfd+wKj3K0fb9pYBmhjayPzvVhA9SCf9vuJ317oiVWLFlPqBd8iYUa
         fwSeos/nXyC2IN/vvUWjaVhAQL5RlvvkUc4C1IdkfciQtXqEwDz4xZF0cgDUmkRMPDFr
         rXH8XrBmklSYjbBrNcwG+KAP3SxaALLnm7ROaVqoMv/A6bVozvZ5omsK0lzz45PlVuTt
         KH83NxwoJ6ZUWFvgCKhNKkKDVo3eyGe8VJyO3dHvVC8zreBvHft+QZsIgdmJCwnMyUBp
         LKQIYCYB68SOGBR3xcheVXCb+2whizU77FDkCig7p/x1yn3z5Ti5Qso1gU/mB0/GCBus
         PsNA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793460546; x=1794065346; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G1Nk/k41lamrFq3GiW5/pY8VVOCflUacaIYb3As4YkQ=;
        b=QmfHXzhcOezwdtoNgZXRYgzAuinaU/8QRWk/hVSSRqe4yRDxVVzeA34s4B71f/FnJV
         kcUcvQ7qOh9ofBzIAMSK1cJ4pbmYk4GjkHca/K7zQhxtuHqex0OV6nD5ZorDppO7Mhey
         vjT786eML7VLFCVx3WXZnnfU4yo8J9gumLU3+RlCwF6QpVZtiBiCjg2mKtfUnXXVFXOt
         D1sY8o/urCkloiyAPYxby5ZS3vGI6i4tlMo+EUShgyVdus2HbOvzkcM2Uy8jERHfqdXp
         j/ZwAjI4XRdQrUY2oBrj0pNvetNeM/XofKK1ZAvAx3GzbnOABpeoDOmcrVSIDpmsvfit
         03+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793460546; x=1794065346;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1Nk/k41lamrFq3GiW5/pY8VVOCflUacaIYb3As4YkQ=;
        b=qhepDuUQls3G8ITHpsfSwD5j+MFgJ3AThkcDz+XrZk0YFVcvhvWeOQZmiPgLLXuTS3
         MtmpYFIKTTjh0TytqrRDsLkWVSueAp55g3OuogksMvksowJxyheOIhF8QyoFb1DHN5fX
         /wWb1/d4Cujc2hJPRQvmITTjmLl6kBxOS4c9TXw6WyGlJ2XRcUnm9575t8nObOztvlgf
         tCRWIfUMW5As2l2ZRhD7UugVhYfB1csXgN1vr/Vn3aOsT2vBZIUfUzw0seyfYzsHRgLa
         xFNywSPuqlRVaftKjTfLH+IyeMH4efOo1IgpStgmGJigVGHG2phYaLRHReiedZGdwBUu
         Sdkg==
X-Forwarded-Encrypted: i=1; AKwUvBysknuo7jq/m1MpiZfxypTbX3pdOYykgaIeDpMkDZWv4Ff9L8j31F+1Dyk23o5m8j+Hi+0i/w==@lists.linux.dev
X-Gm-Message-State: AFq9FYLN6TYcg7hPHplt9lGPRsB7Q/KNoYrCya4Xlbdk3UCLGA4EiyoN
	snHoV6zqFuWAQ4XxXsIc6zlyx9q3SHh6mXaGaW3mWhSSfOIvEJgYoO7eK2ldd33qnhardwRpBlk
	5dM4RQh7PWnHXj7ejisMSleFtzc/uUBeQZi48ssj3yTuyJnBZw60kYkY0f4xjOfgFlrcS0kT2RF
	J/dDJp35TvpWmuTSCk4lMcXY/DJllrXo12
X-Gm-Gg: AYBFou3lhrBLosjp2fHyYUAQ0cEBg1d9F7KIc6cFCCZidOeLDHor5fjgi+C1XTsYS+s
	vX3KdwECWdqGqcN2kTeCtUX9WlQIdcCX1gcndvEdFlCG4shbRWfjWYpt/ZebzmW/WNIXdbX5PDe
	eRdePrRED9Lgm23wUwhJvt0LtN9L7LIXo+63M2oQAZrE+s+Bi85LujYuZOBw==
X-Received: by 2002:a05:6870:5d8b:b0:499:6b20:13df with SMTP id 586e51a60fabf-4a9076f83e1mr3424975fac.30.1793460545593;
        Sat, 31 Oct 2026 08:29:05 -0700 (PDT)
X-Received: by 2002:a05:6870:5d8b:b0:499:6b20:13df with SMTP id
 586e51a60fabf-4a9076f83e1mr3424958fac.30.1793460545051; Sat, 31 Oct 2026
 08:29:05 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com> <20261031-msm-smmu-identity-v1-3-a2a70580eebd@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-3-a2a70580eebd@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 08:28:54 -0700
X-Gm-Features: AclHuK8hrKHo1tqy_PdKqenLScVW9LO6f-Uam7iC-EUaQnDV6_oiAmGdMYjg4CA
Message-ID: <CACSVV00vH_tpQpDY9WX04FWe0Wf00t6ytKHwYB453Et5RP6AAQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iommu/arm-smmu-qcom: Use identity default domains for MDP5
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: XmotU7HlINQdrbs5Eiup9QwiAgbUTo_n
X-Authority-Analysis: v=2.4 cv=Wtq+otfv c=1 sm=1 tr=0 ts=6ae60942 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=sUSyc032qo6c7neFus4A:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2MSBTYWx0ZWRfX8J0KohaPvoGm
 WvPkhbFo3tuaIx7sQZ6Y0/guGDJkktZ4QSrOHBvaUNM5rhpCOOJOT+LkL1t3yFWv4EdHeciCGO6
 7z98IVWuM+b2YDIYHYbGzk5Cmi6/cjI=
X-Proofpoint-GUID: XmotU7HlINQdrbs5Eiup9QwiAgbUTo_n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2MSBTYWx0ZWRfXxSBwZUa7Pze1
 ZL6+4SwqquUn/HV68UXL4AmwBH7YLa7qGPQnkaniX0gbOHJniOJ4uMuHiUT7Hbclh51SUAOaLj+
 wzWaSlcVLZ5MiKZdDfGRKO/HjMl7nvZpVK+uH0Rye27schNklPw/DMvnEXbwdWF0yvMiXA6Goje
 bLWI3cHpKjbvDZN6QY/BLO2eS4GQVoIQRZLdDHJghv+XzIWf6L0lXkPIdiSD3OQahrXZaQGda50
 SofXrqpV6ya4NcdpPRx3xZm2sL7B4YGf2H2lDwT2A83gC17cfPoIvwsKJb6XmTg5AJS3TRdlXBp
 rna6R7hqwY5BI6weoy33D/rqLtAvZCPg4Tmyzp9jR77AdTPNtHbBTeyB+jk9XcCsF8dMNzrpKK5
 rTZ6xB1Dya3T0XJx33BmCEobnju+fOJEoO5qZzbX+6eZuKJwY8yNVPEpG4wi2hhVTd1qk1/omUZ
 2UylvpeVdJoJXRadREw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310061

On Fri, Oct 30, 2026 at 3:05=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> drm/msm writes the addresses dma_map_sgtable() returns for the DRM
> device into its own page tables, so they have to be physical addresses,
> i.e. the device must not use iommu-dma. On MDP5 platforms the DRM
> device is the "qcom,mdp5" node, which is missing from the client list,
> and the msm8996 MMSS SMMUs have no qcom impl at all, so the device gets
> iommu-dma. On db820c the SoC then resets as soon as the GPU starts.
>
> Add "qcom,mdp5" to the list, which also covers sdm630/660, and give
> msm8996 an impl with just def_domain_type, keeping the bypass emulation
> out of it.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index 795e8ec7e8fa..addba9074217 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -408,6 +408,7 @@ static const struct of_device_id qcom_smmu_client_of_=
match[] __maybe_unused =3D {
>         { .compatible =3D "qcom,adreno-gmu" },
>         { .compatible =3D "qcom,glymur-mdss" },
>         { .compatible =3D "qcom,mdp4" },
> +       { .compatible =3D "qcom,mdp5" },
>         { .compatible =3D "qcom,mdss" },
>         { .compatible =3D "qcom,qcm2290-mdss" },
>         { .compatible =3D "qcom,sar2130p-mdss" },
> @@ -642,6 +643,10 @@ static const struct arm_smmu_impl sdm845_smmu_500_im=
pl =3D {
>  #endif
>  };
>
> +static const struct arm_smmu_impl msm8996_smmu_impl =3D {
> +       .def_domain_type =3D qcom_smmu_def_domain_type,
> +};
> +
>  static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl =3D {
>         .init_context =3D qcom_adreno_smmu_init_context,
>         .cfg_probe =3D qcom_adreno_smmuv2_cfg_probe,
> @@ -711,7 +716,7 @@ static const struct qcom_smmu_config qcom_smmu_impl0_=
cfg =3D {
>   * there are not enough context banks.
>   */
>  static const struct qcom_smmu_match_data msm8996_smmu_data =3D {
> -       .impl =3D NULL,
> +       .impl =3D &msm8996_smmu_impl,
>         .adreno_impl =3D &qcom_adreno_smmu_v2_impl,
>  };
>
>
> --
> 2.47.3
>
