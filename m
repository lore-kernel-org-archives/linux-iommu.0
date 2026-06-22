Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20322333429
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 02:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096497; cv=none; b=Rt71GIykqtZWAuOjBII7kW0f3VlrGo+Wfiedbm9GnnuFZSLdHvcl6XZs4x1Z7RLBFFUQQdTDfMZc1L6ML62WyE5ng2I5Q3JpXcYxr7edz3LPFrLKvNY2tuJDpSusWz9mNeyW4a8FvPNoLwONrC+qyUeDQoIMRuiicPK58wI6i+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096497; c=relaxed/simple;
	bh=pj/RajTl5IOiHjklPG4MR4kM7xXSdwQBL/9H2qH5kVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Chd70N22SOS8yuIQLaM9KfANPdeN7QarWskvQelW6qMNRBvbRK8eEhQOGnC8GjkCbkthlccD+tZkOHjHTz2QemhEDBbdutnxhqGeTZnwmR25Trtu89v9MSJSTWKlW0HlbU1YKKbj/Pm5IKWozFFtBfnZowm3vBA9sWaAIUjp510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JetgvMGx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JetgvMGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782096496; x=1813632496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pj/RajTl5IOiHjklPG4MR4kM7xXSdwQBL/9H2qH5kVU=;
  b=JetgvMGxSne4rF0OyRch9seBruIYUzb+7jJ68eKCY8XMmids5YgVXVek
   8Oln8vEzWk/CnL9+ZQu+GxJsUh8TvjcBuksaACy2RSTru9bGa5kAlOqTT
   qw8S2zByWZFda/IznyzPWxchV0PHpSw46SsBK9EPO0IdDrYVRIp0eU7TO
   /CWDQOwYzM7N2N5Mujjckgi6HjQSksJxGqvIYepdBXmEKfaRBnpbyror4
   p/9bxFKl/erah3kasy3j/I1SxZ3VVzSia4nYnOjvBZKAVXZQbf5kEEV4Y
   B9C+wMR4n+Nv40NTqW3Z6dA7bdVF5qzO0vVojgiflSPj5CEDlH5Xe7V+8
   g==;
X-CSE-ConnectionGUID: CPOfcfV4SaaGFeA6LmNEXA==
X-CSE-MsgGUID: Mb4Xa/5yTVuMSlHz6Al9QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93188095"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="93188095"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 19:48:16 -0700
X-CSE-ConnectionGUID: u9Eg5v/2QTGN0pgVUZmaBg==
X-CSE-MsgGUID: IK+UPpu7St+LLiztrSd52g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="249210480"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 19:48:11 -0700
Message-ID: <51e03b42-796c-489c-a0fa-525ed1a492ca@linux.intel.com>
Date: Mon, 22 Jun 2026 10:47:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/18] iommu/vt-d: clear unpreserved context entries
 during shutdown
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-9-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260614233728.2212104-9-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/26 07:37, Samiullah Khawaja wrote:
> During normal shutdown the iommu translation is disabled. Since the root
> table is preserved during live update, it needs to be cleaned up and the
> context entries of the unpreserved devices and root entries for the
> unpreserved context tables need to be cleared.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  9 ++--
>   drivers/iommu/intel/iommu.h      |  6 +++
>   drivers/iommu/intel/liveupdate.c | 74 ++++++++++++++++++++++++++++++++
>   3 files changed, 86 insertions(+), 3 deletions(-)

Please tweak the commit title to: "iommu/vt-d: Clear unpreserved..."
(capitalize "Clear") to match the driver's commit history style.

A high-level question: have you looked at how the suspend/resume path
behaves with the iommu and device preservation? DMA translation is
disabled and re-enabled there. I don't see any immediate changes are
needed there, but it would be good to call it out explicitly if it was
overlooked.

> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 715b538e7efe..26258861e3bf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2374,8 +2374,11 @@ void intel_iommu_shutdown(void)
>   		/* Disable PMRs explicitly here. */
>   		iommu_disable_protect_mem_regions(iommu);
>   
> -		/* Make sure the IOMMUs are switched off */
> -		iommu_disable_translation(iommu);
> +		/* Make sure the IOMMUs are switched off if not preserved. */
> +		if (iommu_preserved_state(&iommu->iommu))
> +			clear_unpreserved_context_entries(iommu);

How are PCI devices handled during a live update kexec? Do they go
through the standard iommu_release_device() path?

I assume they do not, because if they did, the context entries for
preserved devices could be updated after preservation. If they do bypass
the release_device path, why not just explicitly invoke
iommu_release_device() for all devices that are not preserved?

Using iommu_release_device() for the unpreserved devices would naturally
erase their context entries and securely park those devices in a DMA
blocking state.

> +		else
> +			iommu_disable_translation(iommu);
>   	}
>   }
> 

[...]

Thanks,
baolu
