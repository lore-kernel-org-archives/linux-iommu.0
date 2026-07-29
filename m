Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB103B52F4
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 05:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303580; cv=none; b=N0aW7Pv3NnyXurplim6vxVckj/UTrC0h25CVE+s+Y75AAy+Fptrtlzykgv0sr2eqPn7BItSEwwrmTV9yKWYxsdDmIdFs/0HOk7subN+6qGbDTq5INLSrDNkIY4svsQRV9wZVmqRp2TJetK1hqfMKKRT6Uus41SqcxR3iyEfyahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303580; c=relaxed/simple;
	bh=MVuDxY6zTAmNDCxjaulL9KV8llzBrqvd4EV6u6U7bY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tg+Z8AyXMH0dKjoeCY1XzggyWLhFtnVWzM/1qK+TADcVBPc3f8k875ld2BC+WpSe9nYLbHPyxcT7GsQnLD4u/y58u5aKLAKeC6135oI50wt+eIipjm+VHriy9BNKZJgI8htQVNQvPkBgxgzxxlymTSmFT89j1gf1a+3Q7M2VTVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4naFJXV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4naFJXV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785303577; x=1816839577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MVuDxY6zTAmNDCxjaulL9KV8llzBrqvd4EV6u6U7bY4=;
  b=L4naFJXVvsngMwPnvq77RQcCL47XsEXgwW3dZDt/1hbWm4WMIFlTcTEK
   DxP2PQyXD+iUrklJ1JX/nL2VDTRSl+5eioT9hgOTx2zQ2dN2Zby7uJdGy
   XlgrmSWtR759ebnj/HU/XMpYmgeicWtsOQ0p7+iG/OAqtwXC84oDh2KB0
   vhxMx2+SogKeAMNMHAOV0vjTFc8qNqeCUFqx6ndR7u0MZhe9L5YZE0dkX
   UYLTHyN9qha7vLP2rEtLaBE8j+bk0wER1N1hE8UpzaD4F5rP7gN90Z9bn
   KaqcweBP5d6qT4GCl1TzyQN5m/l3hvm0ZBi6WFSlDYnCnSDvfVdk0ECVw
   Q==;
X-CSE-ConnectionGUID: b1Q8717cQVGvAfDboaBgKw==
X-CSE-MsgGUID: 65WHBgZHQZGCR7Dg1FzXkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97412586"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="97412586"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 22:39:36 -0700
X-CSE-ConnectionGUID: +AxouIw1TbWmJEF4OOAKrw==
X-CSE-MsgGUID: wF3SOInaTtO51/OmLlam4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="255608255"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 22:39:35 -0700
Message-ID: <fbf39948-af54-4907-9040-8b1b630fa49c@linux.intel.com>
Date: Wed, 29 Jul 2026 13:37:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: Fix copied_tables bitmap leak on error in
 copy_translation_tables
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <367f963a-d337-4d49-9d5b-a558fcba813a@linux.intel.com>
 <20260727052240.3483567-1-zhaojinming@uniontech.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260727052240.3483567-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/27/26 13:22, ZhaoJinming wrote:
> The iommu->copied_tables bitmap was introduced by the IOMMU live
> update series to track which context entries have been copied from
> the previous kernel.  The allocation via bitmap_zalloc() was added
> inside copy_translation_tables(), but the error paths were not
> updated to free it:
> 
>    1. When old_rt_phys is 0 (invalid root table address)
>    2. When memremap(old_rt_phys) fails
>    3. When kcalloc for ctxt_tbls fails (goto out_unmap, which only
>       unmaps old_rt without releasing the bitmap)
> 
> The bitmap is only cleaned up by free_dmar_iommu(), which is
> called from the free_iommu error label in init_dmars().  However,
> when copy_translation_tables() fails, init_dmars() does not jump
> to free_iommu -- it logs the error, falls through, and continues
> with the next IOMMU.  As a result, copied_tables is leaked.
> 
> Fix this by converting the two early returns to goto a new
> err_free_bitmap label, and by making out_unmap fall through to
> it so that the bitmap is always freed on any error path.  The
> success path performs memunmap(old_rt) inline and returns 0
> directly, since copied_tables must remain allocated for
> subsequent use.
> ---
> 
> v2:
> - On the success path, call memunmap(old_rt) before returning 0
>    instead of returning directly, fixing a memunmap leak introduced
>    in v1.  Suggested by Baolu Lu.
> 
> Signed-off-by: ZhaoJinming<zhaojinming@uniontech.com>

Your signed-off-by should be placed above the "---" line.

> ---
>   drivers/iommu/intel/iommu.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)

Queued for iommu/next with the above change applied manually.

Thanks,
baolu
