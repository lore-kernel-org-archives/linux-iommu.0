From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] amd_iommu: Split IOMMU group initialization
Date: Tue, 09 Oct 2012 08:41:38 -0600
Message-ID: <1349793698.2759.287.camel@ul30vt.home>
References: <20121009044057.16302.44577.stgit@bling.home>
	<20121009044935.16302.93049.stgit@bling.home>
	<CAKocOOOTp7BMbqFyZx=rH-2uOC51C17JTjP77w7=7KB8jKh=hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAKocOOOTp7BMbqFyZx=rH-2uOC51C17JTjP77w7=7KB8jKh=hA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2012-10-09 at 08:33 -0600, Shuah Khan wrote:
> Alex,
> 
> couple of comments in-lined:
> 
> On Mon, Oct 8, 2012 at 10:49 PM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > This needs to be broken apart, start with pulling all the IOMMU
> > group init code into a new function.
> >
> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >
> >  drivers/iommu/amd_iommu.c |   61 ++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 43 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index 55074cb..b65b377 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -276,39 +276,32 @@ static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
> >
> >  #define REQ_ACS_FLAGS  (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
> >
> > -static int iommu_init_device(struct device *dev)
> > +static int init_iommu_group(struct device *dev)
> >  {
> > -       struct pci_dev *dma_pdev = NULL, *pdev = to_pci_dev(dev);
> >         struct iommu_dev_data *dev_data;
> >         struct iommu_group *group;
> > -       u16 alias;
> > +       struct pci_dev *dma_pdev = NULL;
> >         int ret;
> 
> I don't see ret get initialized

It looks that way, but...

> >
> > -       if (dev->archdata.iommu)
> > +       group = iommu_group_get(dev);
> > +       if (group) {
> > +               iommu_group_put(group);
> >                 return 0;
> > +       }
> >
> >         dev_data = find_dev_data(get_device_id(dev));
> >         if (!dev_data)
> >                 return -ENOMEM;
> >
> > -       alias = amd_iommu_alias_table[dev_data->devid];
> > -       if (alias != dev_data->devid) {
> > -               struct iommu_dev_data *alias_data;
> > -
> > -               alias_data = find_dev_data(alias);
> > -               if (alias_data == NULL) {
> > -                       pr_err("AMD-Vi: Warning: Unhandled device %s\n",
> > -                                       dev_name(dev));
> > -                       free_dev_data(dev_data);
> > -                       return -ENOTSUPP;
> > -               }
> > -               dev_data->alias_data = alias_data;
> > +       if (dev_data->alias_data) {
> > +               u16 alias;
> >
> > +               alias = amd_iommu_alias_table[dev_data->devid];
> >                 dma_pdev = pci_get_bus_and_slot(alias >> 8, alias & 0xff);
> >         }
> >
> > -       if (dma_pdev == NULL)
> > -               dma_pdev = pci_dev_get(pdev);
> > +       if (!dma_pdev)
> > +               dma_pdev = pci_dev_get(to_pci_dev(dev));
> >
> >         /* Account for quirked devices */
> >         swap_pci_ref(&dma_pdev, pci_get_dma_source(dma_pdev));
> > @@ -358,6 +351,38 @@ root_bus:
> >
> >         iommu_group_put(group);
> >
> > +       return ret;
> 
> Do you even need ret - can this be simply return 0;

If you apply the patch, you'll see the end of this function is:

        ret = iommu_group_add_device(group, dev);

        iommu_group_put(group);

        return ret;
}

It's unfortunate that diff didn't make this easier to review.  Thanks,

Alex

> > +}
> > +
> > +static int iommu_init_device(struct device *dev)
> > +{
> > +       struct pci_dev *pdev = to_pci_dev(dev);
> > +       struct iommu_dev_data *dev_data;
> > +       u16 alias;
> > +       int ret;
> > +
> > +       if (dev->archdata.iommu)
> > +               return 0;
> > +
> > +       dev_data = find_dev_data(get_device_id(dev));
> > +       if (!dev_data)
> > +               return -ENOMEM;
> > +
> > +       alias = amd_iommu_alias_table[dev_data->devid];
> > +       if (alias != dev_data->devid) {
> > +               struct iommu_dev_data *alias_data;
> > +
> > +               alias_data = find_dev_data(alias);
> > +               if (alias_data == NULL) {
> > +                       pr_err("AMD-Vi: Warning: Unhandled device %s\n",
> > +                                       dev_name(dev));
> > +                       free_dev_data(dev_data);
> > +                       return -ENOTSUPP;
> > +               }
> > +               dev_data->alias_data = alias_data;
> > +       }
> > +
> > +       ret = init_iommu_group(dev);
> >         if (ret)
> >                 return ret;
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
