Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D10604A9
	for <iommu@lists.linux.dev>; Mon, 29 Jan 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530515; cv=none; b=IZgxLHMzDgv3r/05X8r8EGrKylVueSHcZbgaKMsMwkvN2m4ldyYqpJtwKVrXHpLQfQ1/v0bBwsangE1nSBc+2vjdXSyM3qtQC96ZowzRdlNX5dkyLSZ7jJylBfPfHcBaE84ACz0UN4H7oYnp3WZmVjjbn8Tf9KVFNsw3UpvpEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530515; c=relaxed/simple;
	bh=CI2SITbEyDMK/SnfUcFawfQgI/5HdPELOd7hdQeM9Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyBtK3dhVPMRPjrPx5YkOOceEqP7zIUoF2Nrx3VVJDBV2ZsPnNj23sZNogPv9JwX1+HhAyF6uDOql2sPphm8luDfaVf0rBk53FiE/woxpg+CzEgwH/6epgIAg2dttyOD0eiqLc6Mhm/9jNF61+KxbFGH2Zp0d5UN+6MGTwbfNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 296821FB;
	Mon, 29 Jan 2024 04:15:56 -0800 (PST)
Received: from [10.57.77.253] (unknown [10.57.77.253])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8F643F5A1;
	Mon, 29 Jan 2024 04:15:09 -0800 (PST)
Message-ID: <df8f1bf4-819a-4b2a-927d-e97fe196cdf6@arm.com>
Date: Mon, 29 Jan 2024 12:15:07 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] dma: compile-out DMA sync op calls when not
 used
Content-Language: en-GB
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
 <20240126135456.704351-2-aleksander.lobakin@intel.com>
 <20240129061136.GD19258@lst.de>
 <4e23d103-ea1c-4fd3-852e-f7e2ec9170ad@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4e23d103-ea1c-4fd3-852e-f7e2ec9170ad@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-29 11:07 am, Alexander Lobakin wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 29 Jan 2024 07:11:36 +0100
> 
>> On Fri, Jan 26, 2024 at 02:54:50PM +0100, Alexander Lobakin wrote:
>>> Some platforms do have DMA, but DMA there is always direct and coherent.
>>> Currently, even on such platforms DMA sync operations are compiled and
>>> called.
>>> Add a new hidden Kconfig symbol, DMA_NEED_SYNC, and set it only when
>>> either sync operations are needed or there is DMA ops or swiotlb
>>> enabled. Set dma_need_sync() and dma_skip_sync() (stub for now)
>>> depending on this symbol state and don't call sync ops when
>>> dma_skip_sync() is true.
>>> The change allows for future optimizations of DMA sync calls depending
>>> on compile-time or runtime conditions.
>>
>> So the idea of compiling out the calls sounds fine to me.  But what
>> is the point of the extra indirection through the __-prefixed calls?
> 
> Because dma_sync_* ops are external functions, not inlines, and in the
> next patch I'm adding a check there.
> 
>>
>> And if we need that (please document it in the commit log), please
>> make the wrappers proper inline functions and not macros.

In fact those wrappers could perhaps subsume the existing stub 
definitions, by starting with a refactor along these lines:

static inline dma_sync_x(...)
{
	if (IS_ENABLED(CONFIG_NEED_DMA_SYNC))
		__dma_sync_x(...);
}

Cheers,
Robin.
