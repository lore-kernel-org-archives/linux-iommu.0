Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009D185D;
	Thu, 30 Mar 2023 06:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680157390; x=1711693390;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BK9JDPJ3s8bGK6gdr3s2sRO6hSvAJrUAUqHI2FfvOFI=;
  b=C7RgZeOh8NZHp/ylMFmM1gYp+N/fv13JEAlbCddvA9cyRJ+/kNX51KEb
   VK63fAfzLMubqV8Fum6cK9FOAUzmwulHVNHdtTk+KNwTlWsmaMghuaM7J
   Y7mQ3ZDrAkW+8W5uu5MIT+xKVv6AVvs8XnFRLp33/qEhz3QkQpXoWtnxI
   lZ4C5PDKiHHk6+akYXccd1h7HwWqNFfyMjolB6x83ZFIgUDY9+jbQZS05
   3m4JNQXWxhmupraIzpKattOwGzveb/WJz/jywjQAMOKkZrPfVlhgG17QX
   3WzVv2K8IKXY5nMWDBa0avck3p+01vTP/jK0i9QUEB0UNKGlAITpwCPPc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403731340"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="403731340"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714877979"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="714877979"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2023 23:23:05 -0700
Message-ID: <c020b1dd-1d04-954d-6d9a-e3a6b59f954c@linux.intel.com>
Date: Thu, 30 Mar 2023 14:23:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 03/14] iommu: Make __iommu_group_set_domain() handle
 error unwind
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <3-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/23 7:40 AM, Jason Gunthorpe wrote:
> Let's try to have a consistent and clear strategy for error handling
> during domain attach failures.
> 
> There are two broad categories, the first is callers doing destruction and
> trying to set the domain back to a previously good domain. These cases
> cannot handle failure during destruction flows and must succeed, or at
> least avoid a UAF on the current group->domain which is likely about to be
> freed.
> 
> Many of the drivers are well behaved here and will not hit the WARN_ON's
> or a UAF, but some are doing hypercalls/etc that can fail unpredictably
> and don't meet the expectations.
> 
> The second case is attaching a domain for the first time in a failable
> context, failure should restore the attachment back to group->domain using
> the above unfailable operation.
> 
> Have __iommu_group_set_domain_internal() execute a common algorithm that
> tries to achieve this, and in the worst case, would leave a device
> "detached" or assigned to a global blocking domain. This relies on some
> existing common driver behaviors where attach failure will also do detatch
> and true IOMMU_DOMAIN_BLOCK implementations that are not allowed to ever
> fail.
> 
> Name the first case with __iommu_group_set_domain_nofail() to make it
> clear.
> 
> Pull all the error handling and WARN_ON generation into
> __iommu_group_set_domain_internal().
> 
> Avoid the obfuscating use of __iommu_group_for_each_dev() and be more
> careful about what should happen during failures by only touching devices
> we've already touched.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
