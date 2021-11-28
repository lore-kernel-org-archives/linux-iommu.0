Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A85C433EF
	for <iommu@archiver.kernel.org>; Sun, 28 Nov 2021 00:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F8E1401F6;
	Sun, 28 Nov 2021 00:16:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WLtJe1GDWn8o; Sun, 28 Nov 2021 00:16:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B1E840208;
	Sun, 28 Nov 2021 00:16:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3131C001C;
	Sun, 28 Nov 2021 00:16:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD09C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 00:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E8B6401DF
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 00:16:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FkTUUb4qaG-b for <iommu@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 00:16:42 +0000 (UTC)
X-Greylist: delayed 00:09:18 by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A637401DD
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 00:16:42 +0000 (UTC)
Received: from mail.kernel.org (unknown [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 255DDB80916;
 Sun, 28 Nov 2021 00:07:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5952F60524;
 Sun, 28 Nov 2021 00:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1638058040;
 bh=qezTYQseI9DxNpOdmT5kuzbuG73JbvoENi5WMIb3UJY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=wqJban2R9O7yF/wfcwEI4K4ewdbM6sKnUWWUVW47r212gOjNx18PFLesOFaVBDsq3
 23UqWBAtQRubS7Ips1ydm9qOT7CzelMqDvbO+0iE5DvCC4nrU8DDJJHNZx4pfYqvT5
 G90iNCll6YneKYh+AF64jnxHQVZ12GpU+v+KUAqM=
Date: Sat, 27 Nov 2021 16:07:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Calvin Zhang <calvinzhang.cool@gmail.com>
Subject: Re: [PATCH] mm: kmemleak: Ignore kmemleak scanning on CMA regions
Message-Id: <20211127160718.54e82aa93c977a367404a9e3@linux-foundation.org>
In-Reply-To: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
References: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, 26 Nov 2021 10:47:11 +0800 Calvin Zhang <calvinzhang.cool@gmail.com> wrote:

> Just like this:
> commit 620951e27457 ("mm/cma: make kmemleak ignore CMA regions").
> 
> Add kmemleak_ignore_phys() for CMA created from of reserved node.

Could we please have a full, standalone changelog for this patch?

The 620951e27457 changelog says "Without this, the kernel crashes...". 
Does your patch also fix a crash?  If so under what circumstances and
should we backport this fix into -stable kernels?

Etcetera.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
