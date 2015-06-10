From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Master-aware devices and sideband ID data
Date: Wed, 10 Jun 2015 09:11:21 +0100
Message-ID: <20150610081120.GA22973@arm.com>
References: <20150324155007.GC23005@leverpostej>
	<26BE36EF-2C5B-4DA6-8950-8FEBB031ED1B@caviumnetworks.com>
	<20150527173953.GC23176@leverpostej>
	<E342D737-5DD5-48C7-BB01-B83C29CB6E31@caviumnetworks.com>
	<20150601102208.GD22406@leverpostej>
	<158EFC9F-FCAF-44D3-AD40-804EDFE0CE25@caviumnetworks.com>
	<20150605090534.GC1198@arm.com>
	<20150609101515.GA28474@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150609101515.GA28474@leverpostej>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 09, 2015 at 11:17:54AM +0100, Mark Rutland wrote:
> On Fri, Jun 05, 2015 at 10:05:34AM +0100, Will Deacon wrote:
> > On Thu, Jun 04, 2015 at 11:19:30PM +0100, Chalamarla, Tirumalesh wrote:
> > > > On Jun 1, 2015, at 3:22 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> > > > It's possible to specify that the paths exist. I expect that software
> > > > would select which to use at runtime.
> > > > 
> > > My worry is how to define any priorities/preferences between masters. 
> > > in general the proposal looks reasonable.
> > 
> > I agree that the proposal looks reasonable (in terms of the ability to
> > describe the sort of topologies that we will face) but I still don't
> > understand what I need to do in e.g. my IOMMU driver to support this
> > binding whilst continuing to support the existing iommus binding, which
> > is relied upon to configure dma-mapping.
> > 
> > Mark: how do you see this co-existing/merging with the current bindings?
> 
> As I mentioned in my initial mail, it's not clear to me how this can be
> reconciled with the current bindings. Everything I've been able to come
> up with so far at best ends up describing the same thing repeatedly.
> 
> I'll see what I can come up with. Any sugestions are welcome!

Well, I'd start with the current iommu binding and see if you can figure
out which properties need adding to it in order to describe the sort of
topologies you can describe with your original proposal.

> > I don't think it's practical to throw away what we have and move over to
> > something totally different all in one go, but there clearly *is* benefit
> > in your proposal over the existing scheme.
> 
> I can see that's probably not practical. :(
> 
> Do we know what we're going to do w.r.t. IORT? That's going to require
> the kernel to be able to handle a similar description to this proposal.

IORT is part of ACPI, so it doesn't care about the existing DT binding
and doesn't need to co-exist at runtime.

Will
