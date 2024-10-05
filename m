Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE7145FEB;
	Sat,  5 Oct 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131952; cv=none; b=mvuVEmu2ZGFMaSr66Qk5aWCAkVZUYhdq2D0/CvO+xFw8XlU5WlxtGZ9YOKha4EGezAHx753Gn8Ou7D4FY8NBJbCfgp8ud3tf0zpR15ti3mr0Wsmwmri7fXSLs7dqcYQ8hQzH/7dTwnw8WHt3DwBN+f86CCe2C2JZUqNDp6+gXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131952; c=relaxed/simple;
	bh=YNm3x+D/+uR/yV1OSOY9lGo7cThaljvjLDn81E+MKfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPuvinjrVOwvi6lNfVsAKiUi4CZKoVFUQ2uiUwCsSgqHv7uxfEhCi4jd4iSA1TKuVdow4GJYC7YZQBJ1BaBmAreoScjrosYC+MF67QpEno1WGdvCluAYM+BI5HSWkA9UkAYcQgWLkIKHDLWbyUkubEnE3uUu4aA3knm6+7Y8nPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3gGGI1+; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3gGGI1+"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71de776bc69so1082793b3a.1;
        Sat, 05 Oct 2024 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131950; x=1728736750; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbmQWqwf8KLWBh53BpLjJjepp8M5DqLAMepSsUrr8/A=;
        b=W3gGGI1+uwdKWdUVHJdjUSoeCBJflwqjqu7hlt3+ruyOpTj1lDv9zV9yFsID4KXy5t
         jKi3JtfKdWKZ9dedKlXXFIQe9T6f4cInD+tv11EAJIRvj0VdvGhSIWXCc+d/Wqc7zNvt
         Wp7Ybf4mZ1SlJ+qVk0q/MFnNlgxADeXyECkC9c70DRw9/rORSrWjrKnRNJkGWiEtmywh
         Xh1ktZU4E/g0e/PSEeHZQdK3b+X+r+abSRFiD+8Hzu7RV/pM/Ka3kCJ4CWFkB4jjg/Z6
         MlIkoWJ3xNaejyVjpsGhQ1OfnyHrnNOQwZZF8ORDS5vmirKt0gHIdH+RPE6VofgkW/5C
         ZSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131950; x=1728736750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbmQWqwf8KLWBh53BpLjJjepp8M5DqLAMepSsUrr8/A=;
        b=AYYN4PW/5isUIr+e3cwlXDOaVxQHy7D/HklbDzfZe9NcupYlYJ0EgESOHfhd8XHUWh
         baAmGr1hdRni8xO9CrlhwjSWlvEDzSCsCWSmZDtm14GJoO8IBKcTSkvw5TbUdKMNWdwC
         PFeN1n0kCuVpL1kLIJqfuwQgObHC6MImBZ3WQyD3S6rCBSViszhF6mshVZ6XGIw4Xn93
         Dc43M++Gi1nakf97wOz0AMVywpvSoD3IzWwluocTKw5KMyAU+7WrIWhPEn7bKQYIP4Jb
         EWDiZfKgyV+5jalCWW3peuCjY9SyBBm00Fx/KT/eySTqfDWpqSdHaHDWP+5f3qrAdVi0
         cdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCDTet8HroKForiHWaod0HovNgGIGbm63I4aaWSjGg3X0ZXchuzSto+MPMdxsJYDVrvVo=@lists.linux.dev, AJvYcCXYyZAVWWgs0GMHJV0xhEjU3a7sbf3nWTzEpQBQD9EjBOK7k+TXB8Ijs6H/zcq4GRZWYsuDAGw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxg/WQzwMGikMgt4F6tanCDRxyA77gpK17JXBfuAYo4AOmGDk6c
	IOszyDQKKgJy0qvsZkhRjVJjOnNzap9kCdI3ZHS0RGGL+pUreBmD
X-Google-Smtp-Source: AGHT+IH7TZfPKkqMhF7jhMgZXtf7Pauw1fuqlg17S6ZMnwvz+3KYrvO5e1eqHcfYjc/CJowJUAwQhQ==
X-Received: by 2002:a05:6a00:9a1:b0:70d:3337:7820 with SMTP id d2e1a72fcca58-71de23c72ecmr10006756b3a.8.1728131949813;
        Sat, 05 Oct 2024 05:39:09 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:3c3f:d401:ec20:dbc7? ([2409:8a55:301b:e120:3c3f:d401:ec20:dbc7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd3983sm1408702b3a.87.2024.10.05.05.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 05:39:09 -0700 (PDT)
Message-ID: <6cb0a740-f597-4a13-8fe5-43f94d222c70@gmail.com>
Date: Sat, 5 Oct 2024 20:38:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org, davem@davemloft.net, kuba@kernel.org
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com>
 <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
 <33f23809-abec-4d39-ab80-839dc525a2e6@gmail.com>
 <4316fa2d-8dd8-44f2-b211-4b2ef3200d75@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <4316fa2d-8dd8-44f2-b211-4b2ef3200d75@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/2024 3:37 PM, Paolo Abeni wrote:
> Hi,
> 
> On 10/2/24 04:34, Yunsheng Lin wrote:
>> On 10/1/2024 9:32 PM, Paolo Abeni wrote:
>>> Is the problem only tied to VFs drivers? It's a pity all the page_pool
>>> users will have to pay a bill for it...
>>
>> I am afraid it is not only tied to VFs drivers, as:
>> attempting DMA unmaps after the driver has already unbound may leak
>> resources or at worst corrupt memory.
>>
>> Unloading PFs driver might cause the above problems too, I guess the
>> probability of crashing is low for the PF as PF can not be disable
>> unless it can be hot-unplug'ed, but the probability of leaking resources
>> behind the dma mapping might be similar.
> 
> Out of sheer ignorance, why/how the refcount acquired by the page pool 
> on the device does not prevent unloading?

I am not sure if I understand the reasoning behind that, but it seems
the driver unloading does not check on the refcount of the device from
the implementation of __device_release_driver().

> 
> I fear the performance impact could be very high: AFICS, if the item 
> array become fragmented, insertion will take linar time, with the quite 
> large item_count/pool size. If so, it looks like a no-go.

The last checked index is recorded in pool->item_idx, so the insertion
mostly will not take linear, unless pool->items is almost full and the
old item came back to page_pool is just checked. The thought is that if
it comes to this point, the page_pool is likely not the bottleneck
anymore, and adding infinite pool->items might not make any difference.

If the insertion does turn out to be a bottleneck, 'struct llist_head'
can be used to records the old items lockless for the freeing side, and
llist_del_all() can be used to refill the old items for the allocing
side from freeing side, which is kind of like the pool->ring and
pool->alloc used currently in page_pool. As this patchset is already
complicated, doing this makes it more complicated, I am not sure it is
worth the effort right now as benefit does not seem obvious yet.

> 
> I fear we should consider blocking the device removal until all the 
> pages are returned/unmapped ?!? (I hope that could be easier/faster)

As Ilias pointed out, blocking the device removal until all the pages
are returned/unmapped might cause infinite delay in our testing:

https://lore.kernel.org/netdev/d50ac1a9-f1e2-49ee-b89b-05dac9bc6ee1@huawei.com/

> 
> /P
> 

