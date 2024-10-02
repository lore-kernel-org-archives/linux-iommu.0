Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1648FBF0;
	Wed,  2 Oct 2024 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727836489; cv=none; b=S3BIfvWVtEws4DUaALh1L7QJ5iHBZLNEAGnK5UNRJIQDUbt/WKp8cD7EoNmAOMcLmX1TIr6tdEwACBU4WVk8b68fLgFsIqE5RTB189DQDHsH7P1zdSKmGU8uKXEOQbBOlGQSDXME1AJwEVaQvPEZ6mRGOrM6zlKy0iBEXKw7SG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727836489; c=relaxed/simple;
	bh=BRm05lZZpfny2NmS9iQrsoYuXNvYjRIeUaz9a8bHb+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRKS4dP20ulJgl1Kj4pnlgp0wJEhlJtwHb9VnkGKDyw7HdlG4SAUF+TOC9N0IWKG4MwIKXhbVkTIRrwq+LtsEEw0unJgCkPyX1Ozv45XE8GMSsKAwQkf7zuHjxvYwwOXLg9XB3n+jIqER+fxxFnJL+AihMOKKjWbG5ct5hDtZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYKn2KFi; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYKn2KFi"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20ba9f3824fso13768905ad.0;
        Tue, 01 Oct 2024 19:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727836487; x=1728441287; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94naYpv079to4aDULVCz9OCsch+/fu1zXqCOaX8AqZQ=;
        b=dYKn2KFiEnBL+VPKNo9iNarY59c2WY7NUb42HBl3enHGvII/faGVKr780ZZPqIhIYW
         A/k5G92d/VfLn4Pne7mXfEhjsK06nHuc4wJYdnVdSVKLz4sxUnA4SPaQc6EOuW4bSR8R
         Kp8oyONL2G4LOKn+ugnFzhGKPp2Tpp/rUNWpo1whvFUJlzH82dWDMSe6ESd9NGZxrbqF
         cYM+1+5+VbwGGgf1JAMnBN5KrfCvql9gS1FfGQp1PiqWEKikZWf2113xMCSYa/qlmMgx
         shlQs7yZ70GMyuG3rObZOJmyVGiFqKhnAmZFqCHsn1104/aILr1xL4DG583E9THyLfRz
         wzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727836487; x=1728441287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94naYpv079to4aDULVCz9OCsch+/fu1zXqCOaX8AqZQ=;
        b=uBNK7gIzFh7kainrCwFaTMHYL4R18WNRDpLk1UFBWmIMftN++RY4GiO2stPf6lro9c
         Z5IPlKbveBPg+GVWtn8+23NOo1NL0q/VER3YHUre8bz6QY1rhtS7BtR41iMGREUdwc4a
         okO05T1xLe2v+4NSO4nIRsqyJg3CUVlKqgwArjrKBlP0FiZm9pUV5rKbshE1VQdnKANB
         GB9Jq01IFAKEBiId7GVxueqETVNfmYm4CPSnkRUv+qC0jzb8y1nkeyzk1OnkYsvSgiYI
         91cajtljxAJ+0zggmAgNrw1pZYMkuLWLTvAHN2OQOrh6/ssBNQOQJ4U8zeEVyYZSXYqL
         qUjA==
X-Forwarded-Encrypted: i=1; AJvYcCW7RFX3H4GxzRs8+1Zx1NhNPEFw0+WOo96LFl8Bm0kU01t+YLV18CpSrgdJDm/793YzrF8=@lists.linux.dev, AJvYcCXqK6shTHyaaiYV9cLXCAqCHK2lMzg8V6uWGvIHMcHNDuEOXm5cuDilo4S2jkY0iU47aao/OCc=@lists.linux.dev
X-Gm-Message-State: AOJu0YyRUMVg+bvEYyuAg3vJJqWOGwofQSuAXhZoNOmAwGyiY7PXDlCk
	Yd3k8SLK+Xxgvfpm9Cc4+7NRDV6VhRRxP8EMEaRVfr+qdJKH2amB
X-Google-Smtp-Source: AGHT+IF9UFJBsbcmQi++iX6HKeBG+ku6eNZRFQc3F4zkIg3OMASXuELxeSEfBVyfvWUc3NyPSynvqg==
X-Received: by 2002:a17:902:e844:b0:20b:b132:4df9 with SMTP id d9443c01a7336-20bc5a01fa5mr17029495ad.34.1727836487138;
        Tue, 01 Oct 2024 19:34:47 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:50d1:daaf:4d8b:70e8? ([2409:8a55:301b:e120:50d1:daaf:4d8b:70e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b5b167128sm58750135ad.283.2024.10.01.19.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 19:34:46 -0700 (PDT)
Message-ID: <33f23809-abec-4d39-ab80-839dc525a2e6@gmail.com>
Date: Wed, 2 Oct 2024 10:34:34 +0800
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
 davem@davemloft.net, kuba@kernel.org
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
 Andrew Morton <akpm@linux-foundation.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com>
 <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/2024 9:32 PM, Paolo Abeni wrote:
> On 9/25/24 09:57, Yunsheng Lin wrote:
>> Networking driver with page_pool support may hand over page
>> still with dma mapping to network stack and try to reuse that
>> page after network stack is done with it and passes it back
>> to page_pool to avoid the penalty of dma mapping/unmapping.
>> With all the caching in the network stack, some pages may be
>> held in the network stack without returning to the page_pool
>> soon enough, and with VF disable causing the driver unbound,
>> the page_pool does not stop the driver from doing it's
>> unbounding work, instead page_pool uses workqueue to check
>> if there is some pages coming back from the network stack
>> periodically, if there is any, it will do the dma unmmapping
>> related cleanup work.
>>
>> As mentioned in [1], attempting DMA unmaps after the driver
>> has already unbound may leak resources or at worst corrupt
>> memory. Fundamentally, the page pool code cannot allow DMA
>> mappings to outlive the driver they belong to.
>>
>> Currently it seems there are at least two cases that the page
>> is not released fast enough causing dma unmmapping done after
>> driver has already unbound:
>> 1. ipv4 packet defragmentation timeout: this seems to cause
>>     delay up to 30 secs.
>> 2. skb_defer_free_flush(): this may cause infinite delay if
>>     there is no triggering for net_rx_action().
>>
>> In order not to do the dma unmmapping after driver has already
>> unbound and stall the unloading of the networking driver, add
>> the pool->items array to record all the pages including the ones
>> which are handed over to network stack, so the page_pool can
>> do the dma unmmapping for those pages when page_pool_destroy()
>> is called. As the pool->items need to be large enough to avoid
>> performance degradation, add a 'item_full' stat to indicate the
>> allocation failure due to unavailability of pool->items.
> 
> This looks really invasive, with room for potentially large performance 
> regressions or worse. At very least it does not look suitable for net.

I am open to targetting this to net-next, it can be backported when some
testing is done through one or two kernel versions and there is still
some interest to backport it too.

Or if there is some non-invasive way to fix this.

> 
> Is the problem only tied to VFs drivers? It's a pity all the page_pool 
> users will have to pay a bill for it...

I am afraid it is not only tied to VFs drivers, as:
attempting DMA unmaps after the driver has already unbound may leak
resources or at worst corrupt memory.

Unloading PFs driver might cause the above problems too, I guess the
probability of crashing is low for the PF as PF can not be disable
unless it can be hot-unplug'ed, but the probability of leaking resources
behind the dma mapping might be similar.

> 
> /P
> 
> 

