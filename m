Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1A3D84
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 14:14:59 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id r9so13627241ljp.9
        for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGcV0udwGjSruZ22N9l9PLf+/uHhdyNzh4czvTCR/yA=;
        b=zCTXM9N+lWM7M4yu4edy1tV1WT6siuoQVV6e1kZX7hZCPivLfKVDwNmZtMUzVTGTpk
         Ef/AqPA3Cez2+uOeq9HV/f45tl55LY3/Lm6rh//1MmfnE/laT91v1pxoExx7UEnUDxCn
         k+YUuX3kPsjFkja4s3YHSyZTONf48zrSpsqopdXI6QpK4QNe2dvl0s1rizEh9vWkXkxq
         lZrrKtazdbhBNmmNGYg9KXcMYXNveeSxUh+6khWPFBJhyJjhsUPhsNKbhjX+X4GDpXmE
         bKl01T2O+MbqurfsuoXEoHQI8RzhgK8jlETIuCE/jnpt5a0WPd/D2VtgyjbibRTLuymr
         MrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGcV0udwGjSruZ22N9l9PLf+/uHhdyNzh4czvTCR/yA=;
        b=ForPjd+hrGPli0cwuxM2qC7bLnHoQQxZrYjY5Nsz1Yu5zD46fkkKm9JvIdqUP9uUzt
         myWrJNCO5ZZi1minaA9IS1UXya6pm6VPWz8uRZ+b+E3cbdLn/CAcAaoMfpzFYugTQ9fx
         7ONDHTZIgmh8KXPGYUOASNn85oXrh4+a2bUzuLNkOPh+1hZvBcbW3pTRCsFkStBsG5ml
         Pl3uDnj8SsiDxxMegGaN7AJ7tB3+iTXgXUMc4LTTxns/INr9/mYKCTlScGKVZCN7QyOk
         IiufnuMyi/3RMfbrD6IjpkKbSp3ru+V8nwIpD3JZlgZQncVtRl7CePR+0pRm5KS37OoV
         p/sw==
X-Gm-Message-State: AJIora9gjK2SLcTEi0fxeeGqhGiftBV7eLl46VLnzvvq4s0m+sbwrx7L
	sQ03J+8X1z2OAD5neaDih0/PQXGsvJu6GOaZJbfxCg==
X-Google-Smtp-Source: AGRyM1tG9FwWpL3QNN3CU2va1RCPbzZzojzMQ4cZgpcwNihHlrvL0DxO6/vvEBv8w67LwDpTW1hzi0m3ohydLI4AQ8s=
X-Received: by 2002:a2e:bd11:0:b0:25d:4f94:ac79 with SMTP id
 n17-20020a2ebd11000000b0025d4f94ac79mr1943417ljq.4.1657721697308; Wed, 13 Jul
 2022 07:14:57 -0700 (PDT)
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
Date: Wed, 13 Jul 2022 17:14:46 +0300
Message-ID: <CAPLW+4=pikbLQZLabv7aZvGhA_30xaJRYLxK+uOUUXnwu2Byow@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
To: David Virag <virag.david003@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Janghyuck Kim <janghyuck.kim@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, 
	Daniel Mentz <danielmentz@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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

Hey David,

Can you please try out the [1] branch again? I've added support for
Exynos7885 there, using the info provided by Janghyuck Kim: apparently
Exynos7885 has EMU registers, but those have some other offsets than
on Exynos850:

    #define MMU_EMU_PRELOAD    0x8040
    #define MMU_EMU_SHOT       0x8044

I wonder if my changes to [1] do the trick.

[1] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu

> Best regards,
> David
