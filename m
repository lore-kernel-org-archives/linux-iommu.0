Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF629B78F
	for <iommu@lists.linux.dev>; Mon,  7 Jul 2025 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895668; cv=none; b=Yj4YErdqO3U+EZUULc15mNhdIIJIDwVLKVC8LzdYgvu0yX5fIT5cefz7yvw+uKXQEsdRD2cv3mp4G3zqo5bTiQlRqVioWQgaiv2N8wyxeiYlCwKX7U4UWkDIyr0tMGIP4vOjMoFhmmngOw+zp/rVT2lfAtDRmDh8sReCauMO+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895668; c=relaxed/simple;
	bh=E/YTf99KN2j6dfj/Osvmdw8tCiYUY/Ns0F7x6OP0ONk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIr7CUO6Qe01oxgAtdieggV+Q2K2AJMu2jRGQ+LLhW0xHmEu8o9/NN4EFR/0lPExrFsNHjmK5Znvb2fgjp3AaiNySTNLxyhGFceh0omf8YZVq6lYhAOba+Yk8wUeoaD6No+OgURaHmttLApCVIYaQJ0QsgtL5A/UP8UwM8PRL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MoTWIiuo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MoTWIiuo"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so577818466b.2
        for <iommu@lists.linux.dev>; Mon, 07 Jul 2025 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751895664; x=1752500464; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNpVb/nMDP7hj3MLmxppsJZtO2Gs5x5oBsiSaJBuIB4=;
        b=MoTWIiuoe/EWyLJHd67zX+MRrSrQxesHaMckcyC990ZMW8moTUu5ZZKtEfkaJ9OIHt
         rJJY1VwLyJ3bDejete0k8+5A9uSLD/aL0CFolo5W54ncKt92KjwE86BZCUaFfJFiu1WS
         LtORPTkrn/pdBSQQdQs9OOT7jjBsafJeXpgWL1WtQ4h574Zml1gYEAt6uFv/bXY7o3cG
         GomQ10J0nVAspYv/bJ4/0aw619hRHQGGSfJPPTPU71T8DjqYX51Nike0ixCXfoq7UK/e
         W4JDYfNdva11xGY9+I6P0w9ZdJnF2sm35kBTT9tbOgbbSOX60xODpygLw21IdLc+RZyf
         7sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895664; x=1752500464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNpVb/nMDP7hj3MLmxppsJZtO2Gs5x5oBsiSaJBuIB4=;
        b=BAbQKX/YrewPHLyoVkhwTtK2/Ppzl8YLfFQ97bBXeXLyYYKg+6VPp96Skos6r02lVI
         wm1pfKDxaO8Sv/SDINOWj01dKZwF6sUpvahB37AXcnUTPXTyP4df9u1S8V59iea5fQve
         LsQPOvdtqJnR8Ndt8wwzdz4mcXeKb57L42JOYcU4NPqsO/zo+48HqxOz2AKAXLhkIJKU
         qmgzUHYkQ/hAdo0yxbM3cLeZjM0nDKU4fFQ83d+BsW3LjwUj+qt43g/PA1oQBdWxG3F+
         A94loXJoupzUm1f9BSkRvcv/9XLiQGCSxGfWGrkuWOlIr1IEOrFEJbBob1mx3C0aCBnT
         s8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMEIK/v606fn1WLYgxiYY+/2K+879ul/ZfUsRENEu8oCEHGTXPRv8rPN8/aAeo9+NLJ2RCVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+kZiqnYAtN3qeXqK1HuBGg2lF54wWhGqHG5CDfcKrsmedZVN1
	DDyLFXv8B4VI48VJ6bw85GQkIWY+y4he5Sw+zV8KfMIuoPLReFRzc5WQEYEd/LiELZw=
