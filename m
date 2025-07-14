Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325914A8E
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752469634; cv=none; b=TFzf22GsmrynaqBGN/fv8PDJ81KnGP+iT/I9bgNNcV/13HimNL5oN49R0ojMh69ANGGxmWbLQKP3GR7O9ZI/43HDJJnwWXozRDqbSd4T5uzHp+CDN2T2LFJc7ECIy5ihKrgzZItwpAPKaRhusVymmR+7CrUK4WNyy+GNp5UZDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752469634; c=relaxed/simple;
	bh=zrPwbvAAV2RGPxHIizlCLES9eSy9VGVEnIuvyr487fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2EYk/LLAS5GRPrBYoklOMZFqSEsera3J1Uz7MzWeWqvTM7cCJT139zlspXtnsP74KSEa91e1xSEBrbECf4TlF5HZiL2EGle6XM5dwdTu9IVGWR9v8gfdlL0UDfCZSJ1wZb+8vlRoLjMBe6RocFCl9AFhlkU1bChnGWfIgjDnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/v8aknk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/v8aknk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752469634; x=1784005634;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zrPwbvAAV2RGPxHIizlCLES9eSy9VGVEnIuvyr487fI=;
  b=k/v8aknkaUhuuxBGSIU/odpxhvPDsyoHJTfPomY7rjApuu1Q9O+DYMOM
   +KwjkarDaGDCdeSq8GaNS7g8Mt/QhC67zH6NfCFae7bpGcCDIfNtLiml+
   tqr5uo0BpqDKeQjgD7w3UgZPI3zDIaulRW54NnmhfXkbcJszUeosOSJpb
   a9YXPf0UjNJC8vEqwLQNWvbzPgRdKN4SiYqSNEUMhCfpVlsKBKlqfclJN
   KUfhWespQxsBG+v0nQn5yWMKL6t1f+6Yn6/eNQNSbjBgDdnW1I4Ci8fB4
   lJNbPJDSTDSMyRydailg622wslQlCeh0nHQ7IPx6IkHns5srcUhvxC6+a
   g==;
X-CSE-ConnectionGUID: 5V9wt7r1Q0q40UdNEQgbDw==
X-CSE-MsgGUID: yjHpPRudRViWf6ZGT8Vt9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54809011"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="54809011"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 22:07:13 -0700
X-CSE-ConnectionGUID: MFTXKKm7T7Cu/Xc2W1MIbw==
X-CSE-MsgGUID: 1g/7I4VzSpu/QyjZ6x1zlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="157326825"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 22:07:12 -0700
Message-ID: <032b5b3d-74c7-490f-bbe2-4da4d8966f0b@linux.intel.com>
Date: Mon, 14 Jul 2025 13:05:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix missing PASID in dev TLB flush with
 cache_tag_flush_all
To: Ethan MILON <ethan.milon@eviden.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: David Woodhouse <dwmw2@infradead.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20250708214821.30967-1-ethan.milon@eviden.com>
 <015a0eba-d26d-4565-9cbb-d4c9e700501e@linux.intel.com>
 <2125ee10-7b23-4890-a80c-d561ba06f23d@eviden.com>
 <394f73e6-227e-4874-8b1f-9d4f2a5984a4@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <394f73e6-227e-4874-8b1f-9d4f2a5984a4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/12/25 12:09, Baolu Lu wrote:
> On 7/11/2025 4:21 PM, Ethan MILON wrote:
>> Hi Baolu,
>>
>> Thanks for the review.
>>
>> On 7/10/25 10:59, Baolu Lu wrote:
>>> Caution: External email. Do not open attachments or click links, 
>>> unless this email comes from a known sender and you know the content 
>>> is safe.
>>>
>>>
>>> On 7/9/2025 5:48 AM, Ethan MILON wrote:
>>>> The function cache_tag_flush_all() was originally implemented with
>>>> incorrect device TLB invalidation logic that does not handle PASID, in
>>>> commit c4d27ffaa8eb ("iommu/vt-d: Add cache tag invalidation helpers")
>>>>
>>>> This causes regressions where full address space TLB invalidations 
>>>> occur
>>>> with a PASID attached, such as during transparent hugepage unmapping in
>>>> SVA configurations or when calling iommu_flush_iotlb_all(). In these
>>>> cases, the device receives a TLB invalidation that lacks PASID.
>>>>
>>>> This incorrect logic was later extracted into
>>>> cache_tag_flush_devtlb_all(), in commit 3297d047cd7f ("iommu/vt-d:
>>>> Refactor IOTLB and Dev-IOTLB flush for batching")
>>>>
>>>> The fix replaces the call to cache_tag_flush_devtlb_all() with
>>>> cache_tag_flush_devtlb_psi(), which properly handles PASID.
>>>>
>>>> Fixes: 4f609dbff51b ("iommu/vt-d: Use cache helpers in 
>>>> arch_invalidate_secondary_tlbs")
>>>> Fixes: 4e589a53685c ("iommu/vt-d: Use cache_tag_flush_all() in 
>>>> flush_iotlb_all")
>>>>
>>> Remove above blank line.
>> Noted.
>>
>>>> Signed-off-by: Ethan Milon<ethan.milon@eviden.com>
>>> checkpatch.pl complains:
>>>
>>> WARNING: From:/Signed-off-by: email name mismatch: 'From: Ethan MILON
>>> <ethan.milon@eviden.com>' != 'Signed-off-by: Ethan Milon
>>> <ethan.milon@eviden.com>'
>> Understood. Our email server seems to overwrite our last names. I’ll
>> look into correcting that.
>>
>>>> ---
>>>>    drivers/iommu/intel/cache.c | 18 +-----------------
>>>>    1 file changed, 1 insertion(+), 17 deletions(-)
>>> Other looks good to me.
>> Should I send a v2 with the fixes?
> 
> No. I can change it manually if you have no objection.

Queued these two patches for linux-next with above nits addressed. Thank
you!

--
baolu
