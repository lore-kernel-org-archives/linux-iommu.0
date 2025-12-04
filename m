Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0027991E
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764815418; cv=none; b=qLQeMit1B9oLoEeeab5u1UkNEBMX/Nhxt804UI/iH191XLG5XZO79GQt6gspjlGauu42nHX8pY3osUsuxJ5AORdg7jLET1UrfPlFdJSkEbKepvf3NN+/YqXghiRoXlwhdX0fWg1PQK+mbAYQqQ13yM4Xyq73AppNfX2//Q/cM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764815418; c=relaxed/simple;
	bh=Agz27ztHoG/19PjHWv8wSeN+fERK8HwMYb0K9v1jqJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNXdhIUcQ/jyRNKi4DZvZFuR76I98vVZmMnETCzjoOYzHk09H7Q01C9emmqKqLgV1onck5aYLknckxaRvDpQgZgm4ePnUYhjh+Buy+00cWHnFWQhHuWj/FajbtRj9hBV0r29UwmMvsOfxYFydsQ+hy8d4Xz0vP4gJhLKT8l7i6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6H+FeOO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6H+FeOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764815407; x=1796351407;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Agz27ztHoG/19PjHWv8wSeN+fERK8HwMYb0K9v1jqJ0=;
  b=D6H+FeOObiuosu7nLdFjk25aKYkopwRfSE8DXMn7Qo3HFeXaK4sfB/s6
   2CUVoWcbhVrUXQKRGq06vfFLv3DTH5R5BBoWRKIqSGccFCueUnsMjYuMf
   MX06iWnBx79zOYat+blU8QfXjP6t2CzgSj1e+3FWogqM7K1COytHO65g+
   Pp/e8/lZac3tBFIKcGFgfmR9eVDfNQ0GtnXuhbgsB9OIHk0QkCHUkJ/CS
   Uyb5FNFInM+3w01DpPH4k/FEHToTZyV9zmWFgcU8C8WTsgulgXx8+J2c1
   psGzwP4bTlOtsvEEvSHPkedJnGZ2gHcvcC5I7GexCsg3RX7Ws6QTncTWL
   Q==;
X-CSE-ConnectionGUID: W74ORplaSfCyaIZv+F9sFA==
X-CSE-MsgGUID: /lmrTdwWTC6DUIxBnhulCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70678877"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="70678877"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 18:30:00 -0800
X-CSE-ConnectionGUID: 46i5EZ3nQS2MNMWQJAHqlA==
X-CSE-MsgGUID: /5Jy4kPRRIq5cxtdDHcTPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="225528569"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 18:29:56 -0800
Message-ID: <fc6632e7-f0eb-437c-b687-c31c019f3d1f@linux.intel.com>
Date: Thu, 4 Dec 2025 10:25:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/32] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav
 <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Vipin Sharma <vipinsh@google.com>,
 dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>,
 Chris Li <chrisl@kernel.org>, praan@google.com
References: <20251202230303.1017519-1-skhawaja@google.com>
 <20251202230303.1017519-12-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251202230303.1017519-12-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:02, Samiullah Khawaja wrote:
> +int iommu_preserve_pages(struct iommu_pages_list *list)
> +{
> +	struct ioptdesc *iopt;
> +	int count = 0;
> +	int ret;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> +		ret = kho_preserve_folio(ioptdesc_folio(iopt));
> +		if (ret) {
> +			iommu_unpreserve_pages(list, count);
> +			return ret;
> +		}
> +
> +		++count;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_preserve_pages);

What is the purpose of "count"?

Thanks,
baolu
