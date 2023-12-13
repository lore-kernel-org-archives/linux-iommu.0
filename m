Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D7A50
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxfODrXH"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50c0f6b1015so7466282e87.3
        for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 17:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702431375; x=1703036175; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Hxc3TLAQxGrVMxCKcgPL57up2sHDuMinvi71A2jdig=;
        b=ZxfODrXHsezmPnGUg7aVRrdEpYvDyOs4AJES/aS9tUCLtapAInm8vpHHepdzYDDsPS
         NrXhV8R02Zt+h0czoDvCXT3es29tRulNOkXDuXKD+OuSqd9pjJjZiqll7t1LQLWGxEru
         snO/Rs7TN1DqIpEA7nu8QtwuAUOroHmCjB896GTMt6Grzww2CU0Skn2vbLuEBU0MiW0s
         Q+YrtG0nCJT3dCYBdyRlkj9eicZiDFOfO9P7TufpBlFIYfBAROrv5KmotUMXpo8CE8dr
         SzQ+ohxYSzyoNLWAFk6HX0K69jtybD/r3kv7cLooTMH342/cQYB/SkfDIItxcB51g26f
         8R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702431375; x=1703036175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Hxc3TLAQxGrVMxCKcgPL57up2sHDuMinvi71A2jdig=;
        b=jtHtLBWWCDrTUA2QDlgWppd3QteXvqNQ0TG8giJG2/wJLue0ecZCunxcrg/kr8CYEQ
         iRn01wraeeOMTtHURO4K2W8J7bPRsCbwLdLC6Tx2D9SRLJ0sM3e+tqYFhTWm8nHQiIib
         tXDT8GpmI+j9sb589GNoT6owXyG6FJEtdapdpUkN7KMqjohR9mm7apfs2XTIXqU4eltP
         jAZdE6lGoZDR3z6L5EqR8vxZsV7nG5sdzsrvMglFjolN/OlpHFdCot5VlqnBZCOi0rFF
         QX3jE1VnJzvTRv08Vnamw37PnaabjCsDim8JQ3h7SMiXL3djI9f+htkVvD6rQanaE97y
         o4+w==
X-Gm-Message-State: AOJu0Yy3ToVHOBXwQIr71MD3iIhPLFkjG9k7mSLfojpbsE/bm41W2ge3
	aDAiHFTM3z1jpydmjxHBMRDV/6lx6OIS8FH3ND8vbg==
X-Google-Smtp-Source: AGHT+IE8qr+3ZvJkExQliW6jHkHk7Az0eZ+hzQWcAo5QVabKY02QemCYudczVw2seK85vsVg+FKoN5iLYzGZmBPee8U=
X-Received: by 2002:a05:6512:aca:b0:50b:e056:396a with SMTP id
 n10-20020a0565120aca00b0050be056396amr4240552lfu.28.1702431374658; Tue, 12
 Dec 2023 17:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231206005727.46150-1-zhangfei.gao@linaro.org> <170238473311.3099166.16078152394414654471.b4-ty@kernel.org>
In-Reply-To: <170238473311.3099166.16078152394414654471.b4-ty@kernel.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 13 Dec 2023 09:36:03 +0800
Message-ID: <CABQgh9EWiHXxEpNPNmS9r1HPSaxraYgtGC+cqJOTeSdYFp1TGw@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: disable stall for quiet_cd
To: Will Deacon <will@kernel.org>
Cc: jean-philippe <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, catalin.marinas@arm.com, kernel-team@android.com, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, 
	Wenkai Lin <linwenkai6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 01:21, Will Deacon <will@kernel.org> wrote:
>
> On Wed, 6 Dec 2023 08:57:27 +0800, Zhangfei Gao wrote:
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
> > [...]
>
> Applied to will (for-joerg/arm-smmu/updates), thanks!
>
> [1/1] iommu/arm-smmu-v3: disable stall for quiet_cd
>       https://git.kernel.org/will/c/b41932f54458

Thanks Will
