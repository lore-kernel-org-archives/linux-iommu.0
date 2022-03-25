Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D61C433FE
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 21:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 023DF84355;
	Fri, 25 Mar 2022 21:57:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YJAS0MvnYO-Y; Fri, 25 Mar 2022 21:57:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 957EB8430B;
	Fri, 25 Mar 2022 21:57:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BBFEC001D;
	Fri, 25 Mar 2022 21:57:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF035C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 21:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6B4A401F8
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 21:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9HaKTAGqu_3s for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 21:57:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 347FE4013D
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 21:57:11 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id w27so15512989lfa.5
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 14:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3QkuXhB7uf6W60gZWDJ6opx1SFjmEWQp6mnWCLk/yVk=;
 b=V81bw1iGLTqXaYjf0jsGudI2NeIxBtbKHIXsodRWH/kb6aHXXKdpMothCmIcD6Rfoh
 /fz1HWRx8XbZMAnqoaWL21ZRDlx4DYW9SvsheHOi4qGFu+UH1Pw7IcM109+bJ1kvB6MT
 cuSniBp5OIcGWyjJpE0F6/a/QiUmhZEXVvkTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3QkuXhB7uf6W60gZWDJ6opx1SFjmEWQp6mnWCLk/yVk=;
 b=2naIb+ly+rH6/nG3be/NtdzzHyTzkkR86JQaFzAvHho6ZIFgXkBwmFRmF4Hh87Dj7w
 LHuIZ1wEtNtjf/vUYl+JmTx1iLriMA84f8jquqVPZpn6eUknMPxqlSTsB/Yh3l6fRKVU
 kL71cDCviGPSm/iuvWxx+uOa/8oSwRSNQSGooaa2QjTc7Tu3j13LiJ6ZO9vXKgntu7GQ
 iojf36FOIZaOYhLELsr0EhQekCkm+8d3dVZ6ymf/PjPdMAodoJnh8ebXhyYsrLB1YG8E
 UC1/IiwIO2mZlmhZZAw+fVvr0FKyxH6oDsN5kSOLowbZpeiQaLiAuZsBS714ajfkSQVm
 mJSQ==
X-Gm-Message-State: AOAM530M/g2/COooEYDwte8AlXSbqpCsh7BPeQjFd8TZwNzBE/AHJzGy
 gMDBWVtJsyGXzhPxQPZdqG5GioMdGnjkLkRT7PRw6A==
X-Google-Smtp-Source: ABdhPJyg7hzA8Dz8OvdoWIJWUfIsYUMX9mN+uqPDQQ+S5yuFYL/D1xEDGp+ir+Y+87pG/ZSg9Lvw2w==
X-Received: by 2002:ac2:5bcb:0:b0:44a:1fd6:6b14 with SMTP id
 u11-20020ac25bcb000000b0044a1fd66b14mr9649027lfn.186.1648245428684; 
 Fri, 25 Mar 2022 14:57:08 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177]) by smtp.gmail.com with ESMTPSA id
 p8-20020a2ea408000000b00247e5087157sm788693ljn.101.2022.03.25.14.57.07
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Mar 2022 14:57:07 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id q14so11925008ljc.12
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 14:57:07 -0700 (PDT)
X-Received: by 2002:a2e:9794:0:b0:249:8488:7dbd with SMTP id
 y20-20020a2e9794000000b0024984887dbdmr9643335lji.176.1648245427344; Fri, 25
 Mar 2022 14:57:07 -0700 (PDT)
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
 <CAHk-=whXAan2ExANMryPSFaBWeyzikPi+fPUseMoVhQAxR7cEA@mail.gmail.com>
 <e42e4c8bf35b62c671ec20ec6c21a43216e7daa6.camel@sipsolutions.net>
In-Reply-To: <e42e4c8bf35b62c671ec20ec6c21a43216e7daa6.camel@sipsolutions.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Mar 2022 14:56:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJp5xCx0CCrLCzFGZyyABYSNNNa0i=4fN3fBydP7r97w@mail.gmail.com>
Message-ID: <CAHk-=wjJp5xCx0CCrLCzFGZyyABYSNNNa0i=4fN3fBydP7r97w@mail.gmail.com>
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

On Fri, Mar 25, 2022 at 2:13 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Well I see now that you said 'cache "writeback"' in (1), and 'flush' in
> (2), so perhaps you were thinking of the same, and I'm just calling it
> "flush" and "invalidate" respectively?

Yeah, so I mentally tend to think of the operations as just
"writeback" (which doesn't invalidate) and "flush" (which is a
writeback-invalidate).

Which explains my word-usage, but isn't great, because it's not
well-defined. And I'm not even consistent about it.

> However, this seems to be the wrong spot to flush (writeback?) the
> cache, as we're trying to get data from the device, not potentially
> overwrite the data that the device wrote because we have a dirty
> cacheline. Hmm. Then again, how could we possibly have a dirty
> cacheline?

