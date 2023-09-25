Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD115AF;
	Mon, 25 Sep 2023 02:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695609066; x=1727145066;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uSKF2LkBbCOJvzhdcYIdKnGGrppJwIiNPHQWNKzX1pg=;
  b=NwtCYowcZc2c5N+7ogjJT5mjMCM6uJcHh/TDVCPlZWzLvi6mqWM9ErTM
   1txeqbJl5KRieUYNLt5oygnwIc0vUGMhHuzuazlnWaC5l44aq844otNuv
   jpIhJvjtXVHTxiXtHG5vH1HbMbNxUTaEqzRS6ocPD+yqQ5AjlODwR4y24
   nPhqigfQBhb3InpTay7LVE4Bywp/zNKlrQ49S3xD+n6ve6IjZEGtex2rw
   Q2NzxZGXFmtNNRGXtoyStjhq83LsovUR5pyjzlXfE7Nos1dCB7oR7X8PS
   hDLvGi/NjBDZ9YOAFkfqsYj0ZVrJ+ki8aVjXa2tyr1Ek1fKdwMKiaWhAv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447636205"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="447636205"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="741746289"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="741746289"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2023 19:31:01 -0700
Message-ID: <556c732d-bf15-a14a-ff6b-e770aa6bc797@linux.intel.com>
Date: Mon, 25 Sep 2023 10:27:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH 2/8] iommu/vt-d: Update the definition of the blocking
 domain
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
References: <2-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/23 1:07 AM, Jason Gunthorpe wrote:
> The global static should pre-define the type and the NOP free function can
> be now left as NULL.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
