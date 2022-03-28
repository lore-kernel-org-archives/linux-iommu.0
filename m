Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A04C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 00:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36B5960F8E;
	Mon, 28 Mar 2022 00:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id od0bUv_cNiT9; Mon, 28 Mar 2022 00:37:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BBF0A60F37;
	Mon, 28 Mar 2022 00:37:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9171EC001D;
	Mon, 28 Mar 2022 00:37:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBEF2C0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 00:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1E3A40488
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 00:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dlUFv2vIlQqE for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 00:37:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30D6E40160
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 00:37:49 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id r22so17127754ljd.4
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LRo9b3MUkbZre2OxOOlq/WFZn88JngO4mNALahdqLLo=;
 b=LOyMW3j2NDs+H2edr432o6t72bJ9rAAidtE6uQtKka0v04jJxIfLU52bcaFDLDlYM/
 JetNnRKqVZGNI5IDhgLZasSqq5nol47bGRc3ngtiYDkZguPV/FKkhqaz+XAlXyUCnfUj
 hkQqnDJ74mGQw+89wAM/GMeJRvAJS7NceW9Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LRo9b3MUkbZre2OxOOlq/WFZn88JngO4mNALahdqLLo=;
 b=VmCrh/IT9aJkEMwYV45pJU77gLKOiC4e2KeOPp90p/yYb1KrSDiivExY0w2L8kwaR8
 yKHs7JWG8DAAIpi608qluQRA3F0NRCerhGUqc8fwF80bm8BhGLIR/qW1bndSwDjgz0Y7
 7dBaGXUnZmsjBJSr+4k0uknx93e+UQi9ib5K0kGxHDzBKKervxDbBcL+5zuUDk/Ko54V
 SP/lSZ1SlUTqaXxENX/nrnTU9bidX+G6bpjeOPEEAYxv5gZamDdQxYWz6jin2euk5J/5
 hwswqKwNcjq2CFIZhCQo3hrNPRY0ipI5ZW8bD9YaB+tD4FRhHFZ0xIgNlMpQ3Eyr+BgX
 hI7g==
X-Gm-Message-State: AOAM531iaWGZsB5QG6Pe3GI1unrX2VNylYV9eTy2oSxUYjBsFzuNJ4bq
 81F42pBcyRKgFsYrYX6unulyVizFwZNTbD0hetgmsA==
X-Google-Smtp-Source: ABdhPJylUXn+iMq++VLBhfZ2uF6jLgl5SBCVv4vXHjB/UpUrFAB3wpV/H5ZbSDwC34h2gViVld/NLA==
X-Received: by 2002:a2e:3013:0:b0:247:ea0d:11e2 with SMTP id
 w19-20020a2e3013000000b00247ea0d11e2mr17815813ljw.2.1648427866692; 
 Sun, 27 Mar 2022 17:37:46 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com.
 [209.85.167.43]) by smtp.gmail.com with ESMTPSA id
 z14-20020a2e7e0e000000b0024ac33571fbsm729377ljc.62.2022.03.27.17.37.41
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Mar 2022 17:37:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id d5so22099349lfj.9
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 17:37:41 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr17468965lfv.52.1648427861326; Sun, 27
 Mar 2022 17:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <20220327054848.1a545b12.pasic@linux.ibm.com>
 <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
 <20220328013731.017ae3e3.pasic@linux.ibm.com>
In-Reply-To: <20220328013731.017ae3e3.pasic@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Mar 2022 17:37:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whScWZnR_DZ12grwOcH_WnU1hJ_YXFmU5GNqrBkhiKgPQ@mail.gmail.com>
Message-ID: <CAHk-=whScWZnR_DZ12grwOcH_WnU1hJ_YXFmU5GNqrBkhiKgPQ@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: Halil Pasic <pasic@linux.ibm.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

On Sun, Mar 27, 2022 at 4:37 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
>
> For the record, I believe that the partial revert proposed here
> https://www.spinics.net/lists/linux-wireless/msg222300.html
> would have been a wiser choice, than a complete revert of commit
> aa6f8dcbab47 ("swiotlb: rework "fix info leak with DMA_FROM_DEVICE"").

Yeah, the revert is basically my standard "this doesn't work,
discussion is still ongoing" thing.

I agree that the revert then brought back that DMA_ATTR_SKIP_CPU_SYNC
complexity.

So that part of commit aa6f8dcbab47 was probably all good.

I somehow missed that Oleksandr had a tested-by for that smaller change too.

              Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
