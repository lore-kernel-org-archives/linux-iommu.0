Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9A37C915
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481738; cv=pass; b=jQsrjR49V+8l0boGDrD/45hpg4F71hoZugtez2MUmB1P44kFVEP9r2qkcDS2orjny8TIsIWbE7aqKc0ieQBVLtZgzFF5I6kvWhJPNBb2ynf1XA5B1iUUwilhiFYF38t5FRdFdvC03B7fAEYYk+7hu/zooAWizR/5g+Ppx1xff64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481738; c=relaxed/simple;
	bh=ImyaRmLghxFwQsTJnShE9IsVAyUjBEQQdEnQ0b9Byos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cux8LO6DIEroN2FMUt31ceZxAp4PLwqVYp0YJ5eEORV3uTE0GRatnv7+pDsDb9KFvYqw7H7F2nnWYGgRS9AoQzigXzlM+haqVP4MUpTIpar8EGP8YDp+VPUwO0sHc/CGBx3jXPmzjcu5SHf9tCqTHoQCymqjfr5imIrLNJfhSl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RV/ZBQBW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SV0VS4tf; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RV/ZBQBW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SV0VS4tf"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RPjA873803
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 10:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=; b=RV/ZBQBW1Gz7WB7g
	C36gOhNhdL+lLAmqQlpap6noJbbxHcrt5EIxi83XQdvwRajDeMt1YFcY+H3mGLXT
	9XatmhW6r/yTEhIszMkIGbMkNaO+fyhhVMzwIGL7bcpZ9ReeDX5jEpLuRbcstKSQ
	YhnhXEg7Vp0lJ0rPhBLgdWq78t4NPOsw/LugKMhQPSnThw01mcIgA9my3R2A/CFD
	SMxSsEToum0RhiBvscPxkFsFs1FxqjfwWOQrc5lvshnJbrHXt0WtI8psq0P5nZyX
	LEs1LzosAOE89oi/Bezr5wGe+ccK2iGDRjqfsqOH5hQOImzaSe/nMOk3SRXe02I+
	vbBXAg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ej6a9jxg2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 10:15:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ccdfe1ff26so85824776d6.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 03:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481735; cv=none;
        d=google.com; s=arc-20240605;
        b=dU10diARXYrbwOiREavjagYX77h5Zsa25PzHikoxFawZak252ypfzddPM6OMohNJfb
         BIubEbqyW7RHVt+EDhhMWUbDSfbASsYgEn6F0jrI+vNdiIcjxzDkaIlUDjaK8prwaaSE
         +Cocbp14jwzuGibBWGsACF2fBS8YD0iO1hUnu4gjEy23mTN0UTBpoWMiPZWd+WPQZhKF
         KVKq+nwftNc/E+pnIxnVGhjlYoRgRYTV2ITSxh8PKJt1GnGtPEA12ieqSxfDcR6Lt87W
         a8Ty2qE+2XpveOpeaXcUE79tzaqmcxz7Tgdy2+2UpmO3T0Z8bK6rVJtEIoF1n6hgcrU2
         rZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
        fh=JXUxUmdAD6N8nCyr7qMMut5Ol3DZKuj36GCE2j7NkHI=;
        b=URXFYhyCB/vyz+ncEaOiMRAKELUexUX+1rJhH7aVVeLo10wOFPITtfZUeIDx9LzOmo
         6G51D0RGfAombr2V1b4Z6eTIQcxIfIwLtaOM7j2EAzv11n4QnpJVEu1nyumFo4zbCq6X
         CMjM0iOusMWbjX9Y5SbsE2IKLTpHZnWHlqiNm6p/IFhb0NWUurrrBCuN1136VGe/G5S8
         MiiU84VpSvbeZa4alIFoxIedaa+BHf+0yiQylVTCudwd6gTviOvf/AisHmU9rswG8UKl
         ioRyqnZLCo6v4d88dMCWqlzPY4d1JdMMqxKL+N5kmROiJR/X4f9yRSDhUczoJvaKQUoX
         fYIg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481735; x=1781086535; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
        b=SV0VS4tf3FdUe5U+DPPF77N4VtXQF8ccSvYC6qZegUTlSAtFvQF215ftZzpXNWcYt8
         p1HCaXK7xaXg2lYKhZGXrnylual3x7yyj4KbabHxgRefTHmE6+3/oAD6snQrpMBIjOng
         ierth8X0Jv8Y2+Utn6xI2JKKn+ry4dCzXYbAx9jKddScWAARlGNhU6ycL8BwKqJE5B7L
         5D7bJ7NYZGiY12Ozclizq9uF3rvJil4k7iH3zijpm6XkmXvPhgGDK/mO9DqzGEntGcOD
         gXienBa73K5cwgnZZXFutEd37BkSRrEOZSCrScI6VvWvCmamlqRSJpb3tVrF9hz33ekM
         YkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481735; x=1781086535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
        b=cfa6zpCcTZOTs3Ftm4KVJiHeQFF4fxpWvWEA2M+BdCT+5HOmNiCzku0qJNdledBdTZ
         BLHUHZbTdCoodf7AHTzsY4749YdUGZ/1UXYplQHfgnX8+tUO+Sui4N0GadCmE3ueK6mL
         19Eu1l49glcdNUoX2Wc/V0I1Z5fjPIla6KYZu1uhO8ge3u3RdlSBuwgcSD5fR5t66CLn
         /ZHgMVzkSEoKzGXujEx/gpbAWKJbL3KacVCF7l3/e2MOO4k1qX1decl+CgA+y4mXykIg
         Z2/ZAVWMrYgRjlBtcZzp19Zp+OEYWk8VfD2LR6Vo43PE0U2H73IjzHurRp6Ju4Z8BpDN
         eKtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/KOVMDFwkYjWdU4B3s0x3Al+mm0bdfTEf2KwFlBy5YnJysT66AqoEk259DqmGQv6gntqzYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfQaDC1SNEzb1kh9LImjOJ6Mv8zYPXyCGEDyEw0BJPttkGGByK
	9HeYhslsTCWFaUwSt5O0vGKYzicl4eczbWag1KggdSL1u1EZUJLCqG/o7pNmW1mt80rBGdaoxG/
	A69sM0XnizJmQ7h6hzu+7ChzExpeZboS6LAl24fdcPZAEYF/RVKWbJFVRrjlHpeEnZXjuRtB06a
	aMzcMDXlVOu6PeweuEfTYkfH9XtdRgSlWC
