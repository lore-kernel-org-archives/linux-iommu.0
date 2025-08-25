Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13D301028
	for <iommu@lists.linux.dev>; Mon, 25 Aug 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144225; cv=none; b=WS9NzCz5vPEgRQSjABgGScC5AWmZ0YV2/OAbJIyl+UbcYzAO3LN6vuudsAvIXjZGwmm9gF0DNxLatymRWyF4ROwRur+EShJaf4ORYhgIDrpAkoDqy+kFDd1L8iovmishDcTTWIJj6m+liK40ioCj3hMcTKldaZppBzwonOD4l70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144225; c=relaxed/simple;
	bh=99QxpOa1hWDVJMREI3P/OOtPeeZsrilD0hyvIUZj/ko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBVdRknj7O1OJn42ghuwoSjp+4giH1avVQbabY3I9I3zDSpy7q6WaFcXGS0b5WUpO6HH4Q+j3kOGhsNocopUkYirBkg1phTJxQkI94DffQCV3LVNMqPveXq7/kuQSD8GlTSFAiTsO8JvISZRXbgkwPEfocwP6GalvxcZm3vcmS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TGjglqHA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TGjglqHA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756144220;
	bh=99QxpOa1hWDVJMREI3P/OOtPeeZsrilD0hyvIUZj/ko=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TGjglqHAVky/nLbV8g0zk5XTTg0334cJVMNNqKelf9STnzVr5RRzk0kzX72wVe1q+
	 8NBE4L1+kXsrKFexwTkVMZo0sjlWZhDnvKQPPDJCQDdYb7E8T7HBLs3zhAI0QWWFvu
	 ZekyZ3vZINoyjUmX9CkLvTfVDwDYPqlzHimodlaVH1P5BubJA+kAjuge3LeaYx7hMg
	 tj2gikWglVHr3moG7ZWEFN7P17Wga0mAn1gZbFdnUfGF5FPvB1+LDjcVBNVjs7vD+m
	 jN/I0dTZINYAIKgYtVFghuBcGvlgV/BriJcaw5xm/a2TGgx723Dljz6ZztjVWbRBQ6
	 FsU90aE2NNQ6A==
Received: from [IPv6:2606:6d00:11:5a76::5ac] (unknown [IPv6:2606:6d00:11:5a76::5ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8942017E05F0;
	Mon, 25 Aug 2025 19:50:18 +0200 (CEST)
Message-ID: <01c327e8353bb5b986ef6fb1e7311437659aea4a.camel@collabora.com>
Subject: Re: [PATCH v7 4/6] media: verisilicon: AV1: Restore IOMMU context
 before decoding a frame
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Benjamin Gaignard
	 <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
 	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 p.zabel@pengutronix.de, 	mchehab@kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-rockchip@lists.infradead.org,
 kernel@collabora.com, 	linux-media@vger.kernel.org
Date: Mon, 25 Aug 2025 13:50:16 -0400
In-Reply-To: <20250825170531.GA1899851@ziepe.ca>
References: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
	 <20250825153450.150071-5-benjamin.gaignard@collabora.com>
	 <20250825170531.GA1899851@ziepe.ca>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-wovO2wwoxNj2XCpfZEwH"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0


--=-wovO2wwoxNj2XCpfZEwH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benjmain, Jason,

Le lundi 25 ao=C3=BBt 2025 =C3=A0 14:05 -0300, Jason Gunthorpe a =C3=A9crit=
=C2=A0:
> On Mon, Aug 25, 2025 at 05:34:43PM +0200, Benjamin Gaignard wrote:
> > diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/medi=
a/platform/verisilicon/hantro.h
> > index 81328c63b796..a28a181013b9 100644
> > --- a/drivers/media/platform/verisilicon/hantro.h
> > +++ b/drivers/media/platform/verisilicon/hantro.h
> > @@ -12,6 +12,9 @@
> > =C2=A0#ifndef HANTRO_H_
> > =C2=A0#define HANTRO_H_
> > =C2=A0
> > +#include <linux/dma-map-ops.h>
> > +#include <linux/iommu.h>
> > +#include <linux/iommu-dma.h>
>=20
> This is an internal header it should not be included in drivers.
>=20
> > +static void rockchip_vpu981_av1_restore_iommu(struct hantro_ctx *ctx)
> > +{
> > +	if (ctx->iommu_domain) {
> > +		iommu_attach_device(ctx->iommu_domain, ctx->dev->v4l2_dev.dev);
> > +		iommu_detach_device(ctx->iommu_domain, ctx->dev->v4l2_dev.dev);
> > +	}
> > +}
>=20
> What is this supposed to do? Put it back to the default domain? Who
> changed it away from the default domain?

If you rename the iommu_domain into empty_domain it adds a bit of sense. Wh=
en
you attach another domain (this one is empty, but it does not matter) and d=
etach
it, the default domain get restored. That effectively forces the reprogramm=
ing
(in the VSI case flushing) of the iommu configuration.

>=20
> Did some other driver change the attached domain (if so that's wild
> and wrong)? The commit message hints at that but it should be
> explained alot more.
>=20
> This just seems wrong and goofy. Driver shouldn't be changing their
> iommu domains if they are using the default domain at all. We now have
> APIs to allow you to allocate wide chunks of IOVA space and manage
> them directly. Maybe these 'multiple stream's should be doing that
> instead of mucking with iommu domains?

This is seeking inspiration of what we do in rkvdec [0], the iommu-dma.h sh=
ould
not be needed.

Jason, the point is that the iommu and the VPU are not separate devices, wh=
ich
comes with side effects. On RKVDec side, the iommu configuration get resets
whenever a decoding error leads to a VPU "self reset". I can't remember who=
 from
the iommu subsystem suggested that, but the empty domain method was agreed =
to be
the least invasive way to workaround that issue. I believe Detlev tried mul=
tiple
time to add APIs for that before the discussion lead to this path.

Benjamin, please improve the naming, comment and description, I agree with =
Jason
its not completely clear. I'm also surprised that you do that every frame, =
seems
excessive.

regards,
Nicolas

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dff8c5622f9f7c644e995d013af320b59e4d61b93

--=-wovO2wwoxNj2XCpfZEwH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaKyiWAAKCRDZQZRRKWBy
9JL7AP9R1VeW8rNgnuoZz8urKJxxEG6gWu6/kM7ge/SIZxuBcAD/SiNzSms3Po30
iybuQvLYIS4MMJlWAyYz5eVQbcpO6AU=
=XYWc
-----END PGP SIGNATURE-----

--=-wovO2wwoxNj2XCpfZEwH--
