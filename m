Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302013C0F
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 15:26:57 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id k2so8766757pll.8
        for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679930817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Odb92SQ0FVvs57ZcM9A8PJotl9bKl4RHOoMbk3dA3D4=;
        b=e0Y1bQb3FmaTSC2GM9EK+o91pCalJmsio+SSS2HeFxcRwBTaSGbGYRRwhVaIUzHSpk
         PaZabU6yLU1iUGDfpEABRxiqFXC0dPyQ+1uBK5T+siCRQBa4cYRnL3c+WQnSmQOhbX5A
         oPskDLRfQL7IYrcgPLYNq2DHHUlV/t7wHVf7XoCjQT/g9oL6JyfxZaSo5Yr2qzawi42N
         sKPhpVgjdKtrlY/vVyFCrlmZpRO1puDQ3ACYlxKJqzWRCDk20lhxcZNwZbylD0ZCFudN
         j+Cvjcy77Vwu3NtPwunPnZYVlNyFKwIpuuDmz6SfsSSYTKp949kVkPrDevY16dOhvIb4
         OC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679930817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odb92SQ0FVvs57ZcM9A8PJotl9bKl4RHOoMbk3dA3D4=;
        b=luPi7TQl1frCHnNbCVaYKuKttatgUOsILxeZsSQmDo5eCBX8UhV8kxMHIbeQo97Pfd
         754zY59fl3Q80SB4DMt+sd3NZlh7gRiYpAtMHuctA8wZ//ebyN9k4640/nQwtp+79BPh
         y4m9LHP1sWtFJJZrN88k/mCHzX2w/FSZ/xPnjNavsnOdp7cKDEYIOKlAYzjUmtXjhkd+
         WU6eFJGxtyoebT295RyfCN+cT6+nvH6D4sPJQU2upeIveZqikZNMyThTssZhPg+ekiLG
         RIRBSY3BjgQSw2SvWmxsQOHpEksbeR89DxpISv8zWAPc8g0iLC7y2o7xqBui0+NvqhOn
         gycA==
X-Gm-Message-State: AAQBX9dITV+VQN9i+KP+jsvFAfjXnySg4OBqL1hJ3xT311FN+oN8LsNq
	hDKs1tsk+RAjyQ7WjgMUf5gDGQ==
X-Google-Smtp-Source: AKy350Z+cfTmght/h3mZN4yZCxLnNcQHz+khJqLqwwNJtRrzbffWTQd88JWx2oKkmUIhTFGvZmmgNg==
X-Received: by 2002:a17:903:120a:b0:19e:7d67:84e6 with SMTP id l10-20020a170903120a00b0019e7d6784e6mr13850465plh.0.1679930817447;
        Mon, 27 Mar 2023 08:26:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b0019a97a4324dsm19509745plb.5.2023.03.27.08.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:26:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pgokJ-003AkL-Bc;
	Mon, 27 Mar 2023 12:26:55 -0300
Date: Mon, 27 Mar 2023 12:26:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: John Keeping <john@metanate.com>
Cc: Steven Price <steven.price@arm.com>, Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Message-ID: <ZCG1v9hRybc/951e@ziepe.ca>
References: <20230324111127.221640-1-steven.price@arm.com>
 <ZCGpmHUWyZVaeIIx@donbot>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCGpmHUWyZVaeIIx@donbot>

On Mon, Mar 27, 2023 at 03:35:04PM +0100, John Keeping wrote:
> On Fri, Mar 24, 2023 at 11:11:27AM +0000, Steven Price wrote:
> > Similar to exynos, we need a set_platform_dma_ops() callback for proper
> > operation on ARM 32 bit after recent changes in the IOMMU framework
> > (detach ops removal). But also the use of a NULL domain is confusing.
> > 
> > Rework the code to have a singleton rk_identity_domain which is assigned
> > to domain when using an identity mapping rather than "detaching". This
> > makes the code easier to reason about.
> > 
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > ---
> > Changes since v1[1]:
> > 
> >  * Reworked the code to avoid a NULL domain, instead a singleton
> >    rk_identity_domain is used instead. The 'detach' language is no
> >    longer used.
> > 
> > [1] https://lore.kernel.org/r/20230315164152.333251-1-steven.price%40arm.com
> > 
> >  drivers/iommu/rockchip-iommu.c | 50 ++++++++++++++++++++++++++--------
> >  1 file changed, 39 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> > index f30db22ea5d7..437541004994 100644
> > --- a/drivers/iommu/rockchip-iommu.c
> > +++ b/drivers/iommu/rockchip-iommu.c
> [snip]
> > +static struct iommu_domain rk_identity_domain = {
> > +	.type = IOMMU_DOMAIN_IDENTITY,
> > +	.ops = &rk_identity_ops,
> > +};
> > +
> > +#ifdef CONFIG_ARM
> 
> Is this #ifdef needed?  I can't see anything ARM-specific about this
> function or .set_platform_dma_ops.

set_platform_dma_ops is never called on ARM64.

> Not shown in the patch are the pm_runtime hooks.  Do they need to
> change like this?

Most likely yes

Jason
