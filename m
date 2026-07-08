Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610313A6F17
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524258; cv=pass; b=eV5Gu0RUs0WhvvuaY1h3T1d8hy3lazXBFGM1z7DN/bMFz//Hh0tAhFD3WdI2GPwLRvTYsA74vq2SD/JDy12erqCBvb0dp+9QWI/uWdAOkDEInXDo9u4FgRnudsdAzr4UxOk3XFkeEKriPbDr7oW1Se4VyZGac7mbPt0VF2wKXC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524258; c=relaxed/simple;
	bh=fTRf+CpDlg8oC/q1+pBZdLSPb9okL8GDVBLZGR4FfHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxvIbK/9tM7neLLfSzFw0I6ddWkGhjUivjhyTW/9BZIduWOrzGp+0BB8LZxB9AKxuz3z35lCu5BGx2IHAhHnMDJOQ/Bxc3mtiOI55AQQ8FB79VcNgsuzoU7AEDQRgGWUXW1b9ZMY7U4+kzTdB/33pHpOR2osTu4wGj0p8OUppKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KNCMzsev; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I7Ddpj+q; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNCMzsev";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I7Ddpj+q"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3hMp2727692
	for <iommu@lists.linux.dev>; Wed, 8 Jul 2026 15:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=; b=KNCMzsevlh2tuc5/
	1WnIHZZhAhaywF9mfturWOYGVfOtDmek/uPAQGzO8pf5SVlIUqrprfq9VMbsxYYJ
	In4RT4IQuLvwHdCHl2uDDy4uroXw2M6EurBD8eSU3xR6PTtrM8Dmh59iWn6ws4dC
	92CbytmCMmFTb6lNx5rnJolDTaY4yGqklGGr7xsWt1VlIFJER6Uybv8uaGV5g0Ps
	rr0TV2ROBhLa1I2l3JKNmDMytA1jSAa1NTLNCifcU+9Wn7GCxMZBY2vQc0S+n/f/
	EYdNB5Cdm1Zocr9tW97T0cxeQ0WEWUd8uVX4VjqI0hpNRSjBJRCtoKTB03j6Z/Ki
	naEIwg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9c6abajd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 15:24:16 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f08560ea44so11935896d6.1
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 08:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524256; cv=none;
        d=google.com; s=arc-20260327;
        b=irQD3F7N4ytb/MgoEzErkFcGVDKIOC+s6sJEtEQMNjLYQTq8TD2t8Ueo7xXar7kplh
         qoxAONd17V1dNX8sg94BW+qxY9TD9cLCenWMxGnTeafIZgD9bUh5R2Nf2xGLSqyaLcvb
         0uk0q3z70VHy70jM4NY92r30GqGNRvU02EGn40CVMI++ViEOgbmKGppIQmB2q0la5ed2
         orxfMRUFIlSITYYyEteQEB8ksZY2D5tp5NHAXPSeKgwHqNxjEMhi8x1y8GG9ERho0smk
         M81aMHYAEaUh5PTBVCZNkTT64I7kqqpZGgKKAtSyJ1zumudnReGBPHVv0xkdnlJQmHCT
         lgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=;
        fh=dXS9CvcGbhsoa7w32V1Q56Cqm2wbKec8z/RqAIynt1U=;
        b=QbETpYUqTdTt/2/HXKdArGBmQlp4+biaG/FviPVrZcnVNqNyTehAJcsxVWQ1odpBdU
         vmwrLEQZ42DGncyxThQAw7ruRC/B7/4pYE/YhdwgvCCwIQ0l8pidCsqo7VLP4g17gzn3
         L0SuiGRtU+0mGf3EwAmoVDeRCo1SINTrLyFN9Af+SOFkz82oLnhCGqtyAn7WjxWAluVo
         CjHR1cHNTdX7c2OZjs/w1VpfYMUNYFdaMqUYQH25qMvSEnJOuDIwP9f5HjdsvASUz0Zt
         HDMzbGWxeaAkJD+WxKrfweX3IbC14fiTG47QKn4sRJ5ep4wPptyP2jMK+K/VkrpwNzZP
         LjPw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783524256; x=1784129056; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=;
        b=I7Ddpj+qV6/hV9DJ6azOGWJGNg5PErDlLWEk/zeRZDmGWkJ7lJYj7CPL9WAPKWayz6
         H2fmCKpAUiLEE0f3XxrH0LpbZ9I0ZGibTUlQqY4tUrRU1vCmJuuWB37VRVfT88QGICdl
         nGtxf8CyXi1gLF3lyK+zzdRN867xeLyDIMThiX+3zG+NG/+RV4/HS/UAbAXnsKzBnQ8v
         xF/qTEL14vCiL3exg/1C3sAf2Vbr5L4SCG3l07JN+efk1iWtEEG5T24xWbECSUSONnMt
         7syA6i3hg8Ylfo4ZI1QoFRX5Jyr6s7oHpss6J7oo1WE7eCvhlLHZrf+ccMvYmbSErEe2
         hsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524256; x=1784129056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=;
        b=IjT8S8G4tVKn0odvleQOjfVgmR9DS7FbeEFK4dFanWF4ZwRlNrMa97v8ivphoz0kx4
         z3typRvTUQ6UjFYNXL5uJEyBjW1ddkTSK/UGZgfRkgSUK+XNa4j//H7l1Yb6R8pqAbHW
         CdrleCFIDtpYFO5jnHQ8Sv+zKo6mJ+ey3LQ4VmYGqAs26PWnODawPo55N+ZGWnd3xH/L
         rEjjHHimfNAaspby39PvFfVIyK0kXXezGxL1OsXd0niFFYkLbjWt/Uvt+h3RJICRgbuD
         uh2YRWw2o6LDOsujautw28meiW6osmEgylxpk0rqDqrpgVktAuzfjVJI2u+GkgBBfp6E
         Wu0w==
