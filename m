Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D89C433EF
	for <iommu@archiver.kernel.org>; Wed, 19 Jan 2022 15:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D167260F1A;
	Wed, 19 Jan 2022 15:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s5tADhSB0xUD; Wed, 19 Jan 2022 15:29:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 994E860B28;
	Wed, 19 Jan 2022 15:29:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AE9CC0039;
	Wed, 19 Jan 2022 15:29:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31353C002F
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 15:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F80C414C2
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 15:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwZE9nF9sQuB for <iommu@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 15:29:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43C9B408EA
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 15:29:26 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2062A614F4
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 15:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAB5C340F9
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642606164;
 bh=eiP3xCZsCy88f8i33Qm5tHFJtlYCUAmvYn1cMS/h6LE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=I1dPJN3TNsxi+GutnLfvLdAkrWaj+YTzuNOht44jN2mKf4fq/VkPg/jPsPShpheIN
 w60sca0yrzhrw+coRSJ3HgeB7dL4Ychtb88u293ZJQTXzrjtyODiFgDB4cXmqZt6xV
 AcWnpVHvAgN8zPYxE5Mku4TyInsZsNHWhAHgeTnCLSpuomcTJdzI+merY+u28R4kbp
 lA5zvYtpL5fMlJ72EaUW0GKDHa+8MhGWvomV5SCUqAS8IJvzymtE9RhCMTcXzPdioM
 OGRz+34yZg5gVhz37TdPybPlWPnLd2QB1HKIoGQ1bf4IAC//3aLt8oCkE4Rw27Uo5n
 z2G0zV2aggLyQ==
Received: by mail-ed1-f41.google.com with SMTP id p12so13728810edq.9
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 07:29:24 -0800 (PST)
X-Gm-Message-State: AOAM532AUKiE4vzO6KPJDTWtKUoz2MAf3pzWO6QlLs7Ds3D1LH5aatMY
 4pQC81Df/U3FtkN+dnZs95+mvvnT3ohlR9XEEQ==
X-Google-Smtp-Source: ABdhPJyIYkyo1vqpmGZeQ86/fG6wkTZGxnD2kYhf8PsblQjCHqdJn557iPYrUwhbvXoPPN23Wd86PLfRtc/FtNJz2Yw=
X-Received: by 2002:a17:906:7801:: with SMTP id
 u1mr8098133ejm.82.1642606151522; 
 Wed, 19 Jan 2022 07:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20220119015038.2433585-1-robh@kernel.org>
 <20220119103542.el3yuqds6ihpkthn@skbuf>
In-Reply-To: <20220119103542.el3yuqds6ihpkthn@skbuf>
From: Rob Herring <robh@kernel.org>
Date: Wed, 19 Jan 2022 09:28:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKeTmew8ZaNsXqVsXCrkW9zb1V2JcANRVPXyEHqZnVWzA@mail.gmail.com>
Message-ID: <CAL_JsqKeTmew8ZaNsXqVsXCrkW9zb1V2JcANRVPXyEHqZnVWzA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Improve phandle-array schemas
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-remoteproc@vger.kernel.org,
 alsa-devel@alsa-project.org, dri-devel <dri-devel@lists.freedesktop.org>,
 Sebastian Reichel <sre@kernel.org>,
 "open list:LIBATA SUBSYSTEM \(Serial and Parallel ATA drivers\)"
 <linux-ide@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Pavel Machek <pavel@ucw.cz>,
 "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
 netdev <netdev@vger.kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Lee Jones <lee.jones@linaro.org>, linux-riscv@lists.infradead.org,
 Linux LED Subsystem <linux-leds@vger.kernel.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Marc Zyngier <maz@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, Jakub Kicinski <kuba@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, linux-usb@vger.kernel.org,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 devicetree@vger.kernel.org, "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Kalle Valo <kvalo@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-can@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Viresh Kumar <vireshk@kernel.org>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
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

On Wed, Jan 19, 2022 at 4:35 AM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> On Tue, Jan 18, 2022 at 07:50:38PM -0600, Rob Herring wrote:
> > The 'phandle-array' type is a bit ambiguous. It can be either just an
> > array of phandles or an array of phandles plus args. Many schemas for
> > phandle-array properties aren't clear in the schema which case applies
> > though the description usually describes it.
> >
> > The array of phandles case boils down to needing:
> >
> > items:
> >   maxItems: 1
> >
> > The phandle plus args cases should typically take this form:
> >
> > items:
> >   - items:
> >       - description: A phandle
> >       - description: 1st arg cell
> >       - description: 2nd arg cell
> >
> > With this change, some examples need updating so that the bracketing of
> > property values matches the schema.
> > ---
> (...)
> > diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> > index 702df848a71d..c504feeec6db 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> > @@ -34,6 +34,8 @@ properties:
> >        full routing information must be given, not just the one hop
> >        routes to neighbouring switches
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      maxItems: 1
> >
> >    ethernet:
> >      description:
>
> For better or worse, the mainline cases of this property all take the
> form of:
>
> arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
>                                 link = <&switch1port9 &switch2port9>;
>                                 link = <&switch1port10 &switch0port10>;
> arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
>                                                 link = <&switch1port6
>                                                         &switch2port9>;
>                                                 link = <&switch1port5
>                                                         &switch0port5>;
> arch/arm/boot/dts/vf610-zii-scu4-aib.dts
>                                                 link = <&switch1port10
>                                                         &switch3port10
>                                                         &switch2port10>;
>                                                 link = <&switch3port10
>                                                         &switch2port10>;
>                                                 link = <&switch1port9
>                                                         &switch0port10>;
>
> So not really an array of phandles.

Either form is an array. The DT yaml encoding maintains the
bracketing, so how the schema is defined matters. To some extent the
tools will process the schema to support both forms of bracketing, but
this has turned out to be fragile and just doesn't work for phandle
arrays. I'm working on further changes that will get rid of the yaml
encoded DT format and validate DTB files directly. These obviously
have no bracketing and needing the DTS source files to change goes
away. However, to be able to construct the internal format for
validation, I do need the schemas to have more information on what
exactly the phandle-array contains.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
