Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84757630
	for <iommu@lists.linux.dev>; Fri,  7 Jul 2023 00:42:03 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1b88f151d8eso85775ad.0
        for <iommu@lists.linux.dev>; Thu, 06 Jul 2023 17:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688690523; x=1691282523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCyACxMAwu61UikiAif4y4Wc/o7nUyK6gIA9C5b1z4E=;
        b=hwNq4kHUFQI6x1rTaOwo96kkZ2B16Y4NVMhPNfED99XptiI2gLElqTNZSetDJhYL7j
         se+vhpRsznvDKqPwEDTSBOev5w6P9KB+DoeSXRt5I3UeDaGQoTu3Tj7PuMSqi/AiMIyX
         g70+8ctk9ibLGmC3cR8W63408Hmnp2wMf3Xf7GDow/Qk8VQNqHBAn4qVtelUOvpDUpRn
         enwIm/67mROe6whUe+JdAtH0khSXiVNSE/xS8M9H25JvgLnoujm5Ryc/O1dYTvqn9vbe
         IWWdCaurX+Pct+xHyJKyWQydO5offhVXv6sKm/DmEdgVceWs/eh6E5YV+SsJ5XDj9AW/
         Eqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688690523; x=1691282523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCyACxMAwu61UikiAif4y4Wc/o7nUyK6gIA9C5b1z4E=;
        b=L86X10TTPC04ZGq/+9Bri0G/9q6d1wyHxBALu5y2lyQhtxjS6YU0h7DR7FYWLuwGt8
         hAoxbMubq16ZG0fmeKl8JAnQK9XFhj7La6xdPSIq7kH9pQbiS45+CznxzNkcDjwTCGja
         w5YLefGmh+b9S6FTvF8p7xqkqUB5BmqN3gwbkxO8N0Y+eZENUQG2AzsE7y5K1u3RguUw
         PyRWFuAXYISQTKL8iiw/QCVYDD8I4z+R0GV75Fva6NI1TWfH1DlnSXwQY/ltm1Oohxy+
         uBrhc8Mfgriq/c9r2LtyW8x+/l7+fd/aDL6tmE/a2URvvNULMmiDj9ZC6LHtamd1nH4I
         bHeQ==
X-Gm-Message-State: ABy/qLaiFUvnkdKPhAy0Zg6B+UCL98e/6l6c0twsq0P/l7qs2MFbbWUX
	cxUMVjRMydbxpmaXAZCRyH0v4Q==
X-Google-Smtp-Source: APBJJlH5srUuDgu+mX6fEyDEJnUWImMyBSSXnJ0UNtJRcpgynXXRTgag+BoqCLRFTXTJiNOWECKXmg==
X-Received: by 2002:a17:902:db11:b0:1b8:ac40:35ed with SMTP id m17-20020a170902db1100b001b8ac4035edmr118524plx.24.1688690522629;
        Thu, 06 Jul 2023 17:42:02 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:634a:24d:a19f:a90f])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b001b80760fd04sm1966581pla.112.2023.07.06.17.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 17:42:02 -0700 (PDT)
Date: Thu, 6 Jul 2023 17:41:57 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v7 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZKdfVSzbgOonR17A@google.com>
References: <20230612153201.554742-1-catalin.marinas@arm.com>
 <CAMi1Hd04mu6JojT3y6wyN2YeVkPR5R3qnkKJ8iR8if_YByCn4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd04mu6JojT3y6wyN2YeVkPR5R3qnkKJ8iR8if_YByCn4w@mail.gmail.com>

On Wed, Jul 05, 2023 at 07:10:02PM +0530, Amit Pundir wrote:
> Hi Catalin,
> 
> On Wed, 5 Jul 2023 at 18:17, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > Hi,
> >
> > That's v7 of the series reducing the kmalloc() minimum alignment on
> > arm64 to 8 (from 128). There's no new/different functionality, mostly
> > cosmetic changes and acks/tested-bys.
> >
> > Andrew, if there are no further comments or objections to this version,
> > are you ok to take the series through the mm tree? The arm64 changes are
> > fairly small. Alternatively, I can push it into linux-next now to give
> > it some wider exposure and decide whether to upstream it when the
> > merging window opens. Thanks.
> 
> This patch series broke Dragonboard 845c (SDM845) running AOSP.
> With this series I run into random oops at __kmem_cache_alloc_node().
> Here is one such boot log https://bugs.linaro.org/attachment.cgi?id=1146

Hey Amit,

From the log that you linked, this looks like there's corruption within
the kmalloc slab caches. Can you please try enabling slub debug? That
might give us more information about who is causing the corruption
you're seeing here.

To enable slub debug, you can add the following to your kernel config:

CONFIG_SLUB_DEBUG=y

and CONFIG_SLUB_DEBUG_ON=y or add slub_debug to the kernel command line.

--Isaac
