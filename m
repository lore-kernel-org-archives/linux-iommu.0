Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5F5C433F5
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 18:11:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1F76120E
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 18:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F1F76120E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47AEA405E5;
	Thu,  4 Nov 2021 18:11:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M11yBa1gDTGI; Thu,  4 Nov 2021 18:11:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F1FD405E0;
	Thu,  4 Nov 2021 18:11:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1ABA5C0019;
	Thu,  4 Nov 2021 18:11:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B5C8C000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 18:11:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89722401C4
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 18:11:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10GcUJL8im67 for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 18:11:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FBB0401AF
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 18:11:13 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id a10so3433768ljk.13
 for <iommu@lists.linux-foundation.org>; Thu, 04 Nov 2021 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nf0H9x5iC2UijIAft5liiq6zHCoI2VPB3p3SeysRKEk=;
 b=Uwu8a58w2K2ozIztcp+NlMX1tiXHAgLmZSW0tAlxr4RT7mZUZhwi9KscudA5wVqhBQ
 VsQJjUy7lLJrCJt2TPhk0RPqqZlqt+D2WmNlO5+F1nEfD+sjD4Y3323mu1LQlMflp7TZ
 DJe1bcPkA1lE7zcYzWvaIaphlXfZZUXqsukwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nf0H9x5iC2UijIAft5liiq6zHCoI2VPB3p3SeysRKEk=;
 b=eIM3YXazIS0OQIUkursFBhXqgiZIO8sDlVm5HoYa/6b/cTQPKFfnuORu82vcfIbC2z
 crbQRIF94l0P+gG21w4fJY0o4p8prErg/xd4z9/IAzf19s0xErPIM7Iher15ILNFjA6q
 lmwZDt9jZc+MSKCL2jbXZDUg+7kftswwTVwUrIMIzykODD5Z1Kc06xw7QgHNTlHMvWic
 in8STiC1CP9cfCjh2PCvJqwv1XS9tKFkfTzMnNyT0UcVSYqqpjiHUCq7kXGS6UDWXoSk
 XUhrwlRxWTy7lUtM6icdf9e+dn4ci2/tx0OltkPUu3gRmgiVTa2t19xA0LH617t1vASO
 puhA==
X-Gm-Message-State: AOAM530yZ5NUdsGJO0VXuv7XENHQ3uowLKQgrg/LWeusSqlFIQtrW5Ur
 XJaPE0uDqW0/bgubxtajyEvd4xLTiStq9txB7OY=
X-Google-Smtp-Source: ABdhPJyR79q/Qk3qbSvSRiNRYrK3kXmJ2tIIB+i0yaUr0vvXnWbpr6YAxRxUtXPucJO1FBkeWrJxxA==
X-Received: by 2002:a2e:9b1a:: with SMTP id u26mr11002789lji.483.1636049470748; 
 Thu, 04 Nov 2021 11:11:10 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com.
 [209.85.167.43])
 by smtp.gmail.com with ESMTPSA id f23sm567349ljj.116.2021.11.04.11.11.09
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Nov 2021 11:11:10 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id d21so13647472lfg.7
 for <iommu@lists.linux-foundation.org>; Thu, 04 Nov 2021 11:11:09 -0700 (PDT)
X-Received: by 2002:ac2:4e15:: with SMTP id e21mr50379940lfr.655.1636049469724; 
 Thu, 04 Nov 2021 11:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <YYPrNkweZahTdAbA@8bytes.org>
In-Reply-To: <YYPrNkweZahTdAbA@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Nov 2021 11:10:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whX_ygSHr02mhWXO38kddFE_t7ntBHf_sehz=asFfzFKA@mail.gmail.com>
Message-ID: <CAHk-=whX_ygSHr02mhWXO38kddFE_t7ntBHf_sehz=asFfzFKA@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.16
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

On Thu, Nov 4, 2021 at 7:16 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> there is a merge conflict this time between the IOMMU tree and FPU
> changes which came from the tip tree. My conflict resolution is
> attached.

The conflict is trivial, no worries. But as I was resolving it, I
looked at that PASID_DISABLED define..

That too seems to be stale and unused since commit 9bfecd058339
("x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove
update_pasid()")

I left it alone because I didn't want to do any extra development in
the merge commit itself, but it looks to me like there's some room for
more cleanips. No?

              Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
