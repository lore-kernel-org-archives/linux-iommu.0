Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02091DFE22
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505813; cv=none; b=LenvZ8uYCBAQlq/2wXdn42+eAAI09XPROs2bmKUWBrkpcW7N+V0ODiwoyAOv6haCQKgOa4ug0P/GgbZ/8VUgU4Pq4ETxR5cxyeZATsz+lQCVLbzGbopA2YaqKj+hqAh4Vn7IdIL9rXtLXBRZDKTsYVLbv3JlA3fQ+qqU7wyFgIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505813; c=relaxed/simple;
	bh=eK0inZ4rNk5w2Qq8gSVATW8wmK6XxymTxfw6OxJSz54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTa0ity0jYqkCBqVGwtqCNPZe1l1oY0eDW8dPRs01uLvsETVnYaKC2fn3LnbKXWd71WqYDKplwUkPIQZUalUNPzPw9I5lNTOwFD5spXPMVoCPlrgP4wZ/K9XDW2vthPRrEoz4qhwyTAalh2waAKs9TmcbQ8NGZ1b1le6HbT3nBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deT1h9c0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deT1h9c0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760505812; x=1792041812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eK0inZ4rNk5w2Qq8gSVATW8wmK6XxymTxfw6OxJSz54=;
  b=deT1h9c0YoNr37UIT34YuMOL5JQMyV5ot1ANLpfQGrSmHq+pzscEiEiA
   SUgq6nnuOvWoqts2iOv1ge5iazp/Lg7oLTAiiCQBO9shIjc8fQ8j0JBvq
   WZAtc43ZcX1T/NbkPlyUQ2r1XYpx4iIfR0GEHN8PlJzK8scY2Twebvxvr
   MMxmEtcN/NkrbAKMDgbj1G/JoC+alZCGgXSeY7fY94qcYNRZlKg1DFdgd
   d9M7VLxxvUdiI71MUWxvVhpgGcvhwLgGd3jFR3o65XNSnwmvYiHRcZKTX
   6gn2ikSLrn5klCT4H0Io8/rig5nfLMBZwx2gq0xJR2B452/NKP1LJdPlT
   Q==;
X-CSE-ConnectionGUID: t0ShdggaQ2q69te9p7Mufg==
X-CSE-MsgGUID: 1u3IO6ZHTDaaVQMsmlf/Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="85290281"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="85290281"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:23:31 -0700
X-CSE-ConnectionGUID: T0k5dDuKTp6Gt6SVFGKEog==
X-CSE-MsgGUID: eUacngtfTZetlmPxF9skJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182018745"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:23:24 -0700
Message-ID: <bf6ee535-cd5c-41ed-b0a0-f2dc10c1382d@linux.intel.com>
Date: Wed, 15 Oct 2025 13:19:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] x86/mm: Use 'ptdesc' when freeing PMD pages
To: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014130437.1090448-4-baolu.lu@linux.intel.com>
 <b6fdba02-cc3e-4d06-b013-fba94209e7a1@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b6fdba02-cc3e-4d06-b013-fba94209e7a1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 07:19, Dave Hansen wrote:
> On 10/14/25 06:04, Lu Baolu wrote:
>> -#if defined(CONFIG_SPLIT_PMD_PTLOCKS)
>> -
>> +#if defined(CONFIG_SPLIT_PMD_PTLOCKS) || defined(CONFIG_X86_64)
> 
> What's with the #ifdef munging? It's not mentioned in the changelog.
> 
> I went looking at this because pmd_free_pte_page() is right in the
> middle of the action on this reported use after free:
> 
>> https://lore.kernel.org/all/68eeb99e.050a0220.91a22.0220.GAE@google.com/
> 
> so something fishy is going on. It would be great to narrow that report
> down to a _specific_ patch in the series.

Yes. I am trying to reproduce the issue on my local machine and then
narrow down the reported issue.

Thanks,
baolu
