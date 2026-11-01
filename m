Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793512420;
	b=vlmhxf/8b5seYKfSRjAB2HOWzM8h5QUkNDYgjBIAluZUA+mr6tguUBCINlNGG2kWWjQV
	 n3bdpGshl/CDkBJw0lw8QpAD02F6tAiREBZCoUMnYMzMEFCcNGnVyrJcjyYs7hlOaSZVt
	 ttX71CWwRhK/BRE2H1koPT2q/y+YzOSyK3ClLVZRsu3LklaJYONlVmQs3cw0RPE3jxbjQ
	 G1kZehNn0qXRQ85/hWp8KcBgOTJn5ssTbFUoeQvXZSo7PWWhqQXfB5PIyVr83Eb7SQ/G6
	 On5QpapoZTdscFkmSf7PlC9Ph5V9FYUD6+zc+HWmu5heYpPxCQVgTAB+iemKz8RpW8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512420;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KRFkAlDQtTGYIebMYYCmow70NEBIwLIpiCa/lm48XL4=;
	b=yh4+wRVaRz7fEuM+lt8HKJt/5u5k9wMWOkoC0l5Yx4Zfm/4L2CZc8CpPLq/itbXnY5pz
	 PYY+VCeM4/FyU/KiwM6TOdIvFF+ayKvuLp6FOWwzy+ultUK4X359KCUkoL3yAFecvy2La
	 d5xiq8xok++hA5Io5Pc7FeRb+JaBsNTqRKsojc9rVSh1rmNCt74T5DrITweiyFsmHZUZG
	 mHuL2kuTP9Y8+T9ykPjzEcCdElujL0G21UvIwPaz2is+YX+Tlvu4FjphA8qu0uv8lncYF
	 L+doiQ5P9Bs+YSe6vx/o+bNNHcvbUKXyOIW0HEzeq2JCiLllwhLW0ttP+SszIq4c/xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kAZNlMCG;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69097606A325
	for <iommu@lists.linux.dev>; Sun,  1 Nov 2026 05:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69097606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kAZNlMCG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793512419; x=1825048419;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kIHFa658f4+vVViByp5ni8V5gaDl3J8IRD5P6YzY1S8=;
  b=kAZNlMCGvNENFNQ9m/x6enKfFnMPSVvXn1tKX0dylYFs/SaKKsM8TLqG
   hnZG2+OGzWooFhwBmFsij4i5OLdbibLVaEBYgZUan22yjPBbFBX0Ojy6D
   P3OLgzsng4H0FEr74C2BLbv5zNUUaq3W5IhUJ904xC+GkpQjnID0m8pl7
   TlFeEYBezQErj34hdW2UCbf/p46S05HLLbKN8CKi1b6H/Lh4W6mp4D4iA
   mQhcjwl06b/AACCSEjEjMrt/d2mShtFQKuaPyqnxXBF26g5mUY/dCnsBF
   IhSu0UlKg1m7rMe3QQBs0ceFsrf6HpOEHK2+Lao9zecvbkVGDvVZ6JzQ1
   w==;
X-CSE-ConnectionGUID: K3fQJnzjRcyNYUe1vcRgYQ==
X-CSE-MsgGUID: uE4DLbHRQW20juM/AbkH0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2131709"
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="2131709"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 22:53:38 -0700
X-CSE-ConnectionGUID: DI2eld/cSS2LVI98rEutGQ==
X-CSE-MsgGUID: g/ud4erERY6XRk1QPaycEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="5758316"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 22:53:35 -0700
Message-ID: <5751040a-e180-4d29-851d-3ccab96878a3@linux.intel.com>
Date: Sun, 1 Nov 2026 13:53:33 +0800
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
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/2026 5:51 AM, Nicolin Chen wrote:
> iommu_replace_group_handle() looks like it hides the detaching handle ahead
> of the driver callback. But in fact, xa_reserve() calls xa_cmpxchg(), which
> stores only when the current entry matches @old=NULL. For a replace, there
> must be an entry sitting there by definition (i.e. @old cannot be NULL), so
> the compare fails, XA_ZERO_ENTRY is never written, and the call decays into
> a plain read.
> 
> Therefore, the old handle stays published during __iommu_group_set_domain()
> and only gets replaced after the call. This creates a window, during which
> an asynchronous fault path might hit UAF:
> 
>    core, holding group->mutex          fault path, no group->mutex
>    ==========================          ===========================
> 
>    xa_reserve()                    ,-- old handle stays published
>      no-op, the slot is occupied   |
>    __iommu_group_set_domain()      |
>      driver attach/detach ops      |
>          iopf_queue_flush_dev()    |
>                                    |   iommu_attach_handle_get()
>                                    |     reads old_handle
>    xa_store(new entry)             `-- window closes
>    mutex_unlock()
>    kfree(old_handle)  [caller]
>                                    UAF: old_handle->domain->iopf_handler()
> 
> Replace the xa_reserve() with xa_store(XA_ZERO_ENTRY) to unpublish the old
> handle.
> 
> Fixes: 8519e689834a ("iommu: Extend domain attach group with handle support")
> Cc:stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)

This doesn't fix the same-domain replace issue, which can still result
in a use-after-free bug. I agree that this needs a separate lifetime
mechanism as stated in the cover letter. But is it possible to prevent
the same-domain replace case from going through this interface?

For this patch alone,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
