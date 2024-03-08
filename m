Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AF19BDC
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916629; cv=none; b=ZgtOqQbpJbQFRH2jxvStEhafLY0r4prhITcza6/8TCfBf09vaqpmaFAFM20mnHFzZxlWyd8R3avQtYF613nzGHiYrExz6XnLztJRlsobJG6tDqsu8oUUqcpEzRz/U/4irPzYGmg6ddKBKNllw6Wmv6lu4yXzx8PxY9oAkGU1BG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916629; c=relaxed/simple;
	bh=i1Ee+3NTxTAHNdgHBDCqKa6qILKMpt+tuFxakbTmL34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3nr7OeIRgbGQWcgTpNtdbTab0ERXI8TDiF3hS7zkUdfa9dDdm7Oy78FqeAlM1X0IbzARbEEyv8OaQZmGHu+kfXbVOHRlefu1qarKt2rxqymnnV9CWgUzQVztLuZIrHGxi+c5gnkNaTqzIzRoCHVLDrA2juL+5TFRG55/rGikNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8661468BEB; Fri,  8 Mar 2024 17:50:25 +0100 (CET)
Date: Fri, 8 Mar 2024 17:50:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings
 >= PAGE_SIZE
Message-ID: <20240308165025.GA18550@lst.de>
References: <20240308152829.25754-1-will@kernel.org> <20240308152829.25754-7-will@kernel.org> <5c7c7407-5356-4e12-a648-ae695fe0d1cb@arm.com> <20240308173816.5351ea58@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240308173816.5351ea58@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 08, 2024 at 05:38:16PM +0100, Petr Tesařík wrote:
> I thought we agreed that this stricter alignment is unnecessary:
> 
>   https://lore.kernel.org/linux-iommu/20240305140833.GC3659@lst.de/
> 
> But if everybody else wants to have it...

Let's get the fixes in with the existing documented alignment, and
then lift it in the next merge window with enough soaking time in
linux-next.
