Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD01A6814
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061444; cv=none; b=WsTsboZ06v+Ip/vwJz0PMI5nRvi4lApTh/DkGhMwrtYsFfLngLbpl8bM7+FwTfN2ChSMm0e3RtUBO8xvdRefgno91NFFlfo0IA98dpmRrr4oweuV6OG0vs/UCadNYIcaACD4ehXc4l1LR4ii9kJ6+E6Lqi+4mPUGayLUkvGn1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061444; c=relaxed/simple;
	bh=0EEZiPOgIhJKF7ggkB4ySQ088W91sUeLQCXaineGcS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYPND2yJsOhdjZJxAmuFhr/NYn5TdLVuGP8U5Lp+px3cp5NLrmV7BY0BwwcmKEEnk4IPBWuSVYQCAOkpxeanaVB7KLS8HjciIMhlvTHH3wxjyqPaayZIBiOTLV9TmR0Ki6GqjKH29XJza1KwH2Vv9GjObUKZHwp8UoctgbYg/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fz5j9b/L; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fz5j9b/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781061441; x=1812597441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0EEZiPOgIhJKF7ggkB4ySQ088W91sUeLQCXaineGcS8=;
  b=fz5j9b/L5AYccsGZQUPXe58TSvDyYvjSYKAPPTsv3YrOZmY+f1F31JTx
   NWtQC6LJB35zSb8UUvU3+slBcGhRqJlzknMRZ78VOj8YW3f/wvfbmrKzf
   vhEWU64SbVat0fTdk0Cz5gtgQx8cnh2RR84zfsH8aDhijHw7DeImclxk7
   plvodVYn+QvJbzrSQAb7XynO8yXnycnhp8hXDuC8E/aHAm33fymsiIf2s
   LSO1Mi2QGFVhZ+klDDX22j8apfFpZuFQakXLZZyd2tzfELuJVRlSM9Fqm
   1Z5jpk5FNGOxfKwRyDfOnvE/Vy/cErej5JqBgZXFShzDH7svLUhzaJOY9
   g==;
X-CSE-ConnectionGUID: LBtd7d5sTruPFtE9qi+S1g==
X-CSE-MsgGUID: pTMV0BJuRhawbludAqcnDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="69379171"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="69379171"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 20:17:20 -0700
X-CSE-ConnectionGUID: nrt6CnzBQhSMVAAkpuxs4A==
X-CSE-MsgGUID: qfKH81A3QUSFwkYW5xaSsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246067137"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 20:17:17 -0700
Message-ID: <b2119f23-190b-4dcc-bc63-9554f0f8383a@linux.intel.com>
Date: Wed, 10 Jun 2026 11:16:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] iommufd: Set upper bounds on cache invalidation
 entry_num and entry_len
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Shuah Khan <shuah@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Kees Cook <kees@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1780521606.git.nicolinc@nvidia.com>
 <447fa93663f7526eb361719e83fa8b649464483d.1780521606.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <447fa93663f7526eb361719e83fa8b649464483d.1780521606.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/26 05:26, Nicolin Chen wrote:
> iommufd_hwpt_invalidate() takes a user-controlled entry_num and entry_len,
> each bounded only by U32_MAX. An entry_len beyond the kernel's struct size
> makes the copy helper verify the extra bytes are zero, scanning that excess
> in one uninterruptible pass; a multi-gigabyte value over zeroed user memory
> trips the soft-lockup watchdog.
> 
> A large entry_num is the other half, driving the backend invalidation loop
> with no reschedule. The VT-d nested handler, for one, copies each entry and
> flushes caches per iteration, pinning the CPU on a non-preemptible kernel.
> 
> Cap both in the ioctl. entry_len is held under PAGE_SIZE, above any request
> struct, and entry_num under 1 << 19, the order of a hardware invalidation
> queue and well beyond any real batch, bounding the per-call loop length.
> 
> Fixes: 8c6eabae3807 ("iommufd: Add IOMMU_HWPT_INVALIDATE")
> Cc:stable@vger.kernel.org
> Assisted-by:Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
