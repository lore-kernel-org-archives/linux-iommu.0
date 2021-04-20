Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB9CC433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:07:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CF7611F2
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CF7611F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCFD6402E1;
	Tue, 20 Apr 2021 09:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CNwP_lziGmp5; Tue, 20 Apr 2021 09:07:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id E01E5402E3;
	Tue, 20 Apr 2021 09:07:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A95F9C000F;
	Tue, 20 Apr 2021 09:07:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEB70C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87443839E5
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:07:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JPQlH2_7BCgD for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:07:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 134CC81BC2
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:07:46 +0000 (UTC)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MEVBc-1lIqBh3tAA-00FzsA for <iommu@lists.linux-foundation.org>; Tue, 20
 Apr 2021 11:07:43 +0200
Received: by mail-wr1-f53.google.com with SMTP id e5so8129021wrg.7
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 02:07:43 -0700 (PDT)
X-Gm-Message-State: AOAM5315KEKRZts/cCrOM2vUrpfc5NXMLYwCZgLkJ20Db1jMJjPdz1C5
 XmOdcrzgvCZBQBrvojHT1BkBfVfOjGwQkYS+zX0=
X-Google-Smtp-Source: ABdhPJwSiNwlZ27l6d0oeVOJMjBIBpaEf6fV+Kr02yQOCGa6DdHdokE+eIs4+TiyDD+ybgS8jO4hGYikHl0QAhmuRDs=
X-Received: by 2002:adf:db4f:: with SMTP id f15mr19571156wrj.99.1618909652608; 
 Tue, 20 Apr 2021 02:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210419042722.27554-1-alice.guo@oss.nxp.com>
 <20210419042722.27554-4-alice.guo@oss.nxp.com>
 <YH0O907dfGY9jQRZ@atmark-techno.com>
 <CAMuHMdVY1SLZ0K30T2pimyrR6Mm=VoSTO=L-xxCy2Bj7_kostw@mail.gmail.com>
 <YH1OeFy+SepIYYG0@atmark-techno.com>
 <CAK8P3a1Mu2F0irDDCL-50HiHth29iYFL5b7WHZ=UX6W7zzoxAg@mail.gmail.com>
 <YH4VdPNO9cdzc5MD@atmark-techno.com>
In-Reply-To: <YH4VdPNO9cdzc5MD@atmark-techno.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Apr 2021 11:07:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1GjeHyMCworQYVtp5U0uu2B9VBHmf9y0hGn-o8aKSJZw@mail.gmail.com>
Message-ID: <CAK8P3a1GjeHyMCworQYVtp5U0uu2B9VBHmf9y0hGn-o8aKSJZw@mail.gmail.com>
Subject: Re: [RFC v1 PATCH 3/3] driver: update all the code that use
 soc_device_match
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>
X-Provags-ID: V03:K1:huzd72meoCc1JTmA0R/znmeSh6CpyC+ET7pab1srh1tcdjiigZC
 icP/lJqvShuOCq/gU9ynDMrr4NdSV4dFPVWe4yksRvjaEVX2TGpgUKWOioXeTqiuY+KvCH5
 zYlTo5OzIuGqe7vCG+09dQAKphCTG0AG9OsoviQAzskeDDEDi67GaXzW4NaYJYZhYZ0u7sc
 xxqMSCBdZSEifHAoNOSVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:45JNHkjGA5g=:FTuJfOdM3rqjzHdMGP2OWi
 c33LGaVfPea+0t+IAQO6K7GVZFChlzPzfF62Y/t9dcUwFKhWPUApBXtWZSH28QDYWsnak300S
 yNYVk5WcoEqImqsph6PuwE0hqS4MvWDDWkecRweOC8/pKgGbKiLDntnLEOIuJQCI0brqdZtKA
 ZDqDKtFR57N4KfS9dbKBX1kS1J1s5ZhyIJ+8DkKu0izrUSd8q7LPF6qZdPuxX/UAi2It6rk+1
 5ELwhxz3i+OIayvsdfZV86dtUP8TrRxwrwS5WBy6Hl+tYGKWkU8eihyRLC51qDwdMHsRZHTMR
 77CjCvfExRKLp2f1wDcERKKLnqodbYx8fepI/BUMWy/drqZh5Hv6zjst0wQUxTR1k8KcFt3M6
 6Ta1dubN8ru8rO97tmDWMgVzInPdWsTY4EQsPtik199OoiFcMiwBnrJ8Ww49fdPG8PT2vl0qi
 /0szyNtZnIk8oUu7Fj0fu2Npejp+gFTg7ojRMRE2FJky2yzVOPz97plpUoP/pnxhLw6YmsF+a
 oQ9NiY7mGMtKF7nTfiYOgR08DaBAPUf+e8fOj1A4FN95vugY/JXSc5hfXw7juQGbaXl53EPgs
 jx/epLKjBSe8hhN0IRzHuyAfYvuLJOT4dijBQhkfM0NOqEMIjfhB08UIca/KTLf4Yq1w05S3q
 j6Do=
