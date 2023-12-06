Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2837152
	for <iommu@lists.linux.dev>; Wed,  6 Dec 2023 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkCzaFsq"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50bf7bc38c0so4232679e87.2
        for <iommu@lists.linux.dev>; Wed, 06 Dec 2023 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701870411; x=1702475211; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx5g+5SMQxcicok5kYvCUK6eBKquWgCzB86sfFem4PI=;
        b=fkCzaFsq3k1KdMGgdYHeEz6v5rKFFBngtqdlHaB4TSxdPGojJyrZQ9SV5wq5OJwU8K
         7eqw2T0fjsggTV/nk42QYk5Shw/HmuYrEEtEKQ2iXu9fDssepZ51BK8OIP3qyvPAcGh1
         YWn8LtdpylSi0TXXXG0aGeBR/KLOpYzusEJY7VpzPJ1AWzU6WgHypTlEAMf+a6PQasww
         AL9Py3XOYcMmO0ZhKqqAT584JaOjhdDqvi3oLQ24P9XAEl7pKMx4z2kKdqYiSmo9uv4V
         CiomzqeYwyZCMH8zgiPuvDQ+6wBtqbCEhl6qBUrsHQpdbxNYa76wiUQMlU2J0gOhqL7s
         V+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870411; x=1702475211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cx5g+5SMQxcicok5kYvCUK6eBKquWgCzB86sfFem4PI=;
        b=stscx2Y132t8TdHE/JJufrxgqwhKB7uUMAoTa0/p1YGxTIt5XUkHLVzKbevL8JsYA4
         SpE4r/+BV5XLGCzGPNsN25HhNmWHxxFuhHxYrkeBi9ww2nk7fPFBzZ7xRII8LkLwlR1f
         PcNybERoVHDhPBJDaUFs94j8x01QEfR/mQPbBdhV7ZrwzE8SydSi6nN2ZwjDz01lgdVx
         7yTeu5Nl3KlHiob7vl+0/qg8/HwrnlBEHFQF7fbwaXJMlZ7yta+kkjbVuC1PRCI32Dhv
         rCpgUYcwol4xIubsvde0rms4hkjK39U1NbQHl3yFTwaEHMlp51tX9MYiJYJ0CjnSVWck
         WHNQ==
X-Gm-Message-State: AOJu0Yx3JWbQ4/dP2Bm9VyGNVZdfM0YQUMJjyp5cXWM7nXdVX53UpVE4
	eMSUXmTCobSKl84XMn7TNnv643iNaBDCu8OmOnKYxw==
X-Google-Smtp-Source: AGHT+IFDPczFKh5GMvs5SBPQNG9ZyK/pZsKfhVA9gUmBbF0dGQ7YqvGAQFTEpGYilkKRMT/TRZA9w5RZm2ZVFqdXvnc=
X-Received: by 2002:a05:6512:e97:b0:50c:17d6:fff6 with SMTP id
 bi23-20020a0565120e9700b0050c17d6fff6mr314987lfb.1.1701870410783; Wed, 06 Dec
 2023 05:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231206005727.46150-1-zhangfei.gao@linaro.org> <20231206095717.GA2643771@myrica>
In-Reply-To: <20231206095717.GA2643771@myrica>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 6 Dec 2023 21:46:39 +0800
Message-ID: <CABQgh9E5GH4xm=+doz=FO+yJuFa0w5f6D2hovj0kUhgkr_sr0w@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: disable stall for quiet_cd
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, 
	Wenkai Lin <linwenkai6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 17:57, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Wed, Dec 06, 2023 at 08:57:27AM +0800, Zhangfei Gao wrote:
> > From: Wenkai Lin <linwenkai6@hisilicon.com>
> >
> > In the stall model, invalid transactions were expected to be
> > stalled and aborted by the IOPF handler.
> >
> > However, when killing a test case with a huge amount of data, the
> > accelerator streamline can not stop until all data is consumed
> > even if the page fault handler reports errors. As a result, the
> > kill may take a long time, about 10 seconds with numerous iopf
> > interrupts.
> >
> > So disable stall for quiet_cd in the non-force stall model, since
> > force stall model (STALL_MODEL==0b10) requires CD.S must be 1.
> >
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
> > Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Thanks Jean.
