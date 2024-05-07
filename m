Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE878C8F
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064982; cv=none; b=OcIK43eeihpAVFLhWwfIWjXgN+adXrP3RZz5si1sJeScI9UUfmZQgLGmoaZdmI2+jbt4cAJcQSoMfcea7H2DRCRFh5N5QUzQMm3k7+grFyUUy4GM4iNsTrwxYxmh5jW9o03SWJVGUIwTEYUos52Q1BnfEHHJh2T3eMjR+FsSF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064982; c=relaxed/simple;
	bh=srNF1To/gkrtW+OMU1GPxXVRf2tkwKaLhSiYRijk9os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGB7B9bkfl/HEx8qFGiQho+S0+c/pKsllXk5MvC9+zI8Sv9uhAFg9mNe5UNe/bWo8deG8crl6GuitsTCkY7T+L+cnkeDYlPsEdjNZ0ZYchU6sGBxR7Jl+nTUyNyNsGRXFbHvGjnLxdfSS4fxF3NC+uKVB7BB+y/T0rvsFmKKoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0G9xjpp; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0G9xjpp"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4df3d4f0bf7so609893e0c.0
        for <iommu@lists.linux.dev>; Mon, 06 May 2024 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715064980; x=1715669780; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brFAlWc3o5xAeQcntdmVz1rSXR23wEs67uDjVrMmI+c=;
        b=G0G9xjpp4HcZU+y0OnjepTebBSG0JRpT8PAsGZfLcwEmkVRYdr8T7jKrpZ7rQDj9Ic
         xrzqqzOCDBW8iKC0jd2+tGMsFEDale22rd+dNJHCvshnGWK3twNJQdy4sFSoWWOu/U8s
         jOGIgVw9vXTyoGkCGUew+kcGJ9j61ISdRLNtiFqXz7xFicq1uQ7FfpYZfBQDAMOddQ92
         sh8twN0HwhtnA8VbuJ/ancMz5fImGmD0CZektj4PNAZRJyx1OOOQJxdW4i6CeV6Z+kCc
         DJc/yLSwzF7GvFBDr1JwfYceAyaPAA29oPA+C8nXJbsVFA6k9Yfoue3KrOl2p8Yr3Ole
         aSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715064980; x=1715669780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brFAlWc3o5xAeQcntdmVz1rSXR23wEs67uDjVrMmI+c=;
        b=XHEY+RqPjthfeaH8X7rCEQXO42hr2cZndrYG3dGVcCGoDYGAETXJBMpOvC/rL9dhDY
         hpw8nkxyeS1XoxD6N3NMtnrJ0hWAA/zaNRjHFirf22wBeWRXQTG3CjznGKfUDOw07KtT
         bABaUHDT0CsTqTtJwhox71sJ6KGvgGolVxkeDtPbwzt7UVqEE6kMrCUKm/YFrNVPbxl9
         9CRdEQYbukaA422MiVLqWdgh7/WqVfWEjQ0sNr1JWlIgRmF4sWhaTpeL/dzS3ZBdjX4f
         efaW48X7GhzAU3KjUR67S9GrLY+dFXmlTeOrdQKWlkwhLuWk4EpA2nh+q7wcSdt5G8Ob
         NkRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYUpRydPyIItAsVEjEoSS4ALaKSQRftTIjK4lDWTZv5LWC3cZ/ufqQketE3GSYjxBipk/bgfMbrhW6EL1qX6pLGbRRGME=
X-Gm-Message-State: AOJu0Yy18Gj9//27apWbA+XwB2+vbk/mHKBxB1S/lVn0tiMul7mMN/wi
	7A0+Iar85EnvAt5YSDVvMw+dbfjP58Nf4IlCLOm1WAetRaZH/J1ieMBdmPPp/Mz2b53Jye6mBth
	PH2H1mghkxUGnWfF0PlBWsr8F55M=
