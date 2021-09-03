Return-Path: <SRS0=hF+p=NZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E5BC433FE
	for <iommu@archiver.kernel.org>; Fri,  3 Sep 2021 18:43:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7314961058
	for <iommu@archiver.kernel.org>; Fri,  3 Sep 2021 18:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7314961058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4466E80B53;
	Fri,  3 Sep 2021 18:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nBa4zA8qTNDi; Fri,  3 Sep 2021 18:43:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7626C80AA9;
	Fri,  3 Sep 2021 18:43:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B778C0010;
	Fri,  3 Sep 2021 18:43:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0F68C000E
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 18:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98F4340134
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 18:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZPRPdUuef558 for <iommu@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 18:43:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C726400AE
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 18:43:50 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id s10so87868lfr.11
 for <iommu@lists.linux-foundation.org>; Fri, 03 Sep 2021 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PDBYi9Z882BNn51ficUIiFA+0LchDZSUHG8v/R1TTmc=;
 b=erwLqXCPiOkc7iLNX+1wsf+W1xGRPlDR/efCspYuJjsaoLXEbWO/Nfc5o6johJ+t5q
 Slyl6X+1hibZjNLP2somHUs5gbYWVosvZm0eAL92nNAtKKMMb5VVvbxem0vdKgNG0Q6C
 moEnDJGq8wvtO+qgfSREpcFfcutSEKxCSWIr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PDBYi9Z882BNn51ficUIiFA+0LchDZSUHG8v/R1TTmc=;
 b=kSK7sjvs3oEnbnanororksOhci33AGOVAh7U05GKLHjiix3XJNoX1T3ZYmkepYuHeH
 jPPZY9fKBL/8ybIw5rFySJ24vhvOZaZfWOk+r29suXlvfcRejuRtktbrJ3VJpa3jDws+
 vzFQz8EHl3BWTbq9t977r6CL/zpyjKFchxHjSCycj24e8Jtw4214d/V/okOHSqaJE+X9
 I9zhTedvXF/vXeGNqtK14ixjI8Qjdr8Oy+WAVnCA430zo1s2+zmfIa+/bWSVmK/q3BDS
 x1Ky8x8go6rdZ5XaF+dGX6REDAF+eVK2QWDcXlEAgXwgVrPbCmoNDu3UNnd/Fi87dKrr
 QoPw==
X-Gm-Message-State: AOAM532GePaNe3MzvW6Nlc/kUZYo6m6G8l2e3FderrFdQhgSYVECKcDi
 Alkc+6Y5sKXT3jSIiZUms4cSG+QBe90uFFmFq1x8SA==
X-Google-Smtp-Source: ABdhPJwIJ3ekokXt4PM/5rfbOtDCAy+HT5X+iY5N0N8ksbF2fmcwYmKNgGbZGDU3tycXOTokKR5gKw==
X-Received: by 2002:ac2:51a2:: with SMTP id f2mr214943lfk.685.1630694628262;
 Fri, 03 Sep 2021 11:43:48 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45])
 by smtp.gmail.com with ESMTPSA id v15sm22538lfd.34.2021.09.03.11.43.47
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Sep 2021 11:43:47 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c8so143707lfi.3
 for <iommu@lists.linux-foundation.org>; Fri, 03 Sep 2021 11:43:47 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id
 m12mr261598lfg.150.1630694627536; 
 Fri, 03 Sep 2021 11:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <YTIrHxWNzIwuseXO@8bytes.org>
In-Reply-To: <YTIrHxWNzIwuseXO@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Sep 2021 11:43:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTpYOsRPm4T2EV=Sxm52buZrMpRdwSDeedCSF4jh=M1w@mail.gmail.com>
Message-ID: <CAHk-=wjTpYOsRPm4T2EV=Sxm52buZrMpRdwSDeedCSF4jh=M1w@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.15
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Sep 3, 2021 at 7:03 AM Joerg Roedel <joro@8bytes.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.15

So I've merged this, but I'm not entirely happy with some of the
rather insane Kconfig choices.

In particular, the defaults for this:

  choice
        prompt "IOMMU default domain type"
        depends on IOMMU_API
        default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
        default IOMMU_DEFAULT_DMA_STRICT

seems fundamentally confused about what the h*ll is going on.

Why? Because a choice like "AMD_IOMMU" or "INTEL_IOMMU" isn't some
exclusive thing. You can have one or the other - or both. Or you could
have another IOMMU entirely, despite _also_ having AMD/INTEL_IOMMU
enabled as a config option.

IOW, maybe INTEL or AMD_IOMMU is enabled in the kernel configuration,
but that might not be the IOMMU that is then actually *active*.

The active IOMMU might be VIRTIO_IOMMU, for example.

See what I'm saying? Making the default be based on some random "this
driver is enabled" when it can then affect *other* drivers that are
also enabled and not part of the decision seems to be a fundamental
confusion about what is going on, when it's not at all clear which
driver will actually be IN USE.

Now, I don't think this _matters_ that much in practice, and as
mentioned, I already merged things.

But I think people should seriously think about either

 (a) make that default something that is actually *reliable*, so that
the fact that you have possibly enabled iommu X doesn't affect iommu Y
that is actually the one in use

or

 (b) make the defaults be actually per-driver, and set when the driver
is in *use* rather than this incorrect model of "enabled but maybe not
even used".

IOW, the fix might be to just say "the default is always lazy".

Or the fix might be something that is global to a configuration and
doesn't rely on which iommu is in use (eg "on x86, the default is
always LAZY")

Or the fix is to make that 'iommu_dma_strict' variable - and the
default value for it - be a per-IOMMU thing rather than be a global.

Hmm?

              Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
