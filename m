Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCAD4C33C4
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799480; cv=none; b=pukiW7hs1ijmP3tMkJ6CSCu+VKxS1guhZwk0Xi/TsCvic98CbwzfWrzy/qp8zgnb3Ne0D8OS9ZvQ+JkREs0s3Uvh8slk8nYpMAc4eAbw9KM8L+4EpI/xnGaUiiE4R2euO9FJADjsYFOFFc5jRjbaPQxmrBuiApFHpVniqjrLYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799480; c=relaxed/simple;
	bh=LuC1yxQciN15Y1owFlOie4N8M13gYNtvgRSiulcTHP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad7LkDIaAv+Yi4I0NIgk/Ak7WLXcy6nGjkNeDhy+oacb+8UDq1BAZObSV66jC1rH6LoBndbKJ+he1SZiudV1EGamC8QfUYOMNeaKVpUEFrDLsPLMOKYuRPCHerO9Yk44ftp720qMKj7COrWHZdXeXGcSuzFZGipat4HjKSZMKSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AshgwPNl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AshgwPNl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e2e4ef20beso19495ad.0
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790799478; x=1791404278; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PHcKhVSnEwqoc+1KLjRnxGF2Mva/GHzPrgk/jJQDp10=;
        b=AshgwPNlW2MAZsRZUDYp55mki7aIBXIn1bpp5U47b/C926wBwyWT/4j/lguMH1ehmc
         EQegjnc8KELc5l24yOCOMvnprUdXbn2Gy9LmPlVXDdIdWx4vRldY9XtGaIkQ0r07C+WG
         ZxI5/++peNwMAKpeWpft9XfoIV8lPi2SuTurPvQCj3sRVSnrUDC8hWes3yFHTxm42h8/
         lVpCKInd1eztPxjB7KE893nDwxHBxsBVzXYBvPSgI1H/vPBwVXuKutZpdAj7N690cxr5
         U7JW58wTQbsfwPSZ6aLfDkH/QC3+30aoNhHURDtw+hlUznDGYCFZSozCFFsKYZvbZku/
         Rlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790799478; x=1791404278;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHcKhVSnEwqoc+1KLjRnxGF2Mva/GHzPrgk/jJQDp10=;
        b=mSm0ic9AzOpg5j4DJjuUVYBXkXdhDjLhxo06t4jnxgrVWMsEp9N8l3v/KX8AgZkUre
         /13jio9eB1sD9eD4xOaXHpJpdJwCHF+nQyO+5CoJiCLNeTSm8AXzdJ3+KzXghE/OPkTD
         03BFHE/yAC/NVJOOcYNsq2ciBMFlH7QwPcnxWhbjE2b4hlrg/AKOw3hvSE4kvj99lPsC
         cmStnJ/5aF2UuCKcitOckDUxfNpJKkFSrYaoMT/K14if2vZGpteLEiHXgpKAUcxstaNN
         2mIpoLeWNaNMVvfqk45+NzjteG5FUm8wJzaXJCJdjHYyhBWNCQX6rS1wNvrkqMMqFf6v
         9yPg==
X-Gm-Message-State: AFq9FYJ8OkylnOMkB37UwUypsyDCjaxO2Is2FVb7pT9802TYlAPIk5Ue
	VQz7KZbzUrGNPaA046ub4bhJfmKpHlCXlGKRnKPX0ZMT38uxJlqbENE1iKOhOk3oYA==
X-Gm-Gg: AYBFou2kk4Z1NdwyYM6E/pl2A74W7ZcZxcJecJCciMOs7rd1xEVrXPyb/8Dt3Q5EjTJ
	ST/Hk7xlBNdV1g1+kj9UwGwcGpb27Hmr9JmUZtnnt5M9VUkv6OZ8knmOOcsTvItrevLmvfBPJHr
	D5D0pGUOzU035BMXy0ZACMKEzBaOm/48W5hTG7SUBS0fxCrErORylNBdDO5lWPdumTtiXU9S/pB
	uVv/yWEjSDb1yMdWuVjVzY1tCyqNjbQecvuNGxwgKlRkZ8JFVCqUG9RcJ35iJJSSeH5EKdYbI3a
	YzjxvlKe+CSb8WsZAcXKkOM6cEoIisttWiyVqVGAOB/XR3xHjEBZou+D4rOuiaeA8sMm8BptDOu
	G8ziHlZsbpb2QJC8E19L/Z8NkpMukytxOtBGhu8lfq19ZNlLXFibuRbWnW1RQQfvnb2MelHr3OA
	PaQ5y+chYsTra9YxDaTqZWcTw8nkJXUavvB0RcOv2V1HRNz+Y1QwtO1XHBAHjRCcMm5BPHPpCTQ
	F/hpK00W8YXM/JQ+N2j5zfqc41dY0NWlot7Bt1RracCn17l
X-Received: by 2002:a17:903:1a03:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2e301ae27ecmr1354315ad.1.1790799477609;
        Wed, 30 Sep 2026 13:17:57 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300af8560sm2018515ad.46.2026.09.30.13.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:17:57 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:17:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 03/16] iommu/arm-smmu-v3: Add arm_smmu_drain_queue()
 helper
Message-ID: <ar1ubp2nHdRIXNEn@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-4-praan@google.com>
 <ar1T1ecOPXb6JSPc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar1T1ecOPXb6JSPc@nvidia.com>

On Wed, Sep 30, 2026 at 11:24:21AM -0700, Nicolin Chen wrote:
> On Tue, Sep 29, 2026 at 03:44:57AM +0000, Pranjal Shrivastava wrote:
> > +/**
> > + * arm_smmu_drain_queue - Drain an SMMU queue
> > + * @smmu: the SMMU device
> > + * @q: the queue to drain
> > + * @until_empty: target selection
> > + *
> > + * With @until_empty == true (for CMDQ), exit once the queue is observed empty:
> > + *
> > + *   cons0                cons                                prod
> > + *     |                   |                                   |
> > + *  ---+###################+=====================+=============+--->
> > + *                         |<--------- undrained==0? --------->|
> 
> Jason gave some remarks against this API:
> https://lore.kernel.org/linux-iommu/179018862538.3334538.17643821143626392419.b4-review@b4/
> 

I see!

> So, my PRI series would drop this patch. I suspect that it still
> has some value for the RPM/CMDQ case, compared to a busy-waiting
> alternative. Yet, it probably should be simplified for CMDQ case
> only.
> 
> In RPM case, the "prod" would be fixed/stable right? IOW, there
> should be no new commands added to the cmdq, so it only needs to
> wait for cons == prod?
> 

Yes, that's correct. By the time we drain, the STOP_FLAG is set and
we've waited for owner_prod to reach the target & cmdq->lock to drop..
so PROD is stable and only the HW moves CONS (same for the lvcmdqs).

I'll simplify this to just serve the CMDQ in v12, maybe just a sleeping
readl_relaxed_poll_timeout() on CONS until it matches PROD..? 
I'll think try to see if I could repurpose this too.

Thanks,
Praan
