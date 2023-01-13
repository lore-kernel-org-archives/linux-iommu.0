Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082536B
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 02:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673577406; x=1705113406;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IqVfhuFqv5rUQhwltDv+2kENmxlK+b+v2ArrLqBrib0=;
  b=ntXMhyZNuLehgft/WDcvTr5i2pkluu2yyHyJWOcMkTdhTPrqENAEx/Cx
   Q+ywHx8BlpbwkpHw98PB9X84fP0QnRQcdzNuxLO6CBgnkDUg//mE56W8Z
   jx9X5DxynUVC4HF3iGF7KvRinQrn6Wr9QnUXfuo68KjDgPh4tPXSOh9Tp
   evXpsNugD25vJ+2sYo5pIS3JKaQDKwhOB82kiFE6Ce/jqALbWI86fEtir
   U4yHA1Z5wpfqhCY5e8RRO+YAE97jR1JuTORS+YDa/hkTiggt0mmS8+W5V
   i1y1Jua5AxDB8SxJdr+dpA8qjzc1XFT4bSl3DuCHfgEpIKNOIqKyyYbFZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="303594045"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="303594045"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 18:36:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="986826340"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="986826340"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.252.189.78]) ([10.252.189.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 18:36:41 -0800
Message-ID: <3b2c162f-7ba2-5e84-2389-a8686c772467@linux.intel.com>
Date: Fri, 13 Jan 2023 10:36:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Vasant Hegde <vasant.hegde@amd.com>, "Zhu, Tony" <tony.zhu@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH v2 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, "Rodel, Jorg" <jroedel@suse.de>
References: <20230113014409.752405-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52765287D7C66D9CF52F143E8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52765287D7C66D9CF52F143E8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/13 10:24, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, January 13, 2023 9:44 AM
>>
>> One alternative is ATS which lets the device resolve the PASID+addr pair
>> before a memory request is made into a routeable TLB address through the
>> TA. Those resolved addresses are then cached on the device instead of
>> in the IOMMU TLB and the device always sets the translated bit for PASID.
>> One example of those devices are AMD graphic devices that always have ACS
>> or ATS enabled together with PASID.
> 
> this should be made clear that ATS alone doesn't imply that translated
> bit is always set. It's just an optimization so the device may cache
> translation for selective requests. Only combining with PRI to
> support SVA has such implication.
> 
>> + * @flags: device-specific flags
>> + *   - PCI_PASID_XLATED_REQ_ONLY: The PCI device only issues PASID
>> + *                                memory requests of translated type.
> 
> this reads like the device even doesn't issue non-PASID requests.
> 
> It is clearer to be "The PCI device always use translated type for all
> PASID memory requests".
> 
> Otherwise looks good to me:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Both make sense to me. It's updated. Thanks a lot!

--
Best regards,
baolu
