Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA03FC433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 16:20:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730392064B
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 16:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730392064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A188688F85;
	Wed,  8 Jul 2020 16:20:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id imRFUVmL1S8p; Wed,  8 Jul 2020 16:20:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DEB9588F7D;
	Wed,  8 Jul 2020 16:20:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C256CC077B;
	Wed,  8 Jul 2020 16:20:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F808C016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 16:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6A24187D4C
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 16:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fPuFegNK2GYG for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 16:20:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E501887D48
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 16:20:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33BB831B;
 Wed,  8 Jul 2020 09:20:18 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5F663F68F;
 Wed,  8 Jul 2020 09:20:16 -0700 (PDT)
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
To: Christoph Hellwig <hch@lst.de>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
 <e6504dc5-4169-edf9-d08e-17a378a1ef7a@arm.com>
 <21a7276e98ae245404d82537ac1ee597a92f9150.camel@suse.de>
 <20200708153635.GB26743@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <304053c7-9f88-8830-3287-2496a4cb48cd@arm.com>
Date: Wed, 8 Jul 2020 17:20:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708153635.GB26743@lst.de>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-07-08 16:36, Christoph Hellwig wrote:
> On Wed, Jul 08, 2020 at 12:35:34PM +0200, Nicolas Saenz Julienne wrote:
>>> Which allows me to switch between ACPI/DT on the machine. In DT mode it
>>> works fine now,
>>
>> Nice, would that count as a Tested-by from you?
>>
>>> but with ACPI I continue to have failures unless I
>>> disable CMA via cma=0 on the kernel command line.
>>
>> Yes, I see why, in atomic_pool_expand() memory is allocated from CMA without
>> checking its correctness. That calls for a separate fix. I'll try to think of
>> something.
> 
> I think we need a dma_coherent_ok for the allocations from the
> pool and then fall back to the next better one to get started.  And
> yes, CMA is a bit of a mess, that generally needs better checks.

Yeah, another thought that came to mind later is that iommu-dma can use 
pages from any pool regardless of the device's DMA mask, so we could 
stand to be a lot less restrictive in that case too.

Perhaps it is better to just bite the bullet, keep the straightforward 
one-pool-per-zone setup, and implement the dma_coherent_ok() type 
fallback logic. More complexity for dma_alloc_from_pool(), but 
everything else stays nice and simple - lose the assumption that 
dev_to_pool() can work for this and and just let callers pass an 
allocation mask directly, and have dma_free_from_pool() simply check all 
available pools.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
