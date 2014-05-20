From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Tue, 20 May 2014 14:07:09 +0100
Message-ID: <20140520130659.GA5041@e103592.cambridge.arm.com>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<20140519172113.GA13858@e103592.cambridge.arm.com>
	<20140519203232.GD30737@mithrandir> <5080348.QmhgfQRxZW@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5080348.QmhgfQRxZW@wuerfel>
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
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, May 20, 2014 at 12:08:44PM +0200, Arnd Bergmann wrote:
> On Monday 19 May 2014 22:32:33 Thierry Reding wrote:
> > On Mon, May 19, 2014 at 06:22:31PM +0100, Dave Martin wrote:
> > > On Mon, May 19, 2014 at 01:53:37PM +0100, Thierry Reding wrote:
> > [...]
> > > > My understanding here is mostly based on the OpenFirmware working group
> > > > proposal for the dma-ranges property[0]. I'll give another example to
> > > > try and clarify how I had imagined this to work:
> > > > 
> > > >     / {
> > > >             #address-cells = <2>;
> > > >             #size-cells = <2>;
> > > > 
> > > >             iommu {
> > > >                     /*
> > > >                      * This is somewhat unusual (or maybe not) in that we
> > > >                      * need 2 cells to represent the size of an address
> > > >                      * space that is 32 bits long.
> > > >                      */
> > > >                     #address-cells = <1>;
> > > >                     #size-cells = <2>;
> > > > 
> > > >                     #iommu-cells = <1>;
> > > >             };
> > > > 
> > > >             master {
> > > >                     iommus = <&/iommu 42>;
> > > 
> > > Comparing this with the other discussion thread, we have a similar
> > > concept here, in that the iommu is made a logical parent, however...
> > > 
> > > Firstly, there's an implicit assumption here that the only kind of
> > > thing the master could possibly be connected to is an IOMMU, with
> > > no non-trivial interconnect in between.  I'm not sure this is going
> > > to scale to complex SoCs.
> > 
> > Here we go again. We're now in the very same bad spot that we've been in
> > so many times before. There are at least two SoCs that we know do not
> > require anything fancy, yet we're blocking adding support for those use
> > cases because we think that at some point some IOMMU may require more
> > than that. But at the same time it seems like we don't have enough data
> > about what exactly that is, so we keep speculating. At this rate we're
> > making it impossible to get a reasonable feature set supported upstream.
> > 
> > That's very frustrating.
> 
> I agree. While I just commented that I want to think through how this
> would look for other IOMMUs, the generic case of all masters that Dave
> wants is going overboard with the complexity and we'd be better off

I don't want that, and actually I agree with the conclusion "overboard".

It was really about exploring the problem space, including things that
we can reasonably foresee.  Any bindings today should necessarily be
much simpler, and that's certainly the correct approach.

I've been neglecting this thread (apologies) -- but although I have to
think a bit about Thierry's most recent suggestions, I think there's
actually reasonable alignment now.

> deferring this to whenever someone needs it, which I assume is never.

Well, some of it might be.  But I'm not saying we should give in to
wild speculation (except to get a feel for what we're ruling out, and
the consequences of that).

> 
> > > If a range of Stream IDs may be issued (especially from something like
> > > a PCIe RC where the stream ID may be a many-bit value), describing
> > > the IDs individually may be impractical.
> > 
> > The IOMMU specifier is completely specific to the IOMMU. If an IOMMU has
> > a need to represent the stream IDs as a range there's nothing keeping it
> > from defining the specifier accordingly.
> 
> If we make the IOMMU address space look like the PCI address space, we
> can have a simple representation for this in DT. For the code, I assume
> that we will always have to treat PCI and platform devices differently.

Can you elaborate on that?

Master ID signals in ARM systems and how they are handled are rather
under-specified today.  Treating the master ID bits as some extra bits
in some kind of extended bus address could work for ARM IOMMUs etc.,
but I didn't have a complete answer yet.

Cheers
---Dave
