From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Mon, 14 Jul 2014 11:08:13 +0100
Message-ID: <20140714100813.GC1779@arm.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140712093917.GD18601@arm.com>
	<CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
	<201407121422.02078.arnd@arndb.de>
	<CAF6AEGs7=3UByP2DLm-uwU03wr7M14x2t-0hLX-VPJ6_eZbU3g@mail.gmail.com>
	<20140713094341.GB23235@arm.com> <20140714064452.GD2081@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140714064452.GD2081@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

On Mon, Jul 14, 2014 at 07:44:53AM +0100, Thierry Reding wrote:
> On Sun, Jul 13, 2014 at 10:43:41AM +0100, Will Deacon wrote:
> > My plan for the ARM SMMU driver is:
> > 
> >   (1) Change ->probe() to walk the device-tree looking for all masters with
> >       phandles back to the SMMU instance being probed
> 
> You and Rob mentioned this several times and I don't understand why the
> SMMU needs to know all masters up front. Is this necessary because it
> needs to program all registers at .probe() time and they can't be
> reprogrammed subsequently? Or is this just some kind of optimization?

It's an optimization to reduce resource usage in the IOMMU, but one that
is *required* by certain platforms (e.g. Olav mentioned his 43-ID master
and Calxeda had something similar).

Basically, in order to perform an ->attach() for a master to a domain, we
need complete knowledge of the system so that we can avoid accidentally
attaching other masters to the same domain. The programming is done using
a form of StreamID wildcarding, so at this point we would need to have
parsed the entire DT to ensure our wildcard doesn't match other masters.

> >   (2) For each master, extract the Stream IDs and add them to the internal
> >       SMMU driver data structures (an rbtree per SMMU instance). For
> >       hotpluggable buses, we'll need a way for the bus controller to
> >       reserve a range of IDs -- this will likely be a later extension to
> >       the binding.
> > 
> >   (3) When we get an ->add() call, warn if it's a device we haven't seen
> >       and reject the addition.
> 
> It seems to me like this would be the logical place to parse stream IDs.

We could do that only if we were guaranteed to have an ->add() call for
*every* master before an ->attach() call for *any* master. I don't think
that is necessarily true.

> You could for example have a case where some device tree contains a node
> for which no driver will ever be loaded (for example because it hasn't
> been built-in, or the device is never used and the module is therefore
> never loaded). That's a situation that you cannot determine by simply
> walking the device tree in the IOMMU's .probe().

Why not? If we're simply searching for phandles to the IOMMU, why does it
matter whether a driver is bound to the master?

> I've always thought about IOMMU masters much in the same way as other
> types of resources, such as memory or interrupts. In the rest of the
> kernel we do carefully try to postpone allocation of these resources
> until they are required, specifically so we don't waste resources when
> they're unused.

See above, they are all required the moment anybody tries an ->attach().

> That's also one of the reasons why I think associating an IOMMU with the
> bus type is bad. Currently if an IOMMU driver thinks it should enable
> translation for a given device, then there's no way for that device's
> driver to opt out again. There may be reasons (performance, hardware
> bugs, ...) for the driver to decide against using the IOMMU for
> translation, but there's currently no way to do that if the IOMMU driver
> disagrees.

Yes, we need a way to associate an IOMMU with a bus instance, but I think
that's a separate topic, no?

Will
