Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D9BA41
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 22:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72136C433D2;
	Fri, 13 Jan 2023 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673648279;
	bh=HUKCBg28UCRcJ10s3S5AA+c32vWb4jb4VQKxfxFg5pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NU9Ugpcv8hxTU5wYnSXtG7lUtd5S4D9JXKOT4Z/MaEOTTUjyCVzhZzkSPBiaQpRJY
	 KwiqGshxlID4cA/qLY64d2pEQbwJLTpzHnsZ2g6WtFEfYtUL/FmJVFnmkkHDIxXtmq
	 0xpEgGfq32R+NtyXMRrsvbvPL73HyHedfk79+/KMKP+ehXqUZh/l87f3e1boM5mRgO
	 F52dzEaQof3SQMbpHJD8svtD4qInTOHBwSU8l3LtG80jKAwD+rml9gQ3CoF8dsUKUG
	 UIjrRAVgzCkDzDMotOx85xa5v2SNbg3aGjvj4kk+uowJW3UFy/0E45RsjWWAv+tZip
	 55kYchFvQUOoQ==
Date: Fri, 13 Jan 2023 22:17:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, palmer@dabbelt.com
Subject: Re: [PATCH] iommu: Tidy up io-pgtable dependencies
Message-ID: <Y8HYlFp2ZIlzIPfB@spud>
References: <51d8c78e2ecc6696ac5907526580209ea6da167f.1673553587.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/ncmK7LH7mvy4WLh"
Content-Disposition: inline
In-Reply-To: <51d8c78e2ecc6696ac5907526580209ea6da167f.1673553587.git.robin.murphy@arm.com>


--/ncmK7LH7mvy4WLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Robin,

On Thu, Jan 12, 2023 at 07:59:47PM +0000, Robin Murphy wrote:
> Some io-pgtable implementations, and thus their users too, carry a
> slightly odd dependency to get around the GENERIC_ATOMIC64 version of
> cmpxchg64() often failing to compile. Since this is a functional
> dependency, it's a bit misleading and untidy to tie it explicitly to
> COMPILE_TEST while assuming that it's also implied by the other
> platform/architecture options. Make things clearer by separating these
> functional dependencies into distinct statements from those controlling
> visibility, and since they do look a bit non-obvious to the uninitiated,
> also commenting them for good measure.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/Kconfig | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

>  config IPMMU_VMSA
>  	bool "Renesas VMSA-compatible IPMMU"
> -	depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU

This is a fix for the broken riscv32 allmodconfig stuff that Palmer
reported, right?
https://lore.kernel.org/all/20221214180409.7354-1-palmer@rivosinc.com/

I did a dfn:drivers/iommu/Kconfig search on lore & saw this, but AFAICT
the patch was applied to next rather than fixes.

Apologies if I'm off here, I have had that report in my follow-up-on
queue for a while & since Christmas happened in between I've lost track
of when the build failure was introduced.

Last I remember, Guo Ren sent a patch that was not to your liking, but I
didn't see anything after that.

Thanks,
Conor.

--/ncmK7LH7mvy4WLh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8HYkwAKCRB4tDGHoIJi
0uHBAQDCqnz8+NwoYXjQnu2dFi70IzS4ZZKyh11h2wX7/xzlhwEA5Q/7WsWubNPt
n2PIPk+ZrxOn+AZuOEMu/+EkByxUaA4=
=T15g
-----END PGP SIGNATURE-----

--/ncmK7LH7mvy4WLh--
