Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61517C433EF
	for <iommu@archiver.kernel.org>; Sun, 27 Mar 2022 05:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1D6E60D65;
	Sun, 27 Mar 2022 05:06:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5tdLnId4wqnj; Sun, 27 Mar 2022 05:06:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B816760B8F;
	Sun, 27 Mar 2022 05:06:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79803C001D;
	Sun, 27 Mar 2022 05:06:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74817C0012
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 05:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D6F14091E
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 05:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FiMbYVallWEL for <iommu@lists.linux-foundation.org>;
 Sun, 27 Mar 2022 05:06:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B71440919
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 05:06:37 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id bn33so15163462ljb.6
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4DsawngOkTaf1ffe3Djt9i8R04p2xlEj2LaUyWMHpLQ=;
 b=IL1j88A1zMmNQ619gkjkOLfevd4yJp/uUvy/JL+W394T7Ci9byh8r//w+swnF4uoTk
 MZxgdJEbG5E8/y/0RfpNKMtcmR1SxV+ftoqfImF3PZxALDLZgAsd0IabrARdiKS285Pw
 iUyVNk8ywuM4lUwh7TQ+LKc1DK3c/TGkrq11k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4DsawngOkTaf1ffe3Djt9i8R04p2xlEj2LaUyWMHpLQ=;
 b=OZbWsduGcl1B1fkS/sJHjUGFZcoA2rhAZFQ9psMWnx4E+r3jYXbfhPbfKqyIc5KDj2
 krVjNO2QHfgdmfZNWGuQ1WNnVIHddovtIHXh/tBlh7GPUOySFD++Cj6sl3g6Gp6V1yfL
 1awaXZ82LoKzPF0ejTXE6xpEnmic23ohM9rPvqFiqLA40g9y1fA26+mvxWhEHXdT21nf
 NIxtCXyd1tEKRwxojkzkM9/MF632v96EslyVzP9SMAQkOZ3YUCbm7NXl8E/Y0j+FlIO+
 euvggGuJXPQfzmp5BdQ4/HAAcaAj+LpCFvrHDlTbdU37DGaWGD9UjTUUwOqLHHFECvlg
 bWnQ==
X-Gm-Message-State: AOAM532nVhe+Ab2S86a5/SRj0ZFlKiu0jkAkPu7VD3JSKhiTVBk+S2T+
 ofoc8DmyPQ7MIGh0SUGZN2W/qlT9DU5Ri4S+daCgMQ==
X-Google-Smtp-Source: ABdhPJzmZMkBaspaxJt+Etfz2VgmpDownFr/2yGMOur29lthChYJLikay7fN+E21tFUzCSNftcnIkQ==
X-Received: by 2002:a05:651c:1a21:b0:249:8ccf:65eb with SMTP id
 by33-20020a05651c1a2100b002498ccf65ebmr14985345ljb.166.1648357594885; 
 Sat, 26 Mar 2022 22:06:34 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com.
 [209.85.167.41]) by smtp.gmail.com with ESMTPSA id
 u7-20020a2e1407000000b00247eb96ea13sm1252842ljd.131.2022.03.26.22.06.32
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Mar 2022 22:06:33 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id t25so19671246lfg.7
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:06:32 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr14244664lfh.687.1648357591941; Sat, 26
 Mar 2022 22:06:31 -0700 (PDT)
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
In-Reply-To: <20220327054848.1a545b12.pasic@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Mar 2022 22:06:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
Message-ID: <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
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

On Sat, Mar 26, 2022 at 8:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> I agree it CPU modified buffers *concurrently* with DMA can never work,
> and I believe the ownership model was conceived to prevent this
> situation.

But that just means that the "ownership" model is garbage, and cannot
handle this REAL LIFE situation.

Here's the deal: if somebody makes a model that is counter-factual,
you have exactly two choices:

 - fix the damn model

 - live in a la-la-land that isn't reality

Which choice do you pick?

And I'll be brutally honest: if you pick the la-la-land one, I don't
think we can really discuss this any more.

> But a CPU can modify the buffer *after* DMA has written to
> it, while the mapping is still alive.

Yes.

But you are making ALL your arguments based on that "ownership" model
that we now know is garbage.

If you make your arguments based on garbage, the end result _might_
work just by happenstance, but the arguments sure aren't very
convincing, are they?

So let's make it really clear that the arguments must not be based on
some "ownership" model that you just admitted cannot handle the very
real case of real and common hardware.

Ok?

>  For example one could do one
> partial read from the device, *after* the DMA is done,
> sync_for_cpu(DMA_FROM_DEVICE), examine, then zero out the entire buffer,
> sync_for_device(DMA_FROM_DEVICE)

So the result you want to get to I can believe in, but your sequence
of getting there is untenable, since it depends on breaking other
cases that are more important than your utterly broken hardware that
you don't even know how much data it filled.

And I fundamentally also happen to think that since the CPU just wrote
that buffer, and *that* write is what you want to sync with the
device, then that DMA_FROM_DEVICE was just pure fantasy to begin with.

So that code sequence you quote is wrong. You are literally trying to
re-introduce the semantics that we already know broke the ath9k
driver.

Instead, let me give you a couple of alternative scenarios.

Alternative 1:

 - ok, so the CPU wrote zeroes to the area, and we want to tell the
DMA mapping code that it needs to make that CPU write visible to the
device.

 - Ahh, you mean "sync_for_device(DMA_TO_DEVICE)"?

 - Yes.

   The "for_device()" tells us that afterwards, the device can access
the memory (we synced it for the device).

   And the DMA_TO_DEVICE tells us that we're transferring the zeroes
we wrote on the CPU to the device bounce buffer.

   Now the device got those zeroes, and it can overwrite them
(partially), and everything is fine

 - And then we need to use "sync_for_cpu(DMA_FROM_DEVICE)" when we
want to see the result once it's all done?

 - Yes.

 - Splendid. Except I don't like how you mix DMA_TO_DEVICE and
DMA_FROM_DEVICE and you made the dma_alloc() not use DMA_BIDIRECTIONAL

 - Yeah, that's ugly, but it matches reality, and it would "just work" today.

Alternative 2:

 - Ok, so the CPU doesn't even want to write to the area AT ALL, but
we know we have a broken device that might not fill all of the bounce
buffer, and we don't want to see old stale bounce buffer contents that
could come from some other operation entirely and leak sensitive data
that wasn't for us.

 - Ahh, so you really want to just clear the bounce buffer before IO?

 - Yes. So let's introduce a "clear_bounce_buffer()" operation before
starting DMA. Let's call it "sync_for_device(DMA_NONE)" and teach the
non-bounce-buffer dmas mapping entities to just ignore it, because
they don't have a bounce buffer that can contain stale data.

 - Sounds good.

Alternative 3:

 - Ok, you have me stumped. I can't come up with something else sane.

Anyway, notice what's common about these alternatives? They are based
not on some "we have a broken model", but on trying to solve the
actual real-life problem case.

I'm more than happy to hear other alternatives.

But the alternative I am _not_ willing to entertain is "Yeah, we have
a model of ownership, and that can't handle ath9k because that one
wants to do CPU reads while DMA is possibly active, so ath9k is
broken".

Can we please agree on that?

                          Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
