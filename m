From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 3/6] iommu: add ARM short descriptor page table
	allocator.
Date: Mon, 14 Sep 2015 20:25:00 +0800
Message-ID: <1442233500.19588.35.camel@mhfsdcap03>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
	<1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
	<20150721171101.GN31095@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150721171101.GN31095-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel@pen>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-07-21 at 18:11 +0100, Will Deacon wrote:
[...]
> > +static int arm_short_map(struct io_pgtable_ops *ops, unsigned long iova,
> > +                        phys_addr_t paddr, size_t size, int prot)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> > +       int ret;
> > +       arm_short_iopte pgdprot = 0, pteprot = 0;
> > +       bool large;
> > +
> > +       /* If no access, then nothing to do */
> > +       if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> > +               return 0;
> > +
> > +       switch (size) {
> > +       case SZ_4K:
> > +       case SZ_64K:
> > +               large = (size == SZ_64K) ? true : false;
> > +               pteprot = __arm_short_pte_prot(data, prot, large);
> > +               pgdprot = __arm_short_pgtable_prot(data, prot & IOMMU_NOEXEC);
> > +               break;
> > +
> > +       case SZ_1M:
> > +       case SZ_16M:
> > +               large = (size == SZ_16M) ? true : false;
> > +               pgdprot = __arm_short_pgd_prot(data, prot, large);
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (WARN_ON((iova | paddr) & (size - 1)))
> > +               return -EINVAL;
> > +
> > +       ret = _arm_short_map(data, iova, paddr, pgdprot, pteprot, large);
> > +
> > +       tlb->tlb_add_flush(iova, size, true, data->iop.cookie);
> > +       tlb->tlb_sync(data->iop.cookie);
> 
> In _arm_short_map, it looks like you can only go from invalid -> valid,
> so why do you need to flush the TLB here?

Hi Will,
   Here is about flush-tlb after map iova, I have deleted it in v4
following this suggestion. But We meet a problem about it.

Take a example with JPEG. the test steps is:
a).JPEG HW decode a picture with the source iova,like 0xfd780000.
b).JPEG HW decode done, It will unmap the iova(write 0 in pagetable and
flush tlb).
c).JPEG HW decode the second picture, whose source iova is also
0xfd780000.
   Then our HW maybe fail due to it will auto prefetch, It may prefecth
between the step b) and c). then the HW may fetch the pagetable content
which has been unmapped in step b). then the HW will get the iova's
physical address is 0, It will translation fault!

    So I think our HW need flush-tlb after map iova. Could we add a
QUIRK like "IO_PGTABLE_QUIRK_AUTO_PREFETCH_ENABLE" for it?
If it's not allowed, we will have to add this in our internal function
mtk_iommu_map of mtk_iommu.c.
Thanks.

> 
> > +       return ret;
> > +}
> > +
[...]
