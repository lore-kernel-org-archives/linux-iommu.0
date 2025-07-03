Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D0259CB9
	for <iommu@lists.linux.dev>; Thu,  3 Jul 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560920; cv=none; b=W4oyYBm4K6Su0hMaOBev/nwGqYvcakuLpNDdLY2n7d+DcJP0pRfGHfUHo02yZagQbYAKoI71JuF9t6pyeiV21UuRaHgH2CW1Ze63uIXXjAUVWc8ccW/i0z8gihjng8Bp+pZgNWYt9vEByAD8Zr++0bbu/U5wjyCeB+FkVtGi/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560920; c=relaxed/simple;
	bh=cXkv38KGIX34RuLIdAc1i3uN0EIsuRbJnWGY/uoqYZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2NUvsWt4g+Z1j3pri8shoeConxGFFAOJuNMaanCSIbbpWDNtRrdUYmiulL/uwTZwCwko0GR5De6qVAvsy4mSNoGroND+MUqOG2gKyLT/LP7oNXY7stFw946DgjfgSs0Si/QiA+XTwblL16f09b7X1NYr+eusxsU+DdzQcD4Obg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=knng44Gf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="knng44Gf"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so9692866b.2
        for <iommu@lists.linux.dev>; Thu, 03 Jul 2025 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751560916; x=1752165716; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=af1gXahHDj3+vTGl3zYYql5gtv9egPIFOeLtJr5k0gc=;
        b=knng44GfzZXjdc6FExJlfxFDNY6UjvUKEODlmgLb/nUb/89rDiPJV9oh5tNv7uHvVp
         iQAtb8xAswCMMqKUGdtCQexT2oGzgQNF2hT3glm/MmXW022LFZSdiXxXHwC6ktcyzIZy
         MOc79hJv1mb7cpW1i9/C4crux9Th0+TG10d6GDfHTOL7SmJ4YS4+8cAgKNEiObicpp6Q
         Fd8jzBQDO7Biq96PsUfjyROjSUf1mW+hSm39A06sLa/S7H2YuQsedmQvrlM+3TC4smm5
         rq/aDxk1aOyi7Rh0fNEg31kdS768QwWF9Ro86va1/DYxvI6pv7I/f6cr4e+mkwXGRHdn
         OD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751560916; x=1752165716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af1gXahHDj3+vTGl3zYYql5gtv9egPIFOeLtJr5k0gc=;
        b=v8XUWAuTsJqQoeRqBBqnGCwbojN976BuwmZCn/VcTjgCu8gXTFrY/9fdElzjXsLbKV
         iHiRzAODYBqibNqaEEH4aUz8Blq0cc7hNxLaSCu/zA961Go7G0b2p1/hLmzNpLpw92jN
         7PJrgfB1kWxOgPCc1PcR60n69RjxzY5RcFy6BNsmgNho7zPrqfwNhCrezJ6FEmG4QIQL
         ThuD2W4wnFSiw3gYgLZFkV4UOdR6jYE3J0LT/PJY9VzfdTj1m78Ua1tKbpexUcXVTIzS
         c8lGhM43axRa132AtIYmsd/imFX3bmfk/M6pR5J+gFk8a+NFvPL34iVWSDmimUWARIeO
         5PFg==
X-Forwarded-Encrypted: i=1; AJvYcCWlmh/yBFQloTSEeGA9jJomvHo7HI/TKEAiXI6Dxa7/cc679p0bpHNoKOz7cUoHu1HbxnYfPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr0aDehy1vVAe7VIvzvM53p2IZtDN0jy6dSGdWWCfhy+LVDoY2
	2OoIX8kMub5oV309DyiUKgWOq2qHzlgWnPWw72OD8+VJy2ePmjn6G0vnNdgldKRTd60=
X-Gm-Gg: ASbGnctuTEUjuENBLgMByvXVZYHP6qHr4Bjzm03vkG3KC8ZS/wrI8PpThd37IRebOvw
	HUcs7YZfGKLBBVhx6z6ET9IRkdP29TIKHHsGe3mhIesLeqaG9mhYo56RTz1V+vLKZtemERF/FNx
	+cD/jLG9OM2g7nWnlvNkY5qN3pG7zdDTihQ7/JTXe+EIHgzK220mezotrEN2ZmZ0GhgPpnReJv4
	hiDsrJOhlOhM7vmJiSpHzSeLXaKZqHVrUWb7BFTdrllDt4t/pi3pm3u8q9t6lv0Lr4EmSqaEgef
	TLLVvUUekgsnebYn/Z4cF+WHnX6OvSWAfQY1bctSmI+jkj7XR5eMdvFi+bFrhueXXnmdv0pYjoA
	6gAp0GuieyhSjcDNIi4bSL+UtCT93
