From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 9/9] vfio/type1: Handle different mdev isolation type
Date: Wed, 20 Mar 2019 13:52:52 +0800
Message-ID: <939783f6-95e5-1413-8a2a-0e17c71110ef@linux.intel.com>
References: <20190222021927.13132-1-baolu.lu@linux.intel.com>
 <20190222021927.13132-10-baolu.lu@linux.intel.com>
 <20190307084453.GA9288@nvidia.com> <20190307165623.1834cc93@w520.home>
 <20190308180317.GA30821@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308180317.GA30821@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Neo Jia <cjia@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, xin.zeng@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Neo,

On 3/9/19 2:03 AM, Neo Jia wrote:
> On Thu, Mar 07, 2019 at 04:56:23PM -0700, Alex Williamson wrote:
>> On Thu, 7 Mar 2019 00:44:54 -0800
>> Neo Jia <cjia@nvidia.com> wrote:
>>
>>> On Fri, Feb 22, 2019 at 10:19:27AM +0800, Lu Baolu wrote:
>>>> This adds the support to determine the isolation type
>>>> of a mediated device group by checking whether it has
>>>> an iommu device. If an iommu device exists, an iommu
>>>> domain will be allocated and then attached to the iommu
>>>> device. Otherwise, keep the same behavior as it is.
>>>>
>>>> Cc: Ashok Raj <ashok.raj@intel.com>
>>>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>>>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>>> ---
>>>>   drivers/vfio/vfio_iommu_type1.c | 48 ++++++++++++++++++++++++++++-----
>>>>   1 file changed, 41 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index ccc4165474aa..f1392c582a3c 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -1368,13 +1368,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
>>>>   		iommu_detach_group(domain->domain, group->iommu_group);
>>>>   }
>>>>     
>>>
>>> Hi Baolu,
>>>
>>> To allow IOMMU-awared mdev, I think you need to modify the
>>> vfio_iommu_type1_pin_pages and vfio_iommu_type1_unpin_pages to remove the
>>> iommu->external_domain check.
>>>
>>> Could you please include that in your patch? If not, I can send out a separate
>>> patch to address that issue.
>>
>> I figured it was intentional that an IOMMU backed mdev would not use
>> the pin/unpin interface and therefore the exiting -EINVAL returns would
>> be correct.  Can you elaborate on the use case for still requiring the
>> mdev pin/unpin interface for these devices?  Thanks,
> 
> Sure. We are using this api to fetch a pfn of a guest physical address so we can
> access it for PV.

Okay, I will remove these two checks in the next version.

Best regards,
Lu Baolu
