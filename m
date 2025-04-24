Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0F15533F
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506079; cv=none; b=q24wna4+V2MKghDIeg+SIjP9sNYV7nUtH1h0/EPfQE+4AGDZC4sBo1NDQlPysrPiN5xh7CeXSoriF+b5MGsqLct4epmhV2nlXuMi32mIBidC/4sepFGFE3hPMR6J+84s68vQ3Lqz2s+env+rjZ54DATJRJhKsP0wNfhR3fS/Q44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506079; c=relaxed/simple;
	bh=im1Ve/diWjqGVy67nr8Ve06pqqzoPwZGXi4MhFwiP28=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AWQrhXfnwEwiK/VCe4jMAhZ17bA7bOQarUh4TxtL3bAgpxa8OALm344fvaM9iKJYdrU+uZ9PBOS233yWXD01w7/RbWfy4g1VM3SPwO5Mwq+Ac0xhTr1cgkZd8gYPaXEQGECoLWzzlI0lKGjqx6Qmw73tkcT6NM5AJisJf6iBEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/CZMyp0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/CZMyp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745506077; x=1777042077;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=im1Ve/diWjqGVy67nr8Ve06pqqzoPwZGXi4MhFwiP28=;
  b=J/CZMyp05HfTMOImuAIYCIN3EJo+6EomfVZM9ggUGLj3NbjpkeWxt3pV
   j06pHwwsXgUT/2wMZC6WvQAIJTh9CJDyXNWUEa3VsK9deFKn9vZpukbpi
   9SaIjBhKw5PrcoLzC33BGV9DDm6bBBSUMGNQ7fGrBbYkoJNmxIaL0GbMN
   VLB4f7wd/aF9P+5r3K3Q7WpIWIjPeZVPxfJRJbWcl9rXo9/xG555FTS0H
   PgICKzEXV2XFtVAkj1WXM4JIb8Ub19t42LM18lSbRUGZX6xnaz/xMUFdk
   Id+oXA4OQxXUnQfsh26dOq5qAc1bnQ4Q/1RQPgtLQFTvNTrf4Zm+8r21b
   Q==;
X-CSE-ConnectionGUID: T6F1fd19RQ+6vm72cQ0yvg==
X-CSE-MsgGUID: SMsD+/YxRnyLzhl1nEYLnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47281268"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47281268"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 07:47:56 -0700
X-CSE-ConnectionGUID: lc3grZADQH2yPnaWwjGwpA==
X-CSE-MsgGUID: 3wJW1MOrRRmfsjZFCrXluQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132942241"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.159]) ([10.124.243.159])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 07:47:54 -0700
Message-ID: <013a07f4-140f-4cfe-9315-f3a77e081c8a@linux.intel.com>
Date: Thu, 24 Apr 2025 22:47:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu/vt-d: Simplify domain_attach_iommu()
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
 <20250423031020.2189546-4-baolu.lu@linux.intel.com>
 <BN9PR11MB527619613B8615A94A01FF598C852@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42e8c668-e72d-490a-8a5e-8e94af90fda4@linux.intel.com>
 <20250424133759.GA1213339@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250424133759.GA1213339@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/2025 9:37 PM, Jason Gunthorpe wrote:
> On Thu, Apr 24, 2025 at 05:22:48PM +0800, Baolu Lu wrote:
> 
>>>> -err_clear:
>>>> -	ida_free(&iommu->domain_ida, info->did);
>>>> -err_unlock:
>>>> -	kfree(info);
>>>> -	return ret;
>>>> +	return xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
>>>> +			       no_free_ptr(info), GFP_KERNEL));
>>>>    }
>>> no_free_ptr() should be used before successful return. Here xa_store()
>>> could return error but at that point no auto free as no_free_ptr() already
>>> changes 'info' to NULL. then memory leak.
>> Hmm, I've considered this. My thought was that xa_store() failure only
>> occurs due to the system running out of memory, and the Linux kernel
>> can't recover from it. In that case, the system is already broken;
>> hence, handling the failure case here doesn't make things better.
> That's not the kernel pattern, you are supposed to unwind correctly in
> those failures
> 
> I think you should not use cleanup.h for something complicated like
> this..

Okay, so let me drop this patch.

Thanks,
baolu
