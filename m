Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DF58828;
	Wed,  5 Mar 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189526; cv=none; b=moTmTQiWypQKp4yKEhgIlAQLxVOwoSPCVOAnYfde5QKdmv8HTVjJLf73pUvgmiE4WS2pQkLQ0Cr7Ur4t6+CnZbwDWTj/iMmIgOfT/XckQ1fJ4E54DY+VIP1wCJF78SKBJA/M4BbPRqI4Bgh1nHjzVXvSWUKaAK2WGI7DCIhSjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189526; c=relaxed/simple;
	bh=owUqDxdtLK5n+Nj0cOtwi3iZa2EumCq2OdlytOr2qhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufxB/oPXZDxiEDMIexPjZ0N9P6ABS1oyjdl6IVwJ8lGPhGrS5VzhuoVttQYW1M4ifZ4Hqz7jBvtEwvpQNsIgrwBltMS9DlYZsUW8ZMlgIG+XjNwUw+GK4SIvvmEMY+JFzNjz3L3MX+mwZldvZw87Vs//WwmWLWfx+By2uVs5wNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 384B2FEC;
	Wed,  5 Mar 2025 07:45:37 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D95713F673;
	Wed,  5 Mar 2025 07:45:22 -0800 (PST)
Message-ID: <3699641b-c7bc-4fec-b8e2-828f5b1f2d70@arm.com>
Date: Wed, 5 Mar 2025 15:45:21 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] iommu: Sort out domain user data
To: kernel test robot <lkp@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org, will@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc@nvidia.com>
 <202503052255.t1N6KrAn-lkp@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <202503052255.t1N6KrAn-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 3:18 pm, kernel test robot wrote:
> Hi Nicolin,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 5e9f822c9c683ae884fa5e71df41d1647b2876c6]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-Sort-out-domain-user-data/20250304-045529
> base:   5e9f822c9c683ae884fa5e71df41d1647b2876c6
> patch link:    https://lore.kernel.org/r/74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc%40nvidia.com
> patch subject: [PATCH v3 1/3] iommu: Sort out domain user data
> config: mips-randconfig-r071-20250305 (https://download.01.org/0day-ci/archive/20250305/202503052255.t1N6KrAn-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503052255.t1N6KrAn-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503052255.t1N6KrAn-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/iommu/iommu.c:2039:10: error: label at end of compound statement: expected statement
>             default:
>                     ^
>                      ;
>     1 error generated.

Oops, my bad... omitting an extra break here was a semi-conscious 
brainfart. Weird that my AArch64 GCC doesn't complain about this 
construct though, even with "-ansi -Wall" - I have to go all the way to 
-Wpedantic before it notices :/

Thanks,
Robin.

> 
> 
> vim +2039 drivers/iommu/iommu.c
> 
>    2026	
>    2027	void iommu_domain_free(struct iommu_domain *domain)
>    2028	{
>    2029		switch (domain->cookie_type) {
>    2030		case IOMMU_COOKIE_DMA_IOVA:
>    2031			iommu_put_dma_cookie(domain);
>    2032			break;
>    2033		case IOMMU_COOKIE_DMA_MSI:
>    2034			iommu_put_msi_cookie(domain);
>    2035			break;
>    2036		case IOMMU_COOKIE_SVA:
>    2037			mmdrop(domain->mm);
>    2038			break;
>> 2039		default:
>    2040		}
>    2041		if (domain->ops->free)
>    2042			domain->ops->free(domain);
>    2043	}
>    2044	EXPORT_SYMBOL_GPL(iommu_domain_free);
>    2045	
> 
