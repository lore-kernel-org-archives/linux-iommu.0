Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD1170A27
	for <iommu@lists.linux.dev>; Sat, 31 Aug 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725104195; cv=none; b=FnFD+g6wp6y5oWFw2386DI3QShP9uHyzVP2jnnKjZ0p27mwhRYwmqW7e82uP87wF2fiysKhipoB6vijiJuBTeBC+OMmjMesibtZArrHegsQAJ6E9frHt8lOMVnqJoITw1N/ZozlR7E9sojfNtNApsXCo4KVlFxruXD1dxZL9Z+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725104195; c=relaxed/simple;
	bh=OyGTBD0zWa3blsUCOwFvlsbl9D8mhJOLTNMIcOsRCpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwR6lvJAr4/iqJCvcWeZw3qbC4ER/WLC1UMc21ShJ5Don044kiv1oYkbitZsT3mOXWHtUstaXhDQ1iu7tg20G8UAYp2CLz6Bu8IaTSaMUkdYvYB/GGzGRoZbOVDt3L0BsXg+bgfhvJqdkOI+2WKyEkJ7A47eNsx06OEBQW/vK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7R+ca2H; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7R+ca2H"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso30026101fa.1
        for <iommu@lists.linux.dev>; Sat, 31 Aug 2024 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725104191; x=1725708991; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DW5o2YvVHbNPYWo6fwu2OHoD9wQjry9RZ8/xUuq9ccU=;
        b=i7R+ca2HKU5M2wdabR51OLU4R+VTtqGRC1KkM7/Z/i9meh8eLLi03xaySni+Zm+oXA
         Dl6KExEYzyg+FaaUqR0WfVTOMIQLxlY2NwdUVFGqRm5fJw84j+a31dIq2K8NgAiGmiwe
         vPEq0uQP6lA8mYEAHm2lB6xT3v0h/YV9nAURMbkNAGr7jczGPqDJU4+c4sxxV2msQ1f1
         FHmVVPujq9qoSBCoLAaD9TxEH5XEZuDqfc6HlyS0ziHCSbCLvEQIBnikhOVcGuwYhDU3
         1kfFoa17Eueu3ZWvZEvC6TFz849Hw6EryMGJ0VU30r0vw/kt9Vy3NRuoET8ZBr480emJ
         gXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725104191; x=1725708991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DW5o2YvVHbNPYWo6fwu2OHoD9wQjry9RZ8/xUuq9ccU=;
        b=k5LelOuIerX5E3MVEd8+wVyPmWBikaNq+Fn4DrhisXa1QqtxkmCEl5X/pG8AOO6TqI
         9tqOFf9PzElXtQHAcfvKWL7VYK4Qcbpl5j0FCcgT3y+EApAuP9GHhbzSwD5Yd+8q8h1K
         kNKLBDopDeokcwGEV6cFTVXvDsQccknXUOa+nNXYMpHhURpXyVrj51/rR5F2id0hC2vr
         HicAYiZHNUN1x3wOCHhga+JlJI5apZ/7AWzgLdSXO6JGJbXivr4i183qlaMBpani3vyi
         kmQQGHoxSenMWK3nJTC0kSIo1lHBZ5/o9smXheUHRgzfoxfHRvPyzCWJTJmhMeDARmq5
         b34w==
X-Forwarded-Encrypted: i=1; AJvYcCX0jsQMFmPSHdvCvAFgarSrMa1csSfoZNnLqnWl41c0yK/FGupiA/4WNzvy5/+5rV60qZ0tFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKJ64mqH8AVS/HlO5YdrStxye9m3Soc+xEdG1710C+BnHVzM2Z
	bxI5F5uEcgsCH941bayEn7kpultOv0YQZN+EQRrphfPWcPmx44Uh
X-Google-Smtp-Source: AGHT+IHHNejUCl2NXL5+Twx1GLp1uz8JoLh9RVEQPg+qgl3Oa4CJXifFuSUIJs/dn4QjoxCNq1qJPw==
X-Received: by 2002:a2e:be9e:0:b0:2f3:aed8:aa9b with SMTP id 38308e7fff4ca-2f62902dcd4mr10651691fa.5.1725104190488;
        Sat, 31 Aug 2024 04:36:30 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed1787sm10456961fa.10.2024.08.31.04.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 04:36:30 -0700 (PDT)
