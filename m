Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08D3C9454
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785083003; cv=none; b=fSCcy0twmwNoN1ZqXFAjTuR2xJmvahyGhr8kH0UqTqVVIWsD8B5NlWjrWbSroXfSP40VfvZlWyblsxEVBgPCLRBSA0M8OyXrpgLnvolkwNEB7JhtwQQ17FWdl2AVr+MivIGZuYHRpiHI4XjIuElpjGE+RZsd8rJVbeQM11RvlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785083003; c=relaxed/simple;
	bh=eh2uHeTUG5CmXS9cNmYuwq/yTrAZwmMBCh6xBgYyXpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNF4btMG3Z8N7wjVi9gYaKx+p79NPJW5trn78oxvOI+Sd9NZFHcrWHkfw80Xp2mI99EbqCCBJAfDj1zIZ3um1XtMUFkYvVfeuKida7jr4oae1uzQNszaj9SqP5EsojD11IetpOhC4e7hFT3HGeBucy2RUK1OpFh5m9urt2I7+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BUnY8umD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BUnY8umD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so24421055ad.1
        for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785083001; x=1785687801; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHRV8RVQazd81DBcHd8LNzyzM/eTYjhER1/AreGPfK4=;
        b=BUnY8umD11xsCWqyjS/G2qq+hOL7ihCC0uqUD5tdaqB/EqYkPQL1mJ1ekW5C/Gixgf
         4/PVJ5xA8CGPJ2LzbVBk7BSBnkSpYFdaxYJ6cJGwzjnSt3lXVV9O/yIBYgsHs+8rkfoe
         fKZezgjLQipbQngRoaK2DuxYkurmsI0vW+XIHZjHAajGXFyUrtqsT4snZdCUYPrHaH2e
         7LJekguR+sQ44JH62Csxzva/Gb4DLxE2duRpDl2LcVwyejAOzmebOg4GN1tGD+heeGqJ
         M61Gg8V+tHOowPxOqBctTm6OCjGSkeo/LPuO2wpNCyDi/YoPfujirCluUBB+uiVhoZY9
         jfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785083001; x=1785687801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHRV8RVQazd81DBcHd8LNzyzM/eTYjhER1/AreGPfK4=;
        b=aOXtdJZWxE7nu+a+qRVn5Rxm1QHFbZOJopj1PcPTeDDD00EglQ0WTcFF3JsRJ0pokv
         xf916svW56ghAzDlImM7E6Py4hyZjc473OpdBf5NRE2argsFLe3V5H7grFrOxBibY2wh
         dre3q58frq9QXBBNUdRkALPykl/rhTH0lP67q3/2AquK9R+wGZdxk7iSBsgQcyuFevyb
         7qXjXt8zmz99aMGOvzNc6j5ZsvtsFxUrf6xJoFC96tsoYY82VsXOpWlE38ZCYZ3Ui1mn
         nt7sR2kTDQ2/YZQSD6C24irN+2Jve6dbNimBh1flmz1I5PSTu9uQ+qe0mR8rdyPgsUZR
         64xA==
X-Forwarded-Encrypted: i=1; AHgh+RpJuEWKjlgZbAYQ6PHfbeIQoSzZKT3e9crRiQ87xtvZqNQ2f03PwyS+UP2EoixFeH9NW6gAyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ5F/4eieK2dWVgvm9Q99k8X1YVxoFo1LLf+w5bpYSAJ4KvMX7
	+XVgi8SfeNh/1t9Vk5/ryVKKcDpUU8sNgMWLR8zLqrLU/+aj/aZqoyefhWrcLZ+gZyk=
X-Gm-Gg: AR+sD12x7kXYm+KO+tVsrH2xPnz8Obg5dMnma+8ElW4HvFT6aePKachBU9TIxgRaVbo
	grdH/XvCF8ClclLHOzlBi2N72dD56vOFXNpsoAms/Iusdh7xsCqDDPu2f1TpzY54Ex9k4i5HoGg
	+QHkU+t/JX82tesxFfCkwvNe/7UzdoEEuGFiL1RqB0iSl1NeXSPcNvgFLzci4a6VvYombiUCn+T
	XPW9qkELMOsu5YvdH5+JVmsedu85BFnNnXYWNDJ3QtFxyfxEdUzAy3jOxKv9UxKc/Bz+HJN7gDH
	Vrzs2ls42vmzWZd+iTB1BbGIevzRMLp6YiGMw29tIp0ojWSR9y8CpXj/SmVPG9hnO2ha3FrEqII
	ls2gAGhUKTyWde1k3F/GtbccRBWg4auZsWhd3WQQa7tSK9YrFTqY=
X-Received: by 2002:a17:903:124f:b0:2cf:7882:a444 with SMTP id d9443c01a7336-2cfde7bd3d6mr49402625ad.16.1785083001604;
        Sun, 26 Jul 2026 09:23:21 -0700 (PDT)
Received: from ziepe.ca ([64.114.68.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5c8337sm22177955ad.20.2026.07.26.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 09:23:21 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wo1dJ-0001U5-2C;
	Sun, 26 Jul 2026 13:23:21 -0300
Date: Sun, 26 Jul 2026 13:23:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 4/4] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat
 workaround on Tegra264
Message-ID: <amY0edpcgNbqFQ7s@ziepe.ca>
References: <20260726081904.1408859-1-amhetre@nvidia.com>
 <20260726081904.1408859-5-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726081904.1408859-5-amhetre@nvidia.com>

On Sun, Jul 26, 2026 at 08:19:04AM +0000, Ashish Mhetre wrote:
> Nvidia Tegra264 SMMU is affected by an erratum where a TLB entry can
> survive an invalidation that races with concurrent traffic targeting
> the same entry. The hardware-recommended software workaround is to
> issue every CFGI/TLBI command (each followed by CMD_SYNC) twice, and
> that infrastructure is already in place behind
> arm_smmu_erratum_repeat_tlbi_cfgi_key.
> 
> Neither IDR nor IIDR flags this Tegra264-specific bug, so hardware
> detection is not possible. Tegra264 is device-tree-only (no ACPI/IORT
> support) and already has a dedicated "nvidia,tegra264-smmu" compatible,
> so DT-probe is the only viable detection path.
> 
> Enable the workaround on instances matching the existing
> "nvidia,tegra264-smmu" compatible by calling static_branch_enable() on
> arm_smmu_erratum_repeat_tlbi_cfgi_key. Document the erratum in
> Documentation/arch/arm64/silicon-errata.rst.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  Documentation/arch/arm64/silicon-errata.rst | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