X-Google-Smtp-Source: AGHT+IGl4EuHv0dRyoYb7H94b3WfThdmu6cVTyFbEUFr+1l351FibZu0HRnT2kV8alRFt46cOwR2zquwVuU8oSwmbnU=
X-Received: by 2002:a05:6122:3293:b0:4df:18b1:c1a2 with SMTP id
 cj19-20020a056122329300b004df18b1c1a2mr11632483vkb.11.1715064977496; Mon, 06
 May 2024 23:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240504114713.567164-1-pchelkin@ispras.ru> <20240504114713.567164-5-pchelkin@ispras.ru>
In-Reply-To: <20240504114713.567164-5-pchelkin@ispras.ru>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 7 May 2024 18:56:06 +1200
Message-ID: <CAGsJ_4xo6rxO=twFVL1w6D2ht+8BRmB5816zPaptE9v3SoYA-w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dma-mapping: benchmark: handle NUMA_NO_NODE correctly
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Xiang Chen <chenxiang66@hisilicon.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 11:48=E2=80=AFPM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> cpumask_of_node() can be called for NUMA_NO_NODE inside do_map_benchmark(=
)
> resulting in the following sanitizer report:
>
> UBSAN: array-index-out-of-bounds in ./arch/x86/include/asm/topology.h:72:=
28
> index -1 is out of range for type 'cpumask [64][1]'
> CPU: 1 PID: 990 Comm: dma_map_benchma Not tainted 6.9.0-rc6 #29
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> Call Trace:
>  <TASK>
> dump_stack_lvl (lib/dump_stack.c:117)
> ubsan_epilogue (lib/ubsan.c:232)
> __ubsan_handle_out_of_bounds (lib/ubsan.c:429)
> cpumask_of_node (arch/x86/include/asm/topology.h:72) [inline]
> do_map_benchmark (kernel/dma/map_benchmark.c:104)
> map_benchmark_ioctl (kernel/dma/map_benchmark.c:246)
> full_proxy_unlocked_ioctl (fs/debugfs/file.c:333)
> __x64_sys_ioctl (fs/ioctl.c:890)
> do_syscall_64 (arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>
> Use cpumask_of_node() in place when binding a kernel thread to a cpuset
> of a particular node.
>
> Note that the provided node id is checked inside map_benchmark_ioctl().
> It's just a NUMA_NO_NODE case which is not handled properly later.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DM=
A APIs")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

We've never actually accessed the content of cpu_mask when node
equals NUMA_NO_NODE because we always have the condition if (node !=3D
NUMA_NO_NODE) before accessing it. Therefore, the reported failure isn't
actually an issue. However, the underlying concept is correct, hence,

Acked-by: Barry Song <baohua@kernel.org>

I also noticed some arch have fixed up cpumask_of_node itself.
#define cpumask_of_node(node)   ((node) =3D=3D -1 ?                        =
 \
                                 cpu_all_mask :                         \
                                 &hub_data(node)->h_cpus)

> ---
>  kernel/dma/map_benchmark.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 9f6c15f3f168..4950e0b622b1 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -101,7 +101,6 @@ static int do_map_benchmark(struct map_benchmark_data=
 *map)
>         struct task_struct **tsk;
>         int threads =3D map->bparam.threads;
>         int node =3D map->bparam.node;
> -       const cpumask_t *cpu_mask =3D cpumask_of_node(node);
>         u64 loops;
>         int ret =3D 0;
>         int i;
> @@ -124,7 +123,7 @@ static int do_map_benchmark(struct map_benchmark_data=
 *map)
>                 }
>
>                 if (node !=3D NUMA_NO_NODE)
> -                       kthread_bind_mask(tsk[i], cpu_mask);
> +                       kthread_bind_mask(tsk[i], cpumask_of_node(node));
>         }
>
>         /* clear the old value in the previous benchmark */
> --
> 2.45.0
>
