Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACF1EB198
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482600; cv=none; b=J/pepTnpIJrrD8paVETXJOugd9i/llifai1MijaTPIriFCXR6704gur49+FflVmseycUnYRlGZ+atcxuEZNJ4a2W3slQ8YSrAV/DST0QdzYEu5+y1F120T6brmqoNWdYUXk7SNJLGZOeS7Tf6sencqUHQdoGvgqSxcofNNvuPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482600; c=relaxed/simple;
	bh=nPXhFRCwYx2fRNovVNipmFldzgMB8andNjSpocW5M84=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qNxlkL7ojXViBjuE8Qg7MkHZjicHhmPGlLRdIp7mbmCDuV14oL6Pe+Kkj0b+4V3LTI89J2GiWxixGUPfudhDgcrNaPxbdgNDbiW4BN/z5QqHxOZDoRT/BD2r3+z6coRmz0BBnTtjWAaMg0LMh4HjGEnXQXd8s+lBm1GU4xkw5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIySuxDh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIySuxDh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745482599; x=1777018599;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nPXhFRCwYx2fRNovVNipmFldzgMB8andNjSpocW5M84=;
  b=NIySuxDhKa52YMmcOWpbmr1SEBPoxmApsI0SjaVuDhpjb11mrDzThE0l
   1bxdxy3pkal41BHrJ1BEbj4X/StUPlosP7t0eGtmzIV3JbIKm/6c4DjXc
   ET3IwAZ/zE8Xgu1nziSqkDXX+2ul0JutGamW2qE8C2fs32VDoqGlo6eeH
   DPIIpiOjH9M4q/NitRSvQsUK/Su+amOss1aBjMPeR7it2AaaxAR6L47jc
   wS2eEvQC1IvWB0Faya2Bk2WE+0j+EBv0sVJQB5PhBiUdco+JNwrOwvq2q
   25/e04cMJmLkQjYol7BU1Jz8F0vi0k4xPhVDR0hLlnMiZ0fFkbVzlmt4I
   Q==;
X-CSE-ConnectionGUID: p7pjW8IWSH+jyvGA8fatvw==
X-CSE-MsgGUID: JDQmXQauTvOePlEHpTsiPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57744987"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="57744987"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 01:16:38 -0700
X-CSE-ConnectionGUID: 7BcdFlHETDm5k1fqZKWqnQ==
X-CSE-MsgGUID: 1vI6oFjQTJKg0ZdU4nkPNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="137642465"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.159]) ([10.124.243.159])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 01:16:36 -0700
Message-ID: <79da4184-f5b6-461d-a5fa-f07124b37521@linux.intel.com>
Date: Thu, 24 Apr 2025 16:16:33 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iommu/vt-d: Use ida to manage domain id
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
 <20250423031020.2189546-2-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250423031020.2189546-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/2025 11:10 AM, Lu Baolu wrote:
> @@ -2042,7 +1998,7 @@ static int copy_context_table(struct intel_iommu *iommu,
>   
>   		did = context_domain_id(&ce);
>   		if (did >= 0 && did < cap_ndoms(iommu->cap))
> -			set_bit(did, iommu->domain_ids);
> +			ida_alloc_range(&iommu->domain_ida, did, did + 1, GFP_KERNEL);

ida allocation range is inclusive, thus here it should be,

ida_alloc_range(&iommu->domain_ida, did, did, GFP_KERNEL);

>   
>   		set_context_copied(iommu, bus, devfn);
>   		new_ce[idx] = ce;

Thanks,
baolu
