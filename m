Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14369C74A4B
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 10:32:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9B420872
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 10:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zA91KDGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9B420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9AD584EA3;
	Thu, 11 Jul 2019 10:32:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 81F7D4E9B
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 10:23:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D1B24CF
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 10:23:07 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 89AD321537;
	Thu, 11 Jul 2019 10:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562840587;
	bh=Qax9TB9v/t+JwqwzSQrrFr6m3BcBICpw8ugber+pTq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zA91KDGOMxMlfYtukBX0p9X9CZ355qgtXSmRA8Cul/dms1QZxtS4Zo/SIqu8rLCUu
	97yildkCyBKTOn/ch5dbrLyVBMNLW25juxlCHHqyglcBuFKIL7/yl9WciNvLtMkwfT
	Cvw5Nr8/ZmQ5Oug2plUOsj1aTADDr1IQRQadiWZE=
Date: Thu, 11 Jul 2019 11:23:03 +0100
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH] iommu: io-pgtable: Drop WARN for empty PTEs on unmap
Message-ID: <20190711102303.pnvy4zlitusjjku7@willie-the-truck>
References: <20190710223119.8151-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190710223119.8151-1-robh@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
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

On Wed, Jul 10, 2019 at 04:31:19PM -0600, Rob Herring wrote:
> If a region has been mapped sparsely (such as on page faults), the user
> has to keep track of what was mapped or not in order to avoid warnings
> when unmapping the entire region. Remove the WARN on empty PTEs to allow
> unmapping sparsely mapped regions.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This is needed for large (up to 1GB AIUI) scratch buffers on panfrost 
> which are mapped on demand on GPU page faults and can be unmapped on 
> memory pressure. Alternatively, I'd need to have a bitmap of mapped 
> pages to track what is mapped or not. Dropping the WARN seems like a 
> much simpler solution.

I suppose an alternative would be to do an iova_to_phys() before you do the
unmap(). Would that be acceptable? The WARN_ON() indicates invalid usage by
the IOMMU API, so it would be a shame to lose it entirely and I'm hesitant
to continue adding quirks at the rate we're currently doing so!

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
