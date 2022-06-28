Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF32257A
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656416056; x=1687952056;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WyQ7Lhg64UA7faLJ8umQR8gY+ay9xEU5cNZImGlhWOk=;
  b=mPJDr57GEi+1qk2T7LZZHm4bqAo6RCypYCOKO2HWK9nHhcnYcbS9JsP0
   YR9at9ZzN515jI1a5fElDZPKgi3Vwv4IivcEFdFwpPSxkduHgnvE/nPfO
   tOY/TFPnwmWOjSpuSdLFW7GLn47vDlz6vVuFFOGOxegQHlfa2ohbQg6zS
   qnozt6KADcEYk0l2qvqq19Q+VekTkCMUGooxBtMa/cl2/bSx8B54N2VGT
   WY+3G+TI/CywrCcIAy5GF1GIixD+5eGxD851ifX3sEo2I0kaD11ygik3o
   SP37scM7y6/FyfLLlw/qUZaPCUsKllb8M6irP3SUwTm7s+NZ98W2VaGHT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="368029179"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="368029179"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:34:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646877561"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:33:59 -0700
Message-ID: <89130952-155c-38f0-3318-1c071562661f@linux.intel.com>
Date: Tue, 28 Jun 2022 19:33:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
 <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220628113357.yqIz2RjFJn-MdStYWhgosYb7B6zUnoM2cd2aEosLS5w@z>

On 2022/6/28 16:50, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 28, 2022 1:41 PM
>>>>    struct iommu_domain {
>>>>    	unsigned type;
>>>>    	const struct iommu_domain_ops *ops;
>>>>    	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>>>> -	iommu_fault_handler_t handler;
>>>> -	void *handler_token;
>>>>    	struct iommu_domain_geometry geometry;
>>>>    	struct iommu_dma_cookie *iova_cookie;
>>>> +	union {
>>>> +		struct {	/* IOMMU_DOMAIN_DMA */
>>>> +			iommu_fault_handler_t handler;
>>>> +			void *handler_token;
>>>> +		};
>>> why is it DMA domain specific? What about unmanaged
>>> domain? Unrecoverable fault can happen on any type
>>> including SVA. Hence I think above should be domain type
>>> agnostic.
>> The report_iommu_fault() should be replaced by the new
>> iommu_report_device_fault(). Jean has already started this work.
>>
>> https://lore.kernel.org/linux-iommu/Yo4Nw9QyllT1RZbd@myrica/
>>
>> Currently this is only for DMA domains, hence Robin suggested to make it
>> exclude with the SVA domain things.
>>
>> https://lore.kernel.org/linux-iommu/f3170016-4d7f-e78e-db48-
>> 68305f683349@arm.com/
> Then it's worthy a comment that those two fields are for
> some legacy fault reporting stuff and DMA type only.

The iommu_fault and SVA fields are exclusive. The former is used for
unrecoverable DMA remapping faults, while the latter is only interested
in the recoverable page faults.

I will update the commit message with above explanation. Does this work
for you?

Best regards,
baolu
