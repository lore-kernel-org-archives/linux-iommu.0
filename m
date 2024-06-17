Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987FA198A20
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631806; cv=none; b=L/lUJyME/p+UgdzdEyAeNJRsDL0/ktYqjqu8iTzhRJQD+bS6LYwnpQJrTC36UtpV+JpCbbtCAIZjGcv0Q5oO5QBakQ9lQXfIfxx4448IKHBckIljfr+mk1OO9JG9vCzCRPFgm7T3VqVOt3fdS4sf2ASh2k6ROgItyuzQx4q7DjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631806; c=relaxed/simple;
	bh=+t3kd09U1NqkuZGtXUBMPUvqySruMCGg9kRmu1o7du4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0+HHNuZFtjFrpFobw4xNBxJRmLLLUDA+7oNqdNFAEOmGvzRMRTZ0YfrKzjMnV/eDXiXBkqhIDKIBNXFCR3J87NGf37oRcc5Cx8L5/VB/0B4395QYMwmGFyc30JIhq6jWIjMGj0nw96K1vAwAB1bmz/FkcvGjBR67WLI2hHmV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TMYsaj0r; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TMYsaj0r"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c8353d8d0so5755772a12.1
        for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718631802; x=1719236602; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=APk91TXp5Ugv3ZDi4Fkr4LxFk9bAvdubbKJ1lckRAt4=;
        b=TMYsaj0rLissZ+XGMqBfzj6HtaFXd8osI7yolG2CZ8nRtUHso7utFAcnROwrWsBqPd
         BF+xwktxiiXDZFFximVXA2PFZWuBT+j119FTaBHh9pW763e7ED9egoE4DdaNpLYGS/sq
         YZh2wwVfKMXlrVQYn67FaGeTIaCLDHSSmcLRmGy9tL+8JFZoN56WqB82AWdhIIdyvtdV
         75VR0vOgLPXULSnZYQAjnoVaKpYfdUS4RTZPUgyRgMQ+opg/U//u8SsEmStSCxMiqix8
         cfXbL2Rhmd2q7n3DnQTIOGJlelhUOB4ekYyYmbKfUaV5YFi5VbCUu0UGvFsLa4FlEYRK
         Ubvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631802; x=1719236602;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APk91TXp5Ugv3ZDi4Fkr4LxFk9bAvdubbKJ1lckRAt4=;
        b=G2GeB1whhDFBaipx1bqtBHoTml6zq/ICeCR27OY9GRdWVZvcGg9X/PNZCcNflL0NoY
         mifVZkSyFZp7B7a54MlCZ54hbmtQTYCQmhb3bsEzkzu0zmoouqLAMVnQdsHbEcxXj3Of
         wYBlJiGkrmBFry0hs0S38dSr46nZLJatl9txJeCU+9cbaF0+cWQeslBocStJGd4Y96JE
         XJmsmgBAin6YVrhw/3flFK/2bLvMz3VGuiygq0B2COrOD+EAiy6xajhBqDtHuSpQfo3K
         l8FMFAQDA8TnQEf54iyotwbHwIdiMuzSMDx3yxJq+JGQqh6mufsTopB5rM1l44S+kq9L
         qoeg==
X-Forwarded-Encrypted: i=1; AJvYcCX+gB29TxSZGB3ecL9DHOORc4fFA0va/PZUJhzZqiZo4OdWstRczkyjSo8KUvbaUMIK1k1krTpZXOz15Z4XLNxIF4TAYUk=
X-Gm-Message-State: AOJu0Yxwkt1BN7lVXCpbpVbrkYNGlz5iquhItrW9p05K7WaUP2lGn7ZK
	FbKVtxRZ2LSb4GypT9Ps4JqHxuC44ec8p8iZDn3TKt0YwQiI4ekN2XcQ1fV9zw==
X-Google-Smtp-Source: AGHT+IGDT6FgU1fHBZu/3F+toBLz1JtLYQGomy3PSpECSQUUTJMxPHs+ZBmMyNrLpOhhhJMUu54eAA==
X-Received: by 2002:a50:9997:0:b0:57a:3273:e648 with SMTP id 4fb4d7f45d1cf-57cbd6767admr5570285a12.18.1718631801918;
        Mon, 17 Jun 2024 06:43:21 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e6c8sm6463910a12.77.2024.06.17.06.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 06:43:21 -0700 (PDT)
Message-ID: <af39bac8-bb0d-415b-8cb3-79f3d5369d9d@suse.com>
Date: Mon, 17 Jun 2024 15:43:20 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu/xen: Add Xen PV-IOMMU driver
To: Teddy Astie <teddy.astie@vates.tech>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
 iommu@lists.linux.dev
References: <fe36b8d36ed3bc01c78901bdf7b87a71cb1adaad.1718286176.git.teddy.astie@vates.tech>
 <8b0151a8-2293-409a-8469-d9e73cf561a3@suse.com>
 <eceaa7e7-d07f-4a41-b39a-0b32be6724ae@vates.tech>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <eceaa7e7-d07f-4a41-b39a-0b32be6724ae@vates.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17.06.2024 15:36, Teddy Astie wrote:
> Le 13/06/2024 à 16:32, Jan Beulich a écrit :
>> On 13.06.2024 15:50, Teddy Astie wrote:
>>> @@ -214,6 +215,38 @@ struct xen_add_to_physmap_range {
>>>   };
>>>   DEFINE_GUEST_HANDLE_STRUCT(xen_add_to_physmap_range);
>>>   
>>> +/*
>>> + * With some legacy devices, certain guest-physical addresses cannot safely
>>> + * be used for other purposes, e.g. to map guest RAM.  This hypercall
>>> + * enumerates those regions so the toolstack can avoid using them.
>>> + */
>>> +#define XENMEM_reserved_device_memory_map   27
>>> +struct xen_reserved_device_memory {
>>> +    xen_pfn_t start_pfn;
>>> +    xen_ulong_t nr_pages;
>>> +};
>>> +DEFINE_GUEST_HANDLE_STRUCT(xen_reserved_device_memory);
>>> +
>>> +struct xen_reserved_device_memory_map {
>>> +#define XENMEM_RDM_ALL 1 /* Request all regions (ignore dev union). */
>>> +    /* IN */
>>> +    uint32_t flags;
>>> +    /*
>>> +     * IN/OUT
>>> +     *
>>> +     * Gets set to the required number of entries when too low,
>>> +     * signaled by error code -ERANGE.
>>> +     */
>>> +    unsigned int nr_entries;
>>> +    /* OUT */
>>> +    GUEST_HANDLE(xen_reserved_device_memory) buffer;
>>> +    /* IN */
>>> +    union {
>>> +        struct physdev_pci_device pci;
>>> +    } dev;
>>> +};
>>> +DEFINE_GUEST_HANDLE_STRUCT(xen_reserved_device_memory_map);
>>
>> This is a tools-only (i.e. unstable) sub-function in Xen; even the comment
>> at the top says "toolstack". It is therefore not suitable for use in a
>> kernel.
>>
> IMO this comment actually describes how the toolstack uses the 
> hypercall, but I don't think it is actually reserved for toolstack use.

Well, the canonical version of the header is quite explicit about this,
by having the definition in a __XEN__ || __XEN_TOOLS__ section.

> Or maybe we should allow the kernel to use this hypercall as well.

That's an option to consider.

Jan
