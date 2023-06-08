Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B6630
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 02:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686192034; x=1717728034;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Irsk2p/RD2Z8gMtL+6Cvp6rDMB9fErH7tDvNO2pvfes=;
  b=dkwXCfycwXOfUX6UZi7Nz9q3ld9sxP9LLeB8hU7ZxtdaRbPkhQOY3DIX
   yLuzkOwKi/Grg2Nn+xk379FLD2pMmlyrQgU8eRZVcXY2do6hz6Cix4Uwa
   2XDnTqfOzsV2/FCdWRLTQxSfVCe7OVZtXr08pj4OKU4Lo61xcGVoYzP18
   BIHcvfPlORpzjFzN/LLBDGC0X9FmLLcs6LnChn6oCu1nQcS18rh9G7VgA
   8xVT7pz1rdhAlOMplGZIYRjA5DprY73vET0HV5B/mEtS+Vai5vnZBFTKp
   asoI4EpzwV2TtROvayGBRc4CuUby/sP7UrXt1kfROLKPOux8O9AzNHKJR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360509288"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="360509288"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 19:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709782120"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="709782120"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2023 19:40:30 -0700
Message-ID: <f0a691fa-d050-f457-9c8d-0ae340eab58f@linux.intel.com>
Date: Thu, 8 Jun 2023 10:39:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 jean-philippe@linaro.org, nicolinc@nvidia.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Michael Shavit <mshavit@google.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com> <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZIBxPd1/JCAle6yP@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/7/23 7:59 PM, Jason Gunthorpe wrote:
> On Wed, Jun 07, 2023 at 12:06:07AM +0530, Michael Shavit wrote:
>>> What we definately shouldn't do is try to have different SVA
>>> iommu_domain's pointing at the same ASID. That is again making SVA
>>> special, which we are trying to get away from 😄
>> Fwiw, this change is preserving the status-quo in that regard;
>> arm-smmu-v3-sva.c is already doing this. But yes, I agree that
>> resolving the limitation is a better long term solution... and
>> something I can try to look at further.
> I suppose we also don't really have a entirely clear picture what
> allocating multiple SVA domains should even do in the iommu driver.
> 
> The driver would like to share the ASID, but things are much cleaner
> for everything if the driver model has ASID 1:1 with the iommu_domain.

This means that each ASID should be mapped to a single IOMMU domain.
This is conceptually right as iommu_domain represents a hardware page
table. For SVA, it's an mm_struct.

So in my mind, each sva_domain should have a 1:1 relationship with an
mm_struct. Each sva_domain could have a 1:N relationship with ASID (or
PCI PASID), but in current implementation, it's a 1:1 relationship due
to the current global pasid policy for SVA.

> 
> It suggests we are missing some core code in iommu_sva_bind_device()
> to try to re-use existing SVA iommu_domains. This would certainly be
> better than trying to teach every driver how to share and refcount
> its ASID concept...
> 
> Today we have this super hacky iommu_get_domain_for_dev_pasid()
> thing that allows SVA domain reuse for a single device.
> 
> Possibly what we should do is conver the u32 pasid in the mm_struct to
> a struct iommu_mm_data * and put alot more stuff in there. eg a linked
> list of all SVA domains.

I don't quite follow "a linked list of all SVA domains". If my above
understanding is correct, then there should be a single sva_domain for
each mm_struct. The iommu_sva_domain_alloc() takes the responsibility to
allocate/free and refcount the sva domain. The sva bind code could
simply:

	domain = iommu_get_sva_domain(dev, mm);
	iommu_attach_device_pasid(domain, dev, pasid);

and the sva unbind code:

	iommu_detach_device_pasid(domain, dev, pasid);
	iommu_put_sva_domain(domain);

Perhaps, we can further drop struct iommu_sva and make the sva
bind/unbind interfaces to return the sva domain instead?

Best regards,
baolu
