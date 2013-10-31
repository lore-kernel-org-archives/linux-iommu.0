From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 14/19] iommu/tegra: smmu: Get "nvidia,memory-clients"
	from DT
Date: Thu, 31 Oct 2013 13:25:25 -0600
Message-ID: <5272AEA5.7020200@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
	<1382092020-13170-15-git-send-email-hdoyu@nvidia.com>
	<52718BB4.4090007@wwwdotorg.org>
	<20131031.101808.1830527808656695540.hdoyu@nvidia.com>
	<20131031174028.GF3037@kartoffel> <5272AC82.6080205@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5272AC82.6080205-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/31/2013 01:16 PM, Stephen Warren wrote:
> On 10/31/2013 11:40 AM, Mark Rutland wrote:
>> On Thu, Oct 31, 2013 at 08:18:08AM +0000, Hiroshi Doyu wrote:
>>> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 30 Oct 2013 23:44:04 +0100:
>>>
>>>>> +	host1x {
>>>>> +		compatible = "nvidia,tegra30-host1x", "simple-bus";
>>>>> +		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_HC>;
>>>>> +		....
>>>>> +		gr3d {
>>>>> +			compatible = "nvidia,tegra30-gr3d";
>>>>> +			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_NV
>>>>> +						       TEGRA_SWGROUP_NV2>;
>>>>
>>>> Why one cell for the host1x property, and two cells for the gr3d
>>>> property; shouldn't they be the same length?
>>>
>>> That can vary. Even a single device node in DT can belong to multiple
>>> software groups.
>>
>> Same with ARM SMMU.
>>
>>>
>>>>> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
>>>>
>>>>> +static u64 smmu_of_get_memory_client(struct device *dev)
>>>>
>>>>> +	np = of_parse_phandle(dev->of_node, propname, 0);
>>>>> +	if (np != smmu_handle->dev->of_node)
>>>>> +		return ~0;
>>>>> +
>>>>> +	prop = of_get_property(dev->of_node, propname, &bytes);
>>>>> +	if (!prop || !bytes)
>>>>> +		return ~0;
>>>>
>>>> of_parse_phandle_with_fixed_args() might be a good fit here, or perhaps
>>>> require a property #smmu-cells in the SMMU node, thus allowing the
>>>> non-fixed-length of_parse_phandle_with_args() to be used here.
>>>
>>> I once considered of_parse_phandle_with_args() but I couldn't use that
>>> since "#smmu-cells" needed to be fixed in smmu node, not in client
>>> node. In this case, the number of argument(number of swgroup IDs)
>>> varies per client device.
>>
>> For the ARM SMMU binding, each device has a #stream-id-cells property
>> describing how many IDs it has, and then the SMMU node has a phandle+args
>> linkage to each of the devices attached to it, describing their stream IDs.
>> While this does have some limitations (a device can't be plugged into multiple
>> SMMUs with a different number of IDs), it seems generally sane.
> 
> Hmm. That's interesting. I see that the ARM SMMU has a list of the
> clients it affects, whereas this Tegra series puts information into each
> client device about the SMMU(s) that affect it. Is it better to flip the
> Tegra binding around to match the style of the ARM SMMU?

One question here: How do you ensure that the SMMU driver probe()s
before probe() runs for devices affected by the SMMU?

With the DT binding in this series, there's a property in each client
node that describes the SMMU that affects the device. That can feed into
deferred probe very nicely.

However, if all the information is in the SMMU node, how can a client
find that, and hence defer its probe?

Perhaps the ARM SMMU assumes that it sits at the root of a bus, and
hence must be probe()d before any of its child devices can be probe()d?
I'm not sure that there's any general guarantee that a device's control
bus is the same bus it issues bus-master transactions too though, so I'm
not sure that's a general solution.
