Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465BD303C9B
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506942; cv=none; b=kQLkOjB0NR90ijvbYaMLaUvd3ypmBZ9wt0ebdu0ZH+lJNLU1LK3QYFGtUtkRvhkBuceF6qvq94hCg4v0oz6lxsJzIULlmOA88C00JWmnt+yBiaH+QAqZElWbe/BY0/mLCqHCs32dUcV7dHlAxrurAyMgpcvZQtlBqdFUyR7ltaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506942; c=relaxed/simple;
	bh=M9nLxMplSMiBhPOFPdGzBcv2AwYk5gsRtz+J0q0qQz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCtoPMT3EkMdiwcyXqJP0lPqeq7E4KSdfVA8spYm12cccHg9Nsv334YZORqPy/Mubeo7juw2W2llcXuVaRrpzWy8JD+kJZA9KMwB1cPSd/oaSp67mC0WiuhQPjM0DupMfH0in2BJ1A2zu9ZvfAUVg35mtwGjJL6y/682scazFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nT063UBo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nT063UBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760506940; x=1792042940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M9nLxMplSMiBhPOFPdGzBcv2AwYk5gsRtz+J0q0qQz8=;
  b=nT063UBoE6LK78Ze/UAzXmqQ19gOHKboKFR2XXabTEU49EMq34rJ0Yg1
   ca+Q1+H1rIiWlYyLFP7NAndEjyROMNXydb6m7IbDbNL8qYYbSJEAqe8CT
   jUHLB2a7PfNQ3y/119FUz/c3I6Q/+nmtpMi0V5R+DmC83ytm321NuzZ+t
   b6vt7u5icxGQZnijSG74391Vfn3xy8Dz0dj/7Uge+MFDm2RAlFRE20RKi
   g/p8LGWcrhHijlpgn48ay/FPAw1ige0CuJVlOZzsSdoT13FzQ5ekkTiyA
   i0JtS4YyVsjaTUqdke/4gdrQIz/rquXfA2KK14lIBe0FFOdNUldQoXwew
   g==;
X-CSE-ConnectionGUID: GbgXAXGzQ5ma+CP8U4pSiQ==
X-CSE-MsgGUID: Avo8Q89bQym2dAo2xDj0tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73275246"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="73275246"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:42:19 -0700
X-CSE-ConnectionGUID: V4z70CP6R2+/0T0j+LTmrQ==
X-CSE-MsgGUID: d6UKwrkaROSSKj4Zgv4T0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181296500"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:42:13 -0700
Message-ID: <6b187b20-6017-4f85-93ac-529d5df33aa2@linux.intel.com>
Date: Wed, 15 Oct 2025 13:38:33 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Fix stale IOTLB entries for kernel address space
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014174339.c7b7d2cfb9f60d225e4fe5ec@linux-foundation.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251014174339.c7b7d2cfb9f60d225e4fe5ec@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 08:43, Andrew Morton wrote:
> On Tue, 14 Oct 2025 21:04:30 +0800 Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> This proposes a fix for a security vulnerability related to IOMMU Shared
>> Virtual Addressing (SVA). In an SVA context, an IOMMU can cache kernel
>> page table entries. When a kernel page table page is freed and
>> reallocated for another purpose, the IOMMU might still hold stale,
>> incorrect entries. This can be exploited to cause a use-after-free or
>> write-after-free condition, potentially leading to privilege escalation
>> or data corruption.
> 
> Is only x86 affected?

RISC-V is potentially another one. The RISC-V IOMMU driver doesn't
support SVA yet, but I believe it will be there soon.

> 
>> This solution introduces a deferred freeing mechanism for kernel page
>> table pages, which provides a safe window to notify the IOMMU to
>> invalidate its caches before the page is reused.
> 
> Thanks for working on this.
> 
> Can we expect any performance impact from this?  Have any measurements
> been performed?

This change only defers page table page freeing, allows for batch-
freeing of page table pages, and notifies the IOMMU driver to invalidate
the related caches. It doesn't impose any overhead in any critical path;
therefore, I don't see any potential performance impact.

> 
> Only [7/7] has a cc:stable, even though that patch is not at all
> backportable.  Please give some thought and suggestions regarding
> whether you think we should backport this into earlier kernels.

Yes. We should backport this series to stable kernels.

> If "yes" then the size and scope of the series looks problematic.  Is
> it possible to put together something simple and expedient just to plug
> the hole in older kernels?

Squashing some patches is one way. But would it be workable to backport
this series manually? Say, could we send a pull request to the stable
mailing list after this series has landed?

> 
>>   arch/x86/Kconfig              |  1 +
>>   mm/Kconfig                    |  3 ++
>>   include/asm-generic/pgalloc.h | 18 +++++++++
>>   include/linux/iommu.h         |  4 ++
>>   include/linux/mm.h            | 71 ++++++++++++++++++++++++++++++++---
>>   arch/x86/mm/init_64.c         |  2 +-
>>   arch/x86/mm/pat/set_memory.c  |  2 +-
>>   arch/x86/mm/pgtable.c         | 12 +++---
>>   drivers/iommu/iommu-sva.c     | 29 +++++++++++++-
>>   mm/pgtable-generic.c          | 39 +++++++++++++++++++
>>   10 files changed, 167 insertions(+), 14 deletions(-)
> 
> It isn't obvious which tree should carry this.  Were you thinking the
> x86 tree?

It could also be through linux-mm tree?

Thanks,
baolu
