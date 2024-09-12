Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3381AD266
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151140; cv=none; b=U6aD6e3GZkjm+KPtqaoanCSNWnEJnVN2tGHGmROdtxixNK3MsIw+Ah9cq79oYdY913w79HkZplGXuKC6EvABhVEZatD11fzPWr5Ve0nUElLxVBxloU+nVofd2VmqDAZhnZhu9rmexD66PKUOykc/mFSWARTsdyLDVLdTm/wUG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151140; c=relaxed/simple;
	bh=8OYqBuEjfe5EjdWcxDT76k63UIQ5ek8DyxYuIqau7AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAw+FPphgmOSPAdlI+lrvH9e26JOHJlDf1gwejKE4ezWJcL7ssExl3v/Gpsp/pZ7kqI04Dd6nLsjkwsRmwUakv3Ez6j2ZVxHZg5igAWQo4RjnpGCxIQHciKqZHpPVMLZLvFfhiKc+WeFYE/KiU77lPt5GxO58eu0/st2eE7zZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jljda30G; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jljda30G"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4582fa01090so281431cf.0
        for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726151138; x=1726755938; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwLc+XjyWhYA8wehQi12J7lKOf62muLl4QoZfdwa35k=;
        b=Jljda30GAVhWP5ti0Y6IijcCpaekYFXB7/sT7W4VjbJlI5JG4EWjxIAVX6i0ZJ8Miu
         miz1F9DujxRfrLUDUCdKFVsH6Er7H24s4KC1sR+0FOIvuBdCulHNYklMSIyBw8Ecjxv4
         x54JOWfQo2+VgHQxJ0djK/4jVUZxricFuDEDj3Q1++bLVmcd+HplgvlZ3t740Kzoyjzp
         SftZVLyjeKNGBuIzTERYy9nR4xErbWNpcM08qNPt4A5qgQ6DT10hY1zMC38dpDwwb/MA
         Q1r3UdeNbbKhjer4JOneZ1beMunEPRRXDFRJ5e1tDpzdzVnwUmZ95u2CfSXhNxeYyWn9
         8K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151138; x=1726755938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwLc+XjyWhYA8wehQi12J7lKOf62muLl4QoZfdwa35k=;
        b=NEjGycv8oYpV2khWcZ3aPVbPXHf7vzAB5MkonUkKzb5+1auw8yzSuRxXRXkeT8uv7w
         AUItQnUCqWVjDDZNGIa4Xn0YqYg690X8kTANrzZmNcSVuG0GLtW1sDUpODZBeRj+tFMR
         8CXWlD82isc2bXMWOAFVdJlBgW0/0gTOjP4TDoSOMkTzwZ6IxSiYgQilHnjOqzdoe+NP
         aHcfDkaC1J+qt56sWsHHI5iqcEihKgoa1bqHSNoSQLkNpEarvSR+KA+Hg7NgWfmF8Dox
         9c1G4cxVi/Hl7Gj3VP+eAnwBfaaYSOrNVcCBQcYTQGrf9NRC+Vp0ytmg+NsQBwRRrqPf
         I3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk8LEua3qIwDokKK1MgVsKMY/+e7QUgUnN6HQC7ZnJMQIUf//YcWOdGuHuDW01FeK/DAwXRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6d4+vz/3KnLCuXSzpN3aELMYzUmyac26VjRm7p0bP1TVif8xV
	2BLvn6Ihl8iDeM2tNIIPAyG+GEpoEUKu7+McRBFOOz+LPHOFkZiSYcG7W1RsO8huyCFj6poobRp
	BN7Anr1VJeg7t5jdhf3xnDBKBAF16GsUhYkuK
X-Google-Smtp-Source: AGHT+IFyltmncYSZz561uPWQsvsGb5DFmLf+mGb3Vo6WS5NNhJE43ms4WKqkq6D4X3fyD6kxk1+1bYCNn1kURkFiU6A=
X-Received: by 2002:a05:622a:202:b0:456:7f34:f560 with SMTP id
 d75a77b69052e-458608812bdmr4020001cf.22.1726151137360; Thu, 12 Sep 2024
 07:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240912124514.2329991-1-linyunsheng@huawei.com> <20240912124514.2329991-3-linyunsheng@huawei.com>
In-Reply-To: <20240912124514.2329991-3-linyunsheng@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 07:25:23 -0700
Message-ID: <CAHS8izPc8fy08mL1RJtnxiOvTx=Uk037Q5SKobC80jQocEKMJQ@mail.gmail.com>
Subject: Re: [RFC 2/2] page_pool: fix IOMMU crash when driver has already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	liuyonglong@huawei.com, fanghaiqing@huawei.com, 
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
	Andrew Morton <akpm@linux-foundation.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 5:51=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Networking driver with page_pool support may hand over page
> still with dma mapping to network stack and try to reuse that
> page after network stack is done with it and passes it back
> to page_pool to avoid the penalty of dma mapping/unmapping.
> With all the caching in the network stack, some pages may be
> held in the network stack without returning to the page_pool
> soon enough, and with VF disable causing the driver unbound,
> the page_pool does not stop the driver from doing it's
> unbounding work, instead page_pool uses workqueue to check
> if there is some pages coming back from the network stack
> periodically, if there is any, it will do the dma unmmapping
> related cleanup work.
>
> As mentioned in [1], attempting DMA unmaps after the driver
> has already unbound may leak resources or at worst corrupt
> memory. Fundamentally, the page pool code cannot allow DMA
> mappings to outlive the driver they belong to.
>
> Currently it seems there are at least two cases that the page
> is not released fast enough causing dma unmmapping done after
> driver has already unbound:
> 1. ipv4 packet defragmentation timeout: this seems to cause
>    delay up to 30 secs:
>
> 2. skb_defer_free_flush(): this may cause infinite delay if
>    there is no triggering for net_rx_action().
>
> In order not to do the dma unmmapping after driver has already
> unbound and stall the unloading of the networking driver, add
> the pool->items array to record all the pages including the ones
> which are handed over to network stack, so the page_pool can
> do the dma unmmapping for those pages when page_pool_destroy()
> is called.
>

The approach in this patch is a bit complicated. I wonder if there is
something simpler that we can do. From reading the thread, it seems
the issue is that in __page_pool_release_page_dma we're calling
dma_unmap_page_attrs() on a pool->p.dev that has been deleted via
device_del, right?

Why not consider pool->p.dev unusable if pool->destroy_cnt > 0? I.e.
in __page_pool_release_page_dma, we can skip dma_unmap_page_attrs() if
destry_cnt > 0?

More generally, probably any use of pool->p.dev may be invalid if
page_pool_destroy has been called. The call sites can be scrubbed for
latent bugs.

The hard part is handling the concurrency. I'm not so sure we can fix
this without introducing some synchronization between the
page_pool_destroy seeing the device go away and the code paths using
the device. Are these being called from the fast paths? Jespers
benchmark can tell for sure if there is any impact on the fast path.

> Note, the devmem patchset seems to make the bug harder to fix
> and to backport too, this patch does not consider fixing the
> case for devmem yet.
>

FWIW from a quick look I did not see anything in this patch that is
extremely hard to port to netmem. AFAICT the issue is that you skipped
changing page_pool to page_pool_items in net_iov. Once that is done, I
think the rest should be straightforward.

--=20
Thanks,
Mina
