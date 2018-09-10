From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
	device
Date: Mon, 10 Sep 2018 17:06:40 +0100
Message-ID: <aa6f49f8-24ea-f166-9c58-aecb13df0418@arm.com>
References: <20180910060533.27172-1-hch@lst.de>
	<20180910060533.27172-3-hch@lst.de>
	<71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com>
	<20180910154747.GA23578@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180910154747.GA23578-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/09/18 16:47, Christoph Hellwig wrote:
>>> --- a/kernel/dma/Kconfig
>>> +++ b/kernel/dma/Kconfig
>>> @@ -13,6 +13,9 @@ config NEED_DMA_MAP_STATE
>>>    config ARCH_DMA_ADDR_T_64BIT
>>>    	def_bool 64BIT || PHYS_ADDR_T_64BIT
>>>    +config ARCH_HAS_DMA_COHERENCE_H
>>> +	bool
>>
>> This seems a little crude - is it unbearably churny to make an
>> asm-generic/dma-coherence.h implementation for everyone else?
> 
> The case of having something else than the per-device flag is rather
> odd, and I hope we don't grow any new user in addition to mips.
> 
> In fact I'm already thinking of ways to get rid of it for mips by
> e.g. iterating over all devices and just setting dma_coherent,
> but for now I wanted to solve the more urgen issues and tackle this
> later, as this unification blocks a few other things

Ah, somehow I started thinking that arm(64) would need to implement 
their own as well, but I see the point now. In that case, TBH I'd be 
quite happy with just a simple #ifdef CONFIG_MIPS in 
linux/dma-noncoherent.h - plus then it looks even more like something 
nobody else is expected to do.

>> Nits aside, this otherwise looks sane to me for factoring out the
>> equivalent Xen and arm64 DMA ops cases.
> 
> Like this? :)
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent

Man, that's going to take me a *lot* of time to pick through. All those 
horrendous subtleties that I barely remember!

Robin.
