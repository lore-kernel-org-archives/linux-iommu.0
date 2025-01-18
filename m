Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF72F50
	for <iommu@lists.linux.dev>; Sat, 18 Jan 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737207423; cv=none; b=sIllz5oV3H+VAomoY/IntM4x3WkbuDklS9Z3Vw0nh8x4plVWvl+T2f5Nr/I7zPIQlV++OxsUNB/2Lj8JpJ6T8qu5LChvZSSsLJgcV3AGVdKAC4vtPa8AtTnijGju3LwPa23NobwZDGGVJiGfzV1WbQBPNm5vDeQwWHGc8z0A2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737207423; c=relaxed/simple;
	bh=dfkCDEjreWc0tw7VC3I2BHlPVozZjZ/VrjMc8whqjno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms2pVaTOaWsPoAmhcn2+tMqucO3FWGGpugRhqJNgcWfOEN9u/ZgksTlc4WReOFBWRrcPUdY6Dv6c0vqYgtO5+k1TpsN3bDwds+AwoDVrZTVrNpDA2KbykDKqdH9Evq5vKvOT0p+CDx66JtRC1NlZGVTkUiCS8DLZtV8dvGhV9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M65uJ/k0; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M65uJ/k0"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so5531862a91.0
        for <iommu@lists.linux.dev>; Sat, 18 Jan 2025 05:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737207422; x=1737812222; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fl7q3Ow0SI/mPnfg6y3Pb7fNtW/ik4Ugk2pGzG5GGpY=;
        b=M65uJ/k0m0rL8V06h5EezkhKsvx3F5Uh4bCmpM48pTagPe9kS7jPGs8mvuqppQrTfw
         qhlJuL1Mou1jWW9WQNFeIWQdU3mIjrhclAynGyq/SC0ewE3YMiDYZIl5PGKovgLfd6JT
         0IJ1TTaZOIG0x6DJuBJiz27hfctTlbUoMLejT6bwD5JDYKuHiCjRbJhbSD3mDAZKR6av
         QAv+OJQtJ6UXUmTtRrK7I4AE7JuNiAAv7m8nqTk0DUPOIJ43Lh03tVeFbHq6+WHc1cfJ
         ixJebkMwDBBvDdoaue53nBNPMQzhF2Fgi84SflP/ADxxl/h5ZlObIL8CnS94SWTozJll
         mZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737207422; x=1737812222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fl7q3Ow0SI/mPnfg6y3Pb7fNtW/ik4Ugk2pGzG5GGpY=;
        b=ErhakKLUN4CuKiXBm5ixZyAMLhn5yelN19iGOV+C5kiPPPUh0q4S983MYRu+jgIYD1
         cwlGR9a5V3Aw9emA/UzFZcz2qJr18FfXlXa05qANnClj5Ztoh2uFieRd8RUzyixwc7IJ
         q1tfcdNVxv/kTRnxVpG8j6ZmG5WBXKnxCWnpySUkyOCPJeRhsb9lTeQ2dJa/jG3t/utn
         ZEPKDWxDUJTcTB13/7lfa2y29Ei/4yPy2N5DdZu1SBzLczCnd553QJoG8+73LYzi/R74
         GT+WWXPXIlBU+Utywnnt19IxYZUY/qIwFylU4Ah1OC4tzxVD7dTRQMYjDYp3izWn+PLC
         auaw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+HP+9p9zCyGpel67sATA8PvPc8WJTpklbailGf7cahG8rSepGxj5bRVGLPi1xD7kOWDbMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx67bwuGiTCaQMHo3xtA6jFwClwD5S/Y+P5Ll5oGm03j6pXM7z5
	5+r8ZVRkFdZjIPEVcJX6bPY0Pp8FHJl8NUmWVb+0ZYGgvhmHyhRv
X-Gm-Gg: ASbGncsOiDB4VRS2Jo/zTqtsmG0+IzLsEbRT2L1Iz98kPiDfhpv40IxtoYI7MZg7jU8
	0MaB2ml+aVLWOru4a2hcHs/BxrO7d7nNB/5wI9PxTptzWwVUWSQz/p/INJTxQiWKiBkbCDj5AFB
	x/4FzphxujAqAbehTc7UGjj1+Jc8ZvRP64qxQFaI+z0as8gfnA64x/hq4OT+Cc8g40iOvVyqDPD
	pEvk+pwVQfaTVtnsSVwojRPvtd97pm87FdL5G8idUtmCONYnWONLUwX6441IZJ04aQye0StC2cl
	bskJUHA3lpAurMAJIslHSlOw7qcz2tdJVHFMjefXLysWAltR1HmHZmDXGA==
