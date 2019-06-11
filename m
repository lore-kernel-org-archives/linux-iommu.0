Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF912C43218
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 05:27:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA4021721
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 05:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA4021721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8DBA5C64;
	Tue, 11 Jun 2019 05:27:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D6025BDC
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 05:27:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7C23863D
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 05:27:00 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 0B2F968B02; Tue, 11 Jun 2019 07:26:31 +0200 (CEST)
Date: Tue, 11 Jun 2019 07:26:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] dma-remap: Avoid de-referencing NULL atomic_pool
Message-ID: <20190611052630.GA19263@lst.de>
References: <20190607234333.9776-1-f.fainelli@gmail.com>
	<20190610225437.10912-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190610225437.10912-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alexey.skidanov@intel.com, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
	bcm-kernel-feedback-list@broadcom.com, akpm@linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, sjhuang@iluvatar.ai
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

Looks good to me.  When did this start to show up?  Do we need
to push it to Linus this cycle and cc stable?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
