Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F63209
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 12:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4797BC433D7;
	Mon,  7 Nov 2022 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667825928;
	bh=7RfL+o9Qb8/fcUehnPJxj7oMhPv0Ybf4aLUaRvOshpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRWtDMyjxEkpzPADgl+eb2FND7LRLZnWIKCprUKWxhqhZiut8Yw1Hq1s+2cXzCqvE
	 tjfD0JATAVRJ89kwLMx5wepQbyr/StP4HJvUwtaHoDEsIBbsCfbFyl87cuqge8gcVT
	 9eyrr29WRLSiC9VYOGBUK2VySGgk3vYTwfLl4aTdyhKKnQ9Y5DcJ+LuxdUBAEZ/kr8
	 NCxE+eTvLmds7j7hPfWgqq7bM4DDNlJ861hjlq5nZRsWHarbfczmArb3mO368Fqunc
	 h8AW6t6HDlGSmvjavhl466uZ//O9pGZAk/ksOyL87XTFbWIV4ZbtvgQtVLXd24VMPM
	 ojMLUvCKinE+g==
Date: Mon, 7 Nov 2022 12:58:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 10/13] drivers/spi: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Y2kBAWw27P0WbACV@sirena.org.uk>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-11-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GQK+zVBkLWx/ZA39"
Content-Disposition: inline
In-Reply-To: <20221106220143.2129263-11-catalin.marinas@arm.com>
X-Cookie: Minimum charge for booths.


--GQK+zVBkLWx/ZA39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 06, 2022 at 10:01:40PM +0000, Catalin Marinas wrote:
> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> alignment.

Acked-by: Mark Brown <broonie@kernel.org>

--GQK+zVBkLWx/ZA39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNpAQAACgkQJNaLcl1U
h9AWnwf+Lrga8EqgMaXZ1ojKH4O43q6wax8e5xgBnaeSz5/OND0SU2QUxsylAmFz
9UcBZi7Irxjsn3FiLfkQ4Qz4l9pd9GRcvGAhjsk7wC8w9ssRPiXB7/ZIzWn28qlt
68dzwREEd+kLfMDm0MA9m+3IaxRlhlm9WgVVHTs1lNoztsig0HjWGEMX9arPBrZn
PrhQjsGetLaTOQZ8+qfuA7e6Xs/XnHyLWgz55JqZTsYN7hy66FtU3oq92LskJAOn
dxm6N07+Fi4aae6kWb9B/MNF03yfA7iwnPvknAzoT8llWgjMyKo/vif4aBIOWcGI
s+wZnpCqBfLxEVMQG7SitCbPHgYqHQ==
=RkID
-----END PGP SIGNATURE-----

--GQK+zVBkLWx/ZA39--
