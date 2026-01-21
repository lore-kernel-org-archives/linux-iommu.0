Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2E4534B6
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980553; cv=none; b=iHaHy49BgTYq0jLNEhhymZqgWzgMP/jlRM5RmCbAczEYw1NSTy6dUizxpn/G7QgybYzy2d67hNfHJYOiUMcohVDVMcs91t7TDx/qiX06HcZmE+NzTh9HgsXjwc9Wb8f3myhkkoNHmkFtUUzH9HZbcsz7BH0P93usTzoInIbQWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980553; c=relaxed/simple;
	bh=sZC9/40ABxh7RwSmrB46lUvB8P+jEp+Zte5qlGC9bCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTqPDvHdI683zv5do9pj0VOOdk3bs4kJOb7xxjyVNFUxI70t3/sl7bnISKh5UGrx0exFVnV/ISH67bCC8FR6RsJ8tBVyEdt9ptkvVrFqBtnOAFQs5ONNBoXQvl4rePcGH+hJHQIWZ98liefK374d6VRb5f28fkzh0j98Am/+lAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crDZVaij; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crDZVaij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768980546; x=1800516546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sZC9/40ABxh7RwSmrB46lUvB8P+jEp+Zte5qlGC9bCA=;
  b=crDZVaijP6s/DYxFZZFpTSxKmMRENO4kXyOgEIaIaQ6cqwKtY6bYSrNx
   y19TmhdeuRAwtij377GXaUwbD91+rr9uMfWXkFQb9j8NXgxtr14lo6axw
   HmclCUNJ8VOzBiIsMX7huBE2E8pSyKgB7777vAqp4v5DacoT6KT7BOtGj
   5jH+b7tR8EtEcpkJt+9Uj5josom7y2U4vM09OuzaXvidDz22zvAKi36b2
   nbIGYTAf2gmSbyfxvTOTHvvT819hlZAkH+HJv1YFwOqhzD34bveTDaoRC
   1ZJXC3OVsQawcOYPERUZwgDo38HtoDRAKv51HuVkKkWxsEWyeGhzMYpTL
   A==;
X-CSE-ConnectionGUID: 5R0NYUDRRTqiUGlhG13vVg==
X-CSE-MsgGUID: sgib5lFiTx2Iz4nCZlOV5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70256545"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70256545"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:29:03 -0800
X-CSE-ConnectionGUID: ydZNN5eMRzy5an+ZTsmi2Q==
X-CSE-MsgGUID: 7RtRJt/FSuGbzTdpQP39VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206289920"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:29:01 -0800
Message-ID: <a2c1531a-f720-412f-9f39-6a6b9fabe5e7@linux.intel.com>
Date: Wed, 21 Jan 2026 15:28:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down
 context entry
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
 Samiullah Khawaja <skhawaja@google.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
 <20260120061816.2132558-3-baolu.lu@linux.intel.com>
 <BL1PR11MB5271F1F4DF8B6D4052D626088C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB5271F1F4DF8B6D4052D626088C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/21/26 14:23, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, January 20, 2026 2:18 PM
>>
>> When tearing down a context entry, the current implementation zeros the
>> entire 128-bit entry using multiple 64-bit writes. This creates a window
>> where the hardware can fetch a "torn" entry — where some fields are
>> already zeroed while the 'Present' bit is still set — leading to
>> unpredictable behavior or spurious faults.
>>
>> While x86 provides strong write ordering, the compiler may reorder writes
>> to the two 64-bit halves of the context entry. Even without compiler
>> reordering, the hardware fetch is not guaranteed to be atomic with
>> respect to multiple CPU writes.
>>
>> Align with the "Guidance to Software for Invalidations" in the VT-d spec
>> (Section 6.5.3.3) by implementing the recommended ownership handshake:
>>
>> 1. Clear only the 'Present' (P) bit of the context entry first to
>>     signal the transition of ownership from hardware to software.
>> 2. Use dma_wmb() to ensure the cleared bit is visible to the IOMMU.
>> 3. Perform the required cache and context-cache invalidation to ensure
>>     hardware no longer has cached references to the entry.
>> 4. Fully zero out the entry only after the invalidation is complete.
>>
>> Also, add a dma_wmb() to context_set_present() to ensure the entry
>> is fully initialized before the 'Present' bit becomes visible.
>>
>> Fixes: ba39592764ed2 ("Intel IOMMU: Intel IOMMU driver")
>> Reported-by: Dmytro Maluka <dmaluka@chromium.org>
>> Closes: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> btw there is a context_clear_entry() for copied context entry in
> device_pasid_table_setup(), but this patch doesn't touch that
> path. It seems to assume that no in-flight DMA will exist at that
> point:
> 
>          if (context_copied(iommu, bus, devfn)) {
>                  context_clear_entry(context);
>                  ...
>                  /*
>                   * At this point, the device is supposed to finish reset at
>                   * its driver probe stage, so no in-flight DMA will exist,
>                   * and we don't need to worry anymore hereafter.
>                   */
>                  clear_context_copied(iommu, bus, devfn);
> 
> Is that guaranteed by all devices? from kdump feature p.o.v. if
> that assumption is broken it just means potential DMA errors
> in this transition window. But regarding to the issue which this
> patch tries to fix, in-fly DMAs may lead to undesired behaviors
> including memory corruption etc.
> 
> So, should it be fixed too?

This path is triggered when the device driver has probed the device
(ensuring it has been reset) and then calls the kernel DMA API for the
first time. At this stage, there should be no in-flight DMAs. We can
apply the same logic here to improve code readability, but this is not a
bug that requires a fix. Or not?

Thanks,
baolu
