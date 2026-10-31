Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793460459;
	b=SoDDB3GWh1NY2D8wg5VysafIsDARVFo9MYGDH0LCQ3SFNKU8n5nUIwXFEgFB8x5A7H99
	 tMXnhE1xxitSU/nPUKkyvgCN5w8rN3WIPZ4JrZvDIy+Iqr99DV3nql6tZftEcrQK3BkXJ
	 3H0LWwoPrqMT31U7ACU4BgZCg+k3oJC2dbuShiTuBmrjMXeAr7r/PB1U6XKqYwDKX6Mu5
	 XGBTVEh7/qDmwlnYzi2/QXtkm9dE6cHbD/LOkpV7bRk5ti3M4iivOPOKeA8iL/Kb9G5my
	 SkLHLOaUpLaNlC7XKmjY14ZQuDzOWNRuLHnXlQ4U5JlkQypolIDNGQ0Kk4WCqBJyFBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793460459;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mbIGiHBiaKBjgOa8o+hDFP6aAnbPQE0+rh/Y8oaEe/8=;
	b=BtvmUFNu014Ag2YCcYaiZOuUOHcvzSIMq8jkLjRRrJ0V2fgyWYC8j17AwSgOpizNneYz
	 TD0INSJ6FkLxjzDO1IhEFAJMPj3q4CTKSCUOY9/0YXuZUN4Gx5imlwbOUKQlch+YjJ1Yh
	 kTQYhmQ5R4VARblvxnLYjhPdpYW2FkA5j+c1gAVfkT9n2JjilMMJQSokBO/8Hwvw4NvwF
	 DdEYVNj8cJZONnAUo73N3V3nsPgoS8WqLaEE0m8jKnyiUl3MLtyWBKGKAVC+soZRZoZ8O
	 /EyLCJDjL/pd/FdEACI6/65W9TRR3dKSyNNlIfN7sJB6DqorF1owb5wCyOb3joGdsFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FJvFxJvg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BGbjx6kJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A6606A31E
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF9A6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FJvFxJvg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BGbjx6kJ
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VD0QAs2196997
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=mbIGiHBiaKBjgOa8o+hDFP6aAnbPQE0+rh/Y8oaEe/8=; b=FJ
	vFxJvgYCstEvbDKYUxxz1B9BCgQ0xfgx/UEGaF1nIXCswS1rwnxg2MGi4LH9mC/z
	m0CNX+MrrlBxER6K9e5WE7YFVR9cU4n06eirW9IXTWyr1WFHRfuQmTguT2TwbH3n
	nhM+M/w8FkQrlv9aWpmXsP5h5wG+5lDPvwpU+Ly9sTZ588JDZKn+bkKKujwO2MY3
	gvDJoWlR6s8NwUwgmZdHpJ1vr++wRrHyUSoJAs7yW5rocMv+ZNdTHDP4T99XFnZk
	+JRc4j8CgPg9nqu36ovtuGDjuaU8DlNHOa7Qu3MQET/V8i6+Tb0v/jhTmy64kdAj
	7MO7z2UqRBPzaEBkf1xg==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8du9cd6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:27:37 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-44899f99756so2641182fac.2
        for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 08:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793460457; cv=none;
        d=google.com; s=arc-20260327;
        b=odBg2BC84epd6mRiAFPbeskPyyDR/WQjzDAE877hnnMshgoouGZRrZStg5HrwZaVzU
         69OkE63XXoO/cy0ElxSWmeTMY9ledTXAWeWSA352x+ksJfut1TfE9pw47Zaxbcyo1K2X
         r0MmZSa3tFgFW63IOp0mc1Mk1xmfblAG4zkUgP8b+7X2NPp/fGm6qraymKeiM5ew7i1T
         wyqujEwOma6YC600zZXMITvEXWpZ0e0SR64UiCnoy/5DH+QeNKGd7jdJtNQDtWWdj5rL
         guxMJ6ocuhfTGa3Efe1EhtaJswHanbVydTnrbreRc0kU2VuqAyKjAgiYp2Y8PcBnRKgc
         z5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=mbIGiHBiaKBjgOa8o+hDFP6aAnbPQE0+rh/Y8oaEe/8=;
        fh=RQq9P/5t41TlTF3tKD0D84tME4No/6tsCXJWRWt89f0=;
        b=nLPPWIpPOvpwkTeVtRCkzFeXVzmLNcYGjhjq4pU1A46uqZJQbZn7TXCVZ9naAQq3PL
         s56ZzpOBkPp4/NDm+Ai3w13gRs5rcuIqQuerHq8pRcW3LJ/QybHnkf0P9OcTmjiT8Hqq
         8tyrTg2NqCL8nPcy+Q56Bj7WkET+9wBsgGNP/qBi2efHsXe6CZb392ee94cFZQfL3wZN
         2hoHC7eGQVB5MKQcWeIAk6E71iZRfntYZn598lLOZVHuntDnWzKsN2NJ2SoBpjTteFt+
         pUfsDb7YHzfDMyPUauppb6ElT6UrhMBqiyHP3iHjUOX0J7PNv8bSw0JxkKILa049cf1H
         yQmg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793460457; x=1794065257; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mbIGiHBiaKBjgOa8o+hDFP6aAnbPQE0+rh/Y8oaEe/8=;
        b=BGbjx6kJ0j1+LKhNw/DhHw8cfLjKhj1kv7A/A8foGIoXJ+Trn+IrIasq4QjEdmarPW
         d27mVXm+puOCrGOW2BRdqP+LXuOUwoJqcBWpsykxNjmamTAQVV2iKtzqaKVoERQhxuqH
         Uep3ZdD2bnpPQKFD6b0oYKovJ1IyUKTT/y+asiaDHibIlHy1woqNsrBYifNf2UNtAQeV
         lZFEKv/lyuV87TABYdG7DfJ2eubFPZe+NiCiIapCkTGm+k6G0bor04dVsxQAYJ3uq9Ix
         EnoltDUnZSd+E2CEJGYM9WlUPrWvNP1PFb4woxGWt+m1gNARbIziKylmWDK/6CF7JbT3
         2mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793460457; x=1794065257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbIGiHBiaKBjgOa8o+hDFP6aAnbPQE0+rh/Y8oaEe/8=;
        b=wmw8MwT78vncrqo7nyEDOQw4BMpvLuwVfr4pAEipVJg/yIIYDFETJK+ziRLvB3Prty
         9yBQdLT+U7ul7b/mRRUg9OWFtLropTeyhE3B9QR4IqURpDD3v/ik3oxe7oQSdhi6s4ft
         GOBtnAeRh++fDFttlTVRX5ogCLkFO4xEVet++3+L5RszNjSGAuFgtEuB4MAK6iMIEwXG
         GZAcFFyYxNA8v84fy69wuyenAbxukuARd0zw67MS13Wa/cjORgtlaMk+89sAqP53ilSo
         +sRSrPY5/MN2foXCP00cSQ9r0H6zIYmO6fbTMY6tPVheAINrOcA7FqpiargmqWvLPUyA
         zd7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzNHKxIrE2joVgRim0i0ZgMJSEZmDsLOux263F1xq6K35XBr/yBq+nSdQh2vxxUH/xWWZd6Og==@lists.linux.dev
