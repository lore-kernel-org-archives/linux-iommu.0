Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE712BEC43
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 06:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122576; cv=none; b=iF65j8tUa3c7LmNFVzHfqONdaWDCXM6bMygrUdsvmnjXsdLmbHM/2Qjzncod0YvRZMDLfG+9Dret93d9BHPbied2Czx6Bwl3B1HIAjYY02B5FiMSpVHpwoJ4kNOmy5mIqj9gRxvsCqV4l/Tkmbr4N4I8wNzWFhDeY7TojuPqVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122576; c=relaxed/simple;
	bh=YR7HUXW1BcxInSjsGwgaiiW1X724fWYy4DndvZVbN1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX/7S3+4xotpDoEAHVvGzg/VBPyqSubwWSM/4OBw8Ru7I68evYQFj7/X0+ATt/0UP1ate++Ei5LXscc3I67J3uihsQWgLSfR3D91/al0JOVE+pbGSJUvjbASlaxtFtje4EMG9s4dj3eeAxNmmF7/7suNmeGFFu+DSW5ikDzpBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEbPRYVW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEbPRYVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773122574; x=1804658574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YR7HUXW1BcxInSjsGwgaiiW1X724fWYy4DndvZVbN1U=;
  b=XEbPRYVW7ftMBrNFMLzvGfyKx7n5TjkV6HUilpWfucU4aVtf/xzrziiV
   8Z69CEbvmc03XYrBp9+pYb6q2UHCgftGTo5N/LDrdfkWVDBhrphMouNrL
   F9tMhgHiNt8xh9jS+lDGvYMArAYsW+6MoM7P5ypEPILCisXNebD4uO04e
   Y68AuwygsNkkMouR5t0HMf5pLiFz1iTOVKuzpm29a633PpACRXPl13BTR
   GAXkSIhqah43R0BWQT516YAoMFRUT0l+yXKJ05Dcvsl3fvebdnTtzXSK9
   5DYq+iZfrOLBG6NnZmENqNVaEjt11RimEUSnms+s44WYOQOzewoUZwk7u
   Q==;
X-CSE-ConnectionGUID: hu16Zz7jT8mkpNZANOmRlQ==
X-CSE-MsgGUID: Q/h2GfpBR9KNvRe5HDhmtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="85635309"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="85635309"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 23:02:53 -0700
X-CSE-ConnectionGUID: OVqhAxcwSTaDx7dM9vHy1g==
X-CSE-MsgGUID: J78gIAfxRHK3JpSnd10diQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="216413821"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 23:02:51 -0700
Message-ID: <889933b2-a707-4632-a96a-f7e1ccc4c8b9@linux.intel.com>
Date: Tue, 10 Mar 2026 14:02:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/vt-d: fix intel iommu iotlb sync hardlockup and
 retry
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 dwmw2@infradead.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 kevin.tian@intel.com, skhawaja@google.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260306101516.3885775-1-guanghuifeng@linux.alibaba.com>
 <f6af2887-a524-4bb0-8ea8-acdca50e66fe@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f6af2887-a524-4bb0-8ea8-acdca50e66fe@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/9/26 17:05, guanghuifeng@linux.alibaba.com wrote:
> There are some concerns:
> 
> 1. During the invalid request execution process, the IOMMU first fetches 
> requests
> 
>      from the invalid queue to the internal cache.
> 
> 
> 2. If an ITE timeout occurs during the execution of a request fetched to 
> the cache in step 1,
> 
>      the IOMMU driver clears the ITE status, allowing IOMMU to resume 
> processing requests from the invalid queue.
> 
> 
> 3. For requests already fetched in step 1 that experience an ITE 
> timeout, after the IOMMU driver clears the ITE,
> 
>      will IOMMU directly discard these timed-out/cached requests? or 
> will it continue to execute these cached requests again?
> 
> 
> Currently, the IOMMU driver implementation first clears ite to resume 
> IOMMU execution
> 
> before setting desc_status to QI_ABORT.
> 
> If IOMMU will re-execute requests from the cache, then the IOMMU driver 
> needs to be modified.

You are right.

The driver logic assumes that once an ITE error is cleared, the IOMMU
will not resume its previous execution but will instead fetch new
descriptors from the queue. This behavior was introduced by commit
6ba6c3a4cacfd ("VT-d: add device IOTLB invalidation support"), which has
been part of the driver since 2009.

> 
> It should first set desc_status to QI_ABORT, then execute 
> writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG)
> 
> to resume IOMMU execution(In this case, some requests will be 
> resubmitted and executed twice.).
> 
> Otherwise, iommu may write the QI_DONE result back to desc_status after 
> execution, and the iommu driver will
> 
> simultaneously set desc_status to QI_ABORT, leading to data modification 
> contention and timing issues.
> 
> 
> Thanks.

Thanks,
baolu
