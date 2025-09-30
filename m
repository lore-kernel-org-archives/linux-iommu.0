Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1425C6E2
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217171; cv=none; b=CddmhkXMa/ASVn2eLRq6xDC+CtIA/aqhBbIhWlFZ0XE/PFTWVcbxf/uVg5OY3807hPB93GhH7gvc9raKwwfphP5h57/Qs/IQ1jtAhM4+fgS20xXYJ3KmeMiOkGu4EyJYfaOOJG8iXBB1PT4ksMxbomQQT7R+fLWt2VK/RhFZ9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217171; c=relaxed/simple;
	bh=UrXXb74599R8BZwIXkzJxHVqUA8YfSKR3ekHC6kpqv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDQMUL3ND3IcvP8VZ7TMVYVXmnp3X6uFBtBF/PullC4YWph77oDY0qkDRH+XaSug5JCDbzQfdZINFazvPXgZxN3MnuevBn3vqb//6roBHlxwSggzPM23VYQ536OOPUMgwxBydtPgeOCZKv+B0KeIS8fLw5GnKUd5xBPzDms027c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ak/DaJwB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ak/DaJwB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4IDvo017910
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=NJKkBSbx/8tqEG8xyEV6jB7VZnVlHiCHJaTcMaV3vdw=; b=Ak
	/DaJwBmKTwW3xCru1IZ19Bx3qchaFKy4WY9jpPbNbKcGYQGlfHSvI1ZU9YSbT3wT
	jKnXCp3NLSNDeM+BZ8pwNUCAspsTnZ013ZmAumkXntu9a9E4uP/YeCo3GMkMoVcX
	3ujKXRjRN145HCmZjr//WUOyVhVhw3zS9iUCVt12OgRpA0KdnL2zzYuu1X/YMzUU
	OZ8SNVNBNZA/Zu2+fPQC+v8XVuoDRRKh1//bL4vbEP+ZI/rNXFJt59TRICLQ3l+c
	j63z0V475fTu89lVoQYzJnJp1gwlC7MlRVNpsTk+PlYXsH2rvYb3FVgadwqeDuS+
	vyKEUcBKULsUZ5PPUA+w==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hft62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:26:08 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-33450d89acaso9456568fac.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 00:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759217167; x=1759821967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJKkBSbx/8tqEG8xyEV6jB7VZnVlHiCHJaTcMaV3vdw=;
        b=w3A0BT4tEW/E01XbwkieJT164R59SlAxTw8J9jVcdR7Q688+DoqWHNTIwT6ZRNehrn
         p2m0hmfhnpx/1PkEeTlZ/EheglkLVo9aAKU8HxnWFQeWGVE5EUsu6HTTa868PKFcxu0O
         8gp9mCRbRr+nVT3Tm6dEWfEn6TF33GO/brALdW3OFTUqO+IxMD0qzZS9FQRJQzFcoQif
         wAKMQpX2DZKK0CyvZDz+IlDH21SLxlZLolzWy0mZCorVhuLdLDMHsm7EqmO/sn7XxlTx
         K9Abu6j0CGVO8KxKS2MIqMJcx1rmCP78iVjpzYCdjaQfqLP5kC9Yjr852OEb00EZJYJX
         xD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxSS7P9SePkn7OGrbjFsPeCx7wX/QqxhQ4jVdpuxpRsslt9cdxdLmCePQy0RIrJYmiWxRBXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwspafW9oQZ8tBtc4WKR7R39BQROLGsHKhUu3zGuGXqCkDZ0eUP
	egOrm7s+6pZNkKzph591whteRaFI4FVZZle47zDfs2AWGchvjJD7wD9Fy8Ui3uVcxgknrR+eBjo
	oeXR3MgRhgKiv/K5RD9PSLNErYtMQLQ6qYaBvSiluzEuEGmG+x4YTdrW6lrBiqTvlSEaHf8MspR
	/e7U5BLlnloyaBMRrQrd83uwNGfPb92Ajr
