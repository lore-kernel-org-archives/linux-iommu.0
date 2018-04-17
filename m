From: "Hook, Gary" <ghook@amd.com>
Subject: Re: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
Date: Tue, 17 Apr 2018 14:06:47 -0400
Message-ID: <e5e8c59f-ebaa-1b87-713a-ee9ab9c3b5d1@amd.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
 <1523663790.2747.4.camel@intel.com>
 <10e422dd-a3ca-8ecb-50fa-e7f131a55a12@amd.com>
 <80b1e9e5-3048-391a-6d7d-adeeece1bf46@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80b1e9e5-3048-391a-6d7d-adeeece1bf46@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "gary.hook@amd.com" <gary.hook@amd.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 4/17/2018 1:55 PM, Robin Murphy wrote:
> On 17/04/18 18:36, Hook, Gary wrote:
>> On 4/13/2018 7:55 PM, Mehta, Sohil wrote:
>>> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>>> +struct dentry *iommu_debugfs_setup(void)
>>>> +{
>>>> +    if (!debugfs_initialized())
>>>
>>> This check is probably not needed.
>>
>> Ah, so it isn't. Thank you.
>>
>>>
>>>> +        return NULL;
>>>> +
>>>> +    if (!iommu_debugfs_dir)
>>>> +        iommu_debugfs_dir = debugfs_create_dir("iommu",
>>>> NULL);
>>>> +
>>>> +    if (iommu_debugfs_dir)
>>>> +        pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN
>>>> ENABLED IN THIS KERNEL\n");
>>>> +
>>>
>>> As this gets called for each IOMMU, do you want to use pr_warn_once?
>>
>> That works, yes.
> 
> Or I guess you could just roll the pr_warn() into the previous if() 
> condition, i.e. only warn when the singleton debugfs_dir is actually 
> created.

That makes more sense for a code path this isn't going to be hit more 
than a few times at most.

> 
> Robin.
> 
>>
>>>
>>>> +    return iommu_debugfs_dir;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(iommu_debugfs_setup);
>>>
>>> -Sohil
>>>
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
