Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51667136F
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxkiifHR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702000006; x=1733536006;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a1V5oe8F0zniWg/dMhRfRIr1GS+4k6skm7a7EwrxAtk=;
  b=NxkiifHRHo2ZGbkz5gS2HueEUWNS4zQ0TDA6Awnbs0qZdpfaEhp+avo/
   oyIQh5VFdwLZFFbSfhGMGsOuqjyAnHWsMThUxxVEw2lLdOR+AHjTnSyvI
   SGvvfGJVihg38ep2f83xlD+qznnnof3FpsH5b3M9HsPhDtnn9/7vw+FQn
   iczNe8wdrt4mqBL83/JUwaamlzwaAnO87EEauQZg0xb96YS2jJC1BERFN
   ggia+G680afp1+DeYPeuTE/QISD5EIH+zGCzvx27zOD3KTPWLDsWLXahk
   rsBzi9bE25m2cFRtiJyrI3yEOdBgf6K3PfddXS0qjGx/qkrCjlAF2bS3u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7664312"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="7664312"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:46:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="775644369"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="775644369"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2023 17:46:39 -0800
Message-ID: <449c288c-0ab1-4287-814d-91b704fb3b46@linux.intel.com>
Date: Fri, 8 Dec 2023 09:42:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Set owner token to sva and nested domains
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
References: <20231207021938.306738-1-baolu.lu@linux.intel.com>
 <f1c473f7-ba40-454e-bd3e-a47f6d58513e@arm.com>
 <20231207133630.GS1489931@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231207133630.GS1489931@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/7/23 9:36 PM, Jason Gunthorpe wrote:
> On Thu, Dec 07, 2023 at 09:56:10AM +0000, Robin Murphy wrote:
>> On 2023-12-07 2:19 am, Lu Baolu wrote:
>>> Commit a9c362db3920 ("iommu: Validate that devices match domains") added
>>> an owner token to an iommu_domain. This token is checked during domain
>>> attachment to RID or PASID through the generic iommu interfaces.
>>>
>>> The sva and nested domains are attached to device or PASID through the
>>> generic iommu interfaces. Therefore, they require the owner token to be
>>> set during allocation. Otherwise, they fail to attach.
>> Oops, I missed that iommu_sva_domain_alloc() is a thing - when did we get
>> such a confusing proliferation of domain allocation paths? Sigh...
> We have alot of different kinds of domains now, APIs that are giant
> multiplexers are not good.
> 
> What I've been wanting to do for a while is to have the drivers call a
> helper to allocate their domain struct and the helper would initialize
> the common iommu_domain instead of doing this after the op
> returns. This is more typical kernel pattern and avoids some of the
> confusion about when struct members are valid or not (notice some of
> driver code needs iommu_domain stuff set earlier and we confusingly
> initialize things twice :()
> 
>> I think we should set the owner generically there, since presumably it's
>> being missed for SMMUv3/AMD/etc. SVA domains as well. Nested domains are
>> supposed to be OK since both ->domain_alloc_user callsites are covered, or
>> is there some other sneaky path I've also missed?
> Indeed, I also think the first hunk is not needed, the second hunk was
> missed.

Oh, yes! I overlooked that iommufd has already done that for nested
domain. I will update it with a v2.

Best regards,
baolu
