Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E637137746
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261357; cv=none; b=temBOxEnqHb+y4ygVFznNVEG1CP+mequIEt17bPbjJcsVBameWyi6GFeta+UVClH9A0P4YC38ez5sMJFOjVqBx2KmoFvKcZLZXCrOeLbmPZhGCikuqYtSNPweWNHN8NyRKxCWCI7WYLLfibR7O4/mNCLdwgnK6ya3GlX+/lnqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261357; c=relaxed/simple;
	bh=WBIDa8EW/dX05X0Pb8ExnAzcKRiIOjXdz3UGKRYDqMk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hwBnjDYmrwt43vuV/224CPprARgZxOdlwvtVHhsvyrmsltOhdPQMi7fFSKxabzVYxgYtpazdUAqU3ZoPVlV+5E6RLUkZYvYtN2dZOPJcrPGMFs1hnYfJpb4nqNpncD9SVcgdf2/YylrRfteNiwvPQlKgnToPBxY1DUdjIzjfleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma3uHmHU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma3uHmHU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718261356; x=1749797356;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WBIDa8EW/dX05X0Pb8ExnAzcKRiIOjXdz3UGKRYDqMk=;
  b=Ma3uHmHUT/m+cMYA10WsnX4Bubp7tsd4+ErDRIuYI7hj/grX0dJq9nin
   sKuQkVUgz/omvK6THkqCgWEhcTdpeUnOTJ6xDC03d/sx5K5itYmQUL/vn
   5xB4UmJMI5WjvCqDSO0dmuw5C+ofHGlfwAP95u2cJp8eILXONk5jNEjNn
   tJbrNctdeYVjJYrw9hyakAxC2UEE4k7I0dIdDqEaTxbtYSrDaCbPzAWwc
   L8tWiDQi9qNS9co9Hth8Y6GYZO6X2jDWKSCUIG+1gfboYOGBAcoBzjbnx
   pCKzQ/CCWWmImS7d5xjUrtoFxcIq35chQPkZiXmakH6F4eeY6fVha9SkB
   w==;
X-CSE-ConnectionGUID: Ge+zqqLaQbicgbNNe1MqyQ==
X-CSE-MsgGUID: +KscMcYLT/6BAINBgtWwSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25698815"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25698815"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:49:15 -0700
X-CSE-ConnectionGUID: Mle86pKBToOVONWcQvcFmA==
X-CSE-MsgGUID: /uYyYCSzT6qjB04x0FYQaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44944503"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 12 Jun 2024 23:49:12 -0700
Message-ID: <4ba5a1a6-80f2-46eb-84f7-921b9ac27efc@linux.intel.com>
Date: Thu, 13 Jun 2024 14:46:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/10] IOMMUFD: Deliver IO page faults to user space
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240612135426.GA2151677@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612135426.GA2151677@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:54 PM, Jason Gunthorpe wrote:
> On Mon, May 27, 2024 at 12:05:07PM +0800, Lu Baolu wrote:
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework. One feasible use case is the
>> nested translation. Nested translation is a hardware feature that
>> supports two-stage translation tables for IOMMU. The second-stage
>> translation table is managed by the host VMM, while the first-stage
>> translation table is owned by user space. This allows user space to
>> control the IOMMU mappings for its devices.
> This looks pretty close, will you post a v7 with the minor changes?

Yes. Sure.

Best regards,
baolu
