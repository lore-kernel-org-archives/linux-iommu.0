Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518E1465AE
	for <iommu@lists.linux.dev>; Sat,  8 Mar 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741437238; cv=none; b=k94SHrYWl1uKgLNpMk1WT79WzLaNU9zsJaeDNuR21Q+g/WAfc19lETZmUOs59h39djSLsSGk/4187Yo8DqK+sHuToJLP1uqQcWXE+T+g5wH2kAq9+fEQiOFxMH9fDCdcNC6O1Upb8PYBr79kCVt2LTj8ybh90NHkNMjmh5c8CA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741437238; c=relaxed/simple;
	bh=V/0SqlQacp+h4g7KCVIboICK9m0VGNB0L46HL+T24OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmERDbmTjlLoc2HkkB64h1FMcCuDwlrUml2BPxzRORYfDwjkOrZMKTQjqJH6dSWh2tpUIIIUomM4cKTDM4NZLgWeCt84Ctxu1MD72f/6k9iCV+p2BnFJMMudTs7U2a4mdcWWsAbxNcuElUathKl+LbDO7hNHJNdXLzZaR2Gr3m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgeadG5R; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgeadG5R"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-22185cddbffso70967175ad.1
        for <iommu@lists.linux.dev>; Sat, 08 Mar 2025 04:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741437236; x=1742042036; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrHqPe4qI/nAbruW3F2vRPvWp4Qoww7mexetKwU+H74=;
        b=LgeadG5RKp7U2O46dG07Ehs8zQ0HXOGoyJTsavd1C0zs6cEul7xXP9yrixk4MGhtgM
         tnZE598X2k9sq0+C9Qrx4/LAQFbIisKGwyvOnBmXj6XMO14S45CTjtkpv/iTVb11SdCN
         v+hQiHk/w75ZaA7/3AwclL2DveDwSmAPvQpWhEj76XstjY0gKO8tWXv+6vq99DvqUZ0H
         ckqDTW9ooqiWtd9hgp0gSdCuzUStZGUJDiKdR1/G1C03jg864459dl8uWytJ1dcKJLuY
         /Kxv59ZmL7K99kIUvmqiKgV9rzyhltIMyR5ZxPNIy9H1APYKoKqai8YNGLR+6Yd90TKR
         bQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741437236; x=1742042036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrHqPe4qI/nAbruW3F2vRPvWp4Qoww7mexetKwU+H74=;
        b=Cr4be1mCviTrvD0QE+C5RhIwnhuYntT1fOTrZ7FqnDbnRaj8J8PQrWVnTl+sTq/nZr
         MrnO0zStMhJMWB5cADqhlEh0tD6LvKYHze2fLsEU1JbaxDagAs9i1/Y/4xjfkA7B31Hc
         MnkUCYn4XKAq4IqCCdT6x1HK3fETzPEE+a/tQqfKBD4H32KtW1+2ltHtf8G/5KJ95ZfV
         DNuYB0PfxP+9XItzEW1siu+YN4wclT6Sz/rXrfqgNGjSMbeC5r/Zfe5jWJPo7Z+DnruN
         ExX0BkgBb7q2OOIKg+Bjz6HoE/v99mAIo7iTHvsWQJfBmkL6krFkEvwmLGF8toLFFWoF
         58jw==
X-Forwarded-Encrypted: i=1; AJvYcCUSZl5jxRe7dJg2W/06F+ucwR6YsKCd6siL285jebspr0BdywbR5kf1RWmLUjOSeYiuxN4IgA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+x5I0Sp6B475R3yOeanXIFKg/jjy+2I4HDGViAU+opWlHukaH
	ar7+SWZCYAh3z3UQrcVsQKAEDK7V5Vl8NDBsaTw1lXa68Z2a5Lac
