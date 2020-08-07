Return-Path: <SRS0=0w8+=BR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B66C433DF
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 05:21:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E99A21744
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 05:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E99A21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 283D825281;
	Fri,  7 Aug 2020 05:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3xFtr09GNfyM; Fri,  7 Aug 2020 05:21:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 678232044B;
	Fri,  7 Aug 2020 05:21:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CB21C0050;
	Fri,  7 Aug 2020 05:21:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7400C004C
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 05:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C040F87079
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 05:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IxMDvKksci5b for <iommu@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 05:21:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 75DBD87034
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 05:21:21 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6374768D0E; Fri,  7 Aug 2020 07:21:16 +0200 (CEST)
Date: Fri, 7 Aug 2020 07:21:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v3 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
Message-ID: <20200807052116.GA584@lst.de>
References: <20200806184756.32075-1-nsaenzjulienne@suse.de>
 <20200806184756.32075-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806184756.32075-3-nsaenzjulienne@suse.de>
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

On Thu, Aug 06, 2020 at 08:47:55PM +0200, Nicolas Saenz Julienne wrote:
> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. To get around this double check CMA's placement before
> allocating from it.

As the builtbot pointed out, memblock_start_of_DRAM can't be used from
non-__init code.  But lookig at it I think throwing that in
is bogus anyway, as cma_get_base returns a proper physical address
already.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
