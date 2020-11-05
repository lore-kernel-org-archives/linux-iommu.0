Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C42C5517A
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 16:23:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85B8221FA
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODPCIZLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85B8221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 771C686665;
	Thu,  5 Nov 2020 16:23:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PI4w7Rxeme5n; Thu,  5 Nov 2020 16:23:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B61168665F;
	Thu,  5 Nov 2020 16:23:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4A78C0893;
	Thu,  5 Nov 2020 16:23:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BE99C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 16:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 94E1386663
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 16:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jieXMfsTQDNi for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 16:23:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8896C8665F
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 16:23:44 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id v4so2179258edi.0
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Hu62pbz3neBXikSEmZ96SWPoUOawE1pLh+7ImLoJflk=;
 b=ODPCIZLT9TxECYCyI34q91uUAYLgf1QXIkyyrMHTZc2oG7+nMbbeYH0ZBTz0jUD8+T
 UfHs2aB8JxpS5ENaGWHH7IWJyJJWVY66hsJrTKGOOFhNIm5RUBYJxsaSFWwBCGBB23Qc
 dDlVdhL9GM94iNNakLW4OgUyPE8UQGCaSvKHhzvwfdaJQroJZZibnBaw2KHrS+92TeDx
 uzb6zPSUDemAJqWh2x6y5X8fT6iDesPSGoIdGUf9jtvyr/YFbts0mR4kZGbcoZwWECTP
 JqwVSKBnbhRf8Mbe3Q6ExfgUmUii7LVwACDjrLTVNu3nP1uAxuvP/SKsHHzLbpS3ioEV
 i+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Hu62pbz3neBXikSEmZ96SWPoUOawE1pLh+7ImLoJflk=;
 b=YgLA3e7vzkZ9s6D4RqW0jdUm2lgSwAdhtY56E6Qj5rB3GHhi0Io+ekV8T18REr1RRX
 9tvC2V5oWMziXmObOeEaNH/0TE5TCwbZbkO3ZRiUteNasUmZWr/cgrchAz2X7LNPFnIW
 GxuCWK6maIKWepPFEp7NotisqIGnzP+HKQcdjFnrQTXjnDvovRwW9cymxPT376OY/MLs
 4HIwGGF3T+/8Q2/b1XL55/VWYRws1hwpQPS++qLMRI9gnPQEThnEG8u9fR+ieqd/J9Wj
 rhOXDcMQ4IjwgvoUYtQeU08LErQDcCE5Gu7mdI0/6Y7+Z3e9wUcZimtdxvaIs+uchoKV
 fX1w==
X-Gm-Message-State: AOAM533r8PNjMtuvbbmmGmR3SfE5HFxl+kWVr/vXGCUvhFAEgZWrPSSJ
 yM5e55U29CVaEj7IbYGXQ7U=
X-Google-Smtp-Source: ABdhPJwtkbqUO5nQP/ZnEkBUiql0jynh2IPlmxMX5hd6q7UtoT97fCCdkNL4Y8AU+grGmbc2FNSdog==
X-Received: by 2002:aa7:dd49:: with SMTP id o9mr3295364edw.143.1604593422985; 
 Thu, 05 Nov 2020 08:23:42 -0800 (PST)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id bg4sm1252002ejb.24.2020.11.05.08.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 08:23:41 -0800 (PST)
Date: Thu, 5 Nov 2020 17:23:40 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20201105162340.GC485884@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <d3d69cb4-b0f9-40b0-b526-52fdc1a4b876@gmail.com>
 <20200924140130.GA2527337@ulmo>
 <ba16b795-34df-8f8c-3376-3d629cc30f8b@gmail.com>
 <484b9e90-7395-6161-577c-4d3f3716997e@arm.com>
 <70712ca4-8971-3af4-d0d0-b73788d6cfa9@gmail.com>
