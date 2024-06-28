Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554EE1E898
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577435; cv=none; b=cKRpSX750w5/L9rY0c9Sj8JBY7lnNJf6saflkDAfTKsgB/jkvkYL1HE0/PS+NzqtXaXtUP+SP8ECm/LyAoKhW1oe7zoMo9gVNNCoew1uuN9OIrTomwHVkP9hCw0PixW+4iYbJJ6jE/4bS8sW8VhTMXKBqs+w7E7J7bonIZeB0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577435; c=relaxed/simple;
	bh=GfeJoLbm3e5yZQY6C7I1nB0pzBkzKoxqQ5Y8bG9Dijo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B9n1tqMAeB/ZGdQuYoNwPS+cb8yTQJsgQxFwVPNzD6xvWMtzGEFvVCGGIfsmaDQyyT4sFwMe4vuzvP0LhYZBPCxykgwiPirYER1APC/fm1A/JzamSBQjJ9lJODXS91Kn+vWrMJH9sCebr9dUiUjmKIsU0dtKc9CUbSc+rXJlheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsIqZPTQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsIqZPTQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719577433; x=1751113433;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GfeJoLbm3e5yZQY6C7I1nB0pzBkzKoxqQ5Y8bG9Dijo=;
  b=lsIqZPTQq/5KFL9wW4VcqcNEeZz/H6UuORTnOo9QK+kFVMm5UF8/y750
   6e2kZ10NtxHtgR2nk+xkdzkD9dHgQmefbWXWvNhdGp2oKUqkrj9leINXp
   EfncCi+DzKbfECZYaYATN1OTapUt6WjJ5puv+XAGPuuPxXK1oaGut2wbF
   t5DXcT7/CxCkWwtCO0iKZa96LxpOEycpx9A0uAwQcNk3UDkrLxR9MJ1Ct
   +DvxwtV0VSCwivjFxhZ97yn3sPSyg8pkSt9v8f05JkjXafoYkIuIBBOOC
   LhG5V8fMoG2RevxDPgP5IKoy/89Zx5KM5TKgLOh7DV8+GqjHzdVG4ngJw
   g==;
X-CSE-ConnectionGUID: T9KzZ36XTHaLa6pEBWRRww==
X-CSE-MsgGUID: 791wEwwYQyC43s7gcGt4og==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16433706"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16433706"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 05:23:52 -0700
X-CSE-ConnectionGUID: z/DtRjCxTVeRFMdT5A4pPA==
X-CSE-MsgGUID: ElDS3E3mTd6OFz722a3nyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="49679784"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 05:23:51 -0700
Message-ID: <ece72a5e-e4fa-4fe9-9d03-ad31d7a4b212@linux.intel.com>
Date: Fri, 28 Jun 2024 20:23:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/28 14:43, Vasant Hegde wrote:
> We are working on adding domain_alloc_paging() support in AMD driver and came
> across below issue.
> 
> BACKGROUND:
> ============
> - AMD IOMMU HW has two different page tables : V1 (host page table) and V2
> (guest page table). Only V2 page table supports PASID and PRI features.
> 
> - With V2 page table we have an aliasing issue. Hence we added
> per-device-domain-id when domain is configured with v2 page table. See upstream
> commit 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential
> TLB aliasing issue")
> 
> 
> 
> PROBLEM :
> =========
> With iommu_ops->domain_alloc_paging(dev) API AMD driver will chose best page
> table based on device capabilities (V2 for PASID capable device and V1 page
> table for rest of the devices).
> 
> But we would like to continue enforcing V1 page table for UNMANAGED domain. As
> in terms of IOMMU caching, it performs better than V2 page table.
> 
> Also while adding SVA in AMD driver Jason mentioned that we should support PASID
> with UNMANAGED domain. As I understand currently we don't have this feature in
> upstream but we would like to support it in future. Keeping this use case also
> in mind, we came up with below two options :
> 
>    1 - Pass domain type : domain_alloc_paging(dev, type)
>     When we add PASID with UNMANAGED domain we need a way to differentiate the
> domain 'type' (See below attach sample code)

The domain type is not enough for the iommu driver to differentiate
between device or PASID. For example, a domain of type UNMANAGED could
be attached to either a device or a PASID. Furthermore, SVA domain is
not a paging domain.

>    2 - Introduce new flag for domain_alloc_paging()
>      Something like :
>      #define DOMAIN_FLAG_UNMANAGED	0x01
>      #define DOMAIN_FLAG_UNMANAGED_SVA	0x02
> 
>      domain_alloc_paging(dev, flag)
>      For now we will have 'DOMAIN_PAGING_UNMANAGED'.

Add an allocation flag seems to work. It doesn't indicate any type of
domain. Instead, it indicates the required iommu feature.

Something like

#define DOMAIN_ALLOC_FLAG_PASID		0x1

means the allocated domain requires PASID to support on both device and
IOMMU. If the hardware lacks this support, it should return failure.

Best regards,
baolu
