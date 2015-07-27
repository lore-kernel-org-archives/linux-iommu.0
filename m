From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
Date: Mon, 27 Jul 2015 10:16:17 +0100
Message-ID: <20150727091535.GA9169@leverpostej>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-3-git-send-email-mark.rutland@arm.com>
 <FD9C4916-6BDC-40F2-A273-91BFBD3B0075@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <FD9C4916-6BDC-40F2-A273-91BFBD3B0075-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Daney, David" <David.Daney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> > +Example (5)
> > +===========
> > +
> > +/ {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	msi_a: msi-controller@a {
> > +		reg = <0xa 0x1>;
> > +		compatible = "vendor,some-controller";
> > +		msi-controller;
> > +		#msi-cells = <1>;
> > +	};
> > +
> > +	msi_b: msi-controller@b {
> > +		reg = <0xb 0x1>;
> > +		compatible = "vendor,some-controller";
> > +		msi-controller;
> > +		#msi-cells = <1>;
> > +	};
> > +
> > +	msi_c: msi-controller@c {
> > +		reg = <0xc 0x1>;
> > +		compatible = "vendor,some-controller";
> > +		msi-controller;
> > +		#msi-cells = <1>;
> > +	};
> > +
> > +	pci: pci@c {
> > +		reg = <0xf 0x1>;
> > +		compatible = "vendor,pcie-root-complex";
> > +		device_type = "pci";
> > +
> > +		/*
> > +		 * The sideband data provided to MSI controller a is the
> > +		 * RID, but the high bit of the bus number is negated.
> > +		 * The sideband data provided to MSI controller b is the
> > +		 * RID, identity-mapped.
> > +		 * MSI controller c is not addressable.
> > +		 */
> > +		msi-map = <0x0000 &msi_a 0x8000 0x08000>,
> > +			  <0x8000 &msi_a 0x0000 0x08000>,
> > +			  <0x0000 &msi_b 0x0000 0x10000>;
> > +	};
> 
> they can be identical right? like
> 	<0x8000 &msi_a 0x0000 0x08000>,
>  	<0x8000 &msi_b 0x0000 0x08000>;

In general that would be valid, yes.

In this case two entries are required for MSI controller a because the
high bit passed to it is negated. This does not occur for MSI controller
b, so it only requires a single entry to describe the transformation.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
