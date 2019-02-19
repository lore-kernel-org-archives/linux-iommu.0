From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 0/9] vfio/mdev: IOMMU aware mediated device
Date: Tue, 19 Feb 2019 10:46:28 +0800
Message-ID: <0d702a80-4114-533e-f4be-235f54e659c0@linux.intel.com>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
 <20190214131456.3db38cdb@w520.home>
 <20e89cb0-b7ab-d0d7-8630-29ff512a4ef0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20e89cb0-b7ab-d0d7-8630-29ff512a4ef0@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>, "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "yi.y.sun@intel.com" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

On 2/16/19 2:46 AM, Jean-Philippe Brucker wrote:
> On 14/02/2019 20:14, Alex Williamson wrote:
>>> This patch series extends both IOMMU and vfio components to support
>>> mdev device passing through when it could be isolated and protected
>>> by the IOMMU units. The first part of this series (PATCH 1/09~6/09)
>>> adds the interfaces and implementation of the multiple domains per
>>> device. The second part (PATCH 7/09~9/09) adds the iommu device
>>> attribute to each mdev, determines isolation type according to the
>>> existence of an iommu device when attaching group in vfio type1 iommu
>>> module, and attaches the domain to iommu aware mediated devices.
>>>
>>> References:
>>> [1] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
>>> [2] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
>>> [3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
>>>
>>> Best regards,
>>> Lu Baolu
>>>
>>> Change log:
>>>     v5->v6:
>>
>> This looks pretty reasonable with Jean-Philippe's nit fixups.  Where do
>> we go from here?  I think we need an ack from Kirti since they have an
>> interest here.  Presumably this looks ok to the ARM folks.
> 
> Looks great from my point of view. I focused on patch 1 since I'm
> planning to reuse iommu_dev_features for SVA. I don't have time to test
> auxd and mdev on SMMUv3 at the moment but I had a better look and, if it
> helps, for patches 1 and 7-9:
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Thank you! I will add this in the next version.

> 
> That said, are you planning to add back the mdev_get_iommu_domain()
> function, in a separate patch? Because I think the parent driver still
> needs a way to retrieve the PASID for an mdev?

Yes.

As Kirti's suggestion, we removed this since there is currently no
consumer yet. We will bring it back together with the real consumer.

https://lkml.org/lkml/2018/11/16/124

Best regards,
Lu Baolu

> 
> Thanks,
> Jean
> 
>> Do we have
>> any consumers of this code yet?  Theoretically I think a vfio-pci-like
>> meta driver could be written as an mdev vendor driver with this support
>> (restricted to type1 iommu use cases).  Thanks,
>>
>> Alex
> 
> 
