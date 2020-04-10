Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FD4C2BB86
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 08:11:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBB320753
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 08:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dFrk5z2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBB320753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 375612051C;
	Fri, 10 Apr 2020 08:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6FawX1Qho8ay; Fri, 10 Apr 2020 08:11:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 646B120488;
	Fri, 10 Apr 2020 08:11:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41BA1C089F;
	Fri, 10 Apr 2020 08:11:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F23D3C0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 08:11:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E980886A94
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 08:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ORI6rOXce4wi for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 08:11:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4BC0086081
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 08:11:14 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id n25so1165151otr.10
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hgf3DAUC4/KD19F9Gq5AGfjZOzS9LXWN/bbu/vFg+qA=;
 b=dFrk5z2BtMEmisYXExkZBismSlsWb5Q4k/3n94YDOvTZuh2CzIpH/i8KoNWzlv4bXk
 /+Bzn+RqlG2O4N1iciPqbf359lmAxRrY7woQmtsWzKRq9DFPU3AhxhJ6V+T7GDyl1tRC
 5xNRsfm5urzQ2GX3QtuJdU9JR4uI52qA4fFG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hgf3DAUC4/KD19F9Gq5AGfjZOzS9LXWN/bbu/vFg+qA=;
 b=ZSlRe1wDtIpEw24oJMyKZHwdlim0KmKsPM8jbUYSl6O6qCEroLiVEDkEjv/zTmxr/k
 St0vCEKQ/JwRZ7zv8VumRhLk1LWZuVQHlNudIvDG/4sjE+j6f/Prn3uDJsxTFLAru99v
 PhpXNWXUmQ/AEIVgvFRrt+AvZaGjr0cA0WY/jThkZeOMza0YZHs9YuTGkPgWXiIb2dIF
 H9IOtM3yyRHABUzW84J7bc+Rk/Do3XnwbA1HAiMsm54WcnNskjZr2jcpj9l2K55uZpem
 ls4/6d3RRQYKj08c6s/ffvEqEgNeiO9wTjO7BAeO1cfCKr8AyUyBT0Rbjf3g6jHjMNqP
 DMvg==
X-Gm-Message-State: AGi0PubB7s55M+fP/YNkhKxOFMw6Tx9uzmkSRJL512uCNkBSto4aSKCU
 wyDbll93Y23VEjL88icpkn/yRAheO7WfpoYFvMHdwg==
X-Google-Smtp-Source: APiQypJumpZ6N8vscDAXJtrZPRakBWDA3qYtIErOA5tqj0XblmFZSMuMiwpkQHsTVZs7vae7PdjUGGhKyrX4Ng8eQNQ=
X-Received: by 2002:a9d:6e8f:: with SMTP id a15mr3449972otr.188.1586506273249; 
 Fri, 10 Apr 2020 01:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-20-hch@lst.de>
 <20200408122504.GO3456981@phenom.ffwll.local>
 <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
 <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
 <0f360b9cb72b80bae0d0db8150f65598c2776268.camel@kernel.crashing.org>
In-Reply-To: <0f360b9cb72b80bae0d0db8150f65598c2776268.camel@kernel.crashing.org>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 10 Apr 2020 10:11:02 +0200
Message-ID: <CAKMK7uHKyN+c5oTEYVursx4at9br7LSXRb8PMoNEAEBh0hfBLQ@mail.gmail.com>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in
 drm_legacy_sg_alloc
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>,
 linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, X86 ML <x86@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 bpf <bpf@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Minchan Kim <minchan@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Fri, Apr 10, 2020 at 12:57 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Thu, 2020-04-09 at 11:41 +0200, Daniel Vetter wrote:
> > Now if these boxes didn't ever have agp then I think we can get away
> > with deleting this, since we've already deleted the legacy radeon
> > driver. And that one used vmalloc for everything. The new kms one does
> > use the dma-api if the gpu isn't connected through agp
>
> Definitely no AGP there.

Ah in that case I think we can be sure that this code is dead.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
