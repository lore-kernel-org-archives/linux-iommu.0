Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4E8C388F7
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 13:33:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE060206B2
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 13:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmlAGRfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE060206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 241BC228D1;
	Tue, 10 Nov 2020 13:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Ao91DzTd-Ks; Tue, 10 Nov 2020 13:33:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8E33E228D5;
	Tue, 10 Nov 2020 13:33:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 762F1C088B;
	Tue, 10 Nov 2020 13:33:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5BC3C016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 13:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B13AD863D5
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 13:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gULst9uJWoo for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 13:33:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4375F863A6
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 13:33:47 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id j205so10149995lfj.6
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 05:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q+6VXi/5fY0aP8aAL5vEFMrlAfYUy6hH2SKWPsznW1Q=;
 b=FmlAGRfSk4J3zgXbJDv8yHH20lrNZWFBkHg/DnPlYXHe2VccCLgYFTG8bjdBptozIj
 C2SnnYxyrVFoEIY8U1UhC6ub3gwPf//MyHB4gfw2rbPTQhPCPbO5KO4f2s9/x01x5c2q
 d6E8PMeQIsrG5wuAilg4l2FHg93/R/9JGkgflAWK9Hl3OzEvAijLIUAx7ofhK+AaESb+
 1GmPNkrH2tMp7ciAAlxzkR08SQ+fhcGiiToI55gcDiBOR7/lsm7BVrnvEM5ycDQakWp1
 s0DF7ekcsMLZBvO0AbIver97jjPizf/gVWAnl+PQFCdABi/mw1+gmjWTI039J+xVWXTO
 gE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q+6VXi/5fY0aP8aAL5vEFMrlAfYUy6hH2SKWPsznW1Q=;
 b=bHDnZgts3dI0GEVL3OAhGU2C4DH6bTXuH5ge5k3YiROZoz2654jqVMoCqCVdxvpigU
 hTXu/HZaILbVSBnxBQO0+kuyqAL8OgoQuC0AsUQ57DPr9S1H+z8JjhRUNwEEXtTur6Fd
 2AL9Vh8Ggj4sLAio+TekjLl1FApGq2opoLC8zMZLjFp5kYh307uuuj4Ny1mxripj+wRX
 haDlvRPFLNpOcqRmU5sMZlWNjhX9oPEdONoCGoEd3bbldk9RUzvhUGBv2Pb2tVfRyOL3
 EyngfiSgQuwxIRrtWiU9xSyM2RKkkKGIiYa5RxsrVPN1CDvuY0/MB2SDijS0O5QTimAV
 Hm1Q==
X-Gm-Message-State: AOAM533OgbEANeSX5Y/2WOQIijkwXOR3MSOqtpJDByBDHoF+vq1ldkVr
 1UUydAebMB5X/XP6LOvWgd/nmCvX2tSnM9Kll+9K+g==
X-Google-Smtp-Source: ABdhPJwuAaqcMMw0q1QKD4oDxOC2Zd/QBV3ne5UQWRpT2XN+r51MyMsPZhWlpVqWlaIpmZiQGEvtoy7cfNG7jCXEoB0=
X-Received: by 2002:a19:f00b:: with SMTP id p11mr7200799lfc.585.1605015225371; 
 Tue, 10 Nov 2020 05:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20201106042710.55979-1-john.stultz@linaro.org>
In-Reply-To: <20201106042710.55979-1-john.stultz@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Nov 2020 14:33:34 +0100
Message-ID: <CACRpkdY2oH47Om1Xa=ku4csU-YHBB8XFrsemgfOvh0XCTog-aQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] pinctrl: qcom: Kconfig: Rework PINCTRL_MSM to be a
 depenency rather then a selected config
To: John Stultz <john.stultz@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, Todd Kjos <tkjos@google.com>
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

On Fri, Nov 6, 2020 at 5:27 AM John Stultz <john.stultz@linaro.org> wrote:

> This patch reworks PINCTRL_MSM to be a visible option, and
> instead of having the various SoC specific drivers select
> PINCTRL_MSM, this switches those configs to depend on
> PINCTRL_MSM.
>
> This is useful, as it will be needed in order to cleanly support
> having the qcom-scm driver, which pinctrl-msm calls into,
> configured as a module. Without this change, we would eventually
> have to add dependency lines to every config that selects
> PINCTRL_MSM, and that would becomes a maintenance headache.
>
> We also add PINCTRL_MSM to the arm64 defconfig to avoid
> surprises as otherwise PINCTRL_MSM/IPQ* options previously
> enabled, will be off.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Patch applied!

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
