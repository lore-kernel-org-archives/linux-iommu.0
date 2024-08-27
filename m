Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC19819EEC2
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759883; cv=none; b=e+pLZDM1WfSLLHlpUy0HgZB1NevxGqhdQfxU20UV1SGTjU3Wgod0Csi5JRht8Bz+7SGUoY2h+9VKJDTkSdinrwr1faLV+UU5o16aye0Xattu8Dna6XQo0edLP/ea+b57ZXlxZVVVXLTkKdKHKE3hPOUrO61IJXudNlJcTSedIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759883; c=relaxed/simple;
	bh=Flx7bTsY17IE7Wjk12EgYowMqnfPFZ5Az3DmuH6EEpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fm3maea4w51ub8yw0zjeOFtXBvRQbGLFJMqHsSud+Q9rp4g6wWOo/w3wMPvXWAFPZgX9b9muBMoIjqK92w+skLxl8m4KeAi/3j8gDYBxo4agab7KzZryXeyNLskh/2P0+ugGFHXm4IAU8us6k5dGRvMNGoCUiYrCOg4xfPB+uzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4923CDA7;
	Tue, 27 Aug 2024 04:58:27 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85FE3F762;
	Tue, 27 Aug 2024 04:57:59 -0700 (PDT)
Message-ID: <f803659b-d98a-4472-98e4-7deebb9df45f@arm.com>
Date: Tue, 27 Aug 2024 12:57:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default ops
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1721818168.git.leon@kernel.org>
 <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>
 <20369981-37c8-482a-9ffa-cf54d12dad2d@arm.com> <20240816071134.GA2943@lst.de>
 <91b6da73-fc59-4751-8215-1edf68de222e@arm.com>
 <20240820122240.GA17459@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240820122240.GA17459@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2024 1:22 pm, Christoph Hellwig wrote:
> On Mon, Aug 19, 2024 at 02:16:56PM +0100, Robin Murphy wrote:
>> Thanks, I've just had a quick look over what you queued on
>> dma-iommu-direct-calls, and you're welcome to stick my ack on that if you
>> like.
> 
> Yes, thank you a lot for your review!
> 
> While I have your attention - with these two patches we stop building
> dummy_dma_ops for most common configs.  Do you think we need additional
> safeguards for this case?  My idea would be to remove them and force the
> bus_dma_mask to zero where we currently set the dummy ops, but I could
> use a little reality check for that idea.

Yeah, the dummy ops were a nice idea at the time, but have been looking 
increasingly anachronistic for a while - in fact I think they're 
effectively broken already now, since if arm64 stops selecting DMA_OPS 
via IOMMU_DMA then the set_dma_ops() in the ACPI path isn't going to be 
effective anyway.

I certainly don't hate the idea of using bus_dma_limit as the next most 
functionally robust way to deny DMA for now. It would probably be a bit 
awkward to upheave the existing notion of 0 meaning no limit, but 
setting it to 1 would have the desired effect in practice (at least with 
dma-direct), plus would look nicely deliberate - for completeness we'd 
probably just want an extra check or two in the right place(s) to ensure 
that such a DMA-denied device still can't end up being given ops other 
than dma-direct, but that seems simple enough.

Thanks,
Robin.
