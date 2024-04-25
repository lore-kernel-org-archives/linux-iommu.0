Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85514E2C6;
	Thu, 25 Apr 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065068; cv=none; b=Ns1s7vj2Yn4IEa+MeGQRVRjAqtHFHZ286emFSn9Vub8MUbkKRQEp+y2KVZG+Ul1ZyDw/i/zqgATzZvDAPoyMmZp0xikWfkpBH3/P4e/G1AnQlZA6ZPEf6+qcw6/5XSwpKQgFdbROGpTgK1+G7GP3mejSzuf0qMC/XEQTZS3+DVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065068; c=relaxed/simple;
	bh=rQqUpvh48d2fFx+wEaWpZgBfJ44kNNs6Q4v8vtEjFa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVWtBemnMaYlcvgETz0hWO2bpo15aijlTJyKniRX3HE8obIBuAzRJEtTukFjS4czqgfyHrO1jG+NXwZdZwhPj9Upgo+B/tSaOE6CltLB7/Igud866JRNNKD4szD0N11XHUzUw5ixhvewzblWzBVDmBh1HBHON9RN6WFjfLC2Yts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVwne1dh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVwne1dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35163C113CC;
	Thu, 25 Apr 2024 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714065067;
	bh=rQqUpvh48d2fFx+wEaWpZgBfJ44kNNs6Q4v8vtEjFa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVwne1dhgdktoKKlKWhDtSlmrdFaxgvFuvEKeBom6NnmYUhYqoX9fWKES9qHMe86D
	 /kwyydhCCxlPYJXX2yUIAZ9ZOANVfeJtdb9qnopUdMtJsI5VGlpHXxuH0I7nj9zZat
	 SzExn0U/xevuGBC57zhIkb+c2rFgRhzQZ+exSgdgDdjZgi+8ltvqvozAjNt0mWxjaq
	 sD2FIn68bRvp89XPlguf9IqAZOeMjIJsGgyqVc+4q6Eo4QZ2sG3uNFaVU6fw2W9YX5
	 n8PrSPymLXpnyr429BBfQ+77V4+YvfK6COj7NuvwMBaWxvelxl4/a6T4xUtCUrL/1l
	 dtizFhdsjJayw==
Date: Thu, 25 Apr 2024 18:11:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v2 1/7] dt-bindings: iommu: riscv: Add bindings for
 RISC-V IOMMU
Message-ID: <20240425-nursing-ground-7a3f92120058@spud>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <c37cb93e7baa7042a3f82130bf30be6831b558dc.1713456598.git.tjeznach@rivosinc.com>
 <20240418-approach-liquefy-04551ddefbc4@spud>
 <CAH2o1u7_v=_GX5cnV5X14jggTycRTvGEJ1r_9tqtb-xgk=LEkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Swwc95+Q8CpAtvFV"
Content-Disposition: inline
In-Reply-To: <CAH2o1u7_v=_GX5cnV5X14jggTycRTvGEJ1r_9tqtb-xgk=LEkA@mail.gmail.com>


--Swwc95+Q8CpAtvFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2024 at 03:37:14PM -0700, Tomasz Jeznach wrote:
> Makes sense.  Will update to something like below:
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - qemu,iommu
>           - const: riscv,iommu
>       - items:
>           - enum:
>               - pci1efd,edf1
>           - const: riscv,pci-iommu

That seems reasonable to me, addresses both what Rob and I pointed out.

Thanks,
Conor.

--Swwc95+Q8CpAtvFV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiqOpgAKCRB4tDGHoIJi
0iOwAP9rRgNUMnh8lOU9vNTRQerc6pb2yB1UEPBpVUg2JN4ahwD/fUj0t4ghfeIS
Nh5gnWL7xHYspUt3P4f/ljOrutHJywY=
=6/MB
-----END PGP SIGNATURE-----

--Swwc95+Q8CpAtvFV--
