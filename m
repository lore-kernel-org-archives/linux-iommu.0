Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D5BC10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 17:29:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F33B2084D
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 17:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F33B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E7F972A93;
	Thu, 11 Apr 2019 17:29:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 16F0B239B
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 17:28:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B686487F
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 17:28:48 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id C3C0A68AFE; Thu, 11 Apr 2019 19:28:35 +0200 (CEST)
Date: Thu, 11 Apr 2019 19:28:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Scott Wood <swood@redhat.com>
Subject: Re: [PATCH] dma-debug: Only skip one stackframe entry
Message-ID: <20190411172835.GA30904@lst.de>
References: <20190410215925.8458-1-swood@redhat.com>
	<20190411172658.GA30605@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190411172658.GA30605@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411172835.o5Y8NPXhuSv1Yn-ZXFLlem7gwKh89RzqGiJTz4yQ5ik@z>

On Thu, Apr 11, 2019 at 07:26:58PM +0200, Christoph Hellwig wrote:
> Thomas just posted a major rework in this area.  I think you are
> best off rebasing it on top of that series and feeding it to him.

Actually..  Given that this series hasn't been merged yet and given
how trivial this change is I might just feed it to Linus with my
next merge request tomorrow.  That is probably easier for everyone.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
