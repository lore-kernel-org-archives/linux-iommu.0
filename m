Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA0A4D2ED2
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585554; cv=none; b=jbAEoUFTdgSILcWngNiQBNQp1+a9IBct9af1I9+ZOMRmTC1omqkdR8KrxAH+mMGZVcQYIPLdAYDA/c7N2LLbJ/iZqQuQaXhCfsaEzg5XkSulg001fpVFrLUZVVqPyX00QO7QvyPeddmLQwRuT3EJ01SANKb7DgdtSBOyq680tqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585554; c=relaxed/simple;
	bh=0g+LZ2kMg+kPXVAn2V9YPYRNhs9vfvuABqAmQrCxlNs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ARtnnBmLS13dbdS5z0tK4aWvZzu+lmbKCwzhf+3f8BPKsnmutQ7992gvDpfWPDj4nrKBaBsXnZWkislm7mYt3StAAMWE0+EY/p3Iehx0yFnODYjcg1bKes3OSjBEO0pCVp8LF8lgUkesICiIgE2Gfnq2/AggOq+kn3z/7nU5bHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XA4nJupf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XA4nJupf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778585553; x=1810121553;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0g+LZ2kMg+kPXVAn2V9YPYRNhs9vfvuABqAmQrCxlNs=;
  b=XA4nJupf/2sbjCadIyBDCjbQB5ldtlFd0oj5eVpe86uRtB8W9PrXtIhS
   6tMfRG0hItgHqtU23E+4YFs/8AgD1FTYV9OHA2VgRJN0r3r72z2rFsDJH
   GogWKiUW+f/39GhGmIyT46InV0ZapiKMMVt9AZo+k5yH39J+02a66gZpd
   +TMBD1Nv+X1PuvzWCxXvPYVgzr2dTU7QTsDw0Vu8ir8urqXcS/wWs+Hnf
   pQXBSyppaAxhsrKrESf6Xnvq331yNFSXQoPel2Dc/X5C3SjaloaJD9S/t
   vvQ1FcExmiAMh8HUpePrH2I23wgui+7bu3tsUX5Hwi5ui/OlFIO9Sq6fh
   Q==;
X-CSE-ConnectionGUID: 7gXplsS2QAuxMwXes3g7ug==
X-CSE-MsgGUID: FFR5im4rRna+YXOkYdfzWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79440292"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79440292"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:32:33 -0700
X-CSE-ConnectionGUID: QxbpYteZSwe/mxUyHTcZ0A==
X-CSE-MsgGUID: +FmBxDedTeCTMbaEO1ogcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="261494861"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:32:26 -0700
Message-ID: <416088c2-b1b9-4011-bd72-4368647cb2a1@linux.intel.com>
Date: Tue, 12 May 2026 19:32:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 11/16] iommu/vt-d: preserve PASID table of preserved
 device
To: Samiullah Khawaja <skhawaja@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-12-skhawaja@google.com>
 <666d749e-c1fd-44e1-bfe8-681ba04862e0@linux.intel.com>
 <agIGEyL12Djj2clV@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <agIGEyL12Djj2clV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/2026 2:45 AM, Samiullah Khawaja wrote:
> On Fri, May 08, 2026 at 02:05:58PM +0800, Baolu Lu wrote:
>> On 4/28/26 01:56, Samiullah Khawaja wrote:
>>> In scalable mode the PASID table is used to fetch the io page tables.
>>> Preserve and restore the PASID table of the preserved devices.
>>>
>>> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>> ---
>>>  drivers/iommu/intel/iommu.c      |   5 +-
>>>  drivers/iommu/intel/iommu.h      |  12 +++
>>>  drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
>>>  drivers/iommu/intel/pasid.c      |   7 +-
>>>  drivers/iommu/intel/pasid.h      |   9 ++
>>>  include/linux/kho/abi/iommu.h    |  13 +++
>>>  6 files changed, 184 insertions(+), 3 deletions(-)
>>>
> 
> [snip]
>>> +
>>> +void pasid_cleanup_preserved_table(struct device *dev)
>>> +{
>>> +    struct pasid_table *pasid_table;
>>> +    struct pasid_dir_entry *dir;
>>> +    struct pasid_entry *table;
>>> +    size_t dir_size;
>>> +
>>> +    pasid_table = intel_pasid_get_table(dev);
>>> +    if (!pasid_table)
>>> +        return;
>>> +
>>> +    dir = pasid_table->table;
>>> +    table = get_pasid_table_from_pde(&dir[0]);
>>> +    if (!table)
>>> +        return;
>>> +
>>> +    /* Clear everything except the first entry in table. */
>>> +    memset(&table[1], 0, SZ_4K - sizeof(*table));
>>> +
>>> +    /* Use the folio order to calculate the size of Pasid Directory */
>>> +    dir_size = (1 << (folio_order(virt_to_folio(dir)) + PAGE_SHIFT));
>>> +
>>> +    /* Clear everything except the first entry in directory */
>>> +    memset(&dir[1], 0, dir_size - sizeof(struct pasid_dir_entry));
>>> +
>>> +    clflush_cache_range(&table[0], SZ_4K);
>>> +    clflush_cache_range(&dir[0], dir_size);
>>> +}
>>
>> The PASID table is currently active and in use by the hardware. Clearing
>> the entries without the necessary hardware cache invalidation is buggy.
>>
>> It seems this manual clearing is a workaround because PASID domain
>> preservation isn't supported yet. If so, rather than clearing the table
>> blindly, the code should verify if any PASIDs (other than
>> IOMMU_NO_PASID) are actually in use. If there are, the preserve callback
>> should return an error.
> 
> Thanks for looking into this, I agree and will remove the clearing logic
> here.
> 
> Yes, we do this check in iommufd, as it is the dma owner of the device,
> and only DMA owned devices are allowed to be preserved.
> 
> During preservation iommufd returns an error if the device has PASID
> (non NO_PASID) attachments. And once the device is preserved, any PASID
> attachments are not allowed until the device is unpreserved.
> 
> I think I will make this check robust by moving it into core and use
> pasid_array. It will require some plumbing as pasid_array exists in
> iommu.c file.

Yeah, that would be better.

Thanks,
baolu
