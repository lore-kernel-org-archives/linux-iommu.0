Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245EFBA27
	for <iommu@lists.linux.dev>; Wed, 17 Jan 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476778; cv=none; b=Ql6p5tGj3Dr1RqVUJA+rhaoD67HL71tbXaMYw/njWMk/MUHGoCvs8o0XVJbrLEAG04BYEo1pQbufqHsS8SwxZYxIozZxR1k9hMWYqSHOMGBbuuNluDPmwMLxInOUTY6lRdOphc+AVdQOfpXhoIOYjYxtHk87gg/D6jwW7tIEFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476778; c=relaxed/simple;
	bh=mgU4BK0WZGpnh+ZZ8nJeZlcBrjKg45dZcQfWkqRiXwI=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Cc:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=SxX+w2Um83d6aUAbdyxvv+afVhk3NSNQkGAVNevKoR0qnQdp9zUj/40D090h6yNsDB5a/AJ1T2CnHGhyUrqvIQUYI8jhrD7KkqytObAl72BZxQUTIrMM/FPv6QYNtoJXFFm8pIg+gS20b5f7LfBD4Xy+/5WpdRGfRZA7HRaukyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcdnzW8W; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcdnzW8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705476777; x=1737012777;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mgU4BK0WZGpnh+ZZ8nJeZlcBrjKg45dZcQfWkqRiXwI=;
  b=PcdnzW8W0wHgu3/SU8xEcOXEDwUKgnco8+3n1MgkfxAoclCZ67d78jek
   MDzjJnjVURFP19OZArW8DfmXjKh1b91bR5cVcOQ9oGWQC7+iXqk35AUb4
   4mdnyhRZNGqaWiVCwJHxBta4R5iPz1P70IIKt8VyMsMSs7upficGVxJ4f
   q0iBVsaiaLiLFVPJjTv6LbjIJbzFrh7YpnZkV3WNrmqDKxxMtqjrOxcz7
   Bvnm2CGOHA8qXjLW4CB/BQjp12N33kLYWGmB39FV1eBDkRhIzLvHYE59j
   gplEMN5HfOCCTAw2CXeHigDafzK500rTpYqjUWdxdOxOdAISnwQmzzGyI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="431258147"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="431258147"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="907665085"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="907665085"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.146]) ([10.249.171.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:32:54 -0800
Message-ID: <eb13b149-729b-4b22-a6df-63e73ecd73a2@linux.intel.com>
Date: Wed, 17 Jan 2024 15:32:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 08/11] iommu/vt-d: Add domain_type_is_sva helper function
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-9-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240116011146.18645-9-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/16 9:11, Tina Zhang wrote:
> Introduce a helper function to tell if the type of a dmar_domain is sva
> or not. In general, comparing with normal iommu_domain, a sva domain
> shouldn't be special other than having a different source for the page
> table. Thus, this helper function should be used as little as possible
> (i.e. only in the cases related to handling page table source).
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 0eec5d971315..af466ba301b7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -244,6 +244,11 @@ static int domain_type_is_si(struct dmar_domain *domain)
>   	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
>   }
>   
> +static inline bool domain_type_is_sva(struct dmar_domain *domain)
> +{
> +	return domain->domain.type == IOMMU_DOMAIN_SVA;
> +}

Move the helper into the header file and put appropriate comments around
it.

Best regards,
baolu
