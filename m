Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DCBC433E1
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 14:17:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C69420729
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 14:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C69420729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3F990869EC;
	Wed, 22 Jul 2020 14:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u68hssz7mX28; Wed, 22 Jul 2020 14:17:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7602F869C0;
	Wed, 22 Jul 2020 14:17:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B27CC004E;
	Wed, 22 Jul 2020 14:17:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2864CC004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0FB6387FDA
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CD+GYaDdqTi0 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 14:17:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A15C187F43
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:17:03 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 96A4168B05; Wed, 22 Jul 2020 16:16:58 +0200 (CEST)
Date: Wed, 22 Jul 2020 16:16:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Message-ID: <20200722141658.GA17658@lst.de>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com>
 <20200628111251.19108-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200628111251.19108-2-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: catalin.marinas@arm.com, Steve Capper <steve.capper@arm.com>,
 robin.murphy@arm.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>,
 will@kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
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

On Sun, Jun 28, 2020 at 11:12:50PM +1200, Barry Song wrote:
> This is useful for at least two scenarios:
> 1. ARM64 smmu will get memory from local numa node, it can save its
> command queues and page tables locally. Tests show it can decrease
> dma_unmap latency at lot. For example, without this patch, smmu on
> node2 will get memory from node0 by calling dma_alloc_coherent(),
> typically, it has to wait for more than 560ns for the completion of
> CMD_SYNC in an empty command queue; with this patch, it needs 240ns
> only.
> 2. when we set iommu passthrough, drivers will get memory from CMA,
> local memory means much less latency.

I really don't like the config options.  With the boot parameters
you can always hardcode that in CONFIG_CMDLINE anyway.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
