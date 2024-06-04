Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E22633
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463100; cv=none; b=ecth8U5BIFAJ8v8FxMNMAiwp4QBHgE8dXw1kiXyI1zqw46sdUHCtxjuaoOzw/ODo61RVBKQ8WvrAyqFLxjWtFFVc4syUXZGc6ehZBIABIFvKbi8LADWsucvYgAamUo0uUUaONazYR6ZNmkxwKQ9bBVikBtsBBgLedlhz8RM2EMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463100; c=relaxed/simple;
	bh=P8eBB5Cc87RKZAf0H78uJjnNtiqeWTjcR7eQmw+/CFE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fSODjT9uFXFnfrDjPC1Q4r87goN8MfE6afLtFYYqevbeLbpMPBzlWN+4PYcdgYGMxbH8HF7UCLrsJCWoB7WDOccDzeQpML0qKoFvMCeX0PaC8xEUFHPqzaP2xeVVIYWaWhq3xxVSSvmcMremk7V6xmiDH4y7FgA5iTQEibsjR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G89tGdnv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G89tGdnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717463099; x=1748999099;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P8eBB5Cc87RKZAf0H78uJjnNtiqeWTjcR7eQmw+/CFE=;
  b=G89tGdnvKkjrw1wT5Zi2yHImxJuF9c3Ulokfu5rAoiPNvOMNMXt5js1J
   cG3MuOPt1DZD45xkjrRFWC/HqHxSREgNGoJpbvmNusi6Z9vj/5d0Mw1Wa
   e1Q/SVGKRqFQXRoqJDQv6FALbwZ/jcJcYEryvK68A+ewfo/GJuPzIovMU
   JBAxQ2jUxv7KXxhJ9TgYeMK5lchQ9QTKKv0F0KsgBx38kvSjCo44oAZhz
   NqRfoEZhFHkbDeeRcONOu2bexVljBk2roWHjYLqKdJzZvjJSemllzv1MC
   Xz/vruUhyL906v0Ci6arlEjbUIb3cvfuUrTc7ByzTc6JffFWEGnF4LpVW
   A==;
X-CSE-ConnectionGUID: NxoYcgBpSByb/19kkiVsAQ==
X-CSE-MsgGUID: AspoS2KiSTyDXizFj/HXqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24562721"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24562721"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:04:58 -0700
X-CSE-ConnectionGUID: qKwXtPxHQDygtcPp8UG2/A==
X-CSE-MsgGUID: SRYksvRpTWSuBkLTIBhSlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="67883645"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 03 Jun 2024 18:04:54 -0700
Message-ID: <05211393-84dd-4a59-b627-1fc5ab9b1b3d@linux.intel.com>
Date: Tue, 4 Jun 2024 09:02:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] iommu: Refactoring domain allocation interface
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <efd902f6-eafc-4a26-8057-bdd9d7d6e535@intel.com>
 <a1f2c08a-e92f-4080-b55e-8d6dbd94db78@linux.intel.com>
 <20240603133550.GA21513@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240603133550.GA21513@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/24 9:35 PM, Jason Gunthorpe wrote:
> On Wed, May 29, 2024 at 08:02:12PM +0800, Baolu Lu wrote:
>>>> drivers/infiniband/hw/usnic/usnic_uiom.c:       pd->domain = domain
>>>> = iommu_domain_alloc(dev->bus);
>>>>
>>>> This series leave those cases unchanged and keep iommu_domain_alloc()
>>>> for their usage. But new drivers should not use it anymore.
>>>
>>> does it mean there is still domains allocated via iommu_domain_alloc()
>>> on VT-d platform?
>>
>> I think the drivers mentioned above do not run on x86 platforms, or do
>> they?
> 
> usnic does.. What was preventing converting it?

Nothing, just because it wasn't that obvious. :-) I will convert it in
the next version.

Best regards,
baolu
