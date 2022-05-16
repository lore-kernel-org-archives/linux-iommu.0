Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF1BC433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 14:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 110A761088;
	Mon, 16 May 2022 14:07:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sWcQGh1VqH1s; Mon, 16 May 2022 14:07:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C8AA86106C;
	Mon, 16 May 2022 14:07:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDA1CC0032;
	Mon, 16 May 2022 14:07:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0FA4C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9984761085
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fY0MfvJ8_SkC for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 14:07:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BBE36106C
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:07:18 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id g17so2555136wrb.11
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=sM2sRGLVCJ3Fk4PRrn+4dC0xyoX9H+fcNcN8bioAh10=;
 b=XEldJpEHMASSsGBrI5Mmn0Pi9N670GLUxxVJp9B5HOBl43K97MwoAJgO8rLsByNaeb
 lGFHZLdSMp5plsxPECl1hu/RCE92lA3mQMUkELx5ggDkbKbIrRbWl2CF5epTn2VVa9Bk
 EKleAupnQa510VCDAbAdsbYftuIScC1x7XiBfKKGJN4+Q4XS1jPWRU5vVJ/+q3ubfCcV
 CqQx3Zr2V7XIS4AOAoBetY/mlyaYWA5HTpaVMVfXp3aqrxwJLDkgz7shVZ2/UZ8uhN3P
 XQJSOuKhPUftPUtyRVyYYoaZl0WFTnNY6kIltroHODF1It8/lBZoYSRFsyKFcmYNaD1w
 gFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=sM2sRGLVCJ3Fk4PRrn+4dC0xyoX9H+fcNcN8bioAh10=;
 b=TKW0qmlmpnwDNmB0qMK5A4c0RoSqYs6zZMjpefvZU0r/po8HYaB8XNdJpsetNhv94n
 Vvv9A7wKRGZBoDco+3FUzSMxPDgeL1If2aM8Ew8pCouXIW0wLvHcgdeXx9bxdCg6c7r4
 3EFmv7tjL6F8ICEr8FLsHLkA2cQADLfi/VFr4Ec8vo8aFlybsGN5RgjKdx5eb4HTzUhq
 6cZpZoPz5PFSAWhZhGOLMXo60l3z6Zc9rBm+3NOWlK4y6KaVqpuIS7Q2FOp8ydr8wtJj
 /esStd7Ia1rPqxAcHI13pWbvJFk1mbbWcxAttMBOF/zZeZwocprfe40V3wj5QkKm6fn5
 mBBg==
X-Gm-Message-State: AOAM533L6uu+R+9hrb4snak3NzVFL2ElQu570GH758cYGZNZbcL8nWLL
 Axbk6/E7Fi07Fy+lqM2t714=
X-Google-Smtp-Source: ABdhPJy6o0QTxOZPvxVZf6UA03LSbXaPI3cJ5caJlhMXQFfhV3BWO5alGfIPKD4PGJbIVes3G4Q8Uw==
X-Received: by 2002:a5d:4988:0:b0:20d:9b8:e560 with SMTP id
 r8-20020a5d4988000000b0020d09b8e560mr3799784wrq.33.1652710036571; 
 Mon, 16 May 2022 07:07:16 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
 by smtp.gmail.com with ESMTPSA id
 v8-20020adfa1c8000000b0020d050461c9sm5287367wrv.54.2022.05.16.07.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 07:07:15 -0700 (PDT)
Date: Mon, 16 May 2022 16:07:13 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu: Attach to host1x context device bus
Message-ID: <YoJakX0ms7rBF3ia@orome>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
 <20220516085258.1227691-6-cyndis@kapsi.fi>
 <20220516100721.GA1927@willie-the-truck>
 <4a170997-c893-1788-dcaa-8ed2193146ae@kapsi.fi>
 <099cf0f9-5c27-0247-7c5e-6704a9527b11@arm.com>
 <020a8244-760e-fe7c-594a-1d85e5645dbe@kapsi.fi>
MIME-Version: 1.0
In-Reply-To: <020a8244-760e-fe7c-594a-1d85e5645dbe@kapsi.fi>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
Cc: devicetree@vger.kernel.org, krzysztof.kozlowski@canonical.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4418105309888654325=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4418105309888654325==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pzcJQLU+ls3tyqds"
Content-Disposition: inline


