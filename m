Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0462F747D
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766470207; cv=none; b=UARUnw47J8deyYoE03ROy0XGdn6LxF4QSvW4kp10mq/U9AL5axYUhAaj08VtEYZvKN2qFbB2TYfD27Zpml0aUfjjKwzfHDE9J/O/Njvsbryj7AYg65tu+pAEQxwbPuvI05AcriDPMUnemB/yKUX42B1oN+fT1xzwYYPAW2Oqzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766470207; c=relaxed/simple;
	bh=DqR+KdVb0t7eRqlh+OYruOHh2BtW/jxc95nRExD4+vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkx0lTqJffg7IZW24bTwu/8Av4P6Qk2XQmYueDFABNJUte2mzB1kcrOeR34xu03ia0FhmX5JiJNSQcjc6Vuo4/PkGdgXwH0zkhbSKMqpIQ5Xt8Vxjok6GVpICLKxBR5IgE3hCQGdBqLIwANchj6wC8BoB1FTna7ksL51H6nti/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEDi8Fic; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEDi8Fic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766470205; x=1798006205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DqR+KdVb0t7eRqlh+OYruOHh2BtW/jxc95nRExD4+vw=;
  b=fEDi8FicYdrLzCLk628H/OXE7ptvvCTi1Ht7JgMmA/Ddtw01dO6jJ8nE
   KGQnV6cVIhttCUKZP0YKYH+xtX8wi6FXfBpU+KymEIl7FTDMUDTEi0CLE
   sgom1OR0mWAmkOOfadk04yfkVGFWbKasJIkWOhjOiuTJ3e014CWZHbBiT
   sFzJHF83kGwKRbLKiMoyfznLhE8UuNz5aeAWzaeOqy/kh1DHDdhQaN/rx
   acs7hN9DBOPI+0jsxAXJEwwI23qL+6uUy2VBPI8DfrOh22DJ3mZRxVM5Y
   /HrlsGBMLTjoFoEh/OTatkDRu+PBntcfEWPmCRjIaQvVmkMLGiroisqlG
   w==;
X-CSE-ConnectionGUID: NY0ms3+ZSqubL5tl606ySQ==
X-CSE-MsgGUID: IYrqAHBtTpGxQUh5GEPWDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="67316024"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="67316024"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 22:10:04 -0800
X-CSE-ConnectionGUID: v91pPK8PQnCCk76wwgSGlw==
X-CSE-MsgGUID: uTg91cIzSFuiIo1xaBVH9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="204757248"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 22:10:02 -0800
Message-ID: <e63edcfe-0ee9-4582-b29e-5beb549904ce@linux.intel.com>
Date: Tue, 23 Dec 2025 14:10:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/vt-d: Ensure memory ordering in context entry
 updates
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>,
 Grzegorz Jaszczyk <jaszczyk@chromium.org>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20251221014302.17738-1-dmaluka@chromium.org>
 <20251221014302.17738-2-dmaluka@chromium.org>
 <e51dbe16-49a1-4925-8b2b-56beb66de520@linux.intel.com>
 <aUfyBmPQfosuCDab@mitya-t14-2025>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aUfyBmPQfosuCDab@mitya-t14-2025>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 21:11, Dmytro Maluka wrote:
> On Sun, Dec 21, 2025 at 05:04:27PM +0800, Baolu Lu wrote:
>> On 12/21/25 09:43, Dmytro Maluka wrote:
>>> +static inline void context_set_bits(u64 *ptr, u64 mask, u64 bits)
>>> +{
>>> +	u64 old;
>>> +
>>> +	old = READ_ONCE(*ptr);
>>> +	WRITE_ONCE(*ptr, (old & ~mask) | bits);
>>> +}
>>
>> Add a line to ensures that the input "bits" cannot overflow the assigned
>> "mask".
>>
>> static inline void context_set_bits(u64 *ptr, u64 mask, u64 bits)
>> {
>> 	u64 val;
>>
>> 	val = READ_ONCE(*ptr);
>> 	val &= ~mask;
>> 	val |= (bits & mask);
>> 	WRITE_ONCE(*ptr, val);
>> }
> 
> Makes sense. And then worth doing the same in pasid_set_bits() as well?
> 
> Actually we can use the same helper for both context and pasid entries
> (rename it e.g. to entry_set_bits()).

Yeah, that sounds better.

> 
>>>    static inline void context_set_present(struct context_entry *context)
>>>    {
>>> -	context->lo |= 1;
>>> +	context_set_bits(&context->lo, 1 << 0, 1);
>>>    }
>>
>> How about adding a smp_wmb() before setting the present bit? Maybe it's
>> unnecessary for x86 architecture, but at least it's harmless and more
>> readable. Or not?
>>
>> static inline void context_set_present(struct context_entry *context)
>> {
>> 	smp_wmb();
>> 	context_set_bits(&context->lo, 1ULL << 0, 1ULL);
>> }
> 
> Maybe... And if so, then in pasid_set_present() as well?
> 
> Actually this would make a slight behavioral difference even on x86:
> right now this patch only provides ordering of context entry updates
> between each other, while smp_wmb() would add a full compiler barrier
> here.
> 
> So this barrier may be redundant as long as we always use these
> context_*() helpers (and thus always use WRITE_ONCE) for any updates of
> context entries. On the other hand, it might make it more robust if we
> still occasionally do that without WRITE_ONCE, for example in
> context_entry_set_pasid_table() which I also changed to use WRITE_ONCE
> in this patch.

Fair point. It is somewhat redundant. However, I would suggest adding a
comment there. For example:

static inline void context_set_present(struct context_entry *context)
{
  	/*
	 * smp_wmb() is unnecessary here because x86 hardware naturally
	 * keeps writes in order and all context entry modifications
	 * use WRITE_ONCE().
	 */
  	context_set_bits(&context->lo, 1ULL << 0, 1ULL);
}

So that people are still aware of this when porting this driver to
platforms with a weak memory model.

Thanks,
baolu
