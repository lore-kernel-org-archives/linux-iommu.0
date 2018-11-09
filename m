From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: iommu/io-pgtable-arm-v7s: About pagetable 33bit PA
Date: Fri, 9 Nov 2018 16:32:18 +0800
Message-ID: <CANMq1KAAm4J_EWXhK=eMAfQLPNuciY3CRtq_=nq5PLDXnRw3qw@mail.gmail.com>
References: <1541662292.22369.22.camel@mhfsdcap03>
	<1093be2a-f9e8-1889-fc9f-b44b6ecfd7da@arm.com>
	<1541749871.19841.13.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1541749871.19841.13.camel@mhfsdcap03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin/Yong,

On Fri, Nov 9, 2018 at 3:51 PM Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
>
> On Thu, 2018-11-08 at 13:49 +0000, Robin Murphy wrote:
> > On 08/11/2018 07:31, Yong Wu wrote:
> > > Hi Robin,
> > >
> > > After the commit ad67f5a6545f ("arm64: replace ZONE_DMA with
> > > ZONE_DMA32"), we don't have ZONE_DMA in aarch64, but
> > > __arm_v7s_alloc_table[1] use the GFP_DMA to expect the physical address
> > > of pagetable should be 32bit.
> > >
> > > Right now we meet a issue that the lvl1 pagetable PA is 0x1_3ab6_0000 in
> > > the 4GB broad. then the IOMMU initialize failed.(This issue can be fixed
> > > if we revert ad67f5a6545f.)
> >
> > But that shouldn't actually be failing on MTK platforms anyway, right,
> > since your IOMMU is still capable of addressing that? Seems like we
> > overlooked that check in __arm_v7s_alloc_table(), where the conversion
> > by casting will want updating to something like
> > "iopte_to_paddr(paddr_to_iopte(...))" in patch #4 of your series.
>
> The current mt8183 IOMMU support the pagetable address over 4GB.
> Unfortunately the previous mt8173 don't support.(mt8173 IOMMU support
> mapping for the dram over 4GB while its pagetable still need locate
> below 4GB.)
>
> In order to unify the code, we still expect lvl2 pagetable base don't
> over 4GB. thus I didn't change it in the current patchset.
>
> >
> > > I planed to add GFP_DMA32 for pagetable allocation. the level1 was
> > > ok but level2 was failed. It looks that slab don't like GFP_DMA32[2].
> > > this is the warning log:
> > > =====
> > > Unexpected gfp: 0x4 (GFP_DMA32). Fixing up to gfp: 0x488020 (GFP_ATOMIC|
> > > __GFP_ZERO). Fix your code!
> > > =====
> > > I don't know why slab don't allow GFP_DMA32, the gfp flags seems only
> > > be bypassed to alloc_page. Is it possible that let slab allow GFP_DMA32
> > > for aarch64?
> > I had a bit of a look into it some time ago, and I don't recall seeing
> > any obvious reason that the kmem_cache API couldn't support ZONE_DMA32
> > in general (either via a separate SLAB_CACHE_DMA32, or just overloading
> > SLAB_CACHE_DMA depending on which of CONFIG_ZONE_DMA/CONFIG_ZONE_DMA32
> > are enabled) - I guess that's just never been implemented since nobody
> > needed it before.
>
> Thanks for the comment. We could try a patch for this.

I made an attempt here, if that's helpful:
https://lore.kernel.org/patchwork/cover/1009116/ .

I'm still a bit uncomfortable with GFP_DMA passed to kmem_cache_alloc
suddenly becoming GFP_DMA32 in the underlying call, but I'm not sure
if there is a better way (apart from duplicating the caches, and a lot
of ifdefs in callers).

Thanks,

> >
> > Robin.
> >
> > > We notice that this has been discussed[3]. but if we use alloc_page for
> > > the level2 pagetable, It may waste lots of memory.
> > >
> > > Any suggestion is appreciated.
> > >
> > >
> > > Reported-by: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > >
> > > [1]
> > > https://elixir.bootlin.com/linux/v4.20-rc1/source/drivers/iommu/io-pgtable-arm-v7s.c#L200
> > > [2] https://elixir.bootlin.com/linux/v4.20-rc1/source/mm/internal.h#L37
> > > [3] https://patchwork.kernel.org/patch/10474289/
> > >
>
>
