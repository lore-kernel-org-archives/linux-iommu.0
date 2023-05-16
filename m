Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C430107A5
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 18:19:28 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ae3f74c98bso10505ad.1
        for <iommu@lists.linux.dev>; Tue, 16 May 2023 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684261168; x=1686853168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hnujQIGnrKrvLF8j2U/POTslbNBCDtRpy4BK62wtAF8=;
        b=3bKAHTvYQyO/brVIc1IMrdaoFfCBkLctq4Zb7NTxNHIrbn6f8fUd1pH9iHS06GNijW
         qVKtvEtuLqo4nMrw/GLP2IsVLrrmMkJvgLbfM8XV8dKpF4xfgo4ETGtBBp9zYo3iWNfo
         7LNMsrv5vaSiZ0xmYl5bG2BeC59EZ76n1olLQktzyu6aOJD5dLaG/tZmAwiJdPQOM6U5
         401rX5HzxpiJ73bzZPOV06pay4MI/gehzyVVUIhUp3mF+gs8KADF94ylzYcyTq7nIEhZ
         oQWeevdmnl4LsmYlGj8vbNWS9lcHADKgz02M/AJYjRqHorVEaYEnOAxPF1CdX0V/RnWZ
         RmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261168; x=1686853168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnujQIGnrKrvLF8j2U/POTslbNBCDtRpy4BK62wtAF8=;
        b=AuRp+QqTKFmkrUV2NHdPNJeH6eMF6KbQkbQXWnhDJg8H7lZ7e0yMBy4Bvsn/0v4Kkx
         yMo+qQn0Qk5c1laA2AxtzNRUhH3/4JF5F3JSoFJxJGHfX174Et9PHVsz8RjMKaUfT/eD
         31Zd8xmCV4JVWaFVRrk5LStMWO8Ms5YAHY5ixAR5ueMwfCOqE3shimIwcq10K2ETKz4c
         nqOGy9q1KoXa0ZKrzv931yNZWHjS17JOIS4XhlrqUqqGfZeS5RAznzQUK/xjeHve/Ts0
         /LmzOvO+pIPIgpamZW0xDq+zLpGodk2+IvMfBOFZM2ZpbsZUl4aYhudKRhi/wI76bYyo
         WvFA==
X-Gm-Message-State: AC+VfDxZU20WkXKshMIBOu17m152lokgWIBfMppq5aCCXyVwnHMeId+P
	AmfI4f43EGJTg1zRek60GtM9kw==
X-Google-Smtp-Source: ACHHUZ45WumG7sRiSKKxNUeVxPh+M46qd/Nuj3/4l0Bzt6CPpdXbJTPt8n03GszfoPTeFsj+7ZnZZw==
X-Received: by 2002:a17:902:d4c5:b0:1aa:e90c:d437 with SMTP id o5-20020a170902d4c500b001aae90cd437mr15026plg.8.1684261167679;
        Tue, 16 May 2023 11:19:27 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:fd80:d223:d66f:530f])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902b40500b0019a6cce2060sm15837904plr.57.2023.05.16.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:19:26 -0700 (PDT)
Date: Tue, 16 May 2023 11:19:22 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Petr Tesarik <petrtesarik@huaweicloud.com>
Subject: Re: [PATCH v3 00/13] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZGPJKq5ME2r6KIFt@google.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <ZBNiN9CR2F/fvUTh@google.com>
 <ZEARbKMfMS8KdkhJ@arm.com>
 <ZGKDWMqTt/f05AmG@google.com>
 <ZGO7L9EyDEXU6zWf@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGO7L9EyDEXU6zWf@arm.com>

On Tue, May 16, 2023 at 06:19:43PM +0100, Catalin Marinas wrote:
> On Mon, May 15, 2023 at 12:09:12PM -0700, Isaac Manjarres wrote:
> > Hey Catalin, just following up on this. I think it might be worthwhile
> > to split this series into two series:
> > 
> > Series 1: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN,
> > and use the cacheline size to determine the minimum kmalloc
> > alignment.
> > 
> > Series 2: Lower the minimum kmalloc alignment to 8 bytes by adding
> > support for using SWIOTLB to bounce unaligned kmalloc buffers for DMA
> > transactions.
> 
> I attempted "series 1" some time ago and the discussion led to the
> combined approach (i.e. don't bother with limiting kmalloc minimum
> alignment to cache_line_size() but instead bounce those small buffers).
> In my series, I still have this fallback in case there's no swiotlb
> buffer.

> I'll post a new series this week (including DMA bouncing) but I'll try
> to move the bouncing towards the end of the series in case there are
> more discussions around this, at least the first part could be picked
> up.

Thanks Catalin! I think restructuring the series as you're suggesting
makes sense. At least being able to pick up the first part of the series
would be great, since it will have a positive impact on the memory
footprint for a lot of devices. This also helps alleviate some of the
memory overhead for devices that move from a 32-bit ARM kernel to a
64-bit ARM kernel.

The second part can continue to be refined until the SWIOTLB and IOMMU bounce
buffering refactor is complete.

-Isaac
