Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EC4C433FE
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 15:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88DE5833DB;
	Thu,  5 May 2022 15:27:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cRhlbBQE7TnE; Thu,  5 May 2022 15:27:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 770FB82D14;
	Thu,  5 May 2022 15:27:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47468C0032;
	Thu,  5 May 2022 15:27:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0962EC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 15:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E59A360AC1
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 15:27:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3YfWd0jF1FhU for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 15:27:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FEAC60AC0
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 15:27:11 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 125-20020a1c1983000000b003941f354c62so2871542wmz.0
 for <iommu@lists.linux-foundation.org>; Thu, 05 May 2022 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AsbVHOFwEzbENgUiINJNKlcNnthez9FtGuKRd9bJU0Q=;
 b=L44+FNVBy2LcI/Wpq7mve6CtuCCln7dMPntaf0wyQgMFGhFgpCTm8hT8vWRb4tNkqY
 rDpa6hJSh7cfL6z5c5TgvQgPNFMS9PMPP6mBDYb8ZzF4yp9JVHPhKzmsKXFLDBarRrUv
 EQtN23vhcYaxjULfV8LdALu6QTp4phEFJ01uGDs3WIe+D5ckypeA5eVwM81E0ymp58p+
 E8OcQ3QJaKRmmoK/eTf9wDMIKaZbPHuASBuuZIyZCjAUqg3pPbwD9WeHvbBZFq3TZoip
 PybIqxlGyS7GL5+e15n4jTFz1a2aVdsQSsvVDpbhfzwBS2VdwYXN7bmULkcbiZSo58kg
 IevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AsbVHOFwEzbENgUiINJNKlcNnthez9FtGuKRd9bJU0Q=;
 b=YW1OWjwPeOHb/jhAeAVHvrg6eCmPe2d/Il33GPkY1t8jk0AD1AZZ7nArJttnYtd5N8
 q+Vh4K12Qtfe5CKsAj6EfD/hUFqSwyCtTkJ1ZUVERImzudA5uiWcO/6vFYuQP9SkTFwW
 oMYu0xMpmcOrO7exnvSdGZlZLGz8hKJPvYDG96SCvUH3WyJaH7BHOMI2MZzl4czfWTIZ
 LcScRgVRFBw5h57O1M8tiUQXTjePeaBK0NRxggPx/PyB0fsxJ5afC5bAfdopW3aOB1wr
 eAKDCco6vYq617ONj5KCNSi97BBtsmPGbdMDei3sMXKnoiy9RFUrExmA965sd6nDCnv/
 p/Kg==
X-Gm-Message-State: AOAM531nyCG/fTjswlAMyu76HbWY8WJFFLV/f4nSvwjT/GPZZq1Q4bxU
 +6iTCaMee26WLcWgi5BX9RM=
X-Google-Smtp-Source: ABdhPJzhK3cVpMTWp5aUmjJ/mxWWqc5zxs4by9iExAgUoObAITmMMpuVrUTXW2ghV5IvdvNSNv+2fA==
X-Received: by 2002:a05:600c:3ca3:b0:392:990b:af11 with SMTP id
 bg35-20020a05600c3ca300b00392990baf11mr5551638wmb.173.1651764429170; 
 Thu, 05 May 2022 08:27:09 -0700 (PDT)
Received: from orome ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 x18-20020adfdd92000000b0020c5253d915sm1421119wrl.97.2022.05.05.08.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 May 2022 08:27:08 -0700 (PDT)
Date: Thu, 5 May 2022 17:27:05 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/3] iommu/arm-smmu: Support Tegra234 SMMU
Message-ID: <YnPsyWat5sZ8HeaB@orome>
References: <20220429082243.496000-1-thierry.reding@gmail.com>
 <YnPcAaQTMRsNEQYJ@orome> <20220505145307.GA21784@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20220505145307.GA21784@willie-the-truck>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
Cc: linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============8576284453879638490=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8576284453879638490==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r5YBw2N1nTwRTJ8D"
Content-Disposition: inline


--r5YBw2N1nTwRTJ8D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2022 at 03:53:08PM +0100, Will Deacon wrote:
> On Thu, May 05, 2022 at 04:15:29PM +0200, Thierry Reding wrote:
> > On Fri, Apr 29, 2022 at 10:22:40AM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > Hi Joerg,
> > >=20
> > > this is essentially a resend of v2 with a Acked-by:s from Robin and W=
ill
> > > added. These have been on the list for quite a while now, but apparen=
tly
> > > there was a misunderstanding, so neither you nor Will picked this up.
> > >=20
> > > Since Will acked these, I think it's probably best for you to pick th=
ese
> > > up directly. If not, let me know and I'll work with Will to merge via
> > > the ARM SMMU tree.
> > >=20
> > > Thanks,
> > > Thierry
> > >=20
> > > Thierry Reding (3):
> > >   dt-bindings: arm-smmu: Document nvidia,memory-controller property
> > >   dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
> > >   iommu/arm-smmu: Support Tegra234 SMMU
> > >=20
> > >  .../devicetree/bindings/iommu/arm,smmu.yaml   | 23 +++++++++++++++++=
--
> > >  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |  3 ++-
> > >  2 files changed, 23 insertions(+), 3 deletions(-)
> >=20
> > Joerg,
> >=20
> > anything left to do on this from your perspective, or can this go into
> > v5.19?
>=20
> I'll pick them up in the Arm SMMU queue, as there are some other SMMU
> patches kicking around and we may as well keep them all together.

Sounds good, thanks!

Thierry

--r5YBw2N1nTwRTJ8D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJz7MkACgkQ3SOs138+
s6GDMA/+NCme2MLVnG6NC+zLURn3r3hDKe73ocpeZlPhgIdkUOnx5a6Cqfw2exxf
tI9sLZZXvr+sJH+AFxhktdCTdL3IRL9U0wY7L0XJHGEcfCe02Fa8LwT+/zT/NT4q
GsglRWi3QDnNHXvIm1F2+rRrDnuGyZKl3Fpt/5DmgY3z1p9vt3lcp77yWmjvTcUc
Oag6cRev4IoDU84dPinpyyU7aOZf0ii5aBsCD7tSleJ6WasbA6YKqiDpQq59T1am
yNS8xFfAv3zJhFLxi0mK5ZP8l2qayUbmfS2Tw9Yt9y0nyJGR3q/c2cCmFhGZ9bAQ
5VTYLuTZ7UI9O6/Ml4FepOyQsB6znyvFsfNi/QXiXjIhMHoOVWm31P3TJj65I5xw
j6ZH7hlpUJ/s3L9AOg+Y8qY6ezpEnOwWRXFnaYshxC7tGyDo3ByQuAvB3OZ20aAN
Xkq2rkrwbsgL4nHdmxI14HLSeLZafZkuWo9KcrhnzRlJYbblGRE2c0h1TSw9sQjg
vMU9E4qeQO5aHoYOltmV9QTE5M/WGC+uXlB3ef4xCzo3kFs/5xQjDM0lC4gETRL0
D5VMPfl3m6fmkpHgVhBWbW153SCfRVycWNzwsytC3HRMBgFDqWjnYubE9qTpo/8v
8VBunt9uP87XNWxUOYnkVK8+Uf/vp2CWH9IAYou3nJMvFBJ3PHE=
=W9qu
-----END PGP SIGNATURE-----

--r5YBw2N1nTwRTJ8D--

--===============8576284453879638490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8576284453879638490==--
