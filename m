Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5407C
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 12:53:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE1C14BF;
	Thu,  8 Sep 2022 05:54:05 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B58B3F7B4;
	Thu,  8 Sep 2022 05:53:57 -0700 (PDT)
Message-ID: <c11bd109-65cd-39b3-6d7e-2b29208ca2ca@arm.com>
Date: Thu, 8 Sep 2022 13:53:50 +0100
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
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 suravee.suthikulpanit@amd.com
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com> <YxintMDEmzSXJUl5@8bytes.org>
 <YxjMQpGYaHfsiuL+@nvidia.com> <YxneJ2RqaatKmoYT@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YxneJ2RqaatKmoYT@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-08 13:20, Joerg Roedel wrote:
> On Wed, Sep 07, 2022 at 01:52:18PM -0300, Jason Gunthorpe wrote:
>> Why can an identity map be attached to the RID in v2, but not a full
>> translation? It seems like a very strange design that entering PASID
>> mode completely breaks RID support.
> 
> The reason is that AMD IOMMUs do two-level translation, which means that
> the addresses in the PASID page-tables are translated via the v1
> page-table again. In order to be able to use Linux page-tables for PASID
> mappings the v1 page-table needs to be identity mapped.

Ah, and without a default PASID, RID traffic goes straight into the 
second level? That actually sounds much the same as what SMMUv3's S1DSS 
can do - seems I misremembered yesterday, we *could* in fact twiddle 
that to handle identity default domains, it's attaching a PASID to an 
identity domain that remains impossible without installing a full 1:1 
pagetable, my bad.

Cheers,
Robin.
