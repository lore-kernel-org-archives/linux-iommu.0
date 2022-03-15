Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B65C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 00:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9159405CD;
	Tue, 15 Mar 2022 00:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C58WWU6q9Mf4; Tue, 15 Mar 2022 00:00:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 822C940142;
	Tue, 15 Mar 2022 00:00:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4932EC001D;
	Tue, 15 Mar 2022 00:00:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13463C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 00:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D748640583
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 00:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NmWsWcB59vq0 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 00:00:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2BA740142
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 00:00:09 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 1D754CE16F9;
 Tue, 15 Mar 2022 00:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82170C340E9;
 Tue, 15 Mar 2022 00:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647302404;
 bh=qF2Kiv1yBWM6zFZu7vu4vkmgVsDPPK9bUwo+CMzG77s=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=CxQznLVvPAMHVLObot/GbKAGNBs3wp/Zo7J//e5fa5RGl/JAcrYpHk7dFYXJ+dCyc
 yFp/t/ucQtYgdUQQRIyugjt0bw6neR65fWz4Mw2wQpqjjnNDOhxJr7SqJvB+dScWOI
 FWaPNn7YRGzQ0CCDI4WX3HGCjk3WcedTK4ZKrUhQL/ZjI62kK/fSKVT6fnNg8LwsV7
 O+N86nVOy9ALX/s25HJpQGYpv30ak+B6D/CFn8xWL4gwGSW9Q/HStnRPdXpxBq2xEr
 XfmlQm0hAt72Py8IAnH8MpwztAqekJ4fXRmnodDkCqvESbpDzlwteZaCwLl1CvtOpX
 4SrZDmHAzylBg==
Date: Mon, 14 Mar 2022 17:00:02 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/15] swiotlb: merge swiotlb-xen initialization into
 swiotlb
In-Reply-To: <20220314073129.1862284-14-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2203141659210.3497@ubuntu-linux-20-04-desktop>
References: <20220314073129.1862284-1-hch@lst.de>
 <20220314073129.1862284-14-hch@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 tboot-devel@lists.sourceforge.net, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Mon, 14 Mar 2022, Christoph Hellwig wrote:
> Reuse the generic swiotlb initialization for xen-swiotlb.  For ARM/ARM64
> this works trivially, while for x86 xen_swiotlb_fixup needs to be passed
> as the remap argument to swiotlb_init_remap/swiotlb_init_late.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For arch/arm/xen and drivers/xen/swiotlb-xen.c

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
