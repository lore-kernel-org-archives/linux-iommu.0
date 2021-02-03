Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E6DC433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 21:09:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE9E64F43
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 21:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE9E64F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8169186234;
	Wed,  3 Feb 2021 21:09:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ththtMhcOZUS; Wed,  3 Feb 2021 21:09:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 444648621D;
	Wed,  3 Feb 2021 21:09:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29E22C0FA8;
	Wed,  3 Feb 2021 21:09:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63135C0174
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 21:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 49DE286B16
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 21:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VYmhuKxhOPGQ for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 21:09:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B92B686B03
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 21:09:41 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id w124so1385580oia.6
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 13:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nNasvnVnGdaLNC1X/0gD5+vaBF/Bt3/vdbxlWRVVcDU=;
 b=ABx5nFoVWWpmsh70BCBdM7BwZtFkgcrSY6z4u+IBvTO6EMx3Qq7DSB24HN6BEEVrZ/
 k6ooQCJe5qfIToes18XABuNTBu9ZC97gfEVTF7HYsI7T0AlRPH1O0qjZtnNXTHih6Gey
 neqZRFUSFp2qrE9yyJIYw1F3GQvBuUJNTp0tabIDDUrDDMzOCGeSCweK88PGEdRRS58X
 0/BcyqsxgY8RsynciswgI4K4+2N3qAWpN+gLbevuGe5l8NnA9L6sems3w9V+uxAEBM00
 /G/QHA7n2h2n6F2w3T5YB2f0nM+6xUPomXAx46IeWvG4Q2S14Et3T8S21KFbGL/O2WHi
 ClnQ==
X-Gm-Message-State: AOAM530+mfHwRxq8VcsKjIDdA/beM/QSm6EErnOptezLXIzYoVqdUA+h
 jdWTq75sbdjV+TLZ3A5WpQ==
X-Google-Smtp-Source: ABdhPJziQ1MGayJwHSZF4XHn8QPqAgRmZ9o049qxfBV9fRup24v2U17idXkjmSVNyup8I87aVF/jeg==
X-Received: by 2002:aca:1808:: with SMTP id h8mr3234854oih.150.1612386581033; 
 Wed, 03 Feb 2021 13:09:41 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x9sm663527ota.23.2021.02.03.13.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 13:09:40 -0800 (PST)
Received: (nullmailer pid 2451645 invoked by uid 1000);
 Wed, 03 Feb 2021 21:09:38 -0000
Date: Wed, 3 Feb 2021 15:09:38 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: Fix undocumented compatible strings in
 examples
Message-ID: <20210203210938.GE3706951@robh.at.kernel.org>
References: <20210202205544.24812-1-robh@kernel.org>
 <161231243653.76967.3231080427102153199@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161231243653.76967.3231080427102153199@swboyd.mtv.corp.google.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>,
 Tali Perry <tali.perry1@gmail.com>, Daniel Palmer <daniel@thingy.jp>,
 linux-i2c@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, linux-gpio@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Avi Fishman <avifishman70@gmail.com>, linux-kernel@vger.kernel.org,
 Andrew Jeffery <andrew@aj.id.au>, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Tue, Feb 02, 2021 at 04:33:56PM -0800, Stephen Boyd wrote:
> Quoting Rob Herring (2021-02-02 12:55:42)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
> > index fa0ee03a527f..53cc6df0df96 100644
> > --- a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
> > +++ b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
> > @@ -18,7 +18,7 @@ properties:
> >      const: 1
> >  
> >    compatible:
> > -    const: allwinner,sun9i-a80-usb-clocks
> > +    const: allwinner,sun9i-a80-usb-clks
> 
> Should the file name change too?

Yes, I'll fix that while applying.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
