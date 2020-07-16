Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91299C433E5
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 12:52:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B4B20739
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 12:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOjZAMG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B4B20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E80242002B;
	Thu, 16 Jul 2020 12:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0dseHbXJ7L07; Thu, 16 Jul 2020 12:52:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1C2B720030;
	Thu, 16 Jul 2020 12:52:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2465C07FF;
	Thu, 16 Jul 2020 12:52:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65E8AC08A2
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 12:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5776A2002B
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 12:52:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LRGyT10mbY5c for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 12:52:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 509D92549C
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 12:52:08 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id q7so7049330ljm.1
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HCnwyZoMzuPKsERhk3jj3Z4cbSkn3iN0nOs3nxQkMq0=;
 b=sOjZAMG0GZhuc7hKNYzLVK9cSOp5waHIXzYWhb43Fz8ZgX9z9+bNavNcAEpG70dgBk
 ymAxg8CBGeGJogHJ8EZfOJxQxQrcVu4fbyFxrtPhw/lrQtdZwuFiFnU3Ns9+2O77tI7T
 t+cLNEO2tso3H8qv2p3wup/rHCTC9UnJFDeLIR9S3z+CUU/XMjzPHMO8ZlQKuTNz6l/0
 eNvh5dAs47H6r7AMj0WyGKIZ3da6n+akTPo1vtDqAr7R9LVFcAQzgEkzK7V29ThxVSfl
 tlafLPmggszgOc2KgLZv3yeFkDfhxzR7uBKLqBJdhVoSPaG7IxVDNowwB3Q79TU4M5aw
 Us8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HCnwyZoMzuPKsERhk3jj3Z4cbSkn3iN0nOs3nxQkMq0=;
 b=rEMNFwKETCd/VEXIrkwvCT2wJlBEGDKSRHEcX9JWsvMdKjzFpXqxeYzyL1OfGyl/AS
 O28q1GjOfslG78z+m34L6OEH35X6kxZv+IisHJF351c1V8RS/b6h5fDvxe+Dcw4jkjX1
 0qm8CVvKjCTHge6YTBLPq/YaFFtITCZFyZL+7E3Tojf3b7MkeFf6CRoQvQw5tu5TMIFX
 bhZe2BZEdcfZV/oBHVwWaDQrqdf9X2t+1rrMHlmSVUOJw1tZXVljdG8FVaigM4z/4I4L
 u4FqnHmh4zIjIdlze1x462ZKKittGhoWij8IeU9Ce/RQR8pw/ZM2TpR2PyHJ5HYKNMG+
 uceg==
X-Gm-Message-State: AOAM531yd1q0FEFPs5QBaH9KkG9XkUEGEnrc+DtjL1XmCadyK71P6mp2
 1ftbyVZNwXOkbjn6dxZgofx5uWne+PNLzFROEqRk4A==
X-Google-Smtp-Source: ABdhPJw/BhPEYT/8575MJQZaoQ8ocAWYoTgsBn5QFuT7ytXA0Q8/v+AT4JkXs2IK1Vyo3oIafinMzE0ToIsQaj9hRe4=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr1900535ljg.144.1594903926142; 
 Thu, 16 Jul 2020 05:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200710231824.60699-1-john.stultz@linaro.org>
In-Reply-To: <20200710231824.60699-1-john.stultz@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2020 14:51:55 +0200
Message-ID: <CACRpkdaSiUwa0i5nQy8EZOg7smN3g2a+1AV2x+1PShNc071UFg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Allow for qcom-pdc to be loadable as a module
To: John Stultz <john.stultz@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, MSM <linux-arm-msm@vger.kernel.org>,
 Todd Kjos <tkjos@google.com>
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

On Sat, Jul 11, 2020 at 1:18 AM John Stultz <john.stultz@linaro.org> wrote:

> This patch series provides exports and config tweaks to allow
> the qcom-pdc driver to be able to be configured as a permement
> modules (particularlly useful for the Android Generic Kernel
> Image efforts).
>
> This was part of a larger patch series, to enable qcom_scm
> driver to be a module as well, but I've split it out as there
> are some outstanding objections I still need to address with
> the follow-on patches, and wanted to see if progress could be
> made on this subset of the series in the meantime.
>
> New in v3:
> *  Drop conditional usage of IRQCHIP_DECLARE as suggested by
>    Stephen Boyd and Marc Zyngier

This patch set looks entirely reasonable to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
