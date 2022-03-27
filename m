Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3250C433F5
	for <iommu@archiver.kernel.org>; Sun, 27 Mar 2022 20:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94EC540948;
	Sun, 27 Mar 2022 20:11:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1V8B0B9adfMn; Sun, 27 Mar 2022 20:11:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5CDFF415B0;
	Sun, 27 Mar 2022 20:11:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AE4DC001D;
	Sun, 27 Mar 2022 20:11:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1BB6C0012
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 20:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A83B415B0
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 20:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id diRA_vAY5ENK for <iommu@lists.linux-foundation.org>;
 Sun, 27 Mar 2022 20:11:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C43B640948
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 20:11:36 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id s25so16657409lji.5
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wob/7GSQVIpO7i1InQcutyEWYgbvdwTICG96D7RFBB8=;
 b=MBKpZ1UtrtPBVIHqjdSKYB/rkJWZ1f0vdHzhtdISyO5M6IfCasC0hYp5oS9+XwcX2g
 onX3toZbyl+fJ/Tk2m9EN2QoWGToeUma4YxombZeY5ZkW09xgeyTm/fWrkUSPf9q19W+
 djbSzf2EiLGwXDF9V4ce2XqsgWTUpumTDa/0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wob/7GSQVIpO7i1InQcutyEWYgbvdwTICG96D7RFBB8=;
 b=yCd6G8/XdExNpe8YnQ2zt3rZmm7NYV10hgd8MelDwIZa+MotwjOwRzoXQEP/F8kGCK
 ufEWmh98FZz3Ju2dGQm4OSLLCDQcCUzoMO7OWE3fWlwGVCBMJG6eZon2ZLtXrLXKvPbb
 U0r9SXb7JJJ1YGuDKkJIJOtm9TjD8Fc+lMS3Mxf6YpSyyBBzihcKhYbZY7x1pOVbwr7p
 hgSmsucoop/2zqold4d1ipTxX0qF18FnuMd8FzDhBLRt6CnJFOHjDrL6PBi8kOFHub4g
 6eVhuQtM0VefA2Y86VCIcvVoKMx+DxyxCmZGHnW1w/59pEknlcgXPlBvm06/7j0tXSXN
 KW1g==
X-Gm-Message-State: AOAM530zBf5uYuZQFR755XhDhLPvr433vjzIoS1Ifar3bpSFxjHeawYc
 LNaQuXaexfTySk9ppiz+H4YftZ+mTOOZEzGXCtQJkA==
X-Google-Smtp-Source: ABdhPJyqlIu+xdVKdnzCf3NYvomMCzLBT3aLD55kOEjp6VWS+Anw5l6ogGq5QPA8yDXD3RHEqkdXjQ==
X-Received: by 2002:a05:651c:1508:b0:249:b843:208f with SMTP id
 e8-20020a05651c150800b00249b843208fmr11634944ljf.239.1648411894265; 
 Sun, 27 Mar 2022 13:11:34 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49]) by smtp.gmail.com with ESMTPSA id
 d23-20020a0565123d1700b0044a342b4e59sm1442257lfv.239.2022.03.27.13.11.33
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Mar 2022 13:11:33 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id bt26so21488811lfb.3
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 13:11:33 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr16821393lji.152.1648411509868; Sun, 27
 Mar 2022 13:05:09 -0700 (PDT)
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
 <CAHk-=wgUx5CVF_1aEkhhEiRGXHgKzUdKiyctBKcHAxkxPpbiaw@mail.gmail.com>
 <0745b44456d44d1e9fc364e5a3780d9a@AcuMS.aculab.com>
 <CAHk-=wgLyqNJx=bb8=o0Nk5U8gMnf0-=qx53ShLEb3V=Yrt8fw@mail.gmail.com>
In-Reply-To: <CAHk-=wgLyqNJx=bb8=o0Nk5U8gMnf0-=qx53ShLEb3V=Yrt8fw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Mar 2022 13:04:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+TzZhMCiPPnchC4FSeS53-QCN3RYqxLAh4ahKMLoj9A@mail.gmail.com>
Message-ID: <CAHk-=wh+TzZhMCiPPnchC4FSeS53-QCN3RYqxLAh4ahKMLoj9A@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: David Laight <David.Laight@aculab.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
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

On Sun, Mar 27, 2022 at 12:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I will propose that we really make it very much about practical
> concerns, and we document things as
>
>  (a) the "sync" operation has by definition a "whose _future_ access
> do we sync for" notion.
>
>      So "dma_sync_single_for_cpu()" says that the future accesses to
> this dma area is for the CPU.
>
>      Note how it does *NOT* say that the "CPU owns the are". That's
> bullsh*t, and we now know it's BS.
>
>  (b) but the sync operation also has a "who wrote the data we're syncing"
>
>      Note that this is *not* "who accessed or owned it last", because
> that's nonsensical: if we're syncing for the CPU, then the only reason
> to do so is because we expect that the last access was by the device,
> so specifying that separately would just be redundant and stupid.
>
>      But specifying who *wrote* to the area is meaningful and matters.

We could also simply require that the bounce buffer code *remember*
who wrote to it last.

So when the ath9k driver does

 - setup:

                bf->bf_buf_addr = dma_map_single(sc->dev, skb->data,
                                                 common->rx_bufsize,
                                                 DMA_FROM_DEVICE);

we clear the bounce buffer and remember that the state of the bounce
buffer is "device wrote to it" (because DMA_FROM_DEVICE).

Then, we have an interrupt or other event, and ath9k does

 - rc event:

        dma_sync_single_for_cpu(sc->dev, bf->bf_buf_addr,
                                common->rx_bufsize, DMA_FROM_DEVICE);

        ret = ath9k_hw_process_rxdesc_edma(ah, rs, skb->data);
        if (ret == -EINPROGRESS) {
                /*let device gain the buffer again*/
                dma_sync_single_for_device(sc->dev, bf->bf_buf_addr,
                                common->rx_bufsize, DMA_FROM_DEVICE);
                return false;
        }

and the first dma_sync_single_for_cpu() now sees "Ok, I want the CPU
buffer, and I remember that the device wrote to it, so I will copy
from the bounce buffer". It's still DMA_FROM_DEVICE, so that "the
device wrote to it" doesn't change.

When the CPU then decides "ok, that wasn't it", and does that
dma_sync_single_for_device(), the bounce buffer code goes "Ok, the
last operation was that the device wrote to the buffer, so the bounce
buffer is still valid and I should do nothing".

Voila, no ath9k breakage, and it all still makes perfect sense.

And that sounds like an even more logical model than the one where we
tell the bounce buffer code what the previous operation was, but it
involves basically the DMA mapping code remembering what the last
direction was. That makes perfect sense to me, but it's certainly not
what the DMA mapping code has traditionally done, which makes me
nervous that it would just expose a _lot_ of other drivers that do odd
things.

The "good news" (if there is such a thing) is that usually the
direction doesn't actually change. So if you use DMA_FROM_DEVICE
initially, you'll continue to use that. So there is probably basically
never any difference between "what was the previous operation" and
"what is the next operation".

So maybe practically speaking, we don't care.

Anyway, I do think we have choices here on how to describe things.

I do think that the "DMA code doesn't have to remember" model has the
advantage that remembering is always an added complexity, and
operations that behave differently depending on previous history are
always a bit harder to think about because of that. Which is why I
think that model I outlined in the previous email is probably the most
straightforward one.

                 Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
