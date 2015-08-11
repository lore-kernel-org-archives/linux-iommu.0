From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 1/3] iommu: Implement common IOMMU ops for DMA mapping
Date: Tue, 11 Aug 2015 14:31:34 +0100
Message-ID: <55C9F936.8080201@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
	<6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
	<20150807084228.GU14980@8bytes.org> <55C4B4DF.4040608@arm.com>
	<20150811093742.GC14980@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150811093742.GC14980-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 11/08/15 10:37, Joerg Roedel wrote:
> On Fri, Aug 07, 2015 at 02:38:39PM +0100, Robin Murphy wrote:
>> Indeed, DMA_DEBUG will check that a driver is making DMA API calls
>> to the arch code in the right way; this is a different check, to
>> catch things like the arch code passing the wrong domain into this
>> layer, or someone else having messed directly with the domain via
>> the IOMMU API. If the iommu_unmap doesn't match the IOVA region we
>> looked up, that means the IOMMU page tables have somehow become
>> inconsistent with the IOVA allocator, so we are in an unrecoverable
>> situation where we can no longer be sure what devices have access
>> to. That's bad.
>
> Sure, but the BUG_ON would also trigger on things like a double-free,
> which is bad to handle as a BUG_ON. A WARN_ON for this is sufficient.

Oh dear, it gets even better than that; in the case of a simple 
double-unmap where the IOVA is already free, we wouldn't even get as far 
as that check because we'd die calling iova_size(NULL). How on Earth did 
I get to v5 without spotting that? :(

Anyway, on reflection I think you're probably right; I've clearly been 
working on this for long enough to start falling into the "my thing is 
obviously more important than all the other things" trap.

>> AFAIK, yes (this is just a slight tidyup of the existing code that
>> 32-bit Exynos/Tegra/Rockchip/etc. devices are already using) - the
>> display guys want increasingly massive contiguous allocations for
>> framebuffers, layers, etc., so having IOMMU magic deal with that
>> saves CMA for non-IOMMU devices that really need it.
>
> Makes sense, I thougt about something similar for x86 too to avoid the
> high-order allocations we currently do. I guess the buffer will later be
> mapped into the vmalloc space for the CPU?

Indeed - for non-coherent devices we have to remap all allocations 
(IOMMU or not) anyway in order to get a non-cacheable CPU mapping of the 
buffer, so having non-contiguous pages is no bother; for coherent 
devices we can just do the same thing but keep the vmalloc mapping 
cacheable. There's also the DMA_ATTR_NO_KERNEL_MAPPING case (e.g. GPU 
just wants a big buffer to render into and read back out again) where we 
wouldn't need a CPU address at all, although on arm64 vmalloc space is 
cheap enough that we've no plans to implement that at the moment.

Robin.
