Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9BA2609D9
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111256; cv=none; b=VTaWnfrchvRV5zFQnrWNlrCkVE02un8HqjjViy92S/KUxva/qu8O4/iTUwP4ihdNKAc01QpNwwhmhA+U1449OKghnzhrQe0Ekm21Lb6b8PWAEcoOI9rJSM05iw9FxN1gxftqCknzukRJd/7fgM1Je6YGQm3ypPBujLeI5v8kHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111256; c=relaxed/simple;
	bh=mKDOOk3KcDM5ijS4yS5L+9x30BVrsnUu5Cv3VCL98kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Epk5zO8DFXZn8/3Gz1+tcV/mbIFP5bUTljmuC2MVYfRp1s2N0Kpble5InQSZwNXASzT0MKvC9H9M8YI5ncmBkefcP8hzMJYWeCUlp8bBjOIqEdeSIazOET26vwifRnAxIznN9SjP6XqgUi/pZxXdRLgfUrtxJGG4xcujWaIF4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFtlPmvD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFtlPmvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760111254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FYxcb8Ei/Xcr+4iQKa4We4Vrj2RcYDCtpxX0z6XF/kU=;
	b=ZFtlPmvDEWgs1O6QNEly5OXjgWniaruxZx22LRa7HN5RRg1PHNis4uhUKbik1T8kPdyN4D
	IdO70aFlnFsgSgXPriYlkFgiQxxmIi9WHdaa3lrhVNGjd1AcwGEWRmOBjxmYF2pYA6I7MM
	zJCve88iVH+2EFEJc+xWYt2lNziNXoo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-_xP89zXyPM6GRUU1BdKp6A-1; Fri, 10 Oct 2025 11:47:32 -0400
X-MC-Unique: _xP89zXyPM6GRUU1BdKp6A-1
X-Mimecast-MFC-AGG-ID: _xP89zXyPM6GRUU1BdKp6A_1760111251
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f384f10762so1697443f8f.3
        for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 08:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111251; x=1760716051;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYxcb8Ei/Xcr+4iQKa4We4Vrj2RcYDCtpxX0z6XF/kU=;
        b=o8Va3suQF3RZmCk+NdntS1nmFnSPFxCCfehVbDevZNvfrj2PIO2A2jnAkL0y+YguBg
         2vtaIHnZZfam+nTLDS6RXBjhiBzm7Q/qeeFTNLmL4EzTExZWhiZmc3D4fF6ZnJGbfToG
         mdL1iXk7lhIlS/JxpyYz7fP5zLkEf2ghk0wKw15j+X6Xv/h/YnSn04ADqw1cBmgXIgRE
         jiCdpAVCxHKzOLFW+R75VnIhUZuS/Hm5N8zcr436kbRQPjq3W+Ihz/K9htFTcUF0Yp+J
         So62O9rsrtg5ucTogLkO7LtqpSGvHFJdZz3mAmifWWhywFCA3oXIqZLYYpw7pNRg/3/g
         jO/w==
X-Gm-Message-State: AOJu0Yz9tjmxXDNw30VFxbV0m+pYFeaBADuFajSi1YwgsZwt6qpj5wNU
	Dxho2swmw9k4G7wAvqtIcDjljNegGJgIE9heSGLEEciYCzgP5Z3UlTWSDFkPpNBTOUPH1QcsyJs
	cZT+b28vsZ950EhHmPNsLDflQ8u2SuEIsn1ItHMOTyxYpjS/e4Ad3JbpB
X-Gm-Gg: ASbGncvbBnsgMs9209sKZemmJakND/Hc6ugO5wJbsLsC9yiIIM1FhLTGnyXbca3+LXP
	iIaWs4BogXZ0ZmWfRyAhgT4nzaFmn4gCglzgVoEGsghqMMOcGgaPYyxUQOp7OPqYCw9KzPJD+uW
	6hpJH7zO2Vf9spcZ5QgsVTIh5C/7bv6wnFVHgqoB3ymhyrV6i57xprcjfygtCk+nkDm5NwMSLWm
	vBkoqbV73cjy/4tmo/wrwdhlAg0ZEtGztZcsqPzO2kQz8fh9B/K7MEg7XSq3uWwMwUZ96upz4/M
	qyDLDcW6rHfZOi/kRDv2vgEhJVPnOyhQCVtOaP+pHmNbq4aWkiQj3mNEfc7XY7ZOgofyQjXWj1f
	W3Jw=
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42666ab29d5mr6668208f8f.2.1760111250794;
        Fri, 10 Oct 2025 08:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHqhMbEUgBI/Iv97iNeHuLMcRgPyI5xUWfi2ZMDm/sSHI/GStcIbfl5wXKZP1H533gyi729Q==
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42666ab29d5mr6668179f8f.2.1760111250365;
        Fri, 10 Oct 2025 08:47:30 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5833dcsm4829510f8f.19.2025.10.10.08.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 08:47:29 -0700 (PDT)
Message-ID: <5b494700-a3af-4feb-8c5f-1ca424ad9841@redhat.com>
Date: Fri, 10 Oct 2025 17:47:25 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] mm: Introduce deferred freeing for kernel page
 tables
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-7-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250919054007.472493-7-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HO4ajzv4_Czi8Dh4FEL7_pzpypwR0-VU8zAJKzUYan8_1760111251
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.09.25 07:40, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This introduces a conditional asynchronous mechanism, enabled by
> CONFIG_ASYNC_PGTABLE_FREE. When enabled, this mechanism defers the freeing
> of pages that are used as page tables for kernel address mappings. These
> pages are now queued to a work struct instead of being freed immediately.
> 

Okay, I now looked at patch #8 and I think the whole reason of this 
patch is "batch-free page tables to minimize the impact of an expensive 
cross-page table operation" which is a single TLB flush.

> This deferred freeing provides a safe context for a future patch to add

So I would claridy here instead something like

"This deferred freeing allows for batch-freeing of page tables, 
providing a safe context for performing a single expensive operation 
(TLB flush) for a batch of kernel page tables instead of performing that 
expensive operation for each page table."

-- 
Cheers

David / dhildenb

