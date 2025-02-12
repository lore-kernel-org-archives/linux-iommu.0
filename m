Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3CD20A5E8
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360952; cv=none; b=uBg5goCW5NfcDxcdzkB/3XE8pzCyyWSNLprxs8kmFVLjQnnBRd3I4sFZTuBdo/ZCb0rhfdj7i/4lSnOqsbgRhS7ouOMXEddc3yMrpimQKHOAkDn1otXBqkYQhYfsHovnW95BerSIJJ3epN8Oh/mVzV3o6N/VMig1o8pMu0JwPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360952; c=relaxed/simple;
	bh=5cA9DHvlTH8FDmWvm4ojHRhcd4ghIiXt5VPf9lXr4hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ej7uMokm4qIbqJIRtYU1+Tra3RD5rkN4IyKDOZxOBTu2bRcMk7DjflVoKSSrXkHtnQOpL3gK2ty/ACBpjdN44rVMg5jmofu+acqc0Vf6grKis7VxZiYN2RU1/+8yCdpxllSN/H8nNc1xTI9hiJozTfpiABThIhNeKZOecNf06KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CJCYS1u3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CJCYS1u3"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7d583d2afso138724266b.0
        for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739360949; x=1739965749; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a4ktuYMZfFjDtI8OUf8Ecv+gnfAOw4b0BObK8n+AqV8=;
        b=CJCYS1u30/kkVjibBVcED1cx44E5qZ5nmkZlQXgCPS9rpvWhmJsSNY29Dc0FM9a4NL
         4Jeq2TXVkir8gibTwTTthLXojH1DfxoQ5GUJDg92yBqrxk5nCjUJny9yZdQBuNuHPKlH
         RJyMs36pwsiYAo5xUqwaqV2JS98q7el8eJkTB5Is+ZCBO6Kj1CZMZMqkRSOip3nXkNLQ
         ejtC8QFaTaMOOgp6B2q8pJkZgal0VTCvg7WqkOW3J3JBYnHLC57+fImb3UEusK/sUfGU
         LrZlnHjOEKagH0DUpWIW2ppsfr7m7NsW15CaFeerbKtB/YYgPb21gvsfwQrU0rZ/0/vE
         vvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739360949; x=1739965749;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4ktuYMZfFjDtI8OUf8Ecv+gnfAOw4b0BObK8n+AqV8=;
        b=N75kgPtB11vhkux0DweyZrCEPjWA+mdxMGjx5yh3f6kFDY7gTMwE/uK/p58XFq996E
         f+i8GFxHx3ZbDhy7a/ZsL1xYKNBlU343/7Gv0GXMcyfIDega1QqZOwWGbnNOB59qI6vx
         IebVdYby55x4zPjQlqJO59Gku9g1ehfhRqDZ7uPiyc6zqtxacKMWgkavN9eJ2dNymzOY
         0iQHGv6hmNzhZ+JnKR6/xovPgwNUpokHEVFVSHd/CqiQMLb26QAitOsuuORDodVR3TpI
         7OKwf2yu9dwWun/PGUVYTN1jq8tEfz+QdKd1Mp04WGlkRorad2uMMB2hakhLyRqBrdu1
         mN/A==
X-Forwarded-Encrypted: i=1; AJvYcCUAyXdMHvSU4AOtxYJDhN8LM8LYLZ7YNNE5SoU1dKE1TpkbpL0VFESptV2zWuln80le32PwtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtmHbleTpt/4YzD5ClYr9VhrEJc3szWFCYLKwPgyIYfL5R5Lbp
	ucqwTiNf94+ThOOh4Ee2oz+ZW3Fk1VCVcWtrYBX1xM4NY3cslCYtQAnSweBjHw==
X-Gm-Gg: ASbGncsry5USbZG8wENgXIsXdM1o2zaHLGvRviY2dHRQjxY5YE/irRILug+TW+pS3rU
	f15tsbgjPZpcd1sfI5M27bJB45bhKagSkepYHfdMLvd09YMPmz3bBOOWkj/iqEcfxK4wnJOdPgc
	CBwOf/9BqcCqxy4EWQ0wF88ZU0mjQtiq+ifD0T+i31oCqauumXpF03R087+qXHEUYL+SwFL1ATQ
	UN+bcJjs6y9hRWqBRXWWx6W2Zs6jmnRI5I7AH+4SX6f+ZbAABqlr3ostpKvqgRvpgRx0Lq57OH9
	xe0SEqrx25TLbhLpDQp3VIMxvLzT6bLjitts1WQ3xa5yYMnnsA4fKTVRewK0zuGlvy/eFX/Kjl3
	s
X-Google-Smtp-Source: AGHT+IHk8v1UXTDdoz1889v2GctlPWBa0NT2L4lQ+sQMLxd1NoafDj+R+R3QOKeQxuem4GhhaCwamQ==
X-Received: by 2002:a17:907:7da0:b0:ab7:b9b5:6104 with SMTP id a640c23a62f3a-ab7f2e8a612mr226475966b.5.1739360948795;
        Wed, 12 Feb 2025 03:49:08 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7f779d9aesm97924066b.63.2025.02.12.03.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 03:49:08 -0800 (PST)
Message-ID: <38eb09be-67fc-46ff-9e78-c37c30f50e4b@suse.com>
Date: Wed, 12 Feb 2025 12:49:07 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xen/swiotlb: don't destroy contiguous region in all
 cases
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, iommu@lists.linux.dev
References: <20250211120432.29493-1-jgross@suse.com>
 <20250211120432.29493-3-jgross@suse.com>
 <abe2138d-b1a7-4e53-ae5f-ea3c393d50c5@suse.com>
 <ce7320b6-68f3-43b1-8812-3a5bbd75c9c6@suse.com>
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
In-Reply-To: <ce7320b6-68f3-43b1-8812-3a5bbd75c9c6@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12.02.2025 12:11, Jürgen Groß wrote:
> On 12.02.25 08:38, Jan Beulich wrote:
>> On 11.02.2025 13:04, Juergen Gross wrote:
>>> In case xen_swiotlb_alloc_coherent() needed to create a contiguous
>>> region only for other reason than the memory not being compliant with
>>> the device's DMA mask, there is no reason why this contiguous region
>>> should be destroyed by xen_swiotlb_free_coherent() later. Destroying
>>> this region should be done only, if the memory of the region was
>>> allocated with more stringent placement requirements than the memory
>>> it did replace.
>>
>> I'm not convinced of this: Even the mere property of being contiguous
>> may already be enough to warrant freeing when possible. The hypervisor
>> may not have that many contiguous areas available. The bigger the
>> chunk, the more important to give it back once no longer needed in
>> this shape.
> 
> Really? When creating a domain Xen tries to use GB pages and 2MB pages as
> much as possible. Why would this special case here have more restrictions?

There aren't many Gb pages to be had from the space below 4Gb; frequently
there'll be at most one (covering the range from 1 to 2 Gb). For that as
well as 2Mb ones I think it is a mistake that Xen may hand them out, when
the caller could fall back to 4k allocations. Thing is that without extra
information it's hard to come up with a good heuristic to decide whether
the caller is capable of falling back. Perhaps e.g. populate_physmap()
should add MEMF_no_dma to higher order allocation requests targeting other
than the current domain, or when !d->creation_finished.

Jan
