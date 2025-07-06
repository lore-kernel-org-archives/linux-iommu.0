Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C314A09C
	for <iommu@lists.linux.dev>; Sun,  6 Jul 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815235; cv=none; b=EIUd9PJG9p1CK9uWvR/rCiVq/zwYySNTmCQQtBMJPpicUZQraXDeV2yNBgXnM9lzmJCzFNQb4+PhZCqDym2m7afm1pIvZUG+gkpJl7OUBvaEaKPPQXkgsaV8fnDisFASkvsn5WlYiy3h9QXVUc+5sfbBPMWUhg9SeUYTXBEhZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815235; c=relaxed/simple;
	bh=+z1wjg10ZMq9xbw7PHPnNseuKsBQ72DoDrEYmBvqDy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlG+WFfBFe8FYOt8mhuKAQJXlM0OWp1GzADgdLvTrsFoTtCvEbhhl+w2+LNCvyLywqNIsp1rQy5/pGmMosjeq13yUwVG0ivh5Lqddzu0KocfRtnsK+C4FxHXLXb3nMXnQWCROJRGxVH2VvPbhuvnxWTkf3sDP5GP7qMwvBEpwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OXT/UdV3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXT/UdV3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5666OPwF008766
	for <iommu@lists.linux.dev>; Sun, 6 Jul 2025 15:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=dLFAbZ9MMfXUGoM7SgNEwHVpWiLq2JEVpU4msHTUWsw=; b=OX
	T/UdV3HYwYj0Ws0XuBFaj7YM6bc16bVP4VclQN+0EXkqPsQgFvHeAVoznuZi7pgs
	+B9ur+s0e//caRQ1yp2Nvy9UyjCbmy+32YGVNfitc0L3J6LZSXoXiacu+QQDMfyo
	gLBjZdSoY/xFGbMr+qTAXnKOCOo5JEmLDrJWyWF+MjQ4vvUiC/eeFrHFB4Ua0Lgi
	3vrAJt9wKZiCO05Z2V9r2oazm73Hqt4b/cp3e/z4DZs9wCY5/vKknb4YeC40+VHN
	qKwcuDO40vkYc6q45Iex+iugOznNb+gTWdpsXmwDJPBj0ufeEHvMxSKC3aMSvbMT
	wX9NmNU4mRWnSAmLODKQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrk4x06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 06 Jul 2025 15:20:32 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4067aeea8c0so607194b6e.0
        for <iommu@lists.linux.dev>; Sun, 06 Jul 2025 08:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751815231; x=1752420031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dLFAbZ9MMfXUGoM7SgNEwHVpWiLq2JEVpU4msHTUWsw=;
        b=PyJuTxvknGoUFfWR98yFI21Rc+VyPdLMyQCw51n8Lkj4aCmySTQhdt2qiAvyJtaIdl
         /bmfWd60o9shymT0EBduZjaf9T3/qt3GC/TBwzXd90R/yVJM7PgFsAkaY6l4WarAyfv2
         nieZs1k4y038ac4cR7TVioR6MRH2JcG/8Sul/fIpJi3n96QmmEFYX3K51SOBUl73kHnL
         Z/dln7b/R1fuh3FHg9Zv/ODFM172LKRqMsQyiBtGZzAWTwWp8aENe31zHFc+OGw1Q44S
         tN4rKAJjWEMRw/ny5gnulmB91E2fcHMbXziGemyC5IIVFRMUTRwwoIzyWXbrv5SBXlyR
         +F6g==
X-Forwarded-Encrypted: i=1; AJvYcCXnfXQrTDz4VdNnP0/KJsCmwtKUzp8s0al7vPCxhbt+q3B8K+ehaN+zPieOlS8WesjTA4ERGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw44eLxDsVeZRnPjuqpTUd2rG7XR/zPwusVT31nCh2WwP0PNgmg
	o9sBUPwpipy7hAp0DmjG4Gd95QBo8+oM2xsm0WyES37RkmXfJD0DIEqai6dHhgCLQQr9K/CCZPg
	jBPiJGKkXQLnfXGqj4Edc5QgBIgIMkRvk5TRGeYborHafQ3t/DnvUNy0GQWnsoK54lH/M6il5Kz
	bxIPJYYpxZlcVUbScOcquJK0nWp/t6efpe
X-Gm-Gg: ASbGncuAHPLHpFy1dMhPUqv+dnKhCEk7EKSAJPhww0/IZ+ZIt3yScW942naxaqfOaQD
	VfIUY/zp1Ruih5CKxJ5Eds1lg/sYBZGmNAgkrJGjTBoUGaBt6Drdqv4/kqB695QrbApNVh3LhSC
	beovoFKmjL6b0TzNhcgytPkK3Fn1nJAHhb//0=
X-Received: by 2002:a05:6808:4701:b0:409:c6:c147 with SMTP id 5614622812f47-40d2b4715f8mr3439867b6e.6.1751815231014;
        Sun, 06 Jul 2025 08:20:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ19HjfWS2qJ+/2HG/poPWfm2s0tMKpeheNoz9fX/o+Q8VwG+3oADAA9x4xsA7IVI4FHzXquARSSMgABetSuE=
