Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F7F185D;
	Thu, 30 Mar 2023 06:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680157410; x=1711693410;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5aXqcNATiMJMa1yhOxfg/U3LXVZya3PKNACWseZaUe0=;
  b=Sb6sF6je6e8Y2mNkBwtacD44dqOIln5D4gWwO0Bmf2LUYUyPEd0qjRGA
   ZSMFyyiWyf8pURpM+F2eo9JHNZ2n/2K0MBKu9EIO2YLSr0pr5V6XD9pop
   TNz8qWbUl6zGz1Kj3hGQVSj6+CiuOeKe/12phV7gptghgFGQ2YF8ioDXP
   REoLMNtTOAKPLkXCitOROXTIaqio5eNgwAGI7Ox5B9DgaikM+qzMhz8LC
   bjzaBPoLcVhvQ+0RlszsRYLnDb+inYy98jIS7N6ZsYvqbkAmR67Jya+6D
   Upgf+3Spl6ydsk3wkg2fTINzaLOlDHZFr3PtlToyIKw0q8zQg2J82oR3L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403731402"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="403731402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714878080"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="714878080"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2023 23:23:26 -0700
Message-ID: <45f71328-8ea7-abdf-b779-6bff870d7b61@linux.intel.com>
Date: Thu, 30 Mar 2023 14:23:43 +0800
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
Subject: Re: [PATCH v2 04/14] iommu: Use __iommu_group_set_domain() for
 __iommu_attach_group()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <4-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/23 7:40 AM, Jason Gunthorpe wrote:
> The error recovery here matches the recovery inside
> __iommu_group_set_domain(), so just use it directly.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
