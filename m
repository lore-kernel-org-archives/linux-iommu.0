Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D2DC433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 00:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E9AB60F8E;
	Mon, 28 Mar 2022 00:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8TNePUuoUbH; Mon, 28 Mar 2022 00:30:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E265B60F18;
	Mon, 28 Mar 2022 00:30:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A731FC001D;
	Mon, 28 Mar 2022 00:30:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70E40C0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 00:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B119408B6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 00:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R1yOwl8j3QM7 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 00:30:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F2A84087B
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 00:30:23 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id t25so22076922lfg.7
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 17:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LsBHPoKRCtwDOMc2JT/S0rILfVAOjOsIUEg1vfmMk0I=;
 b=KTuL8s82i3Mk75qC61EFLCdxdodMcKaC6rZIGrZq6pH27ySo4Ut4D253RZhCx2Apft
 KLydbkrKIkIu40UMY0bDeeXNtbHp0U0TEYaRj4iCgCkdnXvAOxzWT119PcO/nwUvO8MP
 RszsIWAmBGdjtyiwR7qPFzhdNHOMzILrN1FLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LsBHPoKRCtwDOMc2JT/S0rILfVAOjOsIUEg1vfmMk0I=;
 b=67duJfP2ymeADrqM7J5pbAC5c3NM9n+FPYtqQOVvKfHTUjiB1RbydBDcPsRn+GOEM/
 B2B5EcWaQHLducE+IqPnjcoo+eVu9AALpKne0AW6iBleMmX6eVA71TU8rZ/sSAf58UEx
 q4kMoQ7kSc0z+kC4U0HKM3RGHYre+ImNrJ7Iqp5hRqSNw12W+Yh/bON05Sn/aMsHgCoO
 AwDLOOzFGStjfZrCe93Hhy1p+2xaqfNcSprdPehYx78joN1VTFWqi7Hoe8/bfj2HuObt
 LDFQbtxY97BIJdZ42rgM4srSTDxnzPuVZUNRvL9b+2KNoUxGYVQWlQ519XerL/bqoXiJ
 R+yw==
X-Gm-Message-State: AOAM530ALKFU5RG19ZYjHhiEHHe8o5xx6Cy1fCia6gLm5oCN9eqOxyUQ
 j0jHJ85ZTqByS8YhYVFw4hxUa9mFVqHVrO/OJVKPLw==
X-Google-Smtp-Source: ABdhPJwAz0wekLr4cyL28PPWsV7UUSgpn/rjf6UyvX8ucu0Sk4dcLL8Lai+iIgZ55sHmKCqVZ35z8g==
X-Received: by 2002:a05:6512:3a6:b0:44a:120d:370d with SMTP id
 v6-20020a05651203a600b0044a120d370dmr17502953lfp.437.1648427421421; 
 Sun, 27 Mar 2022 17:30:21 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182]) by smtp.gmail.com with ESMTPSA id
 r20-20020a2e5754000000b002480655267dsm1491888ljd.67.2022.03.27.17.30.18
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Mar 2022 17:30:20 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id bn33so17112244ljb.6
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 17:30:18 -0700 (PDT)
X-Received: by 2002:a2e:a549:0:b0:249:9ec3:f2b with SMTP id
 e9-20020a2ea549000000b002499ec30f2bmr4449509ljn.358.1648427417735; Sun, 27
 Mar 2022 17:30:17 -0700 (PDT)
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
 <20220328015211.296739a4.pasic@linux.ibm.com>
In-Reply-To: <20220328015211.296739a4.pasic@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Mar 2022 17:30:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whK3z5O4G55cOb2JYgwisb4cpDK=qhM=0CfmCC8PD+xMQ@mail.gmail.com>
Message-ID: <CAHk-=whK3z5O4G55cOb2JYgwisb4cpDK=qhM=0CfmCC8PD+xMQ@mail.gmail.com>
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

On Sun, Mar 27, 2022 at 4:52 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> I have no intention of pursuing this.  When fixing the information leak,
> I happened to realize, that a somewhat similar situation can emerge when
> mappings are reused. It seemed like an easy fix, so I asked the swiotlb
> maintainers, and they agreed. It ain't my field of expertise, and the
> drivers I'm interested in don't need this functionality.

Ok.

That said, I think you are putting yourself down when you said in an
earlier email that you aren't veryt knowledgeable in this area.

I think the fact that you *did* think of this other similar situation
is actually very interesting, and it's something people probably
_haven't_ been thinking about.

So I think your first commit fixes the straightforward and common case
where you do that "map / partial dma / unmap" case.

And that straightforward case is probably all that the disk IO case
ever really triggers, which is presumably why those "drivers I'm
interested in don't need this functionality" don't need anything else?

And yes, your second commit didn't work, but hey, whatever. The whole
"multiple operations on the same double buffering allocation"
situation is something I don't think people have necessarily thought
about enough.

And by that I don't mean you. I mean very much the whole history of
our dma mapping code.

I then get opinionated and probably too forceful, but please don't
take it as being about you - it's about just my frustration with that
code - and if it comes off too negative then please accept my
apologies.

          Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
