Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9A63BC
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680786294; x=1712322294;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4m7lbwkH0xe8YoItCdZMQ65J4/rvO42XX0WYtA2Hflw=;
  b=FzXgnkTJZUXOiQzKKZeFPewmKxmwVJm5k9IAxzebNgFw2+Bb8bn6p+F1
   YtoWrCi8FPHHrMXBemWOUjX2AfgQMiS1oi7UcIKA+995tL/hUprBckNuV
   LQDkg4/gO4egqn79TPgwI9SBJ8z8jP24SfNZyq+ES4y+1JtckA4jBKghI
   BE0uzIsNIpwTnTtIRce3O6hyQGVowGV0ceZJQ5brcC/P8OdLEcoVi3Ja8
   0LAtE/A5hFU/lqQAbCVIu0QV+6xRtu0D031nn/v4iA217k0cJmCPMve4y
   +6yh4/SbeaSYKWx9kBG+GWdevQfIu1SilOig3BfIwcX3HuISus5rjNinT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="405524076"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="405524076"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 05:48:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="687115398"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687115398"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.177]) ([10.255.31.177])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 05:48:03 -0700
Message-ID: <ac9ad124-8cfc-e0af-bf7c-5cbbee48a695@linux.intel.com>
Date: Thu, 6 Apr 2023 20:48:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/sva: fix signedness bug in iommu_sva_alloc_pasid()
Content-Language: en-US
To: Dan Carpenter <error27@gmail.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <6b32095d-7491-4ebb-a850-12e96209eaaf@kili.mountain>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6b32095d-7491-4ebb-a850-12e96209eaaf@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/4/6 16:55, Dan Carpenter wrote:
> The ida_alloc_range() function returns negative error codes on error.
> On success it returns values in the min to max range (inclusive).  It
> never returns more then INT_MAX even if "max" is higher.  It never
> returns values in the 0 to (min - 1) range.
> 
> The bug is that "min" is an unsigned int so negative error codes will
> be promoted to high positive values errors treated as success.
> 
> Fixes: 1a14bf0fc7ed ("iommu/sva: Use GFP_KERNEL for pasid allocation")
> Signed-off-by: Dan Carpenter<error27@gmail.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
