Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A6810E0
	for <iommu@lists.linux.dev>; Sat,  5 Jul 2025 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751738717; cv=none; b=qVutSPCswuftCmXkjwTrw3RFZVK6iOQZm7vnDhy7B0tOxFekewrHdqYlcDe8aEZpPvOqScT1pkAEa+JhWJ0a8eRnRryAYg4ed/5yYa04O5bDtIK9yIpk6i7NkR/bSA1ndQbBhouMQBLAHKe/7UuFzwkPXAAty/wxYusKx3fT0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751738717; c=relaxed/simple;
	bh=XQVGIRJw3+xHjhRPG4C3JVHMVjLczj49kVy13S2Zu2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YT+0Flqb/v6Zyzj+1grEYb4y8rXGOliDGt7V8fJjvrRcOeRgRgq+cSpb62m2JUGsCPMZBS5cAqP3XX+KI20oBkcB5IJqAtXZeZ/Da5Sm4LExMHgV3yau7sEcUfXx29naLQJfFUllxJiYsTy1cv7OEJWhcFY3PFIhIHOP+pD4ZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UjFY4ojF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UjFY4ojF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 565Hs7eo000469
	for <iommu@lists.linux.dev>; Sat, 5 Jul 2025 18:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=V6PpfAkChLbMwzHqqroOnb6IX10ZpWIFhKKMDJenfD8=; b=Uj
	FY4ojF2Ye/5mhZp9iOid/+tD+pwhZVz6wxJ7h0gdl7rcImRU3ka3jIiSOea2/0OK
	2vz6zuVkPLaSN3TogUTjNqD9E+2kD/chZvWsvmAv9jEAInCf6OjqX8g5w9e2tt5T
	qvSxpfXp1KcIizeWrBoIpUY2rd4BWUBpwv90EOehUa2b35t+3eIHiE7XZJ7vCWo0
	FL7dowoggiAgwZe9JFCyOTBr+c6xa8gVoV8Cj1SEYEj9T2DcjHRB/+t2bJWsYQ2T
	Xiqr9cTS+ZNeNDsSWwzOROMcsyTp2fxUDKOpOCExl8soAvJH0xlV7OvLtO4cZ2kE
	b94PUM0kviELH2Dt0C/Q==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrk1s9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 05 Jul 2025 18:05:09 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-40b0a248ce8so1492217b6e.1
        for <iommu@lists.linux.dev>; Sat, 05 Jul 2025 11:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751738708; x=1752343508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6PpfAkChLbMwzHqqroOnb6IX10ZpWIFhKKMDJenfD8=;
        b=tTYYAZIEkx6l8CSTE7JQfUCnkGJN7t0TXArCoruXxjgWYr/9l4Wb38fmYafXZdaAhq
         yA8itSujYDbYvR5eErZb5/DmGLphYFRy2+5z1hduClP0k7BHTYuLZzjZdoIeH4y2+GhV
         MBGDTZh/P0Ws4HuHUQ2d2clD6U0vDvhe+feaMVoCBIayeYBOlLYsxYwC+/ZZU51VnwFS
         LQIXDidUoqzeL0AwzKg7+v8VTjb9U+X0NiXqjVspC+IVB0VL94N8Q7m5MnMAXAft6A5V
         2TmRCjVD1a2ZsHiP3S8dpH9vHdADwkDIhYjzvON+G/sl13V6oDI+tsj22Ad7SR/g55za
         /9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVntfk/lnMVpIPvyM9WgcFvpVoafui44s5M3kVDjaLlu1M2Ig6RfHhnLu1ahJhBqadll11d2A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz79ax1tyhnN2UnNH0/X9+9X1FkJtozFO4EpQ+CmuEHoQK6jWhh
	avuD9M2Cc7mtonCAGN2j52PXf1BmsBbex5mS10+/563vT5HoTOq6SnRjZvLDg5O2wzeffViD5i4
	3nAC5kpoYUzeFI7FDT5XlPHVYtYzhBqp/3zY1PcZglLymRJxnnF7xfYab37X7MhsAovmwCXbac/
	QGtG6oQJKinvTMheNoY8omLOnWfk+idEEj
X-Gm-Gg: ASbGncvQaN00hKzN748r2nr0NOWPLa2ZzDhJbRozcc4pBCcKT8o5iZDy+P2bC3y3f1c
	PU+IKdh2L8JZv0xMV23g/ZtMAaCyJuK9l4L8fY1Rl1sLz/u3snZZwTFFjVTrW+Lq9ES/ALohPm7
	OdNsQlDxpwjTunLObik8W8pZZm2WcmUpN+Q8k=
