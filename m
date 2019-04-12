From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 0/9] vfio/mdev: IOMMU aware mediated device
Date: Fri, 12 Apr 2019 09:36:49 +0800
Message-ID: <0beedc65-fc26-5f17-6f0f-6e0c0aa022a3@linux.intel.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
 <20190411151917.GA29810@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411151917.GA29810@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, xin.zeng@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 4/11/19 11:19 PM, Joerg Roedel wrote:
> Hi Lu Baolu,
> 
> thanks for these patches!
> 
> On Mon, Mar 25, 2019 at 09:30:27AM +0800, Lu Baolu wrote:
>> Lu Baolu (9):
>>    iommu: Add APIs for multiple domains per device
>>    iommu/vt-d: Make intel_iommu_enable_pasid() more generic
>>    iommu/vt-d: Add per-device IOMMU feature ops entries
>>    iommu/vt-d: Move common code out of iommu_attch_device()
>>    iommu/vt-d: Aux-domain specific domain attach/detach
>>    iommu/vt-d: Return ID associated with an auxiliary domain
> 
> I applied the patches above to my tree. The first patch is in a new
> branch called 'api-features' and the other are in the x86/vt-d branch.

Thank you!

> 
>>    vfio/mdev: Add iommu related member in mdev_device
>>    vfio/type1: Add domain at(de)taching group helpers
>>    vfio/type1: Handle different mdev isolation type
> 
> Can you please address the minor concern on these patches, add all
> review and acks and re-send?

Sure. I will resend these soon.

> 
> Thanks,
> 
> 	Joerg

Best regards,
Lu Baolu
