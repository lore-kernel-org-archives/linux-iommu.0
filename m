Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CC29A2
	for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 18:38:53 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1a04bd0ab07so153775ad.1
        for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678991932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aco+48KQSTXrRgbQkuc+78HSNv7058GW4RTMfCAnIHA=;
        b=oVgVVSr3DpFodH/W7BEB8twr3ljYV/n6IfeeSQNw2KZSVWn1wUlErVeZyZDxN7u8ah
         2WLpPfc07KAV4brUvbTfPm1hD3Xl+hniedRD6YoZwmdJnHxLU3Bt3lNfQifmAXLABFLJ
         yi726pxGiBD/0r1OCjCb+3jxdD/Z8yI18AbzOVHfNHBWSeTOhNTW5O4VDQJLJfTPCEPV
         UGNCKJn7qZHYmmfSHQqd+N6V7+nWV9V1HCwi4y0gELcQWwJxYnUiK+vDt6kuXP2DodMY
         ubo1Iu2Ne1uES2/k/MkJwG8dzRBJw9vbfrqXv2L1n913ZJcftiop3F3bcmZisfGTDtyW
         gZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678991932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aco+48KQSTXrRgbQkuc+78HSNv7058GW4RTMfCAnIHA=;
        b=l87PldEPm/fU/geX2+KdbrYfqqOa6IBkV4/hX4pc9i8p7YwG1mSzElVz4Iozcg0Wd3
         Re9fZBMeNctzBHZHtHe8caKhnMOxvPMC3zBHKCVHNCIL4jYgtC9kxR4Cu2BV597gxSxV
         zPa7yqkIt/N+M9kJ1d1Jkvo5kJblspOcDwJHZ8p3nCj3jf86XdWCkN0rvp+WqEbpuQOM
         2X4hO3fIoLWlgtQtAJbCNrBU2OUTbAcHTXmiesftusApzwMjjPrRilutqiCt77xQRJsp
         3E+ufojLRjRjS+61zSNYfU/LO0IOiL5/XblKugTvVG4OZpd6xHdAn5HPSoQcQTTmdVXx
         Fu1Q==
X-Gm-Message-State: AO0yUKXfZfZx2wrU/OGQrqZFJNRxbreCzRV46uGFx1q3KW+pY4lW+q4n
	Y+/IW5Rajp4/Bi9eN8mOr4bNfg==
X-Google-Smtp-Source: AK7set8t8uixLTKQFPibXI9O3Eyr3dYB1pWE4h2zKgCpwhJYghtHW0myy/GlG+JZ/ZkMAVXYVektCg==
X-Received: by 2002:a17:902:dac6:b0:199:3909:eaee with SMTP id q6-20020a170902dac600b001993909eaeemr26571plx.6.1678991932413;
        Thu, 16 Mar 2023 11:38:52 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:c641:8e37:69f3:8d4c])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001a064cff3c5sm44886plp.43.2023.03.16.11.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:38:51 -0700 (PDT)
Date: Thu, 16 Mar 2023 11:38:47 -0700
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
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/13] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZBNiN9CR2F/fvUTh@google.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106220143.2129263-1-catalin.marinas@arm.com>

On Sun, Nov 06, 2022 at 10:01:30PM +0000, Catalin Marinas wrote:
> Patches 7-12 change some ARCH_KMALLOC_MINALIGN uses to
> ARCH_DMA_MINALIGN. The crypto changes have been rejected by Herbert
> previously but I still included them here until the crypto code is
> refactored.
Hi Catalin,

Herbert merged the changes to the crypto code that were required to be
able to safely lower the minimum alignment for kmalloc in [1].

Given this, I don't think there's anything blocking this series from
being merged. The requirement for SWIOTLB to get to the minimum
kmalloc alignment down to 8 bytes shouldn't prevent this series from
being merged, as the amount of memory that is allocated for SWIOTLB
can be configured through the commandline to minimize the impact of
having SWIOTLB memory. Additionally, even if no SWIOTLB is present,
this series still offers memory savings on a lot of ARM64 platforms
by using the cache line size as the minimum alignment for kmalloc.

Can you please rebase this series so that it can be merged?

Thanks,
Isaac

[1]: https://lore.kernel.org/all/Y4nDL50nToBbi4DS@gondor.apana.org.au/
