Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188991A723
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706271575; cv=none; b=eVSQigLTQqoqf9V3L5aGob3PI3WDfTIhJh8P+kWnBIh145SPxy3H52LJcCGCpfkmOvYmbHYcp8rBM6ojhM0Rm+xY3FgE3X1eNqK3iApj/Bu/vSoRGzUGHarh+lXYkTcjREv14Y6+dqkmlYWw+BClOtM0xjzpa3ZrLKd8A8cWppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706271575; c=relaxed/simple;
	bh=5H56HWqn/deHln62wrFoByopGDwD6ea2LZ8SD5fSyng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3WGaIyOVJOprSEXHBuD1fw4vb3031iBTKzLN63SRtD51gu+kQTSVzqK6Ihni8dMA9mfARuTvWoNmraasoXIu3QxjvYEDefQLdXsnpzfUP6GFHktFE7sfRMw5Gsh8IIg2DcE1I1j7oAbGOKCnzM7BYRtyr2eCrezE0OUGOn9sMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DloErF6F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DloErF6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706271573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5H56HWqn/deHln62wrFoByopGDwD6ea2LZ8SD5fSyng=;
	b=DloErF6FWYymgX8idet3dDCA6VifCpuWLMezWbBqf98dXWVqtX0U3xyisI1Ft+Dd4aoHr2
	EcIAa9u2+OIA+jY4Grw4B4j3n2eNhD23c2wnXF2LZYCbg6c7yb75xUToY+aBAldRwrQhay
	+TCR0Qyxc8aPqNMEer+7jBbWGzHcKlI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-lRlVvv05MBOSm7wMsTjiNA-1; Fri, 26 Jan 2024 07:19:31 -0500
X-MC-Unique: lRlVvv05MBOSm7wMsTjiNA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-337d2ccaab0so242430f8f.0
        for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 04:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706271570; x=1706876370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5H56HWqn/deHln62wrFoByopGDwD6ea2LZ8SD5fSyng=;
        b=gMOsXZ2Z5ZLQKr1XXw96EtkrstXjjYcFnyUrzqDxZzq0Fh9DdTxzkhczfagkAeew9F
         4h4NR/nBIJsOaUoJHjihEZ4D4jf5Uv0L5UodtEzzGG6PFwwDwqEdxuxE1oW7otzMQ6MX
         joG0e5ciBVLHiSXqlwhYzzxvDppbP29LuR6oRwcxQD6QIb7Ial83THUeHf+GIbboxQ2E
         FQJWBdaKM4WbF/dsJ5qen94ZFHJ/ghi75Hsmaqu4JRzQUtEz+ZsEWYUV7GNfIE9m+NVV
         APIeyuXCaBbAiYFEcaI2HLJzuuARPtM0QVtM83FIOdv8G2FueNdU5dcaPZlm8o6Yk4v+
         1xaw==
X-Gm-Message-State: AOJu0YxgSEtwKFBej/je32+VTz173/2jnbJuAUDR43Im8RSnzRHJhEXR
	QwtnRqQwPirdlIUdTlIETV2TX1KJqfGEzdYIcHz0BXWnZVO1OFwSrp5l2LB8JSqqDE6ZOB/uW9K
	qdkeGRrODjxrXGFyagWKI2h3gh/nK5ewgDXfeShHesOLSe3m5GmIP
X-Received: by 2002:a05:6000:1047:b0:336:5f08:bbe0 with SMTP id c7-20020a056000104700b003365f08bbe0mr877237wrx.101.1706271570356;
        Fri, 26 Jan 2024 04:19:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvk/to6kqjgd6CII/na2g3CQsYKiEqQRao5gUrE4jSuNLIpBgDU8UkmEp/mV+zKAcyqALNYw==
X-Received: by 2002:a05:6000:1047:b0:336:5f08:bbe0 with SMTP id c7-20020a056000104700b003365f08bbe0mr877224wrx.101.1706271570032;
        Fri, 26 Jan 2024 04:19:30 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id bo17-20020a056000069100b0033930068ca8sm1167700wrb.21.2024.01.26.04.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 04:19:29 -0800 (PST)
Date: Fri, 26 Jan 2024 13:19:29 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Milan Zamazal <mzamazal@redhat.com>
Cc: Lucas Stach <dev@lynxeye.de>, Christoph Hellwig <hch@lst.de>, 
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>, catalin.marinas@arm.com, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andrey Konovalov <andrey.konovalov.ynk@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	kieran.bingham@ideasonboard.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: Re: Uncached buffers from CMA DMA heap on some Arm devices?
Message-ID: <4tu76zlfsowltb6nu2dg5uftcztado27zburavsnmbkhursitr@cqot5cz4b7ms>
References: <87bk9ahex7.fsf@redhat.com>
 <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
 <874jf05og9.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ntfm2yy47zkwtyn5"
Content-Disposition: inline
In-Reply-To: <874jf05og9.fsf@redhat.com>


--ntfm2yy47zkwtyn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 12:22:30PM +0100, Milan Zamazal wrote:
> > However this isn't guaranteed to be any faster, as the cache synchroniz=
ation
> > itself is a pretty heavy-weight operation when you are dealing with buf=
fer
> > that are potentially multi-megabytes in size.
>=20
> Yes, it would be best to measure it if the mechanism was available.

AFAIK, perf exposes all kinds of metrics related to cache management. It
would be a good idea to measure all our scenario with perf and see what
comes up.

Maxime

--ntfm2yy47zkwtyn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZbOjUAAKCRDj7w1vZxhR
xaMIAQC8TIZy+27aCCm7ZwP/fIrRdx2Dp39pEo10pIb/qigBLAD/ZZ4BzS42S3aU
H1v9aM/rnDifKjmJxlksv5HOM1XzvwE=
=DwAp
-----END PGP SIGNATURE-----

--ntfm2yy47zkwtyn5--

