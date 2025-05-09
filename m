Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3F23D29F
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746763207; cv=none; b=ULCePG3Ck7ZHmj+M6uZUj37SfmLeeXCVhIW2h4jPR3Bq7mNjCNT2uHvytN6bs/oBNuYF6UMuWBHLoqzQxbjGqRw9ixXj4Dr+e5c6Xd4i+f0MCok5QLgbPe0tJhcWF0EtkttUN89rTGYdEJ7/JUT2Cbk4vdc/GR+EPPUXvm3akb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746763207; c=relaxed/simple;
	bh=O0wc9bDinKNUgWud/v1ynGKPFpt6zxAkHu4kZCpjBLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7xo8ZgyY9RBE/IxMbJiF0I8KeJq5FNz186LlUlFZc0Ixm+TaLbUS98iLRqPiUrrDGA01hXoh4ujajUMwWYf96xM1qTcPfYjVvrYFxFur/XO3pJtW0rBfPRKMZZZUPs6a0ldJ80X7WLVP32Fy7WjilnG+WGoWTBFCIvSWl0NYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4/PvwwQ; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4/PvwwQ"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so1653402241.1
        for <iommu@lists.linux.dev>; Thu, 08 May 2025 21:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746763204; x=1747368004; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G6oVMS2/2cZwRoqWPoJH6DF7ZUJdFMrU5gGv2C0tcI=;
        b=c4/PvwwQJTV1Ub8IDqvde88sfaRs4lDjo4aNmWYw/Jx3/wmV2DL1gw8kW/x92Yb3OX
         4SI/loapHs17gsRsWn7A23UXP1Vbb8AGo9G981J1s+urVFIV24uFPBNBXm4PNaHkq6hk
         fBXrty0EElw3hPX7SjJSO+6tTcuXlIfEKgHHE9acr0114dHr3Zej7JlFJUbaq3g9cU31
         eXQwb946x9jAjzS0OG5GkDqlZyW3Zz2vLTmX88FJcI9CT5e0arOGxUwhL2Jz+AecQiKH
         eY+8hS6KmiQ5EE+o7/eIpRdIl5lBaIlgBMcMm83kDuZ58yRfNXIiT6ps4u3FfTzMf6WH
         P4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746763204; x=1747368004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G6oVMS2/2cZwRoqWPoJH6DF7ZUJdFMrU5gGv2C0tcI=;
        b=LUD2PHMq2rxlPc8rOztsjRTHe8dVGHITNZGnkcaCljH5QEgMY60F8ttdIV3gQXm98m
         W1HH3Jcamul7tkN0rZoLGLdEbgGuQswIKwrNm3Gb3v2aQjntWzYnNeNjTgbNwST3e2oN
         m4HqAQEe9kroWUaKPtT0ayV9ZsmaAKdl+WGXLQalBZYtUWr+jDSSFMVKqvsy0CobLiHw
         q//rCa2ffbmJbsKYOegpx4rL9pCaVUum6DzdjwD7VWhExHNL/vp7H5N0LTIHXx7Az5nh
         FCJIT0CByM8ZKl3LiUXKcTkHBsOM5iQlw8AYWI67KpxEYAez88TDz9tgthgADLnJRcYZ
         U0gg==
X-Forwarded-Encrypted: i=1; AJvYcCXTKHNkvD4OQW2Y0YQLnjpxvdulCmWwu5yP/WlDspw2p+ZuQsxV9o0NbvaU1V4qeMjgkJDl5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8cWOl/TO4GsS2Ivix3f02pJvPl8lPQP1uno/7dPqTQJJWXr8x
	NYwypjr0oR3WQqP0BwCDUF4g0SDLRgaacqJLShp0PH1WA06rfCR6NdAntyuwozXUPuMZzKDItNN
	MGvWFyHfHV2LvDlsGBHkE1q8gm98yb7F0
X-Gm-Gg: ASbGncuUhF3K63zfRpUeFVeVcBy//usBVKyu6TEbAss+IJti2mg7FTHyODbUK5AHqlw
	8WsnEiwB16BTdZu5VV+DVpDcLIHd3CdjcBeC/P9HqE+S05LA+Yypsn6tgPCmwrqikTauGm+2hFp
	z+p/bE4eAhD9jjG6idyOoZ1uGNQ0gIFDOC
X-Google-Smtp-Source: AGHT+IHIcljw4VAISO8y0egc9b6+n1i+yR4OqDyi8CeF/F6PBxgRUsH2uaETX5k2p6QWYWMa3s0puJpc65i6dnobCEc=
X-Received: by 2002:a67:f411:0:b0:4db:10bf:6f2c with SMTP id
 ada2fe7eead31-4ddac94bbb8mr5192054137.11.1746763204204; Thu, 08 May 2025
 21:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250509020238.3378396-1-xiaqinxin@huawei.com> <20250509020238.3378396-5-xiaqinxin@huawei.com>
