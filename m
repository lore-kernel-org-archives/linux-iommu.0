Return-Path: <SRS0=j2S/=HZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD6C433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 07:25:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84FA64E20
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 07:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84FA64E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7CE7E85629;
	Tue, 23 Feb 2021 07:25:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hl9q01Aav8wP; Tue, 23 Feb 2021 07:25:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49EC184808;
	Tue, 23 Feb 2021 07:25:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 353D3C000A;
	Tue, 23 Feb 2021 07:25:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C9B9C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 07:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 357AB83131
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 07:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GzgyqCSLR6H6 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 07:25:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31EF282EA2
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 07:25:19 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8623A68D0D; Tue, 23 Feb 2021 08:25:14 +0100 (CET)
Date: Tue, 23 Feb 2021 08:25:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 6/9] swiotlb: refactor swiotlb_tbl_map_single
Message-ID: <20210223072514.GA18079@lst.de>
References: <20210207160327.2955490-1-hch@lst.de>
 <20210207160327.2955490-7-hch@lst.de>
 <70edceb03e4bf283072397f9563dfc4162aec92a.camel@suse.de>
 <YDQGIb4YqFpTKfyB@Konrads-MacBook-Pro.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YDQGIb4YqFpTKfyB@Konrads-MacBook-Pro.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: saravanak@google.com, marcorr@google.com, gregkh@linuxfoundation.org,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 kbusch@kernel.org, robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>,
 jxgao@google.com
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

On Mon, Feb 22, 2021 at 02:29:37PM -0500, Konrad Rzeszutek Wilk wrote:
> > 'max_slots' should be 'unsigned long' here. Breaks SWIOTLB on RPi4. Do you want
> > me to send a fix or you prefer editing the patch?
> 
> I can roll it in. Thx!

Thanks to both of you!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
