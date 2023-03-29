Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96683C2C0
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 23:42:02 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id p2so11670651qtw.13
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680133321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7C+py6MtCoeCMOtw25BrlCO3RIdyKIetyPlMUWcAxQ=;
        b=or5zOdb0THcrHSRrNF/aWpqr5y5XACt17c51B2fuOW5sIxoj2mxKk9QPCHXd0weuMi
         hnjPrhDD9X00VxhDRyGWzEdQaeUnYGGNVBIvm9NdJ0z50h4PG9uK/AbqfIt+KuEViqwk
         JMM5cDJ2p6Ibr/BwfCk3C1SKBmRh1EslZACPJQ899Ch1m4XCYwbv+spFie8OO9H1NGMd
         dSWXfMR537z5wT9f+bGJgtTobSqzNyVbAqczhBYbiJ434wSDGKN+LAwp1+ntSjG3vP2F
         N7qWsyB3f+eC4E5HMMZTbKMLErH/sElNNBOzKtXz/YGwiDkAtAAhK+4KWLoTciVd0//H
         yxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680133321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7C+py6MtCoeCMOtw25BrlCO3RIdyKIetyPlMUWcAxQ=;
        b=iyzZh+bdyFHskzlIejYddA2rFVThvjByXUvilXVnFbS3T+31wCtKm8ckCYBGTkUHzk
         s0RwK78qGtZgYJIKz5FPTPg43D4e74g5ifHpS1vYYHH5dvpvH+B+mOYl4lQuCh6D3h7j
         j1mB/Qj7Diup6X7mpAAyhgWQpg5ek0pD51TG6PkamEhRAGDU6ops6tReZLS70lVbwzxN
         ym3FMVYAsQvs+2mpbR5/rHepwBMnBP+1a9/w7XOKbYTJG+ntpkwtHrYqXFbPyS8OWx2r
         mVpMunm5Sh+FazpN2AEL8jnDddHKAvXCUnWRgycFvVvC2gm1ip7Zl0usC9bB8qILMOjT
         LHbg==
X-Gm-Message-State: AO0yUKWg7msloiYoOS0lqKl80ZgGFDWgA6jYspzqnMMRKv4DqLJNZtNW
	WwlB1lNZDgHGRloxjFJ8I2WbVA==
X-Google-Smtp-Source: AK7set/r+pGsJrPMn0D9D6pkZb7SUCn2k/XDNs/gApUMrPEx0RFz+B78D/mL8S9HzmDoO+y4IPCuSQ==
X-Received: by 2002:a05:622a:1ba3:b0:3e3:98b5:69c2 with SMTP id bp35-20020a05622a1ba300b003e398b569c2mr26020425qtb.62.1680133321368;
        Wed, 29 Mar 2023 16:42:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h22-20020ac85056000000b003d5aae2182dsm8863730qtm.29.2023.03.29.16.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 16:42:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1phfQW-004hQQ-86;
	Wed, 29 Mar 2023 20:42:00 -0300
Date: Wed, 29 Mar 2023 20:42:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Message-ID: <ZCTMyHifYJfGZqRg@ziepe.ca>
References: <20230324111127.221640-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324111127.221640-1-steven.price@arm.com>

On Fri, Mar 24, 2023 at 11:11:27AM +0000, Steven Price wrote:
> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> operation on ARM 32 bit after recent changes in the IOMMU framework
> (detach ops removal). But also the use of a NULL domain is confusing.
> 
> Rework the code to have a singleton rk_identity_domain which is assigned
> to domain when using an identity mapping rather than "detaching". This
> makes the code easier to reason about.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v1[1]:
> 
>  * Reworked the code to avoid a NULL domain, instead a singleton
>    rk_identity_domain is used instead. The 'detach' language is no
>    longer used.
> 
> [1] https://lore.kernel.org/r/20230315164152.333251-1-steven.price%40arm.com
> 
>  drivers/iommu/rockchip-iommu.c | 50 ++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 11 deletions(-)

Aside from the pm stuff this looks OK to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
