Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A092D97B4
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764582; cv=pass; b=hHHKNRffTEctR66cJKRAxI4EVE9vA5LIoH3HPcJE54sjuvLG8Jfk69Oib8Ocol7+QO+8+jcJHzLB+8w2umk8AGRDopTZsyocb4GRBGeJtTaLBN4V4bkEwyn7lqxKbdIfW1Oxg1K0+JFbQDPmYnIyK/MR1UKmYFqRAq+89yaPt+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764582; c=relaxed/simple;
	bh=JrVv7eiGzcQYnYunasyz44pVc5xZNY7Ge0xd/5K+l/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjRIzVjThYqwLexG4V4cN+E81YsB6ZtVpRElCR1FcyOyq4OozY2vksmG+C34DJjQdzWVtLUIt/yVl/3sCtA/bvs5bF8KH09iMrulzQWBSUpyjY8rAKDVYxMops0YiJe07EHmhGT/Xl1MKl21MVdwjPj0kdBaFItxCL6ZbhY/AOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR1oGhpH; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR1oGhpH"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c532d8be8cso193007185a.2
        for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 01:16:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769764580; cv=none;
        d=google.com; s=arc-20240605;
        b=VMyAuBM6sqFagy+wTY/9iOojjZ8z6W0Wbm4QQzVkKjDNe85i2RVRouClu7W2OH3lTE
         prtZKaHZ2AE5uMjFZJM+D2lBZwjCHyHcE/EiuwbLo1qN8XP1RRgQDBVuQHfz/1bXA3BI
         Xe9BvtEr8EnDCNzpdQNXc6+tYv0g//ieunTKpgKDvu6u+cnV2K0kIRju8GNqCI+Ql4s7
         FT4P4d1S70sGlQr6bYznhjW0z/A/2Ez2/fU8SeVie1N5XnQXNmTKRFUZjxs7w9f8bJtu
         c5DgIcvDdpGMEw1mEQ1XOuuflJrBXQgWfkCePWxZV1IGDXQi3WcvcNVaEmO73OCRuFCI
         u8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=09xHb+ewbdqfNSmYQbLA8Z730ddG89yrC+1GSI/Evmw=;
        fh=WTPLc5bXG2RuSWjYeOch9c0C9fMq2OdXhgXMtgaCmcA=;
        b=IxYxMjzLYGcgTr215j8h6URhw53fpEsXSqcIVyuD+oACC7LT4yQZDx528A0TseIQqp
         ZgPAVv1SMuUNrqKKeHd3KCAh79NTpvHuybXqDxuFnlJSAXBjTAN2fHlkzCIWinWxkbWy
         frZGsuQ4cmgaTr/Aj/lGrcLb4kgRFRXaQpah8/LMjHH8+gbo3SextNrpP7Br8T0yzA4+
         +0AxCCTG4irnq8U0aJNSwKqVTSiFSE24oJOkT6+yFunNeX9KxzaADy8pNQHB5udJ1x+n
         RfNOHGoNr0nBdsWGimsrcelcD1Bw5jBPMfltjwtNBQxFKE+FnMaYOjKqZkbM9jE7uWbi
         4EBQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769764580; x=1770369380; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09xHb+ewbdqfNSmYQbLA8Z730ddG89yrC+1GSI/Evmw=;
        b=fR1oGhpH5yIB90MuK4WgG4om/PtLJjCdwl6BjZ84nGak0k5hhxxEImUAsLmZtVYseE
         9t8TPgwQypvuAzuFva0m357Yf/hfozDjQ455To/ysbn3keZu3e5X0O7WLxKifLb1D53J
         FDnegBZdJI9zpNbqS4LBTN/31Pw0b9ahmjcB8JrxlnVRRx8dgcUex3UEB/MWjEtgY9ki
         NvtBasYnLxdt6PgjsG5oM1a/TfxkmwdvxQQQMqNR3FBlawOKXrjk+5s7JNiMSi3tgSLR
         imbLA91+4QzWIPuTSSYrZky0OxbeBZsrTyu8VL6Rw7wDPNDaDtYC9c0gWk11zbUgLems
         W+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769764580; x=1770369380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=09xHb+ewbdqfNSmYQbLA8Z730ddG89yrC+1GSI/Evmw=;
        b=PcXuN9noD6AyVGOxcg/UVgubBzEnh4nwufHD697ru7LgjOvcP5z+53f6ticPycqJvA
         l56m783wUToj+tUeYAzqvbcIwRxFsI3laFpaeaeTMTOMBpdCFk5UVo+3WbxfxB7V7J3s
         G4A67OSBsj+7YxqhzNXUCov2Kg4gEXvt3Cn5ydjha2qqqKeCdlJuPrvCD82ogirRkn6C
         u6oWe7Uwjz1WjhneQn7qU9X4n9/NoKVuzHaIl8YOtMZtXiz5PAN+cMIuwmhInQYM9Wa7
         +SuWQIGDooWWr9tkzIWGuQXx97/9/Zv+zaUSkHHF7PUdjKgkAKEMj8tpn2ymnF1pxgtq
         zClg==
