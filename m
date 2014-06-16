From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Mon, 16 Jun 2014 19:30:19 +0200
Message-ID: <5115654.pRN5gLfQMp@wuerfel>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
	<8b0492b4697943a0b1f276ef42cc8223@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140616170416.GA16758@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140616170416.GA16758-5wv7dgnIgG8@public.gmane.org>
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
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWOunwaRDDq4rA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Monday 16 June 2014 18:04:16 Will Deacon wrote:
> 
> On Mon, Jun 16, 2014 at 05:56:32PM +0100, Stuart Yoder wrote:
> > > Do you have use-cases where you really need to change these mappings
> > > dynamically?
> > 
> > Yes.  In the case of a PCI bus-- you may not know in advance how many
> > PCI devices there are until you probe the bus.   We have another FSL
> > proprietary bus we call the "fsl-mc" bus that is similar.
> 
> For that case, though, you could still describe an algorithmic
> transformation from RequesterID to StreamID which corresponds to a fixed
> mapping.

It sounds to me like the best option here would be to have only the
RequesterID passed in the "iommus" property and have the StreamID
dynamically assigned. This would mean we treat the StreamID as
the context.

> > Another thing to consider-- starting with SMMUv2, as you know, there
> > is a new distributed architecture with multiple TBUs and a centralized
> > TCU that walks the SMMU page tables.  So instead of sprinkling multiple
> > SMMUs all over an SoC you now have the option a 1 central TCU and sprinkling
> > multiple TBUs around.   However, this means that the stream ID namespace
> > is now global and can be pretty limited.  In the SMMU implementation we 
> > have there are only 64 stream ID total for our Soc.  But we have many more
> > masters than that.
> > 
> > So we look at stream IDs as really corresponding to an 'isolation context'
> > and not to a bus master.  An isolation context is the domain you are
> > trying to isolate with the SMMU.  Devices that all belong to the same
> > 'isolation context' can share the same stream ID, since they share
> > the same domain and page tables.
> 
> Ok, this is more compelling.

This also makes sense from the kernel's perspective: The shared Stream ID
is the one that is used by the dma-mapping API here, while all other
Stream IDs would only be used if you have things like PCI device assignment
or GPU contexts that map into IOMMU contexts using the Linux IOMMU
abstraction, which is a lower-level interface than the dma-mapping
abstraction.

	Arnd