Message-ID: <4b6295c6-d792-4fc8-893c-3be0b26cd22c@gmail.com>
Date: Sat, 31 Aug 2024 13:36:28 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] Dynamic Allocation of the reserved_mem array
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, robh@kernel.org
Cc: andy@black.fi.intel.com, aisheng.dong@nxp.com, catalin.marinas@arm.com,
 devicetree@vger.kernel.org, hch@lst.de, iommu@lists.linux.dev,
 kernel@quicinc.com, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
 robin.murphy@arm.com, saravanak@google.com, will@kernel.org
References: <20240830162857.2821502-1-quic_obabatun@quicinc.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240830162857.2821502-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024-08-30 18:28, Oreoluwa Babatunde wrote:
> The reserved_mem array is used to store data for the different
> reserved memory regions defined in the DT of a device.  The array
> stores information such as region name, node reference, start-address,
> and size of the different reserved memory regions.
> 
> The array is currently statically allocated with a size of
> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
> will not have enough space to store the information for all the regions.
> 
> This can be fixed by making the reserved_mem array a dynamically sized
> array which is allocated using memblock_alloc() based on the exact
> number of reserved memory regions defined in the DT.
> 
> On architectures such as arm64, memblock allocated memory is not
> writable until after the page tables have been setup.
> This is an issue because the current implementation initializes the
> reserved memory regions and stores their information in the array before
> the page tables are setup. Hence, dynamically allocating the
> reserved_mem array and attempting to write information to it at this
> point will fail.
> 
> Therefore, the allocation of the reserved_mem array will need to be done
> after the page tables have been setup, which means that the reserved
> memory regions will also need to wait until after the page tables have
> been setup to be stored in the array.
> 
> When processing the reserved memory regions defined in the DT, these
> regions are marked as reserved by calling memblock_reserve(base, size).
> Where:  base = base address of the reserved region.
> 	size = the size of the reserved memory region.
> 
> Depending on if that region is defined using the "no-map" property,
> memblock_mark_nomap(base, size) is also called.
> 
> The "no-map" property is used to indicate to the operating system that a
> mapping of the specified region must NOT be created. This also means
> that no access (including speculative accesses) is allowed on this
> region of memory except when it is coming from the device driver that
> this region of memory is being reserved for.[1]
> 
> Therefore, it is important to call memblock_reserve() and
> memblock_mark_nomap() on all the reserved memory regions before the
> system sets up the page tables so that the system does not unknowingly
> include any of the no-map reserved memory regions in the memory map.
> 
> There are two ways to define how/where a reserved memory region is
> placed in memory:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a set start address and size using the
>       "reg" property in the DT.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying a range of addresses where they can
>       be placed in memory using the "alloc_ranges" and "size" properties
>       in the DT.
> 
> The dynamically-placed reserved memory regions get assigned a start
> address only at runtime. And this needs to  be done before the page
> tables are setup so that memblock_reserve() and memblock_mark_nomap()
> can be called on the allocated region as explained above.
> Since the dynamically allocated reserved_mem array can only be
> available after the page tables have been setup, the information for
> the dynamically-placed reserved memory regions needs to be stored
> somewhere temporarily until the reserved_mem array is available.
> 
> Therefore, this series makes use of a temporary static array to store
> the information of the dynamically-placed reserved memory regions until
> the reserved_mem array is allocated.
> Once the reserved_mem array is available, the information is copied over
> from the temporary array into the reserved_mem array, and the memory for
> the temporary array is freed back to the system.
> 
> The information for the statically-placed reserved memory regions does
> not need to be stored in a temporary array because their starting
> address is already stored in the devicetree.
> Once the reserved_mem array is allocated, the information for the
> statically-placed reserved memory regions is added to the array.
> 
> Note:
> Because of the use of a temporary array to store the information of the
> dynamically-placed reserved memory regions, there still exists a
> limitation of 64 for this particular kind of reserved memory regions.
>  From my observation, these regions are typically small in number and
> hence I expect this to not be an issue for now.
> 

I tested the series on the same systems as previously and did not see 
anything suspicious.

In addition I tested my x86_64 desktop with CONFIG_OF enabled and this 
new version boots fine for me and did not show any new issues from what 
I could tell.

Regards,
Tested-by: Klara Modin <klarasmodin@gmail.com>
