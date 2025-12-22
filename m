Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3B28643D
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437818; cv=none; b=sPzEyjDOgA0XfWP7D/AhrGJgFRrvVI5lPePGLYe9KDN9sIKTPxC+yRXzaEehLE2nAzZDYa4zJpS1J143UFHooxS/fWqyY3cDZuPlKKWtHo78WilDzwGke/yw6PZ2PrnlL/g0uaZ9dFaOZeljbYLAkQooF/TdgT7jhDKxZRRKMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437818; c=relaxed/simple;
	bh=MjArrtE0BskQ35ac0XeLqXy9S12C9rLyGbNDShCQ8gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCfyyL4rWo5mC/DlCfbYfKhewX3nYmczPyW9wzYx0PIux0CEmPrDRmWgaoP5dAB7XqXH0WOWNu4r6yCNTCfoqh7YpkHsQJFhBXZbBHiiYh3XLADZpudcGraq5lbb1ZpWz2hYCL3YK0M7/pkq+2iesBq1rrKx/5eVMFSTBDMNDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBDvaSu+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBDvaSu+"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8888546d570so61605516d6.2
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 13:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766437816; x=1767042616; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vrLRRf5fQL+SHj3Kc2H88ifQd9Sob2F2apAao57ceo=;
        b=HBDvaSu+Vx2g6pD0pSOZxURaZ5X13GM3UWFhD8AwjpkjZuVeR225AXU3aDYEq1eT8C
         Dwxdny6tv1hf9lfUDcDoBgKVMqyOtlR4tqKd7xlXFDIM8NMZoyckCeigtD+PEBT3Ng2i
         L9QoSR222ObHE/rKtqNbLm+FflM69yFokJQ+DwtOBdb5A9w7K4lXUpfQ+8LczXFbXPmJ
         t7oJ05p9AW4yuka0C8CgZvhDcoI0REPN0iAnrFbMggPMYou+GkpnoRDayJpYqfemKiz9
         NZgo5XZ69BmAD+2tzfmRjJnHCi9XT3Y8wuhkLKPlSeafuaM0UNY+bfe5GIGPRDcGhvWe
         tm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766437816; x=1767042616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vrLRRf5fQL+SHj3Kc2H88ifQd9Sob2F2apAao57ceo=;
        b=BxvZ4j055kYeMLyAlgwuHj9m3r6vgDYb40flUfFgBQUQNyjI9z+IjFS0wbQJgpOX0W
         NPc+TSExLgjeQ407cNt4H/Lc0kLVxmacnGMvtyShOxGWi1DfR1EQsq8NX5/l/lcTTaYs
         C2czPIKlYjmxkaf70E0j4MbP+1hX+x88kTf9ZJzcto/crYNtAFOHbuYFXB0CLS7akF71
         FpghZx6V3GmAn7uuZqLufiGG11JCHkJ9uebq6EjgPWdyz5nzXheHG+Ydoi7zE+93xYfB
         v6FyRE5bswfnMIONgrGejbRcNOLC7SvXLMxQWfOawMrynSqoQfI9tn31JevOKqolhGWE
         SUHw==
X-Forwarded-Encrypted: i=1; AJvYcCWMYpEYCnva3JpX5SjGsxf7TXPhfUjzjmX/Z7TVP03cgo2tBJEPUutUddaB4USOzMugtjP30Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYlfpwHaQcmfcyMCKlCBie+egdxQCXsARfaHRvQWDL7Ari7DBt
	fC7Fh1ukdcWfy464e/gkvwrbD9Nc0TJwmtsEUl0UFdU5RfHllTvAt28kG1omJaow65rGtHMrC+E
	5F9xktbJhADrlmKTYcDfSeYssHsTgjLA=
X-Gm-Gg: AY/fxX6ZFXtwQdo0zjFQNO36TTwCEUxE/xH+Tie39n9Vu3oIKsXJT3/RbOzU+Z5F+F5
	DOrbr8utpbIH7D/Zb282gVBwTMl/duk3cWhw6s/XdBY6RkzWK3BKtY15Ga2ic1y/CeIeoIvNv/M
	J9sYBUX0ltl170HW7jMgX4AvElB+gm2sl04rKCI9uCHcKMthVIxr+zGhDZRxoodKd2kYENysA4J
	R96u10n5jHvUz0x8oo8iTYnIGoE9KUUi/TmQiJyABwZeIkjgUou1ibQQxaR8JU0m4S9yQ==
