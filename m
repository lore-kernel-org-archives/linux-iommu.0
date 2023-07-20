Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1517D182AA
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856291; x=1721392291;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PPjb1efpNVs+0C/3htOuyu3cb1OjDpfvMZWKs6Ysk/Q=;
  b=BoGlVnAFZFS3iT3YeEFjSeBo1LU6ONv3+L9dMH6ev2mNdwKJXggXtMuh
   7vRs1yMbgfZOmRHBA0yHbemBBmmzQ0nnqKMXXJyZp+8q1FzJD+6vniyzr
   RRbVvv5Z3cMOHnAhCHnIyl2YQvtIpMW3AW0H18HAjKUt1rZC3MQiaLPZX
   LUqt+FK/ku7Hh8nYkY9Zw7frI0q73Hu5KfVMhJzaAQ+CmP96z2h8e0YFF
   AUH1z7c+g46uXLmCORWqY8nxlfZTVMJjxXGKGZ5Yd3PrzzNdHB3U/Gc1m
   SlY5t+H5xN9mu/BwvWp1iyaG5iFeUetMX2dPGvYb2ufWt6Ze+cyvg8lri
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="430484822"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="430484822"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:31:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="848430629"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="848430629"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.109]) ([10.252.191.109])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:31:23 -0700
Message-ID: <45d32e95-9d57-a424-63bd-b894cf0d3a2b@linux.intel.com>
Date: Thu, 20 Jul 2023 20:31:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu
 support.
Content-Language: en-US
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/20 3:33, Tomasz Jeznach wrote:
> +static void riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_domain,
> +				       unsigned long iova, size_t size)
> +{
> +	unsigned long end = iova + size - 1;
> +	/*
> +	 * Given we don't know the page size used by this range, we assume the
> +	 * smallest page size to ensure all possible entries are flushed from
> +	 * the IOATC.
> +	 */
> +	size_t pgsize = PAGE_SIZE;
> +	riscv_iommu_flush_iotlb_range(iommu_domain, &iova, &end, &pgsize);
> +}

Does RISC-V IOMMU require to invalidate the TLB cache after new mappings
are created?

Best regards,
baolu
