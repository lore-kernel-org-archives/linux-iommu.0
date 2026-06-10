Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542442D2483
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061777; cv=none; b=EEnhFW61nd8n2eQmvOeLLrcvTLr23/EmGDT3z5t34ffQx7EP/cKucA64TQjKtA/C79bnr6h17Om7VWrlL7IILOpqcLV652G2xcIEuynoqIz33BkLcZd2lHK4M6mojuJ/2hwpCwjl71F6N3ltxeaPMwWQ2A7Q5/5XgpPfzr/itVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061777; c=relaxed/simple;
	bh=YrWemvFOnoDyzRs4mVeFr05jMmA+83uJCITCnLbO+Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxeajaHCuzrr7l/PNZe3yxW92gr1wO/7w2+Ob8Gjt+ewZh7M2CskRqYqC9DaMzW9zkCIFDkEBdwrE8p8EeoATEVyD6NONdhqUbpqPXBJ8YFbnvI4jp0xlgKbZFAFwMmtPQKPw3ifixctW+qjG23cJuUrFEV3M5kSipNcSxkco+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZRMZjut; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZRMZjut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781061776; x=1812597776;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YrWemvFOnoDyzRs4mVeFr05jMmA+83uJCITCnLbO+Qw=;
  b=jZRMZjutKqzumhpGks6Hso+IQOYiJqosA63PNbkqaRwk/jdyuMuJPY+O
   3ecyB+LxTeoXNkGpuEWfDCr1BdGNiWPtkehN/65FrTIawOToSLlNKWyHT
   Cm65CUBn42ZG4y17zzksvHScfntPw24jtPgKC367UCUzHOK0hjf0kgbrN
   D5jt3XcgHg+UfRhFPvmDdPTzd5zN2iPlnMQBWQp+d5hg0lKt6dQb0MsMJ
   3qe/WS4akZ1XddagVsTp4GxVvROsA/bx//wfVOTE1/UDz4G/uV5X8/n3X
   H/X4Bcxq3Sqgqv0Enm7p5fW1Lgfw8V7wjKiGrx6WeCgbsEDTIQht7/viM
   g==;
X-CSE-ConnectionGUID: YFAuTwSHRBGA2nkhDhQv4Q==
X-CSE-MsgGUID: Nd0Oa1AnSFibaMqUYTCgJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84414105"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="84414105"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 20:22:56 -0700
X-CSE-ConnectionGUID: nPiNJsxIT46mPiQ44RURsg==
X-CSE-MsgGUID: 8Vm8nmjOSnqWUTkdHpMCWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="269720293"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 20:22:53 -0700
Message-ID: <414a7d18-037b-4361-8b43-84e618f256f1@linux.intel.com>
Date: Wed, 10 Jun 2026 11:21:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] iommu: Avoid copying the user array twice in the
 full-array copy helper
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Shuah Khan <shuah@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Kees Cook <kees@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1780521606.git.nicolinc@nvidia.com>
 <6c9eca4ff584cb977661e97799ac6fe934e7f51c.1780521606.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6c9eca4ff584cb977661e97799ac6fe934e7f51c.1780521606.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/26 05:26, Nicolin Chen wrote:
> iommu_copy_struct_from_full_user_array() copies a whole user array into a
> kernel buffer. In the common case, where user entry_len equals destination
> entry size, it takes a fast path and copies the whole array with a single
> copy_from_user().
> 
> That fast path does not return, so it falls through into the item-by-item
> copy_struct_from_user() loop and copies every entry a second time. For an
> equal entry_len that loop is just a copy_from_user() of the same bytes, so
> the whole array is copied twice for no benefit.
> 
> Return right after the bulk copy. The per-item loop then runs only on the
> slow path, where entry_len differs and each entry needs size adaption.
> 
> Fixes: 4f2e59ccb698 ("iommu: Add iommu_copy_struct_from_full_user_array helper")
> Assisted-by:Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
