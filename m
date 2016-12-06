From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] ACPI/IORT: Make dma masks set-up IORT specific
Date: Tue, 6 Dec 2016 09:37:10 +0000
Message-ID: <20161206093710.GA4432@red-moon>
References: <20161205122619.25045-1-lorenzo.pieralisi@arm.com>
	<CAJZ5v0hbc61=QCYDgHZ_KbxR7VkSSWrHVGvU47fG6hsQrSJKhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hbc61=QCYDgHZ_KbxR7VkSSWrHVGvU47fG6hsQrSJKhw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Mon, Dec 05, 2016 at 11:18:56PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 5, 2016 at 1:26 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> wrote:
> > The introduction of acpi_dma_configure() allows to configure DMA
> > and related IOMMU for any device that is DMA capable. To achieve
> > that goal it ensures DMA masks are set-up to sane default values
> > before proceeding with IOMMU and DMA ops configuration.
> >
> > On x86/ia64 systems, through acpi_bind_one(), acpi_dma_configure() is
> > called for every device that has an ACPI companion, in that every device
> > is considered DMA capable on x86/ia64 systems (ie acpi_get_dma_attr() API),
> > which has the side effect of initializing dma masks also for
> > pseudo-devices (eg CPUs and memory nodes) and potentially for devices
> > whose dma masks were not set-up before the acpi_dma_configure() API was
> > introduced, which may have noxious side effects.
> >
> > Therefore, in preparation for IORT firmware specific DMA masks set-up,
> > wrap the default DMA masks set-up in acpi_dma_configure() inside an IORT
> > specific wrapper that reverts to a NOP on x86/ia64 systems, restoring the
> > default expected behaviour on x86/ia64 systems and keeping DMA default
> > masks set-up on IORT based (ie ARM) arch configurations.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> > Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> > Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > Cc: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> > Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> > Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> > Cc: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> Acked -by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> > ---
> > Joerg,
> >
> > pending Rafael's ACK on it, given the 4.10 release timing and that the
> > series is queued via the IOMMU tree please consider applying this patch to
> > your arm/smmu branch for 4.10, it is not fixing a bug but it is modifying
> > the x86/ia64 code path; I prefer preventing any issue related to default
> > dma masks on x86/ia64 so I hope it can get merged along with the rest of
> > the ACPI IORT SMMU series.

I can apply Rafael and Hanjun's tags and resend a v2 to you if you
prefer, it would be great if you could apply this patch to your arm/smmu
branch for v4.10 as per description above, please let me know.

Thank you !
Lorenzo

> >
> > Thanks a lot and apologies,
> > Lorenzo
> >
> >  drivers/acpi/arm64/iort.c | 22 ++++++++++++++++++++++
> >  drivers/acpi/scan.c       | 14 +-------------
> >  include/linux/acpi_iort.h |  2 ++
> >  3 files changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 47bace8..e0d2e6e 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -547,6 +547,28 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
> >  }
> >
> >  /**
> > + * iort_set_dma_mask - Set-up dma mask for a device.
> > + *
> > + * @dev: device to configure
> > + */
> > +void iort_set_dma_mask(struct device *dev)
> > +{
> > +       /*
> > +        * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> > +        * setup the correct supported mask.
> > +        */
> > +       if (!dev->coherent_dma_mask)
> > +               dev->coherent_dma_mask = DMA_BIT_MASK(32);
> > +
> > +       /*
> > +        * Set it to coherent_dma_mask by default if the architecture
> > +        * code has not set it.
> > +        */
> > +       if (!dev->dma_mask)
> > +               dev->dma_mask = &dev->coherent_dma_mask;
> > +}
> > +
> > +/**
> >   * iort_iommu_configure - Set-up IOMMU configuration for a device.
> >   *
> >   * @dev: device to configure
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 80698d3..93b00cf 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1380,19 +1380,7 @@ void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
> >  {
> >         const struct iommu_ops *iommu;
> >
> > -       /*
> > -        * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> > -        * setup the correct supported mask.
> > -        */
> > -       if (!dev->coherent_dma_mask)
> > -               dev->coherent_dma_mask = DMA_BIT_MASK(32);
> > -
> > -       /*
> > -        * Set it to coherent_dma_mask by default if the architecture
> > -        * code has not set it.
> > -        */
> > -       if (!dev->dma_mask)
> > -               dev->dma_mask = &dev->coherent_dma_mask;
> > +       iort_set_dma_mask(dev);
> >
> >         iommu = iort_iommu_configure(dev);
> >
> > diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> > index dcb2b60..77e0809 100644
> > --- a/include/linux/acpi_iort.h
> > +++ b/include/linux/acpi_iort.h
> > @@ -35,6 +35,7 @@ bool iort_node_match(u8 type);
> >  u32 iort_msi_map_rid(struct device *dev, u32 req_id);
> >  struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
> >  /* IOMMU interface */
> > +void iort_set_dma_mask(struct device *dev);
> >  const struct iommu_ops *iort_iommu_configure(struct device *dev);
> >  #else
> >  static inline void acpi_iort_init(void) { }
> > @@ -45,6 +46,7 @@ static inline struct irq_domain *iort_get_device_domain(struct device *dev,
> >                                                         u32 req_id)
> >  { return NULL; }
> >  /* IOMMU interface */
> > +static inline void iort_set_dma_mask(struct device *dev) { }
> >  static inline
> >  const struct iommu_ops *iort_iommu_configure(struct device *dev)
> >  { return NULL; }
> > --
> > 2.10.0
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
