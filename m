Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05694C48BE0
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 16:01:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C9261404
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 16:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C9261404
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF3B5415D4;
	Fri, 11 Jun 2021 16:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kNAHytaBfrNP; Fri, 11 Jun 2021 16:01:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F226415D6;
	Fri, 11 Jun 2021 16:01:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9B4AC000E;
	Fri, 11 Jun 2021 16:01:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E84DC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE5E8415D4
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XcxHpy-NvGv7 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 16:01:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8255B415D3
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:01:34 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id j20so9258659lfe.8
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8cTgYop9NFZ0qyAjdKFalLsNoJbK6hVndemtwl7l5Ok=;
 b=JI+g1YiYzhV06je+UJHtI4hG3GnxkuzxgymgJDwaeWA6WGD2qXUyRj1NOBlwnKuyTd
 NaPkND+luK7G0qt+yz8ypcgXRq7rKjgstB/RCNkCODwAPj1YApFLufh5S0QBvekiKtX5
 97Nw+Lmo2DmelofysTIDQKdXUYR22ffH2MAzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8cTgYop9NFZ0qyAjdKFalLsNoJbK6hVndemtwl7l5Ok=;
 b=rblS6IVdvoWeW4td61ZdywNeXXgWghcOHxD+AU07+WzsHS4ZdrlDS7z7AvnImalO7Q
 J/2Zeh9gyvKF2FpJ2dwFUDYMy4b+/BnajcNvgYqrIY14w3g1GXI8NfcVS0vKt2ferDb0
 9JMXmEWwfOuxu1OAZH8aKKjgAhgiNCdkNHqHB+SBi5Dfk0fGFGVVJmJ/Ezt8TUcdr0lg
 Ut8IH6PpMgT8FQuZoqKNL+vCzRtJzRn5h72C/dBA2XeDtPCmR4CH2SckHtKA8Pf6Izgy
 YzZcCVqZo0OGpN5HaciIbJXNwjRoMoRArjfbitKXPfVKII5iurdx7KbsDCRG/Cz4yfhO
 oqpA==
X-Gm-Message-State: AOAM530zj0nqAGKBXJWkUWIPXw+fkvJrkeVErnpMOwP1Vgij5tg1iLkp
 N9+aIn9vcXh9lBaSp6WhGE1WL6YXoeFsmU+1HZCdgg==
X-Google-Smtp-Source: ABdhPJyXhQeTgkpQjMSA3OrP8r6eWR+igkEwJjfcAS/GWD38fS8Hu8NRZavcQtqCV27De/wza0wFMQ==
X-Received: by 2002:a19:4cd7:: with SMTP id z206mr2958671lfa.414.1623427290574; 
 Fri, 11 Jun 2021 09:01:30 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50])
 by smtp.gmail.com with ESMTPSA id y24sm772276lje.138.2021.06.11.09.01.22
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 09:01:25 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id r198so9254742lff.11
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 09:01:22 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr2952000lfc.201.1623427281920; 
 Fri, 11 Jun 2021 09:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
 <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com> <20210611062153.GA30906@lst.de>
In-Reply-To: <20210611062153.GA30906@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jun 2021 09:01:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh70m5dYtJcoc3TQtJSp0+AHTuXZM=raBXQVW9CJKG5ng@mail.gmail.com>
Message-ID: <CAHk-=wh70m5dYtJcoc3TQtJSp0+AHTuXZM=raBXQVW9CJKG5ng@mail.gmail.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
To: Christoph Hellwig <hch@lst.de>
Cc: Dominique MARTINET <dominique.martinet@atmark-techno.com>,
 Aymen Sghaier <aymen.sghaier@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Lukas Hartmann <lukas@mntmn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jianxiong Gao <jxgao@google.com>
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

On Thu, Jun 10, 2021 at 11:21 PM Christoph Hellwig <hch@lst.de> wrote:
>
> FYI, there has been a patch on the list that should have fixed this
> for about a month:
>
> https://lore.kernel.org/linux-iommu/20210510091816.GA2084@lst.de/T/#m0d0df6490350a08dcc24c9086c8edc165b402d6f

Honestly, that patch is all kinds of strange.

This expression:

    tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
        swiotlb_align_offset(dev, orig_addr);

makes no sense to me. Maybe it happens to work, but I think it does so
by mistake rather than by design.

What my patch used was:

    unsigned long offset = (tlb_addr - mem->start) & (IO_TLB_SIZE - 1);

which actually pairs with - and makes sense with - the index calculation:

    int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;

so that offset truly is the offset within that index. Look at how that
'index' calculation calculates the high bits of the difference, and
the 'offset' calculation now literally is the low bits of the same
thing that got dropped on the floor by the 'index' calculation?

So those two calculations actually make sense. The
swiotlb_align_offset() one doesn't.

It's possible that that swiotlb_align_offset() function ends up giving
the right answer just almost by mistake (because of how tlb_addr and
orig_addr end up being related - the swiotlb_align_offset() expression
might just end up being the same thing - I didn't look deeper), but
even if the result is the same, it's not _sensible_ code,

It's also possible that the swiotlb_align_offset() function ends up
giving the right answer very much by design and because of how
orig_addr works - because maybe the remapping is doing odd things and
using that swiotlb_align_offset() function in ways that make the
*obvious* and natural offset calculation not actually work.

So it's at least in theory possible that my "natural offset"
calculation that matches how the index is calculated doesn't actually
work. But that means that the swiotlb remapping is doing some really
odd things, and then I think the patch would need a lot more
commentary on exactly what those very odd things are.

            Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