X-Gm-Gg: ASbGncsa94t61K6kl7JuZQCgq+XVIQx5ZT+xrexxtRR9f6dpsSF2W3/haVA1clDjO4j
	48EgR98sneKXgX+jHEqmuFgcO5sdx/hrD0rJc8CKn7B3bQhlL1lTv3TTJl3TyQpRQhd4BqRXOtk
	Litlrfhq/QKlHqFwWzAe9UNJQRanpNyGPHgQFgDfqANgApSHfs5MCwExQ=
X-Received: by 2002:a05:6870:e08f:b0:31a:70c0:d498 with SMTP id 586e51a60fabf-38cadf744d7mr1709944fac.2.1759217166921;
        Tue, 30 Sep 2025 00:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpcV7QCeOoB82oAsfyshYDoFlRPDZXQ5WvKfJlIGOQR9mFN5O4/G07y/zEQHyHa3AJYBNUcaNtfqPGXVCGfxk=
X-Received: by 2002:a05:6870:e08f:b0:31a:70c0:d498 with SMTP id
 586e51a60fabf-38cadf744d7mr1709930fac.2.1759217166525; Tue, 30 Sep 2025
 00:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-3-73530b0700ed@oss.qualcomm.com> <xsgnpvswvkyuxiviv4uyb6pxbpi646fut6dy54kpyfisqrxycz@tyfox3zdi26e>
In-Reply-To: <xsgnpvswvkyuxiviv4uyb6pxbpi646fut6dy54kpyfisqrxycz@tyfox3zdi26e>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 00:25:55 -0700
X-Gm-Features: AS18NWACYkWNYimh8t14gY4Dmrp_AbVsBXT_pDvjcLAcFBgJJlOrGd5Fr1oHJ8o
Message-ID: <CACSVV011=_szCPbdm6YA8aJjm76r_BZP9QFeOzcAGCvqUUTebg@mail.gmail.com>
Subject: Re: [PATCH 03/17] drm/msm/adreno: Common-ize PIPE definitions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX5QRuEU7waKJI
 M7/X8FbCWoNWfICiESgCeOtazvmiOTo9UwcKTtR7XFOzh3EsQBfgSsGX420j2L4RlUZUOXeS3qQ
 oJHzSPhrTLw10i1sJhJzuGmIrZlNnlT3T05X7hFRhkC/ByWQsNqrV4YoNs4wgvwfuFTpuUK8fCI
 Mqi+rbAQurBgA9K/12X/uEqey6o+fnCD/SXTYrI951C0ItG39lCb4y4qBIhUjOFjWdT1EjHEy0I
 wddDX523/mMAea44N2Mz5h9MQJKpF5q5QnjGNik5dGT3biVgrCEBiqovdeoPW4YVesMKSqqCJzv
 J7ebJ8XLcKbaBMwgAyGNsnYWBsIAyznYek0wbvxkV0eLrTrF9d07HVFUybnqMzzvZ7NzKtymoAG
 s/qlQ4HNUJFd5fFW3YYKjwwXf40X/g==
X-Proofpoint-GUID: XZRK8yfAkqii-GL-gzPRN-7S5OvAbuHH
X-Proofpoint-ORIG-GUID: XZRK8yfAkqii-GL-gzPRN-7S5OvAbuHH
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68db8610 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=2l_kmpBevnkUXydlazsA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On Tue, Sep 30, 2025 at 12:05=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Sep 30, 2025 at 11:18:08AM +0530, Akhil P Oommen wrote:
> > PIPE enum definitions are backward compatible. So move its definition
> > to adreno_common.xml.
>
> What do you mean here by 'backward compatible'. Are they going to be
> used on a6xx? a5xx? If not, then why do we need to move them?

Newer gen's introduce pipe enums which do not exist on older gens, but
the numeric values do not conflict.  Ie. each gen is a superset of the
previous.

BR,
-R

> >
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  10 +-
> >  .../gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h  | 412 +++++++++----=
-----
> >  .../gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h  | 324 +++++++------=
--
> >  .../gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h  | 462 ++++++++++---=
--------
> >  drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   4 +-
> >  .../gpu/drm/msm/registers/adreno/a7xx_enums.xml    |   7 -
> >  .../gpu/drm/msm/registers/adreno/adreno_common.xml |  11 +
> >  7 files changed, 617 insertions(+), 613 deletions(-)
> >
>
> --
> With best wishes
> Dmitry
