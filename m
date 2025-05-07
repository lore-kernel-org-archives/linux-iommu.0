Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433AD143C61
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582738; cv=none; b=B8YGgl9qoVe4TP2fpUTAqJ0d2Jx/kdSpatOmqMINxCumnRzOwzDa5vOQ/S0DF5jXA/nVaXZPHWC729L2UaB+7GTknUfbG83vHWtdfMSX6kW8yBS+aBIk65G0sP2Eb/xk1WvhQuNf2yb9J5vyryY6HqTlbH/GvTZCSSWaMHhyZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582738; c=relaxed/simple;
	bh=zkDJw9GvZlN+rb2GUh2GDAIlyl/U+0gEGbTsPhY4Cuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXIrSrgpILF1Z5PA5X1EC4f52GKICJQHJf1hCNvi0eattD3Ry5cwyEiwSjvsTQNBURIxeekL4ov5LsLRYElHi8nrbYWalh/Ynnt6xK1Hf/WMAK2s1S88Q4DHiOv2kBgRDGLybHVA8dfwZgVAg5nxITM0QtIGOVHGRZLmKmIPpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgeR4qf/; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgeR4qf/"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52b2290e292so720115e0c.3
        for <iommu@lists.linux.dev>; Tue, 06 May 2025 18:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746582735; x=1747187535; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX6DqnExx/DUQA6URdGCU9AcixoGmyM3nBuzLQT2WFY=;
        b=IgeR4qf/PK3wKxUKCFTzdS1p9pcmT5646uiHA6QxI1qOVAQjwNKNBPaQZIPj1R63Wr
         AL5tts+aZ5yvAeIqKqY5kLn4ilistOf0f5cGUoWFnqEnKfgUM8TE+RXdY37vxgpjPvms
         6n9YmIQd8ER0NoryqjnM+Xi0BHOQ1Z2iIX/taZV1dW9PPuxOsfNQngveoMmascAiObxE
         J3mUSJay9b6KUusVMGuZIVl3WTwgGCF4unEqx3Dwlxy9vOUGNBcVH4IDV1bY3AsPF+nh
         QEB/U5wBY/xVihBPDHr8hNwgkFz0MWBwXR6oOZ4qu/b9AqXYCXJMapaVFAKDEwWm0wnV
         c1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746582735; x=1747187535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX6DqnExx/DUQA6URdGCU9AcixoGmyM3nBuzLQT2WFY=;
        b=dRy87feFPlOhZOrw1COmy/3+GeyPzlr4S5POk4cqdFQ/VhrEQ07U+3I5UV8PEstpzZ
         Jfr/YRVfw5u0F3rUELyCD6J6UODL4JPDDueM1jfwJQCviJqeftKufR38rA7Fzqp32GI7
         c7R8kn/TmPLHxAn3mVqGK2KNMMN5DndUEczL5t+ebdYZrG4KslW5olBOjBslc9kmYFqN
         CfBYRYWqv0vG1T8bJATp7eLKcEq6LLYFQxbpOEsjEMMoiwYY6XqGIH48BQggWRzfPFBc
         mC+bLzSie1Xyx2sPKz0a873atPfdPEpkpipZyd/D2nj12owG+tqAuLJ++hAb0C4WGkQp
         w4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9XmClwpWQi17xG+yTqY7O6Qw1Xzr32swbqE+jKPNihIufIepH9UL+EEXP4EhkhuPnVes1ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YymZWM2DI2NFungFcSnXG5Az4StXOXcQwRwQuzGQ2GdApiEAIFs
	6vaTsbDW1sWNKDbtLqSFXvihiZtHS55PZRyr0HeXTcgGl0/GIrD9vwb4X1/OY94OaZ8Wa9n6td2
	1kcnPiIe7qpu6smFgfVxGunVbMpE=
X-Gm-Gg: ASbGncuj/nofi138w/bUeKx2WjAqbQnmSXnrV0TOQHYuGsgohDQffO9DA4CJAXVurnx
	zvtVhwLdzoYeh1if2nSEVuEBh05BJRq/rk2DiIlcL1luefXDULdK3n9qFjzsfSnwinRHzWMmYTq
	TAZx199Msb0lQJcy9A4O7t6ITz1Gaopry5
X-Google-Smtp-Source: AGHT+IHOly4zsMcU5xSwf/RTn890WjiHWEE+LXhkKE4dZQYH5w3dRH7T3JdglvK8E2gyidpry8SS3vNJ4NgWivbqw0o=
X-Received: by 2002:a05:6122:2202:b0:520:6773:e5ea with SMTP id
 71dfb90a1353d-52c37a8710dmr1203653e0c.7.1746582735020; Tue, 06 May 2025
 18:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250506030100.394376-1-xiaqinxin@huawei.com> <20250506030100.394376-2-xiaqinxin@huawei.com>
In-Reply-To: <20250506030100.394376-2-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 May 2025 13:52:04 +1200
X-Gm-Features: ATxdqUGX7CX82MmtEw1YibULEZk4DjAH2OOZCyfYNg35wWYStr5-60vTNSo0xKc
Message-ID: <CAGsJ_4zBz0oZGpP3dTzsjmw0oJbWm=vkKRS_kjBso7cvKJGjuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 3:01=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> wr=
ote:
>
> Fix a problem about commit (8ddde07a3d285a0f3cec, "dma-mapping:benchmark:
> extract a common header file for map_benchmark definition") accidentally
> removed that padding, which has completely broken the ABIs.
>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

Please add Fixes tags and cc stable.

> ---
>  include/linux/map_benchmark.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 62674c83bde4..2ac2fe52f248 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -27,5 +27,6 @@ struct map_benchmark {
>         __u32 dma_dir; /* DMA data direction */
>         __u32 dma_trans_ns; /* time for DMA transmission in ns */
>         __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a ti=
me */
> +       __u8 expansion[76];     /* For future use */
>  };
>  #endif /* _KERNEL_DMA_BENCHMARK_H */
> --
> 2.33.0
>

Thanks
Barry
