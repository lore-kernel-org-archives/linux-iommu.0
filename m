From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Date: Tue, 24 Jul 2018 12:30:35 +0100
Message-ID: <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
 <5B568D5B.5050606@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5B568D5B.5050606@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Baolu,

On 24/07/18 03:22, Lu Baolu wrote:
> Hi,
> 
> On 07/23/2018 12:44 PM, Liu, Yi L wrote:
>>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>>> Sent: Sunday, July 22, 2018 2:09 PM
>>>
>>> With the Intel IOMMU supporting PASID granularity isolation and protection, a
>>> mediated device could be isolated and protected by an IOMMU unit. We need to
>>> allocate a new group instead of a PCI group.
>> Existing vfio mdev framework also allocates an iommu group for mediate device.
>>
>> mdev_probe()
>>   |_ mdev_attach_iommu()
>>        |_ iommu_group_alloc()
> 
> When external components ask iommu to allocate a group for a device,
> it will call pci_device_group in Intel IOMMU driver's @device_group
> callback. In another word, current Intel IOMMU driver doesn't aware
> the mediated device and treat all devices as PCI ones. This patch
> extends the @device_group call back to make it aware of a mediated
> device.

I agree that allocating two groups for an mdev seems strange, and in my
opinion we shouldn't export the notion of mdev to IOMMU drivers.
Otherwise each driver will have to add its own "dev_is_mdev()" special
cases, which will get messy in the long run. Besides, the macro is
currently private, and to be exported it should be wrapped in
symbol_get/put(mdev_bus_type).

There is another way: as we're planning to add a generic pasid_alloc()
function to the IOMMU API, the mdev module itself could allocate a
default PASID for each mdev by calling pasid_alloc() on the mdev's
parent, and then do map()/unmap() with that PASID. This way we don't
have to add IOMMU ops to the mdev bus, everything can still be done
using the ops of the parent. And IOMMU drivers "only" have to implement
PASID ops, which will be reused by drivers other than mdev.

The allocated PASID also needs to be installed into the parent device.
If the mdev module knows the PASID, we can do that by adding
set_pasid(mdev, pasid) and clear_pasid(mdev, pasid) operations to
mdev_parent_ops.

Thanks,
Jean
