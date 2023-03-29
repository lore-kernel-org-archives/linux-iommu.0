Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB48AFFE
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 15:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680104335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNc56yZE3f0/ZsxafHFx8d8Um4Kx4OUbmVJ42ZTNjo8=;
	b=cd5i+ySs2JFWf6+1EU9EG4GuN56lqPUlxmkHN5BrawT2Aa0twh+2ICmDfBscEEita3O3it
	APeNBJ//lYTSSsAeTu0hhSJBljqpNvrXnDt6CX7n0YGelhW14IyvNc/aa1/9XlUHx293Qr
	nFEr2bbuNAqAdcwa+Tb9+Llx/8WGROw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-bnkNCUVTPVOmFhR98y7HIQ-1; Wed, 29 Mar 2023 11:38:54 -0400
X-MC-Unique: bnkNCUVTPVOmFhR98y7HIQ-1
Received: by mail-qk1-f198.google.com with SMTP id s21-20020a05620a0bd500b0074234f33f24so7399663qki.3
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 08:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNc56yZE3f0/ZsxafHFx8d8Um4Kx4OUbmVJ42ZTNjo8=;
        b=8E/twRiEHTpgymVWdASl+5ASRjISK+EaoyY89FEhnXkCCpeuaC+4jgYpjbf2PYC7w/
         LKUnic08Xy6rytHtcLw1WKV9hrKh7IhkUpudQFNzVSMcmGJtZSSWmuQlNyZALhSxbYj7
         7BJ1NtaNFxJB/R3YQbNA19QGtI5W4eJ0C5iig9Q0xmDxeuhy/y0sqsOEVWdbUdim6kXq
         s7saWHAFz17mrEgMRUiRSt3CDh6/PDHw8A8LMi+6fLGg/yc6EpoqaAbTbCMpgfF056hC
         fChAtUYUDSK2POU6xiO361g5JR4jroAfFDeKWukiKfkbewGW0fYyrQ4m21Y+/Y13SU6h
         NLAA==
X-Gm-Message-State: AO0yUKU3M5WZHymWNtDVgK4rsRh7yA3itjVuMD/uxj+qs/IAJ0PeOUHz
	7PQBOWTF/qlJzmv7b75SRTFW5t9YhM7KdD+QVE7HRYRrD36ErIvCkukVY2mclHswuxvHs9oULdl
	CpqNvv5/fM899UN8=
X-Received: by 2002:a05:622a:11cc:b0:3dc:ce21:6f87 with SMTP id n12-20020a05622a11cc00b003dcce216f87mr32315933qtk.11.1680104333981;
        Wed, 29 Mar 2023 08:38:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set8BQYRlPEhXzf93lrSn8foMmX/OnCLu3jZm4AZeY/wbrQvddGOo944faH5Z9J6Py0hDAeGQQw==
X-Received: by 2002:a05:622a:11cc:b0:3dc:ce21:6f87 with SMTP id n12-20020a05622a11cc00b003dcce216f87mr32315897qtk.11.1680104333742;
        Wed, 29 Mar 2023 08:38:53 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id 123-20020a370381000000b00746a7945d87sm9494746qkd.52.2023.03.29.08.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:38:53 -0700 (PDT)
Date: Wed, 29 Mar 2023 08:38:51 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Desnes Nunes <desnesn@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, noreply@ellerman.id.au
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
Message-ID: <hw7djtdwttjwqhnpwidl2g3k7zxoepy7g54ehwatbchjjxahhc@al2t2da3pylo>
References: <20230329071405.1568021-1-geert+renesas@glider.be>
 <2w7rzdbzbii4ewliym6qw4svf2mzptsccz23yms5lsdioflcti@w63kwgzkra6r>
 <CAMuHMdVRqbe4Af72H0uqYrRJHJweiMYawUn4vK-9Xt7b7FLDfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVRqbe4Af72H0uqYrRJHJweiMYawUn4vK-9Xt7b7FLDfQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 29, 2023 at 05:34:23PM +0200, Geert Uytterhoeven wrote:
> Hi Jerry,
> 
> On Wed, Mar 29, 2023 at 5:03 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> > On Wed, Mar 29, 2023 at 09:14:05AM +0200, Geert Uytterhoeven wrote:
> > > On 32-bit without LPAE:
> > >
> > >     kernel/dma/debug.c: In function ‘debug_dma_dump_mappings’:
> > >     kernel/dma/debug.c:537:7: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 9 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
> > >     kernel/dma/debug.c: In function ‘dump_show’:
> > >     kernel/dma/debug.c:568:59: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 11 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
> > >
> > > Fixes: bd89d69a529fbef3 ("dma-debug: add cacheline to user/kernel space dump messages")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Link: https://lore.kernel.org/r/202303160548.ReyuTsGD-lkp@intel.com
> > > Reported-by: noreply@ellerman.id.au
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> =
> > > --- a/kernel/dma/debug.c
> > > +++ b/kernel/dma/debug.c
> > > @@ -534,11 +534,11 @@ void debug_dma_dump_mappings(struct device *dev)
> > >                       if (!dev || dev == entry->dev) {
> > >                               cln = to_cacheline_number(entry);
> > >                               dev_info(entry->dev,
> > > -                                      "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
> > > +                                      "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
> > >                                        type2name[entry->type], idx,
> > >                                        phys_addr(entry), entry->pfn,
> > >                                        entry->dev_addr, entry->size,
> > > -                                      cln, dir2name[entry->direction],
> > > +                                      &cln, dir2name[entry->direction],
> >
> > Won't this just print out the address of cln declared at the beginning of debug_dma_dump_mappings() each time, instead of the value
> > returned from to_cacheline_entry() ?
> 
> The physical address is passed by reference, cfr.
> https://elixir.bootlin.com/linux/latest/source/Documentation/core-api/printk-formats.rst#L231
> 
> Gr{oetje,eeting}s,
> 
>                         Geert

Got it. Thanks Geert

snits

> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

