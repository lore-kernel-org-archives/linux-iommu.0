Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0A179AA
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244791; cv=none; b=D9pACd9rEFLOEIm26oMxjSqEY2eNrehszbQi8thFzh7OtYJrwWUucDrKy/1LP0zZ88Gpn7tGwP/k5QJoLNAAM8C+HAqnQE4iG2+7JR6m4ZrFBZmbTFCZe0Wzh2Y5uJY7YFNnqcy3nQE4E+2mfxfyE/eBzoqBXfNbXt5uM+WYcak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244791; c=relaxed/simple;
	bh=hCD0lhf9UrsR3cHabJeE+8UdsFm02SwQKqkiHbb+S2g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AJtbCC2d+CjzZzuYJprdraFUymTaRN/8EkYW48esjV5fcHOOP8k6IL7e6S/RaJQhBKb8t44hcnI0tUv+Y7L44vHkRWVCjJbO7hH36h/iUC1+jKrdH3P5a/cgRYvwCE68AZ2rbXkNWnOeXLwnGWrx4qTObElwy2SW7osP8zlLscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pg9pjjbm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pg9pjjbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244791; x=1756780791;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hCD0lhf9UrsR3cHabJeE+8UdsFm02SwQKqkiHbb+S2g=;
  b=Pg9pjjbmvDziHVEJkBWD1PM8bOvKJX6GWs+fbokZRXXEVQoVUMpi3gKt
   Yuxm/OG+wkcA5DosF6fl14hvOOjVwMakrFB1eBtHmB7EYXpU0ODCrzFT4
   orDbXfT7+vzFryvdoBmUCa0LQ2vIiREiVv3Vc8yXIU0OuPI4Ei82SbFYi
   ED/TzdMbsB59WTR5YU7LdnS0CBmKQ5VYI9/DAw6CjL1mjI4V94QY9ZoZE
   iMSGdLsi4r4Xt/oWkD59wBiw8cYzxIsmoIhgLzKwjktFsfQALEx5CWk1Y
   HrvyOwyX9cmDZTbIEz3rLBYB1LgEGPq2b8r5PdDKPmN9vOJXs7UkRVNgZ
   Q==;
X-CSE-ConnectionGUID: 8WKqg/BMQ/WM4vS6v4J+pQ==
X-CSE-MsgGUID: ArCD1oqVReuW/orpMogJTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34970978"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34970978"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:39:50 -0700
X-CSE-ConnectionGUID: Vvw2S6LERzmBwcXvTVFedg==
X-CSE-MsgGUID: JrQGoICJTqqoV9nwgTGo1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64505180"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 01 Sep 2024 19:39:48 -0700
Message-ID: <b64d095e-a9a6-4df9-b693-9cd6018eb1a5@linux.intel.com>
Date: Mon, 2 Sep 2024 10:35:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, tina.zhang@intel.com,
 Sanjay K Kumar <sanjay.k.kumar@intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Fix potential lockup if qi_submit_sync
 called with 0 count
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
References: <20240728210059.1964602-1-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240728210059.1964602-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 5:00 AM, Jacob Pan wrote:
> From: Sanjay K Kumar<sanjay.k.kumar@intel.com>
> 
> If qi_submit_sync() is invoked with 0 invalidation descriptors (for
> instance, for DMA draining purposes), we can run into a bug where a
> submitting thread fails to detect the completion of invalidation_wait.
> Subsequently, this led to a soft lockup. Currently, there is no impact
> by this bug on the existing users because no callers are submitting
> invalidations with 0 descriptors. This fix will enable future users
> (such as DMA drain) calling qi_submit_sync() with 0 count.
> 
> Suppose thread T1 invokes qi_submit_sync() with non-zero descriptors, while
> concurrently, thread T2 calls qi_submit_sync() with zero descriptors. Both
> threads then enter a while loop, waiting for their respective descriptors
> to complete. T1 detects its completion (i.e., T1's invalidation_wait status
> changes to QI_DONE by HW) and proceeds to call reclaim_free_desc() to
> reclaim all descriptors, potentially including adjacent ones of other
> threads that are also marked as QI_DONE.
> 
> During this time, while T2 is waiting to acquire the qi->q_lock, the IOMMU
> hardware may complete the invalidation for T2, setting its status to
> QI_DONE. However, if T1's execution of reclaim_free_desc() frees T2's
> invalidation_wait descriptor and changes its status to QI_FREE, T2 will
> not observe the QI_DONE status for its invalidation_wait and will
> indefinitely remain stuck.
> 
> This soft lockup does not occur when only non-zero descriptors are
> submitted.In such cases, invalidation descriptors are interspersed among
> wait descriptors with the status QI_IN_USE, acting as barriers. These
> barriers prevent the reclaim code from mistakenly freeing descriptors
> belonging to other submitters.
> 
> Considered the following example timeline:
> 	T1			T2
> ========================================
> 	ID1
> 	WD1
> 	while(WD1!=QI_DONE)
> 	unlock
> 				lock
> 	WD1=QI_DONE*		WD2
> 				while(WD2!=QI_DONE)
> 				unlock
> 	lock
> 	WD1==QI_DONE?
> 	ID1=QI_DONE		WD2=DONE*
> 	reclaim()
> 	ID1=FREE
> 	WD1=FREE
> 	WD2=FREE
> 	unlock
> 				soft lockup! T2 never sees QI_DONE in WD2
> 
> Where:
> ID = invalidation descriptor
> WD = wait descriptor
> * Written by hardware
> 
> The root of the problem is that the descriptor status QI_DONE flag is used
> for two conflicting purposes:
> 1. signal a descriptor is ready for reclaim (to be freed)
> 2. signal by the hardware that a wait descriptor is complete
> 
> The solution (in this patch) is state separation by using QI_FREE flag
> for #1.
> 
> Once a thread's invalidation descriptors are complete, their status would
> be set to QI_FREE. The reclaim_free_desc() function would then only
> free descriptors marked as QI_FREE instead of those marked as
> QI_DONE. This change ensures that T2 (from the previous example) will
> correctly observe the completion of its invalidation_wait (marked as
> QI_DONE).
> 
> Signed-off-by: Sanjay K Kumar<sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Queued for v6.12-rc1.

Thanks,
baolu
