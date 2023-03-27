Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93573622
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 02:47:55 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id f23so6207924vsv.13
        for <iommu@lists.linux.dev>; Sun, 26 Mar 2023 19:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679885274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jVYybNewVCUGIqlidPD+XnZB+0DT8ZQE8hA51H8g5lY=;
        b=nrKyJZoSZOLvRdvdah1XBHmiBQPlhejAs6Noz0yni0AOhMTvNYiq08DZ9m+ap7x3O2
         dY56EZKctpmqiNkTSQONXOJkoi61DrcWIU8YUpZ6XnOhakY2a/LKHWfW07Od6Xtf3+3f
         itL6A8fliVYnbFW8vp7X7QelVrMrQAsnFZN+eamytjiuo+2QH5c0e26tSryZk8rVsJGD
         6h85l2NvY4o6ep9w3LGHMpCAnpoAbl0VloR1B8AGEXxASkxiuegrzKvDmWz2RwEmpOPG
         411pkCKo0e8oi2uQ9RACupqgNgNHeff+Ftg74Ot2/mZIJbNDddd3kjYNI4k9NkF8rPon
         zbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679885274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVYybNewVCUGIqlidPD+XnZB+0DT8ZQE8hA51H8g5lY=;
        b=bwpoJNEaAI7Kt/AJYt78FOHqIWN9kH7HTMITi+mBR761CQ7LohfreraYWaOyVAKXSc
         KrAN0LapmC5GjwHHe9/DNxiLwSSQyg7phKGFM4yp6wgS7Qpr3V8alaqh9V5HATysWbwU
         gcaOnb4BHTu2yKR0pdZd4K0q1cOzEmPgWeQOAjzbjX/YTuy9OSKSaJGrc4fzBhmHGITZ
         +HlFwqddhwghfT0JaLp0o3DMjQBGCDtHELbgksJWF2RgINP9hsR9MrvrzCOC19dnkcx4
         CUinVTMqmvN5bJHRcke1QgFNZAu3QdE0GIHM/HP0KbWAINpcxMErb+XTd0mICjzBOMK1
         +qXw==
X-Gm-Message-State: AO0yUKUGDMNjT2uJ+WK3Y+hMhJ3jor1cAM04Al7aqoEzkdngDpjHyvo7
	U3g+TzcsC2GgM618zVMvONMM36EWFtMHSNdtnCM=
X-Google-Smtp-Source: AK7set9pttu/SbRRsNRw63OJRSZtjAbF7ctNuFQw/5evaDxrdE27zd5/N5zwTbrosIObJghyEQ2fcPMbPsKxJaOVlHQ=
X-Received: by 2002:a05:6102:3385:b0:426:6d5:a55a with SMTP id
 i5-20020a056102338500b0042606d5a55amr8700427vsh.1.1679885274358; Sun, 26 Mar
 2023 19:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
In-Reply-To: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 27 Mar 2023 10:47:18 +0800
Message-ID: <CAAfSe-tg7JwakdCcoLn3Ws_164HcsT21pWHkjjw0Qqwy8PWkhQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] Add reattaching support and fix memory leak issue
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Baolu Lu <baolu.lu@linux.intel.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Orson Zhai <orsonzhai@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

Hi Joerg,

On Mon, 13 Mar 2023 at 15:51, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
>
> V3:
> * Split into two patches;
> * Added support reattching an existing domain;
> * Release DMA buffer only when domain freed.
>
> V2: https://lkml.org/lkml/2023/3/7/1717
> * Added some comment in sprd_iommu_attach_device() for the reason
>   of calling sprd_iommu_cleanup().
>
> V1: https://lkml.org/lkml/2023/2/10/198
>
> Chunyan Zhang (2):
>   iommu: sprd: release dma buffer to avoid memory leak
>   iommu: sprd: Add support for reattaching an existing domain

Not sure if you received this patchset, since I received a rejection
letter from mail.8bytes.org.

If you didn't receive it, I can resend it with another email address.

Otherwise, would you please pick up this series if there are no more comments.

Thanks,
Chunyan


>
>  drivers/iommu/sprd-iommu.c | 54 +++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 13 deletions(-)
>
> --
> 2.25.1
>