Cc: Ulf Hansson <ulf.hansson@linaro.org>, aymen.sghaier@nxp.com,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Rafael Wysocki <rafael@kernel.org>, David Airlie <airlied@linux.ie>,
 Michael Turquette <mturquette@baylibre.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Networking <netdev@vger.kernel.org>,
 linux-phy@lists.infradead.org, peter.ujfalusi@gmail.com,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>,
 linux-staging@lists.linux.dev,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Kishon <kishon@ti.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap <linux-omap@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Linux PM list <linux-pm@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Eduardo Valentin <edubezval@gmail.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "Alice Guo \(OSS\)" <alice.guo@oss.nxp.com>, Felipe Balbi <balbi@kernel.org>,
 tomba@kernel.org, Stephen Boyd <sboyd@kernel.org>,
 gregkh <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>,
 USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Robert Foss <robert.foss@linaro.org>,
 Leo Li <leoyang.li@nxp.com>, Tony Prisk <linux@prisktech.co.nz>,
 Vinod Koul <vkoul@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Keerthy <j-keerthy@ti.com>, dmaengine@vger.kernel.org,
 Roy Pledge <Roy.Pledge@nxp.com>, jyri.sarha@iki.fi,
 David Miller <davem@davemloft.net>
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

On Tue, Apr 20, 2021 at 1:44 AM Dominique MARTINET
<dominique.martinet@atmark-techno.com> wrote:
> Arnd Bergmann wrote on Mon, Apr 19, 2021 at 02:16:36PM +0200:
> > For built-in drivers, load order depends on the initcall level and
> > link order (how things are lined listed in the Makefile hierarchy).
> >
> > For loadable modules, this is up to user space in the end.
> >
> > Which of the drivers in this scenario are loadable modules?
>
> All the drivers involved in my case are built-in (nvmem, soc and final
> soc_device_match consumer e.g. caam_jr that crashes the kernel if soc is
> not identified properly).

Ok, in that case you may have a chance to just adapt the initcall
levels. This is somewhat fragile if someone else already relies
on a particular order, but it's an easy one-line change to change
a driver e.g. from module_init() or device_initcall() to arch_initcall().

> I frankly don't like the idea of moving nvmem/ above soc/ in
> drivers/Makefile as a "solution" to this (especially as there is one
> that seems to care about what soc they run on...), so I'll have a look
> at links first, hopefully that will work out.

Right, that would be way more fragile.

I think the main problem in this case is the caam driver that really
should not look into the particular SoC type or even machine
compatible string. This is something we can do as a last resort
for compatibility with busted devicetree files, but it appears that
this driver does it as the primary method for identifying different
hardware revisions. I would suggest fixing the binding so that
each SoC that includes one of these devices has a soc specific
compatible string associated with the device that the driver can
use as the primary way of identifying the device.

We probably need to keep the old logic around for old dtb files,
but there can at least be a comment next to that table that
discourages people from adding more entries there.

      Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
