Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C70BECE58D
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 15:08:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AA920B7C
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 15:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ifDZMaGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AA920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E9E1DF81;
	Wed,  9 Oct 2019 15:08:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B0738C51
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 15:08:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 76C4381A
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 15:08:53 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id l21so2360572edr.5
	for <iommu@lists.linux-foundation.org>;
	Wed, 09 Oct 2019 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=4dVOT/zwpO/iVlKT34i6lLt8un5vjwtrCBmaYK+BcfI=;
	b=ifDZMaGbzZ5zS8oLCskFTxsRDRy0vcmM6IDugkmp5x82gdumWWGf6drBBSbP2zXj1X
	keZnbytz7jKV9Bc7Px0ObzoVxcVnraGGKYROf0qAcLNCkS7CrVkbKcLA6O1VtlsCeaNB
	k//x58dAPebQUDYg1zX1dmiP1ryeq3hqRi88I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=4dVOT/zwpO/iVlKT34i6lLt8un5vjwtrCBmaYK+BcfI=;
	b=Le1aYa321T71THTx1NsgiXVy3srJBJNMkqvQiWmh4Q27lvfjZOSXQnYjVyOaIJwYrd
	BVae69z+1LEAEV7rGQG8MrNDiato6owunmwZcMEGTLGJ1sqVRU/FpgCf9YrR4UNEGSFq
	CKbOTU/4fghtWqy0sX99PtGoQeuzS8FbkzfZncJVcqBnS9aTr7yjIZ60p+nosv62rLUk
	Qxga1H6K3MV/c9bvQDuQBBeRZos1jgpx3S+nXzMRQGT6dJT92BISaQTyri+JWnoTDGqw
	gygYvf4sQFwBhzISCU4/65sjl5z4B8z4Z18Jpda4TTF2RxlqjER+PAZWawJhwGl2jER5
	tvYg==
X-Gm-Message-State: APjAAAWPFtoedivlY62DOfQz8ynNPcsqHyznNv8O7jIshviOXZFVfTFw
	oRPIzRr8j94gugLy2i/1mvWXLhzVH/AiMQ==
X-Google-Smtp-Source: APXvYqyvZI41FZtxLuOCVKd+WlkA/isgALbU2Kqy7sAl1Y9+11gopL6cGxFd8cwc3JhWz87IPMYPSQ==
X-Received: by 2002:aa7:c595:: with SMTP id g21mr3416639edq.79.1570633731705; 
	Wed, 09 Oct 2019 08:08:51 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com.
	[209.85.128.51]) by smtp.gmail.com with ESMTPSA id
	rk18sm286271ejb.64.2019.10.09.08.08.49
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Wed, 09 Oct 2019 08:08:50 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id r19so3045726wmh.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 09 Oct 2019 08:08:49 -0700 (PDT)
X-Received: by 2002:a1c:dcd6:: with SMTP id t205mr3094517wmg.10.1570633728709; 
	Wed, 09 Oct 2019 08:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5C+FM3n-Ww4C+qDD1QZOGZrqEYw4EvYECfadGcDH0fmew@mail.gmail.com>
	<1570522162.19130.38.camel@mhfsdcap03>
	<CAAFQd5C3U7pZo4SSUJ52Q7E+0FaUoORQFbQC5RhCHBhi=NFYTw@mail.gmail.com>
	<1570628307.19130.53.camel@mhfsdcap03>
In-Reply-To: <1570628307.19130.53.camel@mhfsdcap03>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 10 Oct 2019 00:08:37 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Aj-DDofzQ1vyKT9OcXpf-Udfx4zeWtVGcQf7S-o+mStQ@mail.gmail.com>
Message-ID: <CAAFQd5Aj-DDofzQ1vyKT9OcXpf-Udfx4zeWtVGcQf7S-o+mStQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/mediatek: Move the tlb_sync into tlb_flush
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream <srv_heupstream@mediatek.com>,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	"moderated list:ARM/Mediatek SoC support"
	<linux-mediatek@lists.infradead.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Oct 9, 2019 at 10:38 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2019-10-09 at 16:56 +0900, Tomasz Figa wrote:
