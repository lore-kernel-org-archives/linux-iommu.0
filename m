Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA75C4741F
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 14:17:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B292B2071A
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 14:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LCaGszIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B292B2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4E8648643F;
	Thu,  5 Nov 2020 14:17:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hd3vQByMOCdL; Thu,  5 Nov 2020 14:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E3E585B48;
	Thu,  5 Nov 2020 14:17:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64742C0893;
	Thu,  5 Nov 2020 14:17:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACF8AC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8FDFD8630A
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:17:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nV7jb97V8b7k for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 14:17:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EB48085B48
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:17:21 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id d24so1724107ljg.10
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 06:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ckFCYgz4p7fV/Rv1ULwzhaLsz6xFc6pP5TZ8DCIkxxA=;
 b=LCaGszICBBAWv70tAKMjDm5ZOV0L4wNQX13Eecy0BkI6e1/k8zmE5W8HTwBm/ZX8M+
 v49/+xKIETMrC1vQV6v0+Ci5Wnex0X5SRy8K3waOOb0ohDg3IyZwFelFWOLwRfKHg5td
 ZSy0Kqof+2A8UXB/Fvm3dnyjDmCJ+LrOI0xpeedQqhf6mIQv0AL29Q2YnYo0tU3Kr1ds
 ipoC5YUtTwXbS1xY2KBYh5WWQvT/7XDJYrgV2pDqkW6yrm6Mf/yiuhF8zhHxizc7M/lP
 biay1WeEs45NggRz/rO2TZQ2zdbe4aW188+ciVgWWFrj/n5ldTFATiVGGa0nI/+Dr9w0
 VV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ckFCYgz4p7fV/Rv1ULwzhaLsz6xFc6pP5TZ8DCIkxxA=;
 b=LuIX7zzRCh4LqwlSUtsQJTGEKEmJrqyH2bzAn34bww/0zWm+SWu05R1rKUE+Rdu8rW
 MnNzL65/fBkrxCDGnAJPJ24m6ON0PQ+Z/lD2cP+f1xZC7cjCIx9tZrm0mc/yXvTUfXnK
 yOjh16pFvFtnSczYD8VUizvPYZtDUzLh4Dp79KHtxvbFdavY2pxzgI1pXUM0el2uDKL9
 ZfowqCLF8PogepfMFgZN6pNRWGjg3tAVpPEnKE4RN6JnqW77+BIzO1KtYdQgtPdM5lHg
 hCQXbEHOHW9uvP9IPwowSm1DW0/0pRVpVFJY6XloEYGMC+UdH0mttTOAFtkEUwGARITX
 20Sw==
X-Gm-Message-State: AOAM532Wm4vMA8plwSdkmROxq4KJPeO/2zOe2MVsbzEGe1vQ+THq+qGe
 x2Cg5pb302dbwz0bW7Q9inDmopFidR+prloRrIIUWg==
X-Google-Smtp-Source: ABdhPJwbKFPhoBPzVE12zAliR3cQNeWctJKtHRHeIQIXzMArYYL00YURYRptpkIiDgn3MbyelUxvyacBOiB03zwHAW4=
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr1049377ljg.286.1604585840115; 
 Thu, 05 Nov 2020 06:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20201031003845.41137-1-john.stultz@linaro.org>
In-Reply-To: <20201031003845.41137-1-john.stultz@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Nov 2020 15:17:09 +0100
Message-ID: <CACRpkda1MV2=0MOMk3t4mr1RczdvfeiNTdbYXX6Jig+6p3TABA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] pinctrl: qcom: Allow pinctrl-msm code to be
 loadable as a module
To: John Stultz <john.stultz@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
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

On Sat, Oct 31, 2020 at 1:38 AM John Stultz <john.stultz@linaro.org> wrote:

> Tweaks to allow pinctrl-msm code to be loadable as a module.
>
> This is needed in order to support having the qcom-scm driver,
> which pinctrl-msm calls into, configured as a module.
>
> This requires that we tweak Kconfigs selecting PINCTRL_MSM to
> also depend on QCOM_SCM || QCOM_SCM=n so that we match the
> module setting of QCOM_SCM.
>
> Unlike the previous revision of this patch:
>   https://lore.kernel.org/lkml/20200625001039.56174-5-john.stultz@linaro.org/
> this version reworks PINCTRL_MSM to be a visible option and
> instead of having the various SoC specific drivers select
> PINCTRL_MSM, this switches those configs to depend on
> PINCTRL_MSM. This avoids adding the oddish looking:
>   "depend on QCOM_SCM || QCOM_SCM=n"
> to every SoC specific driver, as that becomes a maintenance
> headache.
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
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Module description and whitespace fixes suggested by Bjorn
> * Added QCOM_SCM || QCOM_SCM=n bits on Kconfigs selecting
>   PINCTRL_MSM. Reported by both Todd and Bjorn.
> v3:
> * Make sure the QCOM_SCM || QCOM_SCM=n trick is commented
> v4:
> * Rework "select PINCTRL_MSM" to "depends on PINCTRL_MSM"
>   to consolidate the QCOM_SCM dependency.
> v5:
> * Add PINCTRL_MSM to arm64 defconfig

Bjorn can you have a look at this series?

BTW John  I'm afraid I just merged a new QCOM subdriver so we might
need to respin this to cover all.

It's an important patch so I'll help out in rebasing it if the only problem is
that my tree is moving under your feet.

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
