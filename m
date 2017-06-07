From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 02/12] intel-ipu3: mmu: implement driver
Date: Thu, 8 Jun 2017 00:59:52 +0300
Message-ID: <20170607215951.GA21034@kekkonen.localdomain>
References: <1496695157-19926-1-git-send-email-yong.zhi@intel.com>
	<1496695157-19926-3-git-send-email-yong.zhi@intel.com>
	<CAAFQd5BZGVBdbN-8L+pvAf4AkBkB9UFy7_mmMpusFUMxDugQDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAFQd5BZGVBdbN-8L+pvAf4AkBkB9UFy7_mmMpusFUMxDugQDw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "Zheng, Jian Xu" <jian.xu.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Toivonen, Tuukka" <tuukka.toivonen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Mani,
	Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yong Zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

On Tue, Jun 06, 2017 at 07:13:19PM +0900, Tomasz Figa wrote:
> Hi Yong, Tuukka,
> 
> +CC IOMMU ML and Joerg. (Technically you should resend this patch
> including them.)

Thanks!

> 
> On Tue, Jun 6, 2017 at 5:39 AM, Yong Zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
...
> > diff --git a/drivers/media/pci/intel/ipu3/Kconfig b/drivers/media/pci/intel/ipu3/Kconfig
> > index 2a895d6..ab2edcb 100644
> > --- a/drivers/media/pci/intel/ipu3/Kconfig
> > +++ b/drivers/media/pci/intel/ipu3/Kconfig
> > @@ -15,3 +15,14 @@ config VIDEO_IPU3_CIO2
> >         Say Y or M here if you have a Skylake/Kaby Lake SoC with MIPI CSI-2
> >         connected camera.
> >         The module will be called ipu3-cio2.
> > +
> > +config INTEL_IPU3_MMU
> > +       tristate "Intel ipu3-mmu driver"
> > +       select IOMMU_API
> > +       select IOMMU_IOVA
> > +       ---help---
> > +         For IPU3, this option enables its MMU driver to translate its internal
> > +         virtual address to 39 bits wide physical address for 64GBytes space access.
> > +
> > +         Say Y here if you have Skylake/Kaby Lake SoC with IPU3.
> > +         Say N if un-sure.
> 
> Is the MMU optional? I.e. can you still use the IPU3 without the MMU
> driver? If no, then it doesn't make sense to flood the user with
> meaningless choice and the driver could simply be selected by other
> IPU3 drivers.

There are other IPUs that contain the same hardware, so they would
presumably use the same driver.

> 
> And the other way around, is the IPU3 MMU driver useful for anything
> else than IPU3? If no (but yes for the above), then it should depend
> on some other IPU3 drivers being enabled, as otherwise it would just
> confuse the user.

Very likely not.

For now I think it'd be fine to have the driver separate from the rest of
the IPU3 but without a separate Kconfig option.

> 
> > diff --git a/drivers/media/pci/intel/ipu3/Makefile b/drivers/media/pci/intel/ipu3/Makefile
> > index 20186e3..2b669df 100644
> > --- a/drivers/media/pci/intel/ipu3/Makefile
> > +++ b/drivers/media/pci/intel/ipu3/Makefile
> > @@ -1 +1,2 @@
> >  obj-$(CONFIG_VIDEO_IPU3_CIO2) += ipu3-cio2.o
> > +obj-$(CONFIG_INTEL_IPU3_MMU) += ipu3-mmu.o
> > diff --git a/drivers/media/pci/intel/ipu3/ipu3-mmu.c b/drivers/media/pci/intel/ipu3/ipu3-mmu.c
> > new file mode 100644
> > index 0000000..a9fb116
> > --- /dev/null
> > +++ b/drivers/media/pci/intel/ipu3/ipu3-mmu.c

...

> > +/**
> > + * ipu3_mmu_alloc_page_table - get page to fill entries with dummy defaults
> > + * @d: mapping domain to be worked on
> > + * @l1: True for L1 page table, false for L2 page table.
> > + *
> > + * Index of L1 page table points to L2 tbl
> > + *
> > + * Return: Pointer to allocated page table
> > + * or NULL on failure.
> > + */
> > +static uint32_t *ipu3_mmu_alloc_page_table(struct ipu3_mmu_domain *d, bool l1)
> > +{
> > +       uint32_t *pt = (uint32_t *)__get_free_page(GFP_KERNEL);
> 
> Style: I believe u32 is preferred in the kernel.

There are some 30000 users of uint32_t alone in the kernel. I'd say it
should be fine. (I'm not trying saying it'd be more common than u32
though.)

> > +               DMA_BIT_MASK(IPU3_MMU_ADDRESS_BITS);
> > +       mmu_dom->domain.geometry.force_aperture = true;
> > +
> > +       ptr = (void *)__get_free_page(GFP_KERNEL);
> > +       if (!ptr)
> > +               goto fail_get_page;
> > +       mmu_dom->dummy_page = virt_to_phys(ptr) >> IPU3_MMU_PAGE_SHIFT;
> 
> Is virt_to_phys() correct here? I'm not an expert on x86 systems, but
> since this is a PCI device, there might be some other memory mapping
> involved.

In theory yes --- if the IPU3 were behind an IOMMU managed by the Linux
kernel. That kind of configuration wouldn't make much sense and any
attempt to use such a configuration would probably fall apart with
the assumption of single dma_ops, too.

I have to say I'm not certain if anything else than kernel configuration
would prevent this though.

-- 
Regards,

Sakari Ailus
sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