X-Gm-Gg: ASbGncu30aEQg0WTY4yzwKrk2QUTSd3nX0F16B2f0KS5WI/JZI9aVuIZkfdipm03vQ6
	rSmLdNt425IM8FVn1EJbyTfZ8cH8AsurT12b6WtLyhGS3o5btAcwg7lstu4D5g4UOS3haYfEBsk
	+akv3ZEbI+DkF7jjsmjBSJHDSTgYHakzu2bmZ4oJzopcJaNIQGV70LTHiqEp1jCQPTAHXwPOSZa
	ciZQ3FtSvIA2Z7Cyk5oE3vHgzMMwG6VU0e64R9wafLeiSPUk2YRfmbbLrgVCiHycZ2ZHcjzA1f5
	Oa/SDsHJX+NaU3CAMIaZMtnJd6liJ+TuUoxoJNa2mwBczAL++TAOW0vSndP6f/eijpwFoDrGv39
	X5Ixqjg842ENhlZauf6CTTvbyMaxYs06+
X-Google-Smtp-Source: AGHT+IEq4oVqwhl+HcBlEEt5O5mLwczA0MCHU/VL6TVKG4WcVGMzJn/E2qe19p7uaCmDiiGmZcFF6w==
X-Received: by 2002:a05:6a00:816:b0:736:aea8:c9b7 with SMTP id d2e1a72fcca58-736bbf4af5dmr6123665b3a.2.1741437235636;
        Sat, 08 Mar 2025 04:33:55 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:9c19:1482:d401:437c? ([2409:8a55:301b:e120:9c19:1482:d401:437c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698450244sm4918282b3a.80.2025.03.08.04.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 04:33:55 -0800 (PST)
Message-ID: <40b33879-509a-4c4a-873b-b5d3573b6e14@gmail.com>
Date: Sat, 8 Mar 2025 20:33:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/4] fix the DMA API misuse problem for
 page_pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gaurav Batra <gbatra@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, IOMMU <iommu@lists.linux.dev>,
 MM <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Eric Dumazet <edumazet@google.com>
References: <20250307092356.638242-1-linyunsheng@huawei.com>
 <87v7slvsed.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <87v7slvsed.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/7/2025 10:15 PM, Toke Høiland-Jørgensen wrote:

...

> 
> You are making this incredibly complicated. You've basically implemented
> a whole new slab allocator for those page_pool_item objects, and you're
> tracking every page handed out by the page pool instead of just the ones
> that are DMA-mapped. None of this is needed.
 > > I took a stab at implementing the xarray-based tracking first suggested
> by Mina[0]:

I did discuss Mina' suggestion with Ilias below in case you didn't
notice:
https://lore.kernel.org/all/0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com/

Anyway, It is great that you take the effort to actually implement
the idea to have some more concrete comparison here.

> 
> https://git.kernel.org/toke/c/e87e0edf9520
> 
> And, well, it's 50 lines of extra code, none of which are in the fast
> path.

I wonder what is the overhead for the xarray idea regarding the
time_bench_page_pool03_slow() testcase before we begin to discuss
if xarray idea is indeed possible.

> 
> Jesper has kindly helped with testing that it works for normal packet
> processing, but I haven't yet verified that it resolves the original
> crash. Will post the patch to the list once I have verified this (help
> welcome!).

RFC seems like a good way to show and discuss the basic idea.

I only took a glance at git code above, it seems reusing the
_pp_mapping_pad for pp_dma_index seems like a wrong direction
as mentioned in discussion with Ilias above as the field might
be used when a page is mmap'ed to user space, and reusing that
field in 'struct page' seems to disable the tcp_zerocopy feature,
see the below commit from Eric:
https://github.com/torvalds/linux/commit/577e4432f3ac810049cb7e6b71f4d96ec7c6e894

Also, I am not sure if a page_pool owned page can be spliced into the fs
subsystem yet, but if it does, I am not sure how is reusing the
page->mapping possible if that page is called in __filemap_add_folio()?

https://elixir.bootlin.com/linux/v6.14-rc5/source/mm/filemap.c#L882

> 
> -Toke
> 
> [0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/
> 
> 

