Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8BD1FC4;
	Thu, 30 Mar 2023 12:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680180333; x=1711716333;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aABDzXs1bbGmAjh5kX353PzoweJ6hhUk3tT8mRFmXAM=;
  b=BgmYMRhndoBwIvPQFv6+dN7btLpq293cf/7msaDP35QKhLGmn7AOeCGb
   DwWIHPqfu02DvPfDJIX4yYINjZRUgDNSAqYwSMqF3AAyQuk/erGvWlUzQ
   NmxPoSzJxku77mm4jawo2biD92JTQ0yUB7w/wUWBLMAJIP0hgLahR0Gy5
   uJfACGVfWddokuGnaqTSUGix9XmX+5q/7WeUQgn+x0Hau/GpPsuL2H0nA
   dl1JTFzIe3IVUb+FN2J+ARC33ejsekUEK0EfzxUgWbHW46NjT4zixAmG9
   LFwuMW8l2/RvgO09yNEX33LZRLvMxFPz1tYSUTMt8OuEiLOHESH+lczqB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="338655378"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="338655378"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 05:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="753985721"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="753985721"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.251]) ([10.255.30.251])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 05:45:04 -0700
Message-ID: <76c782f4-7c18-4dc1-8a70-9517fdb1506f@linux.intel.com>
Date: Thu, 30 Mar 2023 20:45:02 +0800
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
Subject: Re: [PATCH v2 14/14] iommu: Tidy the control flow in
 iommu_group_store_type()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <14-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <14-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/30 7:40, Jason Gunthorpe wrote:
> Use a normal "goto unwind" instead of trying to be clever with checking
> !ret and manually managing the unlock.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
