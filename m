Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA18A20EA
	for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 03:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663297552; x=1694833552;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=AA4yM8sBHYK6jyGEDMWq+oJQ1iHOxkryKHMct2cC2aU=;
  b=UFWKlLtP0dGWYCDaNUwdOGfrH4NyWJ3Q/8PI7TQC6woLy3HoZjVIUhRX
   s75yZEneubM29suvRP5CAc23Y3gtMS/PrRlhVZ7AqBHLkhxtMDqQw2IU9
   9OI/l8GtkYK7yA3L25Z5Vcqrnvcpa2xjrZ0J9fuh7Jw6yOV/j3ntipnjI
   0QRPssQBKPRVlsZgNQz5ObntAeBOxEB6jjQWpYhEOANnkgzoRWvGVEhHo
   bTZLjcPZDPG1j6YC9AxEBTr2zfUryHNg80Pb8+uFcdilmfxmcNaJWwSPx
   SVINGnHxS24QeInC6fR+gLOO2elP5OCVuZsUq4vzDy3THfT6h+/hG3n0h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="297621060"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="297621060"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:05:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="613120043"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.216]) ([10.254.214.216])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:05:49 -0700
Message-ID: <fc1f5412-6041-71b8-2a87-84f2f32456fc@linux.intel.com>
Date: Fri, 16 Sep 2022 11:05:47 +0800
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
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
 <e0c43ca7-0ad3-a4d6-960b-9853bb815438@linux.intel.com>
 <e26efaee-d84a-3b60-8400-90d8e49a9b25@linux.intel.com>
 <5415d383-5442-a127-bdab-fce9e9b7a3b2@linux.intel.com>
 <78ec0fab-6f69-1d3d-86f3-84f159817707@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
In-Reply-To: <78ec0fab-6f69-1d3d-86f3-84f159817707@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022/9/16 10:40, Ethan Zhao wrote:
>>
>> I may not get you exactly. 😄 Some IOMMU features reply on PASID
>> capabilities on both IOMMU and device. The IOMMU drivers enumerate the
>> capabilities and enable them if they are supported.
> I might not express it straightforward,  I mean with this patch iommu 
> deals with
> 
> the complexity of enabling PASID (globally?)  or not at probing stage , 
> instead
> 
> of other device driver side decision to request IOMMU PASID enabling during
> 
> their setup state.  if so you move the decision to iommu probe stage. 
> hmmm...

I am sorry that the commit message was a bit confusing. Actually we
always enable PASID at iommu probe path w/ or w/o this patch.

> 
> Pros,  iommu driver controls everything about PASID enabling.
> 
> Cons,  iommu driver handles all possible complexity about capability 
> matching

Do device drivers need to configure PCI PASID without IOMMU? I searched
the tree and found nothing.

Best regards,
baolu