X-Google-Smtp-Source: AGHT+IG1Q6T7zYtraRTxu4LE7BnHzIirGKXY1QxEhawuvlIUwK7MxzBM9eQBF4eG96mIbzTvlvveTQ==
X-Received: by 2002:a17:906:eecd:b0:ad8:9b5d:2c1e with SMTP id a640c23a62f3a-ae3d8c9dcb1mr434769866b.29.1751560915895;
        Thu, 03 Jul 2025 09:41:55 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f6958586sm5003066b.72.2025.07.03.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:41:55 -0700 (PDT)
Date: Thu, 3 Jul 2025 18:41:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	iommu@lists.linux.dev
Subject: Re: NULL pointer exception in drivers/memory/mtk-smi.c
Message-ID: <lri2gdwioe3on3unzrnmezv4pnxke6lmixrsvargeupdcywweo@j6xoz36xjdoh>
References: <allge3h2abtjfj77idsnwccurxi2jnbcv6qcxar5f5m3jjmpvs@a4mmfghdhtv4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mmnkz7o7pwgteghy"
Content-Disposition: inline
In-Reply-To: <allge3h2abtjfj77idsnwccurxi2jnbcv6qcxar5f5m3jjmpvs@a4mmfghdhtv4>


--mmnkz7o7pwgteghy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: NULL pointer exception in drivers/memory/mtk-smi.c
MIME-Version: 1.0

Hello,

[expanding the audience a bit according to the drivers that are involved
now that the problem is better understood]

On Tue, Jun 17, 2025 at 05:18:30PM +0200, Uwe Kleine-K=F6nig wrote:
> on a 6.16-rc2 kernel running on an mt8365-evk I occasionally hit the
> following during boot:

I invested some time now to understand the issue. So here comes what I
understood, maybe that helps someone to spot the fix to the described
problem.=20

With a configuration that has all drivers built-in but

	CONFIG_DRM_MEDIATEK=3Dm
	CONFIG_MTK_IOMMU=3Dm

and=20

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index cb95fecf6016..d4320db7cd2d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1387,14 +1387,15 @@ static int mtk_iommu_probe(struct platform_device *=
pdev)
 		goto out_list_del;
=20
 	ret =3D iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
 	if (ret)
 		goto out_sysfs_remove;
=20
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+		msleep(10000);
 		ret =3D component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 		if (ret)
 			goto out_device_unregister;
 	}
 	return ret;
=20
 out_device_unregister:

I can reliably trigger the race.

With that sleep in place iommu_device_register() completes quickly which
enables probing of the devices with drivers contained in the
drm_mediatek module (because the modules are loaded in parallel on
a different CPU).

Then generic driver code calls resume on all suppliers for devices to
bind, among them the four larb devices. However due to
component_master_add_with_match() not being called yet, the larb devices
are not yet bound to the iommu device and so larb->mmu is still NULL.
The latter is a problem in mtk_smi_larb_config_port_gen2_general() which
is called from mtk_smi_larb_resume().

I don't know what the right fix here is, but maybe someone else does?

Best regards
Uwe

--mmnkz7o7pwgteghy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhmss4ACgkQj4D7WH0S
/k4xfAgAo8//U5/g2i21yMqMBVXTs2xxgBcBuLMjuj7nazzxU/t2NCbyfDBSYY5b
VnbwhSsyWIShTgehlQ9KqlgvwmeDuArdtjNsmsG6XaNAbC2xmgo0qy8g1M20Bhpu
cPoHpbn2a7Do99/XlSCJseysvIBKIEBndBl6tC8gmVRFSCw4DttijBeKN/Kaj9Is
fGGhKbdv0NCywa9YanAX/WlkxWspmvpiCMM3uKa2r/PlYJ31PsgD5eWQv9XpSvSC
EkHtXWh5Ykq4YYaadFi6ZI5B8Hx7mTlaDH08SZmgKSzc0UfdVl3qG8YnKBiAuH8Y
1Q6g+GM7xC3yvyyGwYYPyvMPRDSyyw==
=s/aj
-----END PGP SIGNATURE-----

--mmnkz7o7pwgteghy--
