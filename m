Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB721C199
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411057; cv=none; b=t3T8yQZ2vZa2q28gwT5bRYvOeLju8hWOyv8vX4r9L/XjTmHMf+aFvEU3HyQHudCMGbecq4bwfXMFiARKZND0DoRSWXHYPBYA682mho9RgTKGpDg9woxzDN1fpuZCkrhrhd5mqwOPQp4J5u6okAHUXhjh+D+940ScezvurLflcUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411057; c=relaxed/simple;
	bh=D+6lIZ9bV7/xmzLlToKOUu2B1ZQZPieWd2KlAr78KFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK0/P31PKlo7dzG8WIeENivxSf7Wg2GDjxSraUweIQlwHb78rc1QJLSRQc/JYkG0JjJVS6bI4L7GZikGeBrgcdb1dTAsj0WYg4d8Ll9DyJb5rjacnvU8LOleRBxOU7cpxZfhvefKq7Mt5xjtgyKHHg3Q5Amjd6mFrub6YlOHFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFLtffy8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFLtffy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0A0C4CED1;
	Thu,  5 Dec 2024 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733411056;
	bh=D+6lIZ9bV7/xmzLlToKOUu2B1ZQZPieWd2KlAr78KFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFLtffy8VkU0jop2tBE4Nby6MYHqO9tZwCt3wlR5Y6DtZRYvtVt1sLIPUxa7orxN9
	 GMSUCXqbiKiLjiQuuFKz0RflS4afn99I+O2ZLpY+iHR6JYmP4TcwBuovzXI8q9eUbX
	 pbqNeiIiC866KjlpDRx/tDV1828q0r2+rW+CwRwALRDcVrFtvu6FMce0MfIG/+50Md
	 /t5M9uZxzMZlfOda4A+pqp5RQyrJYW9AdWgdp+QzLBTLA83OzDb44eBi6FR6t6cInq
	 REIx0DBED9ljs/QKgUeReKQ0QxAuEAqPk3gqR9YAHbTMj42JP+6yCCXCdVEdpSRWC4
	 vzHdM6+CTAakg==
Date: Thu, 5 Dec 2024 15:04:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, catalin.marinas@arm.com, joro@8bytes.org,
	jean-philippe@linaro.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
	joey.gouly@arm.com, ryan.roberts@arm.com
Subject: Re: [PATCH 2/2] arm64: cpufeature: Add GCS to cpucap_is_possible()
Message-ID: <051c017c-a60f-48a7-b09f-07f0f32e48e3@sirena.org.uk>
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
 <416c7369fcdce4ebb2a8f12daae234507be27e38.1733406275.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fK5nFpGDFbAVSTd6"
Content-Disposition: inline
In-Reply-To: <416c7369fcdce4ebb2a8f12daae234507be27e38.1733406275.git.robin.murphy@arm.com>
X-Cookie: System checkpoint complete.


--fK5nFpGDFbAVSTd6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2024 at 01:48:10PM +0000, Robin Murphy wrote:
> Since system_supports_gcs() ends up referring to cpucap_is_possible(),
> teach the latter about GCS for consistency with similar features.

Not clear why this is part of a series, there's no obvious relationship
with patch 1?

>  static inline bool system_supports_gcs(void)
>  {
> -	return IS_ENABLED(CONFIG_ARM64_GCS) &&
> -		alternative_has_cap_unlikely(ARM64_HAS_GCS);
> +	return alternative_has_cap_unlikely(ARM64_HAS_GCS);
>  }

Ah, this is bitrot since the series was on the list for so long.  As
well as HAFT which Rutland mentioned it looks like _bti_kernel(),
_irq_prio_masking() and possibly others have the same thing.  Ideally
we'd have no uses of IS_ENABLED() in these functions so it's a bit more
obvious.  In any case

Reviewed-by: Mark Brown <broonie@kernel.org>

--fK5nFpGDFbAVSTd6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdRwOoACgkQJNaLcl1U
h9CKCQf+PJ8xyxhvWUHGbBuvArpSMIsFSw+7fhNagnbBeERzr41D0PePE5LX+Cmk
6dz3kmNjq6dOXgE+3Rfkg6b+TXeIOusL+uYCaBrTYQBnEWM+lk9iLoDFQl7GGq3f
+qGLeP9ao7/bHZw4fud2kaNQqnRhkaQWMKBWgAqSJkJav74Px4IXdVUR5PhvtEHV
N21Wqm2F/0/deeX8i8MWFqXIzVh3xGmHaNSTvRu5Cu6pZf0rKMKJ4zfPuvKOxLIb
90qIFQ0LxjTmPJ3MbfkcpB79OcHKz5STwV+lc2MM0IEsMl48cqrY70xrnSK8MGRW
dlGUimQQPI5s+0N/rctb0kDpMXz+mA==
=NPof
-----END PGP SIGNATURE-----

--fK5nFpGDFbAVSTd6--