X-Forwarded-Encrypted: i=1; AJvYcCUmVaLgssOMTtlYOzl/NgFhNb02duFAtOZd3f68X+caRfBitGFSSvh6EbMoa7s0sw1Bb8X74Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzx4q+jHgOpItL2A/14MayNp46ATt78eYOmEC0gYJ1G7R7z97vC
	sZr8dGGrN0SMdzmXxCuuPEMOSRf8MPng6mYd+FNicAoh6fsHc7GwOP0IIFrMtx4XSpvtnBRNN9y
	XfWIHIG/LjHhYH7Lrn7QCctw/vcvb5wc=
X-Gm-Gg: AZuq6aIwjOCB2DAN6hEN6G6ANDzmg/ds+ZKGk3b7ja5ahqpwoDowy8eYW38zFMcrIfa
	N3Rk1TBsvEvcq5FwqVpj+OuQd6Kda7MsuMbIxeudPT+bAvsPVwr7AvwBRgkCTab4Jl81450+oBU
	XomkcE+JxJfV5NfSE1YEE83kJJNLHxyxehoXpMY2thlXpd0cKy2CxEisK0rDwlvT6aszbVQX38B
	qmS39DVDadLL0MUVEpQ4n5Wvq7MQwX2EmshOIa7aZVJLtfUourRORFK0FDe01bivOb8KP7k
X-Received: by 2002:a05:620a:408d:b0:8c5:22b2:8b4a with SMTP id
 af79cd13be357-8c9eb21a76fmr292136585a.16.1769764579499; Fri, 30 Jan 2026
 01:16:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112093436.3456315-1-xiaqinxin@huawei.com>
 <20260112093436.3456315-4-xiaqinxin@huawei.com> <CAGsJ_4zkLF8Si6A0tvFNPGq2VJ8Md-Be=25K65XxSn-JWtCxbA@mail.gmail.com>
 <4794d927-6de4-4283-b3ee-ee5030941a72@huawei.com>
In-Reply-To: <4794d927-6de4-4283-b3ee-ee5030941a72@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 30 Jan 2026 17:16:08 +0800
X-Gm-Features: AZwV_QgThkaN0fWKJB3CN1S3PJjjYywcrE5Rn0LGX84yrISwdwzt8spsIwZ_abM
Message-ID: <CAGsJ_4xERKq4=iQPjP6+=7p4vdCUpfKB7hp7_QDOwUxn+viG5A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tools/dma: Add dma_map_sg support
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: jonathan.cameron@huawei.com, wangzhou1@hisilicon.com, 
	iommu@lists.linux.dev, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 4:38=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
>
>
> On 2026/1/26 10:51:11, Barry Song <21cnbao@gmail.com> wrote:
> > On Mon, Jan 12, 2026 at 5:34=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.co=
m> wrote:
> >>
> >> Support for dma_map_sg, add option '-m' to distinguish mode.
> >>
> >> i) Users can set option '-m' to select mode:
> >>     DMA_MAP_BENCH_SINGLE_MODE=3D0, DMA_MAP_BENCH_SG_MODE:=3D1
> >>     (The mode is also show in the test result).
> >> ii) Users can set option '-g' to set sg_nents
> >>      (total count of entries in scatterlist)
> >>      the maximum number is 1024. Each of sg buf size is PAGE_SIZE.
> >>      e.g
> >>      [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
> >>      dma mapping mode: DMA_MAP_BENCH_SG_MODE
> >>      dma mapping benchmark: threads:8 seconds:30 node:-1
> >>      dir:FROM_DEVICE granule/sg_nents: 8
> >>      average map latency(us):1.4 standard deviation:0.3
> >>      average unmap latency(us):1.3 standard deviation:0.3
> >>      [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
> >>      dma mapping mode: DMA_MAP_BENCH_SINGLE_MODE
> >>      dma mapping benchmark: threads:8 seconds:30 node:-1
> >>      dir:FROM_DEVICE granule/sg_nents: 8
> >>      average map latency(us):1.0 standard deviation:0.3
> >>      average unmap latency(us):1.3 standard deviation:0.5
> >>
> >
> > What happens if m is set to 0 while g is set to 8?
> >
> > Thanks
> > Barry
>
> Hi Barry!
> m set '0' and g set '8', This means that 8 page_sizes are mapped at a
> time in single mode.
> As the comment for the struct map_benchmark definition says:
>
>   __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
>
> [root@localhost xqx]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
> dma mapping benchmark(SINGLE_MODE): threads:8 seconds:30 node:-1
> dir:FROM_DEVICE granule:8
> average map latency(us):0.2 standard deviation:0.1
> average unmap latency(us):4.3 standard deviation:1.4
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> The newly added sg mode reuses the -g option as sgnents and is described
> in the comments:
>         /*
>          * Set the number of scatterlist entries based on the granule.
>
>
>          * In SG mode, 'granule' represents the number of scatterlist
> entries.
>          * Each scatterlist entry corresponds to a single page.
>          */
>
> By the way, I've considered testing sgnents of different sizes, but it's
> not very easy to set for user parameters, so I set it with each
> scatterlist entry corresponds to a single page.

This is a bit odd. Ideally, we shouldn=E2=80=99t have a mixed definition
for a single variant, but since this is just a tool, it may be
acceptable.

That said, the documentation should at least be updated in
patches 2/3 and 3/3. As it stands, it still says:

    __u32 granule; /* how many PAGE_SIZE are mapped or unmapped
                     at a time */


>
> Thanks,
> Qinxin
>
