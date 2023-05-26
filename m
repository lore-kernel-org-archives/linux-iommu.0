Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD41C26
	for <iommu@lists.linux.dev>; Fri, 26 May 2023 04:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685075145; x=1716611145;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rnYAPF5QRecUV0o1s+Lp3V0Rv6Hpp5boRWupRwxXQ5o=;
  b=I4R7h3/VXzSSL4wfPsLSQoWduyQNBmC2DVIhNu085eldm3XNS0aboX2B
   7Mg6UGSi5KxjLFWEg2GJx+s2YX+4pcmpPbKVg2jCKq9vp9KobTJHYS7wg
   mV93fjkW2wWZZBnpABKIuJYhNmxkB/9g3aEntb3qIa6tvdd8LVVMJPUS3
   Uhm47FW5v3YBbzFRqeNU5HnJjkVRafwJtSXSKo1QIxv0d2yvkuZSaHAAY
   8nDJ00/lEAXmA9deUPEOWeo62RsKFbVpYW4gE69dqQxNwpiqoW2Idt8r1
   aBbBuz2KMkF29fbrf+M27U9TQz6YKUBpyjE2jwlPlBodRDCzY5gPFiRut
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="356495644"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="356495644"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 21:25:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="735845061"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="735845061"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga008.jf.intel.com with ESMTP; 25 May 2023 21:25:38 -0700
Message-ID: <a968f730-4161-617c-e386-a7ff8532adc9@linux.intel.com>
Date: Fri, 26 May 2023 12:24:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 06/10] iommu/vt-d: Set the nested domain to a device
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-7-yi.l.liu@intel.com>
 <BN9PR11MB52765BB617AB5611A8B54D328C419@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52765BB617AB5611A8B54D328C419@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/23 3:22 PM, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, May 11, 2023 10:51 PM
>>
>> +
>> +static int intel_nested_attach_dev(struct iommu_domain *domain,
>> +				   struct device *dev)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	if (info->domain)
>> +		device_block_translation(dev);
>> +
>> +	/* Is s2_domain compatible with this IOMMU? */
>> +	ret = prepare_domain_attach_device(&dmar_domain->s2_domain-
>>> domain, dev);
>> +	if (ret) {
>> +		dev_err_ratelimited(dev, "s2 domain is not compatible\n");
>> +		return ret;
>> +	}
> 
> this also includes logic to trim higher page levels:
> 
> 	/*
> 	 * Knock out extra levels of page tables if necessary
> 	 */
> 	while (iommu->agaw < dmar_domain->agaw) {
> 		struct dma_pte *pte;
> 
> 		pte = dmar_domain->pgd;
> 		if (dma_pte_present(pte)) {
> 			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
> 			free_pgtable_page(pte);
> 		}
> 		dmar_domain->agaw--;
> 	}
> 
> What's the background of doing such truncation instead of simply
> failing the request?

This code existed a long time ago. I'm not sure if it's still reasonable
so far.

> In any means it's probably fine before the domain includes any mapping
> but really unreasonable to apply it to an existing s2 when it's used as
> a parent.

But for the new nested translation, it is obviously unreasonable.

Let me revisit it.

Best regards,
baolu
