Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552A18C18
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 19:09:18 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ac65ab7432so747245ad.0
        for <iommu@lists.linux.dev>; Mon, 15 May 2023 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684177758; x=1686769758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NScEF4DUT2RK1kg1ycQM1CBgCg/fSirJtyzV/whK0J0=;
        b=OC0n6O9mt8GEKWsOuiJlnAMyqeZY0/5tkzV4mYOVlaKSWY/9pW0fmBpr1lTRRaY+kx
         zmTHiiXRSd5rL/KZBC/d5bJY7dwa3Z9nYpiykc5TkluI4pfv2JZQbHN5W1q02vevK64P
         mUYLgKP2lJ9ANa5mCrBgiTBq473BLqTADQfY89IHqfhYx1RlFkAHR5G4ytTwaX95J4BP
         5oZSFQa0Vpgrx7t7MkcF5DH0/GKNVwYK1ScMJPbrOsgpit1nwJR6/5ZG3Ll6ESaOYBgX
         e5XFltTBPFiU0N2Af/eN5yTe5I2EQlthcMUKOqOfxpmkzBw2dIBtcBm3taDJYVD6xs0j
         nvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684177758; x=1686769758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NScEF4DUT2RK1kg1ycQM1CBgCg/fSirJtyzV/whK0J0=;
        b=ihKwc/Wthmy5bR6XI/mykuSn+f5yO2wsONV6h2rAuMvS7UHvD9mtzhLImV6qIIeBNQ
         rFqxqt1ljoSjAwTaz8YNtBCB9N9z+V5wzhJkfPVzGiUBd6do8gSCVclQnvlZEirTplJf
         H1wEvDnovDelUmsZGrYJy8/mzczPXsnOVx7KJxv7/HZVKzX5z3xLZ3dm4SClcMnNYoe1
         w+siStWjc0M4qFjztoCL+BJSISeqrwLQOECPZWlsIp0tLhJrRBZd8BqmUBt+Y4bTIVK6
         g573Gj+vj60uOh4UmQBvo9rsPa7WychmYPVBAFGL+MZU3BOXM2znMzK4Q6UYgSG4ekeE
         c7DQ==
X-Gm-Message-State: AC+VfDx35V4t81h8J0wdCjddGbYQP8gfC2XBYdOZjnURiwsm70nApOHF
	MtPTSg6xLO9STOu0ZF+xSgNDIA==
X-Google-Smtp-Source: ACHHUZ6ZwVUoftc1tRpuaAlUdt1ybXqL+4C27qcMcoX/qt34Q62hQcY9bonn36MRLP7Pkq4ToUtlhQ==
X-Received: by 2002:a17:902:ea02:b0:1a9:bb1d:64e with SMTP id s2-20020a170902ea0200b001a9bb1d064emr8433plg.15.1684177757962;
        Mon, 15 May 2023 12:09:17 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:b860:7e3e:331f:4d8b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902768500b001a682a195basm13906296pll.28.2023.05.15.12.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:09:17 -0700 (PDT)
Date: Mon, 15 May 2023 12:09:12 -0700
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
Message-ID: <ZGKDWMqTt/f05AmG@google.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <ZBNiN9CR2F/fvUTh@google.com>
 <ZEARbKMfMS8KdkhJ@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEARbKMfMS8KdkhJ@arm.com>

On Wed, Apr 19, 2023 at 05:06:04PM +0100, Catalin Marinas wrote:
> I rebased it locally but the last stumbling block is sorting out the
> iommu bouncing. I was hoping Robin Murphy can lend a hand but he's been
> busy with other bits. I'll repost the series at 6.4-rc1.
Hey Catalin, just following up on this. I think it might be worthwhile
to split this series into two series:

Series 1: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN,
and use the cacheline size to determine the minimum kmalloc
alignment.

Series 2: Lower the minimum kmalloc alignment to 8 bytes by adding
support for using SWIOTLB to bounce unaligned kmalloc buffers for DMA
transactions.

Dividing the patches as such has the advantage of lowering the minimum
kmalloc alignment to 64 bytes on many ARM64 systems while the work for
lowering the minimum alignment to 8 bytes proceeds. This provides a
noticeable decrease in the slab memory footprint (e.g. I observed a 15
MB decrease in slab usage on a device I was using).

What are your thoughts on this?

--Isaac
