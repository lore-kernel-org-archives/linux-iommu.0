Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A695FC19
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700203; cv=none; b=mJDG2NEkYY9FiTG3q7DbNBNrVFl3zTf0VlueMUpF14lzj1khu0EH1LJdOHREwnDmvYv5+ItB3NcHb9m1lWRESYS3+jdlr9Nj6a9P+4aFd0O5sqjq2vJ/DMB0YR3JiQl7fafumEpEQMduFMblsHLzsEOSzo8/HqZZlSovYvMoS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700203; c=relaxed/simple;
	bh=RKeSGwVWMd/kRozhUIAFCmzXmnNvyig96sBUiNLx3S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZSH0SLNhX3ctfIY6F908IgcRiZg8wTd1PDmscyoyCoBy1vthF8WrxTG/UnCY7kEBJmT0y7AJ+kMxuMFV05NIU03n/xu7hr+nQiEXz/wLVtj+q4Jn9ukASirdDLJdZGuS2BoMaGSFeQQlnz+vY7aKfmTEdM6PPEetkB3nrrmWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTaLSjx4; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTaLSjx4"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4df0bf2db8fso644857e0c.1
        for <iommu@lists.linux.dev>; Thu, 02 May 2024 18:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714700201; x=1715305001; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrFyQBGNythIvg6X/90l73Utbc1IO7PWL/H9UUkOuvA=;
        b=jTaLSjx4ThtuGOmY8Z9KWiTp0PeCoCjute/gHsN3lFZS4wWCfbrFU9ZxSTjl6E84O8
         6clK/h9LYrA6VJwD5UD9DKHu1Hks0snFgEeLkLfOH7pi9Hrgy7wLvUp5/xh/T3nlAT3W
         pXBfWnHvG6+jsOmae7XP6xu6dFdoPRLAjxJCFO8ZfydIV2zUolOLUERDEZYjhmRWrVWy
         zYkBHZ4ZEBo+rZWlbs+1u5HnEUGKqPKFTKSzmjIIA9uIpCFJeZWcc2VFvnANQmu9Lp0R
         plaRE2sxtXth0PAkAdyvYjv6jNjB6MuJjotpSVrBbcHj/dvk+DXSrUe0S9mtrzBt0ToZ
         RTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714700201; x=1715305001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrFyQBGNythIvg6X/90l73Utbc1IO7PWL/H9UUkOuvA=;
        b=WEUg/hKpmxqLaUMN9Ehx2qfC8RiRycADQEgpRyedGYdI7PrhUYRcumtS0y9TFEWbCe
         pFPGmqaK0p+Rbg71r6ocqLEkcLKok5cUzumWdHeH0ZfLnUO4oQfDkEvzM9KmUsuny/IX
         yAshf7e5uCB7CS7SfL3gPVFuzm6KDK55wXBIOl4KA0JUo5NVA9tOYGTTyJGEcliN4XyO
         tPDBfZPK5rJyVnxYwjHyEsy9+PixPnSsEdbWtHbhgLQKCB80dWxMNMDJ/XUdJzG5efTc
         CxXKOb0mrxA+y7CGaHIaaRkY/JbkT9XEDN6qcZBiZfZYpgQumENy8oIy1T4xJ4GMcvVl
         ZT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8/N3B2YE2NtyW5NA2bmdW5atGh47VA1sDMyGWtp556qjVTSGuNapqvkd0XpyBFouWt0fy3RNIuGrTbIzNN3qVYME1IiY=
X-Gm-Message-State: AOJu0YxXumavtCNRKZ9vrnSont5ZdwC7pZxA13Viw3C3aI9H0sFEyLk8
	L6BWvt/tTFzblzMNqh1gV8JpnOjbB7NbOXqWgzE6+g1w+u+eWj4biUT9dMWmkc8756qm/m0L/mF
	Vy782kaTDrL7lhxP69VpQz4mxPgg=
X-Google-Smtp-Source: AGHT+IHhMmjUuWPdCPTy+Ube8hlzNh3C48it5jM9NxcPeKrEiHu+1RTJ82EoLDet+hq4ITJpu4qrY8AkGZ3kbXfppNk=
X-Received: by 2002:a05:6122:459b:b0:4d4:20fa:eb0c with SMTP id
 de27-20020a056122459b00b004d420faeb0cmr1725015vkb.5.1714700201313; Thu, 02
 May 2024 18:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240502161827.403338-1-pchelkin@ispras.ru> <20240502161827.403338-2-pchelkin@ispras.ru>
In-Reply-To: <20240502161827.403338-2-pchelkin@ispras.ru>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 3 May 2024 13:36:30 +1200
Message-ID: <CAGsJ_4yFzR2RYBsLX2oqUHZpzySfT=0rtt6F71hkbFp1iqxCAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dma-mapping: benchmark: fix up kthread creation error handling
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Xiang Chen <chenxiang66@hisilicon.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Barry Song <song.bao.hua@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 4:29=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru> =
wrote:
>
> If a kthread creation fails for some reason then uninitialized members of
> the tasks array will be accessed on the error path since it is allocated
> by kmalloc_array().
>
> Limit the bound in such case.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DM=
A APIs")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

>  kernel/dma/map_benchmark.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 02205ab53b7e..ea938bc6c7e3 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -118,6 +118,7 @@ static int do_map_benchmark(struct map_benchmark_data=
 *map)
>                 if (IS_ERR(tsk[i])) {
>                         pr_err("create dma_map thread failed\n");
>                         ret =3D PTR_ERR(tsk[i]);
> +                       threads =3D i;
>                         goto out;
>                 }
>
> --
> 2.45.0
>
>