--pzcJQLU+ls3tyqds
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 16, 2022 at 02:20:18PM +0300, Mikko Perttunen wrote:
> On 5/16/22 13:44, Robin Murphy wrote:
> > On 2022-05-16 11:13, Mikko Perttunen wrote:
> > > On 5/16/22 13:07, Will Deacon wrote:
> > > > On Mon, May 16, 2022 at 11:52:54AM +0300, cyndis@kapsi.fi wrote:
> > > > > From: Mikko Perttunen <mperttunen@nvidia.com>
> > > > >=20
> > > > > Set itself as the IOMMU for the host1x context device bus, contai=
ning
> > > > > "dummy" devices used for Host1x context isolation.
> > > > >=20
> > > > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > > > ---
> > > > > =C2=A0 drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++++++
> > > > > =C2=A0 1 file changed, 13 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > index 568cce590ccc..9ff54eaecf81 100644
> > > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > @@ -39,6 +39,7 @@
> > > > > =C2=A0 #include <linux/amba/bus.h>
> > > > > =C2=A0 #include <linux/fsl/mc.h>
> > > > > +#include <linux/host1x_context_bus.h>
> > > > > =C2=A0 #include "arm-smmu.h"
> > > > > @@ -2053,8 +2054,20 @@ static int arm_smmu_bus_init(struct
> > > > > iommu_ops *ops)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto err_reset_pci_ops;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0 #endif
> > > > > +#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
> > > > > +=C2=A0=C2=A0=C2=A0 if (!iommu_present(&host1x_context_device_bus=
_type)) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D bus_set_iommu=
(&host1x_context_device_bus_type, ops);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto err_reset_fsl_mc_ops;
> > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > +#endif
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > +err_reset_fsl_mc_ops: __maybe_unused;
> > > > > +#ifdef CONFIG_FSL_MC_BUS
> > > > > +=C2=A0=C2=A0=C2=A0 bus_set_iommu(&fsl_mc_bus_type, NULL);
> > > > > +#endif
> > > >=20
> > > > bus_set_iommu() is going away:
> > > >=20
> > > > https://lore.kernel.org/r/cover.1650890638.git.robin.murphy@arm.com
> > > >=20
> > > > Will
> > >=20
> > > Thanks for the heads-up. Robin had pointed out that this work was
> > > ongoing but I hadn't seen the patches yet. I'll look into it.
> >=20
> > Although that *is* currently blocked on the mystery intel-iommu problem
> > that I can't reproduce... If this series is ready to land right now for
> > 5.19 then in principle that might be the easiest option overall.
> > Hopefully at least patch #2 could sneak in so that the compile-time
> > dependencies are ready for me to roll up host1x into the next rebase of
> > "iommu: Always register bus notifiers".
> >=20
> > Cheers,
> > Robin.
>=20
> My guess is that the series as a whole is not ready to land in the 5.19
> timeframe, but #2 could be possible.
>=20
> Thierry, any opinion?

Dave and Daniel typically want new material to be in by -rc6 and I've
already sent the PR for this cycle. I can ask them if they'd take
another one, though, if it make things simpler for the next cycle.

Thierry

--pzcJQLU+ls3tyqds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKCWpEACgkQ3SOs138+
s6HS5g/+NDlKp3MuR8qOz2HUhNTb5hZJliQREJuGJiH3Lb+xlTr9HRTYFTog5h2o
/8FYXEz/xNe0Ksteb58UEMgTzATGtPWYulLdKMfCLgHRSw9jwEG6IOtCweZv5fNf
9oAzyL/ZTpTOF330ce1BRfk/PvlNVLnetImK4b8OGmaj9ZMgvfNhgJpzq0jSkf7S
hTZozfgJ++nan7UBRnZofuYzhpbDGrTAbxhTgksppbF0nM6AykU1je/eQBZL6I05
ASNkCmDqun5PBmXYyMZChBXBhJl6Di2qKGy1kuFwrT2/K8a1WghA+J4ZiW6nGCH+
9jcbkiXYNiq6T8mwywq3zxONLKKB2gDr07doUPHr2ERBfmXtG+X6lxXq97Zq+eyV
N8RGawUV8cCELULq/U9t7k9WjNtCLNiLIhXKGj7c1QNK8PervlLaJqY2+t1HQzwt
JFWZcP2I1S3246kEhCbh+mPTKS+J5HkOgfgbVRkjcDY/lZrcK1QLmvsL95UFIt1f
pPRcBG9O2CNtjsN2rH8mOHs7dMpR6G1562YhRiRjGJubFFCg5Tmt/Mt7KyER4HGS
kosQh4xTIxzi6Cs0RIXDO/2krGcibkv3vlWJBsxNczzpoq63d7TIjXM5WaV0UKqL
UreHGegFDP9Q2xzfuJhqmaYOYg/E/VuRbZOO19Zn28tLtD/wiGY=
=fv4K
-----END PGP SIGNATURE-----

--pzcJQLU+ls3tyqds--

--===============4418105309888654325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4418105309888654325==--
