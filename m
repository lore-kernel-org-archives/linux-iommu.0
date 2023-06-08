Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606461DCDC
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 21:29:51 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b025aaeddbso218735ad.1
        for <iommu@lists.linux.dev>; Thu, 08 Jun 2023 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686259790; x=1688851790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPMX3DxkVJhj7lf4jDhD9vLnRpY/TahAr2KcouQNqJU=;
        b=rZwE7u5t0AIZFJMCoI4PdGTWbulL6GlnNEFCDJr7E35BzfJ2IcB7ceWyv2O6CICHI/
         TR+2G5IUq96MRqjBI5Kzgjny2zKaU0yZPyI9aJOiYMz3GVx/s+JiP/GaLuTKXYq7v4nW
         k+gYs+hRbi/J3fc7zgUXrjDxX+s7NUU2/SeK3ApYDh37pX2Kqr30WvbNLXPz0CXbnyGK
         EQSf9wNRD2JkUMJH69yEgKdzA21x0e8JkM9UpPpGuapM0x2VBCVIM38vxVI8PPOcucUm
         3IN+gXAoOiCcfzzqdJ0wTK0DgYJBMj623K6mjvIzpzpK8/lErtKvJP1Qgg/T4etxqeDS
         JQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686259790; x=1688851790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPMX3DxkVJhj7lf4jDhD9vLnRpY/TahAr2KcouQNqJU=;
        b=Pe8FvJRCDbskM9GBMKt+U8MftCL8ZF53XmiaVrH4aMKCG20c0SA9Y8E76p77fEjxnN
         WD/qNCTOoMerptyJ94Jrh/xEoXORusalpPUg5NetZIOreiy7nDqoLXJky1Ryl8WOLwSF
         J7GZurXOBtk/Wz4CKJGMqPrE9vggNx8eUs3k51FUYtHFCop+uUCrl+UR2+BLDvQB3LMp
         9jOrolrr5eCMQkjno2fsvgP7OMvVeTm114ZTqLUT1ulcG58Miz+Gu9ZyjMY2MmbMQZNp
         GFc24CooASrIBoc6qATNxpS/0mTyGOmQ0jKphkIfpHCKO0I0AV0RQWdmM1qwer4nVC0R
         7mdA==
X-Gm-Message-State: AC+VfDyOvuQ98o9fjyvBBgd1+qc4dywmdohHyNrVQ3zePFzOkkZJLdbH
	j7kO8QoZmdESiFNqENfMFUVmsvgs5B8E1lvvH/WVYwud
X-Google-Smtp-Source: ACHHUZ7Vs6qzJH+VcgreX92TC329JG3kDA6Q+8+cdy9l79gr20/DdHFIZsTryE+7bHyM6AlKe1iJ/Q==
X-Received: by 2002:a17:902:facd:b0:1b2:4a18:7498 with SMTP id ld13-20020a170902facd00b001b24a187498mr199961plb.0.1686259790457;
        Thu, 08 Jun 2023 14:29:50 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:77e2:95e6:b73c:3950])
        by smtp.gmail.com with ESMTPSA id y34-20020a634b22000000b00528b78ddbcesm1653151pga.70.2023.06.08.14.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 14:29:49 -0700 (PDT)
Date: Thu, 8 Jun 2023 14:29:45 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZIJISbauzCR/oKby@google.com>
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
 <CABfwK12_wC1t5J9c8qRmUi9H4GtYc6KR9oeJPi8ucK36prhUzQ@mail.gmail.com>
 <CAMj1kXHP_57EOOYQtuL2NO9=7sHPxrX=c0ayYwHaYx9x9hxhJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXHP_57EOOYQtuL2NO9=7sHPxrX=c0ayYwHaYx9x9hxhJw@mail.gmail.com>

On Thu, Jun 08, 2023 at 10:05:58AM +0200, Ard Biesheuvel wrote:
> On Thu, 8 Jun 2023 at 07:45, Isaac Manjarres <isaacmanjarres@google.com> wrote:
> >
> > On Wed, May 31, 2023 at 8:48 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > Here's version 6 of the series reducing the kmalloc() minimum alignment
> > > on arm64 to 8 (from 128). There are patches already to do the same for
> > > riscv (pretty straight-forward after this series).
> > Thanks, Catalin for getting these patches out. Please add my "Tested-by:" tag
> > for the series:
> >
> > Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> >
> > With the first 11 patches, I observed a reduction of 18.4 MB
> > in the slab memory footprint on my Pixel 6 device. After applying the
> > rest of the patches in the series, I observed a total reduction of
> > 26.5 MB in the
> > slab memory footprint on my device. These are great results!
> >
> 
> It would also be good to get an insight into how much bouncing is
> going on in this case, given that (AFAIK) Pixel 6 uses non-cache
> coherent DMA.

I enabled the "swiotlb_bounced" trace event from the kernel command line
to see if anything was being bounced. It turns out that for Pixel 6
there are non-coherent DMA transfers occurring, but none of the
transfers that are in either the DMA_FROM_DEVICE or
DMA_BIDIRECTIONAL directions are small enough to require bouncing.

--Isaac

P.S. I noticed that the trace_swiotlb_bounced() tracepoint may not be
invoked even though bouncing occurs. For example, in the dma-iommu path,
swiotlb_tbl_map_single() is called when bouncing, instead of
swiotlb_map(), which is what ends up calling trace_swiotlb_bounced().

Would it make sense to move the call to trace_swiotlb_bounced() to
swiotlb_tbl_map_single() since that function is always invoked?
