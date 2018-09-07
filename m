From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/12] iommu/vt-d: Pass pasid table to context mapping
Date: Fri, 7 Sep 2018 10:13:16 +0800
Message-ID: <cbf798c6-180a-1c57-64c2-7713803eb888@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-9-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2C7A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2C7A@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/06/2018 11:17 AM, Tian, Kevin wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Thursday, August 30, 2018 9:35 AM
>>
>> So that the pasid related info, such as the pasid table and the
>> maximum of pasid could be used during setting up scalable mode
>> context.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 

Thank you, Kevin.

Best regards,
Lu Baolu

>> ---
>>   drivers/iommu/intel-iommu.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index c3bf2ccf094d..33642dd3d6ba 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1942,6 +1942,7 @@ static void domain_exit(struct dmar_domain
>> *domain)
>>
>>   static int domain_context_mapping_one(struct dmar_domain *domain,
>>   				      struct intel_iommu *iommu,
>> +				      struct pasid_table *table,
>>   				      u8 bus, u8 devfn)
>>   {
>>   	u16 did = domain->iommu_did[iommu->seq_id];
>> @@ -2064,6 +2065,7 @@ static int domain_context_mapping_one(struct
>> dmar_domain *domain,
>>   struct domain_context_mapping_data {
>>   	struct dmar_domain *domain;
>>   	struct intel_iommu *iommu;
>> +	struct pasid_table *table;
>>   };
>>
>>   static int domain_context_mapping_cb(struct pci_dev *pdev,
>> @@ -2072,25 +2074,31 @@ static int domain_context_mapping_cb(struct
>> pci_dev *pdev,
>>   	struct domain_context_mapping_data *data = opaque;
>>
>>   	return domain_context_mapping_one(data->domain, data-
>>> iommu,
>> -					  PCI_BUS_NUM(alias), alias & 0xff);
>> +					  data->table, PCI_BUS_NUM(alias),
>> +					  alias & 0xff);
>>   }
>>
>>   static int
>>   domain_context_mapping(struct dmar_domain *domain, struct device
>> *dev)
>>   {
>> +	struct domain_context_mapping_data data;
>> +	struct pasid_table *table;
>>   	struct intel_iommu *iommu;
>>   	u8 bus, devfn;
>> -	struct domain_context_mapping_data data;
>>
>>   	iommu = device_to_iommu(dev, &bus, &devfn);
>>   	if (!iommu)
>>   		return -ENODEV;
>>
>> +	table = intel_pasid_get_table(dev);
>> +
>>   	if (!dev_is_pci(dev))
>> -		return domain_context_mapping_one(domain, iommu, bus,
>> devfn);
>> +		return domain_context_mapping_one(domain, iommu,
>> table,
>> +						  bus, devfn);
>>
>>   	data.domain = domain;
>>   	data.iommu = iommu;
>> +	data.table = table;
>>
>>   	return pci_for_each_dma_alias(to_pci_dev(dev),
>>   				      &domain_context_mapping_cb, &data);
>> --
>> 2.17.1
> 
> 