X-Forwarded-Encrypted: i=1; AHgh+RoSWsQLjrxa3baMuYn7ju01psOcjXcTRIJZ4fHeoxSvmLpKeVlFJBEp11Hr91GpAClaGtwGug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5KTuGej6XwSBwGlMJSFI3B1idCu67oPee/x+iaSxXc+PylGzo
	5MjqElz4ORX0PRlLx0sfDfZOxX7FAwtI/sLXreag0gSSw5XhaJpM+ILng1mnV+GSK/dWon4yH2l
	IDZchh9RNqpIUK22JQGOEhgFMZZGS/qRTZb5ftcPl5L9TKfPyte+hy9b9wf0a4z9DwpryY/Siap
	sJPo/RvLPq/fFeWo37D4ybJyR1tb1J8lMq
X-Gm-Gg: AfdE7cniEbMsZZJGBM08X7domlQ+noAWo/I8uhPpOA+3f0fXl7kgRIv6ogaI+Mj6D6p
	tWmAzRcu1fsG6UreHCNcEmgsGWt2iDtOP9/E2+DXddf57QhJ+lRhiJv3pFWBdgq3KMx1DYfKl/b
	/wY//mqyIEk1mQQMou/YKZRUMtNJQGAuNrgOwOuf7Y2eoyH/CcZ+Lmt2AlqxIrVb5B0Tt9
X-Received: by 2002:a05:6214:5504:b0:8fd:6df3:b377 with SMTP id 6a1803df08f44-8fec323e5b7mr31147586d6.59.1783524255447;
        Wed, 08 Jul 2026 08:24:15 -0700 (PDT)
X-Received: by 2002:a05:6214:5504:b0:8fd:6df3:b377 with SMTP id
 6a1803df08f44-8fec323e5b7mr31146966d6.59.1783524254959; Wed, 08 Jul 2026
 08:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260613070116.438906-1-midgy971@gmail.com> <20260613070116.438906-10-midgy971@gmail.com>
In-Reply-To: <20260613070116.438906-10-midgy971@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:24:04 +0200
X-Gm-Features: AVVi8Cct2pvQNJ49kCocOmZ_g-M7AfBNrJ0WxbavryIJprjGJGNLahRi4HQp2RE
Message-ID: <CAPx+jO_2=SYo0smYzwd8T+TUtHZtgXU0dSWQgZGZ_haV3aOU_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] pmdomain: rockchip: Add a regulator to the
 RK3568 NPU power domain
To: MidG971 <midgy971@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        xxm@rock-chips.com, chaoyi.chen@rock-chips.com,
        finley.xiao@rock-chips.com, diederik@cknow-tech.com, jonas@kwiboo.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1MSBTYWx0ZWRfX1coqiFYlsoc5
 pIwaV1zuBxGRQuIe+0WXBQo+UvyhkRxRTxH7hUubsb94Zl+Ixn7kzrUhpItnBT4r1+dNR4Cr0Zz
 0iVVoMBznlz1iFf9AtyvkN0rEvgF/vZBE7kwXvN0O6tzwTg4CZ2bIhpAUN3Qy6kfkF8PbXjXEK4
 /uKUBTewqflDRW76oIyALBh5lZKGix5vwmXVNv54HDbnbGagBSWqfaDDEwN8htLkicOAZQ/XlxM
 itJgTvsZPQbMGVC81BzajBZ1BiEUq2I1nE0zuuPWJCQPQAbXVUyxiOUldukh3RtXSYQc5jjyZPo
 5/84vceZ50qgIyXl38sAMjyuZCQ1YWuaUvzdfnf3GbLi07BYt6XE0zcRoUjWoHwmWE8roC0jfaC
 jEcYhYLK1DDC6n+/Fse3QzLeb5f2gcPp/EFxkYJ4l1jtxb2wPSLk8a74MT67Qb2XXMLRyn1bCrc
 Y9YpuOy3Rlqs0YXDVMg==
