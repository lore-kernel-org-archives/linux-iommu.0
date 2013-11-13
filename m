From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv4 5/7] iommu/tegra: smmu: Support "mmu-masters" binding
Date: Wed, 13 Nov 2013 10:58:23 -0700
Message-ID: <5283BDBF.9020509@wwwdotorg.org>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>	<1384158718-4756-6-git-send-email-hdoyu@nvidia.com>	<5282C512.5090900@wwwdotorg.org>
	<20131113094517.4608edf4302b61e3c4402a25@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131113094517.4608edf4302b61e3c4402a25-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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

On 11/13/2013 12:45 AM, Hiroshi Doyu wrote:
> On Wed, 13 Nov 2013 01:17:22 +0100
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> 
>>> +		mmu-masters = <&host1x TEGRA_SWGROUP_HC>,
>>> +			      <&mpe TEGRA_SWGROUP_MPE>,
>>> +			      <&vi TEGRA_SWGROUP_VI>,
>>> +			      <&epp TEGRA_SWGROUP_EPP>,
>>> +			      <&isp TEGRA_SWGROUP_ISP>,
>>> +			      <&gr2d TEGRA_SWGROUP_G2>,
>>> +			      <&gr3d TEGRA_SWGROUP_NV TEGRA_SWGROUP_NV2>,
>>
>> So right now, the driver is statically assigning clients to a couple of
>> specific ASIDs. What if we want to configure that mapping from DT; does
>> that make sense? Instead of mmu-masters being a list of <phandle
>> streamid*>, should it be <phandle ASID streamid*> or <phandle (streamid
>> ASID)*>?
> 
> That's possible.
> 
> Here, swgroup ID == stream ID, and a device is statically bind to a
> specific swgroup ID(hard coded). ASID is dynamically assigned to
> swgroup(devices). So assigning ASID belongs to a policy, but we can
> consider this assigning as board specifc policy since it's hard to
> change after kernel boots up in general. So assigning ASID in a board
> DT makes sense. The format would be:
> 
>   <phandle "swgroup ID" "asid">,
> 
> ex:
>   <&host1x TEGRA_SWGROUP_HC 0>,
> 
> The above depends on the discussion of the standard IOMMU bindings,
> but the number of argument can be set by each IOMMU driver.
> 
> If we take the the other way,
> 
>  smmu: iommu@xxxxxx {
>        #iommu-cells = <3>;
>        ^^^^^^^^^^^^^^^^^^
>    };
> 
>    host1x {
>            compatible = "nvidia,tegra30-host1x", "simple-bus";
>            iommu = <&smmu 0x??????? 0x??????? "asid">;
> 	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#######
>            gr3d {
>                    compatible = "nvidia,tegra30-gr3d";
>                    iommu = <&smmu 0x??????? 0x???????>;
>            }
> 
> I think that this "asid" part can be set 0 in tegra??.dtsi and the
> actual value can be overwritten in tegra??-<boardname>.dts file.

The one issue here is that we can only override entire properties, so
it's not possible for a board file to *just* replace the ASID, it'd have
to duplicate the entire property, just to change the one value.

Is the ASID mapping really likely to be board-specific though? To my
naive thinking, it seems that the chip design (e.g. number of
peripherals, number of available ASIDs) would tend to imply the
device->ASID mapping, since it would have been considered as part of
chip design. Hence, wouldn't soc.dtsi typically specify the expected
ASID mapping, and boards rarely if ever override it?

If the ASID mapping really is likely to vary per board, perhaps it makes
sense to put it into a separate property somehow so it's easier to override?
