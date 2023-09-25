Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF227F;
	Mon, 25 Sep 2023 02:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695609192; x=1727145192;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5PH/SBoMG2TOgi6paDh0yzV6D71btfiOoid4YY/5wXw=;
  b=LVusOkoSJs71gCW3k30B1aIx2stgIVFdoB9mdkB5A9sl19QPa7Dhypj8
   h6IfIK47xLe7YQ5A7P4UtPaygahyll9qJKBa+TPveRAjQKTR7Cka4X08A
   M4XFxPPKgkj7vdFnXUDNmNxVCI7cFFrvGQBrKpgi/sneqgwgF1SBveT/z
   yajOWoL84vMAiPRx17v0WfnjldiRy/6GCJHDjR2P99MczHzNBbckKqiFr
   TrpVCCP3Vj8D0EeO1Cn5I1c4+mWN+6JH14eRu9cQVyQlNF6Fzxo9Ffrei
   FQ5ad4vr4/Y7KmEfCz1bJeKmT3V8xCbFY5zRv2nwjTmIZnhN/DVadH8w2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412083610"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="412083610"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:33:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="783300102"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="783300102"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 24 Sep 2023 19:33:07 -0700
Message-ID: <ad9644a2-e8a6-d0fa-ad55-f4e0564c39a0@linux.intel.com>
Date: Mon, 25 Sep 2023 10:29:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH 3/8] iommu/vt-d: Use ops->blocked_domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Hector Martin <marcan@marcan.st>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>
References: <3-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/23 1:07 AM, Jason Gunthorpe wrote:
> Trivially migrate to the ops->blocked_domain for the existing global
> static.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/intel/iommu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

P.S. We can further do the same thing to the identity domain. I will
clean it up after all patches are landed.

Best regards,
baolu