> > On Tue, Oct 8, 2019 at 5:09 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > Hi Tomasz,
> > >
> > > Sorry for reply late.
> > >
> > > On Wed, 2019-10-02 at 14:18 +0900, Tomasz Figa wrote:
> > > > Hi Yong,
> > > >
> > > > On Mon, Sep 30, 2019 at 2:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > > > >
> > > > > The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
> > > > > TLB sync") help move the tlb_sync of unmap from v7s into the iommu
> > > > > framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
> > > > > lacked the dom->pgtlock, then it will cause the variable
> > > > > "tlb_flush_active" may be changed unexpectedly, we could see this warning
> > > > > log randomly:
> > > > >
> > > >
> > > > Thanks for the patch! Please see my comments inline.
> > > >
> > > > > mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
> > > > > full flush
> > > > >
> > > > > To fix this issue, we can add dom->pgtlock in the "mtk_iommu_iotlb_sync".
> > > > > And when checking this issue, we find that __arm_v7s_unmap call
> > > > > io_pgtable_tlb_add_flush consecutively when it is supersection/largepage,
> > > > > this also is potential unsafe for us. There is no tlb flush queue in the
> > > > > MediaTek M4U HW. The HW always expect the tlb_flush/tlb_sync one by one.
> > > > > If v7s don't always gurarantee the sequence, Thus, In this patch I move
> > > > > the tlb_sync into tlb_flush(also rename the function deleting "_nosync").
> > > > > and we don't care if it is leaf, rearrange the callback functions. Also,
> > > > > the tlb flush/sync was already finished in v7s, then iotlb_sync and
> > > > > iotlb_sync_all is unnecessary.
> > > >
> > > > Performance-wise, we could do much better. Instead of synchronously
> > > > syncing at the end of mtk_iommu_tlb_add_flush(), we could sync at the
> > > > beginning, if there was any previous flush still pending. We would
> > > > also have to keep the .iotlb_sync() callback, to take care of waiting
> > > > for the last flush. That would allow better pipelining with CPU in
> > > > cases like this:
> > > >
> > > > for (all pages in range) {
> > > >    change page table();
> > > >    flush();
> > > > }
> > > >
> > > > "change page table()" could execute while the IOMMU is flushing the
> > > > previous change.
> > >
> > > Do you mean adding a new tlb_sync before tlb_flush_no_sync, like below:
> > >
> > > mtk_iommu_tlb_add_flush_nosync {
> > >    + mtk_iommu_tlb_sync();
> > >    tlb_flush_no_sync();
> > >    data->tlb_flush_active = true;
> > > }
> > >
> > > mtk_iommu_tlb_sync {
> > >         if (!data->tlb_flush_active)
> > >                 return;
> > >         tlb_sync();
> > >         data->tlb_flush_active = false;
> > > }
> > >
> > > This way look improve the flow, But adjusting the flow is not the root
> > > cause of this issue. the problem is "data->tlb_flush_active" may be
> > > changed from mtk_iommu_iotlb_sync which don't have a dom->pglock.
> >
> > That was not the only problem with existing code. Existing code also
> > assumed that add_flush and sync always go in pairs, but that's not
> > true.
>
> Yes. Thus I put the tlb_flush always followed by tlb_sync to make sure
> they always go in pairs.
>
> >
> > My suggestion is to fix the locking in the driver and keep the sync
> > deferred as much as possible, so that performance is not degraded. I
>
> I really didn't get this timeout warning log in previous kernel(Many
> tlb_flush followed by one tlb_sync),

Locking issues typically lead to timing problems (race conditions), so
it might just be that the sequence or timing of calls changed between
kernel versions, enough to trigger the issue.

> But deferring the sync is not
> suggested by our DE, thus I still would like to fix the sequence in this
> patch with putting them together.
>

What's the reason it's not suggested? From my understanding, there
shouldn't be any dependency on hardware design here, it's just a
simple software optimization - we can pipeline other CPU operations
while the IOMMU is flushing the TLB.

Basically, right now:

CPU writes page tables 1
IOMMU flushes 1 | CPU busy waits
CPU writes page tables 2
IOMMU flushes 2 | CPU busy waits
CPU writes page tables 3
IOMMU flushes 3 | CPU busy waits
...

With my suggestion that could be:

CPU writes page tables 1 I
IOMMU flushes 1 | CPU writes page tables 2
IOMMU flushes 1 | CPU busy waits less time
IOMMU flushes 2 | CPU writes page tables 3
IOMMU flushes 2 | CPU busy waits less time
IOMMU flushes 3 | CPU busy waits

It reduces the time the CPU spends on busy waiting rather than doing
something useful. It also reduces the total time of maps and unmaps.

Actually, we can optimize even more. Please consider the case below.

CPU writes PTE for IOVA 0x1000.
IOMMU flushes 0x1000 | CPU busy waits
CPU writes PTE for IOVA 0x2000.
IOMMU flushes 0x2000 | CPU busy waits
CPU writes PTE for IOVA 0x3000.
IOMMU flushes 0x3000 | CPU busy waits
CPU writes PTE for IOVA 0x8000.
IOMMU flushes 0x8000 | CPU busy waits

However, depending on the way the hardware implements TLB flush, the
optimal sequence of operations could be:

CPU writes PTE for IOVA 0x1000.
CPU writes PTE for IOVA 0x2000.
CPU writes PTE for IOVA 0x3000.
IOMMU flushes 0x1000-0x3000 | CPU writes PTE for IOVA 0x8000.
IOMMU flushes 0x1000-0x3000 | CPU busy waits remaining flush time.
IOMMU flushes 0x8000 | CPU busy waits.

What's the algorithmic complexity of the TLB flush operation on
MediaTek IOMMU? If N is the number of pages to flush, is it O(N), O(1)
or something else?

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
