Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAC185D;
	Thu, 30 Mar 2023 06:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680157345; x=1711693345;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mm9fLdmkAZnHHfC+nSJjtz1gaO9rbdpUZOXZFTChUwo=;
  b=DPqUL9heXiiwJxVMLfwo9F2Ef/pcR1ibpu8bNw6C45LGPJJAo0cXp3QT
   qD28bkUkCzDYu3OwXmZ7yV57JKEFPwETfelDCTv3nYqGzhNIu1RmDJNPV
   suTB+Xz65+JbLJTIFVvEQMVtNAAepfji5/0SrL0SAZ6rCyqmum41hML77
   guOXpQ1nbruYvnOQtM7KCajyhactz5TGsj+uu9VGHmKjkUkYwi19SSX9v
   dbMKhkr9mxvFCxcBs2OMBpaEEPqBZkKccXvViZ98LVtydiWdNenT+hzcz
   V7qFDAryuV6zLsMjBgZurzGeXIouC8B6RgktDB313FkjuNGfNZK7QFgs2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403731236"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="403731236"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714877768"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="714877768"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2023 23:22:21 -0700
Message-ID: <44ffff8d-9e4b-0a5a-694b-26edd46d5c5c@linux.intel.com>
Date: Thu, 30 Mar 2023 14:22:38 +0800
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
Subject: Re: [PATCH v2 01/14] iommu: Replace iommu_group_device_count() with
 list_count_nodes()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <1-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/23 7:40 AM, Jason Gunthorpe wrote:
> No reason to wrapper a standard function, just call the library directly.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
