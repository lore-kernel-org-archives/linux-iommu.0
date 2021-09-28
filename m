Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257C2C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 07:09:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17A2611F0
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 07:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D17A2611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3D1380F57;
	Tue, 28 Sep 2021 07:09:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GvQ2ws_AZvhj; Tue, 28 Sep 2021 07:09:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 95C4780D60;
	Tue, 28 Sep 2021 07:09:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57661C0011;
	Tue, 28 Sep 2021 07:09:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F5A6C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 07:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C53E402A2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 07:09:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2u62dh0E5-FE for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 07:09:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A1C340229
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 07:09:02 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE86461206
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 07:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632812941;
 bh=UL3HabPZo5poDvomfSgnMsUOXswOov4XaFV+Mhe/hPM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=peKRlRdshfCDM0WKkr1XAFZ5JA0DCpMVcB0qXm9NxkojuV08GN8y4VUWHQuL7c9ZY
 6sWn8yb6HkL33eo7lHoIpmV+16YmcV5URUsbb5ROqMLP/B2oYGO9uzYlQKzwmYIte9
 JjCrZb+8LY02VUAqdkytXO6BXCrNT6hTbVe6tjxqsCJOIcI5lKKEAFEQw+MtMj1kd9
 7TD06BzKQnK5KlREkvXV6RcZ4dYFoBhJ+Sg8NqJMxbI95VJng6XTqHy4AQImO9S4Kf
 gEL4X76N6d2P14bUwruG/Y5pIfa3QIReUn3JXZEw80+7KD8/DNNMDPScLhF7pMaSHH
 +Epm+raz+IWiQ==
Received: by mail-wm1-f47.google.com with SMTP id
 205-20020a1c01d6000000b0030cd17ffcf8so1253479wmb.3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 00:09:01 -0700 (PDT)
X-Gm-Message-State: AOAM531v5uG1eEjMdoDoEZ2SCHO06ixPxcnh4wYptPSX4BHdw2GQMDSY
 8C3/nwrsr5h7nZUck7yNLzhOJtt/AcIY49mPDMU=
X-Google-Smtp-Source: ABdhPJy7UdwG5CMt3vBprQtkQXDtnziSdWAdhBrxF2DYHzwuiJfWIuOu4DEBfNVS3j3HCobxe7h4te4Xc8Y+nnvjU1E=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr3161995wmc.98.1632812940328; 
 Tue, 28 Sep 2021 00:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210927152412.2900928-1-arnd@kernel.org>
 <87k0j1qj0i.fsf@codeaurora.org>
In-Reply-To: <87k0j1qj0i.fsf@codeaurora.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 28 Sep 2021 09:08:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2FiMLZK7W9L9XD5h=3yS8QJ6iMr0pXHtCNrpctZG4FhQ@mail.gmail.com>
Message-ID: <CAK8P3a2FiMLZK7W9L9XD5h=3yS8QJ6iMr0pXHtCNrpctZG4FhQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] qcom_scm: hide Kconfig symbol
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Airlie <airlied@linux.ie>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, ath10k@lists.infradead.org,
 Will Deacon <will@kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andy Gross <agross@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 linux-sunxi@lists.linux.dev,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Paul <sean@poorly.run>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Alex Elder <elder@kernel.org>, Networking <netdev@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
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

On Tue, Sep 28, 2021 at 9:05 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
> > From: Arnd Bergmann <arnd@arndb.de>
> I assume I can continue to build test ATH10K_SNOC with x86 as before?
> That's important for me. If yes, then:
>
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Yes, the difference is that this will then also build the qcom_scm module, but
that should not cause any problems after the other changes in this patch.

      Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
