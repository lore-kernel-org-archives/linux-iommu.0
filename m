Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8DB65F
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 07:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151495; x=1706687495;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kyUTQkrz9mWJxP+tOYE6CbK4sQ6wiEtAftpUXLRxRs0=;
  b=Xz47mGKZ4eqpa+sYMexQzOB4z4KlHIAaq2z2Hj9JRqLY3hrKqSnksG4n
   wfRg2m7Pjx+8mMcwWNOfoPEPiWaMDpg3COsljtPOpGa5YG03+lIB2sSTM
   YsAJdNm19DhDr5oQUMQLclDGBBCPGwkoxuWh/4NVlK0c+XZz8nOw0irqU
   DNOHGxKwmGAie0URqzKa+9PRPTNNPsrro+NSG2PqZJnL/wqO/L0aMCTvK
   J4DQgNUEJAwDHKwBssDl9UqAJdtwcWgCr6qhc+c3e/I3wCSNc2ramtHSZ
   JnZmoYxRbNkfYAKRhJy51XxZYQvCW0WdJtDHldeqy9vsnG37zhe8GaWvo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="308120199"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="308120199"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:51:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="909813199"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="909813199"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.172.41]) ([10.249.172.41])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:51:32 -0800
Message-ID: <a766837f-2c24-68bc-d0c1-74e64f8aa97d@linux.intel.com>
Date: Tue, 31 Jan 2023 15:51:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iommu/vt-d: SVM implementation cleanup
To: iommu@lists.linux.dev
References: <20230109014955.147068-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230109014955.147068-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/9 9:49, Lu Baolu wrote:
> This is a cleanup series after the merge of commit be51b1d6bbff
> ("iommu/sva: Refactoring iommu_sva_bind/unbind_device()"). It removes
> the unused/duplicate data and code.
> 
> Lu Baolu (4):
>    iommu/vt-d: Remove include/linux/intel-svm.h
>    iommu/vt-d: Remove unused fields in svm structures
>    iommu/vt-d: Remove users from intel_svm_dev
>    iommu/vt-d: Remove sva from intel_svm_dev

Patches queued for v6.3.

https://lore.kernel.org/linux-iommu/20230131073740.378984-1-baolu.lu@linux.intel.com/

Best regards,
baolu
