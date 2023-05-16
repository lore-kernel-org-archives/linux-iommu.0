Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122C79E0
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 19:42:09 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-55a14807e4cso250376157b3.1
        for <iommu@lists.linux.dev>; Tue, 16 May 2023 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684266129; x=1686858129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSVEdvfoE0NUvW5V33KiQS8L9RpD2sackPRopDcvPwE=;
        b=SNLgzOql1dtAOa25t+JwnKc6KWkWjPXrHtQbeHGO+c4RB8ouqPaaR72cUjJan7sAbu
         kL0iLRykj6ryell+8/70lbSeGtmHAHYtK8lJKZ//CvvpTCdlgKiRGXsOVFQ9EDDtQGVB
         fAW1lTt1PUYUxcep6bTOavqM4A+1gSEwRP4JsnX1AdjtAtCLdUy+AsYme97+ytk/9/7b
         5L1XkYxErCMcWoJH8BnrHkDZF/uo+X8K++kCNw9Bd59BUkkuUD49ziuOahYCwf1lExyu
         dh0DUkqxfVm2yxbVDSA7QpjtC752jM5eYxid5230oV4am7giDUa6mqkLKS+cfsnwSxpP
         LVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684266129; x=1686858129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSVEdvfoE0NUvW5V33KiQS8L9RpD2sackPRopDcvPwE=;
        b=ENvYDsy1tgleFvpCTrAeg5lSDULOS015QATTmtYl2+KZ1R2fFJmapEtcVx1zCVH1Ma
         JSGtjSwPRd8RyeskFJv1rzhi7vRuHDZP4Irt8DzAYHa5fhK9Xbyvlf0N8J8zfSoDgRGc
         IfsBgeB9zhqnRKYL06rrWFT+YKBsM5+tER4NwsLO7jDNvHxg/tNHq2Fllpi5ISuBGDl7
         y7RPU5v9XH82fIQkCLiT5M45i8rbd998tLBmuvXJaBWX4hnRS8hwfCzMkTDru2G0Qfnl
         d0yu7rBhkX131uN6106GninWZlXHFroPtY33BkXycpEPKH8Icz9Yptp2HYnX5HCoFjIN
         DueA==
X-Gm-Message-State: AC+VfDx1FpQv+W+Y0evXAaobW8s9EGEOFd7JIwOxJSFVvtOxKF6cTU66
	zAOZ1pYzMGO/+qOQ0HqasgOvMnip8fYw90k1/5oOEA==
X-Google-Smtp-Source: ACHHUZ5IjLWNrA5KAMjnxOuxBzdh5Srhi6z385N8RdZH7DOKNSGk6Bwy4ByuDZYp2+0YzOABrupx+f6k8dXErhFHLd4=
X-Received: by 2002:a0d:ffc1:0:b0:561:3fb7:1333 with SMTP id
 p184-20020a0dffc1000000b005613fb71333mr9398994ywf.43.1684266128865; Tue, 16
 May 2023 12:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <18448ae569e24dfd84e811081ede376f@hihonor.com>
In-Reply-To: <18448ae569e24dfd84e811081ede376f@hihonor.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 May 2023 12:41:56 -0700
Message-ID: <CAJuCfpEMqLUePoqaQYKOK5OTFGHft8igg+NZ-R1qrudNJ5VmSg@mail.gmail.com>
Subject: Re: [PATCH] dma-remap: Use kvmalloc_array/kvfree for larger dma
 memory remap
To: gaoxu 00016977 <gaoxu2@hihonor.com>
Cc: "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	yipengxiang 00013268 <yipengxiang@hihonor.com>, wangbintian 00013160 <bintian.wang@hihonor.com>, 
	hanfeng 00012985 <feng.han@hihonor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 6, 2023 at 12:33=E2=80=AFAM gaoxu 00016977 <gaoxu2@hihonor.com>=
 wrote:
>
> If dma_direct_alloc() alloc memory in size of 64MB, the inner function
> dma_common_contiguous_remap() will allocate 128KB memory by invoking
> the function kmalloc_array(). and the kmalloc_array seems to fail to try =
to
> allocate 128KB mem. work around by doing kvmalloc_array instead.

On systems like Android it's not unusual for order 5 allocation to
fail. The change seems safe to me with no downside since kvmalloc will
try kmalloc first.

>
> Signed-off-by: Gao Xu <gaoxu2@hihonor.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/dma/remap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c index b45266680..275=
96f3b4 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -43,13 +43,13 @@ void *dma_common_contiguous_remap(struct page *page, =
size_t size,
>         void *vaddr;
>         int i;
>
> -       pages =3D kmalloc_array(count, sizeof(struct page *), GFP_KERNEL)=
;
> +       pages =3D kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL=
);
>         if (!pages)
>                 return NULL;
>         for (i =3D 0; i < count; i++)
>                 pages[i] =3D nth_page(page, i);
>         vaddr =3D vmap(pages, count, VM_DMA_COHERENT, prot);
> -       kfree(pages);
> +       kvfree(pages);
>
>         return vaddr;
>  }
> --
> 2.17.1
>
