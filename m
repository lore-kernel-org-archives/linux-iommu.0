Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA630BF70
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079464; cv=none; b=ZqyDZWWUbwMoH4vfSpPvIOkd1KTn+qkIeYHpLUVSGkpZohd1sGQYBMNp6Xsabg2564r00iiId2PQ3pChZn96BtMXV62JTobwvHcJRb6Z9ZlrXReku8ruMIB2g8EHkZ6GH5uFKXMEaA59jJhd7RBGWrNWAeUIerba7dcXMND6uuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079464; c=relaxed/simple;
	bh=0r/di+9tY8fWQV2FhOOexs1aLRTD8xu7b2VDNRAEMcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTRrkOVVcZSiS51yMw42QIa31wm2dJmV2/Q+JuE/rz7KJvrHbLVln3zfGovsoaEaWqoaB8B5IRKOy6yNQa0RwBMvjCSeeE3k+iq/PLfeSRtNaLeTYvRKtYNPoNoHjJJXOxrmxFq2PUxTbrnrQTdWEXPyvWLxMQC1q/vewzfq7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg22BBJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg22BBJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9241F000FF;
	Thu, 10 Sep 2026 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789079462;
	bh=OAQJSPmYprdtbC9hOVYl5/rHCM95Iwt9YPvE5BwPOtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eg22BBJVC+8UgAnCtyjXDTrnST6+CjXSQZUj6nlzhY9wiePzV49esI4YQVWSN1e6o
	 ir49Gflm0UKoghuY9bWEKEc9s7XCEL0Xo2cUG6CV0GWDK0AYHIv8YsdKqiF3Xkx7Bq
	 DeTt13EI6e0siS761wHy8Ejd05KrLVA8GN05IFm2UrX6VevHPSkUbS/Kl4j/7OrGer
	 7rOYPvDWitdSa50uvkgonm0HIx56wagF16+WiUnT1SgqQt4p7sL7uEj5u7xQfNPD77
	 qL0pUmO55j34fvtczPhZxmFjrsaeKHZe5PTk5H/ugIgq409NqNBwfMph481mVOBBlu
	 /ixAnGJbrz4aA==
Date: Fri, 11 Sep 2026 00:30:58 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 6/7] drm/i915/gem: Read and shrink memory in a
 separate function
Message-ID: <aqMvCTIzLcshkVCA@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-7-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-7-krzysztof.karas@intel.com>

On Wed, Sep 02, 2026 at 08:25:24AM +0000, Krzysztof Karas wrote:
> Continue unloading shmem_sg_alloc_table by placing reading
> folios and shrink call into a new helper.
> Make the code a bit more reader-friendly by removing moving

"by removing moving"?

> over structure elements and replacing it with a sequence of
> instructions.
> 
> Assisted-by: GitHub Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

Looks correct to me:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
