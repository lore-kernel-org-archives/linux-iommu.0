Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B504AC433F5
	for <iommu@archiver.kernel.org>; Wed,  2 Mar 2022 09:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B85C828AF;
	Wed,  2 Mar 2022 09:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OFQfPEk5KGks; Wed,  2 Mar 2022 09:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 395028289B;
	Wed,  2 Mar 2022 09:22:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16EA0C0082;
	Wed,  2 Mar 2022 09:22:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98157C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 09:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EFD3828AF
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 09:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KECxlCcSWjbn for <iommu@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:22:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEA5B8289B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 09:22:09 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 745BC68AFE; Wed,  2 Mar 2022 10:22:04 +0100 (CET)
Date: Wed, 2 Mar 2022 10:22:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anatoly Pugachev <matorola@gmail.com>
Subject: Re: [PATCH 07/11] x86: remove the IOMMU table infrastructure
Message-ID: <20220302092204.GA24139@lst.de>
References: <20220227143055.335596-1-hch@lst.de>
 <20220227143055.335596-8-hch@lst.de>
 <CADxRZqxrjp4erFNorH+XqubZWLRNjw2E14z7vOW537no1eKnhw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADxRZqxrjp4erFNorH+XqubZWLRNjw2E14z7vOW537no1eKnhw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, linux-s390 <linux-s390@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 tboot-devel@lists.sourceforge.net, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>,
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

On Wed, Mar 02, 2022 at 12:18:26PM +0300, Anatoly Pugachev wrote:
> Is it possible to keep documentation comments in source files? Or are
> they completely irrelevant now?

That ones you quoted are very much irrelevant now.  And the behaviour
of the swiotlb disabling will have to change (this patchset is a bit
of a preparation for now) as we now use per-device dma_ops and the
dma-iommu can dip into the swiotlb pool for untrusted devices.  In
practive we'll basically have to always initialize the swiotlb buffer
now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
