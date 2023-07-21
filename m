Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3D20F8F
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 19:26:19 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-262e839647eso1306603a91.2
        for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689967579; x=1690572379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xr6a3wPaSbxEaGpekcRzvtgOYy20EpF6cLmCTWGM/d8=;
        b=PapxbFN9nlQZ0hbhKVwwawBN6LdJjW3Jxp3CpwEUvmqx8VSIfzvyAWjZmPM7Kc45gi
         qopDwV5z676Si5veJkfi0qrd8a5xaySsryWYloQnQkx318xKe2pYBW9+lqkzldmdemE1
         99prBRal3lq3NgQTCz4ZW//9sRY8xNIj5NBo9hLhMiknT0FEv9J2i7fnVBCc6RRf9Znf
         uwsKZ1RZ5VKXjQYWscKe/M+wHdFj68hEhUuwbDqS0RyuhUHk9xpOWf2qzUNm03raJDUF
         LRxvhcmz1Sp9N4r1u6RxuFKGIRB8KKPMrUgr5brHzLqEYPIE9mcLBomKV+bnZZ4ylsbl
         XTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689967579; x=1690572379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr6a3wPaSbxEaGpekcRzvtgOYy20EpF6cLmCTWGM/d8=;
        b=HJrBmud3QmCr1kF+YNoeu1bpOGdlgGvgbjDoXsvEZCFjz+B7mTr97v7x7aiqPoK1FP
         yz/l1S3HxokeCWL17Sz9wLyNuhgffhi1gCbjPNbOWeW/muiYqruAvJ/aps5UZRe+xr4L
         FroGoMLtpxU3H/UbO3unNH4/RUeUQPwo/jNyqv252Xv2O6lKP+YLsid5zGX1Chi4ZVQY
         5ghDze9DqHpvFm+XHBNr9cxg/0Z4SyMswv5c+nHMtfeOz0YfIQjuk4u0rtovkEsQymHP
         2gjhoulIgaLmy24Yw7nsctokzAzDfa64BHcZ0t0x1vgWmdb4gsZ9ZiPfIpA7+yYH97jw
         U+Xw==
X-Gm-Message-State: ABy/qLaLSNGZaPAIcxA7cDj32szFXFOac7/FzNiHeX5m89iS8kJJbt3J
	VvXHdmNtvzqJVolmxLvZii/PwQ==
X-Google-Smtp-Source: APBJJlGqDcvhn/GzUoUrWJEAu6LLTtj6nE8lbyEgpTLg48+TgijhmiTggNpW3leZ2HelRF+2igrYUQ==
X-Received: by 2002:a17:90a:bb09:b0:260:fd64:a20 with SMTP id u9-20020a17090abb0900b00260fd640a20mr2495306pjr.9.1689967579259;
        Fri, 21 Jul 2023 12:26:19 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id e23-20020a17090ab39700b002609cadc56esm2802248pjr.11.2023.07.21.12.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:26:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qMvlZ-003IDP-Dp;
	Fri, 21 Jul 2023 16:26:17 -0300
Date: Fri, 21 Jul 2023 16:26:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, ajd@linux.ibm.com, catalin.marinas@arm.com,
	fbarrat@linux.ibm.com, iommu@lists.linux.dev, jhubbard@nvidia.com,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, nicolinc@nvidia.com, npiggin@gmail.com,
	robin.murphy@arm.com, seanjc@google.com, will@kernel.org,
	x86@kernel.org, zhi.wang.linux@gmail.com, sj@kernel.org
Subject: Re: [PATCH v3 2/5] mmu_notifiers: Fixup comment in
 mmu_interval_read_begin()
Message-ID: <ZLrb2Xq/ZgDgVPNf@ziepe.ca>
References: <cover.b24362332ec6099bc8db4e8e06a67545c653291d.1689842332.git-series.apopple@nvidia.com>
 <06fa82756e4d6458895962a7743cc7f162658a54.1689842332.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06fa82756e4d6458895962a7743cc7f162658a54.1689842332.git-series.apopple@nvidia.com>

On Thu, Jul 20, 2023 at 06:39:24PM +1000, Alistair Popple wrote:
> The comment in mmu_interval_read_begin() refers to a function that
> doesn't exist and uses the wrong call-back name. The op for mmu
> interval notifiers is mmu_interval_notifier_ops->invalidate() so fix
> the comment up to reflect that.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/mmu_notifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
