Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21758539F
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 09:57:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73ACD1FB;
	Wed, 14 Jun 2023 02:58:27 -0700 (PDT)
Received: from [10.57.85.233] (unknown [10.57.85.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91D133F71E;
	Wed, 14 Jun 2023 02:57:41 -0700 (PDT)
Message-ID: <0454d58b-1de0-a4b4-6b93-8c0b99090d96@arm.com>
Date: Wed, 14 Jun 2023 10:57:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Content-Language: en-GB
To: Michael Shavit <mshavit@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 jean-philippe@linaro.org, nicolinc@nvidia.com, baolu.lu@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com> <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
 <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-06-14 10:17, Michael Shavit wrote:
> On Wed, Jun 7, 2023 at 1:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Tue, Jun 06, 2023 at 08:07:50PM +0800, Michael Shavit wrote:
>>> SVA may attach a CD to masters that have different upstream SMMU
>>> devices. The arm_smmu_domain structure can only be attached to a single
>>> upstream SMMU device however.
>>
>> Isn't that pretty much because we don't support replicating
>> invalidations to each of the different SMMU instances?
> 
> Looked into this some more, and supporting attach to multiple devices
> is still very hard:
> 1. When an arm_smmu_domain is first attached to a master, it
> initializes an io_pgtable_cfg object whose properties depend on the
> master's upstream SMMU device. This io_pgtable_cfg is then used to
> allocate an io_pgtable object, and the arm_smmu_ctx_desc's TTBR field
> points to that io_pgtable's TTBR (and ditto for the vttbr on stage 2
> domains). So then arm_smmu_domain needs to be split into two,
> arm_smmu_domain and arm_smmu_device_domain with the latter containing
> a per-SMMU device io_pgtable, arm_smmu_ctx_desc and arm_smmu_s2_cfg.
> Each iommu_domain_ops operation now needs to loop over each
> arm_smmu_device_domain.
> 2. Some of the iommu_domain fields also depend on the per-SMMU
> io_pgtable_cfg; specifically pgsize_bitmap and geometry.aperture_end.
> These need to be restricted as the domain is attached to more devices.
> 3. Attaching a domain to a new SMMU device must be prohibited after
> any call to map_pages or if iommu_domain.pgsize_bitmap and
> iommu-domain.geometry.aperture_end have been consumed by any system.
> The first is something the arm-smmu-v3.c driver could feasibly enforce
> on its own, the second requires changes to the iommu framework.

In practice it would be entirely reasonable to only support 
cross-instance attach between instances with matching capabilities such 
that they *can* share the pagetable directly.

> The arm-smmu-v3-sva.c implementation avoids all these problems because it
> doesn't need to allocate an io_pgtable;

SVA has all the same underlying problems - pagetable sharing is still 
pagetable sharing regardless of which code happens to allocate the 
physical pages - they're just avoided up-front by disallowing SVA at all 
if the relevant capabilities don't line up between SMMU and CPU.

Thanks,
Robin.
