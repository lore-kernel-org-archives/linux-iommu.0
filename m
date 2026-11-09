Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207571;
	b=GoIX+cJQoEqG+wnI/USqXcoy/gKxkXJvpiAd8/5NVw6emLIEjiBmaHysHZshA1R+dl78
	 fJrwJUXyw1jFjfCGJAXiJcT37czgWZNH236r/vgLlj2tY4Mhnx5D1Su0ZxWPUVRpzLs2N
	 x9credU5ClZxhGk9ghSRI0RCcqNYh767wBCIBPWeCbBo8vZAki1tBJ+1gQ2rJkQK2FiIB
	 a+1wRs+uXq8La4fb5XNe1PWNGxKa0oi0VCZC0W6ilByS8JSc0OdBL6vDCCkHHaLVBgE34
	 ANP/XdHcMJQESVkEYZgk3U5TmLX5GilEaGbC2XdQJL93L3vA5kXArPA9/jekJzguBaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=urs8pBjtJuU8NtJw6ymzH858YDjP6YJOu0XZ72EhaTE=;
	b=UUeqI6p0806LIHq5UllYM+59phJR8UrBgfJ2hcsy0hKlDztnx4KlNHj3eVpaYJ9nuPQ2
	 fcwdLIf0kHC5Db3hrSm9xU5uS8G7pyJQ1Lc8ptiOue/Men6ppcDuRJ5+yxPQs74nFB1Ud
	 rAXWbysfaGrLxDETCWDx7wAjHJ/b5uduCMq+dBCWyJn9P4RRJhgruRgY0aiqYLNoB5blK
	 +jUzSuUCl16J8FmYOJYDi2qykNyXcEREzifeoavkt65zMP4H8V2+X51bZ4wbLMfoLHk2N
	 M02HXec3piE/HBThiVpKIX2vRyoIBqo+Yh+Ww9P+PTU6iq3PAyxL+k7x6ugdOAJPdXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZHmI9Hrb;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6F606A323
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 06:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D6F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZHmI9Hrb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794207571; x=1825743571;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VSPqosOaU5/GTvlzY92xAvPvszuHjX9euWkyiVHgofg=;
  b=ZHmI9Hrb45QpJPL2HlFjz/vRcxkm07D3BDmdnr1t1kX5NsrWQZUu4FIZ
   KpqCCFGdqVNXUzolcO7KrTpGS5e1FCcjPZRPv6RkRGU6Vezj3Tzs1nnnQ
   boZYFFd2jb4mmLdbVzpqq/7i4qCfUKVbt+e7kWqSM/WPRQTFGWPz0keS4
   eL3QlKr/E6gmFucwNcl1tzXXbDqm8eVp5O/8n0GD6zRu/2onBC5LXSZo8
   UDe59IGL6Hscw9YLT8IMcGbgb8tMXBD1fnK7eBsh6myjjbYpKb5DTVPqF
   y9Ltm79zqJE+2ex4vJ5X+JDn6pXr5wK/fMOaiqFgX1sO83DhJfs0ALzJM
   w==;
X-CSE-ConnectionGUID: 3vxlNXZKTzagcfC/OZBObg==
X-CSE-MsgGUID: Wa7kB7XMSlGmyujYfPJLaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2915921"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2915921"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 22:59:30 -0800
X-CSE-ConnectionGUID: hXKE4DkaRtmhIPkYe7OPrw==
X-CSE-MsgGUID: sKUkGYZTQK2SWkCUH56Fpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7830465"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 22:59:28 -0800
Message-ID: <e60624a1-c6e7-4e40-967b-5f5cfbde96ff@linux.intel.com>
Date: Mon, 9 Nov 2026 14:59:25 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, robin.murphy@arm.com, jgg@ziepe.ca,
 iommu@lists.linux.dev
Subject: Re: [PATCH 1/2] iommupt: fix full IOTLB flush from a zero length
 unmap
To: YeeLi <seven.yi.lee@gmail.com>, joro@8bytes.org, will@kernel.org
References: <20261105121227.622631-1-seven.yi.lee@gmail.com>
 <20261105121227.622631-2-seven.yi.lee@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261105121227.622631-2-seven.yi.lee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/2026 8:12 PM, YeeLi wrote:
> From: yeeli<seven.yi.lee@gmail.com>
> 
> unmap_range() hands gather_range_pending() the number of bytes it
> actually unmapped, not the requested length. That count is 0 whenever
> the range holds no mappings, so an unmap that removes nothing reaches
> the gather code with len == 0.
> 
> The gather helpers assume a real range: both
> iommu_iotlb_gather_add_range() and iommu_iotlb_gather_is_disjoint()
> compute end = iova + len - 1. For len == 0 this wraps to iova - 1.
> 
> The problem can be reproduced by attaching an empty paging domain to an
> Intel VT-d device and unmapping IOVA 0:
> 
> 	domain = iommu_paging_domain_alloc(dev);
> 	iommu_attach_device(domain, dev);
> 	iommu_unmap(domain, 0, PAGE_SIZE);	/* nothing is mapped */
> 
> The unmap returns 0, but the gather becomes [0, ULONG_MAX] and the
> iotlb_sync() that follows asks the driver to invalidate everything.
> Captured with the cache_tag_flush_range and qi_submit tracepoints
> enabled:
> 
>    cache_tag_flush_range: dmar0 dmar0[0] type iotlb did 12 [0x0-0xffffffffffffffff] addr 0x0 mask 0x34
>    qi_submit: p_iotlb_inv dmar0: 0xc0026 0x0 0x0 0x0
> 
> With a non-zero IOVA the wrapped end widens whatever range has already
> been gathered instead.
> 
> Skip the gather bookkeeping when nothing was unmapped. An untouched
> gather keeps start == ULONG_MAX and end == 0, which iommu_iotlb_sync()
> already ignores.
> 
> Fixes: 7c53f4238aa8 ("iommupt: Add unmap_pages op")
> Signed-off-by: yeeli<seven.yi.lee@gmail.com>
> ---
>   drivers/iommu/generic_pt/iommu_pt.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
