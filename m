Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26B4C82
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 14:24:56 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id t24so26240536lfr.4
        for <iommu@lists.linux.dev>; Wed, 06 Jul 2022 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0+hemKCm9KoLcdJVlDwowemoYH5rpN+Hagnel9ijRQ=;
        b=omXZrna0gxIYOazn7dGSQ7WvQGEYaiftOCQUxfDqPa5w+1/OLqJq8uvIyGgBHkh8zG
         9StaSLqmtiC++EBHnpfHQg4he4T37Hj1jxHflwWnMXc3gqIUe9gPq3WCAcdsp+s+2A3k
         VrH2kCLpJsCMT7K6KTLi//AB2RG+tSx0/Kt51DWW1YXgTGeB+LdeM7Yubl1VaevlPI6W
         wF7AKTUrmEaEU8dwOESUd3SQGKWBP/ipS3jCHfC0y8aIWEEQuBS4EgPw9kiZxRFXCwcS
         YtyGi6h+7/VfY39HZmzZ6fMF3Mf3AV3oUgt4z9v5BCBRR3hYosw9wyz7yWCEfjyAfLEG
         JuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0+hemKCm9KoLcdJVlDwowemoYH5rpN+Hagnel9ijRQ=;
        b=ZvE4DNcHfeIYQHl67mAFyuCJtwaJJCtgi9oSR86d23zLKjC66bd4+lyfpgH7CHGG40
         DWcpV5XSes8KUrfTkEvbYnEZ8Ij0Ac0qzMChlUUN3/c+N1Z/Sl16iSoLJvi+PesIknSc
         BJYydq1jw61xO+kI8899ttZ95z/k6yfvGr+V1B5cwQRsghXhHHvu4y6yjMR8PzWcp+gR
         3J1HpJngdzs2tX36vnytEG3spZFrbsq2BUs48JYBMMyi04RDw4V+FP6w68HRUa2T/wdK
         8xohAFJBHD00U48W+EArPpmreEKqS4LXyB6IBc+iD1yjKPs4d8F+rqEY9db2dw8bIKz3
         MPRg==
X-Gm-Message-State: AJIora9Mh2Q6E3bFZtzJeek/BlQTDs8EY/Hi9JsHs6odo4PJm2K6saWK
	O3Smk74Q4yTxRvf0cWcwPMUM7yTSJNzZ05ZUTtrQWQ==
X-Google-Smtp-Source: AGRyM1uDeNrP78kQbE4GCyT6VGpyQpPl0h+HaGsEaZJSOZN/gnHdPOD4IO3m6JYnJJttm/k1+C81vMOjQAuEaHVjx1g=
X-Received: by 2002:a05:6512:2205:b0:484:e296:62fa with SMTP id
 h5-20020a056512220500b00484e29662famr4062867lfu.142.1657117494567; Wed, 06
 Jul 2022 07:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com> <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
In-Reply-To: <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 6 Jul 2022 17:24:43 +0300
Message-ID: <CAPLW+4k9DBbX6PupEk-J_KFbLmwgbfuDrfuVgyapT=d4WMG7yQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
To: Janghyuck Kim <janghyuck.kim@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	David Virag <virag.david003@gmail.com>, Cho KyongHo <pullip.cho@samsung.com>, 
	Daniel Mentz <danielmentz@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20220706142443.VlFd02Tv6LtWNkFqLJfOf8IWJcR6iUqJdKm6kjLs5PM@z>

On Sun, 3 Jul 2022 at 13:47, David Virag <virag.david003@gmail.com> wrote:
>
> On Sun, 2022-07-03 at 00:48 +0300, Sam Protsenko wrote:
> [...]
> > Hi Marek,
> >
> > As I understand, you have some board with SysMMU v7, which is not VM
> > capable (judging from the patches you shared earlier). Could you
> > please somehow verify if this series works fine for you? For example,
> > this testing driver [1] can be helpful.
> >
> > Thanks!
> >
> > [1]
> > https://github.com/joe-skb7/linux/commit/bbadd46fa525fe1fef2ccbdfff81f7d29caf0506
>
> Hi Sam,
>
> Not Marek here, but I wanted to try this on my jackpotlte (Exynos
> 7885). The driver reports it's DPU sysmmu as version 7.2, and manually
> reading the capabilities registers it looks like it has the 2nd
> capability register but not the VM capability.
>
> After applying your patches, adding your test driver (with SYSMMU_BASE
> corrected to 7885 value), and adding the sysmmu to dt, I tried to cat
> the test file that it creates in debugfs and I got an SError kernel
> panic.
>
> I tried tracing where the SError happens and it looks like it's this
> line:
>         /* Preload for emulation */
>         iowrite32(rw | vpn, obj->reg_base + MMU_EMU_PRELOAD);
>
> Trying to read the EMU registers using devmem results in a "Bus error".
>
> Could these emulation registers be missing from my SysMMU? Do you have
> any info on what version should have it? Or maybe some capability bit?
> I'll try testing it with DECON/DPP later and see if it works that way.
>

Hi Janghyuck,

Do you have by chance any info on SysMMU v7.2, which is present e.g.
on Exynos7885? David is trying to use emulation registers there with
no luck, so it would be nice if you can provide some details on
questions above.

Thanks!

> Best regards,
> David
