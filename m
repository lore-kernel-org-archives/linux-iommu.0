Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A608C43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 12:36:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C826A20731
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 12:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKJB7Rpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C826A20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A1B0787091;
	Tue, 15 Sep 2020 12:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hXrpiWUzxmLy; Tue, 15 Sep 2020 12:36:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA2F687028;
	Tue, 15 Sep 2020 12:36:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCD99C0859;
	Tue, 15 Sep 2020 12:36:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B70E0C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 12:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A9636866B8
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 12:36:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xBjgr3LMmPEG for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 12:36:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9674486693
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 12:36:52 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id r7so4761346ejs.11
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QMpHViZdWCmsMdl07XVFEUzlf6tpqXDt+wbPmBI/w5E=;
 b=fKJB7Rpvs15tCZdwop3qOFSTTdal+hWhYT8c3itQLABzVVqBO3fvJ1j7FVFx6ugcMx
 nKtdwMl97GuhV5nxql1UgudP77EzRJD5gljZS3Zrdx1PP5xtWcKwmBoR6UQkOb+K/Grk
 EQP04rSJ19Z0+k2BG6WyRktUvDvEfhGCYfLorgwlgDR7KCU00L0fiNgw/Cp7pU/iz/uB
 X5oqz05HfHpEQxVC1YwDdbGdFZhvZ71IAYlZawHEw0QplWtTviWBRnRr2FBvVEw5YRHy
 QCY7pS2t6tQrLt6Zaji58/tK+TG4WVZ7gYnsqXPIjB9BXPWxSDw9XZ3LGufbki4ZQLhH
 aCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QMpHViZdWCmsMdl07XVFEUzlf6tpqXDt+wbPmBI/w5E=;
 b=gZ0uTEG/toQfkY7l/0Wi8azcW4XP5Er82mYiLEVA2lhJHTGzp7a8Ja+BixtnMqFyne
 yHsnviVy5CeFtvtVqsjy5H8nWSIVlmwa9sDRC3bil5Mc3hPC0XLbjoRkHGUvWXYtMyXi
 wy5ehM2hlE1FnvwcRnO8KbnTD1fncaSy6wrFAJhFlIQTktCDyCfJ0USSVmz2a2juS+Px
 vpLlW0HD1No/7rBVQGcoELyFxXvYvdyb+MDydMxi5u5TLcjGBP00h20qpULNcpwIq1gR
 spxDAhvaXW/FEYvQdFW/u0jlJtXbdhgouqpaHYUlt8Ffq59Eo5jvMg/LTHj+GVPId2Tw
 2dHA==
X-Gm-Message-State: AOAM533Lz7c/sITYHFx84BENzPi4Jvbsrw/xFabRxYGInDbx+qDXRvdx
 7oZSaQHHuE6NY1xIP+IU70Q=
X-Google-Smtp-Source: ABdhPJzeu2PzrU8ZEiZBJ27cD9bDlgE0IOExue7Tqm+piwpRBwWsICa/ReD+KBQ14Mk5ZKs3GvW7xg==
X-Received: by 2002:a17:906:3e08:: with SMTP id
 k8mr19458790eji.480.1600173411066; 
 Tue, 15 Sep 2020 05:36:51 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id u9sm10180440eje.119.2020.09.15.05.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:36:49 -0700 (PDT)
Date: Tue, 15 Sep 2020 14:36:48 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20200915123648.GA3496938@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <20200914220829.GA330122@bogus>
MIME-Version: 1.0
In-Reply-To: <20200914220829.GA330122@bogus>
User-Agent: Mutt/1.14.6 (2020-07-11)
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============5312647549777990704=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5312647549777990704==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 04:08:29PM -0600, Rob Herring wrote:
> On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Reserved memory regions can be marked as "active" if hardware is
> > expected to access the regions during boot and before the operating
> > system can take control. One example where this is useful is for the
> > operating system to infer whether the region needs to be identity-
> > mapped through an IOMMU.
>=20
> I like simple solutions, but this hardly seems adequate to solve the=20
> problem of passing IOMMU setup from bootloader/firmware to the OS. Like=
=20
> what is the IOVA that's supposed to be used if identity mapping is not=20
> used?

