Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B5AC2D0CE
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 17:22:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63914206A2
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 17:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ5Ozt/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63914206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 26F6C20016;
	Tue, 21 Jan 2020 17:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UhjGZzEMpIAt; Tue, 21 Jan 2020 17:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B8E662010E;
	Tue, 21 Jan 2020 17:22:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85680C1D80;
	Tue, 21 Jan 2020 17:22:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2172C0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 17:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D0A0F84F80
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 17:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MB0VObVo65Tf for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 17:22:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5D58484D42
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 17:22:03 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id 66so3616190otd.9
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lnnBSB/7F1DqkynwG4soN8UnncCnmRgHmiv4BugYM2Q=;
 b=aJ5Ozt/WoQVqWBg9nszl7nn+QO8qzJ7/0SYJdKIz39o4evxGwkmBpJzx0F02Z6n4TJ
 sA0EU/u73T/YZ8Hd3xsyhAu7nO6kP6arcnO8C4t1Aa4hRaprAC7PZ7M+AX2wNMLW1IDl
 Kga1/wlYwkF7ClEuvlfyBYX0EprNOCvkIXyuakIjFrgGQROA0adWbDS3wbyiRHxOjajA
 eQUnWDQ6kY5KdiLjBsd8Jd1lGJSaQ8t6y9z08JXrAruSFBYukOSxRj0wR9gBTLIXRD/J
 CzkExcAGMl3vty7AL/ANv0XP7ZgQcJsA4z3i7RcoSTTg+Yr2Y9WapiUc6KSpEtqjXKLd
 TvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lnnBSB/7F1DqkynwG4soN8UnncCnmRgHmiv4BugYM2Q=;
 b=ueYM46kuiHPjr+QPBuqs2jIX8Wi2Evfy2flvACOzExcf06U4ObQN8HNb1ntjx1IqV4
 QmKGTsRKtwrZO/YgcYYtzs0EYjsu+8MJzTVaiDOrh9Gn+J9pYZBRXNs12TlJ8tr12yi4
 napvR5y3dsbOK6cdApLJhv3cLSebfw2//Zk31gPgpZhxGu/QE+QHn17iNp8HKFNUUiB8
 ti5wqtPjZTDs6aQCO8XTKF6fAvDBqICxc7m9r2arHi5/UFjgXifXwLCnjELi/BTOY8w2
 Y0AG1t96Sisxjn72Znnax5FwqoZdR23n9YestspUEJ3AHhgiDjQ3mUKjxcUm3BEKfM0b
 ZWrQ==
X-Gm-Message-State: APjAAAWXa9FOE6Hhq57U2bKHrkJcGfgTEsXYOSdd+zb51MmzlKeRE5AB
 8+hwMVZ28ogNCl/CYsPzDfsZEmBEtf1zyACCyPQ=
X-Google-Smtp-Source: APXvYqxhSdmxZTm2RkROSVHhkFHYy/2nkaycOk6cWKNZai7VHc/dUdyL6kgV25LWnepB+Y6eUl58p7ECVzy8LpTzV9c=
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr4630029oth.48.1579627322449;
 Tue, 21 Jan 2020 09:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-2-xiyou.wangcong@gmail.com>
 <db1c7741-e280-7930-1659-2ca43e8aac15@arm.com>
In-Reply-To: <db1c7741-e280-7930-1659-2ca43e8aac15@arm.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 21 Jan 2020 09:21:50 -0800
Message-ID: <CAM_iQpUmRKfiQ-P3G-PkRuumXqxN4TPuZtuqoT3+AFjhnkSwQQ@mail.gmail.com>
Subject: Re: [Patch v3 1/3] iommu: avoid unnecessary magazine allocations
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jan 21, 2020 at 3:11 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 18/12/2019 4:39 am, Cong Wang wrote:
> > The IOVA cache algorithm implemented in IOMMU code does not
> > exactly match the original algorithm described in the paper
> > "Magazines and Vmem: Extending the Slab Allocator to Many
> > CPUs and Arbitrary Resources".
> >
> > Particularly, it doesn't need to free the loaded empty magazine
> > when trying to put it back to global depot. To make it work, we
> > have to pre-allocate magazines in the depot and only recycle them
> > when all of them are full.
> >
> > Before this patch, rcache->depot[] contains either full or
> > freed entries, after this patch, it contains either full or
> > empty (but allocated) entries.
>
> How much additional memory overhead does this impose (particularly on
> systems that may have many domains mostly used for large, long-term
> mappings)? I'm wary that trying to micro-optimise for the "churn network
> packets as fast as possible" case may penalise every other case,
> potentially quite badly. Lower-end embedded systems are using IOMMUs in
> front of their GPUs, video codecs, etc. precisely because they *don't*
> have much memory to spare (and thus need to scrape together large
> buffers out of whatever pages they can find).

The calculation is not complicated: 32 * 6 * 129 * 8 = 198144 bytes,
which is roughly 192K, per domain.

>
> But on the other hand, if we were to go down this route, then why is
> there any dynamic allocation/freeing left at all? Once both the depot
> and the rcaches are preallocated, then AFAICS it would make more sense
> to rework the overflow case in __iova_rcache_insert() to just free the
> IOVAs and swap the empty mag around rather than destroying and
> recreating it entirely.

It's due to the algorithm requires a swap(), which can't be done with
statically allocated magzine. I had the same thought initially but gave it
up quickly when realized this.

If you are suggesting to change the algorithm, it is not a goal of this
patchset. I do have plan to search for a better algorithm as the IOMMU
performance still sucks (comparing to no IOMMU) after this patchset,
but once again, I do not want to change it in this patchset.

(My ultimate goal is to find a spinlock-free algorithm, otherwise there is
no way to make it close to no-IOMMU performance.)

>
> Perhaps there's a reasonable compromise wherein we don't preallocate,
> but still 'free' empty magazines back to the depot, such that busy
> domains will quickly reach a steady-state. In fact, having now dug up
> the paper at this point of writing this reply, that appears to be what
> fig. 3.1b describes anyway - I don't see any mention of preallocating
> the depot.

That paper missed a lot of things, it doesn't even recommend a size
of a depot or percpu cache. For implementation, we still have to
think about those details, including whether to preallocate memory.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
