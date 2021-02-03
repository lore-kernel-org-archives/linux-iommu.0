Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E4DC433E6
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 15:55:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B3F64F8D
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 15:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B3F64F8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C59018712C;
	Wed,  3 Feb 2021 15:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VTLBlztmD09e; Wed,  3 Feb 2021 15:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D517087121;
	Wed,  3 Feb 2021 15:55:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3F5BC0FA8;
	Wed,  3 Feb 2021 15:55:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89567C0174
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 15:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 74A0687150
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 15:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qRgQBLz5q76V for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 15:55:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CEA7B8712F
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 15:55:21 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id h6so339275oie.5
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 07:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qT9vhKEcJnv2UxHfk3LsH4oahpbnsqDoYZLdzv8tkwQ=;
 b=m5BiHIyksE+a7QZt1wGK7nooyjTmEdg9BPVQ5tsewp05x4o6WulQfV8SAKmiozj9rZ
 tuAItq+myHAgbJ1izJrceth2/HyBJyXYjILkaBCV77D5D6K+IyYZRvy9c2J43Buel40o
 Ep/lHhBEuphe2A8QFtRDMRefJAIABbOt1mzliZhWyl23MXwg7R61TvMDdTYIZQJnG11R
 Hyaxx7Kgo+NuNz7gEYEGeauUpntb9f3fwbL4d4krl/Be/wpzgQ0+yT1alxN+u93O3kqh
 Mn6/+ThrZpC0YsEAdTTcvk8Ock9gH3NQKwdTZqNRt8Ju8ASpO8fY6BiNaX0GX3k9o7hp
 EN6g==
X-Gm-Message-State: AOAM531ZHxw+muYBMJegBhVJn442yrgn7KIxJBCjxlFabEq3d0cUD1N+
 Pd4PKNFHp6WR/vSYHhjwxw==
X-Google-Smtp-Source: ABdhPJxmOBQcH5R+lFiUlGBqVbuj5kwZxcJFcUI25C3II5lOgKlwz+nfG7ePzMnfdKQ5jcv5RyiyOg==
X-Received: by 2002:aca:4e13:: with SMTP id c19mr2424431oib.66.1612367721055; 
 Wed, 03 Feb 2021 07:55:21 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id o14sm481868oof.38.2021.02.03.07.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 07:55:19 -0800 (PST)
Received: (nullmailer pid 1895243 invoked by uid 1000);
 Wed, 03 Feb 2021 15:55:17 -0000
Date: Wed, 3 Feb 2021 09:55:17 -0600
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] dt-bindings: Fix errors in 'if' schemas
Message-ID: <20210203155517.GC3706951@robh.at.kernel.org>
References: <20210202205544.24812-1-robh@kernel.org>
 <20210202205544.24812-3-robh@kernel.org>
 <CAMuHMdVvtUvrQh3-3kxaqqWvHnF_UOQmt-6jq_GkX8g=cszUug@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdVvtUvrQh3-3kxaqqWvHnF_UOQmt-6jq_GkX8g=cszUug@mail.gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomer Maimon <tmaimon77@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Tali Perry <tali.perry1@gmail.com>, Eric Anholt <eric@anholt.net>,
 Daniel Palmer <daniel@thingy.jp>, Linux I2C <linux-i2c@vger.kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>, linux-leds <linux-leds@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
 Ray Jui <rjui@broadcom.com>, Maxime Ripard <mripard@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Avi Fishman <avifishman70@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Stephen Boyd <sboyd@kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Jeffery <andrew@aj.id.au>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
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

On Wed, Feb 03, 2021 at 09:01:23AM +0100, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Tue, Feb 2, 2021 at 9:55 PM Rob Herring <robh@kernel.org> wrote:
> > Properties in if/then schemas weren't getting checked by the meta-schemas.
> > Enabling meta-schema checks finds several errors.
> >
> > The use of an 'items' schema (as opposed to the list form) is wrong in
> > some cases as it applies to all entries. 'contains' is the correct schema
> > to use in the case of multiple entries.
> 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Thanks for your patch!
> 
> > --- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > @@ -81,9 +81,8 @@ properties:
> >  if:
> >    properties:
> >      compatible:
> > -      items:
> > -        enum:
> > -          - renesas,usb2-phy-r7s9210
> > +      contains:
> > +        const: renesas,usb2-phy-r7s9210
> 
> Single entry, so "contains" not needed?

No, you are misunderstanding how these work. 'contains' means at least 
one entry in an array passes with the subschema. In this case, 
'renesas,usb2-phy-r7s9210' must appear somewhere in the 'compatible' 
values. (Before, it said *every* entry must be 
'renesas,usb2-phy-r7s9210'.) As there is a fallback compatible, we need 
'contains'.

> > --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> > @@ -76,11 +76,10 @@ required:
> >  if:
> >    properties:
> >      compatible:
> > -      items:
> > -        enum:
> > -          - renesas,pfc-r8a73a4
> > -          - renesas,pfc-r8a7740
> > -          - renesas,pfc-sh73a0
> > +      enum:
> > +        - renesas,pfc-r8a73a4
> > +        - renesas,pfc-r8a7740
> > +        - renesas,pfc-sh73a0
> 
> Missing "contains"?

No. In this case, 'compatible' is always a single entry, so no 
'contains' needed (but would work). If compatible is one of these 3 
strings, then the 'if' is true.

The original way would actually work in this case (i.e. is valid 
json-schema), but we require 'items' to have a size (maxItems/minItems) 
in our meta-schema.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
