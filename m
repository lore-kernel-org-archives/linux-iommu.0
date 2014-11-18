From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [Patch Part3 V7 0/8] Enable support of Intel DMAR device hotplug
Date: Tue, 18 Nov 2014 20:57:45 +0800
Message-ID: <546B4249.7050502@linux.intel.com>
References: <1415544483-27990-1-git-send-email-jiang.liu@linux.intel.com> <20141118102537.GB3762@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20141118102537.GB3762@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Ashok Raj <ashok.raj@intel.com>, Yijing Wang <wangyijing@huawei.com>, Tony Luck <tony.luck@intel.com>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 2014/11/18 18:25, Joerg Roedel wrote:
> Hi Jiang,
> 
> On Sun, Nov 09, 2014 at 10:47:55PM +0800, Jiang Liu wrote:
>> Jiang Liu (8):
>>   iommu/vt-d: Introduce helper function dmar_walk_resources()
>>   iommu/vt-d: Dynamically allocate and free seq_id for DMAR units
>>   iommu/vt-d: Implement DMAR unit hotplug framework
>>   iommu/vt-d: Search for ACPI _DSM method for DMAR hotplug
>>   iommu/vt-d: Enhance intel_irq_remapping driver to support DMAR unit
>>     hotplug
>>   iommu/vt-d: Enhance error recovery in function
>>     intel_enable_irq_remapping()
>>   iommu/vt-d: Enhance intel-iommu driver to support DMAR unit hotplug
>>   pci, ACPI, iommu: Enhance pci_root to support DMAR device hotplug
>>
>>  drivers/acpi/pci_root.c             |   16 +-
>>  drivers/iommu/dmar.c                |  532 ++++++++++++++++++++++++++++-------
>>  drivers/iommu/intel-iommu.c         |  297 ++++++++++++++-----
>>  drivers/iommu/intel_irq_remapping.c |  249 ++++++++++++----
>>  include/linux/dmar.h                |   50 +++-
>>  5 files changed, 897 insertions(+), 247 deletions(-)
> 
> The patches look good, but I need an ack from PCI/ACPI for patch 8
> before I can merge it. Patches 1-7 are applied.
Hi Joerg,
	Thanks for support:)
	Bjorn has given his acked-by for v6 at
https://lkml.org/lkml/2014/9/24/975. But I forgot to carry this
acked-by, sorry:(
Regards!
Gerry
> 
> Thanks,
> 
> 	Joerg
> 
