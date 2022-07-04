Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2246B3
	for <iommu@lists.linux.dev>; Mon,  4 Jul 2022 15:53:46 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id n10so8919169plp.0
        for <iommu@lists.linux.dev>; Mon, 04 Jul 2022 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zy9LvdAwYM6pI8b/Z68M03xTnBNAZuNODV/bDDMn0vo=;
        b=lN/DVKKzJP43Ofps0rEiry9BzZRJuwiipwO7x+o8HW2bURXO5vqIsN1vmv4FjpztiM
         b6S61atBIVw3H6JCWIa8sj/mjBxJZWZtCCTBTjvqlJFbg0xBE0Uf48yxOA+Nzo/KU/rP
         UeKLqBxP9pc5yz6sKag97lg1s7LH1U3PlpnpeCj5n50zAcAg4W+4OxapDSDE2FAq2bFR
         X91+sWlifQjkxkcD5O4VubxhY1Gg7qtmNpvdezNMqhr9FKPbLdM02a5eu8JgTmJ2bF7C
         NQvJa2uayNbqLmUz7po1iaI+m78lPfQeJgbCYU3XyAKs9PF9SpPWWtXjkaFVqFhELtUH
         eaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zy9LvdAwYM6pI8b/Z68M03xTnBNAZuNODV/bDDMn0vo=;
        b=6OxfSDFI3W48w+aEpUnJy746uFONvLI0OGlNoCLsXVPgNaAxPyRDqed3VsxSyAI5hg
         uPQXkHvEEUgVFnQpx52sBb3SnWgxY1Qg6ejTctb9Eh/ohoHxyrQaTPDN9F3XlKReNjwm
         x1x2UtHSoaT3Y+Pq8hvmnrdmYIVQcDH4L/wek+/qtRLL/ym0ouSpVSDQk+pxXkBH5xvC
         mQkZoazlrB3TboggCRGubU8MKOxmnTgmcKJ25QbxtY4AyXOI4/x/Y8cpvjJgKRzsJHNz
         XBI2vsPhPmPpTqieA9BNFYoEPijXEVuwHir3bRs4DLOVjwY3vJYar35RvF3XtgiHf9Eo
         VHUQ==
X-Gm-Message-State: AJIora9dbHzqvxN7js9rONGCLEfcFPGifI5+Hin6LMTK/zj+BI3rlJEJ
	8RPm20lkzGNmi9UhHewEEAiVVw==
X-Google-Smtp-Source: AGRyM1v4odPFoHtXvD2jFfNdl4Wr3ljEKWa0krWChFSsKVWnlMd3cVuRFrACXGH3dz1QfZBOj+8+pg==
X-Received: by 2002:a17:90a:ca8b:b0:1ec:9afb:1a2d with SMTP id y11-20020a17090aca8b00b001ec9afb1a2dmr36485448pjt.225.1656950026314;
        Mon, 04 Jul 2022 08:53:46 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e74a00b0016bdb688097sm3627509plf.142.2022.07.04.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:53:43 -0700 (PDT)
Date: Mon, 4 Jul 2022 09:53:37 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ren Zhijie <renzhijie2@huawei.com>, m.szyprowski@samsung.com,
	robin.murphy@arm.com, mark-pk.tsai@mediatek.com,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dma-mapping: Fix build error unused-value
Message-ID: <20220704155337.GA2375750@p14s>
References: <20220630123528.251181-1-renzhijie2@huawei.com>
 <20220630143116.GA6198@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630143116.GA6198@lst.de>
Message-ID: <20220704155337.mzxA-N_4HkQ3T4aZg8z9tIoR-h8hTjvyLEm3_Ad1NTE@z>

On Thu, Jun 30, 2022 at 04:31:16PM +0200, Christoph Hellwig wrote:
> Thanks, this looks good with a minor nit below:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Mathieu, can you pick this up through your tree as that is where the
> offending commit was merged through?
> 
> > Fixes: e61c451476e6("dma-mapping: Add dma_release_coherent_memory to DMA API")
>

I fixed the missing space and applied this patch.

Thanks,
Mathieu

> missing space before the opening brace here.
