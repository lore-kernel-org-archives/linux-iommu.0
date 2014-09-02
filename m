From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Tue, 02 Sep 2014 14:15:06 +0200
Message-ID: <3424322.yoZKhlAsy0@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<4335091.FB685Z52eG@wuerfel> <20140902100342.GG25379@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140902100342.GG25379-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 02 September 2014 11:03:42 Will Deacon wrote:
> On Mon, Sep 01, 2014 at 09:18:26PM +0100, Arnd Bergmann wrote:
> > On Monday 01 September 2014 17:40:00 Will Deacon wrote:
> > > On Mon, Sep 01, 2014 at 03:46:18PM +0100, Arnd Bergmann wrote:
> > > > On Monday 01 September 2014 10:29:40 Thierry Reding wrote:
> > > > > 
> > > > > I think this could use a bit more formalization. As I said in another
> > > > > reply earlier, there's very little standardization in the IOMMU API.
> > > > > That certainly gives us a lot of flexibility but it also has the
> > > > > downside that it's difficult to handle these abstractions in the core,
> > > > > which is really what the core is all about, isn't it?
> > > > > 
> > > > > One method that worked really well for this in the past for other
> > > > > subsystems is to allow drivers to specify an .of_xlate() function that
> > > > > takes the controller device and a struct of_phandle_args. It is that
> > > > > function's responsibility to take the information in an of_phandle_args
> > > > > structure and use that to create some subsystem specific handle that
> > > > > represents this information in a way that it can readily be used.
> > > > 
> > > > Yes, good idea.
> > > 
> > > Hmm, how does this work for PCI devices? The current RFC takes care to
> > > ensure that the core changes work just as well for OF devices as PCI
> > > devices, and the of-specific functions and data structures are not part of
> > > it.
> > 
> > I don't mind handling PCI devices separately. They are different in a number
> > of ways already, in particular the way that they don't normally have an
> > of_node attached to them but actually have a PCI bus/dev/function number.
> 
> Sure, but at the point when we call back into the iommu_ops structure we
> really don't want bus specific functions. That's why I avoided any OF
> data structures being passed to add_device_master_ids.

Well, we clearly need some format that the caller and the callee agree
on. It can't be a completely opaque pointer because it's something
that has to be filled out by someone who knows the format.

Using the DT format has the advantage that the caller does not have
to know anything about the underlying driver except for #size-cells,
and it just passes the data it gets from DT into the driver. This is
how we do the association in a lot of other subsystems.

> Anyway, I'll try to hack something together shortly. I think the proposal
> is:
> 
>   - Make add_device_master_ids take a generic structure (struct iommu)
>   - Add an of_xlate callback into iommu_ops which returns a populated
>     struct iommu based on the of_node

We may have been talking past one another. What I meant with 'struct iommu'
is something that identifies the iommu instance, not the connection to
a particular master. What you describe here would work, but then I think
the structure should have a different name. However, it seems easier to
not have the add_device_master_ids at and just do the association in the
xlate callback instead.

We still need to figure out how to do it for PCI of course. One
possibility would be to add another argument to the xlate function and
have that called by the PCI device probing method with the iommus
property of the PCI host controller along with the a u64 number that
is generated by the host bridge driver based on the bus/device/function
number of the device.

This means that the new callback function for the iommu API remains
DT specific, but is not really bus specific. It does however not
solve the embedded x86 use case, which may need some other callback.

We might be lucky there if we are able to just use the PCI b/d/f
number as a unique identifier and have a NULL argument for the
respective iommus property.

	Arnd