X-Received: by 2002:a05:6808:4701:b0:409:c6:c147 with SMTP id
 5614622812f47-40d2b4715f8mr3439853b6e.6.1751815230643; Sun, 06 Jul 2025
 08:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250705-iommu-fix-prr-v2-1-406fecc37cf8@oss.qualcomm.com> <c20a9713-6f8d-4c20-a031-dc448404d073@oss.qualcomm.com>
In-Reply-To: <c20a9713-6f8d-4c20-a031-dc448404d073@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sun, 6 Jul 2025 08:20:19 -0700
X-Gm-Features: Ac12FXyNtpZjdRENeNHXo5Q0MJXp9o0sqLqUTlypqwb-wsX2wlCghESA5aSIn6I
Message-ID: <CACSVV02ioJfDyYLj6ASeQwH91n5CGcz+GW0wsupWJaUkJyFmqQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: disable PRR on SM8250
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 2JUmNZtFmHNjc6_adSvN56j9kpEGedLv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDA5OCBTYWx0ZWRfXzi1rH+AQp+aP
 HCtf8kt49TJPefXnoqDhCdAqruNMZuhy973NwFweZkvg5p63lrRAqC9MB8+D+vpl4K6Q5k/VOt6
 fHCNk405MQO7YioCZ3sJ9h0SdGrAMo+J2djJ0zAQ9nJJNvZhDryCX/Jd0s9G1GBu6A4W0PkoCw/
 FNDQkxcATb8+aScS3VFestYBZoGK9ea1+PKCmlLTERZlvvvzOHn09tCH0RzQGzir5OYtIptISCl
 DjGQWi2V27Lx7Xffi7ghe7gGgIib6z/s/3Pvm1qz5FWD2g4wOP9Mz2Ryr7/0OstbgNMSszwH1Nx
 iUJaIgMvmsq76IwOhaqSfNVebUj4Es5UZSwMsSQhzvysI0rwqRxGQ5DE/rb59ZKZP+ZbdORKGt/
 IjwBi+PZ22svn+lusOVObz0V2lB9wERDqiRVfVDKwEV779eVekOwphOK+FdCRDZgCwmOZZ+5
X-Proofpoint-GUID: 2JUmNZtFmHNjc6_adSvN56j9kpEGedLv
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686a9440 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NKDI3HYFCsqCqSkob8kA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507060098

On Sun, Jul 6, 2025 at 7:22=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcomm=
.com> wrote:
>
> On 7/5/2025 9:38 PM, Dmitry Baryshkov wrote:
> > On SM8250 / QRB5165-RB5 using PRR bits resets the device, most likely
> > because of the hyp limitations. Disable PRR support on that platform.
> >
> > Fixes: 7f2ef1bfc758 ("iommu/arm-smmu: Add support for PRR bit setup")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>
> Unfortunately, there is no way to detect firmware support for PRR safely
> from KMD.

I still am a bit curious about whether it is the ACLTR write that
trips the fw out (doubtful, since we write other bits in that reg
AFAICT) or the PRR_CFG_LADDR/UADDR write that does it.  In the latter
case we could potentially use a reserved-region for the PRR page,
instead of dynamically allocating it (if we knew what values are in
LADDR/UADDR.. I guess 0x0?) to avoid reduced vk functionality on these
devices.  AFAIU the vk extensions that depend on PRR are required for
vkd3d.

BR,
-R

> -Akhil.
>
> > ---
> > I currently don't have access to other devices from these generations.
> > It might be necessary to apply the same workaround to other platforms.
> > ---
> > Changes in v2:
> > - Simplify the workaround as the issue seems to be limited to SM8250
> >   only (Rob)
> > - Link to v1: https://lore.kernel.org/r/20250705-iommu-fix-prr-v1-1-ef7=
25033651c@oss.qualcomm.com
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu=
/arm/arm-smmu/arm-smmu-qcom.c
> > index 62874b18f6459ad9a8b0542ab81c24e3e745c53d..53d88646476e9f193a6275d=
9c3ee3d084c215362 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -355,7 +355,8 @@ static int qcom_adreno_smmu_init_context(struct arm=
_smmu_domain *smmu_domain,
> >       priv->set_prr_addr =3D NULL;
> >
> >       if (of_device_is_compatible(np, "qcom,smmu-500") &&
> > -                     of_device_is_compatible(np, "qcom,adreno-smmu")) =
{
> > +         !of_device_is_compatible(np, "qcom,sm8250-smmu-500") &&
> > +         of_device_is_compatible(np, "qcom,adreno-smmu")) {
> >               priv->set_prr_bit =3D qcom_adreno_smmu_set_prr_bit;
> >               priv->set_prr_addr =3D qcom_adreno_smmu_set_prr_addr;
> >       }
> >
> > ---
> > base-commit: 7244e36657076b597ac21d118be9c0b0f15fc622
> > change-id: 20250705-iommu-fix-prr-600451b1d304
> >
> > Best regards,
>
