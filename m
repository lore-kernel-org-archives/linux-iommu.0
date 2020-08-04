Return-Path: <SRS0=Y3fO=BO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47514C433E0
	for <iommu@archiver.kernel.org>; Tue,  4 Aug 2020 06:06:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5D32076E
	for <iommu@archiver.kernel.org>; Tue,  4 Aug 2020 06:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5D32076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 03DC884763;
	Tue,  4 Aug 2020 06:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pV5MGpHZMm2F; Tue,  4 Aug 2020 06:06:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EBBDE84798;
	Tue,  4 Aug 2020 06:06:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4A99C0050;
	Tue,  4 Aug 2020 06:06:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A93FC004C
 for <iommu@lists.linux-foundation.org>; Tue,  4 Aug 2020 06:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2E42585E93
 for <iommu@lists.linux-foundation.org>; Tue,  4 Aug 2020 06:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jsAAGT29uFK2 for <iommu@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 06:06:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C246B85DB5
 for <iommu@lists.linux-foundation.org>; Tue,  4 Aug 2020 06:06:37 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 852C86736F; Tue,  4 Aug 2020 08:06:33 +0200 (CEST)
Date: Tue, 4 Aug 2020 08:06:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
Message-ID: <20200804060633.GA7368@lst.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de>
 <20200803160956.19235-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200803160956.19235-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: amit.pundir@linaro.org, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 rientjes@google.com, Robin Murphy <robin.murphy@arm.com>, hch@lst.de
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

On Mon, Aug 03, 2020 at 06:09:56PM +0200, Nicolas Saenz Julienne wrote:
> +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> +		return end <= DMA_BIT_MASK(zone_dma_bits);
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> +		return end <= DMA_BIT_MASK(32);
> +	if (gfp & GFP_KERNEL)
> +		return end > DMA_BIT_MASK(32);

So the GFP_KERNEL one here looks weird.  For one I don't think the if
line is needed at all, and it just confuses things.  Second I don't
see the need (and actually some harm) in preventing GFP_KERNEL
allocations from dipping into lower CMA areas - something that we did
support before 5.8 with the single pool.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
