From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/arm-smmu: add support for PCI master devices
Date: Thu, 3 Jul 2014 15:43:41 +0100
Message-ID: <20140703144341.GC14305@arm.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
	<1404125530-17984-3-git-send-email-will.deacon@arm.com>
	<a9de518782874b5c8ddd366e6617b8de@BL2PR03MB468.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a9de518782874b5c8ddd366e6617b8de-AZ66ij2kwaacCcN9WK45f+O6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 03, 2014 at 03:22:37PM +0100, Varun Sethi wrote:
> Hi Will,

Hi Varun,

Thanks for taking a look at this!

> > +static struct arm_smmu_master_cfg *
> > +find_smmu_master_cfg(struct arm_smmu_device *smmu, struct device *dev)
> > +{
> > +     struct arm_smmu_master *master;
> > +
> > +     if (dev_is_pci(dev))
> > +             return dev->archdata.iommu;
> > +
> > +     master = find_smmu_master(smmu, dev_get_master_dev(dev)->of_node);
> [Sethi Varun-B16395] Why use dev_get_master_dev over here? You can simply use dev.

True; we've already done the PCI check above. I'll tidy this up.

> > @@ -1598,15 +1642,36 @@ static int arm_smmu_add_device(struct device
> > *dev)
> >               return PTR_ERR(group);
> >       }
> >
> > +     if (dev_is_pci(dev)) {
> > +             struct arm_smmu_master_cfg *cfg;
> > +             struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +             cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> > +             if (!cfg) {
> > +                     ret = -ENOMEM;
> > +                     goto out_put_group;
> > +             }
> > +
> > +             cfg->num_streamids = 1;
> > +             pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid,
> > +                                    &cfg->streamids[0]);
> [Sethi Varun-B16395] We need to look for upstream DMA device. We should be
> using pci_find_dma_isolation_root here. Also, this would also imply that
> there could be multiple devices sharing the same stream ID. So, we should
> check if a particular stream ID value has already been configured in the
> SMR registers.

That function doesn't seem to appear in mainline or next. I can move to it
when it's available, but in the meantime the above is working for me. I'm
making the assumption here that the system is configured so that there
aren't any duplicate stream IDs. What we actually need is a function here
which maps the requester ID to a stream ID using firmware tables (provided
by DT or ACPI). In the absence of those tables at the moment, I just assign
the ID directly, which happens to work on my platform (1:1 mapping).

Once Thierry's generic IOMMU binding is sorted, we should look at adding
support for the Stream ID description. Have you looked at that at all?

Will

BTW: You seem to have a rather strange quoting style on your replies. Is
there any way to configure your editor to limit your lines to 80 columns?
You also don't need the prefix with your name and number in brackets!
