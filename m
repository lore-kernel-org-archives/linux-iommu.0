Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192CC89AA
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 18:16:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BECE3106F;
	Wed,  7 Sep 2022 11:16:46 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FC523F7B4;
	Wed,  7 Sep 2022 11:16:38 -0700 (PDT)
Message-ID: <252a02d3-3c62-f2ca-e2ed-f874a31b17e9@arm.com>
Date: Wed, 7 Sep 2022 19:16:32 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 suravee.suthikulpanit@amd.com
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com> <YxintMDEmzSXJUl5@8bytes.org>
 <YxjMQpGYaHfsiuL+@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YxjMQpGYaHfsiuL+@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-07 17:52, Jason Gunthorpe wrote:
> On Wed, Sep 07, 2022 at 04:16:20PM +0200, Joerg Roedel wrote:
>> On Tue, Sep 06, 2022 at 05:35:13PM +0100, Robin Murphy wrote:
>>> Will this series also mean that the domain shenanigans in
>>> amd_iommu_init_device() can be replaced by just making sure the GPU gets the
>>> proper type of v2 default domain in the first place, so KFD can use its
>>> PASIDs on top of that directly, and the audio driver problem goes away
>>> naturally?
>>
>> Yes, on IOMMUs supporting v2 page-tables and declaring a default PASID
>> this hack can go away. Unfortunately a lot of AMD IOMMUs in the field do
>> not, so the identity mapping hack needs to stay around.
> 
> Why can an identity map be attached to the RID in v2, but not a full
> translation? It seems like a very strange design that entering PASID
> mode completely breaks RID support..

FWIW we have the opposite problem on SMMUv3 - if we're using PASIDs then 
we can't bypass the RID, it *has* to map to a translation context (as 
PASID 0). I can only guess that nobody's yet tried the combination of 
SVA plus IOMMU_DEFAULT_PASSTHROUGH plus the device sending MSIs (and not 
on the dodgy machine where MSIs bypass the SMMU in hardware)... :/

Anyway, fair enough if def_domain_type still has to force 
IOMMU_DOMAIN_IDENTITY in some cases here, but presumably that still 
wouldn't prevent us from enabling v2 on those from the outset and 
avoiding the mysterious and problematic "concoct an identity domain to 
replace the identity domain" dance?

Thanks,
Robin.
