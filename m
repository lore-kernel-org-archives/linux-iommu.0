Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277E86FA1
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 16:15:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D49FEC;
	Mon,  3 Apr 2023 09:16:24 -0700 (PDT)
Received: from [10.57.56.209] (unknown [10.57.56.209])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04E843F6C4;
	Mon,  3 Apr 2023 09:15:38 -0700 (PDT)
Message-ID: <0984f396-7ba4-b14e-bb32-3df7f04a974b@arm.com>
Date: Mon, 3 Apr 2023 17:15:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [Design] iommu/arm-smmu-v3: Implementing set_dev_pasid for other
 domain types
Content-Language: en-GB
To: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org,
 Will Deacon <willdeacon@google.com>
Cc: Daniel Mentz <danielmentz@google.com>,
 John Scheible <johnscheible@google.com>, Mostafa Saleh
 <smostafa@google.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <CAKHBV24u9b-=cJCF=Kt=3B4hynOyNr6gmi0F6zpO6b1mHc0Z7g@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAKHBV24u9b-=cJCF=Kt=3B4hynOyNr6gmi0F6zpO6b1mHc0Z7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-03-24 09:18, Michael Shavit wrote:
> Hi Jean-Philippe, all
> 
> We’d like to use the new iommu_attach_device_pasid API to control
> mappings on a per SSID basis. To that end, we’ve started investigating
> how to implement the set_dev_pasid callback in the arm-smmu-v3.c
> driver for domain types other than SVA.
> 
> As noted in your smmuv3 aux-domain patch, the arm_smmu_domain
> represents not only “the non-PASID address space but also (at least
> for SMMUv3) the whole device context, PASID tables etc.” Multiple SVA
> iommu_domains reach into a shared arm_smmu_domain to write their CDs
> into a shared CD table.
> Is moving to a model where each arm_smmu_master holds this previously
> shared device context instead of the arm_smmu_domain a bad idea?

Since the aux_domain concept got knocked on the head, the model should 
really be that a (stage 1) iommu_domain represents the CD + pagetable. 
Having the domain own its containing CD *table* (or not, depending on 
how it's attached) is conceptually a bit backwards, and indeed I think 
it precludes using per-device SSIDs, which might conceivably be a thing 
to consider for non-SVA use-cases.

> This would allow a pretty straightforward implementation of
> set_dev_pasid for other domain types:
>      * Attaching a domain with PASID to a device doesn’t have to
> piggyback on any other domain’s CD table. The domain’s CD can directly
> be written into the master’s CD table.
>      * A domain attached with PASID is no different than one attached
> without PASID, attach_dev becomes attach_dev_with_pasid(0).
> 
> At a high-level:
>     1. The arm_smmu_domain would still own the arm_smmu_ctx_desc struct
> that describes that domain (translation table, etc)
>     2. Each arm_smmu_master would now own its own s1_cfg struct (and CD
> table). Attaching a domain to a device would write the CD into that
> device’s CD table instead of the previously shared CD table.

Short of doing something wacky like trying to make the CD table belong 
to the PASID allocator (not necessarily as mad as it initially sounds, 
though), I'd say conceptually it's probably closest to belonging to the 
STE, as represented by the arm_smmu_master, so this sounds about the 
right shape to me.

Thanks,
Robin.

>  From an implementation POV there’s a few other changes and
> book-keeping that become required to handle edge-cases (e.g. We need
> to find all the CD entries that a domain is written to when the SVA
> driver tries to update a domain’s ASID value). Right now I’m more
> concerned about whether this idea is sane at a design level.
> 
> As a first order consequence, when multiple devices share a domain:
>      1. We’ll use more memory than we would have before.
>      2. The SMMU will perform dma to distinct CD tables to find the
> page table; however the page table itself would still be shared.
> 
> Is that acceptable considering some users might not need the
> set_dev_pasid support this is geared towards?
> Are there other consequences we've overlooked?
> 
> Thanks,
> Michael
