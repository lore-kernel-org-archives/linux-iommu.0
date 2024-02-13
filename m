Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB86088B
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853770; cv=none; b=LPBGHGep+CcMl+6nIJ/KKKfXu0ocIYZ/YMikU1QPntsa10atW+SK/qMsEyBcUruSyRmM9bspLFLredufXTG+gqoAJUg7kpet8DGW3sBGID+Luh9BxYLjsFjFYx19Y7x930YDXRha/q19Ki3yVcnlmYeFBSqW/Lmj5ErqOjPLC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853770; c=relaxed/simple;
	bh=ffe9gO7KVRYtww3F4xBFEwBZh1a+Hx77aSa0ag65tzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdautcgkbgqPXobBpL0xoPe2N333m9pD6P1hwQ+nwLpynpYT2jrzI5zvcZUspl4UVtdncDSk5pkbYShHpFNagXL1RIj9552443AlY3Zvezv4phG/U6C0jn4bpfDDhs6rbZpH9UYdkZOlzKCS0ut5aCA8uK8xuj4nLqHFPikORfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WGE6MLtL; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGE6MLtL"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbed0710c74so3989810276.1
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 11:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707853767; x=1708458567; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2r+d4SYUIyHT5gjIoPbw+SmalguQNzVZTPSSC+Kv4LI=;
        b=WGE6MLtLd6u0Js/l22Fgy9Crij6VD7PK9MakWKh7Zkn/bbaXvEZ4XkC3FMnn2q9U2D
         iXKEP3CUIHkgO/L0MtefLLWY9rPE7Td3maxWtESXpGOLzPI4tQMNbeTgf87HTzxlWTLb
         Yfc0Xez/+jzyQ44fttWNVK4jtq4rcfCpr0vdStOZbdxyZwC6cREBtRFlV9qsnpP15yuV
         25RUYKmhQ73KVqJvfsC69mVfsCMzl+gx4cEdiT28TzzPtIbmKaJTbIpWaCGRUBNDwO13
         YdmSuqFjwaaH+GSb/jtAoGn8GsfttaXtBV29EQXZWULgSx09gC9JIrstYsEKy2GNnmOM
         DTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853767; x=1708458567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2r+d4SYUIyHT5gjIoPbw+SmalguQNzVZTPSSC+Kv4LI=;
        b=M/jxhwYY1zLEq26PVJBSjPEi+50ECjqxibKAxT+SDTVqx+yd5F4Y4Y2vD9lw9FPgB7
         YgAgV9mUslGFI3DYKb09EMIfe0oc4ZPxrpO3ANdSr5JxUUMFRwCXReGHafzidBfB4qH0
         kdO3ierLniN0cLwbgep4rsXdEFrR+VX5NBYVpDmQRjLw8qmms+YWYe1FGxtqVKP+5Cc2
         8tnQrqHMKseasvrZSIecaUasNKH0TUm3bLT1RBbOHMCsAqniQbbsRLde2S+cn5BakQ4a
         hNDhj8S6jxGNtc2UWJdiTJtLmxLcWtn2hlmRXBjiV9Llu7wwukCc2pxQDv+Sc4PqAWjC
         RR2A==
X-Forwarded-Encrypted: i=1; AJvYcCVzEaNnpqgN3JhcJbGPzWJC9IwDQYnV5HG72E/RWJJ98UQ+XD/vjS2+gjR5yMiCNsk+Cety92EGTKNH8lfQb5LbG/v1p08=
X-Gm-Message-State: AOJu0Yy2VWpivqu7vBvUV8uYcPVwTefKOJeEeDMs9tPwM8PrC6JVM6hS
	o74CFfEuZhKHhEO6W2/EuL/5/opAj9fnsu5X+FKukpGN0VC+DcHY/k0PhHgaxrPXAJ193BB7t9i
	PhP75tOtNfPSPJM7OjcOYfsSqKaAGdmO4GCOkkg==
X-Google-Smtp-Source: AGHT+IHuIaFQMbrirEhKz395nV1OIhvnXj/ek6dLuUYdk+Akp/if7FLIKl+E3i3xejAUx3dzSeFO9Q7CHQjo/bLGoJQ=
X-Received: by 2002:a05:6902:2608:b0:dc2:1f56:11e4 with SMTP id
 dw8-20020a056902260800b00dc21f5611e4mr403120ybb.24.1707853766831; Tue, 13 Feb
 2024 11:49:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240213-iommu-revert-domain-alloc-v1-1-325ff55dece4@linaro.org>
 <20240213121257.GI765010@ziepe.ca> <20240213121934.GA28726@willie-the-truck>
 <20240213125303.GJ765010@ziepe.ca> <20240213125951.GB28844@willie-the-truck>
In-Reply-To: <20240213125951.GB28844@willie-the-truck>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 13 Feb 2024 21:49:15 +0200
Message-ID: <CAA8EJppWpLgX_kfk6O11k0uwyiq507pp_d+QtDogSgJqgiGviw@mail.gmail.com>
Subject: Re: [PATCH] Revert "iommu/arm-smmu: Convert to domain_alloc_paging()"
To: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Rob Clark <robdclark@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 14:59, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Feb 13, 2024 at 08:53:03AM -0400, Jason Gunthorpe wrote:
> > On Tue, Feb 13, 2024 at 12:19:34PM +0000, Will Deacon wrote:
> > > > > @@ -875,15 +879,6 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
> > > > >         mutex_init(&smmu_domain->init_mutex);
> > > > >         spin_lock_init(&smmu_domain->cb_lock);
> > > > >
> > > > > -       if (dev) {
> > > > > -               struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> > > > > -
> > > > > -               if (arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev)) {
> > > > > -                       kfree(smmu_domain);
> > > > > -                       return NULL;
> > > > > -               }
> > > > > -       }
> > > > > -
> > > > >         return &smmu_domain->domain;
> > > > >  }
> > > >
> > > > Everything else is fine, you already tested with that arrangement.
> > >
> > > Partial reverts are a recipe for confusion, so I'll take this and if you'd
> > > like to bring back some of the hunks, please can you send a patch on top
> > > that does that?
> >
> > The typical kernel standard is to fix bugs in patches and only reach
> > for a wholesale revert if the community is struggling with bug
> > fixing. Dmitry already tested removing that hunk, Robin explained the
> > issue, we understand the bug fix is to remove the
> > arm_smmu_init_domain_context() call. Nothing justifies a full scale
> > revert.
>
> I can't say I'm aware of any consensus for how to handle this, to be
> completely honest with you. I just personally see a lot of benefit in
> reverting to a known-good state, especially when the revert has been
> posted by the bug reporter. Then we can add stuff on top of that known
> good state without having to worry about any other problems that we're
> yet to uncover. Doesn't really sound controversial...

Well, I'm open to any patch set that ends up fixing the issue. I won't
insist on landing the revert first, it's up to Will and Robin, I'd
say.

If there are any patches for this matter, please Cc me and
linux-arm-msm@, so that we can reply with the Tested-by trailer.

> > I'll send another patch if you want, but it seems like a waste of all
> > our time.
>
> It's a bug fix, of course it's a waste of time! We're talking minutes
> though, right?
>
> Will
-- 
With best wishes
Dmitry
