Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187F1C433F5
	for <iommu@archiver.kernel.org>; Fri, 21 Jan 2022 08:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F9234059B;
	Fri, 21 Jan 2022 08:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fHHRqsjhOmQf; Fri, 21 Jan 2022 08:35:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEB96403BE;
	Fri, 21 Jan 2022 08:35:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B40DCC0031;
	Fri, 21 Jan 2022 08:35:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4ADFC002F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDEAA60BD7
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n9WxsUNqwbGg for <iommu@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:35:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA41B60AD3
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:35:36 +0000 (UTC)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 523C73F1DD
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642754134;
 bh=h7b33DeTvzBNpVO9xtR6SrRKZdczqz3V7QKsSMc1HTE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=RstT95hGj4V+Ojy+2fIMRDhxaBFfARs6rSVz1Jw1PjUmeqcv0DdhzicO731FmtiQS
 6FufKF9Oe4GvP0ufnxF1JTktsp+X5NyRVNS3FzFU9+XmTILwQZrZjrp91/TvWQ36Fu
 Ukd5q29E6bd1KYa45GQp5lo2BXIralSaQCGqkDjP47MbX68awQ2Tpyzb2VzRdFuQIl
 Jcb8BcuGdpLLxsPWzfEGJmIXf88i4rS2MqK2X2LlpIec4ly2gVFKXltjVuinmv0HJ/
 mOr+9ZMtvt0pB5lkZMKccxcwXrh9ysm0rxztxCbSEZfdHE3lbdGkoNn7gc1XSGS769
 DUxowfpWUZPJw==
Received: by mail-ed1-f72.google.com with SMTP id
 k10-20020a50cb8a000000b00403c8326f2aso8456215edi.6
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 00:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=h7b33DeTvzBNpVO9xtR6SrRKZdczqz3V7QKsSMc1HTE=;
 b=KFBOsCCXk52AAdY0EjOimFuVhY8FxmSKx0mvLWuws/Q3pXS/i7hOXAsjFcf9fBbdyh
 dW0NOMyk1b+Mg/KyhjGMp6p63oax0lfncJSb5GKgCy1dpH58CGfsO1vq+dJYkHqPb1O3
 L6Az9EM20z/7xFiXUL/2WHM6u7iPgAOIhQ+HFOxrjmyq+SOdmLnNWRUcbbgUv0xJEoJn
 eRt6nzIGfyf8SKI4Kd99Qmy7v+o+dxAAdl87i9bgRKcELgoJHLN1oBo7J41D0FZ1GSFT
 LhTg5kCtXPaGRvOuHVUX6VDl2u9s19521gWgVym8YAl3RKXXSid3dz05hBd0H7LLYvSU
 zd1A==
X-Gm-Message-State: AOAM530SIpXkK+2HQZc6wBkra0pVKKRhT1jyEAlJiV0ax/hd/WwVuawR
 l2y7k7I9stDF++W01/kEx3SacOBE5KFH5PHx3jBjX711my4m7H8w5BWAi/1GnnYS5X62TCLycpn
 0pUdvupb8NbopRc2tFHpCtzn+y40IaDsmafs2+IOcJB/ETn0=
X-Received: by 2002:aa7:d9d4:: with SMTP id v20mr3470528eds.234.1642754121941; 
 Fri, 21 Jan 2022 00:35:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIYeq/Ed3URUhIn6WPpagBUgmUBHhym8SeaQc3F2a9sHPJ9ZLkk4zZZiOX2+0I08qYGOPgCA==
X-Received: by 2002:aa7:d9d4:: with SMTP id v20mr3470511eds.234.1642754121737; 
 Fri, 21 Jan 2022 00:35:21 -0800 (PST)
Received: from [192.168.0.50] (xdsl-188-155-168-84.adslplus.ch.
 [188.155.168.84])
 by smtp.gmail.com with ESMTPSA id s13sm1819610ejo.207.2022.01.21.00.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jan 2022 00:35:21 -0800 (PST)