The assumption here is that if the region is not active there is no need
for the IOVA to be specified because the kernel will allocate memory and
assign any IOVA of its choosing.

Also, note that this is not meant as a way of passing IOMMU setup from
the bootloader or firmware to the OS. The purpose of this is to specify
that some region of memory is actively being accessed during boot. The
particular case that I'm looking at is where the bootloader set up a
splash screen and keeps it on during boot. The bootloader has not set up
an IOMMU mapping and the identity mapping serves as a way of keeping the
accesses by the display hardware working during the transitional period
after the IOMMU translations have been enabled by the kernel but before
the kernel display driver has had a chance to set up its own IOMMU
mappings.

> If you know enough about the regions to assume identity mapping, then=20
> can't you know if active or not?

We could alternatively add some property that describes the region as
requiring an identity mapping. But note that we can't make any
assumptions here about the usage of these regions because the IOMMU
driver simply has no way of knowing what they are being used for.

Some additional information is required in device tree for the IOMMU
driver to be able to make that decision.

Thierry

>=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../bindings/reserved-memory/reserved-memory.txt           | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved=
-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-me=
mory.txt
> > index 4dd20de6977f..163d2927e4fc 100644
> > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory=
=2Etxt
> > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory=
=2Etxt
> > @@ -63,6 +63,13 @@ reusable (optional) - empty property
> >        able to reclaim it back. Typically that means that the operating
> >        system can use that region to store volatile or cached data that
> >        can be otherwise regenerated or migrated elsewhere.
> > +active (optional) - empty property
> > +    - If this property is set for a reserved memory region, it indicat=
es
> > +      that some piece of hardware may be actively accessing this regio=
n.
> > +      Should the operating system want to enable IOMMU protection for a
> > +      device, all active memory regions must have been identity-mapped
> > +      in order to ensure that non-quiescent hardware during boot can
> > +      continue to access the memory.
> > =20
> >  Linux implementation note:
> >  - If a "linux,cma-default" property is present, then Linux will use the
> > --=20
> > 2.28.0
> >=20

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9gtV0ACgkQ3SOs138+
s6Edvg/8DciSGbTBg9+QDCo01JmHSUcC8htGJTlXuHqgxjs9aS7GagCow3ajODFU
MSr4b79jqQCwcDGMeVRuklj2fs4GdoPHLLnMggHd82BWo/xaWTHk4onv18igkGTz
kq9eZkZauKzBCzRt/+XpaWO20MUYFNWcBRIw9veUcTJ4Gt0Tf68BnCW4APxEzlM6
luZ+dPvzcwWnLM7406Kira+Rsl6GQvUPkqL1qazjV2lfAiFnFfl/PIGszXDmmbzS
4gL9aAXiEVE9J3JjyKT4USswjMqeSeCYE5nUz9YD/jruzmw8gtgocgINrDvDZ6yJ
q2eZdqG+EbqMZhfsvcf7zfg+XwptbaDLTWrx0P8wABT3sndwa15uIN6TN9xcPFg3
0AdTGfv4g5iCHf/DS3ATsDEybX3a6RwVKBRuQeZDZ8/PiL4x1jSTUsqBtuniAKdJ
lc1rFBHwW8JzbTJQhlMSs9ceINz/RfK3BR0KLUaSWCAbTsLZQ05kX2IkTiCdmOLp
/mrRvT5/e2rrWOAM8xrrRovwobZQ2bSk0dsc2h5XSkG0kbfxrYHu/UhhVsRIL085
GjdwI4F9zwhIBnVODvsYXhUvGtHgpgxO3nZE02RMOeh7luKVwIpOt/KZPdcmUCR+
5C+bzZcbeDY13rs/Gpe2oLjvUjBneMyFI7w+VuJEYWHZkqIeAa4=
=ehzD
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

--===============5312647549777990704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5312647549777990704==--
