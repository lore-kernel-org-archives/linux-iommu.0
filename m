Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE73009DA
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768370646; cv=none; b=qoSnqhyaVcU2Mo9fYL7Ora/UkVN/EOUmsI0ko010h2C2hoGOsgozIKIMiIB8eHEMJKKCZ2qmydH5UDmWGZXS558bDqH6XUmRRNYB/UMMY/pi8tItQlJQ3NnhudK4II+ufX2/3OHHH15hN3WblSH9aDvBdhsawXscyud81+A/DUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768370646; c=relaxed/simple;
	bh=Hrl4UFUgu9uNkxaAAvg7noSOe/rnq8FJxg3jjpVBJ04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMfoAXLWMScGPYG/+CW2JnOlVMbCTQagXXIKGrzNJ78GfYZLiXDyo/53HKkwiR7VyJbzqOApdAo0oOcgu4v65Ud+P2BEHa1OeIVBEmHuNp3D21DhzWQtTs3gk6lOvD+q+4oZFTwWF7eCYuQgKtBktu+HpXyI7oI7Wb4+0COnZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNVC7fLt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNVC7fLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768370638; x=1799906638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hrl4UFUgu9uNkxaAAvg7noSOe/rnq8FJxg3jjpVBJ04=;
  b=MNVC7fLtGNtBxzBGPPy7lFjkNNvGzs9s+x22oxonBW8Nu3Yq83QY0jzv
   AEzFU4rNmNoQpr9TlOup+MNr4RRaLTCUWc+C146u+ZEOHBQugdcfG77Rr
   01trDqYipp5ZVoNZrEZxjl5kbwxXiRSZ3rd+4deoQ2napov1zI7Vo+Ch2
   mh7cll50LF8lnpLF8bWl3TfQxWK9Rk9NKc4ZCshF0ni2TMhxUYnI1HNLE
   7MsRDNYmTZeGr0UhbwOnLBgu4SWfUJgskQbu6yQQMgxHQIRj//VSSiJQM
   /foD8LxEmqY6/yi40l9Qc3VnuHh1LHBDCvML0VfYu+l8JG5/TshGByfkn
   A==;
X-CSE-ConnectionGUID: KxVE8hO9SuiWsUfLZLXUvg==
X-CSE-MsgGUID: 6JBckTlRTr6BDCEJFYNrTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69573427"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69573427"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 22:03:54 -0800
X-CSE-ConnectionGUID: sUs3MhNcStibzyO24uC9yw==
X-CSE-MsgGUID: egaCFXtRRo6N41ofuErERA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209049655"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 22:03:51 -0800
Message-ID: <eeab7d3c-ede1-4e55-a55a-f8b7344ca164@linux.intel.com>
Date: Wed, 14 Jan 2026 14:03:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
 <skhawaja@google.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
 <20260113150542.GF812923@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260113150542.GF812923@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/26 23:05, Jason Gunthorpe wrote:
> On Tue, Jan 13, 2026 at 11:00:48AM +0800, Lu Baolu wrote:
>> +static inline bool pasid_support_hitless_replace(struct pasid_entry *pte,
>> +						 struct pasid_entry *new, int type)
>> +{
>> +	switch (type) {
>> +	case PASID_ENTRY_PGTT_FL_ONLY:
>> +	case PASID_ENTRY_PGTT_NESTED:
>> +		/* The first 128 bits remain the same. */
>> +		return READ_ONCE(pte->val[0]) == READ_ONCE(new->val[0]) &&
>> +			READ_ONCE(pte->val[1]) == READ_ONCE(new->val[1]);
> 
> pte->val128[0] == new->val128[0]
> 
>> +	case PASID_ENTRY_PGTT_SL_ONLY:
>> +	case PASID_ENTRY_PGTT_PT:
>> +		/* The second 128 bits remain the same. */
>> +		return READ_ONCE(pte->val[2]) == READ_ONCE(new->val[2]) &&
>> +			READ_ONCE(pte->val[3]) == READ_ONCE(new->val[3]);
> 
> These READ_ONCE's are pointless, especially the ones on new.
> 
> With 5 words to worry about I really feel strongly this should just
> use the ARM algorithm. It handles everything very elegantly, we can
> lift it out of ARM and make it general.
> 
> Here, I did a quick refactoring into general code:
> 
> https://github.com/jgunthorpe/linux/commits/for-baolu/
> 
> You just need to provide a used function to compute which bits HW is
> not ignoring and a sync function to push the invalidation command. It
> will take care of all sequencing needs for all possible new/old
> combinations.

It's always good to generate common library code to avoid boilerplate
code and different behaviors across multiple drivers. I'll try to
integrate this into the next version. Thanks for the help!

> 
> Then delete the replace/not replace split in the code too.
> 
> Jason

Thanks,
baolu
