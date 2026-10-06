Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0691F63D9
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791252675; cv=none; b=HRfetNlfLRvf+vcrhe4mTD3lUqOy2gTE6oZk39zkOZTUc9IT8kYyg+gr2wiMMGRe1DKz+C8QCAhTu7GRzftTZ3Li3a5ZoCZGI19XglcESz+xfLVCmeT6CVoZqXVB0BlP+wAKDTk7OCYmUGV8aTi77yt5Of8G2uVm0u1yF4/8HXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791252675; c=relaxed/simple;
	bh=f7D5f2zBx5F+sgI5FQe36BPmSURC8axCxrmXCcSCeLk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MzQ8bsRWlWmW8191ty8JM6HT4GWIro2vwNkszfOfZgGJAeFV1i/IIrBr7rQe0Bm9HXNcqk6SvHe13H8XoFVsWYKuFOsfOLuGyMwYkjww7/IOliEp7JG6JWnoFYOCQs5pWYHWSPPDF/AAcxKPsz/kldtEZJK84RiMQNMKBiDr0yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsStrUOG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsStrUOG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791252673; x=1822788673;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f7D5f2zBx5F+sgI5FQe36BPmSURC8axCxrmXCcSCeLk=;
  b=gsStrUOGQPdnyGEYE0rHz5ZBqoflWTrTqHyYCUjVsOLgRZ5ZeQNLlEeZ
   uCEipZWG3I2n5Ty1UTuG4osDGeEgllVG9zaR1HxaGVVfyOHIyx7Mm9f29
   ApO83FK8n1qfGNde3qWJjBSd9wi3+Msl4VYTyBIL15HwDO6DYt3hFqCIf
   uT98KUWn3nTAzJXvDfCqcaJoPHQzhSVZ7B4YSpaHsaUVTp9Qd12Qi9cfZ
   lRWXv3wqrrphvq+ZE+gtswGR+G3RymjCf53cwVQkaySuxxKIK3IWszv9q
   Ikp/Ysex+PEKZ0y5tyMGz0qV/HfGSq/LXElPDRZTyrjsF8Xw5VDP+DK+H
   g==;
X-CSE-ConnectionGUID: ZstRrQ43QmqqJ/7eWal55A==
X-CSE-MsgGUID: QZj1Zov8RG+g4j+gqmVr2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="92043504"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="92043504"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 19:11:13 -0700
X-CSE-ConnectionGUID: JMlpMnjZRm2Lg3EHqiJSow==
X-CSE-MsgGUID: M6Yz8J13RI+O1j1rLUvqGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="275643023"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 19:11:11 -0700
Message-ID: <bd1240e6-c678-4be4-8f64-881d4a43b0f3@linux.intel.com>
Date: Tue, 6 Oct 2026 10:11:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix iopf_refcount leak in nested RID
 replacement
To: Jiale Yao <yaojiale02@163.com>, David Woodhouse <dwmw2@infradead.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260924115027.656743-1-yaojiale02@163.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260924115027.656743-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/2026 7:50 PM, Jiale Yao wrote:
> intel_nested_attach_dev() enables IOPF for the new nested domain without
> releasing the reference held by the old domain.  Replacing a domain with
> an IOPF-enabled domain therefore leaves an extra reference in
> info->iopf_refcount.
> 
> Commit 236dd58fabd2 ("iommu/vt-d: Fix iopf_refcount leak on RID
> domain replacement") fixed the same IOPF reference leak in the regular
> RID attach paths.  The nested RID attach path has the same old-domain
> handling bug.
> 
> Use iopf_for_domain_replace() for the attach and restore the old domain
> reference if nested PASID setup fails, matching the existing PASID path.
> 
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> Link: https://lore.kernel.org/all/20260731054329.2948252-4-baolu.lu@linux.intel.com/
> ---
>   drivers/iommu/intel/nested.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index 2b979bec56ce..dbcec6093d50 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -50,7 +50,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>   	if (ret)
>   		goto detach_iommu;
>   
> -	ret = iopf_for_domain_set(domain, dev);
> +	ret = iopf_for_domain_replace(domain, old, dev);
>   	if (ret)
>   		goto unassign_tag;
>   
> @@ -67,7 +67,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>   
>   	return 0;
>   disable_iopf:
> -	iopf_for_domain_remove(domain, dev);
> +	iopf_for_domain_replace(old, domain, dev);
>   unassign_tag:
>   	cache_tag_unassign_domain(dmar_domain, dev, IOMMU_NO_PASID);
>   detach_iommu:

Thanks for the patch, but we already have a fix in the iommu tree:

83871c3ae10e ("iommu/vt-d: Fix iopf refcount leak in nested attach")

Thanks,
baolu
