Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26301CA9A
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27AB3C15;
	Fri,  6 Oct 2023 07:56:59 -0700 (PDT)
Received: from [10.57.66.230] (unknown [10.57.66.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 848983F5A1;
	Fri,  6 Oct 2023 07:56:17 -0700 (PDT)
Message-ID: <161e4152-9213-415f-8315-4f3a73b76022@arm.com>
Date: Fri, 6 Oct 2023 15:56:15 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] iommu/arm-smmu: Pass arm_smmu_domain to
 arm_smmu_init_domain_context()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <jroedel@suse.de>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Steven Price <steven.price@arm.com>
References: <4-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
 <db259336-1203-4d12-ac80-3108aaf5ec82@arm.com>
 <20231006135347.GR682044@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231006135347.GR682044@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-10-06 14:53, Jason Gunthorpe wrote:
> On Fri, Oct 06, 2023 at 02:43:51PM +0100, Robin Murphy wrote:
>> On 2023-10-05 19:28, Jason Gunthorpe wrote:
>>> Instead of putting container_of() casts in the internals, use the proper
>>> type in this call chain. This makes it easier to check that the two global
>>> static domains are not leaking into call chains they should not.
>>
>> Is there something inherently difficult about to_smmu_domain()? It's hard to
>> tell how the aforementioned checks might expect to work since they don't
>> appear to be added anywhere :/
> 
> ?? There are not added checks, this is talking about static checks and
> code auditing.
> 
> Let's try the commit paragraph again:
> 
> Now that we have IDENTITY and BLOCKED domains that do not use the
> struct arm_smmu_domain it is important that to_smmu_domain() is only
> called on iommu_domain structs passed to the paging domain ops (aka
> default_domain_ops). Use the more specific type in several call
> chains and remove the few to_smmu_domain() calls that are not
> obviously in an op call chain.
> 
> This makes it easier to audit the code that the two IDENTITY and
> BLOCKED domains are not leaking someplace they should not.

How? It should already be trivial to confirm that the driver is not 
itself making any reference to arm_smmu_identity_domain or 
arm_smmu_blocked_domain other than exposing them to the core API, with 
no more than a simple grep. And if the core code does somehow screw up 
at runtime and they get passed back into arm_smmu_attach_dev() then 
that's still going to use to_smmu_domain() on them and propagate that to 
its callees, with exactly the same effect as if they did so themselves. 
I fail to understand what you think you can achieve here.

The only code that deals with the static domains is 
arm_smmu_attach_dev_identity() and arm_smmu_attach_dev_blocked(), and 
you've already implemented those quite happily prior to this change, 
leaving no foreseeable reason to rework them further. So AFAICS the only 
scenario where this could make any practical difference is if someone 
now makes an unnecessary and nonsensical change to have one of those 
call into random other parts of the driver. But by that point, why would 
you be confident that they wouldn't simply cargo-cult a to_smmu_domain() 
invocation to "fix" the type mismatch at the callsite, since that's what 
other domain callbacks do?

It's never worth doing anything for the sole reason of trying to make it 
slightly harder for someone who doesn't understand the code to break the 
code. Either it's an entirely imagined problem to begin with, or 
otherwise nature will always find a way...

Thanks,
Robin.
