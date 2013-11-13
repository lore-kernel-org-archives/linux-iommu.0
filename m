From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
Date: Wed, 13 Nov 2013 17:06:10 +0100
Message-ID: <20131113.180610.823304139654159769.hdoyu@nvidia.com>
References: <1384158718-4756-3-git-send-email-hdoyu@nvidia.com><5282BAFC.8070405@wwwdotorg.org><20131113143804.GA11928@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131113143804.GA11928-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "Mark.Rutland-5wv7dgnIgG8@public.gmane.org" <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org" <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote @ Wed, 13 Nov 2013 15:38:04 +0100:

> On Tue, Nov 12, 2013 at 11:34:20PM +0000, Stephen Warren wrote:
> > On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> > > An "IOMMU device" on the bus is poplulated first, "IOMMU'able devices"
> > > are done later.
> > > 
> > > With CONFIG_OF_IOMMU, "#stream-id-cells" DT binding would be used to
> > > identify whether a device is IOMMU'able or not. If a device is
> > > IOMMU'able, we'll defer to populate that device till an iommu device
> > > is populated. Once an iommu device is populated, "dev->bus->iommu_ops"
> > > is set in the bus. Then, those defered IOMMU'able devices are
> > > populated and configured as IOMMU'abled with help of the already
> > > populated iommu device via iommu_ops->add_device().
> > 
> > This looks fairly neat and clean.
> > 
> > I'm still worried about using #stream-id-cells in DT nodes though. While
> > I do understand that the *Linux* device model currently only allows each
> > struct device to be affected by a single IOMMU, I worry that encoding
> > that same restriction into DT is a mistake. I'd far rather see a
> > property like:
> > 
> > SMMU:
> >     smmu: smmu@xxxxxx {
> >         #smmu-cells = <1>;
> >     }
> > 
> > Affected device:
> >     smmus = <&smmu 1>;
> >     (perhaps with smmu-names too)
> > 
> > That would allow the DT to represent basically arbitrary HW configurations.
> > 
> > The implementation of this patch would then be almost as trivial; you'd
> > just need to walk the smmus property to find each phandle in turn, just
> > like any other phandle+specifier property, and validate that the SMMU
> > driver was already probe()d for each.
> 
> There are a few problems with that:
> 
>   1.) It assumes all devices sharing an SMMU have the same number of
>       "smmu cells"

This can be solved with introducing the fixed size of bitmap. The size
of bitmap can be fixed even per SoC. In tegra we used 64(2 cells)
which I expect at most.

>   2.) It moves SMMU-specific data out to the device, which makes it
>       impossible to describe more complicated topologies where IDs can be
>       remapped/remastered, potentially by multiple SMMUs and/or bus bridges.
> 
> When writing the binding for the ARM SMMU driver, I originally started with
> something similar to what you're suggesting, but was later forced down a
> different route when I realised what sort of systems were being built.
> 
> We will have similar problems for PCIe RIDs and GIC DIDs (I spoke about this
> at the ARM mini-summit). They are not fixed across the system: they
> originate from a device, but can change as they traverse the system
> topology.

Is there any chance to overwrite SMMU driver specific params during
setting up topologies?