MIME-Version: 1.0
In-Reply-To: <70712ca4-8971-3af4-d0d0-b73788d6cfa9@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4168314202390961999=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4168314202390961999==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 04:21:17PM +0300, Dmitry Osipenko wrote:
> 25.09.2020 15:39, Robin Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> >> IIRC, in the past Robin Murphy was suggesting to read out hardware sta=
te
> >> early during kernel boot in order to find what regions are in use by
> >> hardware.
> >=20
> > I doubt I suggested that in general, because I've always firmly believed
> > it to be a terrible idea. I've debugged too many cases where firmware or
> > kexec has inadvertently left DMA running and corrupted kernel memory, so
> > in general we definitely *don't* want to blindly trust random hardware
> > state. Anything I may have said in relation to Qualcomm's fundamentally
> > broken hypervisor/bootloader setup should not be considered outside that
> > specific context ;)
> >=20
> > Robin.
> >=20
> >> I think it should be easy to do for the display controller since we
> >> could check clock and PD states in order to decide whether DC's IO cou=
ld
> >> be accessed and then read out the FB pointer and size. I guess it shou=
ld
> >> take about hundred lines of code.
>=20
> The active DMA is indeed very dangerous, but it's a bit less dangerous
> in a case of read-only DMA.
>=20
> I got another idea of how we could benefit from the active display
> hardware. Maybe we could do the following:
>=20
> 1. Check whether display is active
>=20
> 2. Allocate CMA that matches the FB size
>=20
> 3. Create identity mapping for the CMA
>=20
> 4. Switch display framebuffer to our CMA
>=20
> 5. Create very early simple-framebuffer out of the CMA
>=20
> 6. Once Tegra DRM driver is loaded, it will kick out the simple-fb, and
> thus, release temporal CMA and identity mapping.
>=20
> This will provide us with a very early framebuffer output and it will
> work on all devices out-of-the-box!

Well that's already kind of what this is trying to achieve, only
skipping the CMA step because the memory is already there and actively
being scanned out from. The problem with your sequence above is first
that you have to allocate from CMA, which means that this has to wait
until CMA becomes available. That's fairly early, but it's not
immediately there. Until you get to that point, there's always the
potential for the display controller to read out from memory that may
now be used for something else. As you said, read-only active DMA isn't
as dangerous as write DMA, but it's not very nice either.

Furthermore, your point 5. above requires device-specific knowledge and
as I mentioned earlier that requires a small, but not necessarily
trivial, device-specific driver to work, which is very impractical for
multi-platform kernels.

There's nothing preventing these reserved-memory regions from being
reused to implement simple-framebuffer. I could in fact imagine a fairly
simple extension to the existing simple-framebuffer binding that could
look like this for Tegra:

	dc@52000000 {
		compatible =3D "nvidia,tegra210-display", "simple-framebuffer";
		...
		memory-region =3D <&framebuffer>;
		width =3D <1920>;
		height =3D <1080>;
		stride =3D <7680>;
		format =3D "r8g8b8";
		...
	};

That's not dissimilar to what you're proposing above, except that it
moves everything before step 5. into the bootloader's responsibility and
therefore avoids the need for hardware-specific early display code in
the kernel.

Thierry

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+kJwoACgkQ3SOs138+
s6ERrg/9EQcqVKr72kFSZhGQZ8IsbYN6n9XzzYePwKbGLs/jpZhn1eFHLZcsP7e+
sh62xwiC4yJBAayyE/o6pv8azUYB0RdRHbcDTkk6yWygZL6QNQ5rRrFxTaoNqvEB
sZg8+dHup/ZTQQALWM5gV7L6jroJUMbZKKkZZ3lUvrS+JutqR+vDkNAQWhrMT5+z
OrcNd3leMG6DV0V2gLQzoPawLCuZKAtjB7OWaLjNzqRP0wmuCEydrZqeBN7j1DC5
4epDr9wxMF0hlJ9M3Bmgh3cj6zVhUcwK95oMTu4Ugf43JIsAtNZkIgb+o4+tEtBo
FQRKzV+52IwfQeXeGJwz6Wl0oSH8INyy3Y6Klw5Nlp2hAGyUKP3W6LyGL2kWbJO5
0YJYW9IxRQO3+/IZLWUlb4JKu1vsjyBgzXyem/U0gyn0txUytW805qmo90QtIM5J
jJW3KrzfTqRP7S09R/fhNwWCVYmZrP509+CJDaIGEuhWNic6GERqbzMTG4XzVs6L
s2HmOBEzVdoOlqMqyiK5ftooQotP3gSm2dnc7sOxQ+llPtxoXo2c+G210IMPvWxp
9J0vzZ2RTNnoyhZtAMfYW73+Zr2xIS+6PODiYuc5ymU/gnpHLrONeSv7jRDyPBzM
G652Pg5lVeHIvVPFySxiqjG982iZw1Tpeoy2qZEy2S3IBZO04S8=
=gf22
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--

--===============4168314202390961999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4168314202390961999==--
