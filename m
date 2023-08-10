Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A327E4
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 02:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691634448; x=1723170448;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wbX5ZGZU+a045ReN97N8foV8POn+IQFOPh9KTo/LP+c=;
  b=WdHCsmAhJMGYzQbEeEqkxDz7W7dU4tuJDBP261nCuRBkcYm6zjELb2sh
   9Ue9CoWJAzdsGIexcHtlPNw4Mrc42FqVtxSThth6MvZkeE4K59sOPzt/L
   xd7DweNAc0fyGcY/fuIT5yv9aqiz+LqGJOWwDRWlR7mnSSR7keXKZS2Xw
   eL6xjj0syHg7/m94PyKmR7/ZQaRKMJ3sVCTK6L+TVF/ccuHdKJleLDG6P
   v2HMWgYSkiUc9682eOGyjonkYlZuka8HaJZvITlT5E9oS+bj8CGdvY7Pa
   Vuxb1MuJuNWzjH1Sr4CAyX6+yV3Rg5YgTOXjKvm47DzbDMg8TbxTIeZgF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="356244296"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="356244296"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 19:27:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797433020"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="797433020"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.239]) ([10.254.214.239])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 19:27:23 -0700
Message-ID: <28d86414-d684-b468-d0a9-5c429260e081@linux.intel.com>
Date: Thu, 10 Aug 2023 10:27:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] iommu: Remove unrecoverable fault data
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-4-baolu.lu@linux.intel.com>
 <ZNPF/nA2JdqHMM10@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNPF/nA2JdqHMM10@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/10 0:59, Jason Gunthorpe wrote:
> On Thu, Jul 27, 2023 at 01:48:28PM +0800, Lu Baolu wrote:
>> The unrecoverable fault data is not used anywhere. Remove it to avoid
>> dead code.
>>
>> Suggested-by: Kevin Tian<kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h | 70 +------------------------------------------
>>   1 file changed, 1 insertion(+), 69 deletions(-)
> Do we plan to bring this back in some form? A driver specific fault
> report via iommufd?

I can hardly see the possibility.

The only necessary dma fault messages are the offending address and the
permissions. With these, the user space device model software knows that
"a DMA fault was generated when the IOMMU hardware tried to translate
the offending address with the given permissions".

And then, the device model software will walk the page table and figure
out what is missed before injecting the vendor-specific fault messages
to the VM guest.

Best regards,
baolu
