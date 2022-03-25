Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3476C433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 18:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39CD3843B1;
	Fri, 25 Mar 2022 18:38:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BiiFycYEjoR0; Fri, 25 Mar 2022 18:38:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE59F8439B;
	Fri, 25 Mar 2022 18:38:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 992A4C002C;
	Fri, 25 Mar 2022 18:38:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 588AFC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 471494092B
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:38:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2J_bwt7P8s_F for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 18:38:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD4AC408F3
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:38:16 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id pv16so17118327ejb.0
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gljIlYXXpBBHbzRdornYZ4fw3jcv11aVW7PwNEPzJZQ=;
 b=Ii2GPivqxQ2ddlxdamEhnLuCB7pfEZti2yKg70Bu00oB1TmGoLi9mmcYJjffLMgr7M
 kO6nzHq/i07S3UkaqTeRHaZx6aM4PAZtnbT71SCPe4jEAxpBzhOPO14QdcWfKG0/keb9
 Rp7c48ZnU1d+fvcLBcoGkqAn/OeN51HLRkwCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gljIlYXXpBBHbzRdornYZ4fw3jcv11aVW7PwNEPzJZQ=;
 b=YWQxPJf188Jh5iofLW3gOXRL5ZpUTW5K1SBUJK6YQGHzvQlOWQZikW/+NNF0HcHR9+
 zd9F6y1RYafaQSgXTZ7bwXn83qvVKag/vGeHJ5qmWRxYZcgh9bThLkKtSLpzuy9Bbz/F
 NNmIxf5DDU4CmGzDTJ95pYY/cRMuTXu7sxLawOFqJRvUDwPs+lpxG4XzBAD792TGOXM1
 +reHVEQdR5i0r2jF8OuCwB1dXhig6PE1ayotZEOFBSA06NG19uQ9Oiz6/zGLyq4vqMgN
 L3ltMkJY5oqLAmOTuWG7YZX5Ak/mpix/1OT/YSBo1I4pUJC6uBWXkYvS+Na74HGEX+ZO
 PHsQ==
X-Gm-Message-State: AOAM533a6PJJ4lZLmI21HvPaF8hWM58cgBUDoBXF2Hqe+b4vKa1quV2t
 aLxhEHgJPpdrN8LcCdngYGTQvmVDsrR29c5U8a1GoA==
X-Google-Smtp-Source: ABdhPJyWgmTc3rUv0dAZvqbZPsDg37xCKkDigF0JDRm2ayiLYPmBshZh09NXz8fLYzyzCjL1BSqC1w==
X-Received: by 2002:a17:907:8a1c:b0:6df:ecd6:b6ea with SMTP id
 sc28-20020a1709078a1c00b006dfecd6b6eamr13143012ejc.530.1648233494646; 
 Fri, 25 Mar 2022 11:38:14 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com.
 [209.85.208.49]) by smtp.gmail.com with ESMTPSA id
 jg15-20020a170907970f00b006e0466dcc42sm2630793ejc.134.2022.03.25.11.38.14
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Mar 2022 11:38:14 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id w25so10195781edi.11
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 11:38:14 -0700 (PDT)
X-Received: by 2002:a05:6512:2296:b0:44a:6aaf:b330 with SMTP id
 f22-20020a056512229600b0044a6aafb330mr5713368lfu.531.1648233037928; Fri, 25
 Mar 2022 11:30:37 -0700 (PDT)
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
In-Reply-To: <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Mar 2022 11:30:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
Message-ID: <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: Maxime Bizon <mbizon@freebox.fr>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Fri, Mar 25, 2022 at 3:25 AM Maxime Bizon <mbizon@freebox.fr> wrote:
>
> In the non-cache-coherent scenario, and assuming dma_map() did an
> initial cache invalidation, you can write this:

.. but the problem is that the dma mapping code is supposed to just
work, and the driver isn't supposed to know or care whether dma is
coherent or not, or using bounce buffers or not.

And currently it doesn't work.

Because what that ath9k driver does is "natural", but it's wrong for
the bounce buffer case.

And I think the problem is squarely on the dma-mapping side for two reasons:

 (a) this used to work, now it doesn't, and it's unclear how many
other drivers are affected

 (b) the dma-mapping naming and calling conventions are horrible and
actively misleading

That (a) is a big deal. The reason the ath9k issue was found quickly
is very likely *NOT* because ath9k is the only thing affected. No,
it's because ath9k is relatively common.

Just grep for dma_sync_single_for_device() and ask yourself: how many
of those other drivers have you ever even HEARD of, much less be able
to test?

And that's just one "dma_sync" function. Admittedly it's likely one of
the more common ones, but still..

Now, (b) is why I think driver nufgt get this so wrong - or, in this
case, possibly the dma-mapping code itself.

The naming - and even the documentation(!!!) - implies that what ath9k
does IS THE RIGHT THING TO DO.

The documentation clearly states:

  "Before giving the memory to the device, dma_sync_single_for_device() needs
   to be called, and before reading memory written by the device,
   dma_sync_single_for_cpu(), just like for streaming DMA mappings that are
   reused"

