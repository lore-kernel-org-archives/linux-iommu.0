From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
Date: Tue, 26 Mar 2019 13:31:23 +0100
Message-ID: <CAMuHMdUTkPoCoL7jRz2MRRSjLVSrzE4kPx2uMKCKMGfmVayT6A@mail.gmail.com>
References: <20190207193653.18221-1-geert+renesas@glider.be> <9966a420-b081-a8ed-7f7b-20d97c9f7996@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9966a420-b081-a8ed-7f7b-20d97c9f7996@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, chenxiang <chenxiang66@hisilicon.com>, Xiaofei Tan <tanxiaofei@huawei.com>, Rob Herring <robh@kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi John,

CC robh

On Tue, Mar 26, 2019 at 12:42 PM John Garry <john.garry@huawei.com> wrote:
> > Memory is incorrectly freed using the direct ops, as dma_map_ops = NULL.
> > Oops...
> >
> > After reversing the order of the calls to arch_teardown_dma_ops() and
> > devres_release_all(), dma_map_ops is still valid, and the DMA memory is
> > now released using __iommu_free_attrs():
> >
> >     +sata_rcar ee300000.sata: dmam_release:32: size 2048 vaddr ffffff8012145000 dma_handle 0x0x00000000fffff000 attrs 0x0
> >     +sata_rcar ee300000.sata: dma_free_attrs:289: size 2048, ops = iommu_dma_ops
> >     +sata_rcar ee300000.sata: dma_free_attrs:311: calling __iommu_free_attrs()
> > ---
> >  drivers/base/dd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 8ac10af17c0043a3..d62487d024559620 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
> >                       drv->remove(dev);
> >
> >               device_links_driver_cleanup(dev);
> > -             arch_teardown_dma_ops(dev);
> >
> >               devres_release_all(dev);
> > +             arch_teardown_dma_ops(dev);
> >               dev->driver = NULL;
>
> Hi guys,
>
> Could there still be the same problem in the error path of really_probe():
>
> static int really_probe(struct device *dev, struct device_driver *drv)
> {
>
>         [...]
>
>         goto done;
>
> probe_failed:
>         arch_teardown_dma_ops(dev);
> dma_failed:
>         if (dev->bus)
>                 blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>                                      BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
> pinctrl_bind_failed:
>         device_links_no_driver(dev);
>         devres_release_all(dev);
>         driver_sysfs_remove(dev);
>         dev->driver = NULL;
>         dev_set_drvdata(dev, NULL);
>
> We seem to be able to call arch_teardown_dma_ops() prior to
> devres_release_all() if we reach probe_failed label.

Yes, this looks like another instance of the same problem.
And test_remove doesn't expose this, as it doesn't exercise the full cycle.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
