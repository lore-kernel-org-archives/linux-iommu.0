Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40015C433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 17:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BBAEE40121;
	Wed, 23 Mar 2022 17:34:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8a4676SLc_LL; Wed, 23 Mar 2022 17:34:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5652C401A4;
	Wed, 23 Mar 2022 17:34:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 375F1C001A;
	Wed, 23 Mar 2022 17:34:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D409C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 17:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0289060A68
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 17:34:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xS-3mhd51YtD for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:34:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2789D607E1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 17:34:32 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id dr20so4313184ejc.6
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qw+/tGAcqsZzOdIU9mPy0h6XsR9YUgqE/aO4tJnDV/U=;
 b=AsueKvmLHM2nGOpImBUVo8JvIUXQZTPBXUuZ+V1+E3nRTCnp7dAn5Ysn/GIxghzLln
 GZBXO3w4k/UDMjMFwtn/nP7LeVAoXHaabLGMz82QEQoUcyQ2iSJywkoB38HO0fhpi+qm
 ebKixIbEogjW5TDgyVUN+w+sNSt7oNBz0RQ04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qw+/tGAcqsZzOdIU9mPy0h6XsR9YUgqE/aO4tJnDV/U=;
 b=FIrNMu4RXM6n5Py9rnoc+Umqn/a284dEMOJfLkGRwYrKrT8g5+Guckh4z4FqYHtKXi
 QBNfUl6q9SVa+jJQ2aDYodgN3mOLgz7A7b2tm4gp+U4rzNmxQyf97X9hZAqPIJIIej2o
 HMwvUniOv6SndbMgFLO41yvXTlMFVhM0fJEZoskSWSHHShp+zA298xkVioLCjvjGOJfu
 yqSUfC954k9G+0FfI7pV3Re/Ea4w9pT/vRBK7g4bU1XNe7Yn7NxiN0hdwNIW2p235noB
 UKujElIk0/w9BkWHrDo4l1NCf34lldLaxqxNs/YJBSFdzBAlrgF12iOGXtg+jM2TVPbW
 NFQA==
X-Gm-Message-State: AOAM532KWfb74PJwAw/SnqM6ZKqIxZJQoBJfurBB2Dj61hqq+ipuPmHv
 ThVtcKmGj/mYYSgsyx1cItXYELR1E0ULCZQs9/sdxw==
X-Google-Smtp-Source: ABdhPJwx+6p5rqDpHYmX4BbfnVwdIzt+o1cgLYvp9FCAB+ugcLz5Cdu40CJ6UIseW8UcPOYA072cJw==
X-Received: by 2002:a17:906:3acd:b0:6df:f6da:fbbb with SMTP id
 z13-20020a1709063acd00b006dff6dafbbbmr1248914ejd.189.1648056869967; 
 Wed, 23 Mar 2022 10:34:29 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com.
 [209.85.218.45]) by smtp.gmail.com with ESMTPSA id
 l2-20020a1709060cc200b006d3d91e88c7sm173528ejh.214.2022.03.23.10.34.29
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 10:34:29 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id pv16so4386339ejb.0
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 10:34:29 -0700 (PDT)
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id
 f20-20020a056512229400b004486c863c78mr661692lfu.531.1648056457283; Wed, 23
 Mar 2022 10:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
In-Reply-To: <1812355.tdWV9SEqCh@natalenko.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Mar 2022 10:27:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
Message-ID: <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Wed, Mar 23, 2022 at 12:19 AM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> The following upstream commits:
>
> aa6f8dcbab47 swiotlb: rework "fix info leak with DMA_FROM_DEVICE"
> ddbd89deb7d3 swiotlb: fix info leak with DMA_FROM_DEVICE
>
> break ath9k-based Wi-Fi access point for me. The AP emits beacons, but
> no client can connect to it, either from the very beginning, or
> shortly after start. These are the only symptoms I've noticed (i.e.,
> no BUG/WARNING messages in `dmesg` etc).

Funky, but clearly true:

> These commits appeared in v5.17 and v5.16.15, and both kernels are
> broken for me. I'm pretty confident these commits make the difference
> since I've built both v5.17 and v5.16.15 without them, and it fixed
> the issue.

Can you double-check (or just explicitly confirm if you already did
that test) that you need to revert *both* of those commits, and it's
the later "rework" fix that triggers it?

> So, I do understand this might be an issue with regard to SG I/O
> handling in ath9k, hence relevant people in Cc.

Yeah, almost certainly an ath9k bug, but a regression is a regression,
so if people can't find the issue in ath9k, we'll have to revert those
commits.

Honestly, I personally think they were a bit draconian to begin with,
and didn't limit their effects sufficiently.

I'm assuming that the ath9k issue is that it gives DMA mapping a big
enough area to handle any possible packet size, and just expects -
quite reasonably - smaller packets to only fill the part they need.

Which that "info leak" patch obviously breaks entirely.

So my expectation is that this is something we'll just revert, but it
would be really good to have the ath9k people double-check.

                Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
