Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AC46B9
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 13:25:19 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id u13so2801198lfn.5
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cI4EPJZvjOmVCwlncQ06krIDHxj26fKpcWTj2anfYmI=;
        b=TDrI4nn1sWi8ehUrOQ9H0Jz+yqcwvUJ7TBjohvG0+BYrKTiz5ZnxUFSOOiBL0uiyZS
         G6a7c2o78hOr1PmYaXtjVLKB38Fs5W9mpgBcOJ2SahEI03CJe7LxUUJ5s1lOxk8SkqRf
         c0Nw6o6L3iIn1uWJFqbEZBgSzK3ZU9MubvknxRu1f4hvuPGaUTP9XvKqeMewefPyCcQk
         fv3c5AFAdWJ+TdKFg+rPq3vcx3tXjayipax1LItn3WFjtB8p7NiW7POvVsplMTse7D6I
         YDEVEKptWa/vzxuRm3mgXAr+Bqy7t26stkLZuYXcD7QYSb49AZpXCKV2v3zhBcBaD0MI
         deXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cI4EPJZvjOmVCwlncQ06krIDHxj26fKpcWTj2anfYmI=;
        b=6iSad/XeFnLJKYD82mGlqhpZ1iH06FMzvkOsahDba3TtnIEFhLldJKChoIaEpowSBo
         iWzoGwSGKhEmjizs04IA9WID0rV2P1lb6ZQglq47fA6hEE/hqIqa64Y3oLR/dcwcO08O
         6N6c0wX/zp77IrOhfKTIVN94viyKbAzTEahE+0oInHrl9Mdjg6BUS7ecs6hXAUCQacYu
         HQNthj2RxNYPEkqJ3sIF4URM21ZMbVJMi/RPQbnxIatRwA8rNG1riK1FK9fVueBFIC8H
         9x8KIfO3/Q7jZprkDZAic1LOOAolR6uXgrhLgGCVuQWb5OWt5Eg0r/k+3LX9LesdzkZO
         uOhg==
X-Gm-Message-State: AJIora9o1CeWL0RnOzzjs/QNE+4K0wkbTYqjZbc9ctAPn+IpBWG04Lsr
	b1H9h2TVnH4n/sUKX6IZ9bdIFuy3lZwELRdIfW2I/ncfTWvb/A==
X-Google-Smtp-Source: AGRyM1tcrTCEOfrbRktfpbwYwNL8Kewo76hUGu+vhbpgDmnZs4CnfFPwH8Ie/NXszeuIdTiIN2vPc0kRFM+JwAusXL0=
X-Received: by 2002:a05:6512:2252:b0:489:dede:1cb3 with SMTP id
 i18-20020a056512225200b00489dede1cb3mr4979227lfu.503.1657805117555; Thu, 14
 Jul 2022 06:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <CGME20220710230617eucas1p2a9ba640ab97b608c6fe94007641012a4@eucas1p2.samsung.com>
 <20220710230603.13526-6-semen.protsenko@linaro.org> <00191759-df90-c020-92e8-37454edba6e1@samsung.com>
In-Reply-To: <00191759-df90-c020-92e8-37454edba6e1@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 14 Jul 2022 16:25:06 +0300
Message-ID: <CAPLW+4kbCfjCqLGhsUUhf3Uzu3xkzoGT76+7LKFVA3Y3ozH6hg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] iommu/exynos: Check if SysMMU v7 has VM registers
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Janghyuck Kim <janghyuck.kim@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, 
	Daniel Mentz <danielmentz@google.com>, David Virag <virag.david003@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Jul 2022 at 18:47, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
>
> On 11.07.2022 01:06, Sam Protsenko wrote:
> > SysMMU v7 can have Virtual Machine registers, which implement multiple
> > translation domains. The driver should know if it's true or not, as VM
> > registers shouldn't be accessed if not present. Read corresponding
> > capabilities register to obtain that info, and store it in driver data.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> I would merge this with the next one. Imho this change doesn't make much
> sense on it's own.
>

Will do in v2, thanks!

[snip]

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
