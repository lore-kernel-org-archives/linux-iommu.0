From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Tue, 02 Sep 2014 16:01:32 +0200
Message-ID: <5897964.3ztXLVfPDF@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<3424322.yoZKhlAsy0@wuerfel> <20140902130508.GK25379@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140902130508.GK25379-5wv7dgnIgG8@public.gmane.org>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 02 September 2014 14:05:08 Will Deacon wrote:
> On Tue, Sep 02, 2014 at 01:15:06PM +0100, Arnd Bergmann wrote:

> > > Anyway, I'll try to hack something together shortly. I think the proposal
> > > is:
> > > 
> > >   - Make add_device_master_ids take a generic structure (struct iommu)
> > >   - Add an of_xlate callback into iommu_ops which returns a populated
> > >     struct iommu based on the of_node
> > 
> > We may have been talking past one another. What I meant with 'struct iommu'
> > is something that identifies the iommu instance, not the connection to
> > a particular master. What you describe here would work, but then I think
> > the structure should have a different name. However, it seems easier to
> > not have the add_device_master_ids at and just do the association in the
> > xlate callback instead.
> 
> Yes, I think we were talking about two different things. If we move all
> of the master handling into the xlate callback, then we can just use
> of_phandle_args as the generic master representation (using the PCI host
> controller node for PCI devices, as you mentioned). However, xlate is a
> bit of a misnomer then, as it's not actually translating anything; the
> handle used for DMA masters is still struct device, and we have that
> already in of_dma_configure.
> 
> I'm still unsure about what to put inside struct iommu other than a private
> data pointer. You previously suggested:
> 
> 	struct iommu {
> 		struct device *dev;
> 		const struct iommu_ops *ops;
> 		struct list_head domains;
> 		void *private;
> 	};
> 
> but that has the following problems:
> 
>   - We don't have a struct device * for the IOMMU until it's been probed
>     via the standard driver probing mechanisms, which may well be after
>     we've started registering masters

Right, this may have to be the device_node pointer. I also realized that if
we have this structure, we can stop using the device_node->data field
and instead walk a list of iommu structures.

>   - The ops are still registered on a per-bus basis, and each domain has
>     a pointer to them anyway

I think that has to change in the long run: we may well require distinct
IOMMU operations if we have multiple IOMMUs used on the same bus_type.
 
>   - The IOMMU driver really doesn't care about the domains, as the domain
>     in question is always passed back to the functions that need it (e.g.
>     attach, map, ...).

This is an artifact of the API being single-instance at the moment.
We might not in fact need it, I was just trying to think of things
that naturally fit in there and that are probably already linked
together in the individual iommu drivers.

> The only useful field I can think of is something like a tree of masters,
> but then we have to define a generic wrapper around struct device, which
> is at odds with the rest of the IOMMU API.

Maybe a list of the groups instead? I don't think you should need
a list of every single master here.

> One alternative is having the xlate call populate device->archdata.iommu,
> but that's arch-specific and is essentially another opaque pointer.

I think every architecture that supports IOMMUs needs to have this
archdata pointer though, so that is still a good place to put private
stuff.

	Arnd
