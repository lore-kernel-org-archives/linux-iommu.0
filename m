Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2BBC433DF
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 06:09:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E199C20720
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 06:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J07Y2gm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E199C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 99B79203F9;
	Fri, 10 Jul 2020 06:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fu5rbfERxD60; Fri, 10 Jul 2020 06:09:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DF7502051E;
	Fri, 10 Jul 2020 06:09:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4D5BC0865;
	Fri, 10 Jul 2020 06:09:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B3A5C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 06:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 19FF589B82
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 06:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nC+jeQPadKcE for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 06:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 660D089B71
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 06:09:05 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id r8so3923494oij.5
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 23:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:in-reply-to:references
 :subject:from:cc:to:date:message-id:user-agent;
 bh=Oyd2oGqBVPyTAZ6JKFzEpbSr77ywHRgUekUG2FwE1cs=;
 b=J07Y2gm5zuILWzAzBMOo7yDMDUtUMb/Y8Nizn3WaDwf8021z99+kciMF7G3G6daKCL
 QhNbumaJhrt2UGJ3VPwE3FtUWphcnRsOd3oZNeAYOehVVdmkHlDJSCj3OFbCqLsmlxlh
 ruRX6eK6e1o0KvdHMX7zpNYqp0/xMh0BAPcbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding
 :in-reply-to:references:subject:from:cc:to:date:message-id
 :user-agent;
 bh=Oyd2oGqBVPyTAZ6JKFzEpbSr77ywHRgUekUG2FwE1cs=;
 b=kqkip3wjGIdgnEC8sMH/45RwQzedpZ+rHfQ4L8DNpKIjNUtupKku2bJ3hU2ILO1gRc
 qwgbu40CiLKeuaa0wSL56KWQGzCP2n951Kj26ERKRsgeO9mZUe7lWbuebLZqOsJZvoUq
 qPxhxzp8oi4v+ECMjHoRLNtTHBqQ9sSBlKFImnYo9zrX0He0Zatvql8/KleAZrB296Dw
 syLwgERi+LG4QanM8BmQCkITjfC+APPpb9MUyxtYhHXD/qwGk4mFddvEyJMr2hNItJwG
 HG5V3sJvqnizcAJtdteAsv7I2W+1nAaL7u0x58jpfiYcJiV7S+aKBHDovEBofMDoCfox
 yJUQ==
X-Gm-Message-State: AOAM532jwzo2mHW1SEYDT8ETWTULwfnrZikcc8BGBBpN8BltXcZHJetI
 P9LMM2hU6GAsxjZ/EoHJa+1zlvRfkqA=
X-Google-Smtp-Source: ABdhPJxQuO02QwzrJ7yQ4iqF18cqHc9AyeYIrNPWmubHIZDKuPvIBSEE6MzrekewNPVhTy6i4w1egg==
X-Received: by 2002:a17:90a:2749:: with SMTP id
 o67mr3989699pje.183.1594360972481; 
 Thu, 09 Jul 2020 23:02:52 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
 by smtp.gmail.com with ESMTPSA id h194sm4438382pfe.201.2020.07.09.23.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 23:02:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87wo3setn8.wl-maz@kernel.org>
References: <20200625001039.56174-1-john.stultz@linaro.org>
 <20200625001039.56174-4-john.stultz@linaro.org>
 <159315737502.62212.16093934831673347066@swboyd.mtv.corp.google.com>
 <CALAqxLVNGar8g+FvHaVHN_e-MOZZ+=ZPmDt_GKKSC8AS-wLFGg@mail.gmail.com>
 <87wo3setn8.wl-maz@kernel.org>
Subject: Re: [PATCH v2 3/5] irqchip: Allow QCOM_PDC to be loadable as a
 permanent module
From: Stephen Boyd <swboyd@chromium.org>
To: John Stultz <john.stultz@linaro.org>, Marc Zyngier <maz@kernel.org>
Date: Thu, 09 Jul 2020 23:02:50 -0700
Message-ID: <159436097057.1987609.13993891118929459851@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
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

Quoting Marc Zyngier (2020-06-27 02:37:47)
> On Sat, 27 Jun 2020 02:34:25 +0100,
> John Stultz <john.stultz@linaro.org> wrote:
> > 
> > On Fri, Jun 26, 2020 at 12:42 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > >
> > > Is there any reason to use IRQCHIP_DECLARE if this can work as a
> > > platform device driver?
> > >
> > 
> > Hey! Thanks so much for the review!
> > 
> > Mostly it was done this way to minimize the change in the non-module
> > case. But if you'd rather avoid the #ifdefery I'll respin it without.
> 
> That would certainly be my own preference. In general, IRQCHIP_DECLARE
> and platform drivers should be mutually exclusive in the same driver:
> if you can delay the probing and have it as a proper platform device,
> then this should be the one true way.
> 

Does it work? I haven't looked in detail but I worry that the child
irqdomain (i.e. pinctrl-msm) would need to delay probing until this
parent irqdomain is registered. Or has the hierarchical irqdomain code
been updated to handle the parent child relationship and wait for things
to probe or be loaded?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
