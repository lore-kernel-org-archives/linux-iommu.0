Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB349A3C3
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994785; cv=pass; b=dtrgXD04hF+3i3/oQrlprHT9V3YOmVsT7Iq/BEgxw2eyDTYn5l5FcN9tVyQ78quWXWBXNXCq6m8Gd9pTJ1RyvqQSZJM8HPrIW9yCM+dgo5ixoqVa0TaoMTYZEF0Znu7qE2/2zP6+RCBb7lWGcrwFItxYQag0iE0t9ADpvRR3NZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994785; c=relaxed/simple;
	bh=zhes51yOam9nrMY50t2XhGSjaWOq58zdOVkwQ6/JTTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcwFbFT9OCM6uyAqZCJmcrlNzNcvoSsemXvX9+D2g72mjqHaLcwHL/5ctz4+VVbz4pybtUgnEhTdk+DQK4YqBuuOJeVv9WYYBM6xErNN57xwydUUI0Ez7mwE9p3PCV/8jcSFGvn2/Iaff1rmasYWsoXBK56ju9KSLJE4S8+88xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FDV/uRKt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TJ8J0q/k; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDV/uRKt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TJ8J0q/k"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAeAcG837790
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=; b=FDV/uRKtPIY5Te0O
	/bQLtP7WCvqplyZdNh/yoW+2tP/GxJRj2pu/B6Bsl0tycX9TtwpAkZ2N0+iOYQKl
	JoIpLSfJsY+e7FBiFpYhQMo6g3XgQhIwE1nJh3JJb9MfQWsyWEC67O1f35xHuyZX
	z9qj1VvujtNw6wroAqLSizpGFKgzMfc5UYFj9zFzgjqJMMEnIgx1EYa5V6PwjB2a
	eidrXvUd6D9+bsRQYXBngget4ljibpHdqFk+dqh8Azy7g4c/vHo0NXQIrO3go1Ax
	kN0Go5GB7uylS/SACc7SzmeISBCOdGJhbq82oCS0UvZ4gOSftSsIEswUdfChrIa7
	CyqGeQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5hury-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:46:21 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso11210a12.3
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 05:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789994781; cv=none;
        d=google.com; s=arc-20260327;
        b=VI1LjWmLW6L5n5oRAEjH2e1VMUckUYUBxPZSqXx//TYbL84z9EMPrTiajl3w660Q96
         t6DUG3Aw3JlSSjzAFBAvDKuHiavsyUYBn3BJYy/RkOUVgOkglfin3BecauUZyOzwldld
         e3z4psF/9x1grs9fze/ZL2kaCz1kbw3RZojRU7EhVIKtzDZfDCJzxvg0TXBhK8nisaon
         xe2smHFtwo9N5/lTcubrDhqSWf94T4Br/2n3sFPu1tUJrdlK6rd5lcu45kHfI3rbn2Bl
         q50szyv+Pd38B7uuYSxmcvpep/OE67O+5ixmhJdNpTs5LGb7Nq7cQt6BSO1e6yhtH/tQ
         BEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=;
        fh=mWrVfV/OBHqmiEqi6dpj3QLbAhsN/B3zRS0m366/vq8=;
        b=NElkK59YxrVu0REWuEuvFzAPtTu9eOrY1BMooIqnup4CBxt2vZsSJQ1IoTTMxiaxMc
         eDgEz3yGMsXUkQBcG7c1s3Gb3UcMoMWEtH5ALEwUyEZfTVcDJqzHuqtOIM/FYLmhKnCI
         Xcg5ViuuQyWXSGMa514PKszaXERhcmaUKdP+pbKv4JcCWN2oycuDFABrHIHk8rQB359P
         oWEDSmn4s09ParyNYwFS4IEjmUPgt193FbsrCXXO3s1B3iRRuQl+8GRa3PHK1mlJ7e/6
         rohnQAhY58xiqw7Fptw9F7N+h5KPzB5OmpXrFy4SRvpaS9ffcPiniM2QQxoJno0XGF8X
         QPcw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789994781; x=1790599581; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=;
        b=TJ8J0q/k5ev1h4h22uQN0yrxDLFxj4lM1g8/1iOFD57j07QvA2tiA1CN7cDedUOmSW
         CHWu8JCEfjUneVKmASLhSeHnVx9ZMNQ/Y0UkLqny5d0Py+Di7l3sLAbdiKhIgK7jUzbS
         IwEWCPigzU7jU+Vyfp07u0J30yhJ+GMGSX/8cXuEn0yKw9OhfOmjkQEvgl9+4HJHYDZB
         mGJSzEmUeNqsdS7BtpfnbvzfxNZoRikzOBaVKM5uwSVUcOZCHSdRApG+/gqZSLASVPpm
         X99u50QyVAa+23kr/3Yu0f73L7UDlvmCStT69PbX8eYZjqOi+0djKKanJ1rvtm711H9U
         K3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789994781; x=1790599581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=;
        b=tuMMuUvTLaLJm3MaM9nhcKtictuPMkd1+eU3uF9RufP/PuxHx2rqI04MUZml5DjAIa
         dAPHRNsvojxSAVMyz7An0zIutoS3yPk5DrDGGM73dwiR7zWJ/tc8EJqHfJpRDdME5AYx
         CbB+iAg31OPX8KLBVkIFI1jI6OHMvzuYuaOEMRXhSOZkI0XNaoNXHvn7TVXQq61s9a8y
         zo9GujyoFH2VFThbuZd8yKDNyQScAjEWuprDL5av3VmHuQJH6lfAoqvAV7+1XoWHAHxa
         kJinu89Nj5Mb3gb0TOVWAErxWzkPMcdiPSA8F+TokTLoau/93jTJrXUC6cajffNyQFDZ
         Cs6A==
