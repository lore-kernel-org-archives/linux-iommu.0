Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C21C2BB85
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 06:30:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1166420678
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 06:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1166420678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D6C9487B2B;
	Tue, 14 Apr 2020 06:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D1iCcwSOsVkt; Tue, 14 Apr 2020 06:30:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 41C3687B07;
	Tue, 14 Apr 2020 06:30:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 251E4C1D7D;
	Tue, 14 Apr 2020 06:30:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8E11C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 06:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C0B672044B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 06:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4eSTF2U+hFQe for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 06:30:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 39B8320403
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 06:30:49 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E89D5227A81; Tue, 14 Apr 2020 08:30:43 +0200 (CEST)
Date: Tue, 14 Apr 2020 08:30:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200414063043.GF23154@lst.de>
References: <20200324075402.GJ23447@lst.de>
 <41975da3-3a4a-fc3c-2b90-8d607cf220e6@ozlabs.ru>
 <20200325083740.GC21605@lst.de>
 <a705afc5-779d-baf4-e5d2-e2da04c82743@ozlabs.ru>
 <213b0c7d-f908-b4f4-466d-6240c3622cd6@ozlabs.ru>
 <20200406115016.GA10941@lst.de>
 <348046e7-7a38-62d6-4df0-e4a537b98926@ozlabs.ru>
 <20200406171706.GA3231@lst.de>
 <95395244-bdec-84d2-b81b-3040c076fe4d@ozlabs.ru>
 <44ad32a4-7ce5-4f4d-8237-53356f76f53a@ozlabs.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44ad32a4-7ce5-4f4d-8237-53356f76f53a@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
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

On Tue, Apr 14, 2020 at 04:21:27PM +1000, Alexey Kardashevskiy wrote:
> > Good points, I'll post revised version when you post your v3 of this.
> 
> 
> 
> Any plans on posting v3 of this? Thanks,

Just back from a long weekend.  I'll take a stab at it soon.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
