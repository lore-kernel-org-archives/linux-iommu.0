Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB771FAD;
	Thu, 30 Mar 2023 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680177100; x=1711713100;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aCmf4rglJvXNejCmojYMvYzgNhY4IBiSgtP09G4LG7w=;
  b=O8TDhO8bWcVz7FzOLAyCk/gwn3Em+vtzzN2wR7R4+awKNuKnB+p7Vgsm
   o4K4BZaAWkgpLv4QEheNz1fMyJER0Mk+eyKXsNSWf/kMBEy7a4rU2OnMM
   u1Vu6Dk88Q2yTx9QSqPyPYZNa4DHYl6EQ8PEuA2DvU2T8HIcjD05Mr8IC
   qrAewjhWF1GPTxU7zDElpbCQ76rC2o0QJBz6mzCA6AivSWLDk9oOemBqV
   bPFbD2LjDErQM0ZQfUtlGdoienHCdOqAbMLOoanjuN/4EzlcYlx8ANrZi
   IRmpns20N1UJlQkDdK9iw7py333fdPhhxFBy8VU2UVJ+OVrPSSRUiGJph
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427421036"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="427421036"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="687205871"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="687205871"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.251]) ([10.255.30.251])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:51:35 -0700
Message-ID: <7f667a25-8dbb-2012-871d-acf2665bdf58@linux.intel.com>
Date: Thu, 30 Mar 2023 19:51:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 11/14] iommu: Consolidate the code to calculate the
 target default domain type
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <11-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <11-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/30 7:40, Jason Gunthorpe wrote:
> Put all the code to calculate the default domain type into one
> function. Make the function able to handle the
> iommu_change_dev_def_domain() by taking in the target domain type and
> erroring out if the target type isn't reachable.
> 
> This makes it really clear that specifying a 0 type during
> iommu_change_dev_def_domain() will have the same outcome as the normal
> probe path.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
