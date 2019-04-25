From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
Date: Thu, 25 Apr 2019 09:40:31 +0200
Message-ID: <c847182b-6e5c-5344-a162-29e273a489fb@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
 <143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
 <A2975661238FB949B60364EF0F2C257439E840F5@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439E840F5@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Liu,

On 4/25/19 9:12 AM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: Thursday, April 25, 2019 1:28 AM
>> To: Jacob Pan <jacob.jun.pan@linux.intel.com>; iommu@lists.linux-foundation.org;
>> Subject: Re: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
>>
>> Hi Jacob,
>>
>> On 4/24/19 1:31 AM, Jacob Pan wrote:
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>
>>> If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the IOMMU
>>> driver should rely on the emulation software to allocate and free
>>> PASID IDs.
>> Do we make the decision depending on the CM or depending on the VCCAP_REG?
>>
>> VCCAP_REG description says:
>>
>> If Set, software must use Virtual Command Register interface to allocate and free
>> PASIDs.
> 
> The answer is it depends on the ECAP.VCS and then the PASID allocation bit in
> VCCAP_REG. But VCS bit implies the iommu is a software implementation
> (vIOMMU) of vt-d architecture. Pls refer to the descriptions of "Virtual
> Command Support" in vt-d 3.0 spec.
> 
> "Hardware implementations of this architecture report a value of 0
> in this field. Software implementations (emulation) of this
> architecture may report VCS=1."

OK I understand. But strictly speaking a vIOMMU may not implement CM.
But that's nitpicking ;-)

Thanks

Eric
> 
> Thanks,
> Yi Liu
> 
