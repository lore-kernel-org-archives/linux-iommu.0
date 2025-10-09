Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953851E0E1F
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037405; cv=none; b=AfbUH5r++JLbH+pHqjblhNW3OQ1nkck7chJCVWC2TR+RiOFdjFJAkNMcAoyGqRF6otVidPeinjyGQ7Vmk5Ces9JY9TL3fX3jaYkzX2yW5mj7uCEVCLPDCckc/DTkoLAGdVFQ5BBCJIi7ysDWpPtOv/Urtz8l2ZtOHN6syHrfbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037405; c=relaxed/simple;
	bh=O8Zv30WGnZYC9mVrYMZ4C/OoFisrJ2rjhARUBD8ZGbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJ0yE4U1GKRpJMxUzCkeROe4FczcyRGxFA8WaLaC0xQ9ZdI4jJd3v0ZCzYAHtg8L9U8Ow+3umyxxgU2tgGTlQhWta91HmGdGQRGec3KVp6P6/eqCNUJFF6DS/jC9UwrnsMlvKHfopAx6avpLR88Q/bLOYGPBdrPKDeuu/RVkmjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euR6vlxf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euR6vlxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760037402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/jjq7BLRoYI2nQdmAcFZDfdFEssHTj+qWciljr1C06A=;
	b=euR6vlxfrhdN+hZhhlZdizODLA6MMYzeMfbGhYDK40GGF4+fBrsFcs5einAhHOCJclxnrn
	eqIV7OAs+GuYGDEDaVl/TybYXUuFP997t8ptm62aj3fM9kWqXsJ1u7aYVmis2apITV4DiX
	+Ida4a2/CppmOl//adKnmK6SMbejYy4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-jRKNfouhNI6WjA4V4Yagjw-1; Thu, 09 Oct 2025 15:16:41 -0400
X-MC-Unique: jRKNfouhNI6WjA4V4Yagjw-1
X-Mimecast-MFC-AGG-ID: jRKNfouhNI6WjA4V4Yagjw_1760037400
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e407c600eso8422695e9.3
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 12:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760037400; x=1760642200;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jjq7BLRoYI2nQdmAcFZDfdFEssHTj+qWciljr1C06A=;
        b=ChPt2Y1WcV28YIS65f5jqgcdp6Z+N5JON7krnfXydH6FFWOEV/CkZeVa+ur0R9pSHo
         LyY0xRmrBpV5PqPjtT/Qnukt+9j4N7L+XuIIgMyBGt5dfBW/NjD8LpmxnWsUYSiN9xGu
         HjaihGXGwbHpMaoCZBK+iP2jhMPivPtuZkw0ykBKz9bAMKqYXZGbzfZA95WWo2Fzi/8y
         69CFMEJ0bLbt83wlXa81utzt4N35AY7DM5CnCqA9sETTNHh7IcBGLwJQYAMBgeszpmHa
         Ydhm/YfMXbhKeoG7bUSIzAXZLzTR6gOVb6HmGrSnsD/QRaOwo10x50hrBXY+vA75jbPZ
         CJMw==
X-Gm-Message-State: AOJu0YwVk0pctZDQq404zVnnBtYaPcTRTPndaMNdQfA0g5CimG+HanuE
	XeLN2kS/uaJAf17AKguN/g4iANkc3RjcN3F4TcUKH4Eay1Bu+JP9aCOnJlvUs/fCksJ873k01z6
	uStX4MD3qF5WF6jgVqwz9uUS1zdn0B/okJykp5PvY/LMbsspI9537mE2S
