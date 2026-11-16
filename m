Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869661;
	b=nJcT1JyaWDdnoNH3+efcnT4l3qwq85Y6R9vOeFbQP8DNI1dH5kRwwkEa+Xbgs684gbpf
	 zotKkY7rmCvPzlKK8oir1frv9i1rqaL/H98pF8izWep4GFfDYiipApApiP4AMREC8u2FO
	 DjRXWBpbPkixxm4MNmF2g1XAsvx6a2Xeeu922JWE/0p/rSIKkvDRJAPaCXOCF1rmEJx8p
	 vnsYQQ1Y0fglcvTihaBnw0jVMfDDhOC8E+JJWui9T8gk1QjOzjp6gykK4GD4d4ssm7wQb
	 o3x5cfWKWNmeF/mNsU5PHa59pB7SuLM1GisTXHTvW99H8IAdh62ORQ0oqFm1Co+F1OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869661;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jwC0SviCdFMKke0uXj9EBclPdTB5NbpcKjEcImK+/Uo=;
	b=w4P5oi65tGILMQ+YiCy8K2BIFJ8knV4d8bPqyUPraFRNCsXihd27slOPYEnCsfzneDj8
	 xQ1ZLHcUH4FSoKPAWnTchc6xtQP3JqjmRAelqmuVyln0QcYc0d5fjxp50CRqdadD+8v58
	 AejR6dEj3IEXSt6DsR9CW14ef1zuRMGmPAP8PMp/PZ38Q5PPO4Bq8Gqez2Fq7M0oEPbBH
	 zkVoDbxnksbSwAMk1XgdhnMHTUOqEIExWPq0S1yCvrEb1hEXGq6S8I8ZtNx9UyH0YQt4u
	 MZpEgy+uPrZPc70LrfgZ+fPpjjbxVWgi0zfWsoHuWTD2ocycYlmxvNjnkUG2KIMj3QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOYkCwqA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EF606A31C;
	Mon, 16 Nov 2026 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOYkCwqA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090A01F000C4;
	Mon, 16 Nov 2026 22:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794869661;
	bh=jwC0SviCdFMKke0uXj9EBclPdTB5NbpcKjEcImK+/Uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mOYkCwqAgKjyevuy6fEXex7hLWb4WABigphe2i1p+qeCsmOoW07KKEnSeko3vFsEc
	 J6HEds+1ew4k8kRrM1HT/kA1VzfRH/aa1JvpYz6cBPOkSHh+Qs8aVGFVlhLsGn0QEa
	 Ls0ZYMS3H0fA28PqE/s7MqLzBLXJqfsOvQzHnI5twu2VEwtsZS6VqdsfmCC5PksrVC
	 Cn+1PRP6gTRt2BlDQZSNAiBstRhXHBhsbPafrG4+rhJcu+aKoC9fHnVLban5NJ02VV
	 JQgwQa3ymRH+bi5vdYmdhe0nnJxXHtM5p8MvHGNvilzbSSYs8K1ZJGOQroFO3ER50I
	 o0Wurn/yTnSPw==
Date: Mon, 16 Nov 2026 14:54:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: robin.murphy@arm.com, netdev@vger.kernel.org, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org
Subject: Re: [PATCH 00/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
Message-ID: <20261116145420.2b533196@kernel.org>
In-Reply-To: <17fd14e7-41e3-4658-a62c-1206fd2b5e0d@samsung.com>
References: <20261106184433.761422-1-kuba@kernel.org>
	<CGME20261112161622eucas1p131619576b0d4e6d201197007f3d7c951@eucas1p1.samsung.com>
	<20261112081616.13b81fab@kernel.org>
	<17fd14e7-41e3-4658-a62c-1206fd2b5e0d@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 10:57:06 +0100 Marek Szyprowski wrote:
> On 12.11.2026 17:16, Jakub Kicinski wrote:
> > On Fri,  6 Nov 2026 10:44:22 -0800 Jakub Kicinski wrote:  
> >> Stable tag on top of v7.4-rc1, so that we can also pull this into
> >> the networking tree:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_alloc_coherent_node  
> > Marek, Robin, would you be willing to pull?
> > Or should I respin the tag to include the latest Ack/Review tags from
> > the list?  
> If possible, respin the tag with latest acks/reviews, then I will pull it to
> my dma-mapping-for-next branch.

SG, added the tags and re-pushed:

  git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_alloc_coherent_node
