From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Tue, 2 Sep 2014 14:05:08 +0100
Message-ID: <20140902130508.GK25379@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<4335091.FB685Z52eG@wuerfel> <20140902100342.GG25379@arm.com>
	<3424322.yoZKhlAsy0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3424322.yoZKhlAsy0@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 02, 2014 at 01:15:06PM +0100, Arnd Bergmann wrote:
> On Tuesday 02 September 2014 11:03:42 Will Deacon wrote:
> > On Mon, Sep 01, 2014 at 09:18:26PM +0100, Arnd Bergmann wrote:
> > > I don't mind handling PCI devices separately. They are different in a number
> > > of ways already, in particular the way that they don't normally have an
> > > of_node attached to them but actually have a PCI bus/dev/function number.
> > 
> > Sure, but at the point when we call back into the iommu_ops structure we
> > really don't want bus specific functions. That's why I avoided any OF
> > data structures being passed to add_device_master_ids.
> 
> Well, we clearly need some format that the caller and the callee agree
> on. It can't be a completely opaque pointer because it's something
> that has to be filled out by someone who knows the format.
> 
> Using the DT format has the advantage that the caller does not have
> to know anything about the underlying driver except for #size-cells,
> and it just passes the data it gets from DT into the driver. This is
> how we do the association in a lot of other subsystems.

Ok. More below.

> > Anyway, I'll try to hack something together shortly. I think the proposal
> > is:
> > 
> >   - Make add_device_master_ids take a generic structure (struct iommu)
> >   - Add an of_xlate callback into iommu_ops which returns a populated
> >     struct iommu based on the of_node
> 
> We may have been talking past one another. What I meant with 'struct iommu'
> is something that identifies the iommu instance, not the connection to
> a particular master. What you describe here would work, but then I think
> the structure should have a different name. However, it seems easier to
> not have the add_device_master_ids at and just do the association in the
> xlate callback instead.

Yes, I think we were talking about two different things. If we move all
of the master handling into the xlate callback, then we can just use
of_phandle_args as the generic master representation (using the PCI host
controller node for PCI devices, as you mentioned). However, xlate is a
bit of a misnomer then, as it's not actually translating anything; the
handle used for DMA masters is still struct device, and we have that
already in of_dma_configure.

I'm still unsure about what to put inside struct iommu other than a private
data pointer. You previously suggested:

	struct iommu {
		struct device *dev;
		const struct iommu_ops *ops;
		struct list_head domains;
		void *private;
	};

but that has the following problems:

  - We don't have a struct device * for the IOMMU until it's been probed
    via the standard driver probing mechanisms, which may well be after
    we've started registering masters

  - The ops are still registered on a per-bus basis, and each domain has
    a pointer to them anyway

  - The IOMMU driver really doesn't care about the domains, as the domain
    in question is always passed back to the functions that need it (e.g.
    attach, map, ...).

The only useful field I can think of is something like a tree of masters,
but then we have to define a generic wrapper around struct device, which
is at odds with the rest of the IOMMU API.

One alternative is having the xlate call populate device->archdata.iommu,
but that's arch-specific and is essentially another opaque pointer.

Will
