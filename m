Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E593242D95
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998673; cv=none; b=EX5V7FbBPZD0+u0uLrtq4PCS2Fgk+dE4HnI2Mi4yLCmkgJzgFliZIAHnozofiQ15F2unzSO3f727oNtSdVOqy8tz5tqZKol4nNPXJ4q0T9G5mg6psuVNTjAMo5ekr7XFNViM2vlDJKhk8DEeH4SwfASqX8V5dCnPvFt50NQup5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998673; c=relaxed/simple;
	bh=2ARSQzGI9sG9ij30S7la4f0PdtN1kITFu2sNCpYxHP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EgFoQVnaC1I2Z+1IHYTirM0rwwuiLGiugdKuAWtHmuvlRjX7DLK4pNuUmaaWGOsIN+XXh6ERKP8gHIFd1Smb3GDkgEn13p6sFPslqdxNb7LbD1nqNwIbE2WYlScv036aZ9XMAab7mREYWud8sHcPFUF1bLfqvETrFe4lq2RdBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oC2TvfuE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oC2TvfuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757998672; x=1789534672;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2ARSQzGI9sG9ij30S7la4f0PdtN1kITFu2sNCpYxHP8=;
  b=oC2TvfuEuGipXIvon2bTPmbnrTrUQeaokdJHkcZ+uDifIrDEHtJdw6Os
   hLxapNR2cMQkLwAf8gWgLTQl6Eto7L3WNWdSVMRSNrB50b0AdMxYux7DN
   rL6KtMrUljxg4+ypu1DAIIB7L2f9fV0SnYrf1lq4NEV0Rq8MRsnPizuI4
   UgxazWZf4Qf7CkiuU1CFmBkvG9MT33QOHMM8Wl8MC8PIwqrRZB3yvQW+K
   bIuDul66KmYSq1IhjeDByk+AG32sstwsE+cGPjGq52r9cT1F8fKAm0RfB
   fgav/1fpdDRLPn9PMa8NpDUz/Q9ieVSCxOxth0+sFC8YJLlP8ZGflQDty
   w==;
X-CSE-ConnectionGUID: TZ9KuMl6Qcy0NNKwoTtX4Q==
X-CSE-MsgGUID: JgAFpkGUTx6YBVJddX8zcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59489801"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="59489801"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 21:57:52 -0700
X-CSE-ConnectionGUID: QmPtT1nFQW6s5zSlmaXf7Q==
X-CSE-MsgGUID: +wrmmyR8TkuHjdS/Okz7Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="174382610"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 21:57:50 -0700
Message-ID: <ac6daeb3-41b8-45f4-b4d4-ff8d569c4cf5@linux.intel.com>
Date: Tue, 16 Sep 2025 12:55:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: drop unused cap_super_offset()
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250913015024.81186-1-yury.norov@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250913015024.81186-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/25 09:50, Yury Norov (NVIDIA) wrote:
> The macro is unused. Drop the dead code.
> 
> Signed-off-by: Yury Norov (NVIDIA)<yury.norov@gmail.com>
> ---
>   drivers/iommu/intel/iommu.h | 2 --
>   1 file changed, 2 deletions(-)

Queued for v6.18.

Thanks,
baolu
