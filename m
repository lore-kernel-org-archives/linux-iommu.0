From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 01/12] iommu/vt-d: Enumerate the scalable mode
 capability
Date: Thu, 6 Sep 2018 10:25:56 +0800
Message-ID: <43811e92-f3d4-82a7-87a7-f5bcbf9a13f4@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-2-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A40@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A40@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/06/2018 09:55 AM, Tian, Kevin wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Thursday, August 30, 2018 9:35 AM
>>
>> The Intel vt-d spec rev3.0 introduces a new translation
>> mode called scalable mode, which enables PASID-granular
>> translations for first level, second level, nested and
>> pass-through modes. At the same time, the previous
>> Extended Context (ECS) mode is deprecated (no production
>> ever implements ECS).
>>
>> This patch adds enumeration for Scalable Mode and removes
>> the deprecated ECS enumeration. It provides a boot time
>> option to disable scalable mode even hardware claims to
>> support it.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 

Thank you, Kevin.

Best regards,
Lu Baolu
