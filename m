Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215137;
	b=orPjuiwyKjEu1j73QCChza1iyXb7LJ/BpsCA4hyhSNSwz6Zw44sZPODOKe0qIJWYQoze
	 C2LcpATEXEY2I5yy/2SItPcF5VMfWC7/KWSkG2Ey0RlAapArPoQJAgf5MHHuQEN+LA+sy
	 Vh3gsvkP2F0fBSxMGyiOM+lQWoKRgxo9Wl/NeVs/W3+lfgOF7VgSjB4zgchI8tl5Ot/SS
	 +AgFoPaPyXV9rSYDiZ/lzG4T0EBy/CrF5oXA7SIDVJNKXxT9QZDFmkotVb4sjFakzOFTZ
	 ehYsZXD4J3FpwAWqXmI6CkNOOUE9ZMzBFzw6MT09Q5nWjhpoVqVzP3NhEE7Vw6bZ40g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
	b=VGUGow/wF4vQdjt6S8nq3qW2z97qtNTZvazLgCI0gbhpNWFk8HsQPRulwa8myPkxNFB1
	 3rJitCoX8nH2xW4ycvh6TfAOwSZIknZQ4mQWGt3uMMqkRU6FM7GRnRbzDcT8v9EcpyzUj
	 wFRzl3L74xlp3mMAoNQHwJQXcOUpgzFnCjIUAwkIMZXP3PyCK0FGzsEy8UA5W8f9vUYlC
	 6wKS/K76ErwoFCAakMbkr9xC2D53atAUx5X2QfFiiuty/9u25r+L2y8KFYJs5sCIWqvFs
	 sw96aE3WC2cvEIh9X/RUuCFEtlnCRCxABpqjj4GmAewVxi/WRUj01EktwZ8W0XJqVaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPRg0mLx;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D3606A321
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 09:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 210D3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPRg0mLx
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so361110f8f.3
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 01:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794215134; x=1794819934; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
        b=ZPRg0mLxUZC6rIVYvRIqrvNAFc/F1DzR1NY9RFmsw892J8GG2gDDAu8NvkBHGhfq3P
         WZkdDvToJGUhi+6NULubshHJYjYcJQqHd9wGDYp1LvVIH2HSXNfFQjE70w5HEAS2+/+1
         QjQL9/vqDuIrXmpRBJy51Zq/S741Jvkg3jnSxKYfXYf68w6GvTlqpN3chl57WMK253oi
         7LOyO+ky8DnOLl5px0x/uhMdUFQxm9nLe9byWod412uckIBBafeIYcdzuXvImBtwy1OB
         FSVfYOl2h4JxEWIgDRXCqQuHXSBLmbrbMuX2HMlPssLEbIG0jOtNtgqwoTvFxJ7cSbEf
         Ocew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215134; x=1794819934;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
        b=DFUHUpI0Bx27tXXUxBZxZuFiOXDqpGgVd3AIUiU1/eKCchAINJggksWGtfpRNclwvm
         TYSi8l4qHEbY0/8WA8Jo2aQW5jmT1rnKvyCjqJyvaRlfGd6DDuKokAx2vMFglphd7edo
         ex2goPgTDeBkZG9NmCBO8kfdm2DtIaVthKhCp3UQ8GW057JcABhAEB6VPgtipwtW8Z11
         k+CZCeBVnWsE0Lj+bOVHBJOWfGtuuuTpl6tzIJspsLKIZ2hdehwuBsO0d9+P+2tg7R2M
         HkmC6+iswGvKhiWHuwzr4hjhbFmY78EIeNuj30ydf8z8t+Rxdq+kMV9FPvq24PSI51mI
         NvLg==
X-Forwarded-Encrypted: i=1; AL+hErGPjRUjzcMZCdfYMMEQEcRDnXaj50oQWSpFAvoq3e4PGAr4rzHlNt+1xGxy4lfgnLGC1UAWWQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8LrKoDamPrJXC5YYhYLU21E78tbnyvLLDuVV0E0CYMbmXksZO8
	/7KvFn8keZn5auWEgHuGndWySEMziyXbEzRDvXTkRpWQVcvnE4OKfhrE
X-Gm-Gg: AYBFou28ZJV7IBQGXfwnGM5ig5FlgNoq44OefdRGFceyO0DR77imRBGaNLgQQ9TaSXH
	0XiGnH3JIlR9JITOylEgNsxEJ4DC0ZXMdXarkWwh/pJSSY2yzNX+IEhXPz5sIabAGGrL1JVF8Sj
	nqEl73KdItR4DnF8fMeyKkU/DPpsbuLogliQj034LmZTOgtztkNQQfXqO/Mpm46ipB0Qo2luqXV
	/kMbUe4QQHJNHfGVbjmEwNHEfeWijOTzB4jm8mJ1CcO0bAklgecfbs4ak2c8HcSrKBRQs8Nb3ho
	gKOMNdCHNWWH0hCAuLa0fWzu2yEfF5ooQz1q0s62F87jQrHBtmHI4ifwI8d3koPtLtWsAa5dP+n
	z8mNHVjjKfxn4MLxlndVDj0YrGYakyM/OVPSS3ZeX1XPQTnJASaYoT35vs/ExG26EUeKha/Hr8a
	IkKDX620I1Q8TOyEx4efKv3T7qRbeRWdWffjRLNivZimXwr6ym14DV5GgH8eft8LPexNeAUB25x
	8ABsM4BhGViYec5bhxdvihHDOAoGXZnC1R2IHIAIp99fnU9xDxLxggVRMcgMAt+Y/3zbyhvkPvc
	FE/55+qDU58umIbJNif+eRs=
X-Received: by 2002:a05:6000:2210:b0:48b:a7:6396 with SMTP id ffacd0b85a97d-495844a3a48mr6683329f8f.41.1794215134134;
        Mon, 09 Nov 2026 01:05:34 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596ea51cbsm9541323f8f.27.2026.11.09.01.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 01:05:33 -0800 (PST)
Message-ID: <8ff83fbf-2ecb-4f9b-ac8f-ee88fece67cb@gmail.com>
Date: Mon, 9 Nov 2026 10:05:30 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm/gup: limit pagecache folio refcount when
 grabbing references
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-5-c38f6809b106@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261107-refcount_overflow_stable-v2-5-c38f6809b106@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 11:23 PM, David Hildenbrand (Arm) wrote:
> Let's add a folio_ref_count_over_limit() check in fast and slow GUP
> before acquiring additional references or pins.
> 
> Keep it simple and use the check for all folio types.
> 
> Don't check capabilities with IRQs disabled, as even unaudited capability
> checks can take locks. Refuse access to the admin reserve, so GUP-fast will
> fail and fall back to GUP-slow if possible.
> 
> Also propagate try_grab_folio() errors when grabbing additional
> references in __get_user_pages() and in memfd_pin_folios(), so hitting
> the limit returns -ENOMEM instead of -EFAULT and -EINVAL, respectively.

nice!

> Keep the existing invalid-refcount warnings.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
