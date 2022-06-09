Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A5ACCA473
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 11:45:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02B7160B9C;
	Thu,  9 Jun 2022 11:45:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x5dQbAKiCBEd; Thu,  9 Jun 2022 11:45:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF3A960B72;
	Thu,  9 Jun 2022 11:45:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9120AC0032;
	Thu,  9 Jun 2022 11:45:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EFE3C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 11:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC41660B8F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 11:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cqy4vgjKmq9B for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 11:45:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0679160B72
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 11:45:38 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id s6so37523012lfo.13
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jun 2022 04:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z3ypSb+XDrbeyHXO4y2Np7U53zPPEdC7B+zbSpknR0k=;
 b=OY/i7kxud0oo+BFCt+TUyi9H+g3C5k5yrf+GXzEjHjPnjtkGEK4seV9DkRk020ZUWz
 WKIH+f9T+Afyh0yOus92Sk0vZdrYShJ4ANs3mHE/+w0RKzy/cpBxO+5vSXpcs/6I/W1F
 VgAz/3Vc0Nn9QjNv2tmAAZMKO/Zx0Ief1thCMpUMys0hnSluwTEWS9QWq5+xu+Xs3xCj
 KJI2vfV/hzfKhedkmNIIP79nVy65JYBECsLTbLv14046cdq+juG+NEFNr00i7eve/JuS
 L/L653ZLeJUs2U8MFmzrO0Dn6Jw5uA4RYssB8Qz6MWalyz5dsMEsbsKnbJjRN9KmbwEF
 YCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z3ypSb+XDrbeyHXO4y2Np7U53zPPEdC7B+zbSpknR0k=;
 b=rR1doIgfZRYyzuTWUXznyZUMldTxjUuX01RTF3EsUMPm5zGqAFCLkiOcfbi7UsZLEE
 kNrMN6NGjs5BeiVf5G3WIuYaSHaw1TgibIoL7y5rNBZcfRAqoEojWsI1NyHConWZufnO
 f7N44z4f4hFXFa6nmbJHFxsbjXmGg+Ql0X50i4lBsdWujY2h8F7DqcAc0b/IivvbGo1l
 GQ7W2hMAv/07l1LoAccxFH1mkzFT5Q56tmkafZg4pyqBA1E4D8iodYCoe6Il5qbIG15W
 13+rQC75+/mqU3ZdFruo89ZPHnFzXYk7xcHJUdyU4x8v5d/IYPnxz8DK7FJZ5qsi3TfP
 i6sA==
X-Gm-Message-State: AOAM531x/A0W8f9CLl+KJ9pdp49MQ9Xt+evlm3x+q0n2EAdeIYg3srDM
 jMH+a2VoJlHPSody0gCgFthbSfZCX+bwp29ZUhCFEw==
X-Google-Smtp-Source: ABdhPJyH77X7NZCKlUAkh1b8rGns+ZTVzL2JJqtqHXE5Z9Yu2vwepFP1JhFxEiQXE3Fhj1dWwk3q+ErEVVRC0NDjZtA=
X-Received: by 2002:a05:6512:303:b0:479:1baf:7e5b with SMTP id
 t3-20020a056512030300b004791baf7e5bmr19877546lfp.184.1654775136919; Thu, 09
 Jun 2022 04:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com>
In-Reply-To: <20220601070707.3946847-2-saravanak@google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 9 Jun 2022 13:44:59 +0200
Message-ID: <CAPDyKFpZTmt71LgQ9vNE4_iRff-OBkDWkHrc7y9zQ7o_Z_UYFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
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

On Wed, 1 Jun 2022 at 09:07, Saravana Kannan <saravanak@google.com> wrote:
>
> Now that fw_devlink=on by default and fw_devlink supports
> "power-domains" property, the execution will never get to the point
> where driver_deferred_probe_check_state() is called before the supplier
> has probed successfully or before deferred probe timeout has expired.
>
> So, delete the call and replace it with -ENODEV.

With fw_devlink=on by default - does that mean that the parameter
can't be changed?

Or perhaps the point is that we don't want to go back, but rather drop
the fw_devlink parameter altogether when moving forward?

>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Just a minor nitpick below. Nevertheless, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 739e52cd4aba..3e86772d5fac 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                 mutex_unlock(&gpd_list_lock);
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
> -               return driver_deferred_probe_check_state(base_dev);

Adding a brief comment about why -EPROBE_DEFER doesn't make sense
here, would be nice.

> +               return -ENODEV;
>         }
>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> --
> 2.36.1.255.ge46751e96f-goog
>

Kind regards
Uffe
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
