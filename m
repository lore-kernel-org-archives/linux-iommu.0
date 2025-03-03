Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958E202C2A
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002145; cv=none; b=OgXQdFnoEZd2VH1KLqQnP7Cf2noj9goxnesyzJR5zhJLRsEiwP2BCJ584ZahSGpejVXKSnEYzdrKPwJAZrgmGbr8cQgR8o2BeoKHH1fzFE43qYoB7aQfCX5XOQxgRzNttTUA0YcXzED5jyhU6KQSpNShgviUgBcTuiI55SKm91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002145; c=relaxed/simple;
	bh=oyoGpoAogNlFLsEfP7tF62uwgGj7bpQ4UrXetHF74oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJC25dbNpGxAANiETrXfF/s+o4eOckEJUTOenUmxnw6veaUDTSvkOUWVBE13PVIqp8hrXQv4GqS/CvbXFPwTVFraAOUsacfCuwBPdiH9CCyU9jgTtOzTAprZ0l2GLK+3QQph3+sBkisvwIEawi3hUBsbqHSpr/TL4yedwK2tQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akC5UaNe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akC5UaNe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741002142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GK+r8CB/zopdHXRJVOxigdSQmwtLGrthh+WgPUejIE4=;
	b=akC5UaNe5NQOWWzUjkwHR05Jx0f8UfCv8O5kzpOtqltjhv3/eJdsMJA7r8cnFIKmDXP+ow
	U3IPoSOe2oIiUPRT3hb2E+9+yptcyU+cKDfQcxEXYcq4IKKjtC/Z8Xcn5KLWS/0paEvgH8
	pPHp+DPIdv1pSFXjZ0P6DnrsjZJroLM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-tNFEs5RYM8eVoNqgXmRI8g-1; Mon, 03 Mar 2025 06:42:19 -0500
X-MC-Unique: tNFEs5RYM8eVoNqgXmRI8g-1
X-Mimecast-MFC-AGG-ID: tNFEs5RYM8eVoNqgXmRI8g_1741002138
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so19149095e9.3
        for <iommu@lists.linux.dev>; Mon, 03 Mar 2025 03:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002138; x=1741606938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GK+r8CB/zopdHXRJVOxigdSQmwtLGrthh+WgPUejIE4=;
        b=RWl8B3q6QdF0d+4PgtzDeIfDONmVWCxpXE7EE/mcpf+LwSoUggn+zx8IfzfRsR8Rpb
         nMeVCPsksgYqHnWPmvQCGLXfdCl8oh9mNj+1WR8JqAb+kcG04CtF6e1s0T7oNNUyJJ/N
         nzQXM3zStelt5HQC3g2Z+XT/3+uPAYf0N4kep2wfXWhjmlJKWthi5MtgS3I5A8DZCWuX
         TddwRNmx6MjV7kOUwOffDbDIEUedR26oryDpWTKvTsWdySSlFW7Uhw7NS3JUnKWakUG7
         S0VcAuZqyg6zbQ+EaeFdvLPG2rjwIgrYPXf/9tDCaep37pMJnbMRLzl2MdMQ5pktuhQI
         tujg==
X-Forwarded-Encrypted: i=1; AJvYcCWnEf9PDXB5TQJVgSO+6H4xdfIrzw4dNU6k91vrpMIjivyzJuT0fraQA7M3v4wk2qLrfJq3XQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLo+YSMOiowCi/0H34EiTE/ojbZEr7X4HVypCQYL4edLIgZ3EH
	kS0hjFoEMfn/vQMfKq3xWOToOWuZJ8OQa9EpAr6xe5FzZE50Uv3nUoKKeyiEmUDllHNipTQABa9
	IT4py95PS3bA/CNXIEwyg5Q33lj5QM5k/oiJBnWivU/W5MQ913yc7
X-Gm-Gg: ASbGnctM5ZxeD9JdPp+82uisV22YWd1LvkpqcVYUCQadqQwbfStMcTB0peGzaYnsv/Z
	X57YLCCY5/6wavs13DjGt4n9YuRWqM7UKPdf+Nipu6+J4z0fDqu506zSKjwZa+zfoUv6g24CarF
	x0HfMCqhELQx226UkqhggkZdERf9nfLqptBQlIWEFFmlVwFfDt51KsCgZSUJSsYWlPaSldSerGZ
	pDXdd8ka3CkC/yaZaE6Za4A+UgwUP+N9akOmEYXXitOSWf3+mpw/07RwH6OHm/rNJOzzYe7u870
	rH8N6OiLsRIzR/T6SJcRJnkJtIMjm9XaEeihU3TEUU8F2vXN4v8eG8FMeh8i525wR/cdo2DBJKa
	ctW5RD8TQ9LPfhdLgEMEKYIq4+XGg8KSxKIfZIPRCw78=
X-Received: by 2002:a05:600c:3506:b0:439:8e46:ee73 with SMTP id 5b1f17b1804b1-43ba6704446mr119492835e9.15.1741002138251;
        Mon, 03 Mar 2025 03:42:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe6WbxcsGzXZWMC0pjNXpsivZUSmi+rYJFcr/S86qicmIKfyXyNyDXrqfgaMGgOQqTiegQEw==
