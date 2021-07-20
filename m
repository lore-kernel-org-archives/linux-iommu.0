Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6D8C07E95
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 03:36:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8FA6100C
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 03:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8FA6100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9DA683A56;
	Tue, 20 Jul 2021 03:36:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MzICieIzCI53; Tue, 20 Jul 2021 03:36:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 49DC483A52;
	Tue, 20 Jul 2021 03:36:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24597C001A;
	Tue, 20 Jul 2021 03:36:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4418EC000E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 271E783A56
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yr2lNA_SeI9T for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 03:36:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0331583A52
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:36:19 +0000 (UTC)
Received: by mail-io1-xd2b.google.com with SMTP id z17so15868608iog.12
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 20:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hsld/MqEdNnnYH5CtR/OwDOn1BQhsfMhHOgaoiJiVrI=;
 b=dpHwDqJxuZ7I6pCO4kOk3S3DbouJqnIXXFCmTmGA6eKMwwLcF3WIzUt4VaApCA9XTx
 wIIl/B2FjV8Y3fkzdWjRp/Bv/kQh0JjXXtcusNltw0bRGIuaCQtQaMrv3N58+LB/d3vJ
 eOF0MjOzUlh092Mwf3jLAdi/amtGkCcjBI4As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hsld/MqEdNnnYH5CtR/OwDOn1BQhsfMhHOgaoiJiVrI=;
 b=VuTyM16aHa41nghQaKs9dDckfG73KdfWiEr4i1gWp+qw2X8K4Wv9K3HQ6ds/nkCXQl
 9uBPSvYSeQKrhQL4dz4jyEUY1fzExI7cYc3mbT0+iFv7KiUPn2OKehKhLrD6Hg/dzV3B
 wkSuALZzEnGxfBN7peYwXbvDP7AQANGJSCnr4szM7L7ZmpAhEWvk7F0qj3tRkvCv+94o
 c8YrmellxoxncYMjRqw0Obr2WjBXPA62VflpFbCYRtkxf0sM3n957wv9E7CcMkMpOLuI
 iBc35xvCi0fLJryxt3z4gw6iqt0kUtmi+QRZcqhA7pbsyDZWlMi+xZcINs7e/3hV5CiK
 vNHA==
X-Gm-Message-State: AOAM5337luZZvnOAmm+luTW/BjHws/aPXXQGunh1CIUV8D4O/wUKR14G
 qyS5MAfTKEYTzFdHNiYxQ78OgfFeZNJoDw==
X-Google-Smtp-Source: ABdhPJxvLXFoynB2N6aM6I2atjuOI1B5AhAMCday+FPHHZhpxNZ0lSADspfXNjzyWm7LWWH7iLQ38Q==
X-Received: by 2002:a5e:db02:: with SMTP id q2mr16182093iop.172.1626752178825; 
 Mon, 19 Jul 2021 20:36:18 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com.
 [209.85.166.42])
 by smtp.gmail.com with ESMTPSA id l4sm10527633ilh.41.2021.07.19.20.36.18
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 20:36:18 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id z17so15868578iog.12
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 20:36:18 -0700 (PDT)
X-Received: by 2002:a6b:e602:: with SMTP id g2mr20635619ioh.50.1626752177876; 
 Mon, 19 Jul 2021 20:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210719123054.6844-1-will@kernel.org>
 <20210719123054.6844-5-will@kernel.org>
In-Reply-To: <20210719123054.6844-5-will@kernel.org>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 20 Jul 2021 11:36:07 +0800
X-Gmail-Original-Message-ID: <CALiNf2-xKNyucan678dvzc6WwEEn6D0YFJ-DssdTDzqe9CGcgQ@mail.gmail.com>
Message-ID: <CALiNf2-xKNyucan678dvzc6WwEEn6D0YFJ-DssdTDzqe9CGcgQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] swiotlb: Emit diagnostic in swiotlb_exit()
To: Will Deacon <will@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 lkml <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

On Mon, Jul 19, 2021 at 8:31 PM Will Deacon <will@kernel.org> wrote:
>
> A recent debugging session would have been made a little bit easier if
> we had noticed sooner that swiotlb_exit() was being called during boot.
>
> Add a simple diagnostic message to swiotlb_exit() to complement the one
> from swiotlb_print_info() during initialisation.
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Link: https://lore.kernel.org/r/20210705190352.GA19461@willie-the-truck
> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Claire Chang <tientzu@chromium.org>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 7948f274f9bb..b3c793ed9e64 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -334,6 +334,7 @@ void __init swiotlb_exit(void)
>         if (!mem->nslabs)
>                 return;
>
> +       pr_info("tearing down default memory pool\n");
>         size = array_size(sizeof(*mem->slots), mem->nslabs);
>         if (mem->late_alloc)
>                 free_pages((unsigned long)mem->slots, get_order(size));
> --
> 2.32.0.402.g57bb445576-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
