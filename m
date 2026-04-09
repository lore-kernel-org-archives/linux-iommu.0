Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042A35B632;
	Thu,  9 Apr 2026 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722627; cv=none; b=Mb89FyQSF6palKaGciscKSwN9tQ5+5ZigaViqklYRWjl8FcaAAlPAucApU9uXiqs8xukHqt0lZYybKPZzXPF6+I/FrUD47lVpicUtjLpcgx5oFV+4D9fdYGQ1SrPA2DTICRdqPjZzwH3Hk29tk4OzYL66ZP5ZNQMh4eX5N/uTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722627; c=relaxed/simple;
	bh=0oFL4EmIO/g4ucpjyFy/e+LXyDriJV8hGcGegpTlORY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbxoQDOIb1AB5kSNbRZUlqoai7vxG8zQONGaGtQM6SQ01zcIA7rAuZclsx4rU5/DLVHj26MoFGXO/BhE88rGNBGzMz41nNRozYny4zAqaWZmRpVcNKnoCwFNosRhbJSw4fvAoBuNcaICjdpm/Dh9iRAIcJTyG7gmEpmqM1iEKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHnSI4bf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHnSI4bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B372CC4CEF7;
	Thu,  9 Apr 2026 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775722627;
	bh=0oFL4EmIO/g4ucpjyFy/e+LXyDriJV8hGcGegpTlORY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHnSI4bf+gkyoYAoZhtP9efvv9rDdW/+BojMrGT2iXBjsUGNH+a8zzCpjjwEBWLxf
	 kIkVAP4ANTxj8vTP8O88Y8EQwZQTVRP/72Ub1cjc7N1XEUGpWp+mejqt8adzHvbkj7
	 G0rQuhBIJxwP7pu6XvO+HQL0TC90uDFACu7XXo7Lps0hFscxmfXQffwvSq0XiVVpBU
	 bHR80SeYQ6hta2CxGoloAGkm2hgVYJWXSMjcOTRPT59qfHIWTleOEX8zQnZAvS7jqL
	 P2qe7n0QJEJFf1ZOEZ/GmnY2CDbDoXf6AunDJEpxcF18j6M+KixDH5g5p6QEbA/JVA
	 OIe8SaVyHIbnQ==
Date: Thu, 9 Apr 2026 10:16:52 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Remove obsolete file entry in DMA BUFFER
 SHARING FRAMEWORK
Message-ID: <20260409-jolly-lime-cockatoo-c9eb4d@penduick>
References: <20260408100819.458347-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="tigaibqixmft6ovu"
Content-Disposition: inline
In-Reply-To: <20260408100819.458347-1-lukas.bulwahn@redhat.com>


--tigaibqixmft6ovu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: Remove obsolete file entry in DMA BUFFER
 SHARING FRAMEWORK
MIME-Version: 1.0

On Wed, Apr 08, 2026 at 12:08:19PM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>=20
> Commit 25bd73562941 ("dma: contiguous: Turn heap registration logic
> around") removes the file include/linux/dma-buf/heaps/cma.h, which is the
> only file in include/linux/dma-buf/.
>=20
> Hence, there is no file matching the file entry include/linux/dma-buf/ in
> the MAINTAINERS section DMA BUFFER SHARING FRAMEWORK.
>=20
> Remove this obsolete file entry in DMA BUFFER SHARING FRAMEWORK.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--tigaibqixmft6ovu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaddgdAAKCRAnX84Zoj2+
dhHZAYC54+og7nzGG9mEtXnGL9r7LlvPX+bsMZiPGFO4VCAkpkmw1Z+XDZsmFcVa
YNmN9y4BgOMFpuP7lGhy2T/qJnHCW+vlxw6EVJPbB8Rp/RatJ1modb5XtEqSzU7p
cojAMLyy4Q==
=WP1F
-----END PGP SIGNATURE-----

--tigaibqixmft6ovu--