X-Gm-Message-State: AFq9FYJQoT/RXeXmqHF2bHOaR9vZizD7N+l6TVbOxOUPt+AmkXOdoDk1
	SN9fKaHmVPQ/rJ8eMJllEzzzGUZ694QyCkjcyVv7UajAF/NJB3ZDZJ/WRSa+pn9Z6Tp03faC58Y
	LDH16+3AxHcJSxrPuRhknmjjKNcgl5UVA0+a4LQWla69FnI6To2MPeMVlKFd75BYSbcp3frdgpq
	QiOHqhZCN72TKMX4uFlbzq/JgDXYf+mzd1
X-Gm-Gg: AYBFou2btRqQg0fSDQlXFM8/iq9iYuVCl5YFmwTVQ1WNgJmw1ROYTO4GeRMKewKRl1Q
	2VV8LYnJ6YBt2jPVAeITewYGuMMqDDl4L6Nt5lKtaLDQWEDfc6JdO9FW+aAktucf5ClgDfZJhXg
	MYFVBWznEZjvcZTGL6Kvhsxny694/62LQPwjKI9cldsgZh3Pbw8EWGRjNO9Q==
X-Received: by 2002:a05:6870:82ab:b0:4a6:d85c:a3f2 with SMTP id 586e51a60fabf-4a907684d6cmr3466585fac.33.1793460456933;
        Sat, 31 Oct 2026 08:27:36 -0700 (PDT)
