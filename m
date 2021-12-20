Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0234C433EF
	for <iommu@archiver.kernel.org>; Mon, 20 Dec 2021 08:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5115840572;
	Mon, 20 Dec 2021 08:03:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c4f2aBASxq9F; Mon, 20 Dec 2021 08:03:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1419840573;
	Mon, 20 Dec 2021 08:03:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB2EAC002F;
	Mon, 20 Dec 2021 08:03:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D913C0012
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 08:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AAE283EE5
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 08:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ef1F09lGV8LV for <iommu@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 08:03:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E6F883EDC
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 08:03:40 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D90CF39A; Mon, 20 Dec 2021 09:03:37 +0100 (CET)
Date: Mon, 20 Dec 2021 09:03:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 0/9] iommu: refactor flush queues into iommu-dma
Message-ID: <YcA42LtpISehG6O9@8bytes.org>
References: <cover.1639753638.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1639753638.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com, will@kernel.org,
 hch@lst.de
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

On Fri, Dec 17, 2021 at 03:30:54PM +0000, Robin Murphy wrote:
> Matthew Wilcox (Oracle) (2):
>   iommu/amd: Use put_pages_list
>   iommu/vt-d: Use put_pages_list
> 
> Robin Murphy (6):
>   iommu/iova: Squash entry_dtor abstraction
>   iommu/iova: Squash flush_cb abstraction
>   iommu/amd: Simplify pagetable freeing
>   iommu/iova: Consolidate flush queue code
>   iommu/iova: Move flush queue code to iommu-dma
>   iommu: Move flush queue data into iommu_dma_cookie
> 
> Xiongfeng Wang (1):
>   iommu/iova: Fix race between FQ timeout and teardown

Applied, thanks Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
