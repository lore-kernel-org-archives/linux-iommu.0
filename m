Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA379C1
	for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 18:48:25 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id q12so13583701pfn.10
        for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 10:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQkRh/zM8UmfkMC06DRorx1Y0k2ZsCD/+Fu4/2OaKKc=;
        b=KElmZvHJRpG7wHvswrXYwocLEjK0lPvrdzTgeCwBLxRR9pf8kccPQtT/lGjSOXkNpn
         RnJaL5gRFhxHipd1dSrkxRpzJKmcsBXtPdp7P7jZoZa9tMaAqEmTSqY0Z15XZkNWtFMw
         n+PLMjZ+Vhp/otWzDucp0dDPOwkX27wL5VvwO00YJIaBdcdysov5TGpr0F1F3YXaSm4f
         ZQWw/rCuTQgoyaTp4an6DT7BMskcAA0mqDyQ11s0a6VGpdpVkIHJnzzymX1XWR1aTpc0
         cjm+8Gz9gy/U/H88d82lEl85AzYq9ZPkb5pMZJqFDsqg5j1Dle12R651Ub/lLaDw62/H
         yaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQkRh/zM8UmfkMC06DRorx1Y0k2ZsCD/+Fu4/2OaKKc=;
        b=i2XqLLiHseqfwlAk4TE2N8cZqdYKVKAfCRM9s2J6CxqopenVOK4/ZSQi4q8xv4XVuE
         yx5RPooDhFIqzlEDFRvD/0nvVd4r0nvCtBJT082YF7VX442lij2RZyh/WOZgC7s6KrMp
         cNo5rnnmwllVHSw7GXxcSb35kRiFyvEX+Gi8xpWw/mUMU3bqkrT1TOuj8/INBi4alvij
         jk7ey4I/Q/xP8xggPMb/Uby+hXsqro+oNn6/PdBb3dIUxPRrRVJE1sRmuOOaxCFvwfqI
         X3vPI/OfVXmjMdYezfG719ETw5fqqVHhLrk7+fkn+2Z5CrTKCPAxAuCgAJ4M4+GOUFqg
         lmGg==
X-Gm-Message-State: ANoB5plYlCWpRen5L/+AfR1tx/pv1yY7dyCZtqGLsf5V4/BTMY9quu7q
	VFVDY4gLS5n0nTc+VLUYD/gXlg==
X-Google-Smtp-Source: AA0mqf6NDbn8/fXdCVhPO/4JABlNnzY/bES/E5MrelK7mS0zIK49Tw//Uphb303yWtO0iEC/b3scHQ==
X-Received: by 2002:a62:d10b:0:b0:575:ad52:ba94 with SMTP id z11-20020a62d10b000000b00575ad52ba94mr7820654pfg.74.1669834105040;
        Wed, 30 Nov 2022 10:48:25 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:9968:7291:c9a7:7a22])
        by smtp.gmail.com with ESMTPSA id 7-20020a621707000000b00575a9768edasm1699875pfx.191.2022.11.30.10.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:48:24 -0800 (PST)
Date: Wed, 30 Nov 2022 10:48:20 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: agraf@csgraf.de
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 13/13] dma: arm64: Add
 CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and enable it for arm64
Message-ID: <Y4eldGXZjpi2L2SQ@google.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-14-catalin.marinas@arm.com>
 <6e846f75-b330-9523-4356-41d5f9e48f12@arm.com>
 <Y2omz6pibSUNPtHu@arm.com>
 <20221108100331.GA31944@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108100331.GA31944@lst.de>

On Tue, Nov 08, 2022 at 11:03:31AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 08, 2022 at 09:52:15AM +0000, Catalin Marinas wrote:
> > Since it's hard to guess the optimal swiotlb buffer for such platforms,
> > I think a follow-up step would be to use the DMA coherent pool for
> > bouncing if no swiotlb buffer is available. At least the pool can grow
> > dynamically. Yet another option would be to increase the swiotlb buffer
> > at run-time but it has an overhead for is_swiotlb_buffer().
> 
> Alex said he wanted to look into growing the swiotlb buffer on demand
> for other reason, so adding him to Cc to check if there has been any
> progress on that.
Hi Alex,

Did you get a chance to look into this? If so, have you been able to
make progress on being able to grow the SWIOTLB buffer on demand?

Thanks,
Isaac
