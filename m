Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F023009FA
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765245590; cv=none; b=NIc+BibJhxXPTR2Lid9o7SK6J13A8AAd6gAFPBZYDsD8aLJiVZdRiTGyxY22KZQJPPoy5L6kONKrYEUospBwdLTjpwIOuMBKKR2n8NuxFsmzQ967U6JYlvIE47yZ0SXcVOMyZmbgFu6sA2TdQfzmh9Yz1e84qb2hBpSY4a22NIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765245590; c=relaxed/simple;
	bh=3VqMdSggJxrHPpmH+5FpuHZQMwjsfWTpiO2SJgzVl1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jx9SCRKeUGGr40b/7zCf1eQMXi0G6ddQVCSIaYnwyjLi04+AnQuPy66vpOqJn/D8yk/UfOqPycp7IhrRQ3aNIQUkZZuhkuKeRl4KkuTmPXmdzAuSqm0gcfKgfgz0UInFoqcrILjHSBuJyczuzdBjaAnhYpbIMGRt2D/j4zrwTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gR4lHXjC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gR4lHXjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765245588; x=1796781588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3VqMdSggJxrHPpmH+5FpuHZQMwjsfWTpiO2SJgzVl1E=;
  b=gR4lHXjC7z6ScXQbaLDbITvVpR9fYa3O4C6+IUftiOs9X119Y8zGAmuM
   E8tQjotcNNY+UwQ1SJgEaxuhWKG0eXkI5wJfcklmwImv5pIhHTEjVfYeG
   BZKbM7DTnXcbFzo0MzM/VShj+2FH12AQlDNFydim1aEqDJV+O9aEpjta1
   pJwo4ZgNmQ6aAdb0+2A9rZZkqn5t3Mra7KbjAWLt/hSQZfkjTvCUfma7q
   YOFz/c1I4+Pfvw60Eq79VwQ2FYvwe1g/r+lKDlU68q26UKx8tXjYo3Dk0
   E1b5HHU8bFhtLT9QZjYkjyPvJdFZ2E9TcN1zAITDM1XAJ49DF9F0/O8dM
   Q==;
X-CSE-ConnectionGUID: BTpdyUtWRGqIN3Uio3MSYA==
X-CSE-MsgGUID: UWmWKAItRQ23rP+o+pj2EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67129942"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67129942"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 17:59:47 -0800
X-CSE-ConnectionGUID: 5TdfkdsSS9CYHHtagBCGWQ==
X-CSE-MsgGUID: PeCt+jUsRVKlVClJzGUIVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="201007501"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 17:59:43 -0800
Message-ID: <99b3a5a1-600b-4419-8215-824e7a525f12@linux.intel.com>
Date: Tue, 9 Dec 2025 09:55:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com
References: <20251124200811.2942432-1-smostafa@google.com>
 <20251124200811.2942432-3-smostafa@google.com>
 <07434771-3233-4c88-b505-ee02da72c905@linux.intel.com>
 <aSV-Xi5uMJcMtk1b@google.com>
 <CAFgf54qGdWNB=Oa=vbU1hRN2XOxQSESGO6K0CiG4Qizv=T3+Qw@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAFgf54qGdWNB=Oa=vbU1hRN2XOxQSESGO6K0CiG4Qizv=T3+Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/9/25 04:09, Mostafa Saleh wrote:
> On Tue, Nov 25, 2025 at 10:01 AM Mostafa Saleh<smostafa@google.com> wrote:
>> On Tue, Nov 25, 2025 at 03:35:08PM +0800, Baolu Lu wrote:
>>> On 11/25/25 04:08, Mostafa Saleh wrote:
>>>> Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
>>>> - iommu_debug_init: Enable the debug mode if configured by the user.
>>>> - iommu_debug_map: Track iommu pages mapped, using physical address.
>>>> - iommu_debug_unmap_begin: Track start of iommu unmap operation, with
>>>>     IOVA and size.
>>>> - iommu_debug_unmap_end: Track the end of unmap operation, passing the
>>>>     actual unmapped size versus the tracked one at unmap_begin.
>>>>
>>>> We have to do the unmap_begin/end as once pages are unmapped we lose
>>>> the information of the physical address.
>>>> This is racy, but the API is racy by construction as it uses refcounts
>>>> and doesn't attempt to lock/synchronize with the IOMMU API as that will
>>>> be costly, meaning that possibility of false negative exists.
>>>>
>>>> Signed-off-by: Mostafa Saleh<smostafa@google.com>
>>>> ---
>>>>    drivers/iommu/iommu-debug-pagealloc.c | 26 +++++++++++++
>>>>    drivers/iommu/iommu.c                 | 12 +++++-
>>>>    include/linux/iommu-debug-pagealloc.h | 56 +++++++++++++++++++++++++++
>>>>    3 files changed, 92 insertions(+), 2 deletions(-)
>>>>
>>> Remove "drivers/" from the commit title.
>>>
>>> $ git log --oneline drivers/iommu/iommu.c
>> My bad, I will fix it.
>>
>>> [...]
>>>> diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
>>>> index 83e64d70bf6c..454303ec09c2 100644
>>>> --- a/include/linux/iommu-debug-pagealloc.h
>>>> +++ b/include/linux/iommu-debug-pagealloc.h
>>>> @@ -8,10 +8,66 @@
>>>>    #ifndef __LINUX_IOMMU_DEBUG_PAGEALLOC_H
>>>>    #define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
>>>> +struct iommu_domain;
>>>> +
>>>>    #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
>>>> +DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
>>>> +
>>>>    extern struct page_ext_operations page_iommu_debug_ops;
>>>> +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
>>>> +                  size_t size);
>>>> +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
>>>> +                          unsigned long iova, size_t size);
>>>> +void __iommu_debug_unmap_end(struct iommu_domain *domain,
>>>> +                        unsigned long iova, size_t size, size_t unmapped);
>>>> +
>>>> +static inline void iommu_debug_map(struct iommu_domain *domain,
>>>> +                              phys_addr_t phys, size_t size)
>>>> +{
>>>> +   if (static_branch_unlikely(&iommu_debug_initialized))
>>>> +           __iommu_debug_map(domain, phys, size);
>>>> +}
>>>> +
>>>> +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
>>>> +                                      unsigned long iova, size_t size)
>>>> +{
>>>> +   if (static_branch_unlikely(&iommu_debug_initialized))
>>>> +           __iommu_debug_unmap_begin(domain, iova, size);
>>>> +}
>>>> +
>>>> +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
>>>> +                                    unsigned long iova, size_t size,
>>>> +                                    size_t unmapped)
>>>> +{
>>>> +   if (static_branch_unlikely(&iommu_debug_initialized))
>>>> +           __iommu_debug_unmap_end(domain, iova, size, unmapped);
>>>> +}
>>>> +
>>>> +void iommu_debug_init(void);
>>>> +
>>>> +#else
>>>> +static inline void iommu_debug_map(struct iommu_domain *domain,
>>>> +                              phys_addr_t phys, size_t size)
>>>> +{
>>>> +}
>>>> +
>>>> +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
>>>> +                                      unsigned long iova, size_t size)
>>>> +{
>>>> +}
>>>> +
>>>> +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
>>>> +                                    unsigned long iova, size_t size,
>>>> +                                    size_t unmapped)
>>>> +{
>>>> +}
>>>> +
>>>> +static inline void iommu_debug_init(void)
>>>> +{
>>>> +}
>>> I suppose that all these should go to drivers/iommu/iommu-priv.h, as
>>> they are for use in other files inside the IOMMU subsystem.
>> It seemed better to have all the feature functions/declarations in one
>> isolated file, as it is included outside of the iommu susbsystem also.
>> I have no strong opinion, I can keep them in drivers/iommu/iommu-priv.h
>> if you think it's better. But then we will have to include also
>> "iommu-debug-pagealloc.h" for the static key to avoid including extra
>> files to linux/mm.h.
>>
>> Thanks,
>> Mostafa
>>
> Hi Baolu,
> 
> I plan to post a new version soon. So far, I only have the commit
> subject rewrites. Do you have any opinion on the header file split or
> the unmap size part?

I have no option regarding the unmap size part, as the comments already
declare the possible cases. For the header file split, I feel it's
better to put staff that is only used in the IOMMU subsystem in drivers/
iommu in iommu-pri.h instead of the global ones under include/linux.

Thanks,
baolu
