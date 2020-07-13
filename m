Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F589C433E4
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 00:38:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DCE206F0
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 00:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KB727iWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DCE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E9327870EB;
	Mon, 13 Jul 2020 00:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bTloOgWr5W-d; Mon, 13 Jul 2020 00:38:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1ED23870DE;
	Mon, 13 Jul 2020 00:38:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7839C0894;
	Mon, 13 Jul 2020 00:38:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7ECE9C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 00:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 67962221F8
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 00:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aa+sO2nH9nXy for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 00:38:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
 [209.85.217.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 2DC0420554
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 00:38:36 +0000 (UTC)
Received: by mail-vs1-f67.google.com with SMTP id x205so5734822vsc.11
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 17:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g0AyRgeo4BEr9j6w4Przg7qSFRU4h688XiJcnxouhyk=;
 b=KB727iWE6w5PGxDvHa2wMRrbthwrun9FRgyTC4B4X7EbxLxG6FdFeC67YzVOR4lsHJ
 zyacQjO2mMSGubdbACm0TfaMStvb+6H3WogGdpeeIJm1xd8Iw2CS0a0Ob1BjenJom+xI
 dcKKYQB/EsxLk/eyTmJPjelq7Zl1iRYhjVfw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g0AyRgeo4BEr9j6w4Przg7qSFRU4h688XiJcnxouhyk=;
 b=OeYSdyZs8S/KXnug4ZV0UNnQ4fzA2lylR1qxqNfKs58ixublmOErUMn7zRVJhsy7nk
 dib3YgsFG3nDJyNQRGh9GJLK25nkYznKZhZocTsh/UFJorlFaqr/Be2WJN6E2dov7FgW
 dkIDoeXeKYL2ME2XLG0VIUpaYtWuRyWE+OhmcOc1Ui+os5/3On1ZA5drrquOMEfZVomu
 jy7NtNPiAW9jZFSl8pOiEnnH92ujvVZaE048Azgv5CzVCXdOfIq4D9wMikUfHK2LYfsp
 Fk+sAMwI2Z/ghKsNsUc3S6SHUdBzvgwBavfYMpbdTa2CDjuYpuAG8sqs+353VhxKGXUr
 +htQ==
X-Gm-Message-State: AOAM533/EW5cAKX95lwyohN0a/NgsoJ7MCfhSAKLhHpwQzN8JxUFeKAo
 kHugq3nvj8CIP6fXU3jjlaDGOzyQyu75YehoYZwc6w==
X-Google-Smtp-Source: ABdhPJyT1J4v4BmuydEm21M0iODeO7rG9nBCEHI+CqgAFKtghpRKBPQRwE/iexbiZAAoAgeSe+cmOhjfU0b5xXQV/no=
X-Received: by 2002:a67:f5c6:: with SMTP id t6mr13334091vso.14.1594600715022; 
 Sun, 12 Jul 2020 17:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-7-yong.wu@mediatek.com>
In-Reply-To: <20200711064846.16007-7-yong.wu@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Mon, 13 Jul 2020 08:38:24 +0800
Message-ID: <CANMq1KAhFCWfywV=OiHgW00pof8K8TdwC6Hzgyj=QWSiWBf1ag@mail.gmail.com>
Subject: Re: [PATCH 06/21] iommu/io-pgtable-arm-v7s: Use ias to check the
 valid iova in unmap
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, Devicetree List <devicetree@vger.kernel.org>,
 cui.zhang@mediatek.com, srv_heupstream <srv_heupstream@mediatek.com>,
 chao.hao@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 lkml <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
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

On Sat, Jul 11, 2020 at 2:50 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> As title.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 4272fe4e17f4..01f2a8876808 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -717,7 +717,7 @@ static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>  {
>         struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
>
> -       if (WARN_ON(upper_32_bits(iova)))
> +       if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))

This is a little odd as iova is unsigned long and 1ULL is unsigned long long.

Would it be better to keep the spirit of the previous test and do
something like:
 if (WARN_ON(iova >> data->iop.cfg.ias)) ?

>                 return 0;
>
>         return __arm_v7s_unmap(data, gather, iova, size, 1, data->pgd);
> --
> 2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
