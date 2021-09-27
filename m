Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04171C433FE
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 20:16:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FD0610FC
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 20:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5FD0610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8323080F94;
	Mon, 27 Sep 2021 20:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7mDpxIuGZq2V; Mon, 27 Sep 2021 20:16:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 78F7E80F8B;
	Mon, 27 Sep 2021 20:16:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32871C001C;
	Mon, 27 Sep 2021 20:16:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B51F3C000F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 20:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7C636069A
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 20:16:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CEJ_DlDii-GV for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 20:16:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB43760641
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 20:16:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49670611CE
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632773763;
 bh=Lb3LIgfAEjVXdf1vE2V7OoMMbogeWMravjEabJ1Nxyg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=aoqynUkGyB6ZPUI0PZbhRVWrRQEh4dUFl+HnGRbJEjz36swl07OI+waO5juXrxZEL
 jHlAKLJtp7vLEn53dGPq9ybdvqoV7skp3bnJ2v0dt7b3LCLaWszZoJwfgXGV5CewIZ
 EeT9Puax/p5vO3xFfjNQpP/s5z+vV6IucH/tDVc9OrhV9apJ4xfqmWfbZVQ6mT6zds
 T7V/1iyHvtmaHFbCozBGLs87R9buQKkqhGe1GFJbwuhVxRAw/14pw6aQABaZ9IXQ/3
 OdqLZFHV5ZJBQxWkAwNJ0thZGMxGk74lNv+sDueBnQKqvqp7vbKRWok7c77AtHcBAs
 PL2/kpsfVk1jA==
Received: by mail-wr1-f52.google.com with SMTP id k7so2114608wrd.13
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 13:16:03 -0700 (PDT)
X-Gm-Message-State: AOAM533y9WRELOa8+6ZfZUvjeeRYH+Z535wREbzhGTupGxTnCI/y2PRA
 tyfuxMWZkA5nuVHsJuMSdwPpxQ/Q1l5Oi+k5IEY=
X-Google-Smtp-Source: ABdhPJxhSUG+xfsMcnYBJG/aU9zQ/jW83Rbf6e2ezlqzSM1qdDuC1ur8sa8pPTTU3lbMghJJfkyUaLecI/p3sCcMSis=
X-Received: by 2002:a5d:6cb4:: with SMTP id a20mr1431020wra.428.1632773761805; 
 Mon, 27 Sep 2021 13:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210927152412.2900928-1-arnd@kernel.org>
 <YVIg9CxJGaJr1vpp@ripper>
In-Reply-To: <YVIg9CxJGaJr1vpp@ripper>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 27 Sep 2021 22:15:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1fEuFsQVY9b1oGdTOHzr8pu9wvrSBCMn2iOvgWqtHNnA@mail.gmail.com>
Message-ID: <CAK8P3a1fEuFsQVY9b1oGdTOHzr8pu9wvrSBCMn2iOvgWqtHNnA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] qcom_scm: hide Kconfig symbol
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Airlie <airlied@linux.ie>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, ath10k@lists.infradead.org,
 Will Deacon <will@kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andy Gross <agross@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jakub Kicinski <kuba@kernel.org>, linux-sunxi@lists.linux.dev,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Paul <sean@poorly.run>,
 Kalle Valo <kvalo@codeaurora.org>, Alex Elder <elder@kernel.org>,
 Networking <netdev@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sudeep Holla <sudeep.holla@arm.com>,
 freedreno <freedreno@lists.freedesktop.org>,
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

On Mon, Sep 27, 2021 at 9:52 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Mon 27 Sep 08:22 PDT 2021, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> >  - To avoid a circular dependency chain involving RESET_CONTROLLER
> >    and PINCTRL_SUNXI, change the 'depends on RESET_CONTROLLER' in
> >    the latter one to 'select'.
>
> Can you please help me understand why this is part of the same patch?

This can be done as a preparatory patch if we decide to do it this way,
for the review it seemed better to spell out that this is required.

I still hope that we can avoid adding another 'select RESET_CONTROLLER'
if someone can figure out what to do instead.

The problem here is that QCOM_SCM selects RESET_CONTROLLER,
and turning that into 'depends on' would in turn mean that any driver that
wants to select QCOM_SCM would have to have the same RESET_CONTROLLER
dependency.

An easier option might be to find a way to build QCOM_SCM without
RESET_CONTROLLER for compile testing purposes. I don't know
what would break from that.

     Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
