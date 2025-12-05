Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC778F2E
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 05:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764911005; cv=none; b=S2jUAza4/YBKlZVs8BQkMjB8+U8X0HeRuzPj9swOC2qB/56Dyy5ddZzraVH18C2Nna2r77I082Vx+6SOkzNdJJudcJcZZ9QWVaWFUl276ZwGPfq9bYMRK1EUeyZzoQQO8yjpiTo7gEiZiFXIRovA0LleYMO0uklz6KaVXijaM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764911005; c=relaxed/simple;
	bh=P9ACxseVxndCzyFcedtf2xxFk9JrvXhWjiFJS4EbzVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJB6tg0V6Y7yQd8jtd91HryF+fTlr3GWzR0ZFGOR3niRxfMvxHFNaLb+qfB+AwjWIHgsPW4aouZ3xv+HDx0WHYi0qdwVP4A20xeNNF6oRHHaded2D8f1t1PcFGB934StF0JAE+v+CeMaQ1h9XaWVHCwims+yhR9puIJqTo6W9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMVCmp3S; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMVCmp3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764911003; x=1796447003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P9ACxseVxndCzyFcedtf2xxFk9JrvXhWjiFJS4EbzVI=;
  b=SMVCmp3SKdii/QZl53ToNRQjQi+fmfR7NpTTEBtkxL5Oza/WwyU+rq6E
   j/Kq+QwvpYvIcPC10ynov798yFt0kmri1KqQ/qPfs2IXu4ZvzATVG3rm9
   T9LHQJEEd9sb0H6u96iKu1AO27QMgVxKMqu9yAnrp/1VCtI1hoKy4dbWW
   sb2Gnr6pAl6Zd/2Zcq5n03IBinorrQF7nbWq5j0eM2RdxbcfseJI7aH2n
   Y2G0Dr9D6SHc8U8UQIIpHKZL8HIZwNpF/iAhMR15pdshRECcCYLqCcGay
   Omfvmx0j3yjpam0zx4RiDFSaeykjaC5ewd0cAijopDkiufpuuVjBV4mMp
   Q==;
X-CSE-ConnectionGUID: SwZrPZrIRjyFz6Qa/Bh/3w==
X-CSE-MsgGUID: iJjmXH0uQD6HJN33CoKpZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="77629290"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="77629290"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 21:03:23 -0800
X-CSE-ConnectionGUID: o+8WIpPMTOulJj5+btZRbA==
X-CSE-MsgGUID: do2uYsH2RkGed507ZswgSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="195230298"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 21:03:18 -0800
Message-ID: <c2525d56-59fe-4dd7-aeea-7e5fb230bdf0@linux.intel.com>
Date: Fri, 5 Dec 2025 12:58:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/32] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 William Tu <witu@nvidia.com>, Vipin Sharma <vipinsh@google.com>,
 dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>,
 Chris Li <chrisl@kernel.org>, praan@google.com
References: <20251202230303.1017519-1-skhawaja@google.com>
 <20251202230303.1017519-12-skhawaja@google.com>
 <fc6632e7-f0eb-437c-b687-c31c019f3d1f@linux.intel.com>
 <CAAywjhSTn6hnzVDSpPGTD2=F2vweRc17e1Fd0vJVL-awpd_dcA@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAAywjhSTn6hnzVDSpPGTD2=F2vweRc17e1Fd0vJVL-awpd_dcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/5/25 01:39, Samiullah Khawaja wrote:
> On Wed, Dec 3, 2025 at 6:30 PM Baolu Lu<baolu.lu@linux.intel.com> wrote:
>> On 12/3/25 07:02, Samiullah Khawaja wrote:
>>> +int iommu_preserve_pages(struct iommu_pages_list *list)
>>> +{
>>> +     struct ioptdesc *iopt;
>>> +     int count = 0;
>>> +     int ret;
>>> +
>>> +     list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>>> +             ret = kho_preserve_folio(ioptdesc_folio(iopt));
>>> +             if (ret) {
>>> +                     iommu_unpreserve_pages(list, count);
>>> +                     return ret;
>>> +             }
>>> +
>>> +             ++count;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(iommu_preserve_pages);
>> What is the purpose of "count"?
> Thanks for reviewing.
> 
> The count is there to unpreserve only the preserved pages if an error
> occurs during preservation. For example if 4 pages (from the start of
> the list) were preserved out of 10 pages in the list, the unpreserve
> function will unpreserve the first 4 pages from the start of the list.
> Please take a look at the implementation of iommu_unpreserve_pages for
> details.

Oh, I see now. Thanks!
