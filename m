Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5493C433E1
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 20:52:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5082F207DD
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 20:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlfyTdXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5082F207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EBD97895FE;
	Tue, 16 Jun 2020 20:52:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1c37INw2eD1l; Tue, 16 Jun 2020 20:52:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 53C64895E6;
	Tue, 16 Jun 2020 20:52:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E380C07FF;
	Tue, 16 Jun 2020 20:52:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B476EC016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 20:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A2E2087A26
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 20:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9RSHOoboRG-f for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 20:52:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2011987A1F
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 20:52:46 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id d4so2672257otk.2
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1mDaBoAYNlImmGKdCyzs30Ab2CK6GaNdKX0Jt8lvk4Q=;
 b=NlfyTdXcuRk+bHqUw+iSQlY+Yp1tZiUjSeOcpP040ruHIUtzEyafQn2O0GlSn7gYeL
 7zHVQjG9C9jWGTbTF3esb4X57Pwk4YUnUyCBcQkM53dx293ZwGNIXK+ItM/IYIuYFfwi
 Tgh+QD873HT3EHOdSG6ryAhurDSG7jATKMwanI5nOGb4ckZpJDg+8gUZ5AtbgIsACytK
 za71wGu8CC+u6oCoxiGLOUpgt5E91RAOhdv90F6y9lE1VYMGnZ34mU6D9A5ODCBpMhl/
 +wSeCnpZeuB4NhP2YYyHpXgVNoZi6FdoAdKqdqF8ZOxCxXiNu5ob8xDBytu9hCeMnQ9o
 qU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1mDaBoAYNlImmGKdCyzs30Ab2CK6GaNdKX0Jt8lvk4Q=;
 b=SjL1ubDP9iqnqKNGqTtXPMt+9f1grVeFWPtvUpll7Bnb3RcrlvVAYUrVyV1aXSQ049
 ymXZh1vb8ThZqGGl0ehZAyTuD3FHbhxEff9Z+nGIvxWkBW7tZUEz7qIB4QVkP0Tv2TKZ
 mJKpDE6AP0JlrK+zLi6e2t549tWcsfr2xR4A5C1M2QKGPFXscAHU92waStYVp1TKgVIB
 fSI7d+sT/LRS+gmsAeh5hy9tibP2jmI17EHVLSJQCpWMnmUjR8OhyZyIzsFkg62T70R7
 0dWch9H8C6DUQKK8eDJ9Y+gsUfNpfvE2VvGi447dnWHaajGFxD1mstbV7RsLD0gPy3Un
 xLaA==
X-Gm-Message-State: AOAM5304s2JjmZ0mwo4Ubfo9PD9l34wUvB8KQgHXNDTdVDI1iF2xPd9r
 gPhZHfCyFSaKlOIWkhuWDryU2YQDrfdgyfQO69b6sw==
X-Google-Smtp-Source: ABdhPJwZnDuYF1+ScqyNsWThdN1UjAZVIPE//LsOe27AsBQ3nI7GPtgCaXGfrrPsASezMO6Zgd4KdSIOrpniIxtDmiQ=
X-Received: by 2002:a9d:1296:: with SMTP id g22mr4304025otg.102.1592340765193; 
 Tue, 16 Jun 2020 13:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200616061338.109499-1-john.stultz@linaro.org>
 <20200616061338.109499-6-john.stultz@linaro.org>
 <0be86735238a0f8b0c25934e2ed39eee@kernel.org>
In-Reply-To: <0be86735238a0f8b0c25934e2ed39eee@kernel.org>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 16 Jun 2020 13:52:32 -0700
Message-ID: <CALAqxLUZBdiLBRcp1GW9rGxt1KhgNVQ86MuPXZcXdx2wFLZk6w@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/5] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: Marc Zyngier <maz@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Todd Kjos <tkjos@google.com>
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

On Tue, Jun 16, 2020 at 12:55 AM Marc Zyngier <maz@kernel.org> wrote:
> On 2020-06-16 07:13, John Stultz wrote:
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index b510f67dfa49..714893535dd2 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -381,6 +381,7 @@ config SPAPR_TCE_IOMMU
> >  config ARM_SMMU
> >       tristate "ARM Ltd. System MMU (SMMU) Support"
> >       depends on (ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)) &&
> > MMU
> > +     depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
>
> This looks a bit ugly. Could you explain why we need this at the SMMU
> level? I'd have expected the dependency to flow the other way around...

Yea, so the arm-smmu-qcom.c file calls directly into the qcom-scm code
via qcom_scm_qsmmu500_wait_safe_toggle()
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm-smmu-qcom.c?h=v5.8-rc1#n44

So if ARM_SMMU=y and QCOM_SCM=m we get:
drivers/iommu/arm-smmu-qcom.o: In function `qcom_smmu500_reset':
arm-smmu-qcom.c:(.text+0xb4): undefined reference to
`qcom_scm_qsmmu500_wait_safe_toggle'

Do you have a suggestion for an alternative approach?

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
