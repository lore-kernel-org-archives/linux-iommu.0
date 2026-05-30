Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3723546C2
	for <iommu@lists.linux.dev>; Sat, 30 May 2026 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147999; cv=none; b=ScWd5vkjGY9rZkq3oCNZL3peRL7fmP0kPbwqiW2uq5atyeNNHgICD3SGN7oKoCsZszFBJ7w+fYlOXdSJ4yQPItROuROlDYupbD9XUxIj56cUbO2yaxkr05lgrt2x1AGuCVqHQt+mVhCQ3/dMfODkCSE9Io+9dU8vD+/LDy2b1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147999; c=relaxed/simple;
	bh=DV8avSd2gR/xIE3FWT+avQsI+z9YZ+nQwoYVboIYLIE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RF0vIDU/56lWE1Qo8S5hDNlQPjDnwPpqaDhO+C8oauryZVk9lMsJuaNgXXpahjSF3DNfc69zO4rqN487sN/Vx6FaXN1pVA9cJ2xS5hec2pmEQmB1hCVjj+/UBN4kcnlPVtVq2xAh5wPwRGnbNpu7rNCZX/EAK0OeyTVNOELYejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDYdP5kl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDYdP5kl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780147998; x=1811683998;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DV8avSd2gR/xIE3FWT+avQsI+z9YZ+nQwoYVboIYLIE=;
  b=YDYdP5klTXjobgPN0ZJWggGrjF8YIWqOgLfGfrybmNzrla27k0yHkKoi
   kY915ik6MRP7OvqqsAr3X2hi3OPMysq7QPz5gG/1SE6/5G61wnbOUCXBp
   PjwQL+IelNYdCdP0RDq/6loWUowwh8WZe6ZxRVVwcNGBSJfZihNgaInSA
   /pyVWU3nBZ6m2gQdaMkxg1GWAcC/QA4HfWWgHQKtmu0bn48BP9z4ATi/D
   PcCFNAbnnrllOT85Ms+1Ta7DNNTMK2YNnS96+rmSwt+aqHoJTcp8JEZ9r
   6zbzGP+01YNtz8ACvKJw5RuvrsQ89EVjsfzE0cfkddxSztJ7jgjaljRfu
   g==;
X-CSE-ConnectionGUID: XaaP/RYLS/iukit1QllRhw==
X-CSE-MsgGUID: EKn4XDmfSFGxgNyes+YxhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="98547931"
X-IronPort-AV: E=Sophos;i="6.24,177,1774335600"; 
   d="scan'208";a="98547931"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2026 06:33:18 -0700
X-CSE-ConnectionGUID: AQWeH3t5SPazRAC00+l+ZA==
X-CSE-MsgGUID: uo024BNSRNiSHhfP9rRR8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,177,1774335600"; 
   d="scan'208";a="266739136"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2026 06:33:15 -0700
Message-ID: <fa33f355-a21d-4d6c-ad45-c2bd455a9eab@linux.intel.com>
Date: Sat, 30 May 2026 21:33:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Fix Use-After-Free in probe error path
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260529113410.491538-1-praan@google.com>
 <20260529113410.491538-3-praan@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260529113410.491538-3-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/2026 7:34 PM, Pranjal Shrivastava wrote:
> When intel_iommu_probe_device() fails after the info structure has
> been linked to the device via dev_iommu_priv_set(), the error path
> calls kfree(info) but does not clear the pointer in the device
> structure.
> 
> This results in a Use-After-Free regression if the pointer is accessed
> by a subsequent IOMMU core call or a re-probe.
> 
> Fix this by ensuring dev_iommu_priv_set(dev, NULL) is called before
> freeing the info structure in the error path.
> 
> Fixes: 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path")

Fixes: eda1a94caf6b ("iommu: Mark dev_iommu_priv_set() with a lockdep")

> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260525205628.CD4431F000E9@smtp.kernel.org/
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>   drivers/iommu/intel/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2702e9aa2241..6c718adf97ae 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3320,6 +3320,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   clear_rbtree:
>   	device_rbtree_remove(info);
>   free:
> +	dev_iommu_priv_set(dev, NULL);
>   	kfree(info);
>   
>   	return ERR_PTR(ret);

Thanks,
baolu
