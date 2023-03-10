Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C948820
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 14:52:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77AED1515;
	Fri, 10 Mar 2023 06:53:33 -0800 (PST)
Received: from [10.57.90.67] (unknown [10.57.90.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11F5C3F71A;
	Fri, 10 Mar 2023 06:52:47 -0800 (PST)
Message-ID: <82f5b94b-01fe-5c99-608c-f7d124247b7c@arm.com>
Date: Fri, 10 Mar 2023 14:52:42 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures for
 ARM SMMUv3
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 eric.auger@redhat.com, kevin.tian@intel.com, baolu.lu@linux.intel.com,
 joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, yi.l.liu@intel.com
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica> <ZAnx0lUkw02cVTi+@nvidia.com>
 <20230309182659.GA1710571@myrica> <ZApJGwPjHhlDwTDV@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZApJGwPjHhlDwTDV@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-03-09 21:01, Jason Gunthorpe wrote:
>> For a lot of SMMUv3 implementations that have a single queue and for
>> other architectures, we can do better than hardware emulation.
> 
> How is using a SW emulated virtio formatted queue better than using a
> SW emulated SMMUv3 ECMDQ?

Since it's not been said, the really big thing is that virtio explicitly 
informs the host whenever the guest maps something. Emulating SMMUv3 
means the host has to chase all the pagetable pointers in guest memory 
and trap writes such that it has visibility of invalid->valid 
transitions and can update the physical shadow pagetable correspondingly.

FWIW we spent quite some time on and off discussing something like 
VT-d's "caching mode", but never found a convincing argument that it was 
a gap which needed filling, since we already had hardware nesting for 
maximum performance and a paravirtualisation option for efficient 
emulation. Thus full SMMUv3 emulation seems to just sit at the bottom as 
the maximum-compatibility option for pushing an unmodified legacy 
bare-metal software stack into a VM where nesting isn't available.

Cheers,
Robin.
