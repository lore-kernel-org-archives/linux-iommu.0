Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794770076;
	b=OjuWazEZ0MYOICGRfVlGGgVf9jIkwOiWH1kCD8XD07HMm1ul+7Ij8kyifc7AoWYOwewU
	 lJBvHrIm+pFiJnXduZ91ffUdk3raz7Tj9bXiho7anqvoGc5PZkvQljmqBTLtNpwAp5v+L
	 0LwaGozhQ7Kxjq1RC4YK7ljbWkqyTFIBu4EcHMbVpuwMwwitK1wjuhEXOt2L7PeizaqAb
	 2nMnUc1rAa9Dx90BYfqp/GvNzQaTrtnJl42ulMpsgMEFAiqqCPi5Y08mW6kl16EB1+FOx
	 sVP/uW/UlZuLOHNEREDIDP/SI9G+WZpBKwrFmCsqsQd+DmlD1grSAER1qI3SP68Muxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770076;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bTYAm4EWSRHx/ZHXwlhFob7m+xxSKwh0NNHvPVL+4a0=;
	b=VZ2Vj3IVLqLZLsREd17qiC/2xY0QgLPMj6qLoZlolFoD1xMmKrVML+ESq1wWAmGBx1Tu
	 mZL0xErfTe+5OHnVqxeBtT+wYpDc3agU+/kPXRXVfxbLEQtYqVShYTnCTOjQSNMicA2s5
	 upNoI7xBxXSLpkcEX9Jaxm5lUFHtOVBY6AFeT0A6OrbNEcciPUTCDmabE48yQzXZi1vTv
	 SU6r7xnB+BsZBDl0PR5Zg4poVaQZv5FzubZFaKjFVIwt3pgdITKWX9tgdbqh8Nxkjy1/K
	 DIaXiWsBPtac7oMfvrtQe65TVQkgoObzUjQPi4Sraef/7R9Vp2UtD5Ws0zUCal5fp/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zlr8cphp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFB606A31F;
	Sun, 15 Nov 2026 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zlr8cphp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2830B1F000C4;
	Sun, 15 Nov 2026 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794770075;
	bh=bTYAm4EWSRHx/ZHXwlhFob7m+xxSKwh0NNHvPVL+4a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zlr8cphpaQd3nqY4dD/M8LKmVfhEwBhg/RXnFS8Dbd42j21budIL80Fj83ujynYBi
	 xrkpXbt/vgXXJ3zbCIgd0vytWH9UFZRo+kWYg6+zk3Dgh5sXkP6sxBNtPVRWMc7kgU
	 7c0cXcpkCgnk34WxtxAQP15i7VF+f+o9Op3gqEYw8sVFIZUZZKKEE/DiCEBd5NJmBL
	 eqWix0PI/yHN1v1kle17XH0UgF/k5g+OojdNRy9zlUqHohW/kmiciG1CH3WaxOOynl
	 GtOjVUG+IaqnqKJMnuActvv+XKVHz8jIHWFruwvUHIhP9DWwGFEUc3P4bbqJVKIINp
	 h+RZkJC+eVaDQ==
Date: Sun, 15 Nov 2026 21:14:25 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
	m.szyprowski@samsung.com, jenswi@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mark.rutland@arm.com,
	robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com,
	sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org,
	thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] memblock: Introduce MEMBLOCK_PTEMAP
Message-ID: <avoEkRRM3iH70_Am@kernel.org>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-2-vdonnefort@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111110738.872947-2-vdonnefort@google.com>

On Wed, Nov 11, 2026 at 11:07:31AM +0000, Vincent Donnefort wrote:
> Keeping PTE-level mappings is interesting for arm64 as it allows
> mapping/unmapping pages from the kernel direct map without the risk of
> splitting blocks which, under the break-before-make rule, may trigger
> page-faults the kernel can't handle.
> 
> However, mapping the entire direct map at PTE-level is costly. So
> instead, create a new memblock flag MEMBLOCK_PTEMAP to selectively apply
> a PTE-level mapping.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/memblock.h |  9 +++++++++
>  mm/memblock.c            | 39 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.