So in my model, (1) is the only case where there's actively dirty data
that needs to be written back. That's the "CPU wrote the data to
memory, and wants to transfer it to the device" case.

In (2) and (3), the only question is whether possibly clean cachelines
contain - or will contain - stale data.

And then exactly when you actually invalidate is up to you.

For example, in

 (2) The CPU now wants to see any state written by the device

you have multiple options. You could invalidate any stale cache lines.

Or you could say "We wrote them back and invalidated them in (1), so
we don't need to invalidate them now".

And in

 (3) The CPU looked at the data while it was in flight and is now done with it.

you can (again) decide to do nothing at all, BUT ONLY IF (2) chose
that "invalidate" option. Because if you made your (2) depend on that
"they were already invalidated", then (3) has to invalidate the CPU
caches so that a subsequent (2) will work right.

So these are all somewhat interconnected.

You can do just "writeback" in (1), but then you _have_ to do
"invalidate" in (2), and in that case you don't have to do anything at
all in (3).

Or maybe your CPU only has that "writeback-and-invalidate" operation,
so you decide that (2) should be a no-op, and (3) - which is
presumably less common than (2) - also does that writeback-invalidate
thing.

Or we can also say that (3) is not allowed at all - so the ath9k case
is actively wrong and we should warn about that case - but that again
constrains what you can do in (2) and now that previous optimization
is not valid.

And it's worth noting that if your CPU may do cache fills as a result
of speculative accesses (or just sufficiently out of order), then the
whole argument that "I invalidated those lines earlier, so I don't
need to invalidate them now" is just garbage.

Fun, isn't it?

> Which starts to clarify in my mind why we have a sort of (implied)
> ownership model: if the CPU dirties a cacheline while the device has
> ownership then the cache writeback might overwrite the DMA data.

Right, I think that "if the CPU dirties the cacheline while the device
has ownership, then the data is going to be undefined".

And btw, it does actually potentially happen for real - imagine a user
mmap'ing the IO buffer while IO is in flight. The kernel can't control
for that (well, we can make things read-only, and some uses do), but
then it's often a question of "you have to dirty that area and do the
IO again, because the last attempt sent out undefined data".

And note how this "undefined data" situation can happen even with
coherent IO, so this part isn't even about cache coherency - it's
literally about just about memory accesses being in some undefined
order.

So it *can* be valid to send inconsistent data, but that should be
considered the really odd case.

> So it's
> easier to think of it as "CPU has ownership" and "device has ownership",
> but evidently that simple model breaks down in real-world cases such as
> ath9k where the CPU wants to look, but not write, and the device
> continues doing DMA at the same time.

Yeah, and see above about how the CPU could even write (but honestly,
that isn't valid in the general case, it really requires that kind of
active "we can fix it up later" thing).

> Well if you actually did dirty the cacheline, then you have a bug one
> way or the other, and it's going to be really hard to debug - either you
> lose the CPU write, or you lose the device write, there's no way you're
> not losing one of them?

Again, see above. Losing the CPU write is really bad, because then you
can't even recover by re-doing the operation.

So yes, when looking at only the "single operation" case, it looks
like "lose one or the other". But in the bigger picture, one is more
important than the other.

> So the operations
> (1) dma_sync_single_for_device(DMA_TO_DEVICE)
> (2) dma_sync_single_for_cpu(DMA_FROM_DEVICE)
> (3) dma_sync_single_for_device(DMA_FROM_DEVICE)
>
> really only (1) passes write ownership to the device, but then you can't
> get it back?

Well, you get it back by just checking that the IO is done. Once the
IO is done, the CPU owns the area again.

And the "IO is done" is often some entirely independent status in some
entirely different place.

But it *could* be something that requires a CPU read from that DMA
area. But it's a CPU _read_, so you don't need write ownership for
that.

That's why there is only one DMA_TO_DEVICE, and there are two
DMA_FROM_DEVICE cases.

The DMA_TO_DEVICE cannot have a "let me write in the middle" situation.

But the DMA_FROM_DEVICE has that "let me read in the middle, and
decide if it's done or not", so you can have a looping read, and
that's where (3) comes in.

You can't have a looping write for one operation (but you can
obviously have several independent write operations - that's what the
whole "are you done" is all about)

> But that cannot be true, because ath9k maps the buffer as
> DMA_BIDIRECTIONAL, and then eventually might want to recycle it.

See above. Both cases have "the device is done with this", but they
are fundamentally different situations.

> > That sounds really odd for
> > a "sync" operation. It sounds very reasonable for _allocating_ DMA,
> > but for syncing I'm left scratching my head what the semantics would
> > be.
>
> I agree.
>
> > But yes, if we do and people come up with semantics for it, those
> > semantics should be clearly documented.
>
> I'm not sure? I'm wondering if this isn't just because - like me
> initially - people misunderstood the direction argument, or didn't
> understand it well enough, and then just passed the same value as for
> the map()/unmap()?

Yeah, the solution may well be "grep for it, and pick the right
direction once the docs are clear".

             Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
