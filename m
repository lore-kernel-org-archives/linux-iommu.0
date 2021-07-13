Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A9AC07E95
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 23:54:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992D761369
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 23:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992D761369
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F87560795;
	Tue, 13 Jul 2021 23:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sXvNzt_A0Nid; Tue, 13 Jul 2021 23:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 530726071C;
	Tue, 13 Jul 2021 23:54:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14D33C001A;
	Tue, 13 Jul 2021 23:54:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5907C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 23:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E83460724
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 23:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p12GpJRpQy0x for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 23:54:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88A146071C
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 23:54:16 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id s6so20681821qkc.8
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 16:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=psNqCrBwCGRPV0GMx0UJi9q1GTstXYN3y24OgE9aFHA=;
 b=nAn1ZBctObW5/4rzcwbWcXacQkKZzr+xNKjOPvXZEJkFWoXKOXpGusecOIwp2Bkkg8
 gQx0KPcNl3VanNIuObMwevvxTyfI3v5ASEzsLaWrlzElfTAv2KwigogKaIDDqyk38nTU
 21v2QUakO9PeQqSV/k9mHvzbQmbPMvbgbHCedUgtf8szFThAeyNt6Q3ek3wTC6RZEUhl
 p37zswHknxz2+J7q4tV+WF/DUblIwzz73KSWFvdWA5MatZv4P5NRdAihrggZKv4IBWl5
 mwqZuMZZS6cpQPBZL17XvkhZOGLnGW81B9ErVPSttvz6F20wjdSYJm+vC9ceHZQq20qv
 wjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=psNqCrBwCGRPV0GMx0UJi9q1GTstXYN3y24OgE9aFHA=;
 b=WOysubyColVJmqVibsvG5C1Q2nKsjVNDWLAY55ZXr+tiNdK7x7A4VkNefgS6RXBfq0
 RucU42yNMM4XnJ8OU/+g79e9KhSQQTKByVgWXyE5WEesJYKt99fp+Nyu88AAsR4TfMPz
 G2aFVa73oaZPmD7zb6hmA4og83QR02mTqpTtS5H0xRoSik4zd+v8/TeUnTWVipUixYT5
 6glnIjqO3gJ5oM/2t4cdmF/qX5o5B76FEggmbNNNmXw2YM4lPGu7nLb97kBqguMoHOsp
 iymhj3aBRSrGn81t3a8D40cLHKTt8G15u19jYiDCuWQGRy+yySkkBOYvGL9h1SA9Yao4
 RLWA==
X-Gm-Message-State: AOAM530EPQnSla3jylNJ9o8ioXeja5bq2r3WM+e1jn1m6dmU/ITj58yc
 qN4PdJNp04Bpybc4hHne+CY=
X-Google-Smtp-Source: ABdhPJy9aRtw6TRboqtQn9nRqg1AhyGHGFH4KJheCNecEuLTHHQvQx/DiTyi4lhZrGrHwKCG81Niug==
X-Received: by 2002:a05:620a:709:: with SMTP id
 9mr6857281qkc.493.1626220455313; 
 Tue, 13 Jul 2021 16:54:15 -0700 (PDT)
Received: from fedora ([130.44.160.152])
 by smtp.gmail.com with ESMTPSA id l4sm206872qkd.77.2021.07.13.16.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 16:54:14 -0700 (PDT)
Date: Tue, 13 Jul 2021 19:54:12 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: Re: [PATCH] swiotlb: add overflow checks to swiotlb_bounce
Message-ID: <YO4npNvmgEKFotvq@fedora>
References: <20210707051254.2121603-1-dominique.martinet@atmark-techno.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210707051254.2121603-1-dominique.martinet@atmark-techno.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, Bumyong Lee <bumyong.lee@samsung.com>,
 iommu@lists.linux-foundation.org, Chanho Park <chanho61.park@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Wed, Jul 07, 2021 at 02:12:54PM +0900, Dominique Martinet wrote:
> This is a follow-up on 5f89468e2f06 ("swiotlb: manipulate orig_addr
> when tlb_addr has offset") which fixed unaligned dma mappings,
> making sure the following overflows are caught:
> 
> - offset of the start of the slot within the device bigger than
> requested address' offset, in other words if the base address
> given in swiotlb_tbl_map_single to create the mapping (orig_addr)
> was after the requested address for the sync (tlb_offset) in the
> same block:
> 
>  |------------------------------------------| block
>               <----------------------------> mapped part of the block
>               ^
>               orig_addr
>        ^
>        invalid tlb_addr for sync
> 
> - if the resulting offset was bigger than the allocation size
> this one could happen if the mapping was not until the end. e.g.
> 
>  |------------------------------------------| block
>       <---------------------> mapped part of the block
>       ^                               ^
>       orig_addr                       invalid tlb_addr
> 
> Both should never happen so print a warning and bail out without trying
> to adjust the sizes/offsets: the first one could try to sync from
> orig_addr to whatever is left of the requested size, but the later
> really has nothing to sync there...
> 
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Bumyong Lee <bumyong.lee@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
> 
> Hi Konrad,
> 
> here's the follow up for the swiotlb/caamjr regression I had promissed.

Awesome!
> It doesn't really change anything, and I confirmed I don't hit either of
> the warnings on our board, but it's probably best to have as either
> could really happen.

:nods:

I put it in the devel/for-linus-5.14 and linux-next. Thank you!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
