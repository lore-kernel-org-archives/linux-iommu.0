Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18416C4708F
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 09:23:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A4D60E0B
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 09:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A4D60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00378404F2;
	Mon, 31 May 2021 09:23:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0wZ8J5cfQSL; Mon, 31 May 2021 09:23:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F468403E8;
	Mon, 31 May 2021 09:23:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0EF6C002F;
	Mon, 31 May 2021 09:23:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 469F9C002B
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 09:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D121E403B7
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 09:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DuSoNT4kDhWB for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 09:23:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01B174037D
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 09:23:01 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 i8-20020a4aa1080000b0290201edd785e7so2649794ool.1
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 02:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jY9BuK9FNLMjbPTJtB8IDmbrG3t6+tuv/+gLi9Ppjao=;
 b=srDlNUPWE+qZTl9DnNgSplvRBy+lMllJN9jvZUo8wu6+fXy1o8QVoCdZ9Bzjdw3RtP
 sYG7+z4CdNRzG6esqaZ9KededzACmzQGmkz/1KAcKpaCmkEqKYiMNA34dbzHdPDAhwnV
 SMpqCaitIPYFnyllogzeOZtuTFGcCynkf15AC5uuOlISQNvZUIPwRq2vP1DujF21RICR
 DBqzjZlP0AJHP+B1ipPRZZUf5Ld0CZxsuIy+Q89PpfTmxjsDcvGWme/POK7x93vqXR4k
 AR/nY0sP+lroh8F2TX/GoedgEeNahMizurg8mipwioS6m0kFDfu/n2rTnQqd8wad8UuK
 WfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jY9BuK9FNLMjbPTJtB8IDmbrG3t6+tuv/+gLi9Ppjao=;
 b=kEjTae4ufXrp3mZlYwTRRNEpCIlFcHAV+bjCKDauqoMZjArDSlVhyTCHk8eporCnj+
 rzIAFs6wRbhrIN5ZasaugJtJK/DpeFcJ5c5Y6lTkumn8E9+JzXCGCs+Dilt0brkjAiy0
 b5ibB2Ny9cBe8cH6CxQQtBNAD4KC2t1fgYtD973DllakSnhzzEQ0wCM8movxc1c02S6a
 6TppOQ7Wa9V/AxSW55xc0QRKgDON6DB+ptiVX8FqYRgIQrxnGxPETAZSgyvGs/+T025C
 4QEJxSmVeJO0WryEpsa6TPjhXjOK1wAhJUKnJlcSVt9pruyRJOHG02d1FtzPUWXr7MD+
 rnqA==
X-Gm-Message-State: AOAM5312x/1oM3qCYmT6WWD1PnLthZF6q5klXO3P+LN1AIUnkJFgdYZt
 wf+jpkSk87Zop5sKuvkXMO5bfZOc97or8zI74dg=
X-Google-Smtp-Source: ABdhPJycrk2SDlZgHzTDhg9lJXQwtQoDox9LR72Vg7tmBV/z0zsiYPUgLgQghhPKoDT8OrM+dj0sNsg0LB9NomYB4k4=
X-Received: by 2002:a4a:d89a:: with SMTP id b26mr15783705oov.11.1622452981041; 
 Mon, 31 May 2021 02:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210518112857.1198415-1-aisheng.dong@nxp.com>
In-Reply-To: <20210518112857.1198415-1-aisheng.dong@nxp.com>
From: Dong Aisheng <dongas86@gmail.com>
Date: Mon, 31 May 2021 17:21:51 +0800
Message-ID: <CAA+hA=SSeRrnBRGeqVxJ71Cv0uxydidWoKmG6b0bYzoEdcgqOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] dma-contiguous: return early for dt case in
 dma_contiguous_reserve
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
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

On Tue, May 18, 2021 at 7:29 PM Dong Aisheng <aisheng.dong@nxp.com> wrote:
>
> dma_contiguous_reserve() aims to support cmdline case for CMA memory
> reserve. But if users define reserved memory in DT,
> 'dma_contiguous_default_area' will not be 0, then it's meaningless
> to continue to run dma_contiguous_reserve(). So we return early
> if detect 'dma_contiguous_default_area' is unzero.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Gently ping

Regards
Aisheng

> ---
>  kernel/dma/contiguous.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 3d63d91cba5c..ebade9f43eff 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -171,6 +171,9 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>         phys_addr_t selected_limit = limit;
>         bool fixed = false;
>
> +       if (dma_contiguous_default_area)
> +               return;
> +
>         pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
>
>         if (size_cmdline != -1) {
> @@ -191,7 +194,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>  #endif
>         }
>
> -       if (selected_size && !dma_contiguous_default_area) {
> +       if (selected_size) {
>                 pr_debug("%s: reserving %ld MiB for global area\n", __func__,
>                          (unsigned long)selected_size / SZ_1M);
>
> --
> 2.25.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
