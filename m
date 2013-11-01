From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 15/19] ARM: tegra: Create a DT header defining SWGROUP ID
Date: Fri, 01 Nov 2013 10:05:57 -0600
Message-ID: <5273D165.7080800@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>	<1382092020-13170-16-git-send-email-hdoyu@nvidia.com>	<52718CC6.5@wwwdotorg.org>	<20131031.101942.530833331841957251.hdoyu@nvidia.com>	<20131031174606.GG3037@kartoffel>
	<20131101100605.2a29eac5b5ba8719a0beb276@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131101100605.2a29eac5b5ba8719a0beb276-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/01/2013 02:06 AM, Hiroshi Doyu wrote:
> On Thu, 31 Oct 2013 18:46:06 +0100
> Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> 
>> On Thu, Oct 31, 2013 at 08:19:42AM +0000, Hiroshi Doyu wrote:
>>> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 30 Oct 2013 23:48:38 +0100:
>>>
>>>> On 10/18/2013 04:26 AM, Hiroshi Doyu wrote:
>>>>> Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
>>>>> binding. "swgroups" is a group of H/W clients which Tegra SoCs
>>>>> support. This unique ID can be used to calculate MC_SMMU_<swgroup
>>>>> name>_ASID_0 register offset and MC_<swgroup name>_HOTRESET_*_0
>>>>> register bit. This will allow the same header to be used by both
>>>>> device tree files, and drivers implementing this binding, which
>>>>> guarantees that the two stay in sync. This also makes device trees
>>>>> more readable by using names instead of magic numbers.
>>>>
>>>>> diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h
>>>>
>>>>> +#define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
>>>>> +
>>>>> +#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
>>>>
>>>> Isn't the DT match all 32-bit, such that the ULL suffix does nothing,
>>>
>>> For the future Tegra SoC, the number of HWA grows a bit more, and it's
>>> supposed that "64" would be enough.
>>
>> Does DTC accept 64-bit values as-is? I recall DTC shouting at me in the past,
>> and having to split values across two u32 cells (i.e. <0xffffffff 0xffffffff>
>> rather than <0xffffffffffffffff>).
> 
> TEGRA_SWGROUP_BIT was only used in driver code since DT couldn't handle OR("|").
> 
> Stephen pointed out the latest DT can do. So this macro should be
> revised to be used in DTS as well.

One note: If there was no intention to use the #defines in
<dt-bindings/memory/tegra-swgroup.h> in the DT before, that header
shouldn't have been in the <dt-bindings> directory. That said, given the
bug is really that the DT wasn't using the header but should have been,
fixing the DT is the right way to go.
