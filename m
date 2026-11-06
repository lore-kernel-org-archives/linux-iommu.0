Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999901;
	b=1ZoTV+4w2yTLdU1NFVEWdnSKlE8AysflBN+iRT4HqB949f+UebqrdyTtE1/abHNaenN9
	 pzx0wNMSin6N3mrYoL0IrDcJDbWTa/aHxcFj7r5VVSBNxFt0k4fay3Zdw+rNIg3FaKsEH
	 vkUFH6wV9Z9ZGs1O7ijltiIqHk3rgDdKrpRGALNU6Y6aonY2AvbK2T/9C9wy9ByumaJ6O
	 f8KHZ60jeHD0cJC/d76hXDqLzod3K/gZGWmHgrxIk0CHz8dTilrxYhpxJXczO7NzpMYfz
	 9w623dpv+ZrjM3TaalLQJPIShKiFIs6+eosikAuL6MaXliCTYmWcrtzk4ffcOjr3ElA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999901;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=toc3VIJtaDo7Q+DZvm/d/cwob9aXNkkAYYokvXPgfuM=;
	b=IuGkfq5hsc8lQ3wvY4stcVZ2HvV9rkzgWcgsyhVfq45LH1VXcPD/CR4s26ZA59QXdkAm
	 hE7mXm7Zm06QKpkxEfapIHXd6NpAA6Hib60AJ5+/xd+zzi1prjesRZU664hHjLFg3CjPg
	 0gfbeFDL8OXlEOWqQ7AC6s2jpzrVnDd/aemSI/BizylsRN8685wICr4n63P5JpBmkIxge
	 T2eWV4TnNITSIRVUZbR0BodoGl+FYrrow5qcnalAqmrKnnIkmrSVSawLZXX3tjNzPuqxN
	 zXEOFp0MBi+q4kHPo9Xk1d3Fbga8e67x0po0Myx/XXFoqjl/gMNhl+zZ4aeWuWUzh/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqf27qKh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BCC606A326;
	Fri,  6 Nov 2026 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqf27qKh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C7A1F008A1;
	Fri,  6 Nov 2026 21:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999900;
	bh=toc3VIJtaDo7Q+DZvm/d/cwob9aXNkkAYYokvXPgfuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fqf27qKh9kuiS1bdOgj+2GkXkpPZ3SdkT/+wvuXoy0ekj3K2nuRQNKTnq3cHKMnDW
	 PFUebkFSpuv7V6Avcgv+EkFyYWy6BC6NhI0B0WY0zUul+y3RMJTws+UYWImFqY2kc/
	 Dn6d3zXbpQVYhqOFyQfTntRPMuKHK4/GCUzaRC0sBYBTeR0MGGWt5NWT+eEFF0/r6f
	 ledAefKk6vaLSKFLAn49wGOassovjoDJJkeipIV9ZQdyXqUNjFuDy5zIghWhDOvO+D
	 ehF4UFWwC0JH/oNahgy/mfZDION/xUKWTw8xCLoVCHgClbY8/rlvo0CpFKuXNvHKVn
	 TBbGjGrAQirjw==
Date: Fri, 6 Nov 2026 15:18:15 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Saravana Kannan <saravanak@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] of: reserved_mem: Drop node_fixup, CMA can handle it
 internally again
Message-ID: <179399989427.1724666.16449745308990999422.robh@kernel.org>
References: <CGME20261105215426eucas1p1fb2de3113bd185a84e1d0925e14fc4fc@eucas1p1.samsung.com>
 <20261105215413.1439745-1-m.szyprowski@samsung.com>
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
In-Reply-To: <20261105215413.1439745-1-m.szyprowski@samsung.com>


On Thu, 05 Nov 2026 22:54:11 +0100, Marek Szyprowski wrote:
> The separate fixup step was needed because node initialization used to
> run too late, after paging_init(). Since commit aa05faf81583 ("of:
> reserved_mem: allocate and map the reserved_mem array early") node_init
> runs early enough again, so dma_contiguous_early_fixup() can be called
> directly from rmem_cma_setup() once the CMA region has been successfully
> initialized, as it was before commit 2c223f7239f37 ("of: reserved_mem:
> Restructure call site for dma_contiguous_early_fixup()").
> 
> Drop the now unused node_fixup callback and its helper. This also fixes
> the premature call to fixup when region fails to initialize.
> 
> Closes: https://sashiko.dev/#/bug/linux-61818eaa-5dc1-4457-bd21-3a9be2ed4d6d
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/of/of_reserved_mem.c    | 34 ---------------------------------
>  include/linux/of_reserved_mem.h |  2 --
>  kernel/dma/contiguous.c         | 17 +++--------------
>  3 files changed, 3 insertions(+), 50 deletions(-)
> 

Applied, thanks!

