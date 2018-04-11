From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
	scatter-gather buffers
Date: Wed, 11 Apr 2018 16:32:13 +0100
Message-ID: <2d812da5-1c0d-0e53-83f2-ba1781a12fe9@arm.com>
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
	<32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
	<1a1d0069-c8d3-cc0d-cf1c-8e90e4a2b0d7@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1a1d0069-c8d3-cc0d-cf1c-8e90e4a2b0d7-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sulrich-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:DRM DRIVERS" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/04/18 15:33, Sinan Kaya wrote:
> On 4/11/2018 8:03 AM, Robin Murphy wrote:
>> On 10/04/18 21:59, Sinan Kaya wrote:
>>> Code is expecing to observe the same number of buffers returned
>>> from dma_map_sg() function compared to
>>> sg_alloc_table_from_pages(). This doesn't hold true universally
>>> especially for systems with IOMMU.
>> 
>> So why not fix said code? It's clearly not a real hardware
>> limitation, and the map_sg() APIs have potentially returned fewer
>> than nents since forever, so there's really no excuse.
> 
> Sure, I'll take a better fix if there is one.
> 
>> 
>>> IOMMU driver tries to combine buffers into a single DMA address
>>> as much as it can. The right thing is to tell the DMA layer how
>>> much combining IOMMU can do.
>> 
>> Disagree; this is a dodgy hack, since you'll now end up passing
>> scatterlists into dma_map_sg() which already violate max_seg_size
>> to begin with, and I think a conscientious DMA API implementation
>> would be at rights to fail the mapping for that reason (I know
>> arm64 happens not to, but that was a deliberate design decision to
>> make my life easier at the time).
>> 
>> As a short-term fix, at least do something like what i915 does and
>> constrain the table allocation to the desired segment size as well,
>> so things remain self-consistent. But still never claim that faking
>> a hardware constraint as a workaround for a driver shortcoming is
>> "the right thing to do" ;)
> 
> You are asking for something like this from here, right?
> 
> https://elixir.bootlin.com/linux/v4.16.1/source/drivers/gpu/drm/i915/i915_gem_dmabuf.c#L58

I just looked for callers of __sg_alloc_table_from_pages() with a limit 
other than SCATTERLIST_MAX_SEGMENT, and found 
__i915_gem_userptr_alloc_pages(), which at first glance appears to be 
doing something vaguely similar to amdgpu_ttm_tt_pin_userptr().

Robin.
