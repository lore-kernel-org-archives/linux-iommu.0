Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1973197A93
	for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657886; cv=none; b=GfUYI6PSXSCJNFrvzAVVILME6fi9puzo304rtI28Op6G+dDkOddzKFS0uhSL7XQzVS+rGeg+8qu+xqueb+7U3LEoBjtPU6hi4NNl2r+LpUEC800KAo6SIJAgbhKxGrvJ4m7BY7n4e+kQj6VYJp/xUxtJCJtIgSNNCmhXSQkEobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657886; c=relaxed/simple;
	bh=845xXqnB33nlJjULLO/nrCqGOfiZyHwIgYSmqaNLCHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScYU4joY2OOi3iMsTtxKEf8T0neZA7UjRTj5kMzmP+nyd/Goz5921dJNAYoM6o1MbeE1TfuP+firQagUcv2Y9TurVGBVtCuE0wLvDx9Y30dvwNDPFePmfZdXXBu0M3xa1ZPfOohNkm8hGkPD1saBz6NckzyZmqUpMnl+9O/8mGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M4GXFCQr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4GXFCQr"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4668caacfb2so24931cf.0
        for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 13:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732657883; x=1733262683; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n8OSPqRkLvx2KI0lecepo254y3Ft1HLiSCqdymG99Q=;
        b=M4GXFCQrWDUDXPtWX2A2vRizpyh5VdXQlFyFc7OdnKXl81kulPySYSGjC5O4OJ9p67
         i3O5UwGbcKkfYuqEyzWPTwYXVx6UJrMkXGpPvljzkOD7E/qB5ExxK67fPKqbzw7Mqwnv
         /4TBSB9sW5jnSfOvia/k6NoqvnCjCypGEx7+O5t/IExGZOlIRQ1riop4aj4+/ojqxTKZ
         NurtWuTTJuDZtHhp9jsWA+AipG0ES8ZGJrwpDYCLH0aUGNrJGnbtf6hMTjHVohvnIuCz
         wY5Jvbo/2hWD5YPYIR2V+ARyA3mTszOXcmrQZPp5DT6ZhQX/zcEwth2+2DSXf41N5s5y
         M1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657883; x=1733262683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n8OSPqRkLvx2KI0lecepo254y3Ft1HLiSCqdymG99Q=;
        b=m6UVehxEXSbAoB+O4RAeIvNCzi9u3dgnAjo8hE/+WfRaLSrnBroNAUEMY454ziFkWu
         hvibSNwb15eo7RCPXyz0ZeqqblGupR8E7x9kl4S0mos4zuDVmjDsuLrZdno3lWgtI362
         S4OpY8oIdDijlRXqNWC3iQin1xxJXnhvfyYVkVHvfulLIuXoj5pqsH7wIg0EVAbHOA3E
         Xm1aue65rBcvgeq2O51yfuEsVAgveyoKF9pUIJ0FIH9Maa72/XdV+REAW+n7z0bY3Pln
         atXopY7FHMUd4XB9qi28rRQBMeHPmTyNdFxF+BEcRKRo6umykXgzunKl5NCRES1xiD2x
         56Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUcZzXsQsONQkc+8mD5M4TzNnQAoYvCll00Q71+ekxUVK4JRKoOmxsrbUNdF69QW/Pgu2aZdg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4ADtV8+xQkc2Yj+vuOuQ6w3EmD1G7vGCnJ+NL4xIZs23d74JD
	HZtkRMAV/EBAiDcQAqX1MYUC2z7hmg2Zc+6Wxx2my09LG89LVMMnq0Ju7PlmYXC9NodV1EH+JDJ
	zcIcih+hD9iFb+Pezs2LlFJOpu1xPryFZMgbS
X-Gm-Gg: ASbGncv0QJMkAiEsmp6/mzFHtwH/2D+9+0JyBPcZ5x3If87r5k+bz/11XFt4IGDH9cg
	TSkM9inFRzVpcjRtDy32iWw2MR5j+nvzj17dIWHmCFungN7bqKGr+5h+JVcX0+Q==
