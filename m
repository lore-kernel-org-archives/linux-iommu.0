From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 9 Jul 2014 19:10:48 +0100
Message-ID: <20140709181048.GX9485@arm.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140709134050.GN9485@arm.com>
 <20140709142125.GB3262@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140709142125.GB3262@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TZNg+MwTxZMZA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

On Wed, Jul 09, 2014 at 03:21:27PM +0100, Thierry Reding wrote:
> On Wed, Jul 09, 2014 at 02:40:50PM +0100, Will Deacon wrote:
> > I would like to move the ARM SMMU driver over to this for 3.18, if possible.
> > One use-case there is the ability to describe groups of masters behind a
> > multi-master IOMMU but which must be part of the same domain (i.e. an
> > iommu_group). This is useful for presenting devices to a guest with a
> > virtual SMMU, where the physical devices share a stage-2 context.
> > 
> > With your binding, does this simply mean determining the set of master IDs
> > in the group, then describing the complete set for each master?
> 
> I'm not sure I properly understand what you're trying to do, but I don't
> think the binding is designed to cover that. Rather the goal was to
> describe the IDs belonging to each master, so that an IOMMU can be
> properly configured.

This is directly related to that problem, see below.

> Anything beyond that (e.g. logical grouping of masters) isn't directly
> within the scope of the binding (it doesn't describe hardware but some
> policy pertaining to some specific use-case).

This *is* for hardware. I can use PCI as an example, but this could equally
apply to other types of bus. If you have a bunch of PCI master devices
sitting being a non-transparent bridge, they can end up sharing the same
master device ID (requester ID). This means that there is no way in the
IOMMU to initialise a translation for one of these devices without also
affecting the others. We currently have iommu_groups to deal with this, but
it *is* a property of the hardware and we absolutely need a way to describe
it. I'm happy to add it later, but we need to think about it now to avoid
merging something that can't easily be extended.

For PCI, the topology is probable but even then, we need this information to
describe the resulting master device ID emitted by the bridge for the
upstream group. One way to do this with your binding would be to treat all
of the upstream masters as having the same device ID.

With virtualisation, we may want to assign a group of devices to a guest but
without emulating the bridge. This would need something the device-tree to
describe that they are grouped together.

> That said, the IOMMU driver that I prototyped for Tegra did some similar
> grouping of devices, although in a much more restricted way. The goal of
> that was to add a known set of devices into one group, "peripherals", so
> that they could share one IOMMU domain. This was meant to separate them
> from devices with more advanced needs (such as a GPU driver). Devices in
> the "peripherals" group would be using the DMA mapping API integration
> whereas other devices would have to explicitly allocate an IOMMU domain.
> 
> I'm not sure how much that helps for the use-case that you have in mind.

That sounds more like a software decision, which I agree doesn't need to be
described.

Will
