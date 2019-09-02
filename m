Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470A8C3A59E
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 14:54:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAB52173E
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 14:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVySUU1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAB52173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1008AE3D;
	Mon,  2 Sep 2019 14:52:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 044A5B8A
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 14:52:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9C9DF709
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 14:52:49 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id g24so15907520edu.3
	for <iommu@lists.linux-foundation.org>;
	Mon, 02 Sep 2019 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=24FRW/WZxXq/QDNoUHaKW8WDlW4jeIy2D1ot2PHugcc=;
	b=AVySUU1V+vz2mL44o30zCTNbsJ0/n+iwXnlv+he2TJRi5NQ7O5DyBZDfjaexS0gKp6
	MrY2cQBszZYcIo9bTQMdc/3KsF9puGKTrZiYDHlFZ00zqf78w0WLTFn76RPoPw9AylJw
	Ay8mpNdut6RvN/cvtASulXaFMoUZ0HhzeJt1lpT6nBAHyTpK4i0hWVPipyu/Gb0o1h67
	Uj7gX6ionbryiKcFyj3NBfWTrs+SgWeFXWCwd+ZDGAH1CMNR8DiUUS3T8h2vyQl42HK3
	Wok/Kwcn7DM4OCHc9taawRCHtNtZgJwlog6UsGchDX1RuwTJ/lhJcW01K7Dor5MXnkAs
	gV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=24FRW/WZxXq/QDNoUHaKW8WDlW4jeIy2D1ot2PHugcc=;
	b=Ld2CnTFHwawo90ij660/tzDAiIaajs0bLkyqlzPNCfMe+PHvfce+Ju7+163hn53KC9
	QKQKdCAbCn14RcvQd3DFYx2ilZoc/AUy4EH4oiJC0GMeG1ZQc8uLNiWwMpHVBDuzmHSP
	XwjG2RR9MplSgiYylyg0J7Inwsx+3jczbvOJQg872AfIFBU6PtQZI1rZiDYW2Lij7RWO
	TzgQlo17VoQHEhfgX5qIpVfpGXKH/s5gxvWs9r7NpQjGVGbNIbR1fUxZQsOYurIcnhfc
	Dp5bm3dbW2Kw8bwvqAaD5vMiK/guCIyIQCpwqyl8xLcZ2TfDj4Jsw5I3EQDybFOBuxXz
	YBiA==
X-Gm-Message-State: APjAAAWeIsLknINOtxer6Su3dALB/5gf88aBzCJny5hzbKbdRQSfpPBn
	kkLJeHj69G0NiBcYebhX938=
X-Google-Smtp-Source: APXvYqyOEROUe8DyT6Hqij/gPP/W6Fz/WxQjxkDY4zYOs4TzfahavSwP7jrAGvQ4gwJV4Mv+PGSkbQ==
X-Received: by 2002:a17:906:512:: with SMTP id
	j18mr23963123eja.28.1567435968151; 
	Mon, 02 Sep 2019 07:52:48 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
	by smtp.gmail.com with ESMTPSA id
	a11sm2972544edf.73.2019.09.02.07.52.46
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 02 Sep 2019 07:52:46 -0700 (PDT)
Date: Mon, 2 Sep 2019 16:52:45 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
Message-ID: <20190902145245.GC1445@ulmo>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
	<20190829111407.17191-3-thierry.reding@gmail.com>
	<1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com>
MIME-Version: 1.0
In-Reply-To: <1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============1422086432265713177=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============1422086432265713177==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2019 at 03:22:35PM +0100, Robin Murphy wrote:
> On 29/08/2019 12:14, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > For device tree nodes, use the standard of_iommu_get_resv_regions()
> > implementation to obtain the reserved memory regions associated with a
> > device.
>=20
> This covers the window between iommu_probe_device() setting up a default
> domain and the device's driver finally probing and taking control, but
> iommu_probe_device() represents the point that the IOMMU driver first kno=
ws
> about this device - there's still a window from whenever the IOMMU driver
> itself probed up to here where the "unidentified" traffic may have already
> been disrupted. Some IOMMU drivers have no option but to make the necessa=
ry
> configuration during their own probe routine, at which point a struct dev=
ice
> for the display/etc. endpoint may not even exist yet.

Yeah, I think I'm actually running into this issue with the ARM SMMU
driver. The above works fine with the Tegra SMMU driver, though, because
it doesn't touch the SMMU configuration until a device is attached to a
domain.

For anything earlier than iommu_probe_device(), I don't see a way of
doing this generically. I've been working on a prototype to make these
reserved memory regions early on for ARM SMMU but I've been failing so
far. I think it would possibly work if we just switched the default for
stream IDs to be "bypass" if they have any devices that have reserved
memory regions, but again, this isn't quite working (yet).

Thierry

> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index de68b4a02aea..31d48e55ab55 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -19,6 +19,7 @@
> >   #include <linux/iova.h>
> >   #include <linux/irq.h>
> >   #include <linux/mm.h>
> > +#include <linux/of_iommu.h>
> >   #include <linux/pci.h>
> >   #include <linux/scatterlist.h>
> >   #include <linux/vmalloc.h>
> > @@ -164,6 +165,8 @@ void iommu_dma_get_resv_regions(struct device *dev,=
 struct list_head *list)
> >   	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> >   		iort_iommu_msi_get_resv_regions(dev, list);
> > +	if (dev->of_node)
> > +		of_iommu_get_resv_regions(dev, list);
> >   }
> >   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> >=20

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1tLLoACgkQ3SOs138+
s6HlcQ/9Fygivox982dpWeIcABcFv3w+hcjZPGp/Gbb/waKwE6F8y+M83AaxL2Zb
1QMp/wSZ438o+nMgXmqw8nFeC1HHCbGGRrtQz7Nl8jYiGt86J6WNGcG0pmzKcuCP
y0OiRm5yOhIVWqQDzaeNQ8OWS0b2Pgbrw0PRCu/k6zis9WeAQw9MJig24ljtdojF
U81u8/jOYn4oa+VpBfD3gsI9lenkZn/aBrW40m8M2b9P2/NtdV5XHrbq6ec+q2/I
UWC6UlLQ2F+iMUmFsXP1ol1h6E7ioVWRAH91hsAEAOGkQ0GZbOdlBHdPKJBJ15Hg
TwPxh5xzlZWDUWH5/EMIB4GDhhwuh11wUv4ZowHv2s1zVClHPUCNGeaJyXOZhYM6
i7pfw2UiVVSzAOJRaifnVNeyvOFAGad1X4WP5U+Bzz5nSGlKD/H8Pr6OkIF6ibnU
JUMMFE8VANLT64TWv+bfIkN30Pw08tdfFJIb7LZWqjDhuTra+1+UJL2mAdzJSjml
U4oYvsiegSbe93lJCsmuF0M8Lgi4FtKYDJuPQk2/uEZW3EVJauyUzcwnmAlx8m2O
X9xfkY6/fZYJghXZ1Sary0csp8HaILgDDCHDDFTkxXQXVWvKWT5AT6eWP/bnQC5Q
L5w7pjU2sWYURUEk04JjVotFO680raUhaZrwG2dooJMHvV1K0Ho=
=YWPY
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--

--===============1422086432265713177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1422086432265713177==--
