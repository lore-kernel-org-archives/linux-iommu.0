Return-Path: <SRS0=ml75=6Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC5BC54E8A
	for <iommu@archiver.kernel.org>; Sun, 10 May 2020 18:35:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF792080C
	for <iommu@archiver.kernel.org>; Sun, 10 May 2020 18:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FnNwK+Fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF792080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B194186469;
	Sun, 10 May 2020 18:35:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07jUAD6h7i7K; Sun, 10 May 2020 18:35:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD0A686448;
	Sun, 10 May 2020 18:35:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF761C0178;
	Sun, 10 May 2020 18:35:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10BECC016F
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 18:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E65788645E
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 18:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f9hFP_eRJuvC for <iommu@lists.linux-foundation.org>;
 Sun, 10 May 2020 18:35:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 798F686448
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 18:35:08 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id u4so5575730lfm.7
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jmGhiEm22t+3OQvDts0G7B0MglaOf7LPWER0GV6uNyI=;
 b=FnNwK+FpYxSe49d2HF2HI88DOsvdX7SLIXAH4QIjADNVX8Unc9CioH4sANmElWVzRY
 KS6OL4IOKrQpg/mOQkEYEEC5ONLCRvfQlJyTg25V777MtM2gNyAJHNG+qwbYKjOXD3bu
 R1cqqjG57VB79qMeUjZa9gGCfcfb6/ox3xyGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jmGhiEm22t+3OQvDts0G7B0MglaOf7LPWER0GV6uNyI=;
 b=YW867BU6dk6K6+mTs9kQIkq4qv+yif9wW36YS/No2jLygJOyliDLA6eX2ocDRWoSe1
 Q29BokB6Ydd4kOgB6igrRq68CicHnuD9tLKcG00xTcc5gq2aEoYQJn9sIrgildZmyo2g
 g6WrZj9ORqhrHKhACcsi86v+IQbQD81kQtXBTD9pk4NCX29hI4rd8MCtnj8itJAtYGY/
 r8sgFnQLntiGFF0AvtGaEJzoReadoCnf5yUVt+FcXsCC5GJfprnPuP4yKk2CBwPMDWbP
 dAuVfLmN7OV9/VGHLiMQYR0sefcEo/fTfAD/9c31+Twd2f32Fu6Qs+1HDQ1x+oo0arni
 X1bg==
X-Gm-Message-State: AOAM532nv4uCNKBvZBS8ASp0vcIyYQaam+Ke+/zPAtHY6L9zdQICyMDu
 gHeS9poJODzbWwXo3pVq5/IH/VY20UZ1kg==
X-Google-Smtp-Source: ABdhPJxVKdZL56ML9KRZrJc1N9/XqxyWf4mDCyVHzC8okHxCT3FRq5QyOyrEM20GP46likGUrH1Evg==
X-Received: by 2002:ac2:5046:: with SMTP id a6mr8327960lfm.103.1589135705992; 
 Sun, 10 May 2020 11:35:05 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49])
 by smtp.gmail.com with ESMTPSA id x11sm8013107lfe.6.2020.05.10.11.35.05
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2020 11:35:05 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c21so966984lfb.3
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 11:35:05 -0700 (PDT)
X-Received: by 2002:ac2:58c8:: with SMTP id u8mr8563575lfo.142.1589135704829; 
 Sun, 10 May 2020 11:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200510122634.GA32616@8bytes.org>
In-Reply-To: <20200510122634.GA32616@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 May 2020 11:34:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wht3yDtJ6zka=DNaB8Nymh-zmUMZhGaC8yFz29nuW-EsA@mail.gmail.com>
Message-ID: <CAHk-=wht3yDtJ6zka=DNaB8Nymh-zmUMZhGaC8yFz29nuW-EsA@mail.gmail.com>
Subject: Re: [git pull] IOMMU Fixes for Linux v5.7-rc4
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu <iommu@lists.linux-foundation.org>,
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

On Sun, May 10, 2020 at 5:26 AM Joerg Roedel <joro@8bytes.org> wrote:
>
>            The first race condition was around
>           the non-atomic update of the domain page-table root pointer
>           and the variable containing the page-table depth (called
>           mode). This is fixed now be merging page-table root and mode
>           into one 64-bit field which is read/written atomically.

This seems a bit odd.

The pointer part is always page-aligned, and the "mode" is just three bits.

Why isn't it just encoded as one pointer with the low three bits being the mode?

The thing is, the 64-bit atomic reads/writes are very expensive on
32-bit x86. If it was just a native pointer, it would be much cheaper
than an "atomic64_t".

                Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
