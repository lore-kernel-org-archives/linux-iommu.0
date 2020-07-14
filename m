Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB96DC433E4
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 11:01:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1C421D79
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 11:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1C421D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5AD9D8A5F6;
	Tue, 14 Jul 2020 11:01:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aYcSMLPekRvU; Tue, 14 Jul 2020 11:01:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B55048A303;
	Tue, 14 Jul 2020 11:01:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E5B0C0888;
	Tue, 14 Jul 2020 11:01:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 450C1C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 337038A5E7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FxprVWjHOUoU for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 11:01:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B81658A303
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:01:45 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id D05A568CFC; Tue, 14 Jul 2020 13:01:41 +0200 (CEST)
Date: Tue, 14 Jul 2020 13:01:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/4] dma-mapping: Add bounced DMA ops
Message-ID: <20200714110141.GD16178@lst.de>
References: <20200713091211.2183368-1-tientzu@chromium.org>
 <20200713091211.2183368-2-tientzu@chromium.org>
 <4a2451f9-57d8-2e83-e1d6-f144f37173c0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4a2451f9-57d8-2e83-e1d6-f144f37173c0@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: drinkcat@chromium.org, devicetree@vger.kernel.org,
 heikki.krogerus@linux.intel.com, saravanak@google.com, suzuki.poulose@arm.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, Claire Chang <tientzu@chromium.org>,
 dan.j.williams@intel.com, treding@nvidia.com, frowand.list@gmail.com,
 hch@lst.de
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

On Mon, Jul 13, 2020 at 12:55:43PM +0100, Robin Murphy wrote:
> On 2020-07-13 10:12, Claire Chang wrote:
>> The bounced DMA ops provide an implementation of DMA ops that bounce
>> streaming DMA in and out of a specially allocated region. Only the
>> operations relevant to streaming DMA are supported.
>
> I think there are too many implicit assumptions here - apparently that 
> coherent allocations will always be intercepted by 
> dma_*_from_dev_coherent(), and that calling into dma-direct won't actually 
> bounce things a second time beyond where you thought they were going, 
> manage coherency for a different address, and make it all go subtly wrong. 
> Consider "swiotlb=force", for instance...
>
> Again, plumbing this straight into dma-direct so that SWIOTLB can simply 
> target a different buffer and always bounce regardless of masks would seem 
> a far better option.

I haven't really had time to read through the details, but I agree that
any bouncing scheme should reuse the swiotlb code and not invent a
parallel infrastructure.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
