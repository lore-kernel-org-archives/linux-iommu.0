Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCD0C07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 18:20:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35A1613C3
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 18:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35A1613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C9E683C89;
	Wed, 14 Jul 2021 18:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7BqZCiHC2ADl; Wed, 14 Jul 2021 18:20:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 61A5783C70;
	Wed, 14 Jul 2021 18:20:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1ACEFC001A;
	Wed, 14 Jul 2021 18:20:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5862FC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 18:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31D02405F0
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 18:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C3eIE-ffWBP1 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 18:19:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1637A405C3
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 18:19:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3219D6E;
 Wed, 14 Jul 2021 11:19:57 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 830E83F774;
 Wed, 14 Jul 2021 11:19:55 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] Apple M1 DART IOMMU driver
To: Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
References: <20210627143405.77298-1-sven@svenpeter.dev>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7261df01-34a9-4e53-37cd-ae1aa15b1fb4@arm.com>
Date: Wed, 14 Jul 2021 19:19:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627143405.77298-1-sven@svenpeter.dev>
Content-Language: en-GB
Cc: Arnd Bergmann <arnd@kernel.org>, r.czerwinski@pengutronix.de,
 devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org,
 Stan Skowronek <stan@corellium.com>
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

On 2021-06-27 15:34, Sven Peter wrote:
[...]
> In the long term, I'd like to extend the dma-iommu framework itself to
> support iommu pagesizes with a larger granule than the CPU pagesize if that is
> something you agree with.

BTW this isn't something we can fully support in general. IOMMU API 
users may expect this to work:

iommu_map(domain, iova, page_to_phys(p1), PAGE_SIZE, prot);
iommu_map(domain, iova + PAGE_SIZE, page_to_phys(p2), PAGE_SIZE, prot);

Although they do in principle have visibility of pgsize_bitmap, I still 
doubt anyone is really prepared for CPU-page-aligned mappings to fail.
Even at the DMA API level you could hide *some* of it (at the cost of 
effectively only having 1/4 of the usable address space), but there are 
still cases like where v4l2 has a hard requirement that a page-aligned 
scatterlist can be mapped into a contiguous region of DMA addresses.

> This would be important to later support the thunderbolt DARTs since I would be
> very uncomfortable to have these running in (software or hardware) bypass mode.

Funnily enough that's the one case that would be relatively workable, 
since untrusted devices are currently subject to bounce-buffering of the 
entire DMA request, so it doesn't matter so much how the bounce buffer 
itself is mapped. Even with the possible future optimisation of only 
bouncing the non-page-aligned start and end parts of a buffer I think it 
still works (the physical alignment just has to be considered in terms 
of the IOMMU granule).

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
