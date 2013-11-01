From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 1 Nov 2013 10:59:19 +0100
Message-ID: <20131101.115919.351108054879013006.hdoyu@nvidia.com>
References: <20131031.184603.979300613649357798.hdoyu@nvidia.com><52729912.9050800@wwwdotorg.org><20131101094644.GG27864@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131101094644.GG27864-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Fri, 1 Nov 2013 10:46:45 +0100:

> * PGP Signed by an unknown key
> 
> On Thu, Oct 31, 2013 at 11:53:22AM -0600, Stephen Warren wrote:
> > On 10/31/2013 10:46 AM, Hiroshi Doyu wrote:
> > > Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Thu, 31 Oct 2013 17:35:24 +0100:
> > > 
> > > ...
> > >>>> ... and for the driver to explicitly parse that property, and wait
> > >>>> until the driver for iommu_phandle is ready. Exactly the same as any
> > >>>> other resource/service dependency.
> > >>>>
> > >>>> That will solve all the problems.
> > >>>>
> > >>>> The only downside is that every driver needs to contain code to parse
> > >>>> that property. However, I think that's just one function call; the
> > >>>> actual implementation of that function can be unified somewhere inside
> > >>>> core code in drivers/iommu/.
> > >>>
> > >>> Yes, but only missing part now is that, we could do this with
> > >>> "bus_notifier", but the current bus_notifier doesn't have the feature
> > >>> to return error(-EPROBE_DEFER). This could be modified so that
> > >>> bus_notifier could return (-EPROBE_DEFER) to postpone
> > >>> probing. Alternatively this could be done in some core probe code as
> > >>> well as Thierry pointed out.
> > >>>
> > >>> [1] In the reply of "[PATCHv3 14/19] iommu/tegra: smmu: Get "nvidia,memory-clients" from DT"
> > >>
> > >> I think this should be done explicitly in drivers. It's much
> > >> simpler,
> > > 
> > > Yes, we need to insert some IOMMU specific code in driver?
> > > 
> > >> and doesn't encode any knowledge of driver-specific bindings into some
> > >> common bus notifier code.
> > > 
> > > I think that we cannot do that in drivers. We want to use drivers as
> > > they are without any modifications indicating its dependency on
> > > IOMMU because most of drivers are existing ones which nvidia doesn't
> > > implement. We want to set up any IOMMU related thingy implicitly,
> > > hided from driver. That's why we need to do this in bus_notifier or
> > > driver core code.
> > 
> > We're talking about memory-mapped on-SoC devices here, that generally
> > only exist inside Tegra SoCs.
> > 
> > Even ignoring that (i.e. expanding the argument to arbitrary modules),
> > having drivers that perform bus-master transactions call a function
> > of_iommu_attach() or similar, which does nothing if the device isn't
> > behind an IOMMU but otherwise does whatever is required, seems like it
> > isn't much of an imposition.
> > 
> > If this turns out to be something that lots of devices benefit from, we
> > could do the same thing that pinctrl does for "hogs", and make the
> > function call in the driver core. But note that's still part of the
> > probing flow (just implemented in the driver core) rather than bus
> > notifier based, hence keeps the same simplicity.
> 
> That's exactly what I was proposing in the first place. I did the same
> thing in my patches for late interrupt reference resolution. The reason
> why I think it makes sense to put it into the core is that it's
> something that likely most devices will have to do anyway. And it also
> is completely transparent to drivers, right? If they aren't attached to
> an IOMMU then they just aren't but will continue to work properly. And
> as you said, having it in the core makes drivers simpler, while at the
> same time keeping the explicitness of having a function call (rather
> than a somewhat obfuscated bus notifier) and the flexibility of deferred
> probing.

One idea is that, rather than inserting a hook(function) per
subsystems in driver core, if we invent a new /special section/ which
collects all hooks in sequence like initcalls, the subsystem just
would declare a hook function for that special section. All hooks in
that section can be called from driver core iterately. Then we
wouldn't touch driver core code at all, once we insert a func to call
hooks repeatedly. Looks simpler than tweaking bus notifier.
