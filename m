From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 03/22] ARM: tegra: Create a DT header defining swgroups
 ID
Date: Mon, 29 Jul 2013 11:45:15 -0600
Message-ID: <51F6AA2B.7050509@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><1373021097-32420-4-git-send-email-hdoyu@nvidia.com><51E5D220.1070708@wwwdotorg.org> <20130729.135336.943359637886118972.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130729.135336.943359637886118972.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/29/2013 04:53 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 17 Jul 2013 01:07:12 +0200:
> 
>> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
>>> Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
>>> binding. "swgroup" is a group of H/W clients in Tegra SoC from S/W POV.
>>>
>>> This will allow the same header to be used by both device tree files,
>>> and drivers implementing this binding, which guarantees that the two
>>> stay in sync. This also makes device trees more readable by using names
>>> instead of magic numbers.
>>
>> Why does the driver need these constants; shouldn't it simply support
>> 0..n SW group IDs that all work the same way? Or, is there some reason
>> for it to know the identities?
>>
>>> diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h
>>
>> s/memory/iommu/?
> 
> This info would be used in PMC code as well, which H/W belongs to
> which swgroup. So I use the term "memory(-client)" instead of "iommu".

Why does the PMC care? An explanation of exactly what SW needs to know
about these groups and why would be a good idea.

>> s/tegra-swgroup.h/tegra-smmu.h/?
> 
> Is "tegra-memory-clients.h" preferable, then?

Perhaps, although aren't these IDs specific to the connection between
modules and the SMMU? Or, are these IDs some more global concept; the HW
modules in question pass the same IDs to both the SMMU and to other HW
modules for some reason?

>>> +#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
>>> +
>>> +#define TEGRA30_SWGROUP_ALL	<0x00000000 0x000779ff>
>>> +#define TEGRA114_SWGROUP_ALL	<0x00000000 0x01b659fe>
>>
>> Are those 3 values needed by DT files, or just the driver?
> 
> Only from DT.

If the values are only needed to write the DT content, I'd tend to
prefer not defining them in a header in <dt-bindings/>; I consider that
directory a definition of the constants that define the ABI itself, not
as a random place to put useful things for DT. You can include headers
in the *.dts directory itself.
