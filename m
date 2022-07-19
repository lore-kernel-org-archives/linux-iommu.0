Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20CE4688
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 17:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4BAC341C6;
	Tue, 19 Jul 2022 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658252176;
	bh=gDYE8ppwu4c1VBpCapCFmc8Ncr59buDgfCRpCfpBWao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQ/tzIcYwRa/8vFPHrtwoZ3BQGroiMAvYMrUVB3PvCWLsfF/G0f/UfevKmHRyA0CP
	 Lwen4a4231vb+tULXGgwtqcFCtu8tAzfv5TjBvW2Eyt6nYiZV4ihTCNnT6BJINjtHd
	 bKWVdEAjLu7cqXSwJ30axvps5Gq329wcV5Gnt/xGbVCMeXcXfJy0YdC/cmgZs1znc2
	 jNGI/WQ4uq4KId6yDE4GzKKfVRfA+bur5CcEGQqivTLpsILKKtjPaIgJk2yfviuY3Y
	 yovmdFzePKMyFjghQStzwMmJyfM6uLFmc3RzZJ2AvAssPvo7t9MThV2FdGVnmZjObg
	 IF4e6Io1MioiA==
Date: Tue, 19 Jul 2022 18:36:10 +0100
From: Will Deacon <will@kernel.org>
To: Subkhankulov Rustam <subkhankulov@ispras.ru>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	ldv-project@linuxtesting.org
Subject: Re: [POSSIBLE BUG] iommu/io-pgtable-arm: possible dereferencing of
 NULL pointer
Message-ID: <20220719173610.GA14526@willie-the-truck>
References: <28df50012344fb1c925a7ceaf55ae400152ffb48.camel@ispras.ru>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28df50012344fb1c925a7ceaf55ae400152ffb48.camel@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jul 18, 2022 at 12:20:06PM +0300, Subkhankulov Rustam wrote:
> Version: 5-19-rc6
> 
> In function '__arm_lpae_alloc_pages' pointer 'dev' is compared with 
> NULL at [drivers/iommu/io-pgtable-arm.c: 203]. This means that the 
> pointer can be NULL.
> 
> -----------------------------------------------------------------------
> 203 	p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
> 204 			     gfp | __GFP_ZERO, order);
> -----------------------------------------------------------------------
> 
> Then, if cfg->coherent_walk == 0 at [drivers/iommu/io-pgtable-arm.c: 
> 209], function 'dma_map_single', which is defined as 
> 'dma_map_single_attrs', is called and pointer dev is passed as 
> first parameter.
> 
> -----------------------------------------------------------------------
> 209 	if (!cfg->coherent_walk) {
> 208 		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
> -----------------------------------------------------------------------
> 
> Therefore, pointer 'dev' passed to function 'dev_driver_string' 
> in macro 'dev_WARN_ONCE' at [include/linux/dma-mapping.h: 326], 
> where it is dereferenced at [drivers/base/core.c: 2091].
> 
> -----------------------------------------------------------------------
> 2083	const char *dev_driver_string(const struct device *dev)
> 2084	{
> 2085		struct device_driver *drv;
> 2086
> ---
> 2091		drv = READ_ONCE(dev->driver);
> -----------------------------------------------------------------------
> 
> Thus, if it is possible that 'dev' is null at the same time 
> that flag 'coherent_walk' is 0, then NULL pointer will be 
> dereferenced.
> 
> Should we somehow avoid NULL pointer dereference or is this 
> situation impossible and we should remove comparison with NULL?

I think 'dev' is only null in the case of the selftest initcall
(see arm_lpae_do_selftests()), and 'coherent_walk' is always true there.

Will
