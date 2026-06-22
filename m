Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E173126D6
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782108142; cv=none; b=EUhCq3rOdC6I7zWkaFxsSDaaSV5gTzs+3iEvHkbR5FzlBfUhvcoxZWAwRVDpKn8IpPEhiLg+wb35SvOquEFdt1FLMp8mtrM9O6UFnkWHHVzSdYv7UupuafzfbfNx0anXQ9zwfNHV0EOW3O1iZe/MuS/IrZJasB9YAJDKZMIG7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782108142; c=relaxed/simple;
	bh=KZY7GNfihtdUl+1rFZP9opWiUZDpq0oX/7PZZwhRqMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKFt5Oth1W+eXc/mXhTUAejPZrHSnSINKFUH8cNFjE0lScbQdsBpb0QixMKEYBgo0OhXRXalqFtMP4uXr5kdhcprE7uPD3eScggj2XVgjhHgF06fuy6XDpDVldPBXGhaGEBIFShrxEkgra/LvL375pWdNbu7KQVH8I6ubt/UFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/Oypi5O; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/Oypi5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782108140; x=1813644140;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KZY7GNfihtdUl+1rFZP9opWiUZDpq0oX/7PZZwhRqMU=;
  b=N/Oypi5ONwreO1JR9BTWnhc+wCFJGNi8ktiW+XpBAe6HBPlBLZrH2HJU
   fc90mZqOiaVYXfpzi2VoK4W6cKC8A76t/pTzBHvSPiQlAaUkjU6x/vB65
   qrE6R19ej2++8X2JTSimlEJYBbq0zag12f5N3RtddU+6qL/w2Y8cJYM9D
   9yK4mMsEvczAd/fllHVKWtGmHhXb0NxrPgtKDt6hdg20OeBLdj3hylpUd
   CFpUcks9Wq8fjV4Au4AXHnOlWN/PjuOlW4j/7mmZZPRctuG3aIedNI7AU
   52WiyW2EXcjp3JNvHIe5PzKQeGDIIWrnnVJzmJgmA+sRK3/bX9eeUG8Qb
   A==;
X-CSE-ConnectionGUID: oYwk1uAMSXiQBe5fuWZI3A==
X-CSE-MsgGUID: aAQyGf/2Tz6WybKwOn3C+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82841226"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82841226"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 23:02:19 -0700
X-CSE-ConnectionGUID: MZLKiIm/Q7eMFa085maBxQ==
X-CSE-MsgGUID: lJ2+kSZ/RwazuUcPAhMcaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="249195302"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 23:02:15 -0700
Message-ID: <8b1076ea-022c-42f2-8fbb-f55cd30b4b3d@linux.intel.com>
Date: Mon, 22 Jun 2026 14:01:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/18] iommu/vt-d: preserve PASID table of preserved
 device
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
 <20260614233728.2212104-14-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260614233728.2212104-14-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/26 07:37, Samiullah Khawaja wrote:
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 89541b74ab8c..5cac8e95f73b 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -60,8 +60,11 @@ int intel_pasid_alloc_table(struct device *dev)
>   
>   	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>   	order = size ? get_order(size) : 0;
> -	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> -					1 << (order + PAGE_SHIFT));
> +
> +	dir = intel_pasid_try_restore_table(dev, 1 << (order + PAGE_SHIFT + 3));
> +	if (!dir)
> +		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> +						1 << (order + PAGE_SHIFT));
>   	if (!dir) {
>   		kfree(pasid_table);
>   		return -ENOMEM;

This reads as if PASID table restoration fails, it tries to allocate a
native PASID table instead. This doesn't match my understanding. It
would be a disaster, and the system should panic if the table
restoration fails. Or is there something I'm overlooking?

Thanks,
baolu
