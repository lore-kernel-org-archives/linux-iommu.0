From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v2] iommu: Add event tracing feature to iommu
Date: Tue, 30 Jul 2013 14:18:20 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6174E456@sisaex01sj>
References: <1375147366-2922-1-git-send-email-shuah.kh@samsung.com>
 <1375147768.2075.91.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "tony@atomide.com" <tony@atomide.com>, "ohad@wizery.com" <ohad@wizery.com>, "andreas.herrmann@calxeda.com" <andreas.herrmann@calxeda.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 07/29/2013 07:30 PM, Joe Perches wrote:
> On Mon, 2013-07-29 at 19:22 -0600, Shuah Khan wrote:
>> Add tracing feature to iommu to report various iommu events. Classes
>> iommu_group, iommu_device, iommu_map_unmap, and iommu_amd_event are defined.
>
> Hi again Shuah
>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> []
>> @@ -2159,6 +2160,15 @@ static int iommu_prepare_identity_map(struct pci_dev *pdev,
>>   	printk(KERN_INFO
>>   	       "IOMMU: Setting identity map for device %s [0x%Lx - 0x%Lx]\n",
>>   	       pci_name(pdev), start, end);
>> +
>> +	{
>> +		trace_amd_event("Event", 0x1, pdev->devfn, 0, start, 2);
>> +		trace_remove_device_from_group(0, &pdev->dev);
>> +		trace_attach_device_to_domain(&pdev->dev);
>> +		trace_detach_device_from_domain(&pdev->dev);
>> +		trace_map(start, end, 1024);
>> +		trace_unmap(start, end, 1024);
>> +	}
>
> Aren't these parentheses superfluous and
> so the indent too deep too?
>

Hi Joe,

That is the test code, I included by mistake. I had these changes 
sitting uncommitted in my tree for testing and I accidentally generated 
the patch with them. I am going to send a patch without this file.

I should remember to not rush things at the end of day and create noise. :(

-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
