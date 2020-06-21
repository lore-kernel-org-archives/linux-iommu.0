Return-Path: <SRS0=X07A=AC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EB9C433E0
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 06:10:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF13A207E8
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 06:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEXtwFpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF13A207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A1DC6880A7;
	Sun, 21 Jun 2020 06:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B5Juguw6XAiP; Sun, 21 Jun 2020 06:10:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC63387A9D;
	Sun, 21 Jun 2020 06:10:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B678FC0891;
	Sun, 21 Jun 2020 06:10:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C069C016F
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 06:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 43CA02601E
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 06:10:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XB4o+HhPOY8S for <iommu@lists.linux-foundation.org>;
 Sun, 21 Jun 2020 06:10:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 37DE925D52
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 06:10:27 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id p82so1843864oif.1
 for <iommu@lists.linux-foundation.org>; Sat, 20 Jun 2020 23:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=E37Y5fbYX2B/AUZ69TRQLOn9ZrdWJ1PDTbytHbYw12I=;
 b=bEXtwFplRNji+ZAlc70WTzC2kmlYpyz9O7mWigm5rajr5DgliPr3sad6SDrRGM7Kxf
 AwS4rnsGWi0suv+nLr/dTLjpe/5BBQWQ78Y/MLvC6fIzRiiGWDyDvxlIwAkT6yhVwCVd
 L5Nqmm9rZgD4hg6kOnjyoD90IV4D0fRF8b6QhEkYL4UND9cEbgOAMAO0KGNbHg/xJxzE
 G4QbwMr2XpUzZ00E4P0OlQSphxTK+8k6P8gtvtTANIoMPfCSKI8Lv2oSt70mXr3kVJnX
 mRNNXqZ5KQsa4qUoQjbNJsw5b0Ou9b7vS1uP2/0cXZscaYixyou2r2uvCkhkOuP7Lkp+
 jjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E37Y5fbYX2B/AUZ69TRQLOn9ZrdWJ1PDTbytHbYw12I=;
 b=bmMQCkec9rZ6XRqAcyrKSI8gTGQLkyTbcK86zrsu3mUoQ/EMLPaSOjHYjq55qT635N
 5IWd73yRU7MycG0smYWCuP06KNofn2A+T3yDrFD84j5aWCeFHNdLsHBLfYgiNaUYUrOW
 s0WJQ3bsqLvCdq+jpJX7PVRNYKoLXv3ye4nw38KzbVK+dauo2QBy7btdDdWy4TzaHhTW
 jYe+G5XrQ6jp1YhX0qNq0rtznj7FDDbguEc2dUdHChrkF1PX8BIWiGWcngUW2+zp9jTc
 n7c+9hMEiW23xi09MmkUG747c8/9mNMVjvaGsl9n/cVygv5DhUoy4xvvvw15q8jCRjX+
 0YKA==
X-Gm-Message-State: AOAM531+pNwDhMx1+DeuS4ZaOFC0eNt2VA5UsFTpk5yiC3VcjSU8vRsl
 MVOQLMg4O0fsG2K1nacU7ButTwE1B60=
X-Google-Smtp-Source: ABdhPJxHRHspjuIwXRf0s9ZHcLtbwGIglVcsxqFPwAZTEDfrkST5fk9GgmGyQ7so94acwcjrzTu6RA==
X-Received: by 2002:a17:90a:6ace:: with SMTP id
 b14mr12034953pjm.13.1592719423730; 
 Sat, 20 Jun 2020 23:03:43 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id 77sm10459560pfx.172.2020.06.20.23.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 23:03:42 -0700 (PDT)
Date: Sat, 20 Jun 2020 23:00:55 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC][PATCH 4/5] pinctrl: qcom: Allow pinctrl-msm code to be
 loadable as a module
Message-ID: <20200621060055.GA2421@builder.lan>
References: <20200616061338.109499-1-john.stultz@linaro.org>
 <20200616061338.109499-5-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200616061338.109499-5-john.stultz@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Saravana Kannan <saravanak@google.com>,
 Marc Zyngier <maz@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm@vger.kernel.org, Todd Kjos <tkjos@google.com>
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

On Mon 15 Jun 23:13 PDT 2020, John Stultz wrote:

> Tweaks to allow pinctrl-msm code to be loadable as a module.
> This is needed in order to support having the qcom-scm driver,
> which pinctrl-msm calls into, configured as a module.
> 

This means that we need a "depends on QCOM_SCM || QCOM_SCM=n" on all
entries in the Kconfig that selects PINCTRL_MSM, or switch PINCTRL_MSM
to be user selectable and make all the others depend on it.

> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/pinctrl/qcom/Kconfig       | 2 +-
>  drivers/pinctrl/qcom/pinctrl-msm.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index ff1ee159dca2..5a7e1bc621e6 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -2,7 +2,7 @@
>  if (ARCH_QCOM || COMPILE_TEST)
>  
>  config PINCTRL_MSM
> -	bool
> +	tristate
>  	select PINMUX
>  	select PINCONF
>  	select GENERIC_PINCONF
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 83b7d64bc4c1..54a226f682e9 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1355,3 +1355,6 @@ int msm_pinctrl_remove(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL(msm_pinctrl_remove);
>  
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. pinctrl-msm driver");

It's the "Qualcomm Technologies, Inc. TLMM driver"

> +MODULE_LICENSE("GPL v2");
> +

Please don't retain my empty line at the end of this file :)

Regards,
Bjorn

> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
