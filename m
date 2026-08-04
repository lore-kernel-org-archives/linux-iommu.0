Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A13F4DD6
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810518; cv=none; b=jMjLMd1toM9LH1GYdbXz8+B8BIm0CPTnQbqeW7ACDLtCC4rIBaBNF6CYQzR9jSHwClhQtNc7gU8cSNfYDfQmliL5p56exqIaXD5YPjjFQO8kUdbGyi17CuBOuln9YFej48yEk0egXjJ2nb4kOWgHFOhLCTX9jwx+t/PSKU9CInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810518; c=relaxed/simple;
	bh=nMrFaoho3m9K0kzIRUJEfZYH3xSTX1xjNzE8+wtcYDA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O10JgHcKTayxeyKdWrBuzsV5GEKKgXBq5/i3MUsu/ROid/m07qWyMazeeISu0ZjCE+DwsaJ51Zday/Mz+SkfMaAxZJONu4iI+pg6duoSdZDlceixWU/5oDRaESJGRgjGjiffLBKUdLIrvk1cdaZ9vovgTMVowmGxRx7AX3OrsFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACfZEfQO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACfZEfQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785810516; x=1817346516;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nMrFaoho3m9K0kzIRUJEfZYH3xSTX1xjNzE8+wtcYDA=;
  b=ACfZEfQOH/cGJl0kv9ozykOfPxoYZAQuvalFsa1TDkte3raREZMdgmpp
   6plm4xi2RbznIhBftIIPtJzOdQh1JFKpw11ivECJHDtIw3YKqetFcOlyH
   9K7u1xTqBpvsLLlAtM8X4SjYd3AZ9KC0rjoHp84otQoPUNQn9OZRycjte
   414xisOKfWHIUE2gJu0KbWusgM9iMqbgD7FcowpCqZ9F2LDIjpkITLUr+
   y3WMJNN+UQXHRSuDPjQ6jNuux8aiAsY4s4t7iaY19rEhsD95vzVLOZTFY
   jdp82ovNO9tIbTaROmqY59k+sI+HP6gZD/Z2uYjqsGxiw+DZqx6LDaaGX
   g==;
X-CSE-ConnectionGUID: 8NDIu3OkTi2haiwGd7uozQ==
X-CSE-MsgGUID: q1tFrBZ9SxyDDmu3670HAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97007294"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="97007294"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:28:35 -0700
X-CSE-ConnectionGUID: hWpXkJAEROmeZw43x9a5mg==
X-CSE-MsgGUID: 4qFAvWu/Qbuv7LXEzC7+qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="260780364"
Received: from unknown (HELO [10.238.0.222]) ([10.238.0.222])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:28:33 -0700
Message-ID: <af65db88-23e2-4c74-bfde-13587da360f0@linux.intel.com>
Date: Tue, 4 Aug 2026 10:28:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iommu/vt-d: Fixes for issues reported by Sashiko
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/2026 1:43 PM, Lu Baolu wrote:
> Hi,
> 
> This collects a number of pre-existing issues that were reported by
> Sashiko while reviewing recent VT-d patches. None of them are
> regressions from the patches under review; they are latent problems in
> code those patches happened to touch. They are independent of each other
> and can be applied in any order.
> 
> Thanks,
> baolu
> 
> Lu Baolu (5):
>    iommu/vt-d: Fix shift overflow in qi_desc_dev_iotlb_pasid()
>    iommu/vt-d: Clear Present bit before tearing down copied context entry
>    iommu/vt-d: Fix iopf_refcount leak on RID domain replacement
>    iommu/vt-d: Tear down scalable-mode context on probe failure
>    iommu/vt-d: Flush context cache with correct SID when tearing down
>      aliases
> 
>   drivers/iommu/intel/iommu.h | 18 +++++++++++++-----
>   drivers/iommu/intel/iommu.c | 22 +++++++++++++++-------
>   drivers/iommu/intel/pasid.c |  9 ++++++---
>   3 files changed, 34 insertions(+), 15 deletions(-)

Queued for iommu/vt-d.