X-Google-Smtp-Source: AGHT+IEr0UwAYjH54uv/p9tjrBBxTcKHekQANUfyWsFG5hb9xxGI3N4cbP/XpAUP9uw0bRrU4OjjPw==
X-Received: by 2002:a05:6a00:4fd3:b0:72a:8461:d172 with SMTP id d2e1a72fcca58-72daf9becfamr10317751b3a.3.1737207421525;
        Sat, 18 Jan 2025 05:37:01 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:28db:76a6:1c67:659f? ([2409:8a55:301b:e120:28db:76a6:1c67:659f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab84b639sm3744765b3a.84.2025.01.18.05.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 05:37:01 -0800 (PST)
Message-ID: <3795e5e1-8a6a-4ee3-9778-1828ac5b2748@gmail.com>
Date: Sat, 18 Jan 2025 21:36:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/8] page_pool: fix IOMMU crash when driver
 has already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-4-linyunsheng@huawei.com>
 <921c827c-41b7-40af-8c01-c21adbe8f41f@kernel.org>
 <2b5a58f3-d67a-4bf7-921a-033326958ac6@huawei.com>
 <95f258b2-52f5-4a80-a670-b9a182caec7c@kernel.org>
 <92bb3a19-a619-4bf7-9ef5-b9eb12a57983@huawei.com>
 <eb2381d2-34a4-4915-b0b5-b07cc81646d3@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <eb2381d2-34a4-4915-b0b5-b07cc81646d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/18/2025 12:56 AM, Jesper Dangaard Brouer wrote:

...

>> I am not really sure about that, as using the PAGE_SIZE block to hold the
>> item seems like a implementation detail, which might change in the 
>> future,
>> renaming other function to something like that doesn't seem right to 
>> me IMHO.
>>
>> Also the next patch will add page_pool_item_blk_add() to support 
>> unlimited
>> inflight pages, it seems a better name is needed for that too, perheps 
>> rename
>> page_pool_item_blk_add() to page_pool_dynamic_item_add()?
>>
> 
> Hmmm... not sure about this.
> I think I prefer page_pool_item_blk_add() over 
> page_pool_dynamic_item_add().
> 
>> For __page_pool_item_init(), perhaps just inline it back to 
>> page_pool_item_init()
>> as __page_pool_item_init() is only used by page_pool_item_init(), and 
>> both of them
>> are not really large function.
> 
> I like that you had a helper function. So, don't merge 
> __page_pool_item_init() into page_pool_item_init() just to avoid naming 
> it differently.

Any particular reason for the above suggestion?

After reusing the page_pool_item_uninit() to fix the similar
use-after-freed problem，it seems reasonable to not expose the
item_blcok as much as possible as item_blcok is really an
implementation detail that should be hidden as much as possible
IMHO.

If it is able to reused for supporting the unlimited item case,
then I am agreed that it might be better to refactor it out,
but it is not really reusable.

static int page_pool_item_init(struct page_pool *pool)
{
#define PAGE_POOL_MIN_INFLIGHT_ITEMS            512
         struct page_pool_item_block *block;
         int item_cnt;

         INIT_LIST_HEAD(&pool->item_blocks);
         init_llist_head(&pool->hold_items);
         init_llist_head(&pool->release_items);

         item_cnt = pool->p.pool_size * 2 + PP_ALLOC_CACHE_SIZE +
                 PAGE_POOL_MIN_INFLIGHT_ITEMS;
         for (; item_cnt > 0; item_cnt -= ITEMS_PER_PAGE) {
                 struct page *page;
                 unsigned int i;

                 page = alloc_pages_node(pool->p.nid, GFP_KERNEL, 0);
                 if (!page) {
                         page_pool_item_uninit(pool);
                         return -ENOMEM;
                 }

                 block = page_address(page);
                 block->pp = pool;
                 list_add(&block->list, &pool->item_blocks);

                 for (i = 0; i < ITEMS_PER_PAGE; i++) {
                         page_pool_item_init_state(&block->items[i]);
                         __llist_add(&block->items[i].lentry, 
&pool->hold_items);
                 }
         }

         return 0;
}

> 
> Let me be more explicit what I'm asking for:
> 
> IMHO you should rename:
>   - __page_pool_item_init() to __page_pool_item_block_init()
> and rename:
>   - page_pool_item_init() to page_pool_item_block_init()
> 
> I hope this make it more clear what I'm saying.
 > > --Jesper
> 