X-Forwarded-Encrypted: i=1; AKwUvByaVHH98jmob8pWrPg8SFF3mLRA6euy5GJmKqWlwpdeH3nG5MGG/u+VUvGhE6qpz0nVzUV2vw==@lists.linux.dev
X-Gm-Message-State: AFuF++l3LGakvBCtv6C/BDU4m3wWTnUSAPvp+IcC+3l8zi1K0MDilF+n
	VVfLig4SUTp3fuQPUK/Zeg01eeJmsOBjJX/PE8wlJhkh0q1rDnfWMtvL4iZH0KF3bl2WI0laoR+
	3OQ9Gx4Ot9fOdCv6hwQqag9UrMghh+qnGBXwdTQrWOlbqZ91Di9dTFmXjMS9mgrYQHpFKhR0FL9
	XcbneD8ktSCw4clX4Lcfekil+PpNNKuyYP
X-Gm-Gg: AYBFou3u3an1Tjcs7ItM+FXoBIkFdqGig7io+KVbLBaUJvleNdk/CdQqRoZuPQ80vC1
	74Cc8pQmmdCSze2H6aNhWijgCBBahsV2gapN0iF2rDcltTfItIrAs5kX24OCePJmTBeaOHQ2EM3
	+a3UAc9lbFvQQLlLcrv7EQ/ozEhFytps1O6PjFS5rT63G0zNN83PCgGStbSw==
X-Received: by 2002:a05:6a21:6f87:b0:3dd:a197:edea with SMTP id adf61e73a8af0-3dda197f85emr11235059637.57.1789994780986;
        Mon, 21 Sep 2026 05:46:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f87:b0:3dd:a197:edea with SMTP id
 adf61e73a8af0-3dda197f85emr11235017637.57.1789994780421; Mon, 21 Sep 2026
 05:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915104328.45901-1-gahing@gahingwoo.com>
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:46:07 +0200
X-Gm-Features: AcwNN1X9mUUfG00OJyVIt6nOyuDWy2ZSHbWKT6BOlwyDwHXMMZbGC4tmToAM-O4
Message-ID: <CAPx+jO8EixqfXmrD8zkMkJe_B+2AATo=YNFJraAdE_O9X4KM-w@mail.gmail.com>
Subject: Re: [PATCH v13 00/14] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
        p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
        royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
        sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
        u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
        diederik@cknow-tech.com, alchark@flipper.net,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab1271e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=9GNsruGHAAAA:8 a=uuLM8HNXhctW1a4qv2gA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-GUID: vtGzUBgsPjMfH-6ifXBIDDMwDyKXukQP
