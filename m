Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1922DFE8
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032157; cv=none; b=nmTh/tvLvFcEQ/nPkvnlQ/sWn7G9yRBR811V5HpWAWRMjK1lKGjpRdt7u52inpd/Si7qknuXt2MGJasE14xSvUbh2nsanPUs/Y67FvwU1K5APfM76jCya4h/wJ4tFEz1QBJaNpEr76iO60AGlcEAlIQZgY3hggc7cUHHQMk7KEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032157; c=relaxed/simple;
	bh=3jNVitMyrsT+unXNWleK6dQla5aEs2uzLLL1DWk9G8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6hxWawS0wWwGm3I+wwpfvhTRaV/BM1OohI3KlorYenE2a0ORYuSvvKXyuPRyc4okt2zkBAG9JjYRyj/lDDiTJHTVQLSS3zZ6r243CIMvXdAOyabX95TaOdnKtOq0hZXrCkFqaOvoLwirxljtrj0+HBesU4XlEruwSzV8LJls/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcUkStEN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcUkStEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747032155; x=1778568155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3jNVitMyrsT+unXNWleK6dQla5aEs2uzLLL1DWk9G8o=;
  b=TcUkStENdvFzlP1VhUvYqBSCWXFssiv55OWLT9EqB1PesyWI5OI8xGaT
   Jxb3fWR5HHItOLlhtMiYakk2BZgqACRrMnCQ9RGpmDBitgCLekJ+PMX7D
   XftCROGN7F9YTrcOnTvoWnHR6d3eYRsKy0R4+o94et1pPfm48YozjPQbG
   oEayU5kj4F/IiT8ZJ4Yax/YZTAr7G2m4FPzZ6Ztv0OD5eoOpJMD+NMmAI
   oLCWjsTecix77a/Lpm6JqhJ4JMEEPTYaBUOS6D12WeCVd3JF1Fuo3Co/U
   SuhSjt4PiX/vLPMDvdONyd6q7H81U6bG0IYqJZkJu0fJv4EF+nfOCfr/Q
   g==;
X-CSE-ConnectionGUID: pPBzzy9rR2KaQS9BZcKpgw==
X-CSE-MsgGUID: T6hEJ7MIRIKUwWZVggFLVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48678783"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="48678783"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 23:42:34 -0700
X-CSE-ConnectionGUID: MN7BlsYEQBGB9NlR1klb+g==
X-CSE-MsgGUID: zhNgw+z4Sc+3zXeScwl4FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142028505"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 23:42:33 -0700
Message-ID: <2cc8a047-5453-44f1-839e-62425e1ca239@linux.intel.com>
Date: Mon, 12 May 2025 14:37:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iommu/vt-d: Use ida for domain ID management
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250430021135.2370244-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250430021135.2370244-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/25 10:11, Lu Baolu wrote:
> This converts the Intel iommu driver's domain ID management from a
> fixed-size bitmap to the dynamic ida allocator. This improves memory
> efficiency by only allocating resources for the domain IDs actually in
> use, rather than the maximum possible number.
> 
> The also includes necessary cleanups after the ida conversion, including
> locking adjustment for the ida.
> 
> ---
> Change log:
> v2:
>   - Drop the last patch which simplified the code with __free(). There
>     needs a helper like xa_store_or_{reset,kfree}(). Thus I plan to put
>     it a separated series with broader reviewers.
> 
> v1:https://lore.kernel.org/linux-iommu/20250423031020.2189546-1- 
> baolu.lu@linux.intel.com/
> 
> Lu Baolu (2):
>    iommu/vt-d: Use ida to manage domain id
>    iommu/vt-d: Replace spin_lock with mutex to protect domain ida

Queued for v6.16-rc1.
