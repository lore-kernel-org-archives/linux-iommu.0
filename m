Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB1C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 09:36:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3160764F6C
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 09:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3160764F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B49F9207A6;
	Wed,  3 Feb 2021 09:36:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bxDI2C6fDd6r; Wed,  3 Feb 2021 09:36:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 72F0F204EB;
	Wed,  3 Feb 2021 09:36:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62DD5C0FA7;
	Wed,  3 Feb 2021 09:36:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF347C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B9BB686770
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7KyMsbD9qECO for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 09:36:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 28B8884016
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:36:09 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id l12so27490681ljc.3
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 01:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6GnRcNKibxztYcvUQzDGCgHL6AviuIrNT8YjYqp4o+g=;
 b=FULorK8vsWlfT9sFbadP6z4zJxOs9AiVRnvUe7J2rfjR8hquBrIAC9NlypGz9UeYow
 fXSHbY/48b4B5FIWctnJBzdDTMZq9tEReP6vEhxmitTovmHof64D1sG8EOw5cefbG83b
 b6WHunVOHISOl9wNdGRCjou+X/7CDB2GZGoy1u48n6WpbKI7eHXwxjaSrEfO+KrQAeGa
 MiIrxSEsA6COQt6+e85FcGXmmkpNbcJ6g/AC8Pvg2DqvXoSiLe8ytw/3OA8kIkmwOMSD
 yBCRLiGLJ8rT5lH/iTbOBidfsCnzjchOZKQeN/OhXQqHkDq0+TtRW3ouM6MyzaxbLyzz
 Rqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6GnRcNKibxztYcvUQzDGCgHL6AviuIrNT8YjYqp4o+g=;
 b=Xp8R9yX3K35Uwo6Rut3A8nbhLXk41dJN0T03YsH/GHZK9r9Td3jNRhZWl9nSRF8ozC
 VXEU0vARhypq6A4LTiFHmuxTREom1TOM1PLXy+4bL81ckCgdmTGievhVwFJRkaE/koxD
 +WaTTSthFQPtnTIVRSLptxJKqQKLjwUP2+JV+3q15r0vG99El4JzD8KwF+8V0CafY9Qb
 4drTESCwxr8AVf9qq4xT6swSB7YJUmiZbxzTs776UwZvV1de2dAc1xA9BkfXFTctpD5W
 Q9BJ8MYAoD8vy7NfBcdOseBTdXQ+zom1hYxNofwH66VALMT4Myu3DKlTORU5AXAdL4CM
 j1lQ==
X-Gm-Message-State: AOAM533huIMcvsG5UC+jOHnwRRYR4qElm4fr8LR88PKjgfINq1zzVV+d
 4FMy9+8xQbKGk5UIMuZlyfVBw8ugLfFHgsiU4qoXYA==
X-Google-Smtp-Source: ABdhPJy4FflXpUjChVW+K6gb6Ck95k2cKDdhJLsDyahupxAN2akbTAdmitGaAnNIhYk43WdM7SiuRSAXZjsbLKYTmG8=
X-Received: by 2002:a2e:8746:: with SMTP id q6mr1238712ljj.326.1612344967044; 
 Wed, 03 Feb 2021 01:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20210202205544.24812-1-robh@kernel.org>
In-Reply-To: <20210202205544.24812-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Feb 2021 10:35:56 +0100
Message-ID: <CACRpkdZF1zvykXj58oKjBVqomH86BSW8N=noDs8q3BA--CLAvw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Fix undocumented compatible strings in
 examples
To: Rob Herring <robh@kernel.org>
Cc: Tomer Maimon <tmaimon77@gmail.com>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>,
 Tali Perry <tali.perry1@gmail.com>, Daniel Palmer <daniel@thingy.jp>,
 linux-i2c <linux-i2c@vger.kernel.org>, Will Deacon <will@kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Avi Fishman <avifishman70@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Jeffery <andrew@aj.id.au>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Feb 2, 2021 at 9:55 PM Rob Herring <robh@kernel.org> wrote:

> Running 'dt-validate -m' will flag any compatible strings missing a schema.
> Fix all the errors found in DT binding examples. Most of these are just
> typos.
>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Daniel Palmer <daniel@thingy.jp>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Tomer Maimon <tmaimon77@gmail.com>
> Cc: Tali Perry <tali.perry1@gmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Vincent Cheng <vincent.cheng.xh@renesas.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Ooops.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
