Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279FE274B3C
	for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348047; cv=none; b=ercjQlKglYBzmSwktxnz7JwLhJWPr4wGlKBTsM/rO3HgMUYoHtcJ8IKyxL2+BsVptAT5/upot2BvSXDhXzMscJ3A8cDJ/PCk8xlefYtlvvQTHsI5KnZbsCcU89zGAQ5lgJogr45ULxnW4jJ1g7aEPGZezikA2SuUnxZzi1RUKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348047; c=relaxed/simple;
	bh=zgMFLUq0fEmtCJ+2Gy519EI1Y1jQDENdFaSS0II49MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4mAOJXS3zB/f+HZwEb7FMFDfs4uwyilKnrT8pIOhTq9qatwEUHSl4FDvAm989fy6oRWUMSUsCpLvVu3e/o4RUx25IkduVFrXhexPnLvFupqmb9m/eIdgrIohThlNZ5yQqkMUAEN9LyOs/U1iSEv0QAJY8ZyzSR+tz2fqnSF3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu0L0IC9; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu0L0IC9"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5313eff2649so267810e0c.0
        for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753348045; x=1753952845; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9U1sLWBdhx1paPNTeFVGeHZUtaOkySwMikmcsZGJ3Y=;
        b=Uu0L0IC9fRoA2yWZxefKK+Nr1QIoPUZGRxo6x+ykcZ8il4L74/YJl0KGdAWlwilPnT
         5trHqdY35sgU4F6gxnZZB7FwY7+QeTFFQOcWXdSXK0wEGdnUxAOSINXJOIgzWJOiCT1Y
         4n0jdFanXBQ1duCD9L/zgu9/01gRujXqw3Jkg0WP3G+eCZ9Pfv2VBQZrJ6hIlekngI6f
         ZL701nqZv827/WdXWeg7KRXA5vLAtEj3Asec4KKE+Jc85wVImICXz+QPaUuY+GGx13bP
         /jVdTGhnKEj++2PuOYy/T77gya0outFijXN4QhjSRPhxO0mncYMmVYUXokj55V/Zy/Yn
         kH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753348045; x=1753952845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9U1sLWBdhx1paPNTeFVGeHZUtaOkySwMikmcsZGJ3Y=;
        b=OmqPzAial5XUPZRaupnrQmbkZa1MW1ETC0y70xQB+DXI8DFid+BWCNQrZBROmYU+Q3
         EwuVonL00nsuyXYCg8i8+bakyRvOkK91asR7q9IUhV4Y1n1qYoNOLjf8bLrYUuFc+zPu
         8QOl3ON8OxNQcAuraespBhBz3dS+XgaNE4/erSoeGh8krpVoMZVkQze7drg0k9KbTyH3
         SINoCJCT6zZRjjLUOKKIt4WF3GGHrJVt5cfvkwEJZNz8MJJEF3SFm6bhvm7IC7p/1/ng
         d8pp1J2fs8lexZJ56n65VkqSkXNkzASwXd+rOc+Av01wZXMUdUGyF1CUl8M/E/tfbkiz
         f5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWt6DmjIi/72snodfm++v7fiiibhg52n1ku1uWGQ2s/oAbNmLP5jFuDDf7DGpPiHi3hB2L5JQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH1bSG22iN9fx9Sh3csFcpATshtevfyk1zYokAg7NqT/EmCrnj
	nFd9MxiyDxGtsesc+RT1iwGzwMqGi1p01zVtwxa37YSurpBmElkcASEY1r7iXvb8Q/PRC2utTxt
	N7U+/iriZpMY/w/4J/Gt30eBnzXVsv5gY9LIq
X-Gm-Gg: ASbGncuWunjfatgStQOk6UJpcd73UeqilOo1pZL8B0/QIsFsGqp4HByEe9UhvGyCMJ+
	QEZPEiudwKZrZA2Qsga6T6tWEhwDTdMKudKltWprE1qJxAUZbJQGLTd80ngDb31U1olReV/d39m
	NZUIjc0EEkCxhSyByxWD1olIBySsgpFHma4R9hJ8RkeooyK5L1jLIkhNjVx0lgBbzQe/CNi2aGa
	uOIwubSjaaFl+jwcA==
X-Google-Smtp-Source: AGHT+IFKX+YT+nQfMVHoGIbnz5tCTBk3e35DhUZOmmPV1cNhlCz1oWMNfdF0SDe3luc5Mr/mRo1Wv8KWAB38eYODkMM=
X-Received: by 2002:a05:6102:3f02:b0:4dd:b037:d239 with SMTP id
 ada2fe7eead31-4fa1512033amr2994569137.14.1753348044722; Thu, 24 Jul 2025
 02:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250724085600.4101321-1-xiaqinxin@huawei.com> <20250724085600.4101321-3-xiaqinxin@huawei.com>
In-Reply-To: <20250724085600.4101321-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 24 Jul 2025 17:07:08 +0800
X-Gm-Features: Ac12FXwc8LEw1HxRHbIlcrvJWyoAZgmuRVg1-3tbipJDJAI81oWi9CrI61ErWbk
Message-ID: <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Qinxin Xia <xiaqinxin@huawei.com>, m.szyprowski@samsung.com
Cc: robin.murphy@arm.com, jonathan.cameron@huawei.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:56=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> The padding field in the structure was previously reserved to
> maintain a stable interface for potential new fields, ensuring
> compatibility with user-space shared data structures.
> However,it was accidentally removed by tiantao in a prior commit,
> which may lead to incompatibility between user space and the kernel.
>
> This patch reinstates the padding to restore the original structure
> layout and preserve compatibility.
>
> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header fil=
e for map_benchmark definition")
> Cc: stable@vger.kernel.org
> Acked-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

I don=E2=80=99t think these two patches should be part of the same series. =
This
one is a bug fix and should be handled separately=E2=80=94ideally picked up=
 on
its own and backported to stable.

Also, the subject should not say "Add"=E2=80=94it should be "Restore". I as=
sume
Marek can handle it?

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
