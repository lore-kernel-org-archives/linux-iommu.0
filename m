From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
Date: Wed, 13 Nov 2013 10:49:08 -0700
Message-ID: <5283BB94.6060400@wwwdotorg.org>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>	<1384158718-4756-3-git-send-email-hdoyu@nvidia.com>	<5282BAFC.8070405@wwwdotorg.org>
	<20131113092354.5b65f29bacc4f37083f81e2e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131113092354.5b65f29bacc4f37083f81e2e-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/13/2013 12:23 AM, Hiroshi Doyu wrote:
> On Wed, 13 Nov 2013 00:34:20 +0100
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> 
>> On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
>>> An "IOMMU device" on the bus is poplulated first, "IOMMU'able devices"
>>> are done later.
>>>
>>> With CONFIG_OF_IOMMU, "#stream-id-cells" DT binding would be used to
>>> identify whether a device is IOMMU'able or not. If a device is
>>> IOMMU'able, we'll defer to populate that device till an iommu device
>>> is populated. Once an iommu device is populated, "dev->bus->iommu_ops"
>>> is set in the bus. Then, those defered IOMMU'able devices are
>>> populated and configured as IOMMU'abled with help of the already
>>> populated iommu device via iommu_ops->add_device().
>>
>> This looks fairly neat and clean.
>>
>> I'm still worried about using #stream-id-cells in DT nodes though. While
>> I do understand that the *Linux* device model currently only allows each
>> struct device to be affected by a single IOMMU, I worry that encoding
>> that same restriction into DT is a mistake. I'd far rather see a
>> property like:
>>
>> SMMU:
>>     smmu: smmu@xxxxxx {
>>         #smmu-cells = <1>;
>>     }
>>
>> Affected device:
>>     smmus = <&smmu 1>;
>>     (perhaps with smmu-names too)
>>
>> That would allow the DT to represent basically arbitrary HW configurations.
> 
> True, and also can solve multi IOMMU problem as well.
> 
>> The implementation of this patch would then be almost as trivial; you'd
>> just need to walk the smmus property to find each phandle in turn, just
>> like any other phandle+specifier property, and validate that the SMMU
>> driver was already probe()d for each.
> 
> This seems to be almost same as the previous v3 DT bindings, and if we
> introduce 64 bitmap newly, this DT bindings would be something like
> below:
> 
>    smmu: iommu@xxxxxx {
>        #smmu-cells = <2>;
>        ......
>    };
> 
>    host1x {
>            compatible = "nvidia,tegra30-host1x", "simple-bus";
>            nvidia,memory-clients = <&smmu 0x??????? 0x???????>;
>            ....
>            gr3d {
>                    compatible = "nvidia,tegra30-gr3d";
>                    nvidia,memory-clients = <&smmu 0x??????? 0x???????>;
>            }
> 
> If a device is attached to multiple IOMMU H/Ws,
> 
>            gr3d {
>                    compatible = "nvidia,tegra30-gr3d";
>                    nvidia,memory-clients = <&smmu 0x??????? 0x??????? &gart 0x???????>;
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Then, the problem is the binding "name" and its "scope". This original
> patch works with "#stream-id-cells" in driver core because I assumed
> that "#stream-id-cells" can indicate globally that a device can be an
> IOMMU master.

For example, the pinctrl bindings have the same issue, since they're
interpreted "globally", and by (code called from) the generic device
probing code.

We simply decided that the properties "pinctrl-names" and "pinctrl-n"
(n=0...) were globally defined by the pinctrl subsystem, and hence could
be parsed in any node.

We could do the same with "smmus" and "smmu-names" in this case.

> We may be able to have some kind of callback function which checks
> "#stream-id-cells" *in* SMMU driver, but at least this function needs to
> be registered in the bus at very early stage, iommu_ops->is_iommu_master().
> But this cannot be done with bus->iommu_ops since bus->iommu_ops is set
> after IOMMU is populated. A kind of Chikin or the egg problem.

I think this is simply the normal deferred probe.

When device X attempts to probe, the core SMMU code (called from the
core device probing code) iterates over the smmus property. If any of
the phandles listed there don't have a registered SMMU driver, then
defer probe of device X. Eventually, the SMMU driver will appear, and
the driver core will attempt to re-probe device X, and all the SMMUs
have devices probed already, and everything will work.
