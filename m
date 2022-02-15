Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839CDC433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 19:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1870560FCC;
	Tue, 15 Feb 2022 19:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id czpLgF6pZDzK; Tue, 15 Feb 2022 19:54:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E5BB860B1C;
	Tue, 15 Feb 2022 19:54:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88DBEC0011;
	Tue, 15 Feb 2022 19:54:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9081C000B;
 Tue, 15 Feb 2022 19:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2C0960B1C;
 Tue, 15 Feb 2022 19:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YqwMBwFIQzE2; Tue, 15 Feb 2022 19:54:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE2E060B04;
 Tue, 15 Feb 2022 19:54:02 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A7F7BB81CC2;
 Tue, 15 Feb 2022 19:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD345C340F8;
 Tue, 15 Feb 2022 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644954837;
 bh=ybVzBbvmSOoVbs8OTAqgC9k7dcWxXzPNvdGTlxM4esw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=XiVUyL4al8GHXE+UgzwigR7X6pH993Bu63Z0W1Z517LncckN+4p91ba/TO5NWXQpp
 U1vWjpJONv3koPrD/mTCQn2wG59ZnyoYcqC24otLIxisbduauF07K6jsfuKF7k5IPi
 +Hw1LyLfz4KFU1iFNEABzel5jNUlcgSKiLZTXhgdUbVpBQhvQZook17Z26oC8x+I92
 Kqw26/a9rxOHNFUPyA1v8xkCofJMAgh45s4p7T9SEsz5KknpGQn+JSam3udRoSF79D
 JcwPKgnF+Gb7n0xG2o5q3ZdCK1XwGP234FVVLgPnpE7Dny5AEZWXqxbge/dQJ7fmyT
 BLnrlNNGDqbSg==
Received: by mail-ej1-f49.google.com with SMTP id lw4so15782914ejb.12;
 Tue, 15 Feb 2022 11:53:57 -0800 (PST)
X-Gm-Message-State: AOAM531uNz6C8gTP3VzwPgSpZLWtmmIzdpRKix/moptSskNndhcP/Kp0
 bA6jJBGnQ/MdhMQO5wKhiMHGy6dKvyALCBJ2NA==
X-Google-Smtp-Source: ABdhPJzC9sVdAIFHy7S1BKRXKLnYS/B1vXl5yMVBOJv/Qip68D1M6dRfb08LeY0VUnzZG5cmUksF3YA2hW+Y4jYVYLc=
X-Received: by 2002:a17:907:628c:: with SMTP id
 nd12mr586045ejc.82.1644954836019; 
 Tue, 15 Feb 2022 11:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20220214174132.219303-1-david@redhat.com>
 <20220214174132.219303-2-david@redhat.com>
In-Reply-To: <20220214174132.219303-2-david@redhat.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 15 Feb 2022 13:53:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzL6xBXfuTv423EoWw=fYPnK_q5paqUSDWyyoNx1thRA@mail.gmail.com>
Message-ID: <CAL_JsqKzL6xBXfuTv423EoWw=fYPnK_q5paqUSDWyyoNx1thRA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] cma: factor out minimum alignment requirement
To: David Hildenbrand <david@redhat.com>
Cc: devicetree@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 Minchan Kim <minchan@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Zi Yan <ziy@nvidia.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Robin Murphy <robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>
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

On Mon, Feb 14, 2022 at 11:42 AM David Hildenbrand <david@redhat.com> wrote:
>
> Let's factor out determining the minimum alignment requirement for CMA
> and add a helpful comment.
>
> No functional change intended.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/include/asm/fadump-internal.h |  5 -----
>  arch/powerpc/kernel/fadump.c               |  2 +-
>  drivers/of/of_reserved_mem.c               |  9 +++------

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/cma.h                        |  9 +++++++++
>  kernel/dma/contiguous.c                    |  4 +---
>  mm/cma.c                                   | 20 +++++---------------
>  6 files changed, 19 insertions(+), 30 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