X-Google-Smtp-Source: AGHT+IEEk5aN1eOwnEFKq2VpTSyQGdQBHpkfnICA0k0tDUjJ3oDS7OJn1bkFEhhsrwVy9UKRgNHio5nOyVpIPjmGRwc=
X-Received: by 2002:a05:622a:5e83:b0:461:48f9:4852 with SMTP id
 d75a77b69052e-466b3dc63bcmr655761cf.28.1732657883030; Tue, 26 Nov 2024
 13:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com> <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
In-Reply-To: <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 26 Nov 2024 13:51:11 -0800
Message-ID: <CAHS8izM+sK=48gfa3gRNffu=T6t6-2vaS60QvH79zFA3gSDv9g@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:03=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.c=
om> wrote:
>
> On 2024/11/20 23:10, Jesper Dangaard Brouer wrote:
> >
> >>       page_pool_detached(pool);
> >>       pool->defer_start =3D jiffies;
> >>       pool->defer_warn  =3D jiffies + DEFER_WARN_INTERVAL;
> >> @@ -1159,7 +1228,7 @@ void page_pool_update_nid(struct page_pool *pool=
, int new_nid)
> >>       /* Flush pool alloc cache, as refill will check NUMA node */
> >>       while (pool->alloc.count) {
> >>           netmem =3D pool->alloc.cache[--pool->alloc.count];
> >> -        page_pool_return_page(pool, netmem);
> >> +        __page_pool_return_page(pool, netmem);
> >>       }
> >>   }
> >>   EXPORT_SYMBOL(page_pool_update_nid);
> >
> > Thanks for continuing to work on this :-)
>
> I am not sure how scalable the scanning is going to be if the memory size=
 became
> bigger, which is one of the reason I was posting it as RFC for this versi=
on.
>
> For some quick searching here, it seems there might be server with max ra=
m capacity
> of 12.3TB, which means the scanning might take up to about 10 secs for th=
ose systems.
> The spin_lock is used to avoid concurrency as the page_pool_put_page() AP=
I might be
> called from the softirq context, which might mean there might be spinning=
 of 12 secs
> in the softirq context.
>
> And it seems hard to call cond_resched() when the scanning and unmapping =
takes a lot
> of time as page_pool_put_page() might be called concurrently when pool->d=
estroy_lock
> is released, which might means page_pool_get_dma_addr() need to be checke=
d to decide
> if the mapping is already done or not for each page.
>
> Also, I am not sure it is appropriate to stall the driver unbound up to 1=
0 secs here
> for those large memory systems.
>
> https://www.broadberry.com/12tb-ram-supermicro-servers?srsltid=3DAfmBOorC=
PCZQBSv91mOGH3WTg9Cq0MhksnVYL_eXxOHtHJyuYzjyvwgH
>

FWIW I'm also concerned about the looping of all memory on the system.
In addition to the performance, I think (but not sure), that
CONFIG_MEMORY_HOTPLUG may mess such a loop as memory may appear or
disappear concurrently. Even if not, the CPU cost of this may be
significant. I'm imagining the possibility of having many page_pools
allocated on the system for many hardware queues, (and maybe multiple
pp's per queue for applications like devmem TCP), and each pp looping
over the entire xTB memory on page_pool_destroy()...

My 2 cents here is that a more reasonable approach is to have the pp
track all pages it has dma-mapped, without the problems in the
previous iterations of this patch:

1. When we dma-map a page, we add it to some pp->dma_mapped data
structure (maybe xarray or rculist).
2. When we dma-unmap a page, we remove it from pp->dma_mapped.
3 When we destroy the pp, we traverse pp->dma_mapped and unmap all the
pages there.

I haven't looked deeply, but with the right data structure we may be
able to synchronize 1, 2, and 3 without any additional locks. From a
quick skim it seems maybe rculist and xarray can do this without
additional locks, maybe.

Like stated in the previous iterations of this approach, we should not
be putting any hard limit on the amount of memory the pp can allocate,
and we should not have to mess with the page->pp entry in struct page.

--=20
Thanks,
Mina
