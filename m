Return-Path: <SRS0=Lo8e=YA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D30C47404
	for <iommu@archiver.kernel.org>; Mon,  7 Oct 2019 08:27:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2FD2173B
	for <iommu@archiver.kernel.org>; Mon,  7 Oct 2019 08:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2FD2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9D00DAD8;
	Mon,  7 Oct 2019 08:27:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8B9ACACC;
	Mon,  7 Oct 2019 08:27:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 23A965F4;
	Mon,  7 Oct 2019 08:27:02 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id 89so10198472oth.13;
	Mon, 07 Oct 2019 01:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=VKymJxaLp2SF18G9ExdMOsAdXsmgBDVfrU/If3JZGxo=;
	b=BktjRr1f69lGtbmFYmyvwdSNpen4WheGVasO5sA6JmgwtDW21qo0AI/zoOpBCP/lpF
	4Xe34X1JR18TYc+aGdiBiPv3qVavu4H3Wmzrx5Yo56cAd0HTCyvj3wXL8y2cI60TQaNP
	xRbm5Ztb6qjuQJqBSFFoEqvh9WZz6/Gp5YSx18hGdteiHZyX0g0YSLmSoynuK/Y73oHz
	lFLDWVyyosvAnXAuAaqAdNHykGp9OU+yesAjnvj0TBq3vWmpsl5KxzdTgXnzbgwoivOn
	vd4ghj8DsQGN4Eal+mP70Hw0OkYt3QQ5vCQV4hEH9pEd19uzT22/Fgtek//huVk1d/XM
	6mnQ==
X-Gm-Message-State: APjAAAVRGFkJpYSBVcWBpLOG2xa3KZ3WPXx3Y6MZJJc70olduZp1uRaK
	VAOaxyPy1pC0A4KhRJQ6+/WenEMekp+V+FHzvvI=
X-Google-Smtp-Source: APXvYqxEOkV8nJCSllSqxdkQVypo90wcNgBvYDBNSKRgpoLJCvXTnmOdSLlUAojqzzfR9rCgupdlwodIFF5kpYpgt28=
X-Received: by 2002:a9d:17e6:: with SMTP id j93mr20339687otj.297.1570436821298;
	Mon, 07 Oct 2019 01:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191004145544.5066-1-krzk@kernel.org>
	<20191004145544.5066-3-krzk@kernel.org>
In-Reply-To: <20191004145544.5066-3-krzk@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2019 10:26:49 +0200
Message-ID: <CAMuHMdW0DSujexoGq4CJAYP40DvMcigk08aEnyQ72haY6jds5Q@mail.gmail.com>
Subject: Re: [RESEND TRIVIAL 3/3] treewide: arch: Fix Kconfig indentation
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
	linux-efi <linux-efi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>,
	"open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
	<linux-remoteproc@vger.kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	platform-driver-x86@vger.kernel.org, linux-ide@vger.kernel.org,
	dm-devel@redhat.com, keyrings@vger.kernel.org,
	MTD Maling List <linux-mtd@lists.infradead.org>,
	Linux I2C <linux-i2c@vger.kernel.org>, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	ac100@lists.launchpad.net, linux-rtc@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, scsi <linux-scsi@vger.kernel.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	linux-rdma <linux-rdma@vger.kernel.org>, esc.storagedev@microsemi.com,
	linux-security-module@vger.kernel.org,
	linux-clk <linux-clk@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	linux-input@vger.kernel.org, xen-devel@lists.xenproject.org,
	virtualization@lists.linux-foundation.org,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	"moderated list:H8/300 ARCHITECTURE"
	<uclinux-h8-devel@lists.sourceforge.jp>,
	driverdevel <devel@driverdev.osuosl.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	linux-um@lists.infradead.org, linux-block@vger.kernel.org,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Openrisc <openrisc@lists.librecores.org>,
	linux-mediatek@lists.infradead.org,
	linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
	linux-tegra <linux-tegra@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net,
	"open list:TI ETHERNET SWITCH DRIVER \(CPSW\)"
	<linux-omap@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-raid@vger.kernel.org, Jiri Kosina <trivial@kernel.org>,
	Linux MM <linux-mm@kvack.org>, netdev <netdev@vger.kernel.org>,
	Linux MMC List <linux-mmc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	alpha <linux-alpha@vger.kernel.org>, dmaengine@vger.kernel.org,
	linux-integrity <linux-integrity@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Oct 4, 2019 at 4:57 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>     $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

>  arch/m68k/Kconfig.bus                  |  2 +-
>  arch/m68k/Kconfig.debug                | 16 ++++++++--------
>  arch/m68k/Kconfig.machine              |  8 ++++----

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
