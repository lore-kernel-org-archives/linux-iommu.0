Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5D3C48C
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504790; cv=none; b=pOoS66s0gJ6IxMSYP6uz6hX5tK1qe1HlHXD8zjbUeh7JG4PReROjrKt8Z6J++s+Zflq2OwuDbrn51Fx04MbDw3PA0+vQVZDaOwSgzQN9Wlmg5k6THBtOxu2boYN2DHYsx70GiJm9OJ2dhiTHxRzxqGehl/PLjynSZob1hA1Evdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504790; c=relaxed/simple;
	bh=GUsh6EFsJ7PPrJAD0y3jO+1W1vxjRmmaExeG14jW4aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7hR7SVOSeGcgkFIEj9SC5/uD1CM3G/Rb7qpFKIw/6Tg6Hm+dqzPGwBzuL6gbs5gcFBJl6mCV0T9FVRimT0f6N/nB0x6tKHoJglIp90IutQZGIDXkUayEeHz0wag1RSv8jKWm34MzX6CiaOkWmV/u72PfJq9Rtqx7a7cGNijnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XIn/UGqR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIn/UGqR"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d2533089f6so6421381fa.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 00:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708504786; x=1709109586; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JFbebWnaOELZUkqxAEj6ANGpA9qZ0u3+xyV8xOnxaw=;
        b=XIn/UGqRinjc8G7QLlnmLdGB9icHt54W1YEnL7/nOVLGkRqFNd/Gp601bNyu/m9jQ/
         uwpaU+trdV8kx2qLREz994JPAQJb7ArNS4Ahyl9/zvlcdwMclrEoEQ5KVHfaq2/2w2/8
         Owki7pF5YZy/BG80joXVVKGJbhjDZhQMI/V3KHowdVFD/QOz42PX5JFaJ+dQn98uDANH
         ZcE6YF3OjDs6hhF6rRaeEHgm0ElpENJD30sKgBeM4feTab+xSftxcushv6gFm6rKrT+8
         NFarsYYSx6zAa4Qn/6qQvQ+6dIbOy5ZnR7/u4NVHtFa0mlJWY9kUIrq1YIo6h8pBN1J8
         LGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708504786; x=1709109586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JFbebWnaOELZUkqxAEj6ANGpA9qZ0u3+xyV8xOnxaw=;
        b=RbOtJnc5+RKy1tsBiN0yL9tO5qxY2b6rVCroAJlkh+oLWk2tOcSi+Ph6nADiBVZEXZ
         s0e91asHI8GY24hR3h1Ek4Nri2EFWZPjla40ktyXG2k/JNxS/LFersNd4BcaSNgQf0ZY
         QkBYxvAR3L7/5rdV5H+PI6gMctQSqdz8cFsjVSW01sPG70rE8VHcZlnzNbkq0AO9whwZ
         wmNRye4STTttZhTPsj5DTRb8l7ESwyZiNFQKnfx2YqJ+FR+C9KGYKYoLVKMC/4NhZn1/
         r5VyCVq8T07Mqj0/WEorK0VtyCkiwgCQsgCW+bLc1UGy1WTftfC9riKJeqmvSrToch4d
         /0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX14K/UMiDIJvooL4NuU/fVKzXXYFCJvUPWM1ljlm35jEgVcca+nq/Bj0sHwVzeEPJqp+iMPr744w4aG8126Hx1se8kdmQ=
X-Gm-Message-State: AOJu0YxQ3eGLxF0qQEqmYFqVGau+wUjvmNuWhUKmI9zCC5CGUk9CAnVs
	C/7z17aGzFnc3CPYvjF9vzQjNCmmGdyIiGED6168GZbA2AAxIHa7MP071bMUW8pAlW0abqP9Fsd
	h/L+G2BsTcjFWh8/mXMAd7Z6i/1Vqg8FnqfwsKA==
X-Google-Smtp-Source: AGHT+IGaTNqW+dKRPVQ9KBU0Ci5gQ2Vz28gYpqB2lxGWQ/iKjd38xYAWHvl+7So3L6vVJc6Cuthmp1ZXWdegVKrdl6U=
X-Received: by 2002:a2e:be21:0:b0:2d2:289f:16f7 with SMTP id
 z33-20020a2ebe21000000b002d2289f16f7mr8827955ljq.49.1708504786146; Wed, 21
 Feb 2024 00:39:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221061832.430-1-zhangfei.gao@linaro.org> <MW5PR11MB5881E20A89840306C977F3FA89572@MW5PR11MB5881.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5881E20A89840306C977F3FA89572@MW5PR11MB5881.namprd11.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 16:39:34 +0800
Message-ID: <CABQgh9FVe4MRCoSrxnbjr2kqfd-_N2JovD-12CB3BSV5YSFj8g@mail.gmail.com>
Subject: Re: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 15:59, Zhang, Tina <tina.zhang@intel.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Sent: Wednesday, February 21, 2024 2:19 PM
> > To: Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; jean-
> > philippe <jean-philippe@linaro.org>; Jason Gunthorpe <jgg@nvidia.com>;
> > baolu.lu@linux.intel.com; Zhang, Tina <tina.zhang@intel.com>
> > Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Zhangfei Gao
> > <zhangfei.gao@linaro.org>
> > Subject: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
> >
> > The accelerator dev can provide multi-queue and bind to the same domain in
> > multi-thread for better performance, and domain refcount takes care of it.
> >
> > 'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > removes the possibility, so fix it
> >
> > Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > ---
> >  drivers/iommu/iommu-sva.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c index
> > c3fc9201d0be..a95c8f3a5407 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -91,7 +91,7 @@ struct iommu_sva *iommu_sva_bind_device(struct
> > device *dev, struct mm_struct *mm
> >       /* Search for an existing domain. */
> >       list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next)
> > {
> >               ret = iommu_attach_device_pasid(domain, dev, iommu_mm-
> > >pasid);
> > -             if (!ret) {
> > +             if (!ret || ret == -EBUSY) {
> If rebinding is allowed, how could IOMMU core know if this invocation is intended (like the multi-thread case mentioned in the commit message) or is mistakenly invoked?

I think it is the purpose of refcount, it should be no difference
whether same device or not.
Even different dev, IOMMU core can not make sure it is intended or
mistakenly invoked.

Add the limitation does not make sense.

Thanks
