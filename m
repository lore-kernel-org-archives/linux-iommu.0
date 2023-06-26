Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4869811
	for <iommu@lists.linux.dev>; Mon, 26 Jun 2023 05:32:24 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-5ed99ebe076so34301056d6.2
        for <iommu@lists.linux.dev>; Sun, 25 Jun 2023 22:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687757543; x=1690349543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXB+jTquqi7d4yxzf9mtpgvS8op2p5ZPrpvvnM7qWf8=;
        b=B2cZPZlD9ur3DHMvgTy4QNiMTBrYwHySlfCUgWKgJ/vn3Ppl9iZLPJCiAWPEDnAmbh
         sLu+CCBvQCKIRJJeL9NvyjlWYkh7WxmT21bMsuCUsOJ3AHzvL9LZay4PMTsrx+IQAwx4
         sjoA2L0Wp/fnScDdU1VNwR3Z9dLOktWy58GQcAnVi5shVIjenGjAMtt8jDz0skxM0DOf
         dzYfbWD1b9ncUR7UfRVxux7i/fVneR7IPVMB4QGaM1QvYZUUYyCamPSafAGQMmDz3d2B
         HhMkZnyM7bKpKVigIm+tAVCZjA3eVqhMr8+AaLPduRTBp4YG/JT8jedu6KfevZVoS5lb
         AsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687757543; x=1690349543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXB+jTquqi7d4yxzf9mtpgvS8op2p5ZPrpvvnM7qWf8=;
        b=NBi77n79NqKjiZHYwZkFWmWSNMJWn6kfLfRPIHEgmgIosvhE35dHl1aILPUISsyShc
         zHlfSAymWbfBcIL6te5B1dvrc8fD3DkeTYZ1GvIjiFhoxJAwjzCeIoR3ZhlvP18fRL9T
         kinKTAkNuaip8GyULDRMka48tq7d1s9vO7zIe5mAayVMx50uLf1eiH5KPaSKby2dFweR
         9+Z4K1fS9HC+C98+f02QW3wDQSCwBdhDZDoyE0dLwgH3WWNMqeuw3UJ7EEE+r/fAQZUn
         pssfoonvVK9Sf/QynZPg7xp2YU4DsTyf11SK49EVapUa1ebOdFPz8WP1meaoCj3d9O3k
         m+hA==
X-Gm-Message-State: AC+VfDyOMuttkrfdRxo6zyz27A6gjr11MJJ1A/aRB+x6CftKnZaqZ/ZG
	KYQ7zjOWn9ntqHeYk9/TEzj2tDeVDL/wyv9AIoQ=
X-Google-Smtp-Source: ACHHUZ4dal3x3Kork/lvMSHzLlfs8I8kIYraLC3d1xmKc2SJcxw6PWmUfHM6Cp0x3Xv7pSHFmZ8DnQKL6CAR5TXwsx4=
X-Received: by 2002:ad4:5cac:0:b0:5f7:a9e1:bbbf with SMTP id
 q12-20020ad45cac000000b005f7a9e1bbbfmr4961593qvh.44.1687757543623; Sun, 25
 Jun 2023 22:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230515094955.GB23880@lst.de> <20230512094210.141540-1-yajun.deng@linux.dev>
 <055f964384a2bb4ba51c64a0be6072c9@linux.dev> <20230515133821.769158bb@meshulam.tesarici.cz>
 <20230623174046.66ce934bcf5c1303003a5afc@linux-foundation.org> <a18b0cf466191b0d692e431fe33c7c80@linux.dev>
In-Reply-To: <a18b0cf466191b0d692e431fe33c7c80@linux.dev>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Jun 2023 17:32:12 +1200
Message-ID: <CAGsJ_4xZp_1jLZnsZsUzaxvkkaOv=FDOiGKNgCmPN1gvJugSTg@mail.gmail.com>
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all architectures
To: Yajun Deng <yajun.deng@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Tian Tao <tiantao6@hisilicon.com>
Cc: v-songbaohua@oppo.com, Christoph Hellwig <hch@lst.de>, corbet@lwn.net, 
	catalin.marinas@arm.com, will@kernel.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, paulmck@kernel.org, bp@suse.de, peterz@infradead.org, 
	rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org, 
	thunder.leizhen@huawei.com, ardb@kernel.org, bhe@redhat.com, 
	anshuman.khandual@arm.com, song.bao.hua@hisilicon.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	=?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 7:30=E2=80=AFPM Yajun Deng <yajun.deng@linux.dev> w=
rote:
>
> June 24, 2023 8:40 AM, "Andrew Morton" <akpm@linux-foundation.org> wrote:
>
> > On Mon, 15 May 2023 13:38:21 +0200 Petr Tesa=C5=99=C3=ADk <petr@tesaric=
i.cz> wrote:
> >
> >> On Mon, 15 May 2023 11:23:27 +0000
> >> "Yajun Deng" <yajun.deng@linux.dev> wrote:
> >>
> >> May 15, 2023 5:49 PM, "Christoph Hellwig" <hch@lst.de> wrote:
> >
> > This looks fine to me. Can you please work with Barry to make sure
> > the slight different place of the initcall doesn't break anything
> > for his setup? I doubt it would, but I'd rather have a Tested-by:
> > tag.
> >> Barry's email is no longer in use. I can't reach him.
> >>
> >> Which one? I would hope that his Gmail account is still valid:
> >>
> >> Barry Song <21cnbao@gmail.com>
> >
> > Maybe his kernel.org address works...
> >
> > I have this patch stuck in limbo for 6.4. I guess I'll carry it over
> > into the next -rc cycle, see what happens.
> >
> > fwiw, it has been in -next for six weeks, no known issues.
>
> Hi, Barry, The slight different place of the initcall, does break anythin=
g?

