From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
Date: Wed, 13 Nov 2013 09:23:54 +0200
Message-ID: <20131113092354.5b65f29bacc4f37083f81e2e@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
	<1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
	<5282BAFC.8070405@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5282BAFC.8070405-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 13 Nov 2013 00:34:20 +0100
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:

> On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> > An "IOMMU device" on the bus is poplulated first, "IOMMU'able devices"
> > are done later.
> > 
> > With CONFIG_OF_IOMMU, "#stream-id-cells" DT binding would be used to
> > identify whether a device is IOMMU'able or not. If a device is
> > IOMMU'able, we'll defer to populate that device till an iommu device
> > is populated. Once an iommu device is populated, "dev->bus->iommu_ops"
> > is set in the bus. Then, those defered IOMMU'able devices are
> > populated and configured as IOMMU'abled with help of the already
> > populated iommu device via iommu_ops->add_device().
> 
> This looks fairly neat and clean.
> 
> I'm still worried about using #stream-id-cells in DT nodes though. While
> I do understand that the *Linux* device model currently only allows each
> struct device to be affected by a single IOMMU, I worry that encoding
> that same restriction into DT is a mistake. I'd far rather see a
> property like:
> 
> SMMU:
>     smmu: smmu@xxxxxx {
>         #smmu-cells = <1>;
>     }
> 
> Affected device:
>     smmus = <&smmu 1>;
>     (perhaps with smmu-names too)
> 
> That would allow the DT to represent basically arbitrary HW configurations.

True, and also can solve multi IOMMU problem as well.

> The implementation of this patch would then be almost as trivial; you'd
> just need to walk the smmus property to find each phandle in turn, just
> like any other phandle+specifier property, and validate that the SMMU
> driver was already probe()d for each.

This seems to be almost same as the previous v3 DT bindings, and if we
introduce 64 bitmap newly, this DT bindings would be something like
below:

   smmu: iommu@xxxxxx {
       #smmu-cells = <2>;
       ......
   };

   host1x {
           compatible = "nvidia,tegra30-host1x", "simple-bus";
           nvidia,memory-clients = <&smmu 0x??????? 0x???????>;
           ....
           gr3d {
                   compatible = "nvidia,tegra30-gr3d";
                   nvidia,memory-clients = <&smmu 0x??????? 0x???????>;
           }

If a device is attached to multiple IOMMU H/Ws,

           gr3d {
                   compatible = "nvidia,tegra30-gr3d";
                   nvidia,memory-clients = <&smmu 0x??????? 0x??????? &gart 0x???????>;
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Then, the problem is the binding "name" and its "scope". This original
patch works with "#stream-id-cells" in driver core because I assumed
that "#stream-id-cells" can indicate globally that a device can be an
IOMMU master.

We may be able to have some kind of callback function which checks
"#stream-id-cells" *in* SMMU driver, but at least this function needs to
be registered in the bus at very early stage, iommu_ops->is_iommu_master().
But this cannot be done with bus->iommu_ops since bus->iommu_ops is set
after IOMMU is populated. A kind of Chikin or the egg problem.

Having a global bindings which indicates a device's IOMMU
master'ability is quite convenient. For example, "iommu" and
"#iommu-cells" without refering any local data. Then the above
DT would be:

   smmu: iommu@xxxxxx {
       #iommu-cells = <2>;
       ^^^^^^^^^^^^^^^^^^
   };

   host1x {
           compatible = "nvidia,tegra30-host1x", "simple-bus";
           iommu = <&smmu 0x??????? 0x???????>;
	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
           gr3d {
                   compatible = "nvidia,tegra30-gr3d";
                   iommu = <&smmu 0x??????? 0x???????>;
           }

What do you think to have a global IOMMU DT bindings?
