Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D25CC433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 20:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2881E405D8;
	Fri, 25 Mar 2022 20:48:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7-I4RuFit4g6; Fri, 25 Mar 2022 20:48:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93CDE4013D;
	Fri, 25 Mar 2022 20:48:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BC85C002C;
	Fri, 25 Mar 2022 20:48:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8253C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 20:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 889D460B64
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 20:48:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W-wdEG_dNZUe for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 20:48:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4ACD60B2C
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 20:48:03 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id k21so15295184lfe.4
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qTyIfzc6eWn8tPRbJvu4pItLGCLIkdX7GJakm9zDrl8=;
 b=gm5AHFVvThRrK7sA/BQ6fJ/iDwpQq6O0/7tOPWKWfF0gNOKqop2SvIcH4r/OClE48L
 VFW0eVhGjvjiyVqrrrPg6Q1OkP1qou04a5ugVipBYO9VTlVyEcQ7kokZzVjAoN7pS1Ch
 +u+3DjL5YncJtUcCyN3Ju5WCdBaFHsUNObffo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qTyIfzc6eWn8tPRbJvu4pItLGCLIkdX7GJakm9zDrl8=;
 b=uMjDGSFK8fSoqqGW3YziwzzdjiRUJnppKBsjNnbeXXJPBBbegh6p90b4yiTl6tSUZg
 riyGceMJGr74xf/YpFT++HkRSsWziVqNewmoJa8FpcpthtJh9VU7iGIg5Whj7z0QROs/
 FkeM08otXvnwfnx4FthM6ZX0Vm0ymeTPvqtF72KAtslm/g2a8u3xUGjuwPrj+xN/AoYj
 a3NtdysQCcVXhjVx4WHsM2pOAhsV6UrUzY4GWMxHyKvOg0vLU8sBA3c84RltN0NVmZ+c
 HAqRcTRJB5t1yPXwhusLAL16HeotM7ICOGlyWE5d6/VrMQ25jrF1tahsTyDFsaoaJbRA
 tH4w==
X-Gm-Message-State: AOAM533vi+NoQG8MKo/4ozhRKvZsyJ8LGUHDHRQWELaa/NPwQvGwJ/O5
 6xfgiPNjtrw7BPGn4vFoBHkGsmQQIctjvPOlkYLKVQ==
X-Google-Smtp-Source: ABdhPJyMQBIhFXiPeMFTfOZoHfuNQzU1dvQKV/y26eqiW7QMeRKYPDlmHGN1QUyyBKouk3k/qgPCEg==
X-Received: by 2002:a05:6512:3b25:b0:44a:108d:cc4c with SMTP id
 f37-20020a0565123b2500b0044a108dcc4cmr9579932lfv.36.1648241281230; 
 Fri, 25 Mar 2022 13:48:01 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54]) by smtp.gmail.com with ESMTPSA id
 i27-20020a0565123e1b00b0044a6cd739b6sm513351lfv.15.2022.03.25.13.47.59
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Mar 2022 13:48:00 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id h7so15306692lfl.2
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 13:47:59 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr9094484lfh.687.1648241278691; Fri, 25
 Mar 2022 13:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
 <298f4f9ccad7c3308d3a1fd8b4b4740571305204.camel@sipsolutions.net>
In-Reply-To: <298f4f9ccad7c3308d3a1fd8b4b4740571305204.camel@sipsolutions.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Mar 2022 13:47:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXAan2ExANMryPSFaBWeyzikPi+fPUseMoVhQAxR7cEA@mail.gmail.com>
Message-ID: <CAHk-=whXAan2ExANMryPSFaBWeyzikPi+fPUseMoVhQAxR7cEA@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: Johannes Berg <johannes@sipsolutions.net>
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

On Fri, Mar 25, 2022 at 1:38 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> >  (2) The CPU now wants to see any state written by the device since
> > the last sync
> >
> >     This is "dma_sync_single_for_cpu(DMA_FROM_DEVICE)".
> >
> >     A bounce-buffer implementation needs to copy *from* the bounce buffer.
> >
> >     A cache-coherent implementation needs to do nothing.
> >
> >     A non-coherent implementation maybe needs to do nothing (ie it
> > assumes that previous ops have flushed the cache, and just accessing
> > the data will bring the rigth thing back into it). Or it could just
> > flush the cache.
>
> Doesn't that just need to *invalidate* the cache, rather than *flush*
> it?

Yes.  I should have been more careful.

That said, I think "invalidate without writeback" is a really
dangerous operation (it can generate some *really* hard to debug
memory state), so on the whole I think you should always strive to
just do "flush-and-invalidate".

If the core has support for "invalidate clean cache lines only", then
that's possibly a good alternative.

> >   A non-coherent implementation needs to flush the cache again, bot
> > not necessarily do a writeback-flush if there is some cheaper form
> > (assuming it does nothing in the "CPU now wants to see any state" case
> > because it depends on the data not having been in the caches)
>
> And similarly here, it would seem that the implementation can't _flush_
> the cache as the device might be writing concurrently (which it does in
> fact do in the ath9k case), but it must invalidate the cache?

Right, again, when I said "flush" I really should have said "invalidate".

> I'm not sure about the (2) case, but here it seems fairly clear cut that
> if you have a cache, don't expect the CPU to write to the buffer (as
> evidenced by DMA_FROM_DEVICE), you wouldn't want to write out the cache
> to DRAM?

See above: I'd *really* want to avoid a pure "invalidate cacheline"
model. The amount of debug issues that can cause is not worth it.

So please flush-and-invalidate, or invalidate-non-dirty, but not just
"invalidate".

> Then, however, we need to define what happens if you pass
> DMA_BIDIRECTIONAL to the sync_for_cpu() and sync_for_device() functions,
> which adds two more cases? Or maybe we eventually just think that's not
> valid at all, since you have to specify how you're (currently?) using
> the buffer, which can't be DMA_BIDIRECTIONAL?

Ugh. Do we actually have cases that do it? That sounds really odd for
a "sync" operation. It sounds very reasonable for _allocating_ DMA,
but for syncing I'm left scratching my head what the semantics would
be.

But yes, if we do and people come up with semantics for it, those
semantics should be clearly documented.

And if we don't - or people can't come up with semantics for it - we
should actively warn about it and not have some code that does odd
things that we don't know what they mean.

But it sounds like you agree with my analysis, just not with some of
my bad/incorrect word choices.

            Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
