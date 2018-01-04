From: Gary R Hook <gary.hook@amd.com>
Subject: Re: [PATCH V4 11/26] iommu/amd: deprecate pci_get_bus_and_slot()
Date: Thu, 4 Jan 2018 11:25:46 -0600
Message-ID: <cc2ddf75-75bd-df46-3e9d-ed6b334200fd@amd.com>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-12-git-send-email-okaya@codeaurora.org>
 <8a5dad82-2886-2a51-28bc-b84ab253c361@codeaurora.org>
 <46ccdb85-1c23-c9eb-994c-9a66e6fce7cc@amd.com>
 <9014a9e1-9545-4f3c-08c2-8e8eb4762101@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <9014a9e1-9545-4f3c-08c2-8e8eb4762101@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, linux-arm-kernel@lists.infradead.org, open list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 01/04/2018 10:32 AM, Sinan Kaya wrote:
> On 1/4/2018 11:28 AM, Gary R Hook wrote:
>> On 01/04/2018 06:25 AM, Sinan Kaya wrote:
>>> On 12/19/2017 12:37 AM, Sinan Kaya wrote:
>>>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>>>> where a PCI device is present. This restricts the device drivers to be
>>>> reused for other domain numbers.
>>>>
>>>> Getting ready to remove pci_get_bus_and_slot() function in favor of
>>>> pci_get_domain_bus_and_slot().
>>>>
>>>> Hard-code the domain number as 0 for the AMD IOMMU driver.
>>
>> <snip>
>>
>>>
>>> Any comments from the IOMMU people?
>>>
>>
>> pci_get_bus_and_slot() appears to (now) be a convenience function that wraps pci_get_domain_bus_and_slot() while using a 0 for the domain value. Exactly what you are doing here, albeit in a more overt way.
>>
>> How is this patch advantageous? Seems to me that if other domains need to be enabled, that driver could be changed if and when that requirement arises.
>>
>> But perhaps I'm missing a nuance here.
>>
>>
> 
> The benefit of the change was discussed here:
> 
> https://lkml.org/lkml/2017/12/19/349
> 
> I hope it helps.
> 
> 

Thank you for pointing out that thread directly. I read through it and 
thought further about this change.

I am not the maintainer, but as an AMD developer, this is fine change. I 
can't ACK but I can agree.

Gary