X-Proofpoint-ORIG-GUID: vtGzUBgsPjMfH-6ifXBIDDMwDyKXukQP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4NSBTYWx0ZWRfX4iZiqjhbUMZz
 IjrTCDC+3YHUrKNeBC+XTSRn6r9m5jOSafKpIaPqBVag+vdtUOlSZJhqUTbwHahSyMeYPAGr6UQ
 GMFt2HWsOgze555cauoI3a83TcniZjM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4NSBTYWx0ZWRfX7IXbuyqJGTRK
 7RNuiwsXPJuR79gCHNSMc+SMM0F6LC8Hyw4lTDmDFRqWEFHS2i4IiGgf62JXRUGNOV8OI7SvVy8
 k759xKXTC3HABTBWX2uZb4Gr5E/piEN8uSdbYWUyRDOI9lnAQL53vsjejPooXyrsgkMxlTwxRlg
 F5PVVo4oCurgPLrPP/nom/5DRC1n3Lt5WeJp8hxpiUB7ExUhf3ERHBNIb5mlz5ZubaQ9I8g/k/v
 PZlyh0rgODxP/iq4r0NMMhQRwzm48AzcDCrrhJngNXMMVOp/Atb6NIamIRnV9M4AtxvljDKYt4Y
 P08rlpnfIXyFCMS9S2jLAj/0H3DYzLjTYKIOeRnxpDfQmaf4GP5XpRu3x+G2nfEVu5mZAouZNjy
 NgMwqJ/n5r4CNCbZVMVEAUh8mN5ZIqijZCfU25H73vf8WjKOVfq5dUvLGOuKLXZahb5GtVZ1CGI
 Tz6HRtOzs2AhTjFUV6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210185

On Tue, Sep 15, 2026 at 12:43=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> =
wrote:
>
> This adds the RK3576 NPU to accel/rocket, which today supports RK3588
> only. The RK3576 carries two cores of the same RKNN block, wired up
> differently. Two extra convolution buffer clocks, two power domains per
> core, one reset where the RK3588 has two, no NPU SRAM rail, and a
> PC_TASK_CON that packs the task number into sixteen bits, not twelve.
>

[...]

> Igor Paunovic (1):
>   accel/rocket: request the core clocks by name
>
> Jiaxing Hu (13):
>   accel/rocket: take the completion register writes under job_lock
>   accel/rocket: wait for a running IRQ handler before resetting a core
>   accel/rocket: let the core suspend after a reset
>   accel/rocket: factor the completion tail out of the IRQ handler
>   dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
>   dt-bindings: power: rockchip: allow resets in a power domain node
>   dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
>   pmdomain: rockchip: add optional per-domain power-on settle delay
>   pmdomain: rockchip: cycle optional power-domain resets on power-on
>   accel/rocket: select the per-core clock and reset counts from match
>     data
>   accel/rocket: add RK3576 NPU (RKNN) support
>   arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
>   arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
>
>  .../bindings/iommu/rockchip,iommu.yaml        |  28 ++++
>  .../npu/rockchip,rk3588-rknn-core.yaml        |  47 +++++-
>  .../power/rockchip,power-controller.yaml      |   8 +
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      |  22 +++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  86 +++++++++-
>  drivers/accel/rocket/rocket_core.c            |  32 +++-
>  drivers/accel/rocket/rocket_core.h            |  11 +-
>  drivers/accel/rocket/rocket_device.c          |   7 +-
>  drivers/accel/rocket/rocket_drv.c             |  42 ++++-
>  drivers/accel/rocket/rocket_drv.h             |   2 +
>  drivers/accel/rocket/rocket_job.c             | 151 +++++++++++++++---
>  drivers/pmdomain/rockchip/pm-domains.c        |  83 +++++++---
>  12 files changed, 456 insertions(+), 63 deletions(-)
>
>
> base-commit: 1a1de54f7369cd2b5bac0f265910e60ad3a6b4c3
> --
> 2.43.0
>

I assume it's fine for me to pick up patch7, 9 and 10 from this series
and funnel them via my pmdomain tree. If not, please let me know!

Kind regards
Uffe
