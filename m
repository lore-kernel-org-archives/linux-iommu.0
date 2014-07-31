From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 31 Jul 2014 11:50:17 +0100
Message-ID: <20140731105017.GB22994@leverpostej>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140730152646.GC20162@leverpostej>
	<CAOesGMi3zM1-cqmeGddJ69RNXx0ktFm_zXO_yq7N0EeA3HNrUQ@mail.gmail.com>
	<20140730181842.GG20162@leverpostej> <20140731100905.GA7458@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140731100905.GA7458@ulmo>
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 31, 2014 at 11:09:06AM +0100, Thierry Reding wrote:
> On Wed, Jul 30, 2014 at 07:18:42PM +0100, Mark Rutland wrote:
> [...]
> > > >> +
> > > >> +Multiple-master IOMMU with configurable DMA window:
> > > >> +---------------------------------------------------
> > > >> +
> > > >> +     / {
> > > >> +             #address-cells = <1>;
> > > >> +             #size-cells = <1>;
> > > >> +
> > > >> +             iommu {
> > > >> +                     /* master ID, address and length of DMA window */
> > > >> +                     #iommu-cells = <4>;
> > > >> +             };
> > > >> +
> > > >> +             master {
> > > >> +                     /* master ID 42, 4 GiB DMA window starting at 0 */
> > > >> +                     iommus = <&/iommu  42  0  0x1 0x0>;
> > > >
> > > > Is this that window is from the POV of the master, i.e. the master can
> > > > address 0x0 to 0xffffffff when generating transactions, and these get
> > > > translated somehow?
> > > >
> > > > Or is this the physical addresses to allocate to the master?
> > > 
> > > It needs to be clarified in the documentation, but as far as I know it
> > > is the DMA address space that is used.
> > 
> > Ok. So that's pre-translation, from the POV of the master?
> 
> Correct. It represents the window of the IOMMU's addressable I/O virtual
> address space that should be assigned to this particular master.
> 
> > If we don't have that knowledge about the master already (e.g. based on
> > the compatible string), surely we always need that information in a
> > given iommu-specifier format? Otherwise certain iommus won't be able to
> > handle masters with limited addressing only due to limitations of their
> > binding.
> 
> This is only used for what's often called a windowed IOMMU. Many IOMMUs
> (non-windowed) typically allow only a complete address space to be
> assigned to a master without additional control over subregions. So this
> is really a property/capability of the IOMMU rather than the masters
> themselves.

I'm not sure I follow, but I'm happy to wait until we have the first
windowed IOMMU using this binding. I'll try to get myself up to speed in
the mean time.

> There are already other means to respect the addressing limitations of
> masters. We typcially use a device's DMA mask for this, and it's natural
> to reuse that for I/O virtual addresses since they will in fact take the
> place of physical addresses for the master when translation is enabled.

Ok, that covers my worry then.

Cheers,
Mark.