i don't see a fundamental difference as anyway it is still after
arch_numa_init()
which is really what we depend on.

and i did a test on qemu with the command line:
qemu-system-aarch64 -M virt,gic-version=3D3 -nographic \
 -smp cpus=3D8 \
 -numa node,cpus=3D0-1,nodeid=3D0 \
 -numa node,cpus=3D2-3,nodeid=3D1 \
 -numa node,cpus=3D4-5,nodeid=3D2 \
 -numa node,cpus=3D6-7,nodeid=3D3 \
 -numa dist,src=3D0,dst=3D1,val=3D12 \
 -numa dist,src=3D0,dst=3D2,val=3D20 \
 -numa dist,src=3D0,dst=3D3,val=3D22 \
 -numa dist,src=3D1,dst=3D2,val=3D22 \
 -numa dist,src=3D2,dst=3D3,val=3D12 \
 -numa dist,src=3D1,dst=3D3,val=3D24 \
 -m 4096M -cpu cortex-a57 -kernel arch/arm64/boot/Image \
 -nographic -append "cma_pernuma=3D32M root=3D/dev/vda2  rw ip=3Ddhcp
sched_debug irqchip.gicv3_pseudo_nmi=3D1" \
 -drive if=3Dnone,file=3Dextra/ubuntu16.04-arm64.img,id=3Dhd0 -device
virtio-blk-device,drive=3Dhd0 \
 -net nic -net user,hostfwd=3Dtcp::2222-:22

and in system, i can see all cma areas are correctly reserved:
~# dmesg | grep cma
[    0.000000] cma: cma_declare_contiguous_nid(size
0x0000000002000000, base 0x0000000000000000, limit 0x0000000000000000
alignment 0x0000000000000000)
[    0.000000] cma: Reserved 32 MiB at 0x000000007ce00000
[    0.000000] cma: dma_pernuma_cma_reserve: reserved 32 MiB on node 0
[    0.000000] cma: cma_declare_contiguous_nid(size
0x0000000002000000, base 0x0000000000000000, limit 0x0000000000000000
alignment 0x0000000000000000)
[    0.000000] cma: Reserved 32 MiB at 0x00000000bce00000
[    0.000000] cma: dma_pernuma_cma_reserve: reserved 32 MiB on node 1
[    0.000000] cma: cma_declare_contiguous_nid(size
0x0000000002000000, base 0x0000000000000000, limit 0x0000000000000000
alignment 0x0000000000000000)
[    0.000000] cma: Reserved 32 MiB at 0x00000000fce00000
[    0.000000] cma: dma_pernuma_cma_reserve: reserved 32 MiB on node 2
[    0.000000] cma: cma_declare_contiguous_nid(size
0x0000000002000000, base 0x0000000000000000, limit 0x0000000000000000
alignment 0x0000000000000000)
[    0.000000] cma: Reserved 32 MiB at 0x0000000100000000
[    0.000000] cma: dma_pernuma_cma_reserve: reserved 32 MiB on node 3
[    0.000000] cma: dma_contiguous_reserve(limit 100000000)
[    0.000000] cma: dma_contiguous_reserve: reserving 32 MiB for global are=
a
[    0.000000] cma: cma_declare_contiguous_nid(size
0x0000000002000000, base 0x0000000000000000, limit 0x0000000100000000
alignment 0x0000000000000000)
[    0.000000] cma: Reserved 32 MiB at 0x00000000fae00000
[    0.000000] Kernel command line: cma_pernuma=3D32M root=3D/dev/vda2  rw
ip=3Ddhcp sched_debug irqchip.gicv3_pseudo_nmi=3D1
[    0.000000] Memory: 3848784K/4194304K available (16128K kernel
code, 4152K rwdata, 10244K rodata, 8512K init, 612K bss, 181680K
reserved, 163840K cma-reserved)
[    0.175309] cma: cma_alloc(cma (____ptrval____), count 128, align 7)
[    0.179264] cma: cma_alloc(): returned (____ptrval____)
[    0.179869] cma: cma_alloc(cma (____ptrval____), count 128, align 7)
[    0.180027] cma: cma_alloc(): returned (____ptrval____)
[    0.180187] cma: cma_alloc(cma (____ptrval____), count 128, align 7)
[    0.180374] cma: cma_alloc(): returned (____ptrval____)

so my feeling is that this patch is fine. but I would prefer Yicong
and Tiantao who have a real numa machine
and we can get some real device drivers to call dma APIs to allocate
memory from pernuma cma on arm64
even though it is 99.9% OK.

With their testing done, please feel free to add
Acked-by: Barry Song <baohua@kernel.org>

Thanks
Barry