In-Reply-To: <20250509020238.3378396-5-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 9 May 2025 15:59:53 +1200
X-Gm-Features: AX0GCFurr0i-Df4uo4cGNP0_BIxmRZQifcMqyWZ-td28HMFimLzCvsljDauHGD0
Message-ID: <CAGsJ_4zaE6F5Goh9O6ytPA+RekeYiMhsU7dHYAM_sKzXREiQjA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] selftests/dma: Add dma_map_sg support
To: Qinxin Xia <xiaqinxin@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:02=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> wr=
ote:
>
> Support for dma_map_sg, add option '-m' to distinguish mode.
>
> i) Users can set option '-m' to select mode:
>    DMA_MAP_SINGLE_MODE=3D0, DMA_MAP_SG_MODE:=3D1
>    (The mode is also show in the test result).
> ii) Users can set option '-g' to set sg_nents
>     (total count of entries in scatterlist)
>     the maximum number is 1024. Each of sg buf size is PAGE_SIZE.
>     e.g
>     [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
>     dma mapping mode: DMA_MAP_SG_MODE
>     dma mapping benchmark: threads:8 seconds:30 node:-1
>     dir:FROM_DEVICE granule/sg_nents: 8
>     average map latency(us):1.4 standard deviation:0.3
>     average unmap latency(us):1.3 standard deviation:0.3
>     [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>     dma mapping mode: DMA_MAP_SINGLE_MODE
>     dma mapping benchmark: threads:8 seconds:30 node:-1
>     dir:FROM_DEVICE granule/sg_nents: 8
>     average map latency(us):1.0 standard deviation:0.3
>     average unmap latency(us):1.3 standard deviation:0.5
>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>


- stable@vger.kernel.org
+ Marek
+ Robin,

Please also include something like 'DMA map benchmark' in the subject line
to make it more specific. Additionally, make sure constants like
DMA_MAP_SINGLE_MODE use a more specific namespace, as mentioned in
earlier replies. With those changes, feel free to add:

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  tools/testing/selftests/dma/dma_map_benchmark.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/test=
ing/selftests/dma/dma_map_benchmark.c
> index b12f1f9babf8..036ddb5ac862 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -27,6 +27,7 @@ int main(int argc, char **argv)
>         int fd, opt;
>         /* default single thread, run 20 seconds on NUMA_NO_NODE */
>         int threads =3D 1, seconds =3D 20, node =3D -1;
> +       int map_mode =3D DMA_MAP_SINGLE_MODE;
>         /* default dma mask 32bit, bidirectional DMA */
>         int bits =3D 32, xdelay =3D 0, dir =3D DMA_MAP_BIDIRECTIONAL;
>         /* default granule 1 PAGESIZE */
> @@ -34,7 +35,7 @@ int main(int argc, char **argv)
>
>         int cmd =3D DMA_MAP_BENCHMARK;
>
> -       while ((opt =3D getopt(argc, argv, "t:s:n:b:d:x:g:")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "t:s:n:b:d:x:g:m:")) !=3D -1) =
{
>                 switch (opt) {
>                 case 't':
>                         threads =3D atoi(optarg);
> @@ -57,11 +58,20 @@ int main(int argc, char **argv)
>                 case 'g':
>                         granule =3D atoi(optarg);
>                         break;
> +               case 'm':
> +                       map_mode =3D atoi(optarg);
> +                       break;
>                 default:
>                         return -1;
>                 }
>         }
>
> +       if (map_mode >=3D DMA_MAP_MODE_MAX) {
> +               fprintf(stderr, "invalid map mode, DMA_MAP_SINGLE_MODE:%d=
, DMA_MAP_SG_MODE:%d\n",
> +                       DMA_MAP_SINGLE_MODE, DMA_MAP_SG_MODE);
> +               exit(1);
> +       }
> +
>         if (threads <=3D 0 || threads > DMA_MAP_MAX_THREADS) {
>                 fprintf(stderr, "invalid number of threads, must be in 1-=
%d\n",
>                         DMA_MAP_MAX_THREADS);
> @@ -111,13 +121,15 @@ int main(int argc, char **argv)
>         map.dma_dir =3D dir;
>         map.dma_trans_ns =3D xdelay;
>         map.granule =3D granule;
> +       map.map_mode =3D map_mode;
>
>         if (ioctl(fd, cmd, &map)) {
>                 perror("ioctl");
>                 exit(1);
>         }
>
> -       printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:=
%s granule: %d\n",
> +       printf("dma mapping mode: %d\n", map_mode);
> +       printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:=
%s granule/sg_nents: %d\n",
>                         threads, seconds, node, dir[directions], granule)=
;
>         printf("average map latency(us):%.1f standard deviation:%.1f\n",
>                         map.avg_map_100ns/10.0, map.map_stddev/10.0);
> --
> 2.33.0
>

Thanks
Barry
