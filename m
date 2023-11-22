Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DDC4C3CE
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DFzs9ASI"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b83c4c5aefso50778b6e.1
        for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700675458; x=1701280258; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nz8V9rweqecmN/L6SV+gBbsJ4Hg3ddyVevYX1Lj6BmI=;
        b=DFzs9ASIiL/YLYbdyxw5U1WbXYv6nS1paOwNY9R3JBOje3dBK3zAiZjLHUY9+6781v
         5NfZuPpz45VM08HcTcjaX/jMA+7DbMBdu6ZohAgaOYed3SXux849yt2x3wH/b61TDnm0
         gW4d0acJXaDt/FFIR9MQNmNYhirQVfwV1IG9NwhWWk+/atxiEIEfEeU4wJ+g5hXz95i2
         tYu2CxyDR1pRdhAkPtaYjQhNKQiRaGAqmVnYaUemWJgr91eCQHT6VroMIbfI4ZoDo6BY
         2vJiKbs44BYtgwMzyZqVzmYIpUQZMlP204+KVfF2axsTsMUVkoZRE1PU+rx5x6+4M0pX
         qwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675458; x=1701280258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nz8V9rweqecmN/L6SV+gBbsJ4Hg3ddyVevYX1Lj6BmI=;
        b=B6Emhq9QnYiuC742nD/z1QhUH9qrB+NNjudjmbXqtJPncKPK+yOzyu3KyGD8aekOIz
         2TPe6wowKc395KGKV4Dq2YDH48tOc+YzyUKc+hyMFQrYreLkOyDyBk1KOPGZY8P8WdzQ
         k/Q3nX2FooXFIxSAjHrgSdt2O6roA1q+R9LSVTq46U07SJDkuONfYcYtzpz852p1J/MT
         7dK/EvvY5r74W7hHOFPZWWbJCnRNrRxplux0nk1shk2VVBP5HywPJx0dbYXI749xAYPj
         DHvGqOLBijbg3KIG+slGAQEW2TPXWFU6YsP7JkT36TVUlmw4f5gHebBxudzcfjjbqDNZ
         TgWQ==
X-Gm-Message-State: AOJu0YxgF6I8PDwagTaERtxbMoMxovSe1nIDmJzS1tqccgqGXL9AGm2C
	V0Gj3zh4QqbZ0EGW6msCiHDibw==
X-Google-Smtp-Source: AGHT+IE+sHgWkgjDL3HKxojzOCpNaYYUzNGrbePDWKzfLgoTlvyEA+capCzFwvDnlBFWeg+wqRDriA==
X-Received: by 2002:a05:6808:2224:b0:3b8:3ddd:d490 with SMTP id bd36-20020a056808222400b003b83dddd490mr3304098oib.59.1700675457762;
        Wed, 22 Nov 2023 09:50:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id z19-20020a056808029300b003a78d196acasm7520oic.32.2023.11.22.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:50:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r5rNH-001ftT-QO;
	Wed, 22 Nov 2023 13:50:55 -0400
Date: Wed, 22 Nov 2023 13:50:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <20231122175055.GI10140@ziepe.ca>
References: <20231110201652.629b7228@collabora.com>
 <20231110194215.GR4488@nvidia.com>
 <20231113101103.1cc05c8c@collabora.com>
 <ZVOgBBEetWf1PFxX@nvidia.com>
 <20231120140425.GA10140@ziepe.ca>
 <20231120153838.2166e7b8@collabora.com>
 <20231120144604.GD10140@ziepe.ca>
 <20231120161418.5eca178e@collabora.com>
 <20231120154536.GE10140@ziepe.ca>
 <6e74bd37-9e10-416e-9fbd-0cebb7948e2b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e74bd37-9e10-416e-9fbd-0cebb7948e2b@arm.com>

On Wed, Nov 22, 2023 at 05:23:34PM +0000, Robin Murphy wrote:
> > Gaurav doesn't need a custom allocator, he needs a way to manage
> > sharing page table memory with the hypervisor. A different set of ops
> > that don't replace the entire allocator would be fine for them.
> > 
> > The issue with taking away the alloc_page is that it complicates the
> > ability for the common code to use the struct page fields and more. We
> > already know we are going to need those to do some of the things that
> > are being asked for, eg RCU freeing and refcounting.
> 
> Oh come on, for all the things you claim are simple, you don't think it's
> trivial to make the fancy stuff conditional? (Hint: we already have control
> flow all over which is conditional on the cfg and/or calling context, and
> that future stuff may well end up wanting to be conditional in its own right
> anyway since not all io-pgtable-arm users will need or want it).

I really don't want to make it conditional! I'd want to have one
common set of radix algorithms shared by the enterprise IOMMUs, so we
can actually improve those drivers and get all the special features
people want without writing everything 5 times.

> > Here I am not talking about perfection, I am concerned about messing
> > up work that I now see as important for other iommu drivers related
> > things by making a hack for a DRM driver (which as I've said has,
> > unravelling these hacks has been traumatic for many of us
> > historically)
> 
> In your own words, this is a community effort. You do not own this code, and
> you do not get to prevent the community from solving multiple problems they
> have now, in a way which is reasonable now, just because *you* don't like
> it, and *you* believe it might possibly make it harder to do something at
> some indeterminate point in future. Your objection is noted, but as above, I
> for one do not see a convincing basis for it anyway.

I've said already it is my opinion, if you want to bring another one
then you can particpate too. Thank you for noting my objection.

> You know what *the community* sees as important? Not having to maintain
> multiple copies of near-identical pagetable code, because maintenance is an
> established and very real concern. 

What I heard at LPC is we badly need to stop maintaining independent
radix algorithms across at least the enterprise iommu drivers. This
was clearly an articulated need for many different people *from the
community*.

> This is why we have the io-pgtable
> library in the first place, and why we adapted io-pgtable-arm to support
> panfrost when that came along. If supporting panfrost and panthor as
> io-pgtable users really does ever become a practical problem at some point
> in the future, we will work to address that problem at that point.

You mean Joao or myself will get stuck with it. Not "we". :(

> meantime, we can get on with the common goal of making Linux do the things
> people want it to do, in the best way that the maintainers are happy to
> maintain. This is not "a hack for a DRM driver", it's a simple and
> convenient generalisation of part of io-pgtable, in keeping with the design
> of io-pgtable (user-provided callbacks are nothing new), and
> straightforwardly serving at least two completely different use-cases
> already.

I've already explained to Boris, and he agreed, that it is the *wrong*
generalization because it is implementing a generally useful algorithm
in the DRM driver and keeping it out of the core code.

If we deliberately do the wrong thing then, yes, it is a hack.

Jason
