Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F495391
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 02:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686017714; x=1717553714;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2+x9x3aVu8jpXG444ChRjyq19G6IXrdivnoqOp4FTj0=;
  b=QF9I4DEo0v6A7KjouyDLToc+ZlYyPissqAAUJieFWXOX+StpAv3RodFM
   iG26M3OeRhbYeq04XciA2/TXe4RiWGZ4voXAo9dNEXP+w0QL+u8Ldy361
   f+sJ7NFMOr855ruPvK3EHnYs3teNSIgyx/rRhY0b4mwwdRf54ywMyf1LM
   FjljYf2wD35otUeutbYg9LujWfBy9U2lKxmBPP6jVJ91bg7QwC91fVrKA
   UPf4FBrF7p+Po2XcpQspKDL3YZQwu8kBtq/64gPBxSoUx5lcrluzcgBTa
   rNh2JYIjFZA07CafJfxVRsKksGikDh3Lp2OL0zMKOgW6H0SeJqUuIDT4D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442917647"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="442917647"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 19:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="955563560"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="955563560"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.40]) ([10.255.31.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 19:15:12 -0700
Message-ID: <f416c0dc-a82b-f608-4c6a-c2441b417bfb@linux.intel.com>
Date: Tue, 6 Jun 2023 10:15:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com
Subject: Re: IOMMU software bounce buffers and their overhead
To: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>,
 iommu@lists.linux.dev
References: <CAD7mqryC_JROVXY9eD--iigjCU9266+ufPvZO2BujhVfM7qYfw@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAD7mqryC_JROVXY9eD--iigjCU9266+ufPvZO2BujhVfM7qYfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/6/4 0:49, Chathura Rajapaksha wrote:
> Hi All,
> 
> I have a few questions about IOMMU software bounce buffering.
> Description of the kernel config IOMMU_DEFAULT_DMA_STRICT mentions that,
> "Untrusted devices always use this mode, with an additional layer of
> bounce-buffering such that they cannot gain access to any unrelated data
> within a mapped page.".
> 
> What I am trying to do:
> What I understood from the above description is that the STRICT mode
> provides an additional layer of security for the hardware IOMMU.
> I want to measure the overhead of this additional layer of protection
> (software bounce buffers).
> 
> My questions are:
> 1. Is my understanding correct regarding the software bounce buffers
> being used alongside hardware IOMMU, or do software bounce buffers replace
> the hardware IOMMU?

No.

The strict mode represents that every time a DMA buffer unmaps, the
IOMMU caches (IOTLB and possibly device TLB) will be invalidated and the
cache invalidation will be completed before the unmap is returned.

The IOMMU DMA bounce buffering occurs only when the device has been
marked by the PCI subsystem as an "untrusted device". You can get more
details about "PCI untrusted device" and how IOMMU subsystem addresses
them by reading this:

https://lwn.net/Articles/786558/

> 2. Are untrusted PCI devices use SW bounce buffers by default in the upstream
> kernel?

Yes.

> 
> 3. Are there already available numbers for the performance/memory overhead
> of software bounce buffers?

It's case by case. I haven't seen a complete study on this aspect yet.

> 3. How can I enable/disable software bounce buffers without
> enabling/disabling strict IOTLB invalidations?

You can't disable it. Perhaps you can hack one for your test or
evaluation purpose.

Another option is to use ACPI/DT overriding and tell the OS if a device
is trusted according to your wishes if you are playing with an out-of-
box Linux kernel.

> Details:
> Since I want to measure the overhead of SW bounce buffers, I want to
> know if there is a way to enable/disable only the bounce buffers while
> keeping all other configurations the same. Any suggestions on how to
> properly measure the overhead is welcome.
> 
> I tried to find answers to these questions in kernel mailing lists and
> documentation but I could not find the exact answers.
> References I looked at so far:
> https://www.kernel.org/doc/Documentation/x86/x86_64/boot-options.txt
> https://www.kernel.org/doc/html/v6.3/admin-guide/kernel-parameters.html
> https://lore.kernel.org/lkml/20190730045229.3826-9-baolu.lu@linux.intel.com/T/
> https://lwn.net/Articles/786558/
> 
> I really appreciate any help on this. Thank you in advance.
> 
> Regards,
> Chathura
> 

Best regards,
baolu
