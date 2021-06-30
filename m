Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F05C11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 11:17:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F0C6141C
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 11:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F0C6141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E607608B1;
	Wed, 30 Jun 2021 11:17:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wMrHw_waWpd; Wed, 30 Jun 2021 11:17:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F27460687;
	Wed, 30 Jun 2021 11:17:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE3A8C0010;
	Wed, 30 Jun 2021 11:17:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C258C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 11:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 239D760894
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 11:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GUttlXED-rkA for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 11:17:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CAF960687
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 11:17:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71FDC61416;
 Wed, 30 Jun 2021 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625051819;
 bh=gUK7CVS8e2cXpIkn5P9a80Ni/fjjiEdxLr686zwbYwo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LrE5xBZGvBzxMMDr7xPpC0LgFueWQu9wnpPgxKFozVNI8/77In5i8c/hdO5MtVNMC
 RVEOP5F5mHswSXrFPMxFi7/iAel9d4oGLGucGIc7r9FEpoKRJZcQ2HVWGjvG5VU69Q
 c6cjOrpWuI+1VjsBTf1qKdsQQ3D4afJAQrbf/4rqnfptmLydhn4PAhaWaB9I/Tsbdp
 ldRiKGTkwLmboPAvmvH0tfaKael5yebU5xrM108RV5xDelyF1SYVwz4c8V7MQGY2LB
 okwz61hRCid9ECCu5DhsCWAgdpyNIkdX0wBxVdoeQjrUMcUxYe1uL0oLn267Ja83oM
 bDJsfPF7DHZvg==
Date: Wed, 30 Jun 2021 14:16:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH rdma-next v1 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
Message-ID: <YNxSqOeECXGG2fX8@unreal>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
 <CGME20210630111227eucas1p2212b63f5d9da6788e57319c35ce9eaf4@eucas1p2.samsung.com>
 <a9462d67-2279-93f1-e042-d46033c208df@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a9462d67-2279-93f1-e042-d46033c208df@samsung.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 linux-kernel@vger.kernel.org,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Doug Ledford <dledford@redhat.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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

On Wed, Jun 30, 2021 at 01:12:26PM +0200, Marek Szyprowski wrote:
> Hi Leon,
> 
> On 29.06.2021 10:40, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@nvidia.com>
> >
> > orig_nents should represent the number of entries with pages,
> > but __sg_alloc_table_from_pages sets orig_nents as the number of
> > total entries in the table. This is wrong when the API is used for
> > dynamic allocation where not all the table entries are mapped with
> > pages. It wasn't observed until now, since RDMA umem who uses this
> > API in the dynamic form doesn't use orig_nents implicit or explicit
> > by the scatterlist APIs.
> >
> > Fix it by:
> > 1. Set orig_nents as number of entries with pages also in
> >     __sg_alloc_table_from_pages.
> > 2. Add a new field total_nents to reflect the total number of entries
> >     in the table. This is required for the release flow (sg_free_table).
> >     This filed should be used internally only by scatterlist.
> >
> > Fixes: 07da1223ec93 ("lib/scatterlist: Add support in dynamic allocation of SG table from pages")
> > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

<...>

> For now I would suggest to revert this change.

Thanks for the report, we will drop this patch.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