X-Proofpoint-ORIG-GUID: 3l-0qzM4yc8hz7d-CzJCDodNV5uDdRPc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1MSBTYWx0ZWRfXy931XSgGbsGM
 qK4KOGLQAZhJFdlg6pHatMEl2tTYZlvmYvVgXsmQ4FIGbwksMhw+bm1NDakXRxYlpCtHHPUa82n
 GO0KwtN/bZLhSDQGTufASsCcwkdJmcM=
X-Authority-Analysis: v=2.4 cv=UehhjqSN c=1 sm=1 tr=0 ts=6a4e6ba0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=s8YR1HE3AAAA:8
 a=bcpWyJPC7eKr9KdVfhAA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: 3l-0qzM4yc8hz7d-CzJCDodNV5uDdRPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080151

On Sat, Jun 13, 2026 at 9:01=E2=80=AFAM MidG971 <midgy971@gmail.com> wrote:
>
> From: Midgy BALON <midgy971@gmail.com>
>
> The RK3568 NPU rail (vdd_npu) needs to be enabled before the domain is
> powered on and disabled after it is powered off. Give DOMAIN_RK3568 a
> regulator parameter (like DOMAIN_RK3588 already has) so the NPU domain
> can set need_regulator, letting genpd manage the rail wired up as the
> domain's domain-supply instead of marking it always-on in DT.
>
> Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Signed-off-by: Midgy BALON <midgy971@gmail.com>

This looks good to me. I assume this can be picked up independently of
the other patches, whenever you decide to move forward from the RFC.
If not, please let me know.

Kind regards
Uffe

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 36 ++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 490bbb1d1d8e8..19db307e3811d 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -138,6 +138,20 @@ struct rockchip_pmu {
>         .active_wakeup =3D wakeup,                        \
>  }
>
> +#define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator=
)      \
> +{                                                      \
> +       .name =3D _name,                          \
> +       .pwr_w_mask =3D (pwr) << 16,                      \
> +       .pwr_mask =3D (pwr),                              \
> +       .status_mask =3D (status),                        \
> +       .req_w_mask =3D (req) << 16,                      \
> +       .req_mask =3D (req),                              \
> +       .idle_mask =3D (idle),                            \
> +       .ack_mask =3D (ack),                              \
> +       .active_wakeup =3D wakeup,                        \
> +       .need_regulator =3D regulator,                    \
> +}
> +
>  #define DOMAIN_M_G(_name, pwr, status, req, idle, ack, g_mask, wakeup, k=
eepon) \
>  {                                                      \
>         .name =3D _name,                                  \
> @@ -241,8 +255,8 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)             \
>         DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup,=
 false)
>
> -#define DOMAIN_RK3568(name, pwr, req, wakeup)          \
> -       DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
> +#define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)               \
> +       DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
>
>  #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, wakeup)      \
>         DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status=
, r_offset, req, idle, idle, g_mask, wakeup)
> @@ -1274,15 +1288,15 @@ static const struct rockchip_domain_info rk3562_p=
m_domains[] =3D {
>  };
>
>  static const struct rockchip_domain_info rk3568_pm_domains[] =3D {
> -       [RK3568_PD_NPU]         =3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),=
  false),
> -       [RK3568_PD_GPU]         =3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),=
  false),
> -       [RK3568_PD_VI]          =3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),=
  false),
> -       [RK3568_PD_VO]          =3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),=
  false),
> -       [RK3568_PD_RGA]         =3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),=
  false),
> -       [RK3568_PD_VPU]         =3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),=
  false),
> -       [RK3568_PD_RKVDEC]      =3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),=
  false),
> -       [RK3568_PD_RKVENC]      =3D DOMAIN_RK3568("venc", BIT(3), BIT(7),=
  false),
> -       [RK3568_PD_PIPE]        =3D DOMAIN_RK3568("pipe", BIT(8), BIT(11)=
, false),
> +       [RK3568_PD_NPU]         =3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),=
  false, true),
> +       [RK3568_PD_GPU]         =3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),=
  false, false),
> +       [RK3568_PD_VI]          =3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),=
  false, false),
> +       [RK3568_PD_VO]          =3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),=
  false, false),
> +       [RK3568_PD_RGA]         =3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),=
  false, false),
> +       [RK3568_PD_VPU]         =3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),=
  false, false),
> +       [RK3568_PD_RKVDEC]      =3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),=
  false, false),
> +       [RK3568_PD_RKVENC]      =3D DOMAIN_RK3568("venc", BIT(3), BIT(7),=
  false, false),
> +       [RK3568_PD_PIPE]        =3D DOMAIN_RK3568("pipe", BIT(8), BIT(11)=
, false, false),
>  };
>
>  static const struct rockchip_domain_info rk3576_pm_domains[] =3D {
> --
> 2.39.5
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
