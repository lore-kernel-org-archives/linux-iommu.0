Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A526FA52;
	Tue,  1 Jul 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379646; cv=none; b=HXMNV8C5HA7VxSPVsR3/I7a/Ke2Nh/h4ujLFxTIx4GXI8JY78fdnBWV3jQSae0s9+sSjlrjnqLdFLGuH8Sz8XiMVlasICOF+aN+PxBKEOVXVLvVTy5YpAGm/frvc4dDP81Zy3hf0Lh1ddDRb7yCOVM0qTpiP6BROqj9uYNeSWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379646; c=relaxed/simple;
	bh=rmzUj4ZD9gm0HoCKYYLt0+PcJutRfusCkPSoIPsvInY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGcpF9jrrKkrcYrtmDtCUjwakUZDVZAxdPcrQDmX7ym+y+oQKcStTLxcGNuzfPKRM0UFZwCg0t6bVKq5spgGAyYXOnxSuaYTR1H6+QBe1TK6f9RByDq03FTZ7X1Tj7BBFHAtHZRNDuKhGdkCtBqgWiZNCCiRV86ZAVRiSPuu7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrQmbsRO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrQmbsRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204C0C4CEEB;
	Tue,  1 Jul 2025 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751379645;
	bh=rmzUj4ZD9gm0HoCKYYLt0+PcJutRfusCkPSoIPsvInY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrQmbsROkn81Qa45c1fXnnZNNwmO4+YXtGItxTGRGBkTFbZZa5KYuNhhED+a2z1C8
	 /jDDOdJEHdsA6yKmKxHPEKvd1wAf0YJlgIDu7C2HDh3tSeeVk8zTBYPKv/YtRr9LEx
	 b/RDk95xlMMehf6Mmdn7gursNVIzApQqij+z0W2woKboY6lOQkFER0yZXIh86VSM3U
	 Xaus1CtbQ1Httfkl7TuaCqqwIlbYxVot3BV5RHXyMco/pZzZrMI5abvI5dWKIuYzvk
	 lC15LIJZPJ9L+TOwVn80cWzHv4IBjaVB35QJn2yCGW9XkSaSJq5vIzWBw2KLW4dmP0
	 5dD1M7fg3HabA==
Date: Tue, 1 Jul 2025 10:20:41 -0400
From: Keith Busch <kbusch@kernel.org>
To: Ben Copeland <ben.copeland@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGPuue3_-BSPffR0@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
 <aGLyswGYD6Zai_sI@kbusch-mbp>
 <CAL0q8a7acv-9N1XUmJ9LAojdhm947eiira6Kx0tew-VVVCY6kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL0q8a7acv-9N1XUmJ9LAojdhm947eiira6Kx0tew-VVVCY6kg@mail.gmail.com>

On Tue, Jul 01, 2025 at 02:05:04PM +0100, Ben Copeland wrote:
> Even though SGLs are not supported, I gave you the patch a spin and
> saw the same stack traces.

Right, that patch applies only if SGL is not supported, but it's only
fixing part of the problem, so I expected it would still fail.

The dma teardown needs to be symetric to the dma mapping, but we've
removed the sg-table now, so we don't have the original mapping context
in the completion path here. Christoph replied with a patch that tries
to infer it based on the dma_addr continuity, which I think should work
for you, but I'll have to look a bit closer to be confident it's always
the correct assumption.
