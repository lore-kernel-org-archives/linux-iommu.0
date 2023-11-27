Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27BE20F9
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjVn0ZNV"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c997447ff9so19426711fa.0
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 00:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701075418; x=1701680218; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4j+WUhsI6HLaQhNpMAvxRSBO5fBvP0PmC3kAAmj31Q=;
        b=JjVn0ZNVT6TysrPidbptYSmc8nfn5AwiXntsv9GgVAluNaeLDhSIJtKwA7B7Ug4jp3
         UEjuJ+Xdft6rIUOPJFY3Hiy5amT02LgsFPRsq6nbGer9KygRVQFBB1+RpokgdSOcqwwW
         CXjzCrt4OVjX++BjxtUnvEYIt6WoXSP9nxdtcK20nQu+eBFsqszBpYHQMhfjUjcet84D
         ZFOb68CALChNiICu7337XvvzvFOCH7CxSXYlqhl+6mldNlcAg9irpJRhWhtEnjvNwvcG
         +xxuPPRxqma0I2lBjPok4DcqZQY+iDHMtA9HuKi3lB2/9ax9OZXI+LkQuylBh/iKOYnu
         dOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075418; x=1701680218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4j+WUhsI6HLaQhNpMAvxRSBO5fBvP0PmC3kAAmj31Q=;
        b=NulaVY/hCyWaOsRSz+QKwp3wRvmpeHI6r20zD7K6LzbkwRWKaNJSJpXRUzGDeLPWdv
         73LURG5hNXzp4qKCfWsbzBU7zFsv1krRXvoNW1jTKh6RKZY5hrwC3v1m18ge8tEWpzq6
         bsD+HeoBkxyNic1v51tJ0KmVZ3oKo+1Iiix22ONitNAYHY9CNFvlwHZF4SRVapmVnmCW
         rvIK3332dER89DUDL7KiRp10o6IWGp20/lhfcvk196XpgAIOhpymetiEBojMzgrEswMD
         3JL8Cn0/dgS81ylxPyg4AJIjYinjnnwtJ0E1dHaLff57FunSHq+diMp1gQPHB2sdyyXh
         l/Og==
X-Gm-Message-State: AOJu0YxqtuOrcyukcYfHnZZcciooxnNm0Qi8vc6YnUvghM5hxlnCajeY
	JNQHjdSRWfu67ZvluDLrJCR+9yo3l+vprB8oOWY=
X-Google-Smtp-Source: AGHT+IF4Kbz8DWKARcdVUBkG6k/D9a5BYFVuw/h+Mioxpz8AW7vu4HyqBiXrNT5efzM4LMrKaN1/67x8vXH2BKAHuto=
X-Received: by 2002:a05:651c:317:b0:2c9:9ce3:dfd3 with SMTP id
 a23-20020a05651c031700b002c99ce3dfd3mr2179971ljp.0.1701075417464; Mon, 27 Nov
 2023 00:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com> <20231127071430.GA28214@lst.de>
In-Reply-To: <20231127071430.GA28214@lst.de>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Mon, 27 Nov 2023 16:56:45 +0800
Message-ID: <CAGWkznFf5hdFRomLXDzoxEKVgiKY--DFbHjRLAMvgvodA01EFw@mail.gmail.com>
Subject: Re: [PATCH] kernel: dma: let dma use vmalloc area
To: Christoph Hellwig <hch@lst.de>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 3:14=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Nov 27, 2023 at 11:09:30AM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > memremap within dma_init_coherent_memory will map the given phys_addr
> > into vmalloc area if the pa is not found during iterating iomem_resourc=
es,
> > which conflict the rejection of vmalloc area in dma_map_single_attrs.
>
> I can't parse this sentence.
Sorry for the confusion, please find below codes for more information.
dma_init_coherent_memory
    memremap
        addr =3D ioremap_wt(offset, size);
What I mean is addr is a vmalloc address, which is implicitly mapped
by dma's framework and not be aware of to the driver.
>
> > IMO, it is find to let all valid virtual address be valid for DMA as th=
e
> > user will keep corresponding RAM safe for transfer.
>
> No, vmalloc address can't be passed to map_single.  You need to pass
> the page to dma_map_page, and explicitly mange cache consistency
> using the invalidate_kernel_vmap_range and flush_kernel_vmap_range
> helpers.
Please correct me if I am wrong. According to my understanding, cache
consistency could be solved inside dma_map_page via either
dma_direct_map_page(swio/arch_sync_dma_for_device) or ops->map_page.
The original thought of rejecting vmalloc is that this pa is not safe
as this mapping could go in any time. What I am suggesting is to let
this kind of va be enrolled.

 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *pt=
r,
                size_t size, enum dma_data_direction dir, unsigned long att=
rs)
 {
       /* DMA must never operate on areas that might be remapped. */
       if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
                         "rejecting DMA map of vmalloc memory\n"))
               return DMA_MAPPING_ERROR;

>
