From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Enable PASID only if device expects
 PASID in PRG Response.
Date: Wed, 13 Feb 2019 10:19:59 -0800
Message-ID: <14576cce-b529-5ce2-b122-7f81998811be@linux.intel.com>
References: <cover.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <787d13ae22ae07c708b06180241f4f2b71031f84.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19C93AD90@SHSMSX104.ccr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C93AD90@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Tian, Kevin" <kevin.tian@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org" <joro@8bytes.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Busch, Keith" <keith.busch@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
List-Id: iommu@lists.linux-foundation.org


On 2/13/19 12:26 AM, Tian, Kevin wrote:
>> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
>> bounces@lists.linux-foundation.org] On Behalf Of
>> sathyanarayanan.kuppuswamy@linux.intel.com
>> Sent: Tuesday, February 12, 2019 5:51 AM
>> To: bhelgaas@google.com; joro@8bytes.org; dwmw2@infradead.org
>> Cc: Raj, Ashok <ashok.raj@intel.com>; linux-pci@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Busch, Keith <keith.busch@intel.com>;
>> iommu@lists.linux-foundation.org; Pan, Jacob jun
>> <jacob.jun.pan@intel.com>
>> Subject: [PATCH v2 2/2] iommu/vt-d: Enable PASID only if device expects
>> PASID in PRG Response.
>>
>> From: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> In Intel IOMMU, if the Page Request Queue (PRQ) is full, it will
>> automatically respond to the device with a success message as a keep
>> alive. And when sending the success message, IOMMU will include PASID in
>> the Response Message when the Page Request has a PASID in Request
>> Message and It does not check against the PRG Response PASID
>> requirement
>> of the device before sending the response. Also, If the device receives the
>> PRG response with PASID when its not expecting it then the device behavior
>> is undefined. So enable PASID support only if device expects PASID in PRG
>> response message.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Keith Busch <keith.busch@intel.com>
>> Suggested-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 1457f931218e..af2e4a011787 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1399,7 +1399,8 @@ static void iommu_enable_dev_iotlb(struct
>> device_domain_info *info)
>>   	   undefined. So always enable PASID support on devices which
>>   	   have it, even if we can't yet know if we're ever going to
>>   	   use it. */
>> -	if (info->pasid_supported && !pci_enable_pasid(pdev, info-
>>> pasid_supported & ~1))
>> +	if (info->pasid_supported && pci_prg_resp_pasid_required(pdev)
>> &&
>> +	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
>>   		info->pasid_enabled = 1;
> Above logic looks problematic. As Dave commented in another thread,
> PRI and PASID are orthogonal capabilities. Especially with introduction
> of VT-d scalable mode, PASID will be used alone even w/o PRI...
>
> Why not doing the check when PRI is actually enabled? At that point
> you can fail the request if above condition is false.
yes, makes sense. I will fix it in next version.
>
>>   	if (info->pri_supported && !pci_reset_pri(pdev)
>> && !pci_enable_pri(pdev, 32))
>> --
>> 2.20.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