X-Gm-Gg: Acq92OFrbmAQPCBSGFOiVbOaV4EVW6QCev+femuVRd7XXc5lYmGefI2xaICT02EDlxS
	pcetyq5uYxQ34B0QNsiFuVtnTasKsOp+CcLNgK4JFGURb14bTYKyspbTFEeZtdVx4LOQ7YFJ3iu
	Sxno5hBqBkO6JNWtAOXuRxoItru10DMHL3ibhIO//NPq5XgKOl4yiLlFtry9FXPjBOxXFg+8K0V
	NX2bb6/bzVyChqn
X-Received: by 2002:ad4:4984:0:b0:8cc:6c08:552f with SMTP id 6a1803df08f44-8cecdc03682mr27952066d6.9.1780481734753;
        Wed, 03 Jun 2026 03:15:34 -0700 (PDT)
X-Received: by 2002:ad4:4984:0:b0:8cc:6c08:552f with SMTP id
 6a1803df08f44-8cecdc03682mr27951226d6.9.1780481734358; Wed, 03 Jun 2026
 03:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com> <20260521-pdev-fwnode-ref-v1-4-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-4-88c324a1b8d2@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:15:23 +0200
X-Gm-Features: AVHnY4J4K5UzPNs1yW8q3X0LoIQq3c8UfPuD4kHDjf5PzjApCRf1PSF1rlsmtoU
Message-ID: <CAPx+jO9iJBx6Yifap55NOhn5YZk8Bbwpnk+aeH+0PgYuMxke1Q@mail.gmail.com>
Subject: Re: [PATCH 04/23] pmdomain: imx: fix OF node refcount
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 1WI4Z3lmh5NOC-t8emJSuTMlEKKaZVQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX7/u2OQELmlsR
 IkAUKPe0W0Y5+AZTgLtUsNU5YkaYkpP30PgKmE5N0vYlqOwLrX/7Kdl9MlgQJYpqg/6HWiwnm0a
 IX99V0uLmE8z4CHws7mjK8O8rf7SlHeAdOJIe7rMK/yS4BbhlbwSPqXWfAYZBt7crlrKcE1hRYP
 8GODG5gTD8wVlmFpzDZtYBHqof/x3VrL4IIDiIchhOE3RMtU63IfzUWE5SYl0I3z5SKVQ7ctay6
 XaZism/Q9qTP/iszo6q78rGbyQTRHhceKPemF4RE36C45wLDJhuz5IAA4eEsESAqRdZ7bJWGZn8
 LpO15yoKSZZmLRZsgz7nPzTMtRucKw7OVLgtNciehALuFtN2/hF23HupnuVhxF7jRP+v9/jRfKl
 MkmKrGgvnW2tooSGsSb+n1EajkzpTb8W6wYAT2dIWDMlRUpfV5qX5XDMc4aBapLcQPk8CAKKvsW
 zj9/LCDVBPdFR4rLo9w==
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a1ffec7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=RwuSGLWl7VkFDbmKPUAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 1WI4Z3lmh5NOC-t8emJSuTMlEKKaZVQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030097

On Thu, May 21, 2026 at 10:36=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> for_each_child_of_node_scoped() decrements the reference count of the
> nod after each iteration. Assigning it without incrementing the refcount
> to a dynamically allocated platform device will result in a double put
> in platform_device_release(). Add the missing call to of_node_get().
>
> Cc: stable@vger.kernel.org
> Fixes: 3e4d109ee8fc ("pmdomain: imx: gpc: Simplify with scoped for each O=
F child loop")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index de695f1944ab31de3d37ce8000d0c577579d64f9..42e50c9b4fb9ffb96a20a462d=
4eb5168942a893c 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       pd_pdev->dev.of_node =3D np;
> +                       pd_pdev->dev.of_node =3D of_node_get(np);
>                         pd_pdev->dev.fwnode =3D of_fwnode_handle(np);
>
>                         ret =3D platform_device_add(pd_pdev);
>
> --
> 2.47.3
