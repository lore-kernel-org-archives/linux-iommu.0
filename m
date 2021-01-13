Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB451C433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 02:54:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E5F23123
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 02:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E5F23123
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AEE6686727;
	Wed, 13 Jan 2021 02:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TQAMxOyVrpbR; Wed, 13 Jan 2021 02:54:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 328CA866B3;
	Wed, 13 Jan 2021 02:54:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24454C0893;
	Wed, 13 Jan 2021 02:54:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1426C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 02:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D91B5866B3
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 02:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mUILQ8vwFc5o for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 02:54:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id BC08386631
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 02:54:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8231042;
 Tue, 12 Jan 2021 18:54:14 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D06E3F719;
 Tue, 12 Jan 2021 18:54:12 -0800 (PST)
Subject: Re: [PATCH v2 0/5] Optimize iommu_map_sg() performance
To: Christoph Hellwig <hch@infradead.org>
References: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
 <8ad6db90-1d86-db2a-ccb5-dc3f01213289@arm.com>
 <20210112163307.GA1199965@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ef9390bc-57de-07fa-30fd-863672685788@arm.com>
Date: Wed, 13 Jan 2021 02:54:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112163307.GA1199965@infradead.org>
Content-Language: en-GB
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, pdaly@codeaurora.org,
 will@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, pratikp@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
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

On 2021-01-12 16:33, Christoph Hellwig wrote:
> On Tue, Jan 12, 2021 at 04:00:59PM +0000, Robin Murphy wrote:
>> Out of curiosity, how much of the difference is attributable to actual
>> indirect call overhead vs. the additional massive reduction in visits to
>> arm_smmu_rpm_{get,put} that you fail to mention? There are ways to optimise
>> indirect calling that would benefit *all* cases, rather than just one
>> operation for one particular driver.
> 
> Do we have systems that use different iommu_ops at the same time?
> If not this would be a prime candidate for static call optimizations.

They're not at all common, but such systems do technically exist. It's 
hard to make them work in the current "one set of ops per bus" model, 
but I still have a long-term dream of sorting that out so such setups 
*can* be supported properly. I certainly wouldn't want to make any 
changes that completely close the door on that idea, but any static call 
optimisation that can be done in a config-gated manner should be viable 
for x86 at least. Even better if we could do it with a dynamic 
branch-patching solution that keeps the indirect case as a fallback; 
AFAICS that should be feasible to eagerly apply somewhere around 
iommu_device_register(), then just undo again if another driver ever 
does show up registering a new set of ops that don't match. I'm pretty 
confident that the systems where performance matters most are going to 
be sensible homogeneous ones - on the Arm side the SBSA should see to 
that. The weird mix-and-match cases are typically going to be FPGA 
prototyping systems and esoteric embedded stuff that are worlds away 
from worrying about keeping up with line rate on a 40GbE NIC...

> Also I've been pondering adding direct calls to the iommu dma ops like
> we do for DMA direct.  This would allow to stop using dma_ops entirely
> for arm64.

Yes, now that we're starting to get things sufficiently consolidated 
behind iommu-dma that might be a reasonable thing to try, although given 
the amount of inherent work further down in the IOVA and IOMMU layers 
that dwarfs that of the direct case, I doubt that reducing the initial 
dispatch overhead would make any noticeable difference in practice.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
