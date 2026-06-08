Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA3380FD9;
	Mon,  8 Jun 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925886; cv=none; b=BpCV2s7d767yMzK+WvIjglnia+2vFS24aeM9tWX71d5osKL/l2bsf6EAfF577wRKw3gUBSu2I9CLnWCGba/fplyY9fsDoGESSzAWr1Fs0Znj8N7X/Gx85bUxR2Hk+szF70EqX18LXuMZi1GKGRoR2NEWOHgg2wV8QstBAzdGNUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925886; c=relaxed/simple;
	bh=b+yEP0xv4aXK3S1JzA9JnwqBMA2Dej+EdhfRuZ2GJrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2YHT2XvCoAbJXwIFQvmqAqTuCkyG89J/Hl4KDHB6F3iCjGo11g97Yi9MXbrp8FTbUtemQO88JkElC3Anr4A8xcYWlujq2n/akmOJbv3tHj4MpCY0nIsQXNWlLe6PleSi88WdtFEsI/Yfr8kLZ72HUMn4CmjP4ZcYV0930lLpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdsaNTFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdsaNTFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC331F00893;
	Mon,  8 Jun 2026 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780925885;
	bh=3DmSeVsacdhuO8IPMvgQqcrU2HaMy5DBmzNlEy6t8Sc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LdsaNTFqk669HcLwNMx7JOOX4hWjrgZkdHTXjB2Ko/yB6NiJ84DDHQVDBEtGCh9aw
	 r64054qsJC8nTwPq92DXSOq2JaFL82AgMWM2JKjFNXLF7GmMdagOvVpKkaHZkkF0Sc
	 ExYymswqWwGUOkqPW15y88enuDr+zbmnGJBEGrtn3JmDlWciDbyOvfQwcB9I3Rjtrl
	 6Qnva4MFkmBkzyVdb+0nOG5DtMDkuijAPhIGhog5+v/GLUgdoMWttyu1XIhbDfylFm
	 zEfP9wYD+cwAkFMdaeH9mDluGhviXSXoJmgY2noGNcbbFo84bUI9tioh3Ud4ssvuMq
	 1AS4FEKeyZXCQ==
Message-ID: <38b49fb2-c2c0-4c7f-ac5c-3e79d54728f0@kernel.org>
Date: Mon, 8 Jun 2026 15:38:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iommufd: Require write access for writable MAP_FILE
 mappings
To: Jason Gunthorpe <jgg@nvidia.com>, Yiming Qian <yimingqian591@gmail.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, keenanat2000@gmail.com,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>
References: <20260607085320.73274-1-yimingqian591@gmail.com>
 <20260607120935.GG1962447@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260607120935.GG1962447@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/26 14:09, Jason Gunthorpe wrote:
> On Sun, Jun 07, 2026 at 08:53:18AM +0000, Yiming Qian wrote:
>> IOMMU_IOAS_MAP_FILE pins folios from a shmem/tmpfs or hugetlb file and
>> uses them as the backing storage for an IOAS mapping.  When userspace sets
>> IOMMU_IOAS_MAP_WRITEABLE, the resulting IOMMU PTEs allow DMA writes to the
>> file-backed folios.
> 
> This looks like an issue with the API design in memfd_pin_folios(),
> all users would have a similar bug I think.

Agreed.

Not sure if it should be part of memfd_pin_folios() itself.

> 
> I don't know much about memfd but this seems like a legitimate issue.
> 
> Add those involved with gup.c and the patch adding memfd_pin_folios()
> 
>>  {
>>  	struct iopt_pages *pages;
>> +	int rc;
>> +
>> +	if (writable) {
>> +		if (!(file->f_mode & FMODE_WRITE))
>> +			return ERR_PTR(-EPERM);
>> +
>> +		rc = mapping_map_writable(file->f_mapping);
>> +		if (rc)
>> +			return ERR_PTR(rc);
>> +	}
> 
> We probably need some kind of companion API for memfd_pin_folios(), a
> start/pin/destroy kind of thing to manage this?
> 
> It should not be open coded like this.

The permission check is one thing that's clearly missing.

Not sure about the mapping_map_writable() handling ... it's weird to rely on
that when we are not actually mmaping.

Assume we GUP a page and then munmap, mapping_unmap_writable() would be called
while we still have a writable GUP reference. Hm.

-- 
Cheers,

David
