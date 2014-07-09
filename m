From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/5] iommu/arm-smmu: add support for PCI master devices
Date: Wed, 9 Jul 2014 14:21:07 +0000
Message-ID: <3b971792af184640a1d2ff8c5b57e66d@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
	<1404125530-17984-3-git-send-email-will.deacon@arm.com>
	<a9de518782874b5c8ddd366e6617b8de@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140709132653.GM9485@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140709132653.GM9485-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: Wednesday, July 09, 2014 6:57 PM
> To: Sethi Varun-B16395; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org;
> ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; Marc Zyngier
> Subject: Re: [PATCH 2/5] iommu/arm-smmu: add support for PCI master
> devices
> 
> [Adding Alex; question below]
> 
> On Thu, Jul 03, 2014 at 03:22:37PM +0100, Varun Sethi wrote:
> > > +static int __arm_smmu_get_pci_sid(struct pci_dev *pdev, u16 alias,
> > > +void
> > > +*data) {
> > > +     *((u16 *)data) = alias;
> > > +     return 0; /* Continue walking */ }
> 
> [...]
> 
> > > @@ -1598,15 +1642,36 @@ static int arm_smmu_add_device(struct device
> > > *dev)
> > >               return PTR_ERR(group);
> > >       }
> > >
> > > +     if (dev_is_pci(dev)) {
> > > +             struct arm_smmu_master_cfg *cfg;
> > > +             struct pci_dev *pdev = to_pci_dev(dev);
> > > +
> > > +             cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> > > +             if (!cfg) {
> > > +                     ret = -ENOMEM;
> > > +                     goto out_put_group;
> > > +             }
> > > +
> > > +             cfg->num_streamids = 1;
> > > +             pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid,
> > > +                                    &cfg->streamids[0]);
> > [Sethi Varun-B16395] We need to look for upstream DMA device. We
> > should be using pci_find_dma_isolation_root here. Also, this would
> > also imply that there could be multiple devices sharing the same
> > stream ID. So, we should check if a particular stream ID value has
> > already been configured in the SMR registers.
> 
> pci_find_dma_isolation_root doesn't exist in any of the trees I have.
> Alex, is this queued anywhere and do I actually need it?
> 
> The purpose of this code is to find the requester ID of a device as it
> appears at the host controller. At this point, we can map it (via
> firmware tables that are TBD) to a Stream ID for the SMMU. It looks to me
> like pci_for_each_dma_alias walks over non-transparent PCI bridges
> correctly, so the callback I provide just updates the alias until the
> walk has completed.
I think pci_for_each_dma_alias should work fine here. Isolation would be specifically required while setting up the iommu groups.

-Varun
