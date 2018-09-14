From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Date: Fri, 14 Sep 2018 10:46:32 +0800
Message-ID: <4b24f0c6-5985-efbc-f842-8bde239dfc2a@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
 <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
 <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: baolu.lu@linux.intel.com, "kevin.tian@intel.com" <kevin.tian@intel.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yi.y.sun@intel.com" <yi.y.sun@intel.com>, "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/13/2018 01:54 AM, Jean-Philippe Brucker wrote:
> On 12/09/2018 03:42, Lu Baolu wrote:
>> Hi,
>>
>> On 09/11/2018 12:22 AM, Jean-Philippe Brucker wrote:
>>> Hi,
>>>
>>> On 30/08/2018 05:09, Lu Baolu wrote:
>>>> Below APIs are introduced in the IOMMU glue for device drivers to use
>>>> the finer granularity translation.
>>>>
>>>> * iommu_capable(IOMMU_CAP_AUX_DOMAIN)
>>>>     - Represents the ability for supporting multiple domains per device
>>>>       (a.k.a. finer granularity translations) of the IOMMU hardware.
>>> iommu_capable() cannot represent hardware capabilities, we need
>>> something else for systems with multiple IOMMUs that have different
>>> caps. How about iommu_domain_get_attr on the device's domain instead?
>> Domain is not a good choice for per iommu cap query. A domain might be
>> attached to devices belonging to different iommu's.
>>
>> How about an API with device structure as parameter? A device always
>> belongs to a specific iommu. This API is supposed to be used the
>> device driver.
> Ah right, domain attributes won't work. Your suggestion seems more
> suitable, but maybe users can simply try to enable auxiliary domains
> first, and conclude that the IOMMU doesn't support it if it returns an error
> 

Some driver might want to check whether hardware supports AUX_DOMAIN
during the driver probe stage, but doesn't want to enable AUX_DOMAIN
at that time. One reasonable use case is driver check AUX_DOMAIN cap
during driver probe and expose different sysfs nodes according to
whether AUX_DOMAIN is support or not, then AUX_DOMAIN is enabled or 
disabled during run time through a sysfs node. With this consideration,
we still need a API to check cap.

How about

* iommu_check_aux_domain(struct device *dev)
    - Check whether the iommu driver supports multiple domains on @dev.

Best regards,
Lu Baolu
