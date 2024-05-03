Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEBDF5B
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700704; cv=none; b=oWOjyDn/DVijwxBp472VKFv/xE2nkdqW3njM1uAfhI6tT5etdNGpe862Q+85LByKDptqgxcrVOSKB+5gAeCWWzfMKSFO3qpQONV5TMzY+K/CQC5VbufcIVNEGeiQXfeQi8ir4D+gmiNpRsrWRH+5d8wBhnZ5KI/0j2ThhOFp9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700704; c=relaxed/simple;
	bh=ey+G/MUCESd2sdoi0DGUPvdRUSE5ujEB7MzNjilZVjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMQEalvpJxU1rL0wtUttGVkk1mmiPylA/QUQpefJNV9Wzo8d4LghLzX/Clg3/HKS+/ru9WkCwjLo6aD1d9pxyAG5upP+SnwtVDcOy6cOTnvU/X5R5K0aTGl8KDRrrJXxUYdP/wMTQRXzaNnUznfyPaqzXqOVuirDbVYgYZPUwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elnZIeBY; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elnZIeBY"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7f395ac5b16so1128112241.0
        for <iommu@lists.linux.dev>; Thu, 02 May 2024 18:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714700702; x=1715305502; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBpaufwW255tHTakY+OCArHInOzRj+zykzi7grRdC1U=;
        b=elnZIeBY3cr5gt9W5ikUOUkTAvplqyhZAOPyNh55U0N17Vgoy7IcrBCt6bcYwyORXy
         wlSY0CdBUkS26r8oBm/KAVDs7FbPpDDfBYj3XYy0U18OwUPQqFBl94fGaQ1gBoNrDkAo
         iMtEDcBPlG5qmUX0DKOE96ThL+kFbhixdEBSl8E+34vpuo61I7M+s581+9EUskIjHAl1
         dg1642he72q9cztUWkb/e+G+f7z8J+r1Eg7SNIfi7BkJIFYbb40TnuAdFsO4rMujX7OB
         xA3YeTU9aHbqm47eCQsytY0efT5t2UZihqW8OgPa5lJpMAf7T2tzbdE90vD7VpgiLbqh
         pHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714700702; x=1715305502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBpaufwW255tHTakY+OCArHInOzRj+zykzi7grRdC1U=;
        b=SwyejrdkeNgYOP+2BF3mlq0UHJImHEYt8rFZeKSflXqrOk2UtNuEfnh15X0DcRFUfY
         JOdPoQajXLDwTfMtoEdD2+CiuQ43VSYcyWFU/Hamic11jsBPSuCwNRbi/9XT71xelq+8
         Uv2MTqy0aXalB+7rjU7dJ/4m4Xxak7M1FkUu/HArc5nVkCMS1WEcAiFfnOB2agxc2zQl
         P/p9smSkuvlZHjvvOeSdaKh0M6fAoC3vaboQvOIXD0WOuqDAX4GAsO0q+xTQ86+dVbpF
         qvlNwJJXhTN/BDLkhFuszVq3lOIjnOjB0JQbJqFxf27RGpFa8S6pIwzSvKML4rbXhQZh
         1iDg==
X-Forwarded-Encrypted: i=1; AJvYcCWPQR57EuC6eZFZ717HRg4uK7pjoIdEf2Hd96R7aOMZbPO9/s3fvWLR1Ek301f1MGRVWnx3JKR/JHHtvfu5qOCPSyfN8Gw=
X-Gm-Message-State: AOJu0YyGzVc3MsTg34IYu13LYmoKxcOkiflfQi7SzV3tCdhbp68nmqSz
	H3H+wyFGmmnFGKszU2o9BKiZTcmOFrXvD3mDNCH7gK+rgHqOwh+8TCUd/kWKyODCjvk+vrdJhaT
	YSmuQveXgF0anJwWspJ0Vhvcph8k=
X-Google-Smtp-Source: AGHT+IFZyWmBAJipXUPPt+Uv0QLkbPfwvtGgat1yYkY94P24DIj2C1Oirn7fshUPnUvtMM9lPCqJXhZGWJE6z4SC6r8=
X-Received: by 2002:a67:c58e:0:b0:47b:bda4:c30d with SMTP id
 h14-20020a67c58e000000b0047bbda4c30dmr2040619vsk.3.1714700702183; Thu, 02 May
 2024 18:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240502161827.403338-1-pchelkin@ispras.ru> <20240502161827.403338-3-pchelkin@ispras.ru>
In-Reply-To: <20240502161827.403338-3-pchelkin@ispras.ru>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 3 May 2024 13:44:51 +1200
Message-ID: <CAGsJ_4zKRSnpoepYsw8qiwVHY-ztWYixKjtD7D1SKbhYho=pUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: prevent potential kthread hang
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
> If some of kthreads executing map_benchmark_thread() return with an error
> code (e.g. due to a memory allocation failure), then the next kthreads in
> the array are not stopped and potentially loop for indefinite time.
>
> Call kthread_stop() for each started thread as map_benchmark_thread()
> expects that happening in order to exit.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DM=
A APIs")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  kernel/dma/map_benchmark.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index ea938bc6c7e3..7e39a4690331 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -140,13 +140,17 @@ static int do_map_benchmark(struct map_benchmark_da=
ta *map)
>
>         msleep_interruptible(map->bparam.seconds * 1000);
>
> -       /* wait for the completion of benchmark threads */
> +       /* wait for the completion of all started benchmark threads */
>         for (i =3D 0; i < threads; i++) {
> -               ret =3D kthread_stop(tsk[i]);
> -               if (ret)
> -                       goto out;
> +               int kthread_ret =3D kthread_stop(tsk[i]);
> +
> +               if (kthread_ret)
> +                       ret =3D kthread_ret;
>         }
>
> +       if (ret)
> +               goto out;
> +

do we still need to do copy_to_user(argp, &map->bparam, sizeof(map->bparam)
after  do_map_benchmark(map) fails?
do we also need the below?
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 02205ab53b7e..28ca165cb62c 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -252,6 +252,9 @@ static long map_benchmark_ioctl(struct file *file,
unsigned int cmd,
                 * dma_mask changed by benchmark
                 */
                dma_set_mask(map->dev, old_dma_mask);
+
+               if (ret)
+                       return ret;
                break;
        default:
                return -EINVAL;


>         loops =3D atomic64_read(&map->loops);
>         if (likely(loops > 0)) {
>                 u64 map_variance, unmap_variance;
> --
> 2.45.0
>
>
