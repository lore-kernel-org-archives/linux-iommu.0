Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF2C07E95
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 03:35:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167656113B
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 03:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167656113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D01BD6059E;
	Tue, 20 Jul 2021 03:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IiqGWrK8SqZv; Tue, 20 Jul 2021 03:35:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B26A760818;
	Tue, 20 Jul 2021 03:35:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 691E1C001A;
	Tue, 20 Jul 2021 03:35:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 529CDC000E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25C0340319
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:35:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7oeaO4pTFdC for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 03:35:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D77D4402B3
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 03:35:28 +0000 (UTC)
Received: by mail-io1-xd33.google.com with SMTP id w22so14343152ioc.6
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=46s+twwjNv2sIPRbtw2A5bIDmISsKXnSTnGDLXGIZ0E=;
 b=O7/9wAbSVU1X2NPTi8SQJBRiExLOOIzoQwML7nz2eyMX0iaMTG1iubRKpBfJXNStNO
 u7PZE+c6iRaq1TxMI/x8I18vNdOPyZZYzbEEa5lcue5KS4mSSV0gp7pMWqf/SnmrG+7k
 CBabDT8vj+PC+p9opMnJNVQVGfCpTVoH0TfyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=46s+twwjNv2sIPRbtw2A5bIDmISsKXnSTnGDLXGIZ0E=;
 b=Zc47JrLlm4CI8Ta8dvaLU06XVwNsf22/3ry8KjnXhhNU3SFXIVeFeMru9UbCGgRFEM
 +g/ea9CCaIwLVgDNHYLFCuHWirtyjAYR+xbTkVeanyfRYrxaIx/COUH/1PshAaukBiyZ
 ek04WPdk3q/xiZISMes7MZhGUzVuxAdg/I4hQdhioaWXEaBBeqtNi0m7dJ2EFsL9hd70
 3ul8SR9Khg2hYqhs+ze1NSWerGYk19DrnD0fPKtdlvyP5GZdYaHkqw/wKBslWCBWt1Jj
 F6DAI2UQeHnduYrDKLBZxdkXgZCOIaXSW4FJX8om2qUJTJQQQD+6CpN9Nt4n9dmLC/Ou
 P4vA==
X-Gm-Message-State: AOAM533lSMjNZ37zrm44FfH74Mo6GnbV/i5Jn7QF8p6COVKVqxBNbds/
 sxKwcgM4iYPpjzTKMsOQl88mz5GrqMHCbQ==
X-Google-Smtp-Source: ABdhPJym4Jj9HdlgmqMvTD5aR1eOKdkIWpMccSfsopOuUYgNmm8bBOx+EBHrvdyYxUIJREyoOHooMA==
X-Received: by 2002:a02:866b:: with SMTP id e98mr25193189jai.48.1626752127658; 
 Mon, 19 Jul 2021 20:35:27 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com.
 [209.85.166.175])
 by smtp.gmail.com with ESMTPSA id i5sm11230668ilc.16.2021.07.19.20.35.26
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 20:35:26 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id a7so17978104iln.6
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 20:35:26 -0700 (PDT)
X-Received: by 2002:a92:dc4f:: with SMTP id x15mr19263827ilq.64.1626752125837; 
 Mon, 19 Jul 2021 20:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210719123054.6844-1-will@kernel.org>
 <20210719123054.6844-2-will@kernel.org>
In-Reply-To: <20210719123054.6844-2-will@kernel.org>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 20 Jul 2021 11:35:14 +0800
X-Gmail-Original-Message-ID: <CALiNf29az7Y3t8OfDKRoNkhEzh4qcD-BDRX1rP-ZhfzwXAROsA@mail.gmail.com>
Message-ID: <CALiNf29az7Y3t8OfDKRoNkhEzh4qcD-BDRX1rP-ZhfzwXAROsA@mail.gmail.com>
Subject: Re: [PATCH 1/5] of: Return success from of_dma_set_restricted_buffer()
 when !OF_ADDRESS
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
> When CONFIG_OF_ADDRESS=n, of_dma_set_restricted_buffer() returns -ENODEV
> and breaks the boot for sparc[64] machines. Return 0 instead, since the
> function is essentially a glorified NOP in this configuration.
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Claire Chang <tientzu@chromium.org>

> Link: https://lore.kernel.org/r/20210702030807.GA2685166@roeck-us.net
> Fixes: fec9b625095f ("of: Add plumbing for restricted DMA pool")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/of/of_private.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 376462798f7e..f557bd22b0cf 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -173,7 +173,8 @@ static inline int of_dma_get_range(struct device_node *np,
>  static inline int of_dma_set_restricted_buffer(struct device *dev,
>                                                struct device_node *np)
>  {
> -       return -ENODEV;
> +       /* Do nothing, successfully. */
> +       return 0;
>  }
>  #endif
>
> --
> 2.32.0.402.g57bb445576-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
