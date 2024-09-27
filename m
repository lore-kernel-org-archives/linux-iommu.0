Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598F175D53
	for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431175; cv=none; b=o3jZp5rUBHNdJIm2OOpArNhrevyeuaDE43T5fq95rQEOdUvNXYv4tKCeAX2RulUg1TU1SFMI9Wci6fEhQvcoKqrLoKtWUYcKW5gzf8KbjylRE4Bg6GDmZPrvbjEyngSiAmIRjjvZ6RsJcCTxVoNdRM2eiPwDp+iGXKHmd1VJFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431175; c=relaxed/simple;
	bh=/wFHvQrnJe6+I0Hk404NsRdbI8eFHq8tb62kLJdsI/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCXIjMF+zu5ps8yKTbZPdz9O0BftgtZ687VnMU3hvlsozjFi4pB0cSj7GBqBjgttvqoZR69+1Lies1Mp2s1cQa7rIN91CRdnbWebUvs+eS2/wDWrxbksemjjJn+luQUkr7ZctMOyPzKRPhXeEI50xEyERUc+cxtQUYKtlR4yg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=avSCPk5E; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avSCPk5E"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so1274212a12.3
        for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727431172; x=1728035972; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wFHvQrnJe6+I0Hk404NsRdbI8eFHq8tb62kLJdsI/o=;
        b=avSCPk5ENVTWSavk7hYIZWqYh+x3UBGZGxEiDTR6zVl5pm77JjtSlFrEq2OrFOKncT
         pvuUDkFUh1BoIevVb5mqRzHh2Tgf/rMJxLWbDPxNXtApZhVtUx6vS5Hgb9pISrxTYPZ1
         KC2c106qIV6n6q7MMoPsQRDzJLJ6XjniBMVbJ9VI3TD6H74zF9aQ8XoPGTC91bfplEFi
         CJfq8QKlip07jKR1qj3B4gPNImAJHfSjXNIFAIBpeSzNv92CToaabU6gYlT2yznlnx0l
         RYveA+fn4r9jO4INqKd/c4Zb7EzMr8GWWXspiJBmxm7eOIKamBmZbFkHOE7X/0vb/y4d
         QS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727431172; x=1728035972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wFHvQrnJe6+I0Hk404NsRdbI8eFHq8tb62kLJdsI/o=;
        b=S/xplOajcMJ0Vz8c+DHf0t8g1oGQWnUKTIUnBFg/M13YYzWoqdFLu+La4UeEMqfVMp
         w5Wq9kTyhutmfdsqx/NHMKf1FcfO7oODbd+voXU1R7AuPZx9HcpvcwA+wRtqYEf3au4s
         vjHiGZGLD3Wbb6P5gVTZJhoQSoKwD++QLWuIkKiITIAXfSImYtoO2zhEXn/AHAYxKK8h
         XZkSO6nC6b5uUubm8ydYpd2985krOGP/AxUrKqyVVJtcUSsXLfIrYjkiq4mrLTxNwC2b
         /8/OFGifztagqmwawAMtNqmd52KRi7Lv9rZPNsNx0fNEST8gZrTOhXWWxdR+mSbfn3sE
         sBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqfRnsIWNRVTfg7sOALX/BDZKQG9ELRLxbjIY8vSMYFd4wTD0PbblDFJdwyzgdgVy6l8ZObg==@lists.linux.dev
X-Gm-Message-State: AOJu0YySFR7nAXw84JGujBD5o0WsJVdnoo9R+E3BqIVxcmgITeTeG95P
	oaWvoQA+TK48ALDTGQousPIsTSmxSsH+Cwho3wdYKvya5iZu46jYcSLHxXx1XVVy5KGzyt4RNa9
	MG/RH+kl/Yyi/SPooxnSNjRuQpRC/143Erc8f4Q==
X-Google-Smtp-Source: AGHT+IFPw7TdHI7xAVBejSYDuXRNyLLxKTG1ESrzw48y3A/pOuf25zX23NWOfeE/8MxH7DAW+JoIMvACw7ATICsO3w0=
X-Received: by 2002:a05:6a20:6f03:b0:1cf:23cb:b927 with SMTP id
 adf61e73a8af0-1d4fa7a6f8emr3754825637.34.1727431171797; Fri, 27 Sep 2024
 02:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
 <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com> <CAC_iWjLgNOtsbhqrhvvEz2C3S668qB8KatL_W+tPHMSkDrNS=w@mail.gmail.com>
 <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com>
In-Reply-To: <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 12:58:55 +0300
Message-ID: <CAC_iWjKeajwn3otjdEekE6VDLHGEvqmnQRwpN5R3yHj8UpEiDw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 12:50, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2024/9/27 17:21, Ilias Apalodimas wrote:
> > Hi Yunsheng
> >
> > On Fri, 27 Sept 2024 at 06:58, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>
> >> On 2024/9/27 2:15, Mina Almasry wrote:
> >>>
> >>>> In order not to do the dma unmmapping after driver has already
> >>>> unbound and stall the unloading of the networking driver, add
> >>>> the pool->items array to record all the pages including the ones
> >>>> which are handed over to network stack, so the page_pool can
> >>>> do the dma unmmapping for those pages when page_pool_destroy()
> >>>> is called.
> >>>
> >>> One thing I could not understand from looking at the code: if the
> >>> items array is in the struct page_pool, why do you need to modify the
> >>> page_pool entry in the struct page and in the struct net_iov? I think
> >>> the code could be made much simpler if you can remove these changes,
> >>> and you wouldn't need to modify the public api of the page_pool.
> >>
> >> As mentioned in [1]:
> >> "There is no space in 'struct page' to track the inflight pages, so
> >> 'pp' in 'struct page' is renamed to 'pp_item' to enable the tracking
> >> of inflight page"
> >
> > I have the same feeling as Mina here. First of all, we do have an
> > unsigned long in struct page we use for padding IIRC. More
>
> I am assuming you are referring to '_pp_mapping_pad' in 'struct page',
> unfortunately the field might be used when a page is mmap'ed to user
> space as my understanding.
>

Ah good point, I just grepped for it and didn't look at the surrounding unions.

> https://elixir.bootlin.com/linux/v6.7-rc8/source/include/linux/mm_types.h#L126
>
> > importantly, though, why does struct page need to know about this?
> > Can't we have the same information in page pool?
> > When the driver allocates pages it does via page_pool_dev_alloc_XXXXX
> > or something similar. Cant we do what you suggest here ? IOW when we
> > allocate a page we put it in a list, and when that page returns to
> > page_pool (and it's mapped) we remove it.
>
> Yes, that is the basic idea, but the important part is how to do that
> with less performance impact.

Yes, but do you think that keeping that list of allocated pages in
struct page_pool will end up being more costly somehow compared to
struct page?

Thanks
/Ilias
