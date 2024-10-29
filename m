Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24FF1F4FA8
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 04:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176884; cv=none; b=SL1MNzCDGZTcpoXa1ifuvxqiHIGK7hYBCzACQwvjq+G8OaNJ82+pyMJ7WYA4DBkIqER7rxPJN0G9vM2UwFKAVO9EKKKmzHY7HYquOTGr+1PLDmGe5fCP6JfH9oZnKVZMqCFfrVhkqDGalYgVsBWOeSenKoSU55hf/ditAnmz3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176884; c=relaxed/simple;
	bh=/lGgzYCuXKNlA3wX0mmt+/FRFK+05gsYDqzyxHNFDJw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CpwR4WjYYLBUFBjuGTPJ9zcffFjqFZQGI35osPZ7oNBsWdA40matgFmrDQ9/uijdvwo4aO5odRsfaWl09hYL0rxmxgz35BT8KYKPMvE+LP8Udn/Qj8SUZELU7dzdyc1aeX5y/3UqzVe001DPXhYxOeOEYJcdDPoRbsO5JClKR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHa6oFsI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHa6oFsI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730176883; x=1761712883;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/lGgzYCuXKNlA3wX0mmt+/FRFK+05gsYDqzyxHNFDJw=;
  b=XHa6oFsIMJNtBCDAwtC+719TB2hXALfE454KrKmd5BH0lKeuRrMERpzY
   mr0axjTvEXKoRh6kRzrcYyqvUCs11SGdDLcK5TS9t0hARX5c5vm6Ia2Bw
   BUuFyg6jBYOtSq+CmUX0lBJ2O5KBMnlz2OZCWrA4E6vSkJa4gtgig5ArD
   SZAhQwiJxnlnWruIYAERZ4I3010yLUigvpQdwDaMUj526Jdn5xWUZXyvX
   JvLldF5KfRS1rBLDGwHv8UfrNJXbYPX2HQbSJnXFVsNw+1Kc5PfCqLqft
   vXkRxH14rwY+Yqx+eOXNIOAgjFyYXTfTjbBMasLZUyEsriB0a3qOK7Izu
   Q==;
X-CSE-ConnectionGUID: CyT4iRnzQOOKr4v/RY1lKg==
X-CSE-MsgGUID: 4RhGIj5lQoyAKmvX5QU8fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32656003"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="32656003"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:41:22 -0700
X-CSE-ConnectionGUID: u2v94uqrSX2Z3iF/czjreA==
X-CSE-MsgGUID: m+idzGaDST2Kr16oLni5mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86966215"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:41:13 -0700
Message-ID: <cd377b12-5982-4c41-9f82-ee35cd8a6433@linux.intel.com>
Date: Tue, 29 Oct 2024 12:41:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Remove unused dmar_msi_read
To: linux@treblig.org, dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com
References: <20241022002702.302728-1-linux@treblig.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241022002702.302728-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 8:27, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert"<linux@treblig.org>
> 
> dmar_msi_read() has been unused since 2022 in
> commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> 
> Remove it.
> 
> (dmar_msi_write still exists and is used once).
> 
> Signed-off-by: Dr. David Alan Gilbert<linux@treblig.org>
> ---
>   drivers/iommu/intel/dmar.c | 13 -------------
>   include/linux/dmar.h       |  1 -
>   2 files changed, 14 deletions(-)

Queued for v6.13. Thank you!

--
baolu
