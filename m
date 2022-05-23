Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AD3C433EF
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 15:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E727C82D0C;
	Mon, 23 May 2022 15:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V267cWf3kUH0; Mon, 23 May 2022 15:55:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CFF8482CDE;
	Mon, 23 May 2022 15:55:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0118C0032;
	Mon, 23 May 2022 15:55:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9023C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 15:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B51CE610A3
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 15:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rpLvEs6JX05p for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 15:55:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC71660EB7
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 15:55:00 +0000 (UTC)
Received: by mail-yb1-xb2d.google.com with SMTP id b124so14181906ybg.12
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zcz3Knd2FXDp/6rkGBIzY243CZcd9qE9/BuWzEwVYYI=;
 b=lekDUzT4kL68GY5g6aQLoYSVnzLTb+WgHRTI5Lm3/BX61Y250W/1wgp4+2BQ4OJkGW
 9IJQZj7RaJ4FYjc18bpZnhRTqP5mr4ypDQcOgL1lDWqUt3x7Oth6vwH/RbjQSjeK5xt/
 gUz7vKNc3PEqD8azMBNMnMN6fK8RR/vPMF51yUQvBXLyJqFhDdWGYYZN4dk5NIpTeE0n
 JyajU41EFWjjrIWUVlNa1IJ+/YsrTd7IWQXClJjvl/2dw+QLnIeqnCAHeBfpKa1DSyPi
 WJDtPCkiY8JERUrhiG94RHtQHA5frwP24DOK0klrQVfO590i6IOjFc3bvfPA5wnw6CaP
 ZRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zcz3Knd2FXDp/6rkGBIzY243CZcd9qE9/BuWzEwVYYI=;
 b=ylEj30lGoxJtO1RjDmFYci6hMapgWB2pmudgNta1t4zGMIVsYS4Ksq2wNv2rQOkpKN
 lFx1VSYqq1AOgS9HK9N7r2o01MS9wViz7NFhyI2DmlHp78lHgfx8OAMv0962q3Q2RCwS
 xqz4iS2VGmY/7HHyxiY7bBDYFAq6ier7R9fAEJ3KxA2TBpzJTdvE06kIskz63ZqCZTEW
 p8itKJEXVSFdLyihHi8tmhSgM4qZsVsWXjqy7EbdykPA/dhjebrgYITTbyAhnoKvX9Z3
 KXWUva0I9cQBRwB9TCShW9kawRQ1Iyg5Fc8HogezfwNgISJ3lmKGxAQV37coVttISyg4
 GqQw==
X-Gm-Message-State: AOAM533mhadZvMmL2a2OfwRRgovP/0keScKh1aXnfxtqx4MVjupo1r5A
 SZFkiUwppuGwNWe6LuXkg+B4mfAFeb4boX5rZM4=
X-Google-Smtp-Source: ABdhPJwD35IyU1viAzG3IGyBq8P/gdx7DTc/j2RZ0xPNW+IPRSZd3Ic4/VB9Zh1cxKR8GxId6uAkNgkp03zmPgePqKU=
X-Received: by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP id
 f9-20020a056902038900b0063331c1d0f7mr21833304ybs.543.1653321299794; Mon, 23
 May 2022 08:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220511121425epcas5p256b55554b32dc58566827818a817ac44@epcas5p2.samsung.com>
 <20220511121544.5998-1-ajaykumar.rs@samsung.com>
In-Reply-To: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
From: Ajay Kumar <ajaykumar.rs1989@gmail.com>
Date: Mon, 23 May 2022 21:24:48 +0530
Message-ID: <CADe9J7HOwD9fDW_sUV8mzwfuvJ0yuYB6s-UXcMzbBgYG+Bf=dg@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] IOMMU-DMA - support DMA_ATTR_LOW_ADDRESS attribute
To: Ajay Kumar <ajaykumar.rs@samsung.com>, linux-arm-kernel@lists.infradead.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>, joro@8bytes.org, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: pankaj.dubey@samsung.com, alim.akhtar@samsung.com
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

Ping!

On Thu, May 12, 2022 at 9:09 AM Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
>
> This patchset is a rebase of original patches from Marek Szyprowski:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2321261.html
>
> The patches have been rebased on Joro's IOMMU tree "next" branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
>
> This patchset is needed to address the IOVA address dependency issue between
> firmware buffers and other buffers in Samsung s5p-mfc driver.
>
> There have been few discussions in the past on how to find a generic
> soultion for this issue, ranging from adding an entirely new API to choose
> IOVA window[1], to adding a DMA attribute DMA_ATTR_LOW_ADDRESS which handles
> buffer allocation from lower address[2].
> This is a continuation of initial work from Marek for approach [2].
> Patches have been tested with latest version of Samsung s5p-mfc driver.
>
> Changes since V1:
> [PATCH V2 1/6]
> - Rebase on latest tree.
>
> [PATCH V2 2/6]
> - Rebase on latest tree.
>   Added a missing check for iova_pfn in __iova_rcache_get()
>   Discard changes from drivers/iommu/intel/iommu.c which are not necessary
>
> [PATCH V2 3/6]
> - Rebase on latest tree.
>
> [PATCH V2 4/6]
> - Rebase on latest tree
>
> [PATCH V2 5/6]
> - Rebase on latest tree
>
> [PATCH V2 6/6]
> - Rebase on latest tree.
>
> Marek Szyprowski (6):
>   dma-mapping: add DMA_ATTR_LOW_ADDRESS attribute
>   iommu: iova: properly handle 0 as a valid IOVA address
>   iommu: iova: add support for 'first-fit' algorithm
>   iommu: dma-iommu: refactor iommu_dma_alloc_iova()
>   iommu: dma-iommu: add support for DMA_ATTR_LOW_ADDRESS
>   media: platform: s5p-mfc: use DMA_ATTR_LOW_ADDRESS
>
> References:
> [1]
> https://lore.kernel.org/linux-iommu/20200811054912.GA301@infradead.org/
>
> [2]
> https://lore.kernel.org/linux-mm/bff57cbe-2247-05e1-9059-d9c66d64c407@arm.com
>
>  drivers/iommu/dma-iommu.c                     | 77 +++++++++++-----
>  drivers/iommu/iova.c                          | 91 ++++++++++++++++++-
>  .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  8 +-
>  include/linux/dma-mapping.h                   |  6 ++
>  include/linux/iova.h                          |  3 +
>  5 files changed, 156 insertions(+), 29 deletions(-)
>
>
> base-commit: faf93cfaadfaaff2a5c35d6301b45aa2f6e4ddb2
> --
> 2.17.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
