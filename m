Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C53A2546
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777951610; cv=none; b=g7FVMK4benYrXRpUuZJkhKbGgUwGQ1D6FVIGtWUYhdZmI3Lbc6SN6eRjjJh2qAd0Mrq/i2nfMQQCqI/RLyldGzDwHyjxVBcgdTBvkP6OhGciFXGOaxUq9HtFsKRh720Zs9f9cxl7K0B3JFViuZ2iWu1LeKLTh4FUEFaP2A14x2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777951610; c=relaxed/simple;
	bh=VFe7PgpFxQ1/JBMQ2tXnIfjekzfcHIqzZyLSb948a4g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j0pNCLNwgD5V8Mz8cbrjtKIh6oTYzEwlFwRFODYWTFSaST/QWdqLsjMsxZSZ/JuQTtxxPaCuHyxjiE0IWgZta2RkNwAb10+aK2H6W1yoPp6Ww4N5ta2KfB1pq+qmHKqxpxw+Hccfm81brj0O7xLUtUJsTPT16V/iBzkPKHe7NLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfE4yk9O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfE4yk9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777951608; x=1809487608;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VFe7PgpFxQ1/JBMQ2tXnIfjekzfcHIqzZyLSb948a4g=;
  b=EfE4yk9OTy/aSSUg2LjV5xAzCQ70JJeu3hnev/1VqtHjrkh60VyO3lkI
   H2hek9bFxLCKbr+c60ibMUVYfMUVdsle9OFBtJ/b/P7Q70BUeJlrE/Nqc
   0DgDZkkUKjMZWNc/ehVidDTu+tlOBjS1VnVwRVV7qvM9h8C0BwrAbRSBI
   XqyYE879NbfKDV9w12CymicrxZqmLn8/LuIYGs31Cw6fG+b007Asbm/K+
   h3g4eo4MxwHk1MqP03b6c8lVzWeGpdXOrp/HnIGPnjbIhZqGxH0rRqmcI
   axiOEnbG7WI/UCAia+PfqSGj8on9pXHWeEM7ycMkM9XWYR0tsq8+vMe5y
   Q==;
X-CSE-ConnectionGUID: gdN2hQJPSCqjs7pMft18gA==
X-CSE-MsgGUID: SlaK5/FNQiW2UVY047g7Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78838281"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78838281"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 20:26:47 -0700
X-CSE-ConnectionGUID: dNMWoRljRr6xxgdFkHaM6Q==
X-CSE-MsgGUID: vnpdTCCqRr6hIpW+beQVEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239668138"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 20:26:45 -0700
Message-ID: <7e085616-ec18-49a0-9414-d3a2302b2c72@linux.intel.com>
Date: Tue, 5 May 2026 11:26:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
To: Kai Aizen <kai.aizen.dev@gmail.com>, jgg@nvidia.com
References: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/2026 1:56 AM, Kai Aizen wrote:
> The bound-check in iommufd_veventq_fops_read() for the normal vEVENT
> path uses sizeof(hdr) where the surrounding code uses sizeof(*hdr):
> 
> 	if (!vevent_for_lost_events_header(cur) &&
> 	    sizeof(hdr) + cur->data_len > count - done) {
> 
> hdr is declared as struct iommufd_vevent_header *, so sizeof(hdr)
> evaluates to the size of the pointer.  Surrounding code uses
> sizeof(*hdr) consistently:
> 
> 	if (done >= count || sizeof(*hdr) > count - done) {
> 	...
> 	if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
> 	...
> 	done += sizeof(*hdr);
> 
> struct iommufd_vevent_header is currently 8 bytes (two __u32 fields,
> flags and sequence), so on 64-bit (sizeof(void *) == 8) the two
> expressions happen to be equal and the check works as intended.
> 
> On 32-bit (sizeof(void *) == 4) the check under-counts the header by
> 4 bytes: a vEVENT whose data_len causes 8 + cur->data_len to exceed
> count - done while 4 + cur->data_len does not will pass the check,
> then the loop will copy_to_user 8 bytes of header followed by data_len
> bytes of payload, writing past the user-supplied buffer.
> 
> It is also a latent bug for any future expansion of struct
> iommufd_vevent_header beyond sizeof(void *) on 64-bit; the check
> should not depend on the type happening to match the host pointer
> width.
> 
> Use sizeof(*hdr) to match the rest of the function and the actual
> amount that will be copied.
> 
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc:stable@vger.kernel.org
> Reported-by: Kai Aizen<kai.aizen.dev@gmail.com>
> Signed-off-by: Kai Aizen<kai.aizen.dev@gmail.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