and ath9k obviously did exactly that, even with a comment to the effect.

And I think ath9k is actually right here, but the documentation is so
odd and weak that it's the dma-mapping code that was buggy.

So the dma mapping layer literally broke the documented behavior, and
then Christoph goes and says (in another email in this discussion):

 "Unless I'm misunderstanding this thread we found the bug in ath9k
  and have a fix for that now?"

which I think is a gross mis-characterization of the whole issue, and
ignores *BOTH* of (a) and (b).

So what's the move forward here?

I personally think we need to

 - revert commit aa6f8dcbab47 for the simple reason that it is known
to break one driver. But it is unknown how many other drivers are
affected.

   Even if you think aa6f8dcbab47 was the right thing to do (and I
don't - see later), the fact is that it's new behavior that the dma
bounce buffer code hasn't done in the past, and clearly confuses
things.

 - think very carefully about the ath9k case.

   We have a patch that fixes it for the bounce buffer case, but you
seem to imply that it might actually break non-coherent cases:

   "So I'd be very cautious assuming sync_for_cpu() and sync_for_device()
    are both doing invalidation in existing implementation of arch DMA ops,
    implementers may have taken some liberty around DMA-API to avoid
    unnecessary cache operation (not to blame them)"

   so who knows what other dma situations it might break?

   Because if some non-coherent mapping infrastructure assumes that
*only* sync_for_device() will actually flush-and-invalidate caches
(because the platform thinks that once they are flushed, getting them
back to the CPU doesn't need any special ops), then you're right:
Toke's ath9k patch will just result in cache coherency issues on those
platforms instead.

 - think even *more* about what the ath9k situation means for the dma
mapping naming and documentation.

I basically think the DMA syncing has at least three cases (and a
fourth combination that makes no sense):

 (1) The CPU has actively written to memory, and wants to give that
data to the device.

   This is "dma_sync_single_for_device(DMA_TO_DEVICE)".

    A cache-coherent thing needs to do nothing.

   A non-coherent thing needs to do a cache "writeback" (and probably
will flush)

   A bounce buffer implementation needs to copy *to* the bounce buffer

 (2) The CPU now wants to see any state written by the device since
the last sync

    This is "dma_sync_single_for_cpu(DMA_FROM_DEVICE)".

    A bounce-buffer implementation needs to copy *from* the bounce buffer.

    A cache-coherent implementation needs to do nothing.

    A non-coherent implementation maybe needs to do nothing (ie it
assumes that previous ops have flushed the cache, and just accessing
the data will bring the rigth thing back into it). Or it could just
flush the cache.

 (3) The CPU has seen the state, but wants to leave it to the device

   This is "dma_sync_single_for_device(DMA_FROM_DEVICE)".

   A bounce buffer implementation needs to NOT DO ANYTHING (this is
the current ath9k bug - copying to the bounce buffer is wrong)

  A cache coherent implementation needs to do nothing

  A non-coherent implementation needs to flush the cache again, bot
not necessarily do a writeback-flush if there is some cheaper form
(assuming it does nothing in the "CPU now wants to see any state" case
because it depends on the data not having been in the caches)

 (4) There is a fourth case: dma_sync_single_for_cpu(DMA_TO_DEVICE)
which maybe should generate a warning because it seems to make no
sense? I can't think of a case where this would be an issue - the data
is specifically for the device, but it's synced "for the CPU"?

Do people agree? Or am I missing something?

But I don't think the documentation lays out these cases, and I don't
think the naming is great.

I also don't think that we can *change* the naming. That's water under
the bridge. It is what it is. So I think people need to really agree
on the semantics (did I get them entirely wrong above?) and try to
think about ways to maybe give warnings for things that make no sense.

Based on my suggested understanding of what the DMA layer should do,
the ath9k code is actually doing exactly the right thing. It is doing

        dma_sync_single_for_device(DMA_FROM_DEVICE);

and based on my four cases above, the bounce buffer code must do
nothing, because "for_device()" together with "FROM_DEVICE" clearly
says that all the data is coming *from* the device, and copying any
bounce buffers is wrong.

In other words, I think commit aa6f8dcbab47 ("swiotlb: rework 'fix
info leak with DMA_FROM_DEVICE'") is fundamentally wrong. It doesn't
just break ath9k, it fundamentally break that "case 3" above. It's
doing a DMA_TO_DEVICE copy, even though it was a DMA_FROM_DEVICE sync.

So I really think that "revert aa6f8dcbab47" is not only inevitable
because of practical worries about what it breaks, but because that
commit was just entirely and utterly WRONG.

But having written this long wall of text, I'm now slightly worried
that I'm just confused, and am trying to just convince myself.

So please: can people think about this a bit more, and try to shoot
down the above argument and show that I'm just being silly?

And if I'm right, can we please document this and try really hard to
come up with some sanity checks (perhaps based on some "dma buffer
state" debug code?)

                 Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