X-Gm-Gg: ASbGncv8dCuS1slRvHTW/28h9fqWDiLylnavgBH/Ebv/SUfApYw5N9Dokcl2VhdkPXX
	jxo/26ET9YQwOeQ9xzKewNk7o6Lp32WkMrD+M27mb1hDGfsTpGhGILSuMHqXOHawzfuF8uiKSD4
	Mp7ogkOM5llJtx9H/09KOPupsH13dfdDsH6JtZnWrIZI3Gl8WHfd3qeDy3GTy+oZarDfntYEQcR
	xcnnKnI+zGpp9Tsiwmlcw8lRJxk0kxXCJpRTntQQpXIiVWHWlKxlsbg9uzXJLM+JEBPw5/NYL/m
	NjPbEs7VNX5ESLHDGgMgN5WgBRLvJ3tGDJE9has8sldx2rlt6dOR1haXe+wIUnHcLvzFzBEiBW3
	JhA==
X-Google-Smtp-Source: AGHT+IEVEQQKSyWO8J/KHI1EhymIFStABHRr6vUfPIXgyPnnTgZXYb+sbCsOm6oQazMQbqKjsU4K6Q==
X-Received: by 2002:a17:907:1b23:b0:ae3:635c:53c1 with SMTP id a640c23a62f3a-ae410a62cdbmr922365066b.54.1751895663516;
        Mon, 07 Jul 2025 06:41:03 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae411a54227sm471065266b.74.2025.07.07.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:41:02 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:41:00 +0200
From: "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Yong Wu =?utf-8?B?KOWQtOWLhyk=?= <Yong.Wu@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	"krzk@kernel.org" <krzk@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: NULL pointer exception in drivers/memory/mtk-smi.c
Message-ID: <c2fhyerjrb5qgtgyo7jojcyolsryvdp6injgbbzdkbzoaubdnk@37aw7p2f6rbj>
References: <allge3h2abtjfj77idsnwccurxi2jnbcv6qcxar5f5m3jjmpvs@a4mmfghdhtv4>
 <lri2gdwioe3on3unzrnmezv4pnxke6lmixrsvargeupdcywweo@j6xoz36xjdoh>
 <1dbebbf290413eae9af13312028c2d19d3441a09.camel@mediatek.com>
 <d818cad4-9eff-4fd6-b46c-d1fc24f7130b@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3dz544qscs7qsyr"
Content-Disposition: inline
In-Reply-To: <d818cad4-9eff-4fd6-b46c-d1fc24f7130b@collabora.com>


--o3dz544qscs7qsyr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: NULL pointer exception in drivers/memory/mtk-smi.c
MIME-Version: 1.0

On Mon, Jul 07, 2025 at 10:47:53AM +0200, AngeloGioacchino Del Regno wrote:
> Il 07/07/25 09:24, Yong Wu (=E5=90=B4=E5=8B=87) ha scritto:
> > On Thu, 2025-07-03 at 18:41 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >=20
> > > [expanding the audience a bit according to the drivers that are
> > > involved
> > > now that the problem is better understood]
> > >=20
> > > On Tue, Jun 17, 2025 at 05:18:30PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > on a 6.16-rc2 kernel running on an mt8365-evk I occasionally hit
> > > > the
> > > > following during boot:
> > >=20
> > > I invested some time now to understand the issue. So here comes what
> > > I
> > > understood, maybe that helps someone to spot the fix to the described
> > > problem.
> > >=20
> > > With a configuration that has all drivers built-in but
> > >=20
> > > 	CONFIG_DRM_MEDIATEK=3Dm
> > > 	CONFIG_MTK_IOMMU=3Dm
> > >=20
> > > and
> > >=20
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index cb95fecf6016..d4320db7cd2d 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -1387,14 +1387,15 @@ static int mtk_iommu_probe(struct
> > > platform_device *pdev)
> > >   		goto out_list_del;
> > >   	ret =3D iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
> > >   	if (ret)
> > >   		goto out_sysfs_remove;
> > >   	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
> > > +		msleep(10000);
> > >   		ret =3D component_master_add_with_match(dev,
> > > &mtk_iommu_com_ops, match);
> > >   		if (ret)
> > >   			goto out_device_unregister;
> > >   	}
> > >   	return ret;
> > >   out_device_unregister:
> > >=20
> > > I can reliably trigger the race.
> > >=20
> > > With that sleep in place iommu_device_register() completes quickly
> > > which
> > > enables probing of the devices with drivers contained in the
> > > drm_mediatek module (because the modules are loaded in parallel on
> > > a different CPU).
> > >=20
> > > Then generic driver code calls resume on all suppliers for devices to
> > > bind, among them the four larb devices. However due to
> > > component_master_add_with_match() not being called yet, the larb
> > > devices
> > > are not yet bound to the iommu device and so larb->mmu is still NULL.
> > > The latter is a problem in mtk_smi_larb_config_port_gen2_general()
> > > which
> > > is called from mtk_smi_larb_resume().
> >=20
> > Hi Uwe,
> >=20
> > Thanks for your help. In this case, it looks like the disp probe occurs
> > before the smi_larb_bind operation, we need to let disp wait for the
> > bind to complete.
> >=20
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -666,6 +666,10 @@ static int __maybe_unused
> > mtk_smi_larb_resume(struct device *dev)
> >          if (MTK_SMI_CAPS(larb->larb_gen->flags_general,
> > MTK_SMI_FLAG_SLEEP_CTL))
> >                  mtk_smi_larb_sleep_ctrl_disable(larb);
> >=20
> > +     /* The larb_bind operation may be later than the master probe. */
> > +       if (!larb->mmu)
> > +               return -EPROBE_DEFER;
> > +

