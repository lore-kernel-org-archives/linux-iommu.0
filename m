Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A5C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 17:11:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40E82063F
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 17:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z6QX77ME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40E82063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CCC1611B0;
	Thu, 13 Jun 2019 17:11:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5EC6E10B5
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 17:11:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0483C775
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 17:11:23 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
	[209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A2CB421473
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560445883;
	bh=zXxn0DZZzDqw7OoZuqRBZa3+NRFbt9j4/8PtEklx0ks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=z6QX77MEL+lVTwICJFn4lx/RYfLqUuktVzenVzi/xypIH3UcvaG4r71l7+wQ0UtEQ
	77w8cr+DCRXNO+kGefwibUjePyZcggjFxjb/OyjvBNs0qX/ZCCaagbGAGepZh82Fb8
	78Fi+KGZAlC2CadDDN6Mv/Pcqz8geGb2RALiMIUU=
Received: by mail-qt1-f172.google.com with SMTP id x2so22520809qtr.0
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 10:11:23 -0700 (PDT)
X-Gm-Message-State: APjAAAXpXkvfBcZdS05kVlyrdHYBRKKP4Q+VkL5+m6tPrhpNxWzlc89E
	7kV2NKVfs7Q5rAhmzQZkSAJ5H2r0VldUZdKPWA==
X-Google-Smtp-Source: APXvYqxPx+RzHImrfYff7rhrQ4nBX3av55NJRHWJ45TzZYNcBbf30JPqZBJ3v2N/ISXb3erZEUw1S75dSeXuFTMiFz8=
X-Received: by 2002:aed:3b33:: with SMTP id p48mr69738055qte.143.1560445882940;
	Thu, 13 Jun 2019 10:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190613170011.9647-1-thierry.reding@gmail.com>
In-Reply-To: <20190613170011.9647-1-thierry.reding@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 13 Jun 2019 11:11:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKiFzED-YaBFQ-PBnBBbDaC5yeri+pLG-PX=-wpaFfb=A@mail.gmail.com>
Message-ID: <CAL_JsqKiFzED-YaBFQ-PBnBBbDaC5yeri+pLG-PX=-wpaFfb=A@mail.gmail.com>
Subject: Re: [PATCH v2] driver: core: Allow subsystems to continue deferring
	probe
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
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

On Thu, Jun 13, 2019 at 11:00 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Some subsystems, such as pinctrl, allow continuing to defer probe
> indefinitely. This is useful for devices that depend on resources
> provided by devices that are only probed after the init stage.
>
> One example of this can be seen on Tegra, where the DPAUX hardware
> contains pinmuxing controls for pins that it shares with an I2C
> controller. The I2C controller is typically used for communication
> with a monitor over HDMI (DDC). However, other instances of the I2C
> controller are used to access system critical components, such as a
> PMIC. The I2C controller driver will therefore usually be a builtin
> driver, whereas the DPAUX driver is part of the display driver that
> is loaded from a module to avoid bloating the kernel image with all
> of the DRM/KMS subsystem.
>
> In this particular case the pins used by this I2C/DDC controller
> become accessible very late in the boot process. However, since the
> controller is only used in conjunction with display, that's not an
> issue.
>
> Unfortunately the driver core currently outputs a warning message
> when a device fails to get the pinctrl before the end of the init
> stage. That can be confusing for the user because it may sound like
> an unwanted error occurred, whereas it's really an expected and
> harmless situation.
>
> In order to eliminate this warning, this patch allows callers of the
> driver_deferred_probe_check_state() helper to specify that they want
> to continue deferring probe, regardless of whether we're past the
> init stage or not. All of the callers of that function are updated
> for the new signature, but only the pinctrl subsystem passes a true
> value in the new persist parameter if appropriate.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - pass persist flag via flags parameter to make the function call easier
>   to understand
>
>  drivers/base/dd.c            | 19 ++++++++++++++-----
>  drivers/base/power/domain.c  |  2 +-
>  drivers/iommu/of_iommu.c     |  2 +-
>  drivers/pinctrl/devicetree.c |  9 +++++----
>  include/linux/device.h       | 18 +++++++++++++++++-
>  5 files changed, 38 insertions(+), 12 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
