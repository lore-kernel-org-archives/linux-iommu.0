Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B88C43334
	for <iommu@archiver.kernel.org>; Sat,  2 Jul 2022 21:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 532C2415E7;
	Sat,  2 Jul 2022 21:48:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 532C2415E7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oCpQEhUQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fWndMM7AliTz; Sat,  2 Jul 2022 21:48:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB8974099D;
	Sat,  2 Jul 2022 21:48:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB8974099D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73E17C0032;
	Sat,  2 Jul 2022 21:48:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EDBAC002D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61AE24014B
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:48:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61AE24014B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=oCpQEhUQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LK0M0CSnzzCg for <iommu@lists.linux-foundation.org>;
 Sat,  2 Jul 2022 21:48:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D23EE40117
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D23EE40117
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:48:54 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id b23so6623136ljh.7
 for <iommu@lists.linux-foundation.org>; Sat, 02 Jul 2022 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xwhpF2WN1J6S5lDXRAv+Kjl/+1IwILg/3g/jg+Rhz9c=;
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
 b=bKOwHU2yAf2NibJcQSE7iGasIMZ6S6fnluNRlpKGk2XjOISNhIxsHBbzxXAr1mZoXS
 oNyGdfSU7rvP4z+9maG/ffaD7ynscllm9SQL1EaI89x04G69ZOH3A/ykVSq0qed2DUc/
 bdkjPuqc/e06JK6wd34+NjnqEsSDmcqJtNzoqDyoBrrRh1wU3mbHu2trNyQyY5pJqMAm
 wGzME/k8UvUaDcuZdyt2S/HC6toRbQ2HXjxxxt/mQBSfsQdkjm9aoYi/RD2fKHMlvYj2
 Zkv7LlPcuKLEkjICpbGE8Vrb53mXoQ/W1+x1LJBQggz8fZVOFsmVJ1UluRZEyW6Yp+vC
 G7TQ==
X-Gm-Message-State: AJIora+9Aihppd1dY3Qrq4h5r4dnPCQ/5GWiAkqLoc0cSNJPzXwehWzM
 VSj6DzNqIc+2YGOCQ6++jxW0/ZlhnOUbhsm5vZQjwA==
X-Google-Smtp-Source: AGRyM1vFoFHz8ksTCP0i6tWzC5kgSiz3ScxWxfJFYqE/7vLPww6uI//LFWqdzMMDeGA2eY9gG4si//g3WtmRof3kUm0=
X-Received: by 2002:a2e:8ec9:0:b0:25a:754d:db39 with SMTP id
 e9-20020a2e8ec9000000b0025a754ddb39mr12010480ljl.4.1656798532393; Sat, 02 Jul
 2022 14:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
In-Reply-To: <20220702213724.3949-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 3 Jul 2022 00:48:41 +0300
Message-ID: <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Cho KyongHo <pullip.cho@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-arm-kernel@lists.infradead.org
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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
