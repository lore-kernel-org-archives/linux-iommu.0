Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C364A
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 02:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692758562; x=1724294562;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j2fcy9XeTyi7lyzHRzENS3KkHahyZ7go/+rVh3lLPqM=;
  b=nsZO5FK/Rd+1CdQpGKSm3ZPmY7v6mCVu+AIa2NsSUCGgN8PvyUUEGtT1
   GiiBV11cx9pT+XUd4z/BTtKZNXevUMsq5LEQCqgAjHgd1Ib2y8nzhPtx9
   ZVJfSJn7D/LYhxe86WXLin6l/XULHwmGjMdb1MOELjkHnMTpdKdIhDDit
   TX9Q1wtLrqART9K5WvuPoUrhSWVdE5FI6rzMPrU/nlDu6sENqgRSQS4Dn
   5fe5yEXuaTAak3EPeoaWqFG6kFBHvNMOVO6Bcx+KoItsP+PnIh4fED4oJ
   v67CVnhwjevvOQuNLIDuiDCPBl7gNnVrTFwuR+YBteFxRw/bF07Gp0Tv3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="364226472"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364226472"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="826551870"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="826551870"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.189.105]) ([10.252.189.105])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:42:33 -0700
Message-ID: <4ba43e04-965a-4002-ac8d-58a798c25975@linux.intel.com>
Date: Wed, 23 Aug 2023 10:42:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, nicolinc@nvidia.com, tina.zhang@intel.com,
 jean-philippe@linaro.org, will@kernel.org, robin.murphy@arm.com,
 jgg@nvidia.com, Dawei Li <set_pte_at@outlook.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 0/9] Install domain onto multiple smmus
Content-Language: en-US
To: Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230822105738.1607365-1-mshavit@google.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/22 18:56, Michael Shavit wrote:
> 
> Hi all,
> 
> This series refactors the arm-smmu-v3 driver to support attaching
> domains onto masters belonging to different smmu devices.
> 
> The main objective of this series is allow further refactorings of
> arm-smmu-v3-sva. Specifically, we'd like to reach the state where:
> 1. A single SVA domain is allocated per MM/ASID

The core side of this work is under discussion.

https://lore.kernel.org/linux-iommu/20230808074944.7825-1-tina.zhang@intel.com/

Just FYI.

Best regards,
baolu
