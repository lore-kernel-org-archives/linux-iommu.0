From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Fri, 30 May 2014 21:06:16 +0200
Message-ID: <4545972.cM7IP1qTXQ@wuerfel>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
	<CAL_JsqKumG1PSFoVfeGpLLG+MjXFeF4aUjun=vv1BJpaxk0Byg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAL_JsqKumG1PSFoVfeGpLLG+MjXFeF4aUjun=vv1BJpaxk0Byg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Friday 30 May 2014 08:16:05 Rob Herring wrote:
> On Fri, May 23, 2014 at 3:33 PM, Thierry Reding
> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > +IOMMU master node:
> > +==================
> > +
> > +Devices that access memory through an IOMMU are called masters. A device can
> > +have multiple master interfaces (to one or more IOMMU devices).
> > +
> > +Required properties:
> > +--------------------
> > +- iommus: A list of phandle and IOMMU specifier pairs that describe the IOMMU
> > +  master interfaces of the device. One entry in the list describes one master
> > +  interface of the device.
> > +
> > +When an "iommus" property is specified in a device tree node, the IOMMU will
> > +be used for address translation. If a "dma-ranges" property exists in the
> > +device's parent node it will be ignored. An exception to this rule is if the
> > +referenced IOMMU is disabled, in which case the "dma-ranges" property of the
> > +parent shall take effect.
> 
> Just thinking out loud, could you have dma-ranges in the iommu node
> for the case when the iommu is enabled rather than putting the DMA
> window information into the iommus property?
> 
> This would probably mean that you need both #iommu-cells and #address-cells.

The reason for doing like this was that you may need a different window
for each device, while there can only be one dma-ranges property in 
an iommu node.

> > +
> > +Optional properties:
> > +--------------------
> > +- iommu-names: A list of names identifying each entry in the "iommus"
> > +  property.
> 
> Do we really need a name here? I would not expect that you have
> clearly documented names here from the datasheet like you would for
> interrupts or clocks, so you'd just be making up names. Sorry, but I'm
> not a fan of names properties in general.

Good point, this was really overdesign by modeling it after other
subsystems that can have a use for names.
 
> > +Multiple-master IOMMU:
> > +----------------------
> > +
> > +       iommu {
> > +               /* the specifier represents the ID of the master */
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +       };
> > +
> > +       master {
> > +               /* device has master ID 42 in the IOMMU */
> > +               iommus = <&/iommu 42>;
> > +       };
> 
> Presumably the ID would be the streamID on ARM's SMMU. How would a
> master with 8 streamIDs be described? This is what Calxeda midway has
> for SATA and I would expect that to be somewhat common. Either you
> need some ID masking or you'll have lots of duplication when you have
> windows.

I don't understand the problem. If you have stream IDs 0 through 7,
you would have

	master@a {
		...
		iommus = <&smmu 0>;
	};

	master@b {
		...
		iommus = <&smmu 1;
	};

	...

	master@12 {
		...
		iommus = <&smmu 7;
	};

and you don't need a window at all. Why would you need a mask of
some sort?

	Arnd
