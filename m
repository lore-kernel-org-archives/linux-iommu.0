Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01226C433FE
	for <iommu@archiver.kernel.org>; Tue,  8 Mar 2022 15:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D8F3402F3;
	Tue,  8 Mar 2022 15:59:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mEeIC1vop7eG; Tue,  8 Mar 2022 15:59:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 08E8D400D7;
	Tue,  8 Mar 2022 15:59:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D36F9C0012;
	Tue,  8 Mar 2022 15:59:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E2CEC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 15:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B895402F3
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 15:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id reNYI4KFcszO for <iommu@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 15:59:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EE0B400D7
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 15:59:14 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id g39so33020290lfv.10
 for <iommu@lists.linux-foundation.org>; Tue, 08 Mar 2022 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NaE7cTQwn70u1r2AKLM8OGzQ4OE9faei/DLoyJgl9jA=;
 b=VRPHWSeVxAe0zzcub9Ifrphfq3vr9WDr5L4YHSLIsd11VDwIpBZDRvRH8IbcY1OT72
 z9WZmwfmji8cFr3J12q5XmZqUEurVI2+O4IyvYE8GN5U2dxsGhx4onik/dTh2hVwYkFD
 85+7dOQJ5eJaXGacmAl3cAcqlVZdEJUSwiBB9SLFAAnpRWy0b7WhHdqmNurFl+2KUoZj
 NQu8CGHAskOJBctsWFmOCOE4gQcryo5tmKdNAxwqehxyP3mZLz9iWu5D3kaMZ5cis5LD
 ggjjXeyJ7zulpzmDNNGzijx1dbfzeaG3QH3r0TGrk5WZ/fdO18mDjoVcnBNRVl50zOLG
 V/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NaE7cTQwn70u1r2AKLM8OGzQ4OE9faei/DLoyJgl9jA=;
 b=vmiQowiDU99HcIBhXszL/2+w7W10NHcXBhLJnMS+zcXPU9jw817HSHF6AlbvC0wcFB
 rLP5MUOnF56V+XU8J1fig6h7HE7ua9l46aFMdDTTapePu6QIIAOMGxdMvEDMbL4Divto
 BbueivEacXNCoFThx3RolyRqHGhszmCA6X733A28wZB7eA9hqQipAzcw+lQIMlC4XygX
 xqcWvcSA1Z3nHr0WLdxqwweVfWAD9Qka2ZbriFH4+1dRBPJETAeKtVyalFWSnlyAK723
 B5KU1FFiyKWRH1CHeCSapL8qsJdWBgvY5kYvz+h5YvB6V3ITtrXYQzOpVW/hUbBrXVS8
 IjKA==
X-Gm-Message-State: AOAM532KC3/z7VytADxRHIJ2lpn7VkeSEnxv8JIvr2Xzhc4eubCof/oN
 zchtpVHeahdgXEF6VPE8i2k=
X-Google-Smtp-Source: ABdhPJz3GlGEMEtV6DBobJaEdrCeckQzYNCFVzAA4bMQl2QX29aS9D+umGV5hV0A6B1ySdUHX2ipjg==
X-Received: by 2002:a05:6512:33c6:b0:446:e0ce:5c3c with SMTP id
 d6-20020a05651233c600b00446e0ce5c3cmr11894879lfg.26.1646755152081; 
 Tue, 08 Mar 2022 07:59:12 -0800 (PST)
Received: from orome (p200300e41f181700000000000000043a.dip0.t-ipconnect.de.
 [2003:e4:1f18:1700::43a]) by smtp.gmail.com with ESMTPSA id
 p8-20020a2ea408000000b00247e5087157sm1471161ljn.101.2022.03.08.07.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 07:59:10 -0800 (PST)
Date: Tue, 8 Mar 2022 16:59:05 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm-smmu: Document
 nvidia,memory-controller property
Message-ID: <Yid9SWbpPQQhNgA4@orome>
References: <20211209163600.609613-1-thierry.reding@gmail.com>
 <Ygz7QD4EJX3vZJtD@orome>
MIME-Version: 1.0
In-Reply-To: <Ygz7QD4EJX3vZJtD@orome>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 Jon Hunter <jonathanh@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============7267975407343027666=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7267975407343027666==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rFDGFzVNzKne2qqP"
Content-Disposition: inline


--rFDGFzVNzKne2qqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2022 at 02:25:20PM +0100, Thierry Reding wrote:
> On Thu, Dec 09, 2021 at 05:35:57PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > On NVIDIA SoC's the ARM SMMU needs to interact with the memory
> > controller in order to map memory clients to the corresponding stream
> > IDs. Document how the nvidia,memory-controller property can be used to
> > achieve this.
> >=20
> > Note that this is a backwards-incompatible change that is, however,
> > necessary to ensure correctness. Without the new property, most of the
> > devices would still work but it is not guaranteed that all will.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v2:
> > - clarify why the new nvidia,memory-controller property is required
> >=20
> >  .../devicetree/bindings/iommu/arm,smmu.yaml     | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
>=20
> Hi Joerg,
>=20
> can you pick up patches 1-3 of this series? DT bindings have been
> reviewed by Rob and Will acked the ARM SMMU change. I can take the
> device tree changes (patch 4) through the Tegra tree.

Will, Robin, Joerg,

I haven't seen this show up in linux-next yet but was hoping to see this
go in for v5.18. Anything I can do to help this move along?

Thanks,
Thierry

--rFDGFzVNzKne2qqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmInfUkACgkQ3SOs138+
s6G49w//Ygjl2iHsMwI94cYoUH9dcGuDS8MJQNrU1Cnul3dW5pIzNyFYD6S2n3AU
gK/YYeZA1Ik8G4Q/Um+xmNSC0ZOVMng6fVmjpL2xVdOv1qeN135Hue1QZuUXzFV9
6fas+Y260jHRvPG1t0oS/HEvzmlRwDiYoKQe7h26kH9BpdLj/H0aMWhlu3Cb/coi
UnypSm2sScPaIuCY1/cPlb50NrgxqQ4R/LrNa6Aud/x+HsZTPCMHCOLPnQUvkYyR
Q/DEIFW8lyqJeOskopyuOqd43fPpzY+1Y0NwJuZhcpk0x4ikt8hh3J04eaEHsP67
af0twj+ENQvJ4fKiH0I1E38xtPi5uhtAKlTHU0hJs5LgZyoGLTvhiNAp7oOgSZXy
0I61nD65TBAqiv6AmpgFkXNRMBaS17BlkuhrwbKtbCwI+hbV8ppZSSbJr/AVQoDi
oo6QaGhkMYNVRUnXRA7Vi5mA32vxOf/5328W4SS9OTs7kV7xeRNsfHe6ZXOtqzc+
f2WUOfSJ3FgCEoAITsCCMK9NI6oaqMBSQOFsTG4yuXgYn2Px3PdgfRVE6X7cBbYr
0aTiGmzx3Im8dUSm82LZovu55yDlJZ0Q0/EU+zNLfQC2rs2biLhJyNqcRgD6fCmH
2W0sB+udBwSjicEc3XNRzk70i3J++uk7f1oQ6Ak+gL0Dvl2YBBY=
=z2UF
-----END PGP SIGNATURE-----

--rFDGFzVNzKne2qqP--

--===============7267975407343027666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7267975407343027666==--
