From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: AMD-Vi: Unable to write to IOMMU perf counter.
Date: Thu, 4 Feb 2016 12:11:52 -0600
Message-ID: <56B39468.7080902@amd.com>
References: <56B365E0.4020100@01019freenet.de> <56B37292.1000201@amd.com>
 <56B39009.90401@maya.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <56B39009.90401@maya.org>
Sender: linux-pci-owner@vger.kernel.org
To: Andreas Hartmann <andihartmann@freenet.de>, linux-pci@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <helgaas@kernel.org>, iommu <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On 2/4/2016 11:53 AM, Andreas Hartmann wrote:
> On 02/04/2016 at 04:47 PM, Suravee Suthikulanit wrote:
>> Hi Andreas,
>>
>> On 2/4/2016 8:53 AM, Andreas Hartmann wrote:
>>> Hello!
>>>
>>> The following happens with Linux 4.4.1 during boot on an MSI A78M-E35
>>> board. Additionally, I attached the complete dmesg.
>>
>> I was working on upstreaming changes to the AMD IOMMU Perf to fix some
>> of the similar issue I saw on a different platform.  Would you please
>> check to see if this patch series would fix this?
>>
>> https://lkml.org/lkml/2016/1/1/141
>
>
> This patchset seems to fix the problem.
>
> [    1.264639] AMD-Vi: IOMMU performance counters supported
>
> But there seems to be a problem with the location of
> perf_event_amd_iommu.h in the patch - I had to fix the complete
> perf_event_amd_iommu.h related patches to get them applied to 4.4. and
> finally compiled.
>
>
> Thanks,
> Andreas
>

Ok, I'll clean up and resend this patch series. Thanks for testing.

Thanks,
Suravee
