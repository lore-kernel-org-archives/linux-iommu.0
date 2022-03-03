Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF3CC43217
	for <iommu@archiver.kernel.org>; Thu,  3 Mar 2022 22:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2DE16409DC;
	Thu,  3 Mar 2022 22:49:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KnYNKc1gmMwj; Thu,  3 Mar 2022 22:49:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E15F3400DA;
	Thu,  3 Mar 2022 22:49:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C67BAC001D;
	Thu,  3 Mar 2022 22:49:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10E99C000B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 22:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E43F940363
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 22:49:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WPN7sLpTZ9hh for <iommu@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 22:49:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10FAD400DA
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 22:49:34 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EF430B826F7;
 Thu,  3 Mar 2022 22:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF27C004E1;
 Thu,  3 Mar 2022 22:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646347770;
 bh=8T7CokGxWBKJfPW1pG0VCMscny/1l39AXb6Fw4feFiI=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=mDE8XGmJRPXC3FhUExxfC/Tg8r8q5kqje46aVpKcSpgATjCrTOmm8dyL5+N0ARFUl
 igEkDLka8/5AR112e4UmftTK6LTw6MIVEq72/1WbVxD/BN6jvq1CQNSmYNX2eOZkoM
 C7Y6r4k/M1DH2K4tAUOZ5dfMEE8n9On9bbDAQYejM/m/pVednlfOiQ+0ILLxk+xuq6
 0Hivc3idTv5Og15E95hL8KOwRNZ6gfWfd8YTyoWKgbowpFGJ7UwyLwEnr/Ub/zQ8kx
 OW2VcyhCSn0JN1ypiUZLYah5Kofhllw9xygmCFN3oPTfqf6bSdXRFiDe95KnoglrOU
 yMQm9xneH86Yg==
Date: Thu, 3 Mar 2022 14:49:29 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/12] swiotlb: merge swiotlb-xen initialization into
 swiotlb
In-Reply-To: <20220303105931.GA15137@lst.de>
Message-ID: <alpine.DEB.2.22.394.2203031447120.3261@ubuntu-linux-20-04-desktop>
References: <20220301105311.885699-1-hch@lst.de>
 <20220301105311.885699-12-hch@lst.de>
 <alpine.DEB.2.22.394.2203011720150.3261@ubuntu-linux-20-04-desktop>
 <20220302081500.GB23075@lst.de>
 <alpine.DEB.2.22.394.2203021709470.3261@ubuntu-linux-20-04-desktop>
 <20220303105931.GA15137@lst.de>
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

On Thu, 3 Mar 2022, Christoph Hellwig wrote:
> On Wed, Mar 02, 2022 at 05:25:10PM -0800, Stefano Stabellini wrote:
> > Thinking more about it we actually need to drop the xen_initial_domain()
> > check otherwise some cases won't be functional (Dom0 not 1:1 mapped, or
> > DomU 1:1 mapped).
> 
> Hmm, but that would be the case even before this series, right?

Before this series we only have the xen_swiotlb_detect() check in
xen_mm_init, we don't have a second xen_initial_domain() check.

The issue is that this series is adding one more xen_initial_domain()
check in xen_mm_init.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
