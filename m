From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC v2] dma-mapping: Use unsigned long for dma_attrs
Date: Wed, 01 Jun 2016 08:08:11 +0200
Message-ID: <574E7BCB.6040505@samsung.com>
References: <1464609246-6948-1-git-send-email-k.kozlowski@samsung.com>
 <1464609246-6948-2-git-send-email-k.kozlowski@samsung.com>
 <20160531181533.GD11300@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <20160531181533.GD11300@char.us.oracle.com>
Sender: linux-doc-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org, sstabellini@kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 05/31/2016 08:15 PM, Konrad Rzeszutek Wilk wrote:
> On Mon, May 30, 2016 at 01:54:06PM +0200, Krzysztof Kozlowski wrote:
>> The dma-mapping core and the implementations do not change the
>> DMA attributes passed by pointer.  Thus the pointer can point to const
>> data.  However the attributes do not have to be a bitfield. Instead
>> unsigned long will do fine:
>>
>> 1. This is just simpler.  Both in terms of reading the code and setting
>>    attributes.  Instead of initializing local attributes on the stack and
>>    passing pointer to it to dma_set_attr(), just set the bits.
>>
>> 2. It brings safeness and checking for const correctness because the
>>    attributes are passed by value.
> 
> 
> .. why not go the next step a do an enum? Perhaps that should be mentioned
> as part of the description?

These are additive flags so to me this would look a little bit weird:
enum dma_attr {
	DMA_ATTR_WRITE_BARRIER	= 0x1,
	DMA_ATTR_WEAK_ORDERING	= 0x2,
	DMA_ATTR_WRITE_COMBINE	= 0x4,
	DMA_ATTR_NON_CONSISTENT	= 0x8,
	...
}

It doesn't really look like enumeration.

Best regards,
Krzysztof
