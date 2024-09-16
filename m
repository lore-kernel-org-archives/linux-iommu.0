Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDE84D34
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469989; cv=none; b=kF5iw65JG5JFZ0hM/JEY5JFpYhZC/VIFTpODSBMG5QnMyiI6wBTbe6VLOdj8OsyUkTEdGcbcstpfjirbiMOhBXsFtfqvtbWfmJy+uanXQuK98D94gZeln+c5f6p+bTfnqB3bpNJGLKQz5IX8yEvCdRgxvvNZ0TgqKiYuj23gVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469989; c=relaxed/simple;
	bh=BRlg6KteMpFfEGHsJSzVG3Wg8eNHikDPuQFuLb5FRIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHT7whZ6qJ14KQ69apiRHcTJfgzh4ebkRSRrHECFIfBN/4E1K7Li+XJF6VK3AtKACd0I8Ljwmga5EdbaEwMQTi6AsEjBRSQy7DmBMfYIxSzoo4yHbuyy50P9NfBFxw5Gm5HXpMkX9k4tXjQ0uIyMvkH1XAMHw3P/08BZKDhNoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ily93794; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ily93794"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d4093722bso577975666b.0
        for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 23:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726469986; x=1727074786; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hoxc2xLo27czaSJSdH1lZge3rHpm9JVblpGZxZKH8tM=;
        b=Ily93794deTrFz3mnGpwmEljFh8b0B5bgwnnqP7LAN50qFAwpb4h8zy7iDFUS+yeMK
         cTYCmHV95B9Xfn85soPel4qI0PJ5z/TsWK9TpmnKfN8GP9rayD478Ttn1J3F7/Jpy6ws
         G0mdGGBNGwgAMYXhwm9oq7afuoQ39gSd90SRWciMcZb0ySy7qRn01zJS4L1Rc4iH2OgJ
         MRKiAZiBGwLq1Br4WN9Bfypdb/jzscMOYVA0o3oAucEiejM0KrO3pyVxQNt18iBPtKcm
         HnbP5+jAvruWmW5tUNtNvMSbUVFAkap9l7KMCQbnRQkg/dP27VI8ehOYVzHEmRHiGtC5
         yT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726469986; x=1727074786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hoxc2xLo27czaSJSdH1lZge3rHpm9JVblpGZxZKH8tM=;
        b=b0gfzwQTp89wOx3XnQlIojh9I9vjD1SroU4IjxSnttshPO6GpUZRV2D8vu7bHCBOSx
         A8iidlLnEPuhET/LmOtzEbjVhcNdZFa5ds6v8wdR61U8XCCpbRRZ68xjT4FGV3J/cDxX
         XeuJQ3xxMXSGrcH5YR4u8zxmWAZ8tbY3UnNC5Ob10+4dBHfQH4fCqrWYZjhKX7sp1+xY
         OjKiezD7nXy1Bo4OumaZpncTbYi3xNG7cGZ1NKAp8tOJkLwswGUaBaLZMWmZexlqznpw
         sHRIxqgUMA9gZYMFiKR2tWdVy+L/CAOKxZMYvnvmvyjxp5KVex6cpv8O4i3wg6vq3Cm+
         NGQg==
X-Forwarded-Encrypted: i=1; AJvYcCXyTucXB9TqPQGeKD43C52cDU8ik6i1mDKQmsL/WDdmmUYSSmZjh06ekLUzZp1kCngeYZlf3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmPtYkMtkvmKjEdyV1Jss/n9FnK3CYuMcUxfnOiVbSk4XmN192
	ICjkOXnNSkwpu3hBiXwGMSqOScFJMEztkFgyF2kKQeeM6oW3gUvIF4Y/FDcGaQ==
X-Google-Smtp-Source: AGHT+IGEE+x4myqxVpsG+4wlTw+uLRt/VgS3sL49Fo+T3MUgbxgZNUqjr+4TTGSrsMaNaZ7JrXeu3w==
X-Received: by 2002:a17:907:d3cf:b0:a86:8285:24a0 with SMTP id a640c23a62f3a-a9029434c42mr1485582266b.23.1726469985553;
        Sun, 15 Sep 2024 23:59:45 -0700 (PDT)
Received: from [172.31.47.100] ([193.118.249.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4375sm272050366b.73.2024.09.15.23.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 23:59:45 -0700 (PDT)
Message-ID: <c97450a0-6ddd-49c5-a8e4-0cd2cf9d1635@suse.com>
Date: Mon, 16 Sep 2024 08:59:44 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] xen/swiotlb: add alignment check for dma buffers
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-2-jgross@suse.com>
 <d23c9af4-4a79-4300-891a-fba3ea9cbb1c@suse.com>
 <c2dd89b4-46c7-4a0a-a47b-70862294176b@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <c2dd89b4-46c7-4a0a-a47b-70862294176b@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.09.2024 08:56, Juergen Gross wrote:
> On 16.09.24 08:50, Jan Beulich wrote:
>> On 16.09.2024 08:47, Juergen Gross wrote:
>>> --- a/drivers/xen/swiotlb-xen.c
>>> +++ b/drivers/xen/swiotlb-xen.c
>>> @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>>>   {
>>>   	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>>>   	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
>>> +	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
>>>   
>>>   	next_bfn = pfn_to_bfn(xen_pfn);
>>>   
>>> +	/* If buffer is physically aligned, ensure DMA alignment. */
>>> +	if (IS_ALIGNED(p, algn) &&
>>> +	    !IS_ALIGNED(next_bfn << XEN_PAGE_SHIFT, algn))
>>
>> And this shift is not at risk of losing bits on Arm LPAE?
> 
> For alignment check this just doesn't matter (assuming XEN_PAGE_SIZE is
> smaller than 4G).

Oh, yes - of course. A (hypothetical?) strict no-overflow checking
mode of the kernel may take issue though, so maybe better to right-
shift "algn"?

Jan
