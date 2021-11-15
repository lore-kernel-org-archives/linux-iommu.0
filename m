Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D44C433F5
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 18:19:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17AC06138B
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 18:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17AC06138B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB6846071F;
	Mon, 15 Nov 2021 18:19:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id djxn7pwNKGNW; Mon, 15 Nov 2021 18:19:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB3CD605DC;
	Mon, 15 Nov 2021 18:19:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D3D2C001E;
	Mon, 15 Nov 2021 18:19:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1DC6C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92863401CA
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y6ACS2tPw_vZ for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 18:19:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 821A440161
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zVrBoirh2EF9+XPhCgtoyIlYq2wX2tx0m7p7r3K4JDE=; b=c0jPYjEJ2+8cqRIOPjmMalFRsM
 wIuGdLyprIZWo22GRu4eRakSjo+en3lVr5mXfg6fN3FoeQAO9uG73Nb7nfxGxONrnUAR+UwqISNpn
 oIGSMHGZKvoxd9uy7f4SLVMVKetQqzPSfg8jTxKb7zyRHVnOS/smfK4Hxe09WYAndcx5BqAXJMuP3
 +7iO0yXz9x/J7Hi5O4CGiXlGExg8uJ37Lc3dbw4LUbR/qiISVUuSWAqWIELHG+RSGpQfkRcY5HvJf
 sZkm4QHh4nad9xygINeOfTg3M9efb3+RI1XRq/Dwnqo7XPQxin/AvQry0RbC2Wv25PLusqyXo4a1g
 F1X0B+lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mmgZL-00GeVC-IN; Mon, 15 Nov 2021 18:19:03 +0000
Date: Mon, 15 Nov 2021 10:19:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 03/11] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
Message-ID: <YZKkl/1GN+KgjYs6@infradead.org>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-4-baolu.lu@linux.intel.com>
 <YZJe1jquP+osF+Wn@infradead.org>
 <20211115133107.GB2379906@nvidia.com>
 <495c65e4-bd97-5f29-d39b-43671acfec78@arm.com>
 <20211115161756.GP2105516@nvidia.com>
 <e9db18d3-dea3-187a-d58a-31a913d95211@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e9db18d3-dea3-187a-d58a-31a913d95211@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>, Diana Craciun <diana.craciun@oss.nxp.com>
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

On Mon, Nov 15, 2021 at 05:54:42PM +0000, Robin Murphy wrote:
> > s/PIO/MMIO, but yes basically. And not just data trasnfer but
> > userspace can interfere with the device state as well.
> 
> Sure, but unexpected changes in device state could happen for any number of
> reasons - uncorrected ECC error, surprise removal, etc. - so if that can
> affect "kernel integrity" I'm considering it an independent problem.

Well, most DMA is triggered by the host requesting it through MMIO.
So having access to the BAR can turn many devices into somewhat
arbitrary DMA engines.

> I can see the argument from that angle, but you can equally look at it
> another way and say that a device with kernel ownership is incompatible with
> a kernel driver, if userspace can call write() on "/sys/devices/B/resource0"
> such that device A's kernel driver DMAs all over it. Maybe that particular
> example lands firmly under "just don't do that", but I'd like to figure out
> where exactly we should draw the line between "DMA" and "ability to mess
> with a device".

Userspace writing to the resourceN files with a bound driver is a mive
receipe for trouble.  Do we really allow this currently?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
