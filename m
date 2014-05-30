From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Fri, 30 May 2014 21:49:59 +0200
Message-ID: <5288123.eXagyPAxNq@wuerfel>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
	<4545972.cM7IP1qTXQ@wuerfel>
	<CAL_Jsq+tkFNpjSEZboT+o69B_Z3a8e-ZVKaYDmLwtkyYoPy6VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAL_Jsq+tkFNpjSEZboT+o69B_Z3a8e-ZVKaYDmLwtkyYoPy6VQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Friday 30 May 2014 14:31:55 Rob Herring wrote:
> On Fri, May 30, 2014 at 2:06 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > On Friday 30 May 2014 08:16:05 Rob Herring wrote:
> >> On Fri, May 23, 2014 at 3:33 PM, Thierry Reding
> >> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >> > +IOMMU master node:
> >> > +==================
> >> > +
> >> > +Devices that access memory through an IOMMU are called masters. A device can
> >> > +have multiple master interfaces (to one or more IOMMU devices).
> >> > +
> >> > +Required properties:
> >> > +--------------------
> >> > +- iommus: A list of phandle and IOMMU specifier pairs that describe the IOMMU
> >> > +  master interfaces of the device. One entry in the list describes one master
> >> > +  interface of the device.
> >> > +
> >> > +When an "iommus" property is specified in a device tree node, the IOMMU will
> >> > +be used for address translation. If a "dma-ranges" property exists in the
> >> > +device's parent node it will be ignored. An exception to this rule is if the
> >> > +referenced IOMMU is disabled, in which case the "dma-ranges" property of the
> >> > +parent shall take effect.
> >>
> >> Just thinking out loud, could you have dma-ranges in the iommu node
> >> for the case when the iommu is enabled rather than putting the DMA
> >> window information into the iommus property?
> >>
> >> This would probably mean that you need both #iommu-cells and #address-cells.
> >
> > The reason for doing like this was that you may need a different window
> > for each device, while there can only be one dma-ranges property in
> > an iommu node.
> 
> My suggestion was that you also put the IDs in the dma-ranges as the
> first cell much as ranges for PCI encodes other information in the
> first cell. Then you can have an entry for each ID. The downside is
> another special case like PCI.
> 
> The argument for using #address-cells and #size-cells seems to be to
> align with how ranges work. If that's the route we want to go, then I
> say we should not stop there and actually use dma-ranges as well.
> Otherwise, I don't see the advantage over #iommu-cells.

I can see how dma-ranges in bus nodes work, it just doesn't seem to
have any reasonable meaning in the iommu node itself.

> > I don't understand the problem. If you have stream IDs 0 through 7,
> > you would have
> >
> >         master@a {
> >                 ...
> >                 iommus = <&smmu 0>;
> >         };
> >
> >         master@b {
> >                 ...
> >                 iommus = <&smmu 1;
> >         };
> >
> >         ...
> >
> >         master@12 {
> >                 ...
> >                 iommus = <&smmu 7;
> >         };
> >
> > and you don't need a window at all. Why would you need a mask of
> > some sort?
> 
> 1 master with 7 IDs like this:
> 
>          master@a {
>                  ...
>                  iommus = <&smmu 0> <&smmu 1> <&smmu 2> <&smmu 3>
> <&smmu 4> <&smmu 5> <&smmu 6> <&smmu 7>;
>          };
> 
> If there was any sort of window, then it is almost certainly the same
> window for each ID.

Ok, I see. In that case you'd probably want to have #address-cells = <1>
and #size-cells = <1> and give a range of IDs like

	iommus = <&smmu 0 8>;

Do you think that ranges can have a meaningful definition with the ARM
SMMU stream IDs?

	Arnd
