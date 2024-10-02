Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB50194AD9
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857441; cv=none; b=lqnKaxu7g6ADs7gWevm1S2HbKjGDKGAkxmTR5MU52MMLiAirL5oSaqRWK+Ln+7kbAdHL93y4ozwfkdMEmxJx+FE5CHQ819uwhv00Q9R+uDUodMDBmUdvxGuM5dc8yEuJnCcXPjOIdNctUJk+ifn2e+kv8x4dIpWj6Op7Npprdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857441; c=relaxed/simple;
	bh=8qT8AJdSAevn7Lon301IIUYaxahlZK6BFR3I/iQhyNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxO0FJFheLM16qnoUDyrHjeloGh+4ws3pL+HNrrtVujavhzmnXvxpqFivCay8nlV9NQCm9ttMR+GXCPqv9Wgp3fxKljzgrg+FqavjVUandq4yS2FoU2dUDEXkyoN0nuvs94VcMfp12kq0/PNg10GWu5PEd3aib9rgKgtpgI1h4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BHW5lW5B; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHW5lW5B"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso428037a91.1
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727857439; x=1728462239; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qT8AJdSAevn7Lon301IIUYaxahlZK6BFR3I/iQhyNk=;
        b=BHW5lW5B2eWwX/ymaNnMH3EzHTMBPTPjbBfH8FFfBhcuirPABn8jVYPtsZYSLmIRc4
         SoRskx13nv+HiW+8bZ34pKV9Qt3f+sasEnUV6eIH1MO8o6xuGqh4nnN9pnWgAP4jd3pE
         FBA3OAzoPo/diWrG8UEeCJctjlA7AsHdodaTAWYR1SR9ZBj7YGs3B/uV3+oL+EmxGOgM
         E2kjuastt6ezELl2dDPrMm414wKwYCxZOd7lwKQgUsQueQeLzNhzcootfaLrMvJZP2Ra
         l2hCZCeCvGmZ4HsN5VBI5uUf7KYmuOEno9bGcPY3JDvSEEPTj3BJ5ByQ3v8NlglNqcCk
         jAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727857439; x=1728462239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qT8AJdSAevn7Lon301IIUYaxahlZK6BFR3I/iQhyNk=;
        b=bHY6+aFuibOLqjtDICZRmc4WluFyO62jLGB3oV8cHwiGSiC8lFJ18bK6SpMbC9JalP
         p/oo5S8v7RMkwYvsb3Rg8+8nsfRshTqFBnDCoyR/Fx4/9TToQuhBgTqTnX6TjFmMJBmw
         vM3om8zxSbGAtZx/8d3YtaUt99Q2kiS/PEji2X2/ctPGiet/5/H3bvuSeNYtZIEs1JBz
         KwPm/IInS1irhEWj86iB2a4WQyIjWabGSQ4IOz+rLt+kDj6MZ6AQEiqMtK0TQPPszEWq
         BmB3cCO5FsHFaRjHl6tw2GwiTkASKnchdKneICV1iz9Cq57tV6pG8lsHkhsC8dT+hjkr
         DQUA==
X-Forwarded-Encrypted: i=1; AJvYcCUWZ6sDtl/i4A/VW+Fq9JcLYAOeH3Eka3Q7ltpJnHtGxNBQIhY4im9qL3Bmn7sS0yYrQ4bYzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHlaHtWup8ejpBNvKvFHaakmzKRdD/Iu/8hkyeg0STmFiofS84
	OkFNpaJmBh70MkSjeCKBxEB70EyePyUqSFbxXTZ5jJ3vnQSjVyRrufhzYpBwnW+21d8/4u4GxSS
	eYIPnVgjiZelk+aCgUR9b/UGRlFQwSAFsQwB6Jw==
X-Google-Smtp-Source: AGHT+IEr1vFU0a1kvwV4sZXMH05Rcdg/y0G4x0gieaTwktCZi4DvPvG3W8WrO/0W27YGf2bHaceIX2iLNO+x3PuzjLM=
X-Received: by 2002:a17:90a:cb8f:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2e1851496c6mr3427473a91.3.1727857439139; Wed, 02 Oct 2024
 01:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
 <33f23809-abec-4d39-ab80-839dc525a2e6@gmail.com> <4316fa2d-8dd8-44f2-b211-4b2ef3200d75@redhat.com>
In-Reply-To: <4316fa2d-8dd8-44f2-b211-4b2ef3200d75@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Oct 2024 11:23:22 +0300
Message-ID: <CAC_iWjLBE9UY2wk_kKE=t=npRBF13HoLWODLUpQJ6F3P8sv4rw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
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
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org, davem@davemloft.net, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Wed, 2 Oct 2024 at 10:38, Paolo Abeni <pabeni@redhat.com> wrote:
>
> Hi,
>
> On 10/2/24 04:34, Yunsheng Lin wrote:
> > On 10/1/2024 9:32 PM, Paolo Abeni wrote:
> >> Is the problem only tied to VFs drivers? It's a pity all the page_pool
> >> users will have to pay a bill for it...
> >
> > I am afraid it is not only tied to VFs drivers, as:
> > attempting DMA unmaps after the driver has already unbound may leak
> > resources or at worst corrupt memory.
> >
> > Unloading PFs driver might cause the above problems too, I guess the
> > probability of crashing is low for the PF as PF can not be disable
> > unless it can be hot-unplug'ed, but the probability of leaking resources
> > behind the dma mapping might be similar.
>
> Out of sheer ignorance, why/how the refcount acquired by the page pool
> on the device does not prevent unloading?
>
> I fear the performance impact could be very high: AFICS, if the item
> array become fragmented, insertion will take linar time, with the quite
> large item_count/pool size. If so, it looks like a no-go.

It would be could if someone could test that. I'll look around in case
we have any test machines with cards that run on page pool.

>
> I fear we should consider blocking the device removal until all the
> pages are returned/unmapped ?!? (I hope that could be easier/faster)

Jakub send an RFC doing that [0]. Yes, this is far far simpler and
does not affect performance, but aren't we implicitly breaking
userspace?

[0] https://lore.kernel.org/netdev/20240806151618.1373008-1-kuba@kernel.org/

Thanks
/Ilias
>
> /P
>
