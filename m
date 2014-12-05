From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
	drivers
Date: Fri, 05 Dec 2014 13:21:22 +0100
Message-ID: <3286461.0coAmzDsnx@wuerfel>
References: <CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
	<5480B924.2010205@arm.com> <20141205121037.GI1630@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141205121037.GI1630-5wv7dgnIgG8@public.gmane.org>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Friday 05 December 2014 12:10:37 Will Deacon wrote:
> On Thu, Dec 04, 2014 at 07:42:28PM +0000, Robin Murphy wrote:
> > On 04/12/14 17:58, Grant Likely wrote:
> > [...]
> > >>>> +struct of_iommu_node {
> > >>>> +       struct list_head list;
> > >>>> +       struct device_node *np;
> > >>>> +       struct iommu_ops *ops;
> > >>>
> > >>>
> > >>> Why can't this be const? Why would anyone ever need to modify it? Also
> > >>> drivers do define their iommu_ops structures const these days, so you'll
> > >>> either still have to cast away at some point or the compiler will
> > >>> complain once you start calling this from drivers.
> > >>>
> > >>
> > >> ...whereas if we make everything const then the drivers that _do_ want to
> > >> use the private data introduced by this series and thus pass mutable
> > >> per-instance iommu_ops will be the ones having to cast. We have no users
> > >> either way until this series is merged, and the need to stash the
> > >> per-instance data somewhere other than np->data is in the way of getting it
> > >> merged - this is just a quick hack to address that. I think we've already
> > >> agreed that mutable per-instance iommu_ops holding private data aren't
> > >> particularly pleasant and will (hopefully) go away in the next iteration[1],
> > >> at which point this all changes anyway.
> > >
> > > Do you expect drivers to modify that *priv pointer after the ops
> > > structure is registered? I'd be very surprised if that was the use
> > > case. It's fine for the driver to register a non-const version, but
> > > once it is registered, the infrastructure can treat it as const from
> > > then on.
> > 
> > Possibly not - certainly my current port of the ARM SMMU which makes use 
> > of *priv is only ever reading it - although we did also wave around 
> > reasons for mutable ops like dynamically changing the pgsize_bitmap and 
> > possibly even swizzling individual ops for runtime reconfiguration. On 
> > consideration though, I'd agree that things like that are mad enough to 
> > stay well within individual drivers if they did ever happen, and 
> > certainly shouldn't apply to this bit of the infrastructure at any rate.
> 
> I certainly need to update the pgsize_bitmap at runtime because I don't
> know the supported page sizes until I've both (a) probed the hardware
> and (b) allocated page tables for a domain. We've already discussed
> moving the pgsize_bitmap out of the ops, but moving it somewhere where
> it remains const doesn't really help.
> 
> Can I just take the patch that Grant acked, in the interest of getting
> something merged? As you say, there's plenty of planned changes in this
> area anyway. I plan to send Olof a pull request this afternoon.
> 

I think that would be ok. The fix later should be to move the
private data pointer into of_iommu_node, but I think that will
require a larger set of changes, so let's defer that.

	Arnd
