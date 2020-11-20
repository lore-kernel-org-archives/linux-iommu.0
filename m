Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6EEC5519F
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 12:40:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1127922227
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 12:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1127922227
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ABB7087181;
	Fri, 20 Nov 2020 12:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HfdltpKuZqB1; Fri, 20 Nov 2020 12:40:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9706F87046;
	Fri, 20 Nov 2020 12:40:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CFC8C163C;
	Fri, 20 Nov 2020 12:40:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E2E7C0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 12:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 34F04875A7
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 12:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLmaaIj8NI+T for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 12:40:48 +0000 (UTC)
X-Greylist: delayed 00:16:11 by SQLgrey-1.7.6
Received: from fireflyinternet.com (unknown [77.68.26.236])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A4B258753C
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 12:40:47 +0000 (UTC)
X-Default-Received-SPF: pass (skip=forwardok (res=PASS))
 x-ip-name=78.156.65.138; 
Received: from localhost (unverified [78.156.65.138]) 
 by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id
 23054655-1500050 for multiple; Fri, 20 Nov 2020 12:24:02 +0000
MIME-Version: 1.0
In-Reply-To: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 0/7] Convert the intel iommu driver to the dma-iommu api
From: Chris Wilson <chris@chris-wilson.co.uk>
To: Christoph Hellwig <hch@infradead.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Tom Murphy <murphyt7@tcd.ie>,
 Will Deacon <will@kernel.org>
Date: Fri, 20 Nov 2020 12:24:01 +0000
Message-ID: <160587504147.19364.17448380121292539865@build.alporthouse.com>
User-Agent: alot/0.9
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org
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

Quoting Lu Baolu (2020-11-20 10:17:12)
> Lu Baolu (3):
>   iommu: Add quirk for Intel graphic devices in map_sg
>   iommu/vt-d: Update domain geometry in iommu_ops.at(de)tach_dev
>   iommu/vt-d: Cleanup after converting to dma-iommu ops
> 
> Tom Murphy (4):
>   iommu: Handle freelists when using deferred flushing in iommu drivers
>   iommu: Add iommu_dma_free_cpu_cached_iovas()
>   iommu: Allow the dma-iommu api to use bounce buffers
>   iommu/vt-d: Convert intel iommu driver to the iommu ops

Something that may be of interest is that we encounter problems with
using intel-iommu across a PCI remove event. All HW generations fail
with faults like:

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Write] Request device [00:02.0] PASID ffffffff fault addr 4b822000 [fault reason 02] Present bit in context entry is clear

i.e. they all report missing present bit after re-adding the device to the
iommu group. Forcing an identity map (or disabling iommu) works fine.

I applied this series just on the off-chance it changed the symptoms; it
does not. If you have any ideas on how to chase down this fault, that
would be very useful. We have a few other DMAR faults visible on many
platforms, all "[fault reason 07] Next page table ptr is invalid" that
are again not affected by this series, that we also need to resolve.
-Chris
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
