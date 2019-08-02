Return-Path: <SRS0=q6Nl=V6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7EBC433FF
	for <iommu@archiver.kernel.org>; Fri,  2 Aug 2019 06:37:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E479D2086A
	for <iommu@archiver.kernel.org>; Fri,  2 Aug 2019 06:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E479D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 82463EBE;
	Fri,  2 Aug 2019 06:37:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CD131EB7
	for <iommu@lists.linux-foundation.org>;
	Fri,  2 Aug 2019 06:37:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 47492E7
	for <iommu@lists.linux-foundation.org>;
	Fri,  2 Aug 2019 06:37:16 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 80CFE68C65; Fri,  2 Aug 2019 08:37:12 +0200 (CEST)
Date: Fri, 2 Aug 2019 08:37:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alex Smith <alex.smith@imgtec.com>
Subject: DMA_ATTR_WRITE_COMBINE on mips
Message-ID: <20190802063712.GA7553@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
	Paul Burton <paul.burton@mips.com>,
	Sadegh Abbasi <Sadegh.Abbasi@imgtec.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

[I hope the imgtec address still works, but maybe the mips folks know
if it moved to mips]

Hi Alex,

you added DMA_ATTR_WRITE_COMBINE support in dma_mmap_attrs to mips
in commit 8c172467be36f7c9591e59b647e4cd342ce2ef41
("MIPS: Add implementation of dma_map_ops.mmap()"), but that commit
only added the support in mmap, not in dma_alloc_attrs.  This means
the memory is now used in kernel space through KSEG1, and thus uncached,
while for userspace mappings through dma_mmap_* pgprot_writebombine
is used, which creates a write combine mapping, which on some MIPS CPUs
sets the _CACHE_UNCACHED_ACCELERATED pte bit instead of the
_CACHE_UNCACHED one.  I know at least on arm, powerpc and x86 such
mixed page cachability attributes can cause pretty severe problems.
Are they ok on mips?  Or was the DMA_ATTR_WRITE_COMBINE supported
unintended and not correct and we should remove it?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
