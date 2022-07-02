Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AF4422
	for <iommu@lists.linux.dev>; Sat,  2 Jul 2022 21:48:54 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id b19so6622044ljf.6
        for <iommu@lists.linux.dev>; Sat, 02 Jul 2022 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwhpF2WN1J6S5lDXRAv+Kjl/+1IwILg/3g/jg+Rhz9c=;
        b=oCpQEhUQFqNhRyRxjTjg2S5HdHN/+rGO/9TGX6J3EXmBo7rnTdLvPgvWrtCYw2J9UL
         wPu+VXgoiZTIjlLx8ApyAAFpKJYDCFzUjD+6WIbD9w2kENrTihBt45XO8XYjeSnU93NS
         krbAIogLcjd8c8Hl+HuDng2dDRSr96aWR3ZV8g8//QDnIuXXK552X9Zyvv13uHm9LwGT
         Qg2/7MLD3xII8a4IFaufxcAVcoUOcYwp49Xo4IqzHP2n5rUaXUo3LyC/py01oAEAukQp
         tovSlF37pVHf7oPsn77gzJU3rv/MI1477WsxbQ52/qO1KKeng3K1lsh93mSnr2STndqD
         2RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwhpF2WN1J6S5lDXRAv+Kjl/+1IwILg/3g/jg+Rhz9c=;
        b=jrcl4Nv60fqsXj5a2N4S+WCOjXMhckKPOvxO0L4CPMSrPSIlYxcv15Fn+r6ndrovMk
         Fekk8bG+8NHWgRq3+dlwPmK8bOoca4c3aVSR2zf46dZDxsYiCvFbyUdg+K9w0StKYonN
         2RwD86FrglsFYyoqv5pRQiXa8pRWAdQWY9bumoHwMQw0Ydf02nWnBi5xiRg20cFtk5KA
         B1rPcPkda6ITVpzoay1d6cylYYVtet3REHm3vUVAwMdCT5UoeuJ+KLUgGQlCoNsbKOGO
         eoWXqo6FZjwVUGFMBAGffkPWeZrYW+D1WVJ7K8RUpGyWnxz+x2aeGemvPdAckd+YI2Xj
         0puQ==
X-Gm-Message-State: AJIora9uOMNbbr0RCZtHzMIXILlhFp5w0mnixHfDi2ZQtlSsCWgSjspn
	3++De1bpeZeDAmmRHTFaLBZQQIT8ItIVQ6B4HqmJxQ==
X-Google-Smtp-Source: AGRyM1vFoFHz8ksTCP0i6tWzC5kgSiz3ScxWxfJFYqE/7vLPww6uI//LFWqdzMMDeGA2eY9gG4si//g3WtmRof3kUm0=
X-Received: by 2002:a2e:8ec9:0:b0:25a:754d:db39 with SMTP id
 e9-20020a2e8ec9000000b0025a754ddb39mr12010480ljl.4.1656798532393; Sat, 02 Jul
 2022 14:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
In-Reply-To: <20220702213724.3949-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 3 Jul 2022 00:48:41 +0300
Message-ID: <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Janghyuck Kim <janghyuck.kim@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, 
	Daniel Mentz <danielmentz@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20220702214841.D9jCGFweZQuKSS5JqynJ_SaiJRaI1GNOlnuBX95Qhrw@z>

On Sun, 3 Jul 2022 at 00:37, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Existing exynos-iommu driver only supports SysMMU versions up to v5. But
> it's pretty much ready for basic usage with SysMMU v7, only small
> changes have to be done. As SysMMU version is tested dynamically (by
> reading the corresponding register), there is no need to introduce new
> compatible string.
>
> One major change is that SysMMU v7 can have different register layouts:
>   - with Virtual Machine support
>   - without Virtual Machine support
>
> That can be checked by reading the capability registers. In case the
> SysMMU IP-core is VM-capable, the VM registers have to be used, and some
> additional initialization is needed. That is the case on E850-96 board,
> which non-secure SysMMU (v7.4) implements VM-capable register set.
>
> The patch series was tested on E850-96 board. Because at the moment
> there are no SysMMU users for that board, the testing was done using so
> called "Emulated Translation" registers available on SysMMU v7. That
> allows one to initiate the translation from CPU, by writing to those
> registers, and then reading the corresponding TLB registers to find out
> the translation result. The testing driver can be found in [1] tree.
>
> [1] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu
>
> Sam Protsenko (4):
>   iommu/exynos: Set correct dma mask for SysMMU v5+
>   iommu/exynos: Check if SysMMU v7 has VM registers
>   iommu/exynos: Use lookup based approach to access v7 registers
>   iommu/exynos: Add minimal support for SysMMU v7 with VM registers
>
>  drivers/iommu/exynos-iommu.c | 112 ++++++++++++++++++++++++++++++++---
>  1 file changed, 104 insertions(+), 8 deletions(-)
>
> --
> 2.30.2
>

Hi Marek,

As I understand, you have some board with SysMMU v7, which is not VM
capable (judging from the patches you shared earlier). Could you
please somehow verify if this series works fine for you? For example,
this testing driver [1] can be helpful.

Thanks!

[1] https://github.com/joe-skb7/linux/commit/bbadd46fa525fe1fef2ccbdfff81f7d29caf0506