X-Received: by 2002:a05:6808:2227:b0:406:67dc:85e5 with SMTP id 5614622812f47-40d073ed168mr4931752b6e.32.1751738707910;
        Sat, 05 Jul 2025 11:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA1V6eDhxgL68PhGByEGdZ2yGlPoePdjpJUerLbX2cT9JRZ/ymGxWYtpk/nq8tCGPhn0PxFjOVFmscNcrUN+8=
X-Received: by 2002:a05:6808:2227:b0:406:67dc:85e5 with SMTP id
 5614622812f47-40d073ed168mr4931737b6e.32.1751738707518; Sat, 05 Jul 2025
 11:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250705-iommu-fix-prr-v2-1-406fecc37cf8@oss.qualcomm.com>
In-Reply-To: <20250705-iommu-fix-prr-v2-1-406fecc37cf8@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 5 Jul 2025 11:04:56 -0700
X-Gm-Features: Ac12FXxPGf3OtS1hFIiu8JcWUGDwoozM4YEfH5zfdc7rWndBMdlpthog4m8uuIE
Message-ID: <CACSVV03E5QZWuyiejY0BkecQbnLFYCOD2btW962XRJ+n4-KfWQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: disable PRR on SM8250
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: EZE7LwDDiHWHv9lhsR4gfz0SFNr85P79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA1MDExOSBTYWx0ZWRfX+ghIAWOyetbG
 7HRQFX+/TmuK111dytjZyAe0L6LGvOMnk8ANwOZ/ZYAmGBpYKCJoglS96IV3ProqVLQ+Q30QX+p
 xLsMWSp+cVct/w/b0CRU7EWvqivApqYPjIvP4D1R8b8G97CDbuq4hsyFFhL7bgvTjefn4ca1m7g
 tP+/ijK6hnEnfnbZTtP5XBkBLjbWaq6qU02jyP/AAcgiq6DVXW8g4yV67lIIJzoyfE78A301wRG
 PvyibvtYYSV39xooUKmlOaNGFkHeNGUjLJIVcF7mm0+9fmSfTWx41l7Zusl4BLF6fFUUDZp1pZD
 POLSLeDPrp7g+6Zetu/S5Wd1F6Q+rGp7A03OpDn51uHUtO/oUieRRlHpU/hQ0b1YEOsG/BFTluS
 nt95x6nGT8+s2QkHN4pbiEJX7LAt23hpaSaB1hMv2x7goSSfaIBHBL0yIoywCDEi8sGu6YC0
X-Proofpoint-GUID: EZE7LwDDiHWHv9lhsR4gfz0SFNr85P79
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=68696955 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2B00_WpXKG7Y0WWvpoAA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507050119

On Sat, Jul 5, 2025 at 9:08=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On SM8250 / QRB5165-RB5 using PRR bits resets the device, most likely
> because of the hyp limitations. Disable PRR support on that platform.
>
> Fixes: 7f2ef1bfc758 ("iommu/arm-smmu: Add support for PRR bit setup")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Rob Clark <robin.clark@oss.qualcomm.com>

> ---
> I currently don't have access to other devices from these generations.
> It might be necessary to apply the same workaround to other platforms.
> ---
> Changes in v2:
> - Simplify the workaround as the issue seems to be limited to SM8250
>   only (Rob)
> - Link to v1: https://lore.kernel.org/r/20250705-iommu-fix-prr-v1-1-ef725=
033651c@oss.qualcomm.com
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index 62874b18f6459ad9a8b0542ab81c24e3e745c53d..53d88646476e9f193a6275d9c=
3ee3d084c215362 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -355,7 +355,8 @@ static int qcom_adreno_smmu_init_context(struct arm_s=
mmu_domain *smmu_domain,
>         priv->set_prr_addr =3D NULL;
>
>         if (of_device_is_compatible(np, "qcom,smmu-500") &&
> -                       of_device_is_compatible(np, "qcom,adreno-smmu")) =
{
> +           !of_device_is_compatible(np, "qcom,sm8250-smmu-500") &&
> +           of_device_is_compatible(np, "qcom,adreno-smmu")) {
>                 priv->set_prr_bit =3D qcom_adreno_smmu_set_prr_bit;
>                 priv->set_prr_addr =3D qcom_adreno_smmu_set_prr_addr;
>         }
>
> ---
> base-commit: 7244e36657076b597ac21d118be9c0b0f15fc622
> change-id: 20250705-iommu-fix-prr-600451b1d304
>
> Best regards,
> --
> With best wishes
> Dmitry
>