X-Received: by 2002:a05:6870:82ab:b0:4a6:d85c:a3f2 with SMTP id
 586e51a60fabf-4a907684d6cmr3466570fac.33.1793460456464; Sat, 31 Oct 2026
 08:27:36 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com> <20261031-msm-smmu-identity-v1-1-a2a70580eebd@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-1-a2a70580eebd@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 08:27:25 -0700
X-Gm-Features: AclHuK-pzJRTbh4UTFiq0fs-4bAqq6ic9ym9r9ejSwbktmESwt9yc0oaaUOjgyA
Message-ID: <CACSVV01pWNJsLLek+az=uHbt1-Cavv5M=QhX=xD6_AG9J+magw@mail.gmail.com>
Subject: Re: [PATCH 1/3] iommu/qcom: Invalidate the TLB in flush_iotlb_all
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae608e9 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=BFTSSJhH0xhXNpwrsgYA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-ORIG-GUID: IvUbbjV672BmYiSV2fHhsauxTVvAoOns
X-Proofpoint-GUID: IvUbbjV672BmYiSV2fHhsauxTVvAoOns
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2MSBTYWx0ZWRfX2Nz/AUu10w6N
 Orb8+JuhRRAAHJSzAMiwzH367l+LJmEP11k2vJnrXW8sE8bOefO2SQ0ZnTDDzz4n7gMgdNb8B1e
 RUvhJHfEwuil/LncZEgV3U3DjbxgC4Duqn3JcJvK1aWgONmuCebhnAjyGhzhRAkQZxMwX2VlxUP
 74L5CWVOEby/kUT6G97irE3+BFClJolCJnpi/GCaqe7EZy4T1QN8sFCqh5LW/F+bNwmHS/7ljlg
 P2ilZdBN3DF1GK7ONMbUe8egM5Sqa/pJhPG/nYR6sXxL4uWOIIipVArBdChKtL+yFfswsouWQB3
 zVe/bcJ1nuop007bAu26bqDMvKH6GYyACEAchQAVLwjwMHmQnpHBE+lz0OJYuuWAYA9N20RsiTs
 IaW4UhUIAbK5i4neX9h2sLtloVn3D3HoEbAXeKMRwkKmq3nBWd9UtzuPFbD1H7mN7xnrRo/wtY+
 CBnlW5Dki4ovNPpZfrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2MSBTYWx0ZWRfX4oVIzlbKC8LB
 r2JaLNiyRR4z1yjOpnqSn+Fu/mmN+aXPJv77XFi7eWbOHAX+WfSzDfA6E+g7VSz4Qm549D9Pxaa
 Xm8ZAzLIePUMO/INjBUdXF+sQbIfSQc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310061

On Fri, Oct 30, 2026 at 3:05=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> qcom_iommu_flush_iotlb_all() only waits for a TLB sync and never
> invalidates anything. iommu_unmap() users do not notice, since
> io-pgtable invalidates each page through the gather, but drm/msm unmaps
> with a NULL gather and relies on flush_iotlb_all. On db410c the GPU then
> hangs on stale TLB entries as soon as another process reuses the IOVAs.
>
> Invalidate the whole context, as arm-smmu does, and keep iotlb_sync a
> plain sync.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/=
arm-smmu/qcom_iommu.c
> index 21d18ce67b98..54130c32056a 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -479,14 +479,22 @@ static void qcom_iommu_flush_iotlb_all(struct iommu=
_domain *domain)
>                 return;
>
>         pm_runtime_get_sync(qcom_domain->iommu->dev);
> -       qcom_iommu_tlb_sync(pgtable->cookie);
> +       qcom_iommu_tlb_inv_context(pgtable->cookie);
>         pm_runtime_put_sync(qcom_domain->iommu->dev);
>  }
>
>  static void qcom_iommu_iotlb_sync(struct iommu_domain *domain,
>                                   struct iommu_iotlb_gather *gather)
>  {
> -       qcom_iommu_flush_iotlb_all(domain);
> +       struct qcom_iommu_domain *qcom_domain =3D to_qcom_iommu_domain(do=
main);
> +       struct io_pgtable *pgtable =3D container_of(qcom_domain->pgtbl_op=
s,
> +                                                 struct io_pgtable, ops)=
;
> +       if (!qcom_domain->pgtbl_ops)
> +               return;
> +
> +       pm_runtime_get_sync(qcom_domain->iommu->dev);
> +       qcom_iommu_tlb_sync(pgtable->cookie);
> +       pm_runtime_put_sync(qcom_domain->iommu->dev);
>  }
>
>  static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
>
> --
> 2.47.3
>