X-Received: by 2002:a05:600c:3506:b0:439:8e46:ee73 with SMTP id 5b1f17b1804b1-43ba6704446mr119492405e9.15.1741002137875;
        Mon, 03 Mar 2025 03:42:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532ba6sm186494095e9.12.2025.03.03.03.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 03:42:17 -0800 (PST)
Message-ID: <0ff27dbb-401b-4793-be70-1ff9c8010e4a@redhat.com>
Date: Mon, 3 Mar 2025 12:42:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
 yang@os.amperecomputing.com, catalin.marinas@arm.com, will@kernel.org,
 joro@8bytes.org, jean-philippe@linaro.org, mark.rutland@arm.com,
 joey.gouly@arm.com, oliver.upton@linux.dev, james.morse@arm.com,
 broonie@kernel.org, maz@kernel.org, akpm@linux-foundation.org, jgg@ziepe.ca,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-5-miko.lenczewski@arm.com>
 <f270bb5d-aa54-45d3-89ed-2b757ab3a4b0@redhat.com>
 <20250303094947.GB13345@e133081.arm.com>
 <7e987f17-ffcb-45e0-8588-2d569d90f776@redhat.com>
 <20250303105539.GA74129@e133081.arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250303105539.GA74129@e133081.arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rEA-Y_DiCTTe-3AhO_5tp9-T29Cj1Mpl2TQhg1Q8FDM_1741002138
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.03.25 11:55, Mikołaj Lenczewski wrote:
> On Mon, Mar 03, 2025 at 10:57:21AM +0100, David Hildenbrand wrote:
>> On 03.03.25 10:49, Mikołaj Lenczewski wrote:
>>> Hi David,
>>>
>>> Thanks for taking the time to review.
>>>
>>> On Mon, Mar 03, 2025 at 10:17:12AM +0100, David Hildenbrand wrote:
>>>> On 28.02.25 19:24, Mikołaj Lenczewski wrote:
>>>>> If we support bbml2 without conflict aborts, we can avoid the final
>>>>> flush and have hardware manage the tlb entries for us. Avoiding flushes
>>>>> is a win.
>>>>>
>>>>> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>>>>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>     arch/arm64/mm/contpte.c | 3 ---
>>>>>     1 file changed, 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>>>>> index 145530f706a9..77ed03b30b72 100644
>>>>> --- a/arch/arm64/mm/contpte.c
>>>>> +++ b/arch/arm64/mm/contpte.c
>>>>> @@ -72,9 +72,6 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
>>>>>     		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>>>>>     	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
>>>>> -
>>>>> -	if (system_supports_bbml2_noabort())
>>>>> -		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>>>>>     }
>>>>>     void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
>>>>
>>>> What's the point of not squashing this into #2? :)
>>>>
>>>> If this split was requested during earlier review, at least seeing patch #2
>>>> on its own confused me.
>>>
>>> This split is a holdover from an earlier patchset, where it was still
>>> unknown whether the removal of the second flush was permitted with
>>> BBML2. Partly this was due to us being worried about conflict aborts
>>> after the removal, and partly this was because the "delay" is a separate
>>> optimisation that we could apply even if it turned out the final patch
>>> was not architecturally sound.
>>>
>>> Now that we do not handle conflict aborts (preferring only systems that
>>> handle BBML2 without ever raising aborts), the first issue is not a
>>> problem. The reasoning behind the second patch is also a little bit
>>> outdated, but I can see the logical split between a tlbi reorder, and
>>> the removal of the tlbi. If this is truly redundant though, I would be
>>> happy to squash the two into a single patch.
>>
>> Thanks for the information.
>>
>> Does patch #2 (reordering the tlbi) have any benefit on its own? I read
>> "other threads will not see an invalid pagetable entry", but I am not sure
>> that is correct. A concurrent HW page table walker would still find the
>> invalid PTE? It's just a matter of TLB state.
> 
> I think I understand what you mean. I agree that it is possible for a
> concurrent walk to see an invalid TLBI state, if it is on the same TLB
> that the repaint is happening on. For other TLBs, the flush has not yet
> propagated our invalidated PTEs (from `__ptep_get_and_clear()`) though?

What I am saying is: if there is no TLB entry yet, HW will walk the page 
table to find no present PTE and trigger a fault.

> That invalidation will only be seen by other TLBs after the
> `__flush_tlb_range()`, so we should save a few faults because only
> "local" threads will ever see the invalid entry, as opposed to all
> threads that try to read our modified range?

So what you say is, that deferring the flush means that if there is 
already a TLB entry, flushing deferred reduces the likelihood that a 
page table walk is triggered that could find no present PTE: 
consequently, reducing the likelihood that a page fault is triggered.

(I use the word likelihood, because I assume other action could result 
in a TLB entry getting flushed in the meantime, such as TLB entry reuse)

Correct?

Or it is the case that I
> have misunderstood something basic here, or that I have misinterpreted
> what you have written?

No, that makes it clearer, thanks.

-- 
Cheers,

David / dhildenb

