From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/5] iommu/arm-smmu: add support for PCI master devices
Date: Fri, 4 Jul 2014 07:41:53 +0000
Message-ID: <3b9f2103f5c44958a74f1e594a58d58a@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
	<1404125530-17984-3-git-send-email-will.deacon@arm.com>
	<a9de518782874b5c8ddd366e6617b8de@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140703144341.GC14305@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140703144341.GC14305-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, July 03, 2014 8:14 PM
> To: Sethi Varun-B16395
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org;
> ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; Marc Zyngier
> Subject: Re: [PATCH 2/5] iommu/arm-smmu: add support for PCI master
> devices
> 
> On Thu, Jul 03, 2014 at 03:22:37PM +0100, Varun Sethi wrote:
> > Hi Will,
> 
> Hi Varun,
> 
> Thanks for taking a look at this!
> 
> > > +static struct arm_smmu_master_cfg * find_smmu_master_cfg(struct
> > > +arm_smmu_device *smmu, struct device *dev) {
> > > +     struct arm_smmu_master *master;
> > > +
> > > +     if (dev_is_pci(dev))
> > > +             return dev->archdata.iommu;
> > > +
> > > +     master = find_smmu_master(smmu,
> > > + dev_get_master_dev(dev)->of_node);
> > [Sethi Varun-B16395] Why use dev_get_master_dev over here? You can
> simply use dev.
> 
> True; we've already done the PCI check above. I'll tidy this up.
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
> That function doesn't seem to appear in mainline or next. I can move to
> it when it's available, but in the meantime the above is working for me.
> I'm making the assumption here that the system is configured so that
> there aren't any duplicate stream IDs. What we actually need is a
> function here which maps the requester ID to a stream ID using firmware
> tables (provided by DT or ACPI). In the absence of those tables at the
> moment, I just assign the ID directly, which happens to work on my
> platform (1:1 mapping).
> 
> Once Thierry's generic IOMMU binding is sorted, we should look at adding
> support for the Stream ID description. Have you looked at that at all?
> 
Yes, I have looked at the bindings. Would we need to represent the stream ids for PCI devices in the device tree? Why do we want to depend on the firmware to map the requestor id to the stream id? It can be handled using the APIs proposed by Alex Williamson. This is similar to IOMMU group determination, which is handled by the IOMMU driver.

> Will
> 
> BTW: You seem to have a rather strange quoting style on your replies. Is
> there any way to configure your editor to limit your lines to 80 columns?
> You also don't need the prefix with your name and number in brackets!


Will try to sort out issues with my e-mail client.

-Varun