Message-ID: <32a92895-d724-c1bf-4eab-15c971625cf0@canonical.com>
Date: Fri, 21 Jan 2022 09:35:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC 0/3] iommu/samsung: Introduce Exynos sysmmu-v8 driver
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220120201958.2649-1-semen.protsenko@linaro.org>
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Carlos Llamas <cmllamas@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-samsung-soc@vger.kernel.org,
 Mark Salyzyn <salyzyn@google.com>, Jinkyu Yang <jinkyu1.yang@samsung.com>,
 Thierry Strudel <tstrudel@google.com>, Will McVicker <willmcvicker@google.com>,
 Cho KyongHo <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org,
 Jonglin Lee <jonglin@google.com>, "J . Avila" <elavila@google.com>,
 Alex <acnwigwe@google.com>, linux-kernel@vger.kernel.org,
 Hyesoo Yu <hyesoo.yu@samsung.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 20/01/2022 21:19, Sam Protsenko wrote:
> This is a draft of a new IOMMU driver used in modern Exynos SoCs (like
> Exynos850) and Google's GS101 SoC (used in Pixel 6 phone). Most of its
> code were taken from GS101 downstream kernel [1], with some extra
> patches on top (fixes from Exynos850 downstream kernel and some porting
> changes to adapt it to the mainline kernel). All development history can
> be found at [2].
> 
> Similarities with existing exynos-iommu.c is minimal. I did some
> analysis using similarity-tester tool:
> 
> 8<-------------------------------------------------------------------->8
>     $ sim_c -peu -S exynos-iommu.c "|" samsung-*
> 
>     exynos-iommu.c consists for 15 % of samsung-iommu.c material
>     exynos-iommu.c consists for 1 %  of samsung-iommu-fault.c material
>     exynos-iommu.c consists for 3 %  of samsung-iommu.h material
> 8<-------------------------------------------------------------------->8
> 
> So the similarity is very low, most of that code is some boilerplate
> that shouldn't be extracted to common code (like allocating the memory
> and requesting clocks/interrupts in probe function).

This is not a prove of lack of similarities. The vendor drivers have
proven track of poor quality and a lot of code not compatible with Linux
kernel style.

Therefore comparing mainline driver, reviewed and well tested, with a
vendor out-of-tree driver is wrong. You will almost always have 0% of
similarities, because vendor kernel drivers are mostly developed from
scratch instead of re-using existing drivers.

Recently Samsung admitted it - if I extend existing driver, I will have
to test old and new platform, so it is easier for me to write a new driver.

No, this is not that approach we use it in mainline.

Linaro should know it much better.

> 
> It was tested on v5.4 Android kernel on Exynos850 (E850-96 board) with
> DPU use-case (displaying some graphics to the screen). Also it
> apparently works fine on v5.10 GS101 kernel (on Pixel 6). On mainline
> kernel I managed to build, match and bind the driver. No real world test
> was done, but the changes from v5.10 (where it works fine) are minimal
> (see [2] for details). So I'm pretty sure the driver is functional.

No, we do not take untested code or code for different out-of-tree
kernels, not for mainline.

I am pretty sure drivers is poor or not working.

> 
> For this patch series I'd like to receive some high-level review for
> driver's design and architecture. Coding style and API issues I can fix
> later, when sending real (not RFC) series. Particularly I'd like to hear
> some opinions about:
>   - namings: Kconfig option, file names, module name, compatible, etc
>   - modularity: should this driver be a different platform driver (like
>     in this series), or should it be integrated into existing
>     exynos-iommu.c driver somehow
>   - dt-bindings: does it look ok as it is, or some interface changes are
>     needed

You sent bindings in TXT with dead code inside, and you ask if it is ok.
I consider this approach that you sent whatever junk to us hoping that
we will point all the issues instead of finding them by yourself.

I am pretty sure you have several folks in Linaro who can perform first
review and bring the code closer to mainline style.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
