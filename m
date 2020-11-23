Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61117C2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 12:35:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C066420888
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 12:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ucPq/hty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C066420888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3804A8676A;
	Mon, 23 Nov 2020 12:35:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YBYLsgOT795m; Mon, 23 Nov 2020 12:35:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 11DED86767;
	Mon, 23 Nov 2020 12:35:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDC65C163C;
	Mon, 23 Nov 2020 12:35:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94584C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 12:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 528DB204BC
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 12:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gn065frYXenY for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 12:35:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 83EEA204A4
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 12:35:27 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id u18so23469030lfd.9
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 04:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bIWsoLneay5Kl8XDCK10cRcYyCYPRUIRK+zSmVlUvos=;
 b=ucPq/htyydn+9nClVGlZXYjYlkUMJiVSI6//s3K2lB127+Dttlcf30ubg2H0y6FtTe
 0t0/uAcNyjks0BNC+Nc9WQM9twGuyQgzeJDmHOJCcuG+BPEgo4hZphWquRikKVGCaEDH
 fZ9J0t0/u2VfMvu3ThtvvLpxoqAXFYzigtfxsm/UFO7lW8Qd2SlHVODvvjva2lUIv9Wh
 C56U3YkqIoZLIrq/Q6mXCqbIVVZjrdUbXXTgF57i/vdQhFyGr1ys40XzGUOvAyMl6YSB
 r9W3JHWAvhB32/0yGKToSVztgYnBmSn1zD2LDPjUKQH80SPA+8oNJEecXJ/c2Cat6vX+
 DDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bIWsoLneay5Kl8XDCK10cRcYyCYPRUIRK+zSmVlUvos=;
 b=CAz8YUeCkLLkpgI64oNuDTCE0NkDa/tsPA4WvjN1DNixNkKZVAcx0L8P90aHhzoCTt
 bg6Yxtza8xgUyIgb/DX7Fuy64Ari9dKB1WUDXVwdAasCtOYLAcHLyVK1MmaMfLkCEyWU
 hjKgiUGLEbrZazQx82HObjZ+EgtMTxYPb0+XxGX1yrke0jdeE49wNTokArIpj0627y57
 jRS9JS1QSJEAYFM8G+Xah2siShb6SkvZx9AFAYbGYKWZMK/m6BYOZ4DpdYDQd30a6BOB
 AG0JIuS4g9KXnakoUxc31fao1aVfSqv91e656w7M4FmxkE8NzWLL01vKljzTrgcPsiXi
 e89A==
X-Gm-Message-State: AOAM530fVVyZFfVW3Y5DW5O64DMUShDEEkU9kKu3yHb58wbkXQfRP+to
 Tk4Xhm0f00y/iA/XQDGGz+wRf9kpN7DL3MwrkRbLyw==
X-Google-Smtp-Source: ABdhPJyKTHrZB4S6+zJWCf7UD8YLgth7EXVZo1EcgOOYpBLPQaWWmzkLYbQnaZmrG7aYqRK3IZDf1ocx2qEm2ucjD18=
X-Received: by 2002:a19:5f11:: with SMTP id t17mr1536573lfb.572.1606134925520; 
 Mon, 23 Nov 2020 04:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20201106042710.55979-1-john.stultz@linaro.org>
 <20201106042710.55979-3-john.stultz@linaro.org>
 <20201116155936.GE2224373@ulmo>
 <20201116163603.GA30507@willie-the-truck>
In-Reply-To: <20201116163603.GA30507@willie-the-truck>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Nov 2020 13:35:14 +0100
Message-ID: <CACRpkdZ9P0vG-deWmK8A-zRZbndq1gz_oaK_b128bu4NfUB+Nw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: Will Deacon <will@kernel.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jon Hunter <jonathanh@nvidia.com>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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

On Mon, Nov 16, 2020 at 5:36 PM Will Deacon <will@kernel.org> wrote:

> Linus -- please can you drop this one (patch 3/3) for now, given that it's
> causing problems?

Reverted now, sorry for missing to do this earlier.

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
