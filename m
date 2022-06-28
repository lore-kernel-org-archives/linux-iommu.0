Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801C7C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 13:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF37841735;
	Tue, 28 Jun 2022 13:10:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF37841735
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kCf9o6/0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jfREVLixGf05; Tue, 28 Jun 2022 13:10:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C38741505;
	Tue, 28 Jun 2022 13:10:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C38741505
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3801CC0039;
	Tue, 28 Jun 2022 13:10:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0AABC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 13:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 953B582BE5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 13:10:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 953B582BE5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=kCf9o6/0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J7hsTrNujCI6 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:10:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E84CD82A4E
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E84CD82A4E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 13:10:05 +0000 (UTC)
Received: by mail-yb1-xb29.google.com with SMTP id q132so22081027ybg.10
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0ZW3XqarvTcGhZ4Peie0PakfFooFWkf6ipw6nAT5DK0=;
 b=kCf9o6/0aD5+Onn97DhZLKfxw23aiwSbWQ3wt8mFoCdH+LjvNVVhyHZrAjseX0NWrN
 zimXeTlzcsePfCsKfNUe2CcGIVa/wrTuQYf71uyvPNwYH5Toe8RyOGCqldn+XbJd+eXu
 Hf0DeQ66vCbWLYXux5M2YqXImKJiT37AMwrsS9i5deSkUrYmy22k7VDXkg3CoD9p5DRB
 Z5Mpogjkt5F719HhCMQYv6MEJuJR+ujHXe33gkTF33jPPsX+Eui0zRqLcqEJMHgL1FXw
 cjVcvfn72nIgSfSalkb/FiXX3YPX78N4BM8l8tTsT8dtjsfMK+aH+lkwQGW4Nt2h6hcn
 6p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0ZW3XqarvTcGhZ4Peie0PakfFooFWkf6ipw6nAT5DK0=;
 b=DIT+veQV1nuXDRlfN3n3o3zcd/bUDMsIyblqEtNhIKq+WBR8BHRz2aCEuUS1J+8iQF
 URJFynwyHYcAgPc41IBcP6nPkItmYP54+Pnk0rJkVXg0nnhJLUul5iKiK6jva6zj+r9J
 xftWgWAlmsrMCwubkmZmOpIWyDtZF75Uv8UOM9J0a9q5wIovMl2EXbeIyOyW+hz+LUSO
 fBLCdjOm/1O7LG7Ts/drlLbAjySEMuJYSw/FV1O9NQ8V4ZWUd+qUPZQn3rgSMP1aE9RZ
 +TOmHnCFrvMyEaBFtYHvblFp8GHXMD8n5hA2og8pvVR2UEWXdvqdiYxDZPD+gwHS2EIW
 qRVg==
X-Gm-Message-State: AJIora8gJBun/HGKhoxFGzR4qpb+/N8R2SUDYgx2jaqDfGCuTVi/cMji
 ndTQXAJqGqkps/iyi9J3MHfZabMsbvVgKGpNUN1xtw==
X-Google-Smtp-Source: AGRyM1tf6Oi2cTjL5Xen3Ry8mKIsaQdlmT4EjbmjDbOehmH4tttuvrwdwMm9BEXAu/FfRgr09oipji2FOAjmIeuskqo=
X-Received: by 2002:a25:cac5:0:b0:66d:2c32:8593 with SMTP id
 a188-20020a25cac5000000b0066d2c328593mr2891580ybg.626.1656421804675; Tue, 28
 Jun 2022 06:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-8-saravanak@google.com>
 <20220622074756.GA1647@pengutronix.de>
 <CACRpkdYe=u9Ozj_dtLVr6GSau8yS5H7LnBNNrQHki1CJ1zST0A@mail.gmail.com>
 <CAGETcx_qm7DWbNVTLfF9jTgGA8uH8oAQzbPcMDh4L6+5mdRFog@mail.gmail.com>
In-Reply-To: <CAGETcx_qm7DWbNVTLfF9jTgGA8uH8oAQzbPcMDh4L6+5mdRFog@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Jun 2022 15:09:53 +0200
Message-ID: <CACRpkdYkbVWayPEukyKcSQuzMuV=BmhBwBA6GuoNvb3HLWLNUQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] driver core: Set fw_devlink.strict=1 by default
To: Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Sascha Hauer <sha@pengutronix.de>, Kevin Hilman <khilman@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, kernel-team@android.com,
 Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel@pengutronix.de,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
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

On Wed, Jun 22, 2022 at 9:40 PM Saravana Kannan <saravanak@google.com> wrote:

> Actually, why isn't earlyconsole being used? That doesn't get blocked
> on anything and the main point of that is to have console working from
> really early on.

For Arm (arch/arm) there is a special low-level debug option call low-level
debug, which you find in e.g:
arch/arm/Kconfig.debug
arch/arm/kernel/debug.S

This debug facility can print to the UART fifo before even MMU is up, pretty
much from the first instruction the kernel executes.

The versatility of LL-debug means that developers do not use earlyconsole
much on Arm.

I don't know about arm64 though.

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
