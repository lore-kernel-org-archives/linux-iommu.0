Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12494C636CA
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 17:24:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB96C61263
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 17:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB96C61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 762308239A;
	Wed, 21 Jul 2021 17:24:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id coq2At_1AVW9; Wed, 21 Jul 2021 17:24:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 671878183D;
	Wed, 21 Jul 2021 17:24:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40637C001A;
	Wed, 21 Jul 2021 17:24:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CB55C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 17:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A6D5608AE
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 17:24:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lnQuYMKZVfe5 for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 17:24:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5CE4607DF
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 17:24:14 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id y7so3987193ljm.1
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/geap+n06qADP8bUUkTvJg1+GbqYMe8lt6RpcUMxI18=;
 b=Hdt2KFh5xvg+QlcJKKcwzWITxdiB3zzWrNsSCi3yAmz5xkPmKzqnF9Vf88sIJjyPDe
 Ja3BG8LkZkNqMVYCmyfVmPjbmoWDHNC6HgfHZY9miAffsE8USRj45txPlXOHFqcKntP3
 JjG7JeL0LVCQRQFaqy6JOIaGkcz2XECZ3STKTmPSSK0EKewRHEkllDmMhuIPT0uEdT52
 UwELbIZsRCf9PI/reTR9o+ZG02ZzwTKnr65Pk5ZvQwTvMOL5yV5Q6QklhTuJftyhkSuM
 MNeB8hArE2/Uhg1XW/oqWLr9/271h+/O24cYDoBKJOPLkn+OgMrJxb73TsB4kCB0PkhA
 PB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/geap+n06qADP8bUUkTvJg1+GbqYMe8lt6RpcUMxI18=;
 b=b1bm23XwinlnDT5Fabxgdq6OFJdT81Un9enYwXXF49nLLEsh1c4m2NFFsfRvMOhRnA
 NH87Aak/r8KpliQCw2hGu99YfzE75bKS39pzE8oVonyngBGw9PmtAFS2Yvw7q/H1t3Bs
 q3+c46oAx/CxE9DPXW0pykxDejerhxFDBzaZaT5BqRWCAm/7S/jH/teTguiNADhgJlRM
 Ibih+2tuYJi87Js3ZDB6wAGLV3PqdIgkciHqYRTq7kfQj/Ajwu6+kYbwXfNHiJLJgSE7
 Ed5oKu6ZgnJ737qmPJA5faIGSp733bbs+Vn0ovV8EaILtoh4CBkXFOFybmv0nzkRCLIx
 iovA==
X-Gm-Message-State: AOAM533RWyQHZLGrOuFtfZC4gYaL2m6eYQtA5/AN8MO+RQxWWRD/AQwQ
 EhzDSjZI4ZXbTVqWga9gNRrXvI4GBYFvTcI5RaKmPg==
X-Google-Smtp-Source: ABdhPJws9ZMve7X1DBmsQqOrLOBnsRl56RypIYvLQcQu3Pn14yEsYIeMebFKy7cEHM6l5RgopE5mNsBgOpWsXYjmmQY=
X-Received: by 2002:a2e:a54b:: with SMTP id e11mr24488402ljn.503.1626888252628; 
 Wed, 21 Jul 2021 10:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPgK50dmV7Z69WsL@kroah.com>
In-Reply-To: <YPgK50dmV7Z69WsL@kroah.com>
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 21 Jul 2021 10:24:01 -0700
Message-ID: <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Saravana Kannan <saravanak@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
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

On Wed, Jul 21, 2021 at 4:54 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> > Allow the qcom_scm driver to be loadable as a permenent module.
>
> This feels like a regression, it should be allowed to be a module.

I'm sorry, I'm not sure I'm following you, Greg.  This patch is trying
to enable the driver to be able to be loaded as a module.

> > This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> > ensure that drivers that call into the qcom_scm driver are
> > also built as modules. While not ideal in some cases its the
> > only safe way I can find to avoid build errors without having
> > those drivers select QCOM_SCM and have to force it on (as
> > QCOM_SCM=n can be valid for those drivers).
> >
> > Reviving this now that Saravana's fw_devlink defaults to on,
> > which should avoid loading troubles seen before.
>
> fw_devlink was supposed to resolve these issues and _allow_ code to be
> built as modules and not forced to be built into the kernel.

Right. I'm re-submitting this patch to enable a driver to work as a
module, because earlier attempts to submit it ran into boot trouble
because fw_devlink wasn't yet enabled.

I worry something in my description made it seem otherwise, so let me
know how you read it and I'll try to avoid such confusion in the
future.

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
