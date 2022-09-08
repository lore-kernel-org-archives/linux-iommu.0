Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D427A3222
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 13:47:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D788A23A;
	Thu,  8 Sep 2022 06:47:25 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51083F7B4;
	Thu,  8 Sep 2022 06:47:17 -0700 (PDT)
Message-ID: <c48211fe-00b1-e679-21b8-00a85bba599a@arm.com>
Date: Thu, 8 Sep 2022 14:47:11 +0100
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
 <c11bd109-65cd-39b3-6d7e-2b29208ca2ca@arm.com> <Yxnr1gBIGwdinIkr@nvidia.com>
 <YxnuYTrkC5yoHH84@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YxnuYTrkC5yoHH84@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-08 14:30, Joerg Roedel wrote:
> On Thu, Sep 08, 2022 at 10:19:18AM -0300, Jason Gunthorpe wrote:
>> What is the use case for having PASID nested under another level of
>> translation?
> 
> Virtualization. Basically having a device access process address spaces
> inside a virtual machine. That got never put into code, but it was the
> rationale behind it.

For SMMUv3 it did actually get as far as a prototype[1] before the 
iommufd work interjected. I believe there are cloud vendors using those 
patches in their deployments :O

Cheers,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/20210423095147.27922-1-vivek.gautam@arm.com/
