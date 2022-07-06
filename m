Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A6EC43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 14:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 81C3A40B44;
	Wed,  6 Jul 2022 14:25:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81C3A40B44
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=omXZrna0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9hHyTmI3yqkC; Wed,  6 Jul 2022 14:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 597514012D;
	Wed,  6 Jul 2022 14:25:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 597514012D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E39FC0033;
	Wed,  6 Jul 2022 14:25:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DBE3C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 14:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 546DB41730
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 14:24:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 546DB41730
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=omXZrna0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZUN_A62EWX6R for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 14:24:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C42E94154F
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C42E94154F
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 14:24:56 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id t25so26202106lfg.7
 for <iommu@lists.linux-foundation.org>; Wed, 06 Jul 2022 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y0+hemKCm9KoLcdJVlDwowemoYH5rpN+Hagnel9ijRQ=;
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
 b=Of1mSNo2XeZJKJC2ON+coP86gV+9MgO/edQPOve7118CBFnMTSJonsdc8jj8CEExg0
 X/8FoOtkpji9/RFJMPfONrEnCoKMIS4SDQogeLwJLwe1hkC9eitdzR/Po7mycMzOPg8A
 HVYPtHlsMZZYxtmu8ptskbUcQHBno5iHIoj2Ecklt1t+Lz8gmXryjxZCsKv9CIzX9/BH
 IahLLFBgbmTGhaC+vFjc5K6zzKXmOloVZdMDu1EHmaaUh2nfBegxH8ZmMaUwlf1x1gkx
 a+09pFbQXbArJXH4g1NGukksakWGwNrN5tpAK9M+P9fhUtn0HLcbRwGPLpgoYumxsLV3
 tQXw==
X-Gm-Message-State: AJIora9iJ03mQ7KXBGm+QLaNq5APOmuBgYPmzMiYZOJ3soUar3S7vVJ1
 JyzEZbyAGShWXa/G44LndOYA5nHrbfD9k+/OM76B8Q==
X-Google-Smtp-Source: AGRyM1uDeNrP78kQbE4GCyT6VGpyQpPl0h+HaGsEaZJSOZN/gnHdPOD4IO3m6JYnJJttm/k1+C81vMOjQAuEaHVjx1g=
X-Received: by 2002:a05:6512:2205:b0:484:e296:62fa with SMTP id
 h5-20020a056512220500b00484e29662famr4062867lfu.142.1657117494567; Wed, 06
 Jul 2022 07:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com>
 <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
In-Reply-To: <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 6 Jul 2022 17:24:43 +0300
Message-ID: <CAPLW+4k9DBbX6PupEk-J_KFbLmwgbfuDrfuVgyapT=d4WMG7yQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
To: Janghyuck Kim <janghyuck.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 David Virag <virag.david003@gmail.com>, Cho KyongHo <pullip.cho@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arm-kernel@lists.infradead.org
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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
