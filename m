Return-Path: <SRS0=xpAE=N6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA58C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Sep 2021 16:47:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8939161154
	for <iommu@archiver.kernel.org>; Wed,  8 Sep 2021 16:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8939161154
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4391A40162;
	Wed,  8 Sep 2021 16:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6t3slVm9tE0A; Wed,  8 Sep 2021 16:47:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E329D40022;
	Wed,  8 Sep 2021 16:47:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2B62C0011;
	Wed,  8 Sep 2021 16:47:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 477B0C000D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Sep 2021 16:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36D43834B9
 for <iommu@lists.linux-foundation.org>; Wed,  8 Sep 2021 16:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1RczXR8wVJoi for <iommu@lists.linux-foundation.org>;
 Wed,  8 Sep 2021 16:47:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EE9783487
 for <iommu@lists.linux-foundation.org>; Wed,  8 Sep 2021 16:47:24 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id w4so4541292ljh.13
 for <iommu@lists.linux-foundation.org>; Wed, 08 Sep 2021 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jt97OjPgOlwhkMU+9KY4C6kyYEYRZScwK0qfgdPvP7s=;
 b=AkaWDibe1d4zi2+EffnilOJ0ivSBKulI33gsSPtpT2aARGvKgOcNOj6Pqd5Nt1/3Ug
 ehQICKIF8BVDZbENDFCCkCZmAVxFltEioM2P+QQbUiK5ba7HNLtagSiJLbfgREIG9J/2
 VPM5qijcG/juMnCQY4ebU42mXDzauxWZ9Yxs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jt97OjPgOlwhkMU+9KY4C6kyYEYRZScwK0qfgdPvP7s=;
 b=b+0+oiWEN8Hby3cAMd5rX+ExSVEIEUupeY+LUaGauwEvDy2bfpqedmbJXIR6vA3GQm
 A9xBGydOTS6xA+ScyBxoVdt6F77JZY2pt3ZzmVizz9DP1BZv6QExe/RSFPtZujEC6Vim
 ma3bf3qSLv1MZlmNEi4yqtH7oQHbhNEjjBATRrhCH74DnBFk5uKJvoODHOxVPmZCqYTQ
 2wGwndPfwvZWoHyrvifvXHyoPBrqCadxKm02//HEARZso2LKJvDMrA1Y9pKtnDrTngJw
 0FyvNWAZMeSNl4zjq9c+2g6lDVTfnfdS26qqu0X80cZk8bVLJaDcci7sCHtEJB0nvK8L
 LDmw==
X-Gm-Message-State: AOAM532JP4O820swybz9vXrKXH38dx4aBCEW2IkBQIyaVUUrWLlD4KOZ
 6RWSJ0vEpHSnpIPCeN1Kvf0hK1RtLSroP8U6G4bo5A==
X-Google-Smtp-Source: ABdhPJyqauCohY8jKezgLvsXw5Jg03MdSyRo9aQ2pGrkGI5GrjMuDWgKBx6jFTEID6uFuYAM8gaK0w==
X-Received: by 2002:a2e:8553:: with SMTP id u19mr3709313ljj.158.1631119642203; 
 Wed, 08 Sep 2021 09:47:22 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id x1sm293561ljh.113.2021.09.08.09.47.19
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Sep 2021 09:47:19 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id m28so6119288lfj.6
 for <iommu@lists.linux-foundation.org>; Wed, 08 Sep 2021 09:47:19 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id
 w3mr3240332lfr.173.1631119639612; 
 Wed, 08 Sep 2021 09:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <69a0c6f17b000b54b8333ee42b3124c1d5a869e2.1631105737.git.robin.murphy@arm.com>
In-Reply-To: <69a0c6f17b000b54b8333ee42b3124c1d5a869e2.1631105737.git.robin.murphy@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Sep 2021 09:47:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whm5tP-JDnZ=LCr2ZpnPaAZakZyN=wD_tY7pydQJRtJXw@mail.gmail.com>
Message-ID: <CAHk-=whm5tP-JDnZ=LCr2ZpnPaAZakZyN=wD_tY7pydQJRtJXw@mail.gmail.com>
Subject: Re: [PATCH] iommu: Clarify default domain Kconfig
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, iommu <iommu@lists.linux-foundation.org>,
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

On Wed, Sep 8, 2021 at 5:55 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Although strictly it is the AMD and Intel drivers which have an existing
> expectation of lazy behaviour by default, it ends up being rather
> unintuitive to describe this literally in Kconfig. Express it instead as
> an architecture dependency, to clarify that it is a valid config-time
> decision.

Thanks, I think this describes the behavior much more naturally, even
if apparently the end result is pretty much identical.

I'm assuming I'll get it through the iommu tree eventually (no need to
expedite this),

           Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
