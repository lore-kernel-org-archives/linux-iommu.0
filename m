From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [v2 1/1] iommu/tegra: smmu: Support variable MMIO ranges/blocks
Date: Tue, 29 Jan 2013 10:57:25 -0700
Message-ID: <51080D85.4050201@wwwdotorg.org>
References: <50FD752A.6060706@wwwdotorg.org><1359448450-24894-1-git-send-email-hdoyu@nvidia.com><510800F7.7020507@wwwdotorg.org> <20130129.194007.2143867447969494923.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130129.194007.2143867447969494923.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/29/2013 10:40 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Tue, 29 Jan 2013 18:03:51 +0100:
> 
>>> +	/* Same as "mc" 1st regiter block start address */
>>> +	smmu->regbase = (void __iomem *)((u32)smmu->regs[0] & ~PAGE_MASK);
>>
>> I'm not sure if it's relevant how these register ranges are related to
>> the MC registers, given this is the SMMU driver?
> 
> All SMMU register offsets are against MC[0]'s start address and SMMU
> register blocks are interleaved as below. The 1st SMMU register block
> SMMU[0]'s offset is always 0x10.
> 
> Address Register block
> -----------------------
> 000-010	MC[0]
> 010-03c	SMMU[0]
> 03c-1f0	MC[1]
> 1f0-200	SMMU[1]
> 200-228	MC[2]
> 228-284	SMMU[2]
> 284-...	MC[3]

I know that's true, but it's still not really relevant to the SMMU
driver. What is relevant is that the SMMU has a bunch of chunks of
address space containing SMMU registers, and there are gaps, and all the
register offsets in the SMMU driver are relative to the page-aligned
base of the first chunk. The fact the gaps contain MC registers is what
isn't relevant.

> If the above assumption is not acceptable, alternatively we need to
> access MC's node to get the 1st MC register block start address, for
> example, via embedded in MC's phandle in smmu entry.

Like I said, the code is fine so I'm not really objecting to it.
