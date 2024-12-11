Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6B1FCCED
	for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885032; cv=none; b=ouKqH5vmcAw77Yf/9WQjdUc14eMEaXRALrAN/3EEh2DfA1hNEtOD45ERwNN58/2hp7CNok1TlGy6u4ldhz8C1AjYnGboJiWewnSek4mQckshsaru+1+bcupFGdg/WqxeL+MjutT4Y3/ZMRuxf+ylnRssKmwzbE5kZjgjar6eDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885032; c=relaxed/simple;
	bh=GHgSmtR9vTzTjcJ4EaBcwK+ynctZcjBW+h/7n4rakHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nirj3h1fpCnZN1gO+uB8k48XAvIh9ugWlX8ZYBCuJw9iw/SbqwRI07CzhpHVDwop4gCyjKuosAQsjLHzJyQtgg+iTL/FlZRaf/ileg/q2WccGvPwJHlTqVay0zKsrtxGX+QVM8k8kllb5833BoUS/KEfrI6/FMIiJ92sfIr6poM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sos2xtBo; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sos2xtBo"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so3934527e87.3
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 18:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733885027; x=1734489827; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GHgSmtR9vTzTjcJ4EaBcwK+ynctZcjBW+h/7n4rakHM=;
        b=sos2xtBoynlpaAd+taEPsZKUOXZLiRKOwD9/IqtMho2O53Vo5x6Gh6CZlpmEUWO2nn
         8N54r54T5X0AUcH/py7C03/BVPRYHOH/yZWmZy2st/VEIXJOj5biXnWB11VFBerqT4Hj
         +rXoG7GPBUg2NGmRUqcoCUmN0rSeYUdej9iA3jVW4ZhF9u+4kIncw3CvFuik/iH4NNPs
         3tVm/SFW0u6QnI1ePKbK4hGeecLYNZqXecHftPnNaoRJt/GCXrfw8DHGxNHynyXxiCXy
         DJOxO5lt3jskCCWnGLC1tDIrQGJnsK0Seb5VKn4159/57NAwIANmGk5CB42C7E2nNdr2
         30+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733885027; x=1734489827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHgSmtR9vTzTjcJ4EaBcwK+ynctZcjBW+h/7n4rakHM=;
        b=JjVA4Vy4MycZh8TEFDP3G08uO0xJpufXwSJveejgNPDr7h3HUQLHmV8YoLpVvlhQmk
         rX+5CHwgBDmnX/BJ8veqdKaXnTy8VfwYkNxYFHLrQUwvgjDyB3O+rgTh8mxgXM7OYSiR
         ixzQQ9OwflBIYWGTT7rLm8Cp+azGF62UarE4dfcAaj+CYdWiDIG51LBRG+wKzQMBjezl
         sHIjIyQ80x6fBPYEBbm9MBqHM8IwrXn/C/VT8M1fjL4ytagvlmpqWTAkAYEDwRWGcaAo
         j+4WiFcggjhDc6TNwlalQbUEVy2JXSqU2rkhKPvaJDB06tEsJULpfeAt14P7fS4cUZbD
         agvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaO1oy/ysimyoHyS2zOZIaNG8vzQ870Ea9XoGydNC+y3BkiAIhnmiEyY7Ujatw5c+ACPF+5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7XAOykxy3VCcj9UkdMHlMlPo8wrlgmuYeKyLVZIiMqW8GA/25
	CUVDjCNRyGMKbRmYWfWO5b2wQVAHJgXC72xtU1aJ/8F6LOcr59DvVMHPM66IzRr36IR9kJ3gLrH
	rrVh71SoD9JrHN8ZivNeUzqRkmIHe8NXON6T3ow==
X-Gm-Gg: ASbGncsoTDbAvbgOIhlqa+edKOfHxJv4PYS07V3KGaXTXyPWFRGlAbpZp0ppJbJSRyT
	VcynhMmoD+nY7V6Pz5lY26jCxVs7jHL+hTw==
X-Google-Smtp-Source: AGHT+IHS5KkQGk8APo1eXi8Rt0VOlOnXgP9QSvrLJC3hb+d5Eq1x/2VIMDfLSd1xVwCVFBb915rne/FHPXP95gCc0hQ=
X-Received: by 2002:a05:6512:68b:b0:53e:3a7d:a1df with SMTP id
 2adb3069b0e04-5402a5fcc85mr299823e87.45.1733885027031; Tue, 10 Dec 2024
 18:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241108121742.18889-1-yi.l.liu@intel.com> <20241108121742.18889-6-yi.l.liu@intel.com>
In-Reply-To: <20241108121742.18889-6-yi.l.liu@intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 11 Dec 2024 10:43:35 +0800
Message-ID: <CABQgh9GgWVZ6onc7Tu5ARJ_bPrm1GB-5EaQuh4OCu+ywC1Ez_g@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] iommufd: Extend IOMMU_GET_HW_INFO to report PASID capability
To: Yi Liu <yi.l.liu@intel.com>
Cc: alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com, 
	baolu.lu@linux.intel.com, joro@8bytes.org, eric.auger@redhat.com, 
	nicolinc@nvidia.com, kvm@vger.kernel.org, chao.p.peng@linux.intel.com, 
	iommu@lists.linux.dev, zhenzhong.duan@intel.com, vasant.hegde@amd.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 20:17, Yi Liu <yi.l.liu@intel.com> wrote:
>
> PASID usage requires PASID support in both device and IOMMU. Since the
> iommu drivers always enable the PASID capability for the device if it
> is supported, so it is reasonable to extend the IOMMU_GET_HW_INFO to
> report the PASID capability to userspace.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org> #aarch64 platform
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Hi, Yi

Found this patch still not gets merged in 6.13-rc1
Any plan to respin.

Will this target to 6.14?

Thanks
