Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B287F
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663061444; x=1694597444;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=E7t2UOdY9wHDMf0CP0CgwG8FAmDq7eQIjFUMP5nR1Hw=;
  b=HDGTtLBioLylKmGx0vkVU/nUyHzRyEfkkPSVwuODfuLbAZFemRrYNv/U
   omwuqjbkSxUlnc/p2vg6D5JkYqJRlRt2HS8HM9ZwBECAQ/dIKXLzg74s0
   71odG6Xe/+TUiPFyrLqraPMCZbdsYqxFKGJEkLdvuCX++XuG8KX1JB6rl
   Gd8Yz7MEBFS7Xr+OsA0Cth9f4QmXSKrb4lwjLxomE78wqFpttpAAF38IE
   bg+O5fyuwdpKBeaaHQGp1SEnv61l73ql6HU0dxny6PJtk2Hfkml4fZzIM
   qu9F7eRfAIRceh/5dzLCs9/XD3W5ECbGbrYGQ+c9s11zr9BTqExpT8j3R
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298890121"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="298890121"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 02:30:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="646855920"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.188]) ([10.254.213.188])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 02:30:42 -0700
Message-ID: <e0c43ca7-0ad3-a4d6-960b-9853bb815438@linux.intel.com>
Date: Tue, 13 Sep 2022 17:30:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
In-Reply-To: <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ethan,

On 2022/9/13 15:46, Ethan Zhao wrote:
> Baolu,
> 
> 在 2022/9/12 10:48, Lu Baolu 写道:
>> Previously PASID supports on both IOMMU and PCI devices are enabled in 
>> the
>> iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) path. It's functionally
>> correct as the SVA is the only feature that requires PASID setup. 
>> However,
>> looking ahead, we will add more features that need to enable pasid (for
>> example, kernel DMA with PASID, SIOV, VM guest SVA, etc.). It makes more
>> sense to enable PASID during iommu probing device.
>>
>> This enables PASID during iommu probing device and deprecates the
>> intel_iommu_enable_pasid() helper. This is safe because the IOMMU 
>> hardware
>> will block any PCI TLP with a PASID prefix if there is no IOMMU domain
>> attached to the PASID of the device.
> 
> What the error path would be if this code runs on some old platforms don't
> 
> support PASID, would you print out "this platform doesn't suppor PASID" and
> 
> give users an interface function to query if the PASID cap of iommu is 
> enabled
> 
> and if not why ?

It's not an error case if the IOMMU doesn't support PASID. But it's an
error case if any device drivers call PASID related IOMMU interfaces
(for example, iommu_domain_attach/detach_dev_pasid()). The corresponding
error code will be returned to the drivers.

Best regards,
baolu
