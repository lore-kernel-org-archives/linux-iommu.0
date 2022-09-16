Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C24C95;
	Fri, 16 Sep 2022 12:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69580C43140;
	Fri, 16 Sep 2022 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663329847;
	bh=SDyVHic+g5Ln/swY+PozT5sqObg8/WxJ+rqngYuzFro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DvQwyaMWXD82NwWUoeJrKeV4DUHsMIooQCYHcmXosyl/K7WeLRGRkRndoqJ3SrkK1
	 LcvCsmmGFAY+MhYDrz7xpw3FxMi5d+PzQ0fW/asv+Cr0i1n49A0F1qWoS+FI3A47Xy
	 4B/5WOw0w9/sSli5YXJHD7wXhQ4foTYIZj90a1gBp8ARlG4GJBQK3lyl2LSF6ogojF
	 J6EfBXoXGGAmXN0TxKx6qWywOKVawa0f9COqJsXsBYSXOC1nyzun57z3AbI0LIna/s
	 TwatmS31qbtoiZnWx2n5l9+Hob6BiCu2PxJc5cgSzrVV5jiJdbnLsOTt3755sFgYE1
	 9aCKWkFxhJIoQ==
Received: by mail-vk1-f179.google.com with SMTP id b81so10563354vkf.1;
        Fri, 16 Sep 2022 05:04:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf1q5+slm5UOdqCwXTEXqBIjCD+Api0y9QhunZnl3ktCUD24Xo75
	9M8/Y5OHB7TrZkHepjRi35itWxpgz4s+szZU7w==
X-Google-Smtp-Source: AMsMyM7R+47aUUSWrJkPcclUE1JWWBatBMqC16j/7ya6IfwoPKPQZf1oKfsbs1hf02nYS8dtX20SyZppgT1c6KwVmjA=
X-Received: by 2002:a1f:1d4d:0:b0:382:59cd:596c with SMTP id
 d74-20020a1f1d4d000000b0038259cd596cmr1736330vkd.35.1663329846359; Fri, 16
 Sep 2022 05:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220916094152.87137-1-j@jannau.net> <20220916094152.87137-5-j@jannau.net>
In-Reply-To: <20220916094152.87137-5-j@jannau.net>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Sep 2022 07:03:55 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+u5ZjCNbxQd9FfgvHx6BM4AYjMS63qmm22k2zn5Xqtyg@mail.gmail.com>
Message-ID: <CAL_Jsq+u5ZjCNbxQd9FfgvHx6BM4AYjMS63qmm22k2zn5Xqtyg@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] iommu/io-pgtable-dart: Add DART PTE support for t6000
To: Janne Grunau <j@jannau.net>
Cc: iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@somainline.org>, 
	asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 16, 2022 at 4:42 AM Janne Grunau <j@jannau.net> wrote:
>
> From: Sven Peter <sven@svenpeter.dev>
>
> The DARTs present in the M1 Pro/Max/Ultra SoC use a diffent PTE format.
> They support a 42bit physical address space by shifting the paddr and
> extending its mask inside the PTE.
> They also come with mandatory sub-page protection now which we just
> configure to always allow access to the entire page. This feature is
> already present but optional on the previous DARTs which allows to
> unconditionally configure it.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - apply change to io-pgtable-dart.c
> - handle pte <> paddr conversion based on the pte format instead of
>   the output address size
>
> Changes in v2:
> - add APPLE_DART2 PTE format
>
>  drivers/iommu/io-pgtable-dart.c | 49 ++++++++++++++++++++++++++++-----
>  drivers/iommu/io-pgtable.c      |  1 +
>  include/linux/io-pgtable.h      |  1 +
>  3 files changed, 44 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
