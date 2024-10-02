Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D1188597
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727851607; cv=none; b=UguzzoNdgc8E6aK9tFCllxgcv+3cySPqoJA+5TEW90uopAaX3qFoPp51PK9oXTYkCC05vkn+h1kTEvgZnky7XM+GT9GbudLa6HTD3VWw13dG5KLnzH1yyArSlK2AAGMVrnM7ktS8T6UFkSJwTGAuMRlJpeD9qdi89Q5zf7cVy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727851607; c=relaxed/simple;
	bh=QohghBaWHgvEKjhP//39OdbypduFrYPoEqH6pqB/N9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBWXYYDAjAxa8nqSEoHLkCDiuD7/HDL56G+IFiBMumncYb8zLLqwGoRX+tOV4nHcAWa4k03x0PuPkN6aCFzcSxOLHhq12Ep2GKaPxQuFLeV9EkN6Va14HqY+VKCLNGV7hFJ6D0smJOxqqwDwYlsHtE3idTrwzCLwFvU1c28moJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PUbf4ee2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUbf4ee2"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20bb610be6aso15955675ad.1
        for <iommu@lists.linux.dev>; Tue, 01 Oct 2024 23:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727851605; x=1728456405; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=julty6rnHcSXHSDPw3px62HgLzdn2IBXQjTC66JT5PQ=;
        b=PUbf4ee2ZBTS7SKto+7Q/i+VqzY0DLKUX71Fq2u/erb7YesR94Rdn/zDd9/sCXwbUL
         nqawu6i0VAN/oT+wnbmPtca0gbTdIqM0kvxpeNyP3wJtRgOcpfLUhOLnph2u4VOFeHRk
         c795LVMF1zEbBCS7S35fsoe1QtKZXcvGvIfTMBmb2Ptc3XTnIdM9ta5mwIY3mUY9bJir
         7IEX2HLXEX67kR3s31s+1baUSUzu07u5tk6QR2o71whMKJx+5A3Esuvf5JExwxGjZhcJ
         dcqOtpaZqif2oKm+hNr7UNY8APVaV8oF0tZvK+WD7U1PeqD5QkNrlFXtV3013hr+FG6m
         Y2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727851605; x=1728456405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=julty6rnHcSXHSDPw3px62HgLzdn2IBXQjTC66JT5PQ=;
        b=CGwOJb66hMG4PhBH4Sw6VifqJ9+uG2ES1XYtu2LcYkgvEFobrf1sinaf7omKFXTHHi
         nPBA87nx73DusYlOWlcY5NLNrrcQ9Us/OSxZfoCFc6JANOsB3mXbEHdLHfjDgJEW00wp
         S6YBzUaDbno0Hm+NOFPdYF58BPZHEzSwoKOBuDxPxQwQ+4WpHsryYTal5bIzv0gY8PdB
         TSjToa6zief15Wt1ZTaLU0Hy9xYv7R+zRMVU/8VFLe1DgGdwDgZdJqaZcDzxLI7QG0s0
         ilcPz6IFqVslpCMyJaR+EnVxWiiaqvLxviYkA94v/s7rALjRZpgtJZg2v9kXMoP4lMSe
         r8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUYtuW2ZanhQNMKbbiib2rGQh9w+EtOP+LyexqfuvSEd5oUmJmTJg2RkeKwvOgwaKZ4kFIo5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya9CXi0rD9O3yyz8eDmv4iLtjqvk5wlYFzgdMZH/pDjQzSKCm/
	ADNbGo3VgIv94fWtdDkwBPr8Ni0hIsbZbCUZ2EaJAmR6caF7QuynGkcX9X3m7p6eK98IffAvGe8
	qtK15s6oBneJUe1h+MjktbEcLJUz5duKJRwI3xA==
X-Google-Smtp-Source: AGHT+IFQFeN+13hsSVg8HfZx3v0JFKL/2OojczRKBuzwXMASAbyeLF4dgYHBH+F1NmuIXohzp3j20fi5PB1R6+vYJtE=
X-Received: by 2002:a17:902:d505:b0:205:4e4a:72d9 with SMTP id
 d9443c01a7336-20bc59efb2emr41817915ad.7.1727851604719; Tue, 01 Oct 2024
 23:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
In-Reply-To: <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Oct 2024 09:46:08 +0300
Message-ID: <CAC_iWjKHofqDrp+jOO_QTp_8Op=KeE_jjhjsDUxjRa4vnHYJmQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	IOMMU <iommu@lists.linux.dev>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
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

Hi Paolo,

Thanks for taking the time.

On Tue, 1 Oct 2024 at 16:32, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 9/25/24 09:57, Yunsheng Lin wrote:
> > Networking driver with page_pool support may hand over page
> > still with dma mapping to network stack and try to reuse that
> > page after network stack is done with it and passes it back
> > to page_pool to avoid the penalty of dma mapping/unmapping.
> > With all the caching in the network stack, some pages may be
> > held in the network stack without returning to the page_pool
> > soon enough, and with VF disable causing the driver unbound,
> > the page_pool does not stop the driver from doing it's
> > unbounding work, instead page_pool uses workqueue to check
> > if there is some pages coming back from the network stack
> > periodically, if there is any, it will do the dma unmmapping
> > related cleanup work.
> >
> > As mentioned in [1], attempting DMA unmaps after the driver
> > has already unbound may leak resources or at worst corrupt
> > memory. Fundamentally, the page pool code cannot allow DMA
> > mappings to outlive the driver they belong to.
> >
> > Currently it seems there are at least two cases that the page
> > is not released fast enough causing dma unmmapping done after
> > driver has already unbound:
> > 1. ipv4 packet defragmentation timeout: this seems to cause
> >     delay up to 30 secs.
> > 2. skb_defer_free_flush(): this may cause infinite delay if
> >     there is no triggering for net_rx_action().
> >
> > In order not to do the dma unmmapping after driver has already
> > unbound and stall the unloading of the networking driver, add
> > the pool->items array to record all the pages including the ones
> > which are handed over to network stack, so the page_pool can
> > do the dma unmmapping for those pages when page_pool_destroy()
> > is called. As the pool->items need to be large enough to avoid
> > performance degradation, add a 'item_full' stat to indicate the
> > allocation failure due to unavailability of pool->items.
>
> This looks really invasive, with room for potentially large performance
> regressions or worse. At very least it does not look suitable for net.

Perhaps, and you are right we need to measure performance before
pulling it but...

>
> Is the problem only tied to VFs drivers? It's a pity all the page_pool
> users will have to pay a bill for it...

It's not. The problem happens when an SKB has been scheduled for
recycling and has already been mapped via page_pool. If the driver
disappears in the meantime, page_pool will free all the packets it
holds in its private rings (both slow and fast), but is not in control
of the SKB anymore. So any packets coming back for recycling *after*
that point cannot unmap memory properly.

As discussed this can either lead to memory corruption and resource
leaking, or worse as seen in the bug report panics. I am fine with
this going into -next, but it really is a bugfix, although I am not
100% sure that the Fixes: tag in the current patch is correct.

Thanks
/Ilias
>
> /P
>
