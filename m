Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA510E3
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 06:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680070382; x=1711606382;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oxmXk/Jf6fYFdSfm6pbGui75cwVHE+ozCDImWBIUPGg=;
  b=NpDTAfXY4jHN7yqqkox92fI2O+yl7QiWl8zEHtpfe4CyPo93BO76S92S
   ZmoYMJB+Kml7fljNmuGpf9G8OqzfymjBV6bhUzgK9WH5IUAgAUz5Ky06r
   OxvLyokMH+VQp/hqz0jktRs4fj+0LNf8FbxsVl7DHiIwklvG3xotH1UO6
   LtPbC0xeymhz1KGYNgt6AQYw9gvA3Pj2s98+43aPASmJcg3e4jpiIyhX/
   ColLTn1qWMqzfu6jWJLNS2EQIipdZsqX9rydchxKNtYN1n4ZaNRlBrIBE
   cUz6+HDO23p9rWTJcIDubRPN1+yzfBzlNn+0ScP2QXPSTnE4OUSt4VErQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="329254928"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="329254928"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 23:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="661476319"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="661476319"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 28 Mar 2023 23:12:56 -0700
Message-ID: <709827a9-da98-1751-c69c-e2b883784093@linux.intel.com>
Date: Wed, 29 Mar 2023 14:13:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v2 4/8] iommu/vt-d: Reserve RID_PASID from global SVA
 PASID space
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
 <41d31adf-577e-431c-c400-2708885400c1@linux.intel.com>
 <20230328092919.372f0545@jacob-builder>
 <20230328135200.139f280a@jacob-builder>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230328135200.139f280a@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/23 4:52 AM, Jacob Pan wrote:
> On Tue, 28 Mar 2023 09:29:19 -0700, Jacob Pan
> <jacob.jun.pan@linux.intel.com>  wrote:
> 
>>>> On VT-d platforms, RID_PASID is used for DMA request without PASID. We
>>>> should not treat RID_PASID special instead let it be allocated from
>>>> the global SVA PASID number space.
>>> It's same to AMD and ARM SMMUv3, right? They also need an explicit
>>> reservation of PASID 0.
>>>    
>> yes, all IOMMU drivers need to do that. I will give it a try but might
>> need help to place the call.
> It might be simpler to just let SVA code allocate from 1 up instead of 0
> (as is in the current code). Global PASID allocator would still allow the
> full range from 0 to max. Then there is no change to architectures that
> don't support non-zero RID_PASID. For VT-d, it would still work in the
> future when we have nonzero RID_PASID. is that reasonable?

Yes. It's reasonable from the status quo.

Best regards,
baolu