A .resume callback isn't supposed to return -EPROBE_DEFER.

> >          /* Configure the basic setting for this larb */
> >=20
> >=20
> > Hi Angelo,
> >   Do you have any suggestion?
> >=20
>=20
> I don't have the necessary bandwidth to really broadly research about thi=
s, but
> there's two ideas:
>=20
> 1. What if we disable PM OPS until MMU is bound? That would avoid calls to
>    larb_resume().....

I think the key question here is: Is the iommu functional without the
larbs bound? If not I'd claim that iommu_device_register() should only
happen if all larbs are present and ready.

> 2. Instead of component, we could register a device - which carries its o=
wn suspend
>    and resume ops; the device would be registered only after all local ar=
biters
>    are bound, so there would be no suspend/resume ops until everything is=
 in place.
>    That's more or less how it's done in drivers/usb/core/port.c
>=20
> Probably N.1 would work best - we could...
>=20
> probe:
> pm_runtime_set_active(larb->smi.dev);
> pm_runtime_forbid(larb->smi.dev);
>=20
> bind:
> larb->mmu =3D ...
> larb->bank =3D ...
>=20
> pm_runtime_set_suspended(larb->smi.dev);
> pm_runtime_allow(larb->smi.dev);
>=20
>=20
> ...the next usage/wakeup should then call resume() but at that point we'r=
e sure
> that larb->mmu is actually initialized, because we allowed PM resume only=
 after
> binding.

Not knowing the details of the hardware that feels wrong. IMHO a device
that is operational should be able to do PM ops.

Best regards
Uwe

--o3dz544qscs7qsyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhrzmkACgkQj4D7WH0S
/k4UPAf9FwUgM0aTRuE8AAy349MmsZSjSNcSHXZ+3SALeNHgKMZmzXZ9h4traUjW
/786sSywNT+YsF6M/FtH66NcqGodQkwZzjC+ftAnYhmvydMfaAxOkLWpiqIXW8Zk
92oO27jqoKq+4AiIij4GAM4iPNza20nzsZvxsxv6NAI5rluVWWk9+klgloLqFj/T
+iDnQ4VMVrMEaCyfQqGastonqdZlj0VJkigQpd6RWOY7kXS9NxOzaw/V1KaYIkAf
tmHutlkfA+8EQQXfr5g+ciIlA90wVI5VM1EZVLybfT96FZ3kTvlksBIbdDo69URq
NgTabIBVTmeKlrzY0uaZLRC/5pQq/w==
=BFbu
-----END PGP SIGNATURE-----

--o3dz544qscs7qsyr--
