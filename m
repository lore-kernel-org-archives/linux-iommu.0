Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2BFC433F5
	for <iommu@archiver.kernel.org>; Sun, 27 Mar 2022 05:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 095514025D;
	Sun, 27 Mar 2022 05:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1yLSVhsnUk-g; Sun, 27 Mar 2022 05:21:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6E74540025;
	Sun, 27 Mar 2022 05:21:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E4D6C002C;
	Sun, 27 Mar 2022 05:21:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8965EC0012
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 05:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E6C0409F9
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 05:21:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q1zOvZvNu4DC for <iommu@lists.linux-foundation.org>;
 Sun, 27 Mar 2022 05:21:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98323409F8
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 05:21:24 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id m3so19670602lfj.11
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3AIrmmPfx/ZOrHBctYZwCCwGfAaK/1/IH4psZd3wsUE=;
 b=djCcgOaCULO1J4pux52MUZuwiPblxKGguZJ9FLwYib2dSNo188P6jyJlcS/Z3+Vjqp
 NuxHz+nULM3zYzdCDc/LCticaRTrzP6Eu8i5lYrUz9D+Qn4hFWHokDkpiq4ZgcyhM3fv
 2VMFEP6rvt3FcDITehwTGDWmAXZRTRWN+Beak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3AIrmmPfx/ZOrHBctYZwCCwGfAaK/1/IH4psZd3wsUE=;
 b=E0BT9IW7zIYSp5OdkVxtJOi9Z1plktlOgWg1bFKTFMU9cxwd0I38Niasx+eRywRfbT
 7kzH1eeqouV0yXmLHOCKGu8DcXc8bmwdXyrZlRrzrDhdvQmSrvxRm4Jou0Z8cV9r6mVi
 0hLVdZIwKpaXgDBpeXQPt8MjOK++72TQwFyX2iXa5VkFM4M7Jz8vSpJiweR45ZSwsnuW
 zcHqCVWB05d/bttT0/tyTM/LML6Q/ovNS8ReoHpV31cBQszlnh3YMxohGMnxWsgyOLvB
 wlYJ5Kwo9LHqrxzs7SWKs29k7yCvqsrlK1B8Q+ORO+FOnSFRdoxjcx+u1sh7C0OyUErx
 LzhQ==
X-Gm-Message-State: AOAM530W3QJpAeCZqKj5q4vQ7CZlIuB7tz4WbVawQ9tWJlpdoFlm5OPt
 INgYrIsIY17ELQgGzy6BdDX/tNuYh9rN2G2yBjYD5A==
X-Google-Smtp-Source: ABdhPJziv3co30WCPiBT+uaN+QLeKnRNZwUVYyuM8uy9LrXmyZYxjA8bvbraUFj7EWZaRp3W3BZcPg==
X-Received: by 2002:ac2:5dd5:0:b0:44a:581c:dda5 with SMTP id
 x21-20020ac25dd5000000b0044a581cdda5mr14435150lfq.344.1648358482276; 
 Sat, 26 Mar 2022 22:21:22 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com.
 [209.85.208.175]) by smtp.gmail.com with ESMTPSA id
 f1-20020a2e1f01000000b0024602522b5dsm1246103ljf.120.2022.03.26.22.21.19
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Mar 2022 22:21:20 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id a30so7709308ljq.13
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:21:19 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr14918936ljc.506.1648358479393; Sat, 26
 Mar 2022 22:21:19 -0700 (PDT)
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
In-Reply-To: <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Mar 2022 22:21:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUx5CVF_1aEkhhEiRGXHgKzUdKiyctBKcHAxkxPpbiaw@mail.gmail.com>
Message-ID: <CAHk-=wgUx5CVF_1aEkhhEiRGXHgKzUdKiyctBKcHAxkxPpbiaw@mail.gmail.com>
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

On Sat, Mar 26, 2022 at 10:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Mar 26, 2022 at 8:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> >
> > I agree it CPU modified buffers *concurrently* with DMA can never work,
> > and I believe the ownership model was conceived to prevent this
> > situation.
>
> But that just means that the "ownership" model is garbage, and cannot
> handle this REAL LIFE situation.

Just to clarify: I obviously agree that the "both sides modify
concurrently" obviously cannot work with bounce buffers.

People still do want to do that, but they'll limit themselves to
actual cache-coherent DMA when they do so (or do nasty uncached
accesses but at least no bounce buffering).

But the "bounce ownership back and forth" model comes up empty when
the CPU wants to read while the DMA is still going on. And that not
only can work, but *has* worked.

You could have a new "get me a non-ownership copy" operation of
course, but that hits the problem of "which existing drivers need it?"

We have no idea, outside of ath9k.

This is why I believe we have to keep the existing semantics in a way
that keep ath9k - and any number of unknown other drivers - happy.

And then for the cases where you want to introduce the zeroing because
you don't know how much data the DMA returned - those are the ones
you'll have to mark some way.

                  Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