X-Google-Smtp-Source: AGHT+IHVBCJWAKmwiH9ku4OUbh/pDoeLws/h805SUms/2BcVsHl7FwooRnpbT7L9xeUpOho3GAhFSIVU+C2CtJ3eBRA=
X-Received: by 2002:a05:6214:4699:b0:87f:fecf:17b2 with SMTP id
 6a1803df08f44-88d881b9a37mr172017816d6.64.1766437815649; Mon, 22 Dec 2025
 13:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251222153246.2220659-1-xiaqinxin@huawei.com> <20251222153246.2220659-4-xiaqinxin@huawei.com>
In-Reply-To: <20251222153246.2220659-4-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 23 Dec 2025 10:10:04 +1300
X-Gm-Features: AQt7F2oaR4rsyDgc5WviZDq3wGRobv5Irdy_zg9Mt72OL4J0OA2xXGdiExntKXE
Message-ID: <CAGsJ_4yyFXmeHKwb4E7PA9ndOrB79aQKAEKSTmJEVPO1OtiqnA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] tools/dma: Add dma_map_sg support
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: jonathan.cameron@huawei.com, wangzhou1@hisilicon.com, 
	iommu@lists.linux.dev, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 4:33=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> Support for dma_map_sg, add option '-m' to distinguish mode.
>
> i) Users can set option '-m' to select mode:
>    DMA_MAP_BENCH_SINGLE_MODE=3D0, DMA_MAP_BENCH_SG_MODE:=3D1
>    (The mode is also show in the test result).
> ii) Users can set option '-g' to set sg_nents
>     (total count of entries in scatterlist)
>     the maximum number is 1024. Each of sg buf size is PAGE_SIZE.
>     e.g
>     [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
>     dma mapping mode: DMA_MAP_BENCH_SG_MODE
>     dma mapping benchmark: threads:8 seconds:30 node:-1
>     dir:FROM_DEVICE granule/sg_nents: 8
>     average map latency(us):1.4 standard deviation:0.3
>     average unmap latency(us):1.3 standard deviation:0.3
>     [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>     dma mapping mode: DMA_MAP_BENCH_SINGLE_MODE
>     dma mapping benchmark: threads:8 seconds:30 node:-1
>     dir:FROM_DEVICE granule/sg_nents: 8
>     average map latency(us):1.0 standard deviation:0.3
>     average unmap latency(us):1.3 standard deviation:0.5
>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  tools/dma/dma_map_benchmark.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/tools/dma/dma_map_benchmark.c b/tools/dma/dma_map_benchmark.=
c
> index dd0ed528e6df..39102330a43f 100644
> --- a/tools/dma/dma_map_benchmark.c
> +++ b/tools/dma/dma_map_benchmark.c
> @@ -26,6 +26,8 @@ int main(int argc, char **argv)
>         int fd, opt;
>         /* default single thread, run 20 seconds on NUMA_NO_NODE */
>         int threads =3D 1, seconds =3D 20, node =3D -1;
> +       /* default single map mode */
> +       int map_mode =3D DMA_MAP_BENCH_SINGLE_MODE;
>         /* default dma mask 32bit, bidirectional DMA */
>         int bits =3D 32, xdelay =3D 0, dir =3D DMA_MAP_BIDIRECTIONAL;
>         /* default granule 1 PAGESIZE */
> @@ -33,7 +35,7 @@ int main(int argc, char **argv)
>
>         int cmd =3D DMA_MAP_BENCHMARK;
>
> -       while ((opt =3D getopt(argc, argv, "t:s:n:b:d:x:g:")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "t:s:n:b:d:x:g:m:")) !=3D -1) =
{
>                 switch (opt) {
>                 case 't':
>                         threads =3D atoi(optarg);
> @@ -56,11 +58,20 @@ int main(int argc, char **argv)
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
> +       if (map_mode < 0 || map_mode >=3D DMA_MAP_BENCH_MODE_MAX) {
> +               fprintf(stderr, "invalid map mode, SINGLE_MODE:%d, SG_MOD=
E: %d\n",
> +                       DMA_MAP_BENCH_SINGLE_MODE, DMA_MAP_BENCH_SG_MODE)=
;
> +               exit(1);
> +       }
> +
>         if (threads <=3D 0 || threads > DMA_MAP_MAX_THREADS) {
>                 fprintf(stderr, "invalid number of threads, must be in 1-=
%d\n",
>                         DMA_MAP_MAX_THREADS);
> @@ -110,13 +121,15 @@ int main(int argc, char **argv)
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

Why can=E2=80=99t we print mode on this line,
and why isn=E2=80=99t the integer converted to a string
like directions?

Thanks
Barry