X-Gm-Gg: ASbGncuaulsu2gixao1tS4CnH4jvHp1vpnAjv7un9sl3TFwq0B9ueEtOhN5vAowIFk2
	Y4w+EKbziZqOcbfNGvOsCL/ONl4ZpZHbkR2mgSbaSxoksTQ5uw2NLiEx80bkEUxK3QX36lnm+YV
	tkCy17dCd7x+So6zRnkwitkGxTdZ+jnQNF3lfanBLVCF+nvyNpxG2fD/HNZtjF0FAsgP4Gs6WPz
	46d2ySfvODWx86/Hwh5DZfkeN0eQf6E0K8MS3VtaY7x7qZghrXx9KP+7CUyjAavp4gSew+snwAi
	AY0kBX/9mcXzmsNaEi1fyOZVkVTBHP6bVKbAclN0BegRqcMYjZIteaQh9vlD+cnYUlLgPnnU12y
	RIWipTbZg
X-Received: by 2002:a05:600c:3e87:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-46fa9b17df1mr59434435e9.34.1760037400241;
        Thu, 09 Oct 2025 12:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxEViiRN8Lw2h0KvemsqiiXPHU95kQiydslrrD2f9G9rGLUFyRDI7eBLoEqJHlLxcoXRSxgA==
X-Received: by 2002:a05:600c:3e87:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-46fa9b17df1mr59433925e9.34.1760037399787;
        Thu, 09 Oct 2025 12:16:39 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0a03sm403646f8f.37.2025.10.09.12.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 12:16:39 -0700 (PDT)
Message-ID: <abe539bb-375a-43ec-ba36-6d10a35dd85d@redhat.com>
Date: Thu, 9 Oct 2025 21:16:34 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Fix stale IOTLB entries for kernel address space
To: Dave Hansen <dave.hansen@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <c04d4c9d-e868-4883-af92-26f142bc84be@intel.com>
 <d3cf3716-98ec-419b-90b7-b91b83599498@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d3cf3716-98ec-419b-90b7-b91b83599498@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BKCZ3z9CWdI4wuSTw_KO51Gd3gS0Q_QhXvv19V1k1TY_1760037400
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.25 21:42, Dave Hansen wrote:
> I wondered why no mm folks were commenting on this. linux-mm@ was cc'd,
> but the _people_ on cc seem to have been almost all IOMMU and x86 folks.
> so I added a few mm folks...

Thanks. Lately I find myself scanning linux-mm only randomly. So if it's 
not in my inbox, likely I won't realize easily that there is something 
that needs our attention.

Will take a look.

> 
> On 9/25/25 13:24, Dave Hansen wrote:
>> On 9/18/25 22:39, Lu Baolu wrote:
>>> This solution introduces a deferred freeing mechanism for kernel page
>>> table pages, which provides a safe window to notify the IOMMU to
>>> invalidate its caches before the page is reused.
>>
>> I think all the activity has died down and I everyone seems happy enough
>> with how this looks. Right?
>>
>> So is this something we should prod Andrew to take through the mm tree,
>> or is it x86-specific enough it should go through tip?
> 
> Hi Folks! We've got a bug fix here that has impact on x86, mm, and IOMMU
> code. I know I've talked with a few of you about this along the way, but
> it's really thin on mm reviews, probably because mm folks haven't been
> cc'd. Any eyeballs on it would be appreciated!
> 
> It seems like it should _probably_ go through the mm tree, although I'm
> happy to send it through tip if folks disagree.
> 
> Diffstat for reference:
> 
>   arch/x86/Kconfig              |  1 +
>   arch/x86/mm/init_64.c         |  2 +-
>   arch/x86/mm/pat/set_memory.c  |  2 +-
>   arch/x86/mm/pgtable.c         | 12 ++++-----
>   drivers/iommu/iommu-sva.c     | 29 +++++++++++++++++++++-
>   include/asm-generic/pgalloc.h | 18 ++++++++++++++
>   include/linux/iommu.h         |  4 +++
>   include/linux/mm.h            | 24 +++++++++++++++---
>   include/linux/page-flags.h    | 46 +++++++++++++++++++++++++++++++++++
>   mm/Kconfig                    |  3 +++
>   mm/pgtable-generic.c          | 39 +++++++++++++++++++++++++++++
>   11 files changed, 168 insertions(+), 12 deletions(-)
> 


-- 
Cheers

David / dhildenb

