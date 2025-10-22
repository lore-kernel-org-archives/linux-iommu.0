Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371FF204C36
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761109859; cv=none; b=Y7pNX0ZN5M/LT71jc07HmQJ6znORzI2ELuQQgSaU2SzpjJ+VLZ/kR/B1lFZr49m1Ad/TK8DifILfBle9Izw7HgYeK+6P/awNCUIc9MZCf6Yf86qLfdk0nSiy5K2mUwYEos4HhRml+ZTpkTikT7S8CYc3F1w0DVUzNxF6G37sXUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761109859; c=relaxed/simple;
	bh=sa3pkvNdt3+2ieOyDtANYF05yDX/GehSlt5KkTBOpIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNcFLLdSl7aK9OzmaTlbRAAALZPoPJh9iqAH5EemzwNg0MKu1kfuwTnr66GijKSAv/RqWScdR+eGJX6cb60mupPJQ1TLi05A+TGtmBkRkhbiCNTUQNOYlMsIQmL5xtuxstDa0welrXkWjlME4Um8S8Oluw5MH2UQ7FPt+tIRnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNEs+/E7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNEs+/E7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761109858; x=1792645858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sa3pkvNdt3+2ieOyDtANYF05yDX/GehSlt5KkTBOpIk=;
  b=PNEs+/E7mAx1hLMw1sdG5tXgVJKSAaLsFGI0QWei06J06P7Rrr0v33wA
   ML6Ix6oTwc9FMoH87Z1w+JE2K/g7XtT909Lg11ws/3UQn7XnDE+Q7PgDF
   3gzx/WuzU1IK1v7QvdJO2h8VjVtBDyiSUPrQYpwnjp0ZTjk+aMjUK+5Fp
   m7S2pMqxiYqWl3Oh1CMF1KurYyteK3JBDGiHz/wx4L3kBy17MEaWB4vjx
   gXCSXhXiaSwEfnTaFvDeY5kiuBE3u6WQnwdc26zSwRIkZu0pvMfPshg0t
   ozCZcyi94XW3pA5bby6ZV1ZwUe6WTFlwiDOdwkBJq6wSItIp6r22NZzmM
   Q==;
X-CSE-ConnectionGUID: uMqwnh3hRBSafrzrJePZNA==
X-CSE-MsgGUID: avne4g/tSEyTGhXkj0pZcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74366785"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="74366785"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:10:57 -0700
X-CSE-ConnectionGUID: dxfXMIS5SPWjB3eWAnIlqA==
X-CSE-MsgGUID: DjyR4X0YT/ijS4596uZPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="214718411"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:10:50 -0700
Message-ID: <16775184-a98b-40dc-8fb7-168f90edb427@linux.intel.com>
Date: Wed, 22 Oct 2025 13:06:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Fix stale IOTLB entries for kernel address space
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Jiang, Dave" <dave.jiang@intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014174339.c7b7d2cfb9f60d225e4fe5ec@linux-foundation.org>
 <6b187b20-6017-4f85-93ac-529d5df33aa2@linux.intel.com>
 <ecee3200-c8e2-47ec-a219-c88e8e905b32@intel.com>
 <11cad2be-9402-4d45-8d2b-c92d8962edfc@linux.intel.com>
 <20251017140101.GM3901471@nvidia.com>
 <c3eee56a-7fe3-454c-878f-cff37467fb7e@intel.com> <87zf9pjsg5.fsf@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <87zf9pjsg5.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/25 02:26, Vinicius Costa Gomes wrote:
> Dave Hansen<dave.hansen@intel.com> writes:
> 
>> On 10/17/25 07:01, Jason Gunthorpe wrote:
>>>>> The other alternative is to have arch_vmap_pmd_supported() return false
>>>>> when SVA is active, or maybe when it's supported on the platform.
>>>>>
>>>>> Either of those are 10-ish lines of code and easy to backport.
>>>> Hi iommu folks, any insights on this?
>>> IDK, the only SVA user on x86 I know is IDXD, so if you do the above
>>> plan you break IDXD in all stable kernels. Doesn't sound OK?
>> Vinicius, any thoughts on this?
>>
> This won't break IDXD exactly/totally, it would cause it to be
> impossible for users to create shared DSA/IAA workqueues (which are the
> nicer ones to use), and it will cause the driver to print some not happy
> messages in the kernel logs. The in-kernel users of IDXD (iaa_crypto for
> zswap, for example) will continue to work.
> 
> In short, I am not happy, but I think it's workable, even better if
> there are alternatives in case people complain.

Okay, so I will add an extra patch to disable SVA for x86 arch and re-
enable it after the kernel page table free callback is done.

Thanks,
baolu
