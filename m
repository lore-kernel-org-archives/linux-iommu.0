From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 10 Jul 2014 11:23:34 +0100
Message-ID: <20140710102334.GG2449@arm.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140709134050.GN9485@arm.com>
 <20140709142125.GB3262@ulmo>
 <20140709181048.GX9485@arm.com>
 <20140710094909.GA21583@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140710094909.GA21583@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TZNg+MwTxZMZA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 10, 2014 at 10:49:10AM +0100, Thierry Reding wrote:
> On Wed, Jul 09, 2014 at 07:10:48PM +0100, Will Deacon wrote:
> > On Wed, Jul 09, 2014 at 03:21:27PM +0100, Thierry Reding wrote:
> > > Anything beyond that (e.g. logical grouping of masters) isn't directly
> > > within the scope of the binding (it doesn't describe hardware but some
> > > policy pertaining to some specific use-case).
> > 
> > This *is* for hardware. I can use PCI as an example, but this could equally
> > apply to other types of bus. If you have a bunch of PCI master devices
> > sitting being a non-transparent bridge, they can end up sharing the same
> > master device ID (requester ID). This means that there is no way in the
> > IOMMU to initialise a translation for one of these devices without also
> > affecting the others. We currently have iommu_groups to deal with this, but
> > it *is* a property of the hardware and we absolutely need a way to describe
> > it. I'm happy to add it later, but we need to think about it now to avoid
> > merging something that can't easily be extended.
> > 
> > For PCI, the topology is probable but even then, we need this information to
> > describe the resulting master device ID emitted by the bridge for the
> > upstream group. One way to do this with your binding would be to treat all
> > of the upstream masters as having the same device ID.
> 
> Yes, I think that makes most sense. After all from the IOMMU's point of
> view requests from all devices behind the bridge will originate from the
> same ID.
> 
> So technically it's not really correct to encode the master ID within
> each of the devices, but rather they should be inheriting the ID from
> the non-transparent bridge.

Indeed. Is that possible with your binding, or would we just duplicate the
IDs between the masters?

> > With virtualisation, we may want to assign a group of devices to a guest but
> > without emulating the bridge. This would need something the device-tree to
> > describe that they are grouped together.
> 
> But that's also a software decision, isn't it? Virtualization doesn't
> have anything to do with the hardware description. Or am I missing
> something? Of course I guess you could generate a DTB for the guest and
> group device together, in which case you're pretty much free to do what
> you want since you're essentially defining your own hardware.

If you're doing device passthrough and you want to allow the guest to
program the IOMMU, I think that virtualisation is directly related to the
hardware description, since the guest will be bound by physical properties
of the system.

Will
