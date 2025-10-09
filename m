Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B9258CFA
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038152; cv=none; b=eiLo2l43sLnG/ypMNz0E3X7pLtvEwCig7HOXyOHMSHoDpSZLybX7bTSJ7jqZ9iAqKHRIkJUFTM5TGRvypzoADasuBxqtl8dSM/t7arEwVcUEWA7/4E7iSEPDJFA/826eWIJk5UoSwArA/Yk/vNCTA5aFUuArdc5n6q1xCZwKUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038152; c=relaxed/simple;
	bh=H/mYcSY8IRc8FFw6hGHOaUcyuzzyejgI2LVImLSxLCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTHRBkYjWT4mo5q970kTr6yl90yg8Lrgo8ZHhxr5hlELFb+Bu1djV6MZwuAqrGxbSbzAplbd6Vk/2HUCKUAuyXpITiPMlirKuj18BmtgW65PW/MW1ECJ+0Ur4OnWyrwH6QsS4ugxyKxA1gdFDJMj8CxQbgxB3k7M791ZCDfhVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+oqna0I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+oqna0I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760038146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UYizE6uG9dNRCx3B33Lx7SghCaXuP30ktU90LRwaflI=;
	b=K+oqna0IVxLKwGXSQBV9hHshneFRu79W7UyieKd9kRDbMkF2bg2gr09DzlzTvM2kslifQO
	utrqFX/VyFIPVeYcVR/aJI6LxNCc4QGy5VyVs0DIizjr93M8gQqMx0pqFBjTsdbrlbFaS/
	cmyjr+N1Dxuoiwjij7XasOUWYl25fps=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-d1QHNaRlPUaLbMXZZ78lvQ-1; Thu, 09 Oct 2025 15:29:03 -0400
X-MC-Unique: d1QHNaRlPUaLbMXZZ78lvQ-1
X-Mimecast-MFC-AGG-ID: d1QHNaRlPUaLbMXZZ78lvQ_1760038142
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f93db57449so863584f8f.2
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 12:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760038142; x=1760642942;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYizE6uG9dNRCx3B33Lx7SghCaXuP30ktU90LRwaflI=;
        b=an/pDgP/PgD6l2gWZ5ZfnaJashDGZAyFMM2eHZ9+EbM2seqCztwD5lMsThi8nONWTp
         Na44zmsTzDal9McK+2CFbSimVbkxcWBzslDY0gHK/DwxqCi+KC5/5/A2FiqUL57ChFmg
         w5yvtcWoK7ZaLc09Soo7jVBGH5g+RhRqUDXwYhTgLxYup0sMB2nsWH3P3PgTg5yWgQnr
         OMWQzZcYlagFiK496ISNt6t1SJlR7sFgUnDSZ6Fhf/rnfbJ+9Cfh+bLnNJw3HsXqI7Hh
         EfflEFx92tjBCDdKyMNYvD4JYm9Z+m4zw5wj8RjDvRUMC5zRatilpnv7149p92rBMeXz
         DJ5g==
X-Gm-Message-State: AOJu0Yy5zNrFEXkBji9VpkBsGxRzv9Kulvu80UFYW2k3qwHi3uUlWsqx
	oeoJb5gqF3v+na/rDPOGElphA8/5IfePrlzKj9wr9gG/0gah+Gs4zNhMkKkaJSzBKEnPpq6pEaH
	4GXLbp+l+W1rjZuvpd7GIQfwvaFUYixCacVxJi21PiZnLjHGExuikRQLX
X-Gm-Gg: ASbGnctqLBB5Zo37vhG6edcdZE42UKtzFpftkpBtXZA9nFjNPCZGcAJxnFR4pPyi+mT
	zmtUUortsA2eKq/OePJEur2xdrYZ4CMjwmfHDJQq3Uf+w2GQTBrMt0GUHNHSVw2bZrfeflIGwFb
	bLbD31gSqhnmYCL4cyBZbf3vmgqE1YEf6orEQ2CC3aCYul/P9f68lxGgYTanLNBxvlpRAoq9nFv
	TmBWmEdNoU48Bw5fP5juUUVnjf3XE/kpxGtuq7R+F2eSAUcoAZgXZGGFdt4kaafdDy6mXv2CZZE
	Jy5trJWIEu6t/JM1VjwYvqqgPxRvq+ne+ZB2bpJALc+kCIAllzsskFyvqlBY+7T7LyxLmd3WP4L
	rea6AtDXy
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42666ab29d5mr4954564f8f.2.1760038141798;
        Thu, 09 Oct 2025 12:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2gGT2xa1+bv3tEdvDcUr7e+R3VDfPgA0ByjD5pwZbjp/sJ5A191i0yd157sCivGgarXbQ8g==
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42666ab29d5mr4954535f8f.2.1760038141331;
        Thu, 09 Oct 2025 12:29:01 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5833dcsm468974f8f.19.2025.10.09.12.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 12:29:00 -0700 (PDT)
Message-ID: <4858074d-f058-41ec-a581-a8254b8cc2d7@redhat.com>
Date: Thu, 9 Oct 2025 21:28:58 +0200
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
 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
 qIws/H2t
In-Reply-To: <20250919054007.472493-7-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PGQQFauUcn1lnJBhMZcuPjcB3P86IeyBprzSP1OveCo_1760038142
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
> This deferred freeing provides a safe context for a future patch to add
> an IOMMU-specific callback, which might be expensive on large-scale
> systems. This ensures the necessary IOMMU cache invalidation is performed
> before the page is finally returned to the page allocator outside of any
> critical, non-sleepable path.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---

Can we please squash #7 in here and make sure to call the config knob 
something that indicates that it is for *kernel* page tables only?

ASYNC_KERNEL_PGTABLE_FREE

or sth like that.

-- 
Cheers

David / dhildenb

