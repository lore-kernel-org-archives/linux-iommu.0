Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95E5C433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 12:26:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B641920720
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 12:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B641920720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8D2CE895AE;
	Wed,  8 Jul 2020 12:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Us905RjNiAUD; Wed,  8 Jul 2020 12:26:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CED94896A0;
	Wed,  8 Jul 2020 12:26:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0AD0C077B;
	Wed,  8 Jul 2020 12:26:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F046C016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 12:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2759687ED6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 12:26:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GpQQGD7RF1wj for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 12:26:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D601B88D39
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 12:26:05 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7232068AFE; Wed,  8 Jul 2020 14:26:01 +0200 (CEST)
Date: Wed, 8 Jul 2020 14:26:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] iommu/intel: Avoid SAC address trick for PCIe devices
Message-ID: <20200708122601.GB19619@lst.de>
References: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathan.lemon@gmail.com,
 dwmw2@infradead.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
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

Looks pretty sensible.

> -	if (!dmar_forcedac && dma_mask > DMA_BIT_MASK(32)) {
> +	if (!dmar_forcedac && dma_mask > DMA_BIT_MASK(32) &&
> +	    dev_is_pci(dev) && !pci_is_pcie(to_pci_dev(dev))) {

The only thing I wonder is if it is worth to add a little helper
for this check, but with everything moving to dma-iommu that might
not be needed.

Btw, does anyone know what the status of the intel-iommu conversion
to dma-iommu is?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
