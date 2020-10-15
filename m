Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9FDC433DF
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 05:42:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E5C22247
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 05:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E5C22247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 43DB52044A;
	Thu, 15 Oct 2020 05:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LtuJKHjmrlLT; Thu, 15 Oct 2020 05:42:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6D09320402;
	Thu, 15 Oct 2020 05:42:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D193C07FF;
	Thu, 15 Oct 2020 05:42:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A5BEC0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 05:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 468442044A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 05:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zV-O3WYWvo4X for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 05:42:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 79F1D20402
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 05:42:48 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id B4D9068BEB; Thu, 15 Oct 2020 07:42:44 +0200 (CEST)
Date: Thu, 15 Oct 2020 07:42:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v3 3/8] of/address: Introduce of_dma_get_max_cpu_address()
Message-ID: <20201015054244.GD12218@lst.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-4-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201014191211.27029-4-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, ardb@kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-rpi-kernel@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 hch@lst.de, linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com
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

> +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> +{
> +	phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
> +	struct of_range_parser parser;
> +	phys_addr_t subtree_max_addr;
> +	struct device_node *child;
> +	phys_addr_t cpu_end = 0;
> +	struct of_range range;
> +	const __be32 *ranges;
> +	int len;
> +
> +	if (!np)
> +		np = of_root;

Requiring of_root to be passed explicitly would seem more natural
to me than the magic NULL argument.  There doesn't seem to be any
precedent for that kind of calling convention either.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
