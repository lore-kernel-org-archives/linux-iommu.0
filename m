Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435B4430
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716513071; cv=none; b=oLZW5Lmwa8sbzKers2Vchhr+tF0db05hiKfSUlzJ//tblCzIy0ZwiLOvExwg6HFBzNg/WSV/hbjNMlWCHHFnB1PUWXe+45UQcWxzA+dTHj3c++MtxGnLrBcqVNnzwee6E2vxHUjD83c/JZyRWTqc8tQMfiW1fm00LVmDBggwuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716513071; c=relaxed/simple;
	bh=7eD2UmuhPW/+ApwIW9GMlhMuZIHesbvVW8A7NKI8QOY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m7w2brDgdypi4P3uIuy81BGj5ub0YFmG6M/F1PH0ygF6QC2XAYtlVb9UI4wsZIOyGL8tfioWHHZb3dvleEvFObbfnFqX+IO2b7RYgdQMoC0AAE/xLZ2WBcBclG2goDCnE2a9sck9mid47MOm2WkwOQfsjPkkfDhBFLAcJcGHVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nV1a2LlW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nV1a2LlW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716513070; x=1748049070;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7eD2UmuhPW/+ApwIW9GMlhMuZIHesbvVW8A7NKI8QOY=;
  b=nV1a2LlWGpJYj7L36YCtBK1+fxPjG5U+6d0zdM+CZtndyOwrnn7/VulQ
   alkpc6BMrEpO607gRzVU5G9yAstkwBnsVVvsZtm+RylxgFWAq+5Svc89h
   Nkj6jN16Pmf7EuNpGWi2rmZllMZebZTA9DQvmGiPDNcWR0QIhFCuqJJkW
   9CexgF3f6iqHIikFqTMRMKbo5b5Jbo8rhdTqCgYnmhhId9JfPk3sM8otm
   yRg+a4PB/we/Yx2NfVzyLleuN0q8G6py8JCraY2n5WBSPsVizOpLWil+F
   CYenarS7ImJ5jnuyB+b49fsYZVgnEqNxaQV0+p2zHTwe43B3gfFfW4ly1
   A==;
X-CSE-ConnectionGUID: z4fX9zeGT0ync3dGZ5hr9w==
X-CSE-MsgGUID: JRY2uldsQzWs01X5/Ci/DA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="16662313"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="16662313"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 18:11:10 -0700
X-CSE-ConnectionGUID: TP+9MNGVSm+rgXGYip3/Yg==
X-CSE-MsgGUID: eaiXLBj7TkqBRQcgNjeoGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="65065360"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 23 May 2024 18:11:08 -0700
Message-ID: <44d4013d-5c25-40ba-a599-91eee6d50a8c@linux.intel.com>
Date: Fri, 24 May 2024 09:09:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Use try_cmpxchg64() in
 intel_pasid_get_entry()
To: Uros Bizjak <ubizjak@gmail.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240522082729.971123-1-ubizjak@gmail.com>
 <20240522082729.971123-2-ubizjak@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240522082729.971123-2-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 4:26 PM, Uros Bizjak wrote:
> Use try_cmpxchg64() instead of cmpxchg64 (*ptr, old, new) != old in
> intel_pasid_get_entry().  cmpxchg returns success in ZF flag, so
> this change saves a compare after cmpxchg (and related move
> instruction in front of cmpxchg).
> 
> Signed-off-by: Uros Bizjak<ubizjak@gmail.com>
> Cc: David Woodhouse<dwmw2@infradead.org>
> Cc: Lu Baolu<baolu.lu@linux.intel.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc: Will Deacon<will@kernel.org>
> Cc: Robin Murphy<robin.murphy@arm.com>
> ---
>   drivers/iommu/intel/pasid.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
