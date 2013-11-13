From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
Date: Wed, 13 Nov 2013 10:45:14 -0700
Message-ID: <5283BAAA.4080701@wwwdotorg.org>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
	<1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
	<5282BAFC.8070405@wwwdotorg.org>
	<20131113143804.GA11928@mudshark.cambridge.arm.com>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/13/2013 07:38 AM, Will Deacon wrote:
> On Tue, Nov 12, 2013 at 11:34:20PM +0000, Stephen Warren wrote:
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
>>
>> The implementation of this patch would then be almost as trivial; you'd
>> just need to walk the smmus property to find each phandle in turn, just
>> like any other phandle+specifier property, and validate that the SMMU
>> driver was already probe()d for each.
> 
> There are a few problems with that:
> 
>   1.) It assumes all devices sharing an SMMU have the same number of
>       "smmu cells"

The SMMU HW defines how many cells are required to represent the client
stream IDs. So, this isn't a problem.

Are you thinking of cases where an SMMU client issues transactions with
multiple different stream IDs? That is supported by having multiple
entries in the smmus property.

(Assuming that #smmu-cells in the SMMU is <1>)

HW that issues with 1 stream ID:

	smmus = <&smmu 123>;

HW that issues with 2 stream IDs:

	smmus = <&smmu 123 &smmu 345>;

>   2.) It moves SMMU-specific data out to the device, which makes it

Yes, but I think it's really SMMU-client-specific data not
SMMU-specific. The SMMU doesn't dictate the stream IDs that "clients"
include with their transactions; the "client" HW dictates that.

>       impossible to describe more complicated topologies where IDs can be
>       remapped/remastered, potentially by multiple SMMUs and/or bus bridges.

I don't think so.

The SMMU "clients" can indicate what stream IDs they use to issue
transactions.

The SMMU DT node or driver itself can still include a table that
describes how it re-writes those stream IDs when forwarding transactions
to the next step. I don't believe there's any requirement that the SMMU
list all its clients and this mapping table in the same property. So,
the SMMU could easily have:

(entries are this SMMU's #stream-id-cells, assumed to be 1 here, then
the next SMMU's #stream-id-cells, assumed to be 2 here)

	smmu-stream-id-translations =
		<123 1 987>,
		<345 0 765>;

> When writing the binding for the ARM SMMU driver, I originally started with
> something similar to what you're suggesting, but was later forced down a
> different route when I realised what sort of systems were being built.
> 
> We will have similar problems for PCIe RIDs and GIC DIDs (I spoke about this
> at the ARM mini-summit). They are not fixed across the system: they
> originate from a device, but can change as they traverse the system
> topology.
